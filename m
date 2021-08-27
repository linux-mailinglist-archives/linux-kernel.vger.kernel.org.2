Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6970D3F9D82
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 19:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240215AbhH0RRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 13:17:50 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:37578 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239899AbhH0RRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 13:17:48 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 8B5A942C;
        Fri, 27 Aug 2021 20:16:57 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1630084617;
        bh=aKDGBWbxN6juVo3fEnLuKdso5Um1Is+UUWiB/hlPvxg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=nMT53Rx2IyypXu0kTAPoH6O5BkKpNTOTYTMT3ynbQcZLPUCO9oOHIak2/ByYhQVYY
         yWi73i2UwNK8VidYS5QCXAAOVdDgjxkDjdHDhmx8gIJ71kMpFmLiQWLBxCXcHgIjLs
         /6oDqf+7AllwEIOXHc/YPISLMbxlaz4UoazwxsC8=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 27 Aug 2021 20:16:57 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%12]) with
 mapi id 15.01.2176.009; Fri, 27 Aug 2021 20:16:57 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] fs/ntfs3: add checks for allocation failure
Thread-Topic: [PATCH] fs/ntfs3: add checks for allocation failure
Thread-Index: AQHXmN6VFXy+PyddQ0qyTjMLzsfUaKuHnNlw
Date:   Fri, 27 Aug 2021 17:16:57 +0000
Message-ID: <433bf776e8cf4fcc8dc9c1db4e43151b@paragon-software.com>
References: <20210824115236.GJ31143@kili>
In-Reply-To: <20210824115236.GJ31143@kili>
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

> From: Dan Carpenter <dan.carpenter@oracle.com>
> Sent: Tuesday, August 24, 2021 2:53 PM
> To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> Cc: ntfs3@lists.linux.dev; linux-kernel@vger.kernel.org; kernel-janitors@=
vger.kernel.org
> Subject: [PATCH] fs/ntfs3: add checks for allocation failure
>=20
> Add a check for when the kzalloc() in init_rsttbl() fails.  Some of
> the callers checked for NULL and some did not.  I went down the call
> tree and added NULL checks where ever they were missing.
>=20
> Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  fs/ntfs3/fslog.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
> index 397ba6a956e7..209fe6ddead0 100644
> --- a/fs/ntfs3/fslog.c
> +++ b/fs/ntfs3/fslog.c
> @@ -807,7 +807,11 @@ static inline struct RESTART_TABLE *init_rsttbl(u16 =
esize, u16 used)
>  	u32 off;
>  	u32 bytes =3D esize * used + sizeof(struct RESTART_TABLE);
>  	u32 lf =3D sizeof(struct RESTART_TABLE) + (used - 1) * esize;
> -	struct RESTART_TABLE *t =3D ntfs_zalloc(bytes);
> +	struct RESTART_TABLE *t;
> +
> +	t =3D ntfs_zalloc(bytes);
> +	if (!t)
> +		return NULL;
>=20
>  	t->size =3D cpu_to_le16(esize);
>  	t->used =3D cpu_to_le16(used);
> @@ -831,7 +835,11 @@ static inline struct RESTART_TABLE *extend_rsttbl(st=
ruct RESTART_TABLE *tbl,
>  	u16 esize =3D le16_to_cpu(tbl->size);
>  	__le32 osize =3D cpu_to_le32(bytes_per_rt(tbl));
>  	u32 used =3D le16_to_cpu(tbl->used);
> -	struct RESTART_TABLE *rt =3D init_rsttbl(esize, used + add);
> +	struct RESTART_TABLE *rt;
> +
> +	rt =3D init_rsttbl(esize, used + add);
> +	if (!rt)
> +		return NULL;
>=20
>  	memcpy(rt + 1, tbl + 1, esize * used);
>=20
> @@ -864,8 +872,11 @@ static inline void *alloc_rsttbl_idx(struct RESTART_=
TABLE **tbl)
>  	__le32 *e;
>  	struct RESTART_TABLE *t =3D *tbl;
>=20
> -	if (!t->first_free)
> +	if (!t->first_free) {
>  		*tbl =3D t =3D extend_rsttbl(t, 16, ~0u);
> +		if (!t)
> +			return NULL;
> +	}
>=20
>  	off =3D le32_to_cpu(t->first_free);
>=20
> @@ -4482,6 +4493,10 @@ int log_replay(struct ntfs_inode *ni, bool *initia=
lized)
>  		}
>=20
>  		dp =3D alloc_rsttbl_idx(&dptbl);
> +		if (!dp) {
> +			err =3D -ENOMEM;
> +			goto out;
> +		}
>  		dp->target_attr =3D cpu_to_le32(t16);
>  		dp->transfer_len =3D cpu_to_le32(t32 << sbi->cluster_bits);
>  		dp->lcns_follow =3D cpu_to_le32(t32);
> --
> 2.20.1

Hi Dan! Thanks, applied :)

Best regards
