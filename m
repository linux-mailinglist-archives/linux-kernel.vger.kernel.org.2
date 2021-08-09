Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2ECE3E483F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbhHIPAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:00:23 -0400
Received: from verein.lst.de ([213.95.11.211]:60892 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234133AbhHIPAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:00:17 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2A33567357; Mon,  9 Aug 2021 16:59:54 +0200 (CEST)
Date:   Mon, 9 Aug 2021 16:59:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Joel Becker <jlbec@evilplan.org>,
        linux-kernel@vger.kernel.org,
        Bodo Stroesser <bostroesser@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Yanko Kaneti <yaneti@declera.com>
Subject: Re: [PATCH v4 3/3] configfs: Add unit tests
Message-ID: <20210809145953.GB21234@lst.de>
References: <20210805043503.20252-1-bvanassche@acm.org> <20210805043503.20252-4-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805043503.20252-4-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> text and binary attribute support. This is how I run these tests:
> 
> set -e
> if [ -e .config ]; then
>     make ARCH=um mrproper
> fi
> if [ ! -e .kunit/.kunitconfig ]; then
>     cat <<EOF >.kunit/.kunitconfig
> CONFIG_CONFIGFS_FS=y
> CONFIG_CONFIGFS_KUNIT_TEST=y
> CONFIG_KUNIT=y
> CONFIG_PROVE_LOCKING=y
> CONFIG_SYSFS=y
> CONFIG_UBSAN=y
> EOF
>     cp .kunit/.kunitconfig .kunit/.config
> fi
> ./tools/testing/kunit/kunit.py run

This is very useful documentation, but shouldn't it go into a README.kunit
or similar instead of a commit message?

> +config CONFIGFS_KUNIT_TEST
> +	bool "Configfs Kunit test" if !KUNIT_ALL_TESTS
> +	depends on CONFIGFS_FS && KUNIT=y
> +	default KUNIT_ALL_TESTS

Why does it depend on KUNIT=y?  What is the issue with a modular KUNIT
build?


> +static int mkdir(const char *name, umode_t mode)
> +{
> +	struct dentry *dentry;
> +	struct path path;
> +	int err;
> +
> +	err = get_file_mode(name);
> +	if (err >= 0 && S_ISDIR(err))
> +		return 0;
> +
> +	dentry = kern_path_create(AT_FDCWD, name, &path, LOOKUP_DIRECTORY);
> +	if (IS_ERR(dentry))
> +		return PTR_ERR(dentry);
> +
> +	err = vfs_mkdir(&init_user_ns, d_inode(path.dentry), dentry, mode);
> +	done_path_create(&path, dentry);

To me this sounds like userspace would be a better place for these
kinds of tests.
