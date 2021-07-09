Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33413C2113
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 10:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhGII6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 04:58:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:52244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231494AbhGII6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 04:58:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6DE9161375;
        Fri,  9 Jul 2021 08:56:00 +0000 (UTC)
Date:   Fri, 9 Jul 2021 10:55:57 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Moreland <smoreland@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ANDROID: binderfs: add capabilities support
Message-ID: <20210709085557.2bx2vojtyw23jzch@wittgenstein>
References: <20210707162419.15510-1-cmllamas@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210707162419.15510-1-cmllamas@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2021 at 04:24:19PM +0000, Carlos Llamas wrote:
> Provide userspace with a mechanism to discover binder driver
> capabilities to refrain from using these unsupported features

Hey Carlos,

The model will be one file per feature?

Instead of calling the directory "caps" should this maybe be called
"features"? I'm not fuzzed about it and if you want to keep "caps"
that's fine. The term is just a bit overused and makes me think of other
things than this.

> in the first place. Note that older capabilities are assumed
> to be supported and only new ones will be added.

What if you ever want to deprecate one? :)

> 
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>  drivers/android/binderfs.c | 45 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> index e80ba93c62a9..f793887f6dc8 100644
> --- a/drivers/android/binderfs.c
> +++ b/drivers/android/binderfs.c
> @@ -58,6 +58,10 @@ enum binderfs_stats_mode {
>  	binderfs_stats_mode_global,
>  };
>  
> +struct binder_capabilities {
> +	bool oneway_spam;
> +};
> +
>  static const struct constant_table binderfs_param_stats[] = {
>  	{ "global", binderfs_stats_mode_global },
>  	{}
> @@ -69,6 +73,10 @@ static const struct fs_parameter_spec binderfs_fs_parameters[] = {
>  	{}
>  };
>  
> +static struct binder_capabilities binder_caps = {
> +	.oneway_spam = true,

I know this is the oneway spam _detection_ feature but this file makes
it sound like the binder driver has the capability to generate one-way
spam. :) Maybe name at least name the file "oneway_spam_detection".

> +};
> +
>  static inline struct binderfs_info *BINDERFS_SB(const struct super_block *sb)
>  {
>  	return sb->s_fs_info;
> @@ -583,6 +591,39 @@ static struct dentry *binderfs_create_dir(struct dentry *parent,
>  	return dentry;
>  }
>  
> +static int binder_caps_show(struct seq_file *m, void *unused)
> +{
> +	bool *cap = m->private;
> +
> +	seq_printf(m, "%d\n", *cap);
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(binder_caps);
> +
> +static int init_binder_caps(struct super_block *sb)

You can drop the goto here and just always return directly.

> +{
> +	struct dentry *dentry, *root;

Please name this "dir" instead of "root". "root" is conventionally used
for sb->s_root and especially here in this file I only ever used it to
indicate s_root.

> +	int ret = 0;
> +
> +	root = binderfs_create_dir(sb->s_root, "caps");
> +	if (IS_ERR(root)) {
> +		ret = PTR_ERR(root);

	return PTR_ERR(root);

> +		goto out;
> +	}
> +
> +	dentry = binderfs_create_file(root, "oneway_spam",
> +				      &binder_caps_fops,
> +				      &binder_caps.oneway_spam);
> +	if (IS_ERR(dentry)) {
> +		ret = PTR_ERR(dentry);

	return PTR_ERR(root);

> +		goto out;
> +	}
> +
> +out:
> +	return ret;
> +}
> +
>  static int init_binder_logs(struct super_block *sb)
>  {
>  	struct dentry *binder_logs_root_dir, *dentry, *proc_log_dir;
> @@ -723,6 +764,10 @@ static int binderfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  			name++;
>  	}
>  
> +	ret = init_binder_caps(sb);
> +	if (ret)
> +		return ret;
> +
>  	if (info->mount_opts.stats_mode == binderfs_stats_mode_global)
>  		return init_binder_logs(sb);
>  
> -- 
> 2.32.0.93.g670b81a890-goog
> 
