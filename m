Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED9A3B9534
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 19:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbhGARGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 13:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhGARGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 13:06:36 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40DCC061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 10:04:05 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id r4-20020a0568301204b029047d1030ef5cso291659otp.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 10:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KTfXNbsRGCZ2JJ0XX6b1VXX9NJfkKK4oNu1chBwcSns=;
        b=L3cyfSpvV5hqCG85J7o/Hg28ZuKcrfFAi5mgBxdFz9zgdZ44e/AM3Z/8/1zZ2Qn7oF
         +SRkh3fh1FM4QbDUAwA5PxTOhNTV9yHoCjNNVj9ADJAAnuFms2CGWxK/tSMD38rw1VDa
         oP1rJ9W64Vjr1F2+vxlRXIrq9epj+IdQsxGndRcsxLKiQpR0LddHhvZ237I91l4bv9PS
         wt8FEcCMiyvhEDs4Rw9oACqET0bOkvxoW+YiCiD1ZrdHxn9oe4mlLvvJv15e+aNfVBhI
         ausNnI0CIJ8WeiBr/GLan6cueOmIQ8IfmQHk6SHWgYwzIMNkSS9vrB0Y38Y7eoVYoC0G
         Hzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KTfXNbsRGCZ2JJ0XX6b1VXX9NJfkKK4oNu1chBwcSns=;
        b=Zk8BknBhS/KHZM3JDXW7/k8dbBriMW42vvmz8cZStWrdHt7W50mXZNDKbFHs33k4nx
         vBF8J4K3v1bUvApIlOfGu0N6NwDAfhJrEFNdzu4XW9Sc0bPCjzBs8evQVzsh9KbGAP+A
         LNPyGhreHdtn7p9P/lF6IjIWMaKMBSoc1d9b5Hao5Nj5zbqzfBz2Bn4b7GrthjmJTdww
         WtrpWiRwf1w2Q/JkukrgYGkiSMpx2G1/pEuWgLm41r3GJ3xuUF2ISlYPRgod26nDnMJS
         Cl9S9OFCegnvydmMC4KzQMCrDEap8qcDG1mfJairt6wyaK5pmzQVkM4VVHzPBM6DUJ54
         VXwQ==
X-Gm-Message-State: AOAM530aF078X4vkhI2x6rK4PiVU1SjhnrphR7FxMCvjbuma82gohOqV
        NOoU2XGIhnF82U9SzIet6IGD2A==
X-Google-Smtp-Source: ABdhPJyd3n4i6/Ath0pD2RILlnUYUtbGAXhiJk3HOXnvrGJGANQj8sVT7XtAcg+X/KP3/4rVSMuYlA==
X-Received: by 2002:a9d:2c44:: with SMTP id f62mr777752otb.147.1625159045120;
        Thu, 01 Jul 2021 10:04:05 -0700 (PDT)
Received: from smtpclient.apple ([2600:1700:42f0:6600:4d57:e39e:c32f:13d2])
        by smtp.gmail.com with ESMTPSA id l10sm57404oti.9.2021.07.01.10.04.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Jul 2021 10:04:04 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v2 3/3] hfs: add lock nesting notation to hfs_find_init
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <20210701030756.58760-4-desmondcheongzx@gmail.com>
Date:   Thu, 1 Jul 2021 10:04:02 -0700
Cc:     gustavoars@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, skhan@linuxfoundation.org,
        gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+b718ec84a87b7e73ade4@syzkaller.appspotmail.com,
        Andrew Morton <akpm@linux-foundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7E90922F-6F1F-4D05-AB2A-E4D3CDC513E0@dubeyko.com>
References: <20210701030756.58760-1-desmondcheongzx@gmail.com>
 <20210701030756.58760-4-desmondcheongzx@gmail.com>
To:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 30, 2021, at 8:07 PM, Desmond Cheong Zhi Xi =
<desmondcheongzx@gmail.com> wrote:
>=20
> Syzbot reports a possible recursive lock:
> =
https://syzkaller.appspot.com/bug?id=3Df007ef1d7a31a469e3be7aeb0fde0769b18=
585db
>=20
> This happens due to missing lock nesting information. =46rom the logs,
> we see that a call to hfs_fill_super is made to mount the hfs
> filesystem. While searching for the root inode, the lock on the
> catalog btree is grabbed. Then, when the parent of the root isn't
> found, a call to __hfs_bnode_create is made to create the parent of
> the root. This eventually leads to a call to hfs_ext_read_extent which
> grabs a lock on the extents btree.
>=20
> Since the order of locking is catalog btree -> extents btree, this
> lock hierarchy does not lead to a deadlock.
>=20
> To tell lockdep that this locking is safe, we add nesting notation to
> distinguish between catalog btrees, extents btrees, and attributes
> btrees (for HFS+). This has already been done in hfsplus.
>=20
> Reported-and-tested-by: =
syzbot+b718ec84a87b7e73ade4@syzkaller.appspotmail.com
> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
> Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
> ---
> fs/hfs/bfind.c | 14 +++++++++++++-
> fs/hfs/btree.h |  7 +++++++
> 2 files changed, 20 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
> index 4af318fbda77..ef9498a6e88a 100644
> --- a/fs/hfs/bfind.c
> +++ b/fs/hfs/bfind.c
> @@ -25,7 +25,19 @@ int hfs_find_init(struct hfs_btree *tree, struct =
hfs_find_data *fd)
> 	fd->key =3D ptr + tree->max_key_len + 2;
> 	hfs_dbg(BNODE_REFS, "find_init: %d (%p)\n",
> 		tree->cnid, __builtin_return_address(0));
> -	mutex_lock(&tree->tree_lock);
> +	switch (tree->cnid) {
> +	case HFS_CAT_CNID:
> +		mutex_lock_nested(&tree->tree_lock, =
CATALOG_BTREE_MUTEX);
> +		break;
> +	case HFS_EXT_CNID:
> +		mutex_lock_nested(&tree->tree_lock, =
EXTENTS_BTREE_MUTEX);
> +		break;
> +	case HFS_ATTR_CNID:
> +		mutex_lock_nested(&tree->tree_lock, ATTR_BTREE_MUTEX);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> 	return 0;
> }
>=20
> diff --git a/fs/hfs/btree.h b/fs/hfs/btree.h
> index 4ba45caf5939..0e6baee93245 100644
> --- a/fs/hfs/btree.h
> +++ b/fs/hfs/btree.h
> @@ -13,6 +13,13 @@ typedef int (*btree_keycmp)(const btree_key *, =
const btree_key *);
>=20
> #define NODE_HASH_SIZE  256
>=20
> +/* B-tree mutex nested subclasses */
> +enum hfs_btree_mutex_classes {
> +	CATALOG_BTREE_MUTEX,
> +	EXTENTS_BTREE_MUTEX,
> +	ATTR_BTREE_MUTEX,
> +};
> +
> /* A HFS BTree held in memory */
> struct hfs_btree {
> 	struct super_block *sb;
> --=20
> 2.25.1
>=20

Looks good.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.


