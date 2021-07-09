Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C84AF3C20EB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 10:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbhGIImW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 04:42:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:49986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231361AbhGIImW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 04:42:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6F9B6127C;
        Fri,  9 Jul 2021 08:39:36 +0000 (UTC)
Date:   Fri, 9 Jul 2021 10:39:34 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Carlos Llamas <cmllamas@google.com>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Moreland <smoreland@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ANDROID: binderfs: add capabilities support
Message-ID: <20210709083934.ghkohnqq4x23rs7d@wittgenstein>
References: <20210707162419.15510-1-cmllamas@google.com>
 <YOXdgrmXAMV1ys/A@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YOXdgrmXAMV1ys/A@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2021 at 06:59:46PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jul 07, 2021 at 04:24:19PM +0000, Carlos Llamas wrote:
> > Provide userspace with a mechanism to discover binder driver
> > capabilities to refrain from using these unsupported features
> > in the first place. Note that older capabilities are assumed
> > to be supported and only new ones will be added.
> 
> What defines "new" vs. "old"?  Where was the line drawn?
> 
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > ---
> >  drivers/android/binderfs.c | 45 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> > 
> > diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> > index e80ba93c62a9..f793887f6dc8 100644
> > --- a/drivers/android/binderfs.c
> > +++ b/drivers/android/binderfs.c
> > @@ -58,6 +58,10 @@ enum binderfs_stats_mode {
> >  	binderfs_stats_mode_global,
> >  };
> >  
> > +struct binder_capabilities {
> > +	bool oneway_spam;
> > +};
> > +
> >  static const struct constant_table binderfs_param_stats[] = {
> >  	{ "global", binderfs_stats_mode_global },
> >  	{}
> > @@ -69,6 +73,10 @@ static const struct fs_parameter_spec binderfs_fs_parameters[] = {
> >  	{}
> >  };
> >  
> > +static struct binder_capabilities binder_caps = {
> > +	.oneway_spam = true,
> > +};
> > +
> >  static inline struct binderfs_info *BINDERFS_SB(const struct super_block *sb)
> >  {
> >  	return sb->s_fs_info;
> > @@ -583,6 +591,39 @@ static struct dentry *binderfs_create_dir(struct dentry *parent,
> >  	return dentry;
> >  }
> >  
> > +static int binder_caps_show(struct seq_file *m, void *unused)
> > +{
> > +	bool *cap = m->private;
> > +
> > +	seq_printf(m, "%d\n", *cap);
> > +
> > +	return 0;
> > +}
> > +DEFINE_SHOW_ATTRIBUTE(binder_caps);
> > +
> > +static int init_binder_caps(struct super_block *sb)
> > +{
> > +	struct dentry *dentry, *root;
> > +	int ret = 0;
> > +
> > +	root = binderfs_create_dir(sb->s_root, "caps");
> > +	if (IS_ERR(root)) {
> > +		ret = PTR_ERR(root);
> > +		goto out;
> > +	}
> > +
> > +	dentry = binderfs_create_file(root, "oneway_spam",
> > +				      &binder_caps_fops,
> > +				      &binder_caps.oneway_spam);
> > +	if (IS_ERR(dentry)) {
> > +		ret = PTR_ERR(dentry);
> > +		goto out;
> 
> If this fails, you still report that an error happened, yet you do not
> remove the directory?  Is that intended?
> 
> And where is this new file documented?  Where are the existing binderfs
> files documented?

When I wrote it I added documentation to:

Documentation/admin-guide/binderfs.rst

So the new caps directory and file should be documented there.

I would also suggest to add a simple test reading this new caps
directory and the new file in there to:

tools/testing/selftests/filesystems/binderfs_test.c

Christian
