Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2929D3F9C2E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 18:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245530AbhH0QKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 12:10:46 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:36974 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245348AbhH0QKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 12:10:44 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 897FF1D45;
        Fri, 27 Aug 2021 19:09:54 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1630080594;
        bh=BqiwzVhva+csPjSDEsGqCA8sq/nNxY2PFZRQPK70VtU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=Uo1cnJAycJAsDIrY1jAgvEiC6dQsXrfxkdbB8p7fIdQdJUAbVu0HFikQyAfmQRiTo
         j8Vd2HDcLgvVGLnEFQCSPUF7yvKREeBfNxp4JgwKrke5vlH7PJO1cjWieUnhTfvsoJ
         1ZiXO19EpM8mbJ4Fi+DyvzpLcOtAvK8rzEb6oyOU=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 27 Aug 2021 19:09:54 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%12]) with
 mapi id 15.01.2176.009; Fri, 27 Aug 2021 19:09:54 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     Kari Argillander <kari.argillander@gmail.com>,
        "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] fs/ntfs3: Add ifndef + define to all header files
Thread-Topic: [PATCH] fs/ntfs3: Add ifndef + define to all header files
Thread-Index: AQHXkpaNnll4ojWsX0ux0GOVaSMR8auHlqNw
Date:   Fri, 27 Aug 2021 16:09:54 +0000
Message-ID: <e73f5cebaee948568c2738bd1b9d9edf@paragon-software.com>
References: <20210816120156.186193-1-kari.argillander@gmail.com>
In-Reply-To: <20210816120156.186193-1-kari.argillander@gmail.com>
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
> Sent: Monday, August 16, 2021 3:02 PM
> To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>; ntfs3@=
lists.linux.dev
> Cc: Kari Argillander <kari.argillander@gmail.com>; linux-kernel@vger.kern=
el.org
> Subject: [PATCH] fs/ntfs3: Add ifndef + define to all header files
>=20
> Add guards so that compiler will only include header files once.
>=20
> Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
> ---
> I do not mind if this get's merged to V28/V29 without commit.
> ---
>  fs/ntfs3/debug.h   | 5 +++++
>  fs/ntfs3/ntfs.h    | 3 +++
>  fs/ntfs3/ntfs_fs.h | 5 +++++
>  3 files changed, 13 insertions(+)
>=20
> diff --git a/fs/ntfs3/debug.h b/fs/ntfs3/debug.h
> index dfaa4c79dc6d..465466631d38 100644
> --- a/fs/ntfs3/debug.h
> +++ b/fs/ntfs3/debug.h
> @@ -7,6 +7,9 @@
>   */
>=20
>  // clang-format off
> +#ifndef _LINUX_NTFS3_DEBUG_H
> +#define _LINUX_NTFS3_DEBUG_H
> +
>  #ifndef Add2Ptr
>  #define Add2Ptr(P, I)		((void *)((u8 *)(P) + (I)))
>  #define PtrOffset(B, O)		((size_t)((size_t)(O) - (size_t)(B)))
> @@ -61,4 +64,6 @@ void ntfs_inode_printk(struct inode *inode, const char =
*fmt, ...)
>  #define ntfs_free(p)		kfree(p)
>  #define ntfs_vfree(p)		kvfree(p)
>  #define ntfs_memdup(src, len)	kmemdup(src, len, GFP_NOFS)
> +
> +#endif /* _LINUX_NTFS3_DEBUG_H */
>  // clang-format on
> diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
> index 40398e6c39c9..16da514af124 100644
> --- a/fs/ntfs3/ntfs.h
> +++ b/fs/ntfs3/ntfs.h
> @@ -7,6 +7,8 @@
>   */
>=20
>  // clang-format off
> +#ifndef _LINUX_NTFS3_NTFS_H
> +#define _LINUX_NTFS3_NTFS_H
>=20
>  /* TODO:
>   * - Check 4K mft record and 512 bytes cluster
> @@ -1235,4 +1237,5 @@ struct SID {
>  };
>  static_assert(offsetof(struct SID, SubAuthority) =3D=3D 8);
>=20
> +#endif /* _LINUX_NTFS3_NTFS_H */
>  // clang-format on
> diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
> index 0c3ac89c3115..80e1dea2579a 100644
> --- a/fs/ntfs3/ntfs_fs.h
> +++ b/fs/ntfs3/ntfs_fs.h
> @@ -6,6 +6,9 @@
>   */
>=20
>  // clang-format off
> +#ifndef _LINUX_NTFS3_NTFS_FS_H
> +#define _LINUX_NTFS3_NTFS_FS_H
> +
>  #define MINUS_ONE_T			((size_t)(-1))
>  /* Biggest MFT / smallest cluster */
>  #define MAXIMUM_BYTES_PER_MFT		4096
> @@ -1090,3 +1093,5 @@ static inline void le64_sub_cpu(__le64 *var, u64 va=
l)
>  {
>  	*var =3D cpu_to_le64(le64_to_cpu(*var) - val);
>  }
> +
> +#endif /* _LINUX_NTFS3_NTFS_FS_H */
> --
> 2.30.2

Thanks again - applied!

Best regards
