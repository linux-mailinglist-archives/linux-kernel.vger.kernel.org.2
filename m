Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6293F9C8B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 18:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236077AbhH0Qb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 12:31:58 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:48977 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233745AbhH0Qb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 12:31:57 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 91A0E821CB;
        Fri, 27 Aug 2021 19:31:07 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1630081867;
        bh=mTPrU7Xby7bdyA5QoWyXxTNUqhVFSY/ggcdmXWm3lTw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=ch6SmnIk2fS3FTquU3QgRc/OP3pBtHdJVdoFFbGWiPs0eYY++ropdyQyjFbNd+u76
         K8Be20RFRsAjMvBcgr5tT4cSyEQtBj7IuxwRAUX91gcRjaNCn3jLtj0dBsUF81nRoV
         KJ/XHRnjFPsOLK5mRCjMjypPUcxMOeb13aQABmIc=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 27 Aug 2021 19:31:07 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%12]) with
 mapi id 15.01.2176.009; Fri, 27 Aug 2021 19:31:07 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
CC:     "nathan@kernel.org" <nathan@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Subject: RE: [PATCH] fs/ntfs3: Remove unused including <linux/version.h>
Thread-Topic: [PATCH] fs/ntfs3: Remove unused including <linux/version.h>
Thread-Index: AQHXlNOYiBEK8ENRz0Won74AeeEXEauHl8Bg
Date:   Fri, 27 Aug 2021 16:31:07 +0000
Message-ID: <3f2f11cc4e414f088ed60919e7d9cd56@paragon-software.com>
References: <1629361417-94657-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1629361417-94657-1-git-send-email-jiapeng.chong@linux.alibaba.com>
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

> From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> Sent: Thursday, August 19, 2021 11:24 AM
> To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> Cc: nathan@kernel.org; ndesaulniers@google.com; ntfs3@lists.linux.dev; li=
nux-kernel@vger.kernel.org; clang-built-
> linux@googlegroups.com; Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> Subject: [PATCH] fs/ntfs3: Remove unused including <linux/version.h>
>=20
> Eliminate the follow versioncheck warning:
>=20
> ./fs/ntfs3/inode.c: 16 linux/version.h not needed.
>=20
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  fs/ntfs3/inode.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> index bf51e29..bb01f1b 100644
> --- a/fs/ntfs3/inode.c
> +++ b/fs/ntfs3/inode.c
> @@ -13,7 +13,6 @@
>  #include <linux/namei.h>
>  #include <linux/nls.h>
>  #include <linux/uio.h>
> -#include <linux/version.h>
>  #include <linux/writeback.h>
>=20
>  #include "debug.h"
> --
> 1.8.3.1
Hi Jiapeng! Applied, thanks.
Best regards.
