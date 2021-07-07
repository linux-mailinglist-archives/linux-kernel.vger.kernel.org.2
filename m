Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCE83BECB4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 18:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhGGRCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 13:02:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230109AbhGGRCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 13:02:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B675061C60;
        Wed,  7 Jul 2021 16:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625677189;
        bh=qn7Eyj9XNAOP0U0oSFE2xt0Kb26qGji0dRrK9Ip4e5I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d3gXr1iDVZxDA44YdE9RPogIGqKBOIX8xYywK93divX8W3Xo0t1NuPIEwQ8Zv+R7M
         uPyt9h2oIDHVgArGI7BzWaQbVank9hA+OWTz8Tq6u1jW3u3E0d3Y4fxeiw4d8GI42+
         YQnrh15EsjFf9cpZSFhefk/mB1EVcA4sDJ+cEh0s=
Date:   Wed, 7 Jul 2021 18:59:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Moreland <smoreland@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ANDROID: binderfs: add capabilities support
Message-ID: <YOXdgrmXAMV1ys/A@kroah.com>
References: <20210707162419.15510-1-cmllamas@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707162419.15510-1-cmllamas@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2021 at 04:24:19PM +0000, Carlos Llamas wrote:
> Provide userspace with a mechanism to discover binder driver
> capabilities to refrain from using these unsupported features
> in the first place. Note that older capabilities are assumed
> to be supported and only new ones will be added.

What defines "new" vs. "old"?  Where was the line drawn?

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
> +{
> +	struct dentry *dentry, *root;
> +	int ret = 0;
> +
> +	root = binderfs_create_dir(sb->s_root, "caps");
> +	if (IS_ERR(root)) {
> +		ret = PTR_ERR(root);
> +		goto out;
> +	}
> +
> +	dentry = binderfs_create_file(root, "oneway_spam",
> +				      &binder_caps_fops,
> +				      &binder_caps.oneway_spam);
> +	if (IS_ERR(dentry)) {
> +		ret = PTR_ERR(dentry);
> +		goto out;

If this fails, you still report that an error happened, yet you do not
remove the directory?  Is that intended?

And where is this new file documented?  Where are the existing binderfs
files documented?

thanks,

greg k-h
