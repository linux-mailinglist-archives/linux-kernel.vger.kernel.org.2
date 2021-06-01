Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42E7397CFF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 01:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbhFAXZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 19:25:45 -0400
Received: from p3plsmtp03-03-2.prod.phx3.secureserver.net ([72.167.218.215]:47908
        "EHLO p3plwbeout03-03.prod.phx3.secureserver.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234766AbhFAXZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 19:25:43 -0400
X-Greylist: delayed 467 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Jun 2021 19:25:43 EDT
Received: from outbound-gw.openxchange.ahost.me ([94.136.40.163])
        by :WBEOUT: with ESMTP
        id oDcGlhBu9BHyNoDcHlz48j; Tue, 01 Jun 2021 16:16:09 -0700
X-CMAE-Analysis: v=2.4 cv=Ds2TREz+ c=1 sm=1 tr=0 ts=60b6bfbd
 a=ExpeE9u7wY9QIRtJzA+xFA==:117 a=ExpeE9u7wY9QIRtJzA+xFA==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=r6YtysWOX24A:10 a=S_-2Y0Uh84wA:10
 a=3-RhneuVAAAA:8 a=FXvPX3liAAAA:8 a=nr84E1qWduPX7mtxeRMA:9 a=QEXdDO2ut3YA:10
 a=VLVLkjT_5ZicWzSuYqSo:22 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
X-SID:  oDcGlhBu9BHyN
Received: from localhost ([127.0.0.1] helo=outbound-gw.openxchange.ahost.me)
        by outbound-gw.openxchange.ahost.me with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
        (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1loDcG-0003zo-G5; Wed, 02 Jun 2021 00:16:08 +0100
Date:   Wed, 2 Jun 2021 00:16:08 +0100 (BST)
From:   Phillip Lougher <phillip@squashfs.org.uk>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        akpm@linux-foundation.org
Cc:     kernel@axis.com, linux-kernel@vger.kernel.org
Message-ID: <2128779324.7581027.1622589368437@webmail.123-reg.co.uk>
In-Reply-To: <20210527125019.14511-1-vincent.whitchurch@axis.com>
References: <20210527125019.14511-1-vincent.whitchurch@axis.com>
Subject: Re: [PATCH] squashfs: add option to panic on errors
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.3-Rev22
X-Originating-IP: 82.69.79.175
X-Originating-Client: com.openexchange.ox.gui.dhtml
X-Authenticated-As: phillip@squashfs.org.uk
X-122-reg-Authenticated: phillip@squashfs.org.uk
X-CMAE-Envelope: MS4xfEgvVgfo1qQwMeljwvOMHcLNz7tAZzijmWolXNN2e4Un6vsXle2x0iulP2C6LT1M1oLCsnEO8iVlYbOIngQLfFnhb4jZwTvIX6m2Emkr/qXOZXXzv40P
 NLGZmShxYNyC7rAznLD3+rv232JjtwD2XFHRyNp3hBoSMn5je1om7qoTb8K2oZI0LW2A1K8UrLC+UlTGwNgEpo+txybipdKw1LnRnaCFxa0VZRPUI436zM2N
 DJGOOkWC8Ne6kDytEK3FdM4yPRI4qERzbMKjd6RqmL56QU+tjedThA18SC18tFaSWJTKvU3B/eaWrig6PAC2FVUX8+xJjv12tOu981d2H1I=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 27/05/2021 13:50 Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:
> 
>  
> Add an errors=panic mount option to make squashfs trigger a panic when
> errors are encountered, similar to several other filesystems.  This
> allows a kernel dump to be saved using which the corruption can be
> analysed and debugged.
> 
> Inspired by a pre-fs_context patch by Anton Eliasson.

This looks like a worthwhile improvement.

Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>

Thanks

Phillip
--
Squashfs maintainer.

> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  fs/squashfs/block.c          |  5 ++-
>  fs/squashfs/squashfs_fs_sb.h |  1 +
>  fs/squashfs/super.c          | 86 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 91 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
> index b9e87ebb1060..855f0e87066d 100644
> --- a/fs/squashfs/block.c
> +++ b/fs/squashfs/block.c
> @@ -226,8 +226,11 @@ int squashfs_read_data(struct super_block *sb, u64 index, int length,
>  	bio_free_pages(bio);
>  	bio_put(bio);
>  out:
> -	if (res < 0)
> +	if (res < 0) {
>  		ERROR("Failed to read block 0x%llx: %d\n", index, res);
> +		if (msblk->panic_on_errors)
> +			panic("squashfs read failed");
> +	}
>  
>  	return res;
>  }
> diff --git a/fs/squashfs/squashfs_fs_sb.h b/fs/squashfs/squashfs_fs_sb.h
> index 166e98806265..1e90c2575f9b 100644
> --- a/fs/squashfs/squashfs_fs_sb.h
> +++ b/fs/squashfs/squashfs_fs_sb.h
> @@ -65,5 +65,6 @@ struct squashfs_sb_info {
>  	unsigned int				fragments;
>  	int					xattr_ids;
>  	unsigned int				ids;
> +	bool					panic_on_errors;
>  };
>  #endif
> diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
> index 88cc94be1076..60d6951915f4 100644
> --- a/fs/squashfs/super.c
> +++ b/fs/squashfs/super.c
> @@ -18,9 +18,11 @@
>  
>  #include <linux/fs.h>
>  #include <linux/fs_context.h>
> +#include <linux/fs_parser.h>
>  #include <linux/vfs.h>
>  #include <linux/slab.h>
>  #include <linux/mutex.h>
> +#include <linux/seq_file.h>
>  #include <linux/pagemap.h>
>  #include <linux/init.h>
>  #include <linux/module.h>
> @@ -37,6 +39,51 @@
>  static struct file_system_type squashfs_fs_type;
>  static const struct super_operations squashfs_super_ops;
>  
> +enum Opt_errors {
> +	Opt_errors_continue,
> +	Opt_errors_panic,
> +};
> +
> +enum squashfs_param {
> +	Opt_errors,
> +};
> +
> +struct squashfs_mount_opts {
> +	enum Opt_errors errors;
> +};
> +
> +static const struct constant_table squashfs_param_errors[] = {
> +	{"continue",   Opt_errors_continue },
> +	{"panic",      Opt_errors_panic },
> +	{}
> +};
> +
> +static const struct fs_parameter_spec squashfs_fs_parameters[] = {
> +	fsparam_enum("errors", Opt_errors, squashfs_param_errors),
> +	{}
> +};
> +
> +static int squashfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
> +{
> +	struct squashfs_mount_opts *opts = fc->fs_private;
> +	struct fs_parse_result result;
> +	int opt;
> +
> +	opt = fs_parse(fc, squashfs_fs_parameters, param, &result);
> +	if (opt < 0)
> +		return opt;
> +
> +	switch (opt) {
> +	case Opt_errors:
> +		opts->errors = result.uint_32;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct squashfs_decompressor *supported_squashfs_filesystem(
>  	struct fs_context *fc,
>  	short major, short minor, short id)
> @@ -67,6 +114,7 @@ static const struct squashfs_decompressor *supported_squashfs_filesystem(
>  
>  static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  {
> +	struct squashfs_mount_opts *opts = fc->fs_private;
>  	struct squashfs_sb_info *msblk;
>  	struct squashfs_super_block *sblk = NULL;
>  	struct inode *root;
> @@ -85,6 +133,8 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	}
>  	msblk = sb->s_fs_info;
>  
> +	msblk->panic_on_errors = (opts->errors == Opt_errors_panic);
> +
>  	msblk->devblksize = sb_min_blocksize(sb, SQUASHFS_DEVBLK_SIZE);
>  	msblk->devblksize_log2 = ffz(~msblk->devblksize);
>  
> @@ -350,18 +400,52 @@ static int squashfs_get_tree(struct fs_context *fc)
>  
>  static int squashfs_reconfigure(struct fs_context *fc)
>  {
> +	struct super_block *sb = fc->root->d_sb;
> +	struct squashfs_sb_info *msblk = sb->s_fs_info;
> +	struct squashfs_mount_opts *opts = fc->fs_private;
> +
>  	sync_filesystem(fc->root->d_sb);
>  	fc->sb_flags |= SB_RDONLY;
> +
> +	msblk->panic_on_errors = (opts->errors == Opt_errors_panic);
> +
>  	return 0;
>  }
>  
> +static void squashfs_free_fs_context(struct fs_context *fc)
> +{
> +	kfree(fc->fs_private);
> +}
> +
>  static const struct fs_context_operations squashfs_context_ops = {
>  	.get_tree	= squashfs_get_tree,
> +	.free		= squashfs_free_fs_context,
> +	.parse_param	= squashfs_parse_param,
>  	.reconfigure	= squashfs_reconfigure,
>  };
>  
> +static int squashfs_show_options(struct seq_file *s, struct dentry *root)
> +{
> +	struct super_block *sb = root->d_sb;
> +	struct squashfs_sb_info *msblk = sb->s_fs_info;
> +
> +	if (msblk->panic_on_errors)
> +		seq_puts(s, ",errors=panic");
> +	else
> +		seq_puts(s, ",errors=continue");
> +
> +	return 0;
> +}
> +
>  static int squashfs_init_fs_context(struct fs_context *fc)
>  {
> +	struct squashfs_mount_opts *opts;
> +
> +	opts = kzalloc(sizeof(*opts), GFP_KERNEL);
> +	if (!opts)
> +		return -ENOMEM;
> +
> +	fc->fs_private = opts;
>  	fc->ops = &squashfs_context_ops;
>  	return 0;
>  }
> @@ -481,6 +565,7 @@ static struct file_system_type squashfs_fs_type = {
>  	.owner = THIS_MODULE,
>  	.name = "squashfs",
>  	.init_fs_context = squashfs_init_fs_context,
> +	.parameters = squashfs_fs_parameters,
>  	.kill_sb = kill_block_super,
>  	.fs_flags = FS_REQUIRES_DEV
>  };
> @@ -491,6 +576,7 @@ static const struct super_operations squashfs_super_ops = {
>  	.free_inode = squashfs_free_inode,
>  	.statfs = squashfs_statfs,
>  	.put_super = squashfs_put_super,
> +	.show_options = squashfs_show_options,
>  };
>  
>  module_init(init_squashfs_fs);
> -- 
> 2.28.0
