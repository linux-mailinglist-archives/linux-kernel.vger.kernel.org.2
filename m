Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A53D53F9C67
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 18:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235979AbhH0Q1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 12:27:51 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:47972 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235911AbhH0Q1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 12:27:50 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 0E9BD820C9;
        Fri, 27 Aug 2021 19:27:00 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1630081620;
        bh=tt5mEXv8qlqB4YWly4mTmZV3s2uSzB94kC/w5/UcOAA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=DnbMDwgJ1skFvRHRP9TsCDgd4tSsKgmEQOAvDWxEa+W9b5OnWPw9f4t7/OCOBrqtn
         k3W3blR5if8lKOGw2lazGBz/JWGXbnmh0jnM63d05DufaU1cwrGYZsoeOShVZy3jdX
         udFgsQTUT6Ysmc2lZU6CHSCuB3/9xLadKhEfhL8Q=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 27 Aug 2021 19:26:59 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%12]) with
 mapi id 15.01.2176.009; Fri, 27 Aug 2021 19:26:59 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
CC:     "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH][next] fs/ntfs3: Fix fall-through warnings for Clang
Thread-Topic: [PATCH][next] fs/ntfs3: Fix fall-through warnings for Clang
Thread-Index: AQHXlH8GgQxbFi/fhU2Z/WpnkAbBi6uHl4+Q
Date:   Fri, 27 Aug 2021 16:26:59 +0000
Message-ID: <aeb1cad119034c359939c76c4835b86a@paragon-software.com>
References: <20210818222146.GA312859@embeddedor>
In-Reply-To: <20210818222146.GA312859@embeddedor>
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

> From: Gustavo A. R. Silva <gustavoars@kernel.org>
> Sent: Thursday, August 19, 2021 1:22 AM
> To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> Cc: ntfs3@lists.linux.dev; linux-kernel@vger.kernel.org; Gustavo A. R. Si=
lva <gustavoars@kernel.org>; linux-
> hardening@vger.kernel.org
> Subject: [PATCH][next] fs/ntfs3: Fix fall-through warnings for Clang
>=20
> Fix the following fallthrough warnings:
>=20
> fs/ntfs3/inode.c:1792:2: warning: unannotated fall-through between switch=
 labels [-Wimplicit-fallthrough]
> fs/ntfs3/index.c:178:2: warning: unannotated fall-through between switch =
labels [-Wimplicit-fallthrough]
>=20
> This helps with the ongoing efforts to globally enable
> -Wimplicit-fallthrough for Clang.
>=20
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  fs/ntfs3/index.c | 1 +
>  fs/ntfs3/inode.c | 1 +
>  2 files changed, 2 insertions(+)
>=20
> diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
> index 6aa9540ece47..76eae60b7fce 100644
> --- a/fs/ntfs3/index.c
> +++ b/fs/ntfs3/index.c
> @@ -175,6 +175,7 @@ static inline NTFS_CMP_FUNC get_cmp_func(const struct=
 INDEX_ROOT *root)
>  		default:
>  			break;
>  		}
> +		break;
>  	default:
>  		break;
>  	}
> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> index bf51e294432e..a573c6e98cb8 100644
> --- a/fs/ntfs3/inode.c
> +++ b/fs/ntfs3/inode.c
> @@ -1789,6 +1789,7 @@ int ntfs_unlink_inode(struct inode *dir, const stru=
ct dentry *dentry)
>  	switch (err) {
>  	case 0:
>  		drop_nlink(inode);
> +		break;
>  	case -ENOTEMPTY:
>  	case -ENOSPC:
>  	case -EROFS:
> --
> 2.27.0

Hi Gustavo, thank you. Picked into ntfs3 tree.

Best regards.
