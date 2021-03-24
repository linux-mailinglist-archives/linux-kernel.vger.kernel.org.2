Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3DEA3470A7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 06:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235232AbhCXFKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 01:10:14 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:40702 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbhCXFKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 01:10:00 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOvmJ-008kjG-MF; Wed, 24 Mar 2021 05:09:59 +0000
Date:   Wed, 24 Mar 2021 05:09:59 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 03/18] ovl: stack miscattr ops
Message-ID: <YFrJp5I3nL1RriTL@zeniv-ca.linux.org.uk>
References: <20210322144916.137245-1-mszeredi@redhat.com>
 <20210322144916.137245-4-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322144916.137245-4-mszeredi@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 03:49:01PM +0100, Miklos Szeredi wrote:

> +int ovl_miscattr_set(struct user_namespace *mnt_userns,
> +		     struct dentry *dentry, struct miscattr *ma)
> +{
> +	struct inode *inode = d_inode(dentry);
> +	struct dentry *upperdentry;
> +	const struct cred *old_cred;
> +	int err;
> +
> +	err = ovl_want_write(dentry);
> +	if (err)
> +		goto out;
> +
> +	err = ovl_copy_up(dentry);
> +	if (!err) {
> +		upperdentry = ovl_dentry_upper(dentry);
> +
> +		old_cred = ovl_override_creds(inode->i_sb);
> +		err = ovl_security_miscattr(dentry, ma, true);
> +		if (!err)
> +			err = vfs_miscattr_set(&init_user_ns, upperdentry, ma);
> +		revert_creds(old_cred);
> +		ovl_copyflags(ovl_inode_real(inode), inode);
> +	}
> +	ovl_drop_write(dentry);
> +out:
> +	return err;
> +}

Umm...  No equivalents of
        /*  
         * Prevent copy up if immutable and has no CAP_LINUX_IMMUTABLE
         * capability.
         */ 
        ret = -EPERM;
        if (!ovl_has_upperdata(inode) && IS_IMMUTABLE(inode) &&
            !capable(CAP_LINUX_IMMUTABLE))
                goto unlock;

        ret = ovl_maybe_copy_up(file_dentry(file), O_WRONLY);
        if (ret)
                goto unlock;
in the current tree?
