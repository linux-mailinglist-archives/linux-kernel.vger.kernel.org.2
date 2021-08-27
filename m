Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43203F9D54
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 19:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbhH0RNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 13:13:22 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:37540 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230021AbhH0RNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 13:13:20 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 711D642C;
        Fri, 27 Aug 2021 20:12:29 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1630084349;
        bh=k5CkhsWtPfiYob9Y++gS1X8TgF++lJOzIgl5gQZ+Ozc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=VrqxzgSpIl30A1GybMbPKXlhEprRJNwFGYOhrd6poyuqXfma2TWKixjCVN0HXjoiF
         nOBlT3pJEPPu5VmPrgfIgGhvMCNdJEfXYbzYmJPPxR8KSQuLUFz9P/CX2W/V4xP0ky
         w83dYXhmMuuxuLAUywEo/DGOWn8MjKG3zggFpbxY=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 27 Aug 2021 20:12:29 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%12]) with
 mapi id 15.01.2176.009; Fri, 27 Aug 2021 20:12:29 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     Kari Argillander <kari.argillander@gmail.com>,
        "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
        Christoph Hellwig <hch@lst.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
Subject: RE: [PATCH v4 0/3] fs/ntfs3: Use kernel alloc wrappers and fix
 warnings
Thread-Topic: [PATCH v4 0/3] fs/ntfs3: Use kernel alloc wrappers and fix
 warnings
Thread-Index: AQHXmRcWmaTmTKjT70K3YgZRTKjTH6uHms+A
Date:   Fri, 27 Aug 2021 17:12:28 +0000
Message-ID: <373c644eff6d4e2b8137acc0ca6faf7f@paragon-software.com>
References: <20210824183708.1008538-1-kari.argillander@gmail.com>
In-Reply-To: <20210824183708.1008538-1-kari.argillander@gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.0.26]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Kari Argillander <kari.argillander@gmail.com>
> Sent: Tuesday, August 24, 2021 9:37 PM
> To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>; ntfs3@=
lists.linux.dev; Christoph Hellwig <hch@lst.de>
> Cc: Kari Argillander <kari.argillander@gmail.com>; linux-kernel@vger.kern=
el.org; Joe Perches <joe@perches.com>
> Subject: [PATCH v4 0/3] fs/ntfs3: Use kernel alloc wrappers and fix warni=
ngs
>=20
> In ntfs3 driver there is allocation made like this ntfs_malloc().
> Patch 2/3 will converter these to kernel ones like kmalloc(). After I
> did this then checkpatch raise warnings about array allocations so I
> fix these in patch 3/3.
>=20
> I also notice when I made patch that there is broken utf8 char so I
> wanted first fix that because it raised some warning in my editor and
> did not want to "break" patch 2/3. And because we are editing comment
> then make whole comment block clean. So patch 1/3 address that. I did
> try to apply this and it seem to work without issues.
>=20
> v2:
>  - Add patch 1/3 because I found broken utf8 char in source file
>  - Add another patch 3/3 which will fix allocation warnings
>  - Rewrite some of commit message from first patch
> v3:
>  - Patch series didn't have X/X numbers
>  - Cover letter didn't have fs/ntfs3 in it
>  - One kmalloc was converted to kcalloc insted of kmalloc_array
>  	Thanks Joe Perches
> v4:
>  - Wrap whole comment block in patch 1/1 max 80 char. And restyle.
>  	Thanks Christoph Hellwig for noting this
>  - Add Reviewed-by: from Christoph Hellwig to patch 2 and 3
>=20
> Kari Argillander (3):
>   fs/ntfs3: Restyle comment block in ni_parse_reparse()
>   fs/ntfs3: Do not use driver own alloc wrappers
>   fs/ntfs3: Use kcalloc/kmalloc_array over kzalloc/kmalloc
>=20
>  fs/ntfs3/attrib.c   |   6 +-
>  fs/ntfs3/attrlist.c |  10 +--
>  fs/ntfs3/bitmap.c   |   8 +--
>  fs/ntfs3/debug.h    |   7 --
>  fs/ntfs3/file.c     |   4 +-
>  fs/ntfs3/frecord.c  |  42 ++++++-----
>  fs/ntfs3/fslog.c    | 172 ++++++++++++++++++++++----------------------
>  fs/ntfs3/fsntfs.c   |   8 +--
>  fs/ntfs3/index.c    |  54 +++++++-------
>  fs/ntfs3/inode.c    |  10 +--
>  fs/ntfs3/lznt.c     |   4 +-
>  fs/ntfs3/ntfs_fs.h  |  18 ++---
>  fs/ntfs3/record.c   |   8 +--
>  fs/ntfs3/run.c      |   8 +--
>  fs/ntfs3/super.c    |  20 +++---
>  fs/ntfs3/xattr.c    |  18 ++---
>  16 files changed, 197 insertions(+), 200 deletions(-)
>=20
> --
> 2.25.1

Hi Kari, Christoph and Joe! Thanks for your contribution, applied these pat=
ch series to our tree.

Best regards,
Konstantin
