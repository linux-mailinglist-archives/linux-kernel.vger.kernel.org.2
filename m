Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863D43F9D5C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 19:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236737AbhH0RO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 13:14:58 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:59505 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231325AbhH0RO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 13:14:56 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 9DEE282098;
        Fri, 27 Aug 2021 20:14:06 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1630084446;
        bh=ZwOcqdTC0R72bGI27rg5+vLxEE/rDPnkWZ1BmV4glkY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=eG92I9pXLFlTX7tjrr/1V8I12BRbcz60XCCZPoFLWerq7s34EaNktgxsOv4u4HDVp
         nmSBMzUWYGkMlloGLG3YI9KDAZY9mezqqYaZ8Z19et125dfOVb3634QGDM2ylX9s0q
         DIpm6tnSVDry5Tm5C4x/RCxrCUt+I9hh6Y5aHGos=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 27 Aug 2021 20:14:06 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%12]) with
 mapi id 15.01.2176.009; Fri, 27 Aug 2021 20:14:06 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     Kari Argillander <kari.argillander@gmail.com>,
        "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Dan Carpenter" <dan.carpenter@oracle.com>
Subject: RE: [PATCH v2] fs/ntfs3: Use kernel ALIGN macros over driver specific
Thread-Topic: [PATCH v2] fs/ntfs3: Use kernel ALIGN macros over driver
 specific
Thread-Index: AQHXmlhV5xXSFj1mfEW1c/HCR7pysKuHmRRA
Date:   Fri, 27 Aug 2021 17:14:06 +0000
Message-ID: <ceb3d439826c4295a3507ff0d11b2fd9@paragon-software.com>
References: <20210826085629.1566449-1-kari.argillander@gmail.com>
In-Reply-To: <20210826085629.1566449-1-kari.argillander@gmail.com>
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
> Sent: Thursday, August 26, 2021 11:56 AM
> To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>; ntfs3@=
lists.linux.dev
> Cc: Kari Argillander <kari.argillander@gmail.com>; linux-kernel@vger.kern=
el.org; Dan Carpenter <dan.carpenter@oracle.com>
> Subject: [PATCH v2] fs/ntfs3: Use kernel ALIGN macros over driver specifi=
c
>=20
> The static checkers (Smatch) were complaining because QuadAlign() was
> buggy.  If you try to align something higher than UINT_MAX it got
> truncated to a u32.
>=20
> Smatch warning was:
> 	fs/ntfs3/attrib.c:383 attr_set_size_res()
> 	warn: was expecting a 64 bit value instead of '~7'
>=20
> So that this will not happen again we will change all these macros to
> kernel made ones. This can also help some other static analyzing tools
> to give us better warnings.
>=20
> Patch was generated with Coccinelle script and after that some style
> issue was hand fixed.
>=20
> Coccinelle script:
>=20
> virtual patch
>=20
> @alloc depends on patch@
> expression x;
> @@
> (
> -	#define QuadAlign(n)		(((n) + 7u) & (~7u))
> |
> -	QuadAlign(x)
> +	ALIGN(x, 8)
> |
> -	#define IsQuadAligned(n)	(!((size_t)(n)&7u))
> |
> -	IsQuadAligned(x)
> +	IS_ALIGNED(x, 8)
> |
> -	#define Quad2Align(n)		(((n) + 15u) & (~15u))
> |
> -	Quad2Align(x)
> +	ALIGN(x, 16)
> |
> -	#define IsQuad2Aligned(n)	(!((size_t)(n)&15u))
> |
> -	IsQuad2Aligned(x)
> +	IS_ALIGNED(x, 16)
> |
> -	#define Quad4Align(n)		(((n) + 31u) & (~31u))
> |
> -	Quad4Align(x)
> +	ALIGN(x, 32)
> |
> -	#define IsSizeTAligned(n)	(!((size_t)(n) & (sizeof(size_t) - 1)))
> |
> -	IsSizeTAligned(x)
> +	IS_ALIGNED(x, sizeof(size_t))
> |
> -	#define DwordAlign(n)		(((n) + 3u) & (~3u))
> |
> -	DwordAlign(x)
> +	ALIGN(x, 4)
> |
> -	#define IsDwordAligned(n)	(!((size_t)(n)&3u))
> |
> -	IsDwordAligned(x)
> +	IS_ALIGNED(x, 4)
> |
> -	#define WordAlign(n)		(((n) + 1u) & (~1u))
> |
> -	WordAlign(x)
> +	ALIGN(x, 2)
> |
> -	#define IsWordAligned(n)	(!((size_t)(n)&1u))
> |
> -	IsWordAligned(x)
> +	IS_ALIGNED(x, 2)
> |
> )
>=20
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
> ---
> Disgussion that these should be changed can be found here
> lore.kernel.org/ntfs3/20210824104910.v3mvpw5zb2jqmvbo@kari-VirtualBox/
>=20
> V2:
> 	Make better commit message. Request by Dan Carpenter.
> ---
>  fs/ntfs3/attrib.c  |  2 +-
>  fs/ntfs3/debug.h   | 11 -----------
>  fs/ntfs3/frecord.c | 14 +++++++-------
>  fs/ntfs3/fslog.c   | 32 ++++++++++++++++----------------
>  fs/ntfs3/fsntfs.c  |  4 ++--
>  fs/ntfs3/index.c   |  4 ++--
>  fs/ntfs3/inode.c   |  8 ++++----
>  fs/ntfs3/namei.c   |  2 +-
>  fs/ntfs3/ntfs.h    | 16 ++++++++--------
>  fs/ntfs3/ntfs_fs.h |  2 +-
>  fs/ntfs3/record.c  | 10 +++++-----
>  fs/ntfs3/super.c   | 10 +++++-----
>  fs/ntfs3/xattr.c   |  8 ++++----
>  13 files changed, 56 insertions(+), 67 deletions(-)
>=20
> diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
> index 046dc57f75f2..c15467ec12ed 100644
> --- a/fs/ntfs3/attrib.c
> +++ b/fs/ntfs3/attrib.c
> @@ -380,7 +380,7 @@ static int attr_set_size_res(struct ntfs_inode *ni, s=
truct ATTRIB *attr,
>  	u32 rsize =3D le32_to_cpu(attr->res.data_size);
>  	u32 tail =3D used - aoff - asize;
>  	char *next =3D Add2Ptr(attr, asize);
> -	s64 dsize =3D QuadAlign(new_size) - QuadAlign(rsize);
> +	s64 dsize =3D ALIGN(new_size, 8) - ALIGN(rsize, 8);
>=20
>  	if (dsize < 0) {
>  		memmove(next + dsize, next, tail);
> diff --git a/fs/ntfs3/debug.h b/fs/ntfs3/debug.h
> index dfaa4c79dc6d..fe5ed660c3b0 100644
> --- a/fs/ntfs3/debug.h
> +++ b/fs/ntfs3/debug.h
> @@ -12,17 +12,6 @@
>  #define PtrOffset(B, O)		((size_t)((size_t)(O) - (size_t)(B)))
>  #endif
>=20
> -#define QuadAlign(n)		(((n) + 7u) & (~7u))
> -#define IsQuadAligned(n)	(!((size_t)(n)&7u))
> -#define Quad2Align(n)		(((n) + 15u) & (~15u))
> -#define IsQuad2Aligned(n)	(!((size_t)(n)&15u))
> -#define Quad4Align(n)		(((n) + 31u) & (~31u))
> -#define IsSizeTAligned(n)	(!((size_t)(n) & (sizeof(size_t) - 1)))
> -#define DwordAlign(n)		(((n) + 3u) & (~3u))
> -#define IsDwordAligned(n)	(!((size_t)(n)&3u))
> -#define WordAlign(n)		(((n) + 1u) & (~1u))
> -#define IsWordAligned(n)	(!((size_t)(n)&1u))
> -
>  #ifdef CONFIG_PRINTK
>  __printf(2, 3)
>  void ntfs_printk(const struct super_block *sb, const char *fmt, ...);
> diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
> index c3121bf9c62f..28c471e5b098 100644
> --- a/fs/ntfs3/frecord.c
> +++ b/fs/ntfs3/frecord.c
> @@ -1249,7 +1249,7 @@ static int ni_expand_mft_list(struct ntfs_inode *ni=
)
>  	if (err < 0)
>  		goto out;
>=20
> -	run_size =3D QuadAlign(err);
> +	run_size =3D ALIGN(err, 8);
>  	err =3D 0;
>=20
>  	if (plen < svcn) {
> @@ -1269,7 +1269,7 @@ static int ni_expand_mft_list(struct ntfs_inode *ni=
)
>  	if (err < 0)
>  		goto out;
>=20
> -	run_size =3D QuadAlign(err);
> +	run_size =3D ALIGN(err, 8);
>  	err =3D 0;
>=20
>  	if (plen < evcn + 1 - svcn) {
> @@ -1392,7 +1392,7 @@ int ni_insert_nonresident(struct ntfs_inode *ni, en=
um ATTR_TYPE type,
>  	struct ATTRIB *attr;
>  	bool is_ext =3D
>  		(flags & (ATTR_FLAG_SPARSED | ATTR_FLAG_COMPRESSED)) && !svcn;
> -	u32 name_size =3D QuadAlign(name_len * sizeof(short));
> +	u32 name_size =3D ALIGN(name_len * sizeof(short), 8);
>  	u32 name_off =3D is_ext ? SIZEOF_NONRESIDENT_EX : SIZEOF_NONRESIDENT;
>  	u32 run_off =3D name_off + name_size;
>  	u32 run_size, asize;
> @@ -1403,7 +1403,7 @@ int ni_insert_nonresident(struct ntfs_inode *ni, en=
um ATTR_TYPE type,
>  	if (err < 0)
>  		goto out;
>=20
> -	run_size =3D QuadAlign(err);
> +	run_size =3D ALIGN(err, 8);
>=20
>  	if (plen < len) {
>  		err =3D -EINVAL;
> @@ -1463,8 +1463,8 @@ int ni_insert_resident(struct ntfs_inode *ni, u32 d=
ata_size,
>  		       struct ATTRIB **new_attr, struct mft_inode **mi)
>  {
>  	int err;
> -	u32 name_size =3D QuadAlign(name_len * sizeof(short));
> -	u32 asize =3D SIZEOF_RESIDENT + name_size + QuadAlign(data_size);
> +	u32 name_size =3D ALIGN(name_len * sizeof(short), 8);
> +	u32 asize =3D SIZEOF_RESIDENT + name_size + ALIGN(data_size, 8);
>  	struct ATTRIB *attr;
>=20
>  	err =3D ni_insert_attr(ni, type, name, name_len, asize, SIZEOF_RESIDENT=
,
> @@ -2849,7 +2849,7 @@ static bool ni_update_parent(struct ntfs_inode *ni,=
 struct NTFS_DUP_INFO *dup,
>  		} else if (!attr->non_res) {
>  			u32 data_size =3D le32_to_cpu(attr->res.data_size);
>=20
> -			dup->alloc_size =3D cpu_to_le64(QuadAlign(data_size));
> +			dup->alloc_size =3D cpu_to_le64(ALIGN(data_size, 8));
>  			dup->data_size =3D cpu_to_le64(data_size);
>  		} else {
>  			u64 new_valid =3D ni->i_valid;
> diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
> index 397ba6a956e7..5a118c351441 100644
> --- a/fs/ntfs3/fslog.c
> +++ b/fs/ntfs3/fslog.c
> @@ -456,7 +456,7 @@ static inline bool is_rst_page_hdr_valid(u32 file_off=
,
>  		return false;
>=20
>  	ro =3D le16_to_cpu(rhdr->ra_off);
> -	if (!IsQuadAligned(ro) || ro > sys_page)
> +	if (!IS_ALIGNED(ro, 8) || ro > sys_page)
>  		return false;
>=20
>  	end_usa =3D ((sys_page >> SECTOR_SHIFT) + 1) * sizeof(short);
> @@ -488,7 +488,7 @@ static inline bool is_rst_area_valid(const struct RES=
TART_HDR *rhdr)
>=20
>  	off =3D le16_to_cpu(ra->client_off);
>=20
> -	if (!IsQuadAligned(off) || ro + off > SECTOR_SIZE - sizeof(short))
> +	if (!IS_ALIGNED(off, 8) || ro + off > SECTOR_SIZE - sizeof(short))
>  		return false;
>=20
>  	off +=3D cl * sizeof(struct CLIENT_REC);
> @@ -526,8 +526,8 @@ static inline bool is_rst_area_valid(const struct RES=
TART_HDR *rhdr)
>  	}
>=20
>  	/* The log page data offset and record header length must be quad-align=
ed */
> -	if (!IsQuadAligned(le16_to_cpu(ra->data_off)) ||
> -	    !IsQuadAligned(le16_to_cpu(ra->rec_hdr_len)))
> +	if (!IS_ALIGNED(le16_to_cpu(ra->data_off), 8) ||
> +	    !IS_ALIGNED(le16_to_cpu(ra->rec_hdr_len), 8))
>  		return false;
>=20
>  	return true;
> @@ -1355,9 +1355,9 @@ static void log_create(struct ntfs_log *log, u32 l_=
size, const u64 last_lsn,
>  		log->l_flags |=3D NTFSLOG_MULTIPLE_PAGE_IO;
>=20
>  	/* Compute the log page values */
> -	log->data_off =3D QuadAlign(
> +	log->data_off =3D ALIGN(
>  		offsetof(struct RECORD_PAGE_HDR, fixups) +
> -		sizeof(short) * ((log->page_size >> SECTOR_SHIFT) + 1));
> +		sizeof(short) * ((log->page_size >> SECTOR_SHIFT) + 1), 8);
>  	log->data_size =3D log->page_size - log->data_off;
>  	log->record_header_len =3D sizeof(struct LFS_RECORD_HDR);
>=20
> @@ -1365,9 +1365,9 @@ static void log_create(struct ntfs_log *log, u32 l_=
size, const u64 last_lsn,
>  	log->reserved =3D log->data_size - log->record_header_len;
>=20
>  	/* Compute the restart page values. */
> -	log->ra_off =3D QuadAlign(
> +	log->ra_off =3D ALIGN(
>  		offsetof(struct RESTART_HDR, fixups) +
> -		sizeof(short) * ((log->sys_page_size >> SECTOR_SHIFT) + 1));
> +		sizeof(short) * ((log->sys_page_size >> SECTOR_SHIFT) + 1), 8);
>  	log->restart_size =3D log->sys_page_size - log->ra_off;
>  	log->ra_size =3D struct_size(log->ra, clients, 1);
>  	log->current_openlog_count =3D open_log_count;
> @@ -1496,7 +1496,7 @@ static int next_log_lsn(struct ntfs_log *log, const=
 struct LFS_RECORD_HDR *rh,
>=20
>  		vbo =3D hdr_off + log->data_off;
>  	} else {
> -		vbo =3D QuadAlign(end);
> +		vbo =3D ALIGN(end, 8);
>  	}
>=20
>  	/* Compute the lsn based on the file offset and the sequence count */
> @@ -2982,7 +2982,7 @@ static struct ATTRIB *attr_create_nonres_log(struct=
 ntfs_sb_info *sbi,
>  					     __le16 flags)
>  {
>  	struct ATTRIB *attr;
> -	u32 name_size =3D QuadAlign(name_len * sizeof(short));
> +	u32 name_size =3D ALIGN(name_len * sizeof(short), 8);
>  	bool is_ext =3D flags & (ATTR_FLAG_COMPRESSED | ATTR_FLAG_SPARSED);
>  	u32 asize =3D name_size +
>  		    (is_ext ? SIZEOF_NONRESIDENT_EX : SIZEOF_NONRESIDENT);
> @@ -3220,7 +3220,7 @@ static int do_action(struct ntfs_log *log, struct O=
PEN_ATTR_ENRTY *oe,
>  			goto dirty_vol;
>=20
>  		memmove(attr, attr2, dlen);
> -		rec->used =3D cpu_to_le32(QuadAlign(roff + dlen));
> +		rec->used =3D cpu_to_le32(ALIGN(roff + dlen, 8));
>=20
>  		mi->dirty =3D true;
>  		break;
> @@ -3231,7 +3231,7 @@ static int do_action(struct ntfs_log *log, struct O=
PEN_ATTR_ENRTY *oe,
>  		used =3D le32_to_cpu(rec->used);
>=20
>  		if (!check_if_attr(rec, lrh) || dlen < SIZEOF_RESIDENT ||
> -		    !IsQuadAligned(asize) ||
> +		    !IS_ALIGNED(asize, 8) ||
>  		    Add2Ptr(attr2, asize) > Add2Ptr(lrh, rec_len) ||
>  		    dlen > record_size - used) {
>  			goto dirty_vol;
> @@ -3296,7 +3296,7 @@ static int do_action(struct ntfs_log *log, struct O=
PEN_ATTR_ENRTY *oe,
>  		if (nsize > asize && nsize - asize > record_size - used)
>  			goto dirty_vol;
>=20
> -		nsize =3D QuadAlign(nsize);
> +		nsize =3D ALIGN(nsize, 8);
>  		data_off =3D le16_to_cpu(attr->res.data_off);
>=20
>  		if (nsize < asize) {
> @@ -3341,7 +3341,7 @@ static int do_action(struct ntfs_log *log, struct O=
PEN_ATTR_ENRTY *oe,
>  			goto dirty_vol;
>  		}
>=20
> -		nsize =3D QuadAlign(nsize);
> +		nsize =3D ALIGN(nsize, 8);
>=20
>  		memmove(Add2Ptr(attr, nsize), Add2Ptr(attr, asize),
>  			used - le16_to_cpu(lrh->record_off) - asize);
> @@ -5103,8 +5103,8 @@ int log_replay(struct ntfs_inode *ni, bool *initial=
ized)
>  	rh->sys_page_size =3D cpu_to_le32(log->page_size);
>  	rh->page_size =3D cpu_to_le32(log->page_size);
>=20
> -	t16 =3D QuadAlign(offsetof(struct RESTART_HDR, fixups) +
> -			sizeof(short) * t16);
> +	t16 =3D ALIGN(offsetof(struct RESTART_HDR, fixups) +
> +		    sizeof(short) * t16, 8);
>  	rh->ra_off =3D cpu_to_le16(t16);
>  	rh->minor_ver =3D cpu_to_le16(1); // 0x1A:
>  	rh->major_ver =3D cpu_to_le16(1); // 0x1C:
> diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
> index 92140050fb6c..488e47c7f670 100644
> --- a/fs/ntfs3/fsntfs.c
> +++ b/fs/ntfs3/fsntfs.c
> @@ -1944,7 +1944,7 @@ int ntfs_security_init(struct ntfs_sb_info *sbi)
>  	sbi->security.next_id =3D SECURITY_ID_FIRST;
>  	/* Always write new security at the end of bucket */
>  	sbi->security.next_off =3D
> -		Quad2Align(sds_size - SecurityDescriptorsBlockSize);
> +			ALIGN(sds_size - SecurityDescriptorsBlockSize, 16);
>=20
>  	cnt =3D 0;
>  	off =3D 0;
> @@ -2099,7 +2099,7 @@ int ntfs_insert_security(struct ntfs_sb_info *sbi,
>  	struct NTFS_DE_SII sii_e;
>  	struct SECURITY_HDR *d_security;
>  	u32 new_sec_size =3D size_sd + SIZEOF_SECURITY_HDR;
> -	u32 aligned_sec_size =3D Quad2Align(new_sec_size);
> +	u32 aligned_sec_size =3D ALIGN(new_sec_size, 16);
>  	struct SECURITY_KEY hash_key;
>  	struct ntfs_fnd *fnd_sdh =3D NULL;
>  	const struct INDEX_ROOT *root_sdh;
> diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
> index 6aa9540ece47..3fdec8871fab 100644
> --- a/fs/ntfs3/index.c
> +++ b/fs/ntfs3/index.c
> @@ -701,7 +701,7 @@ static struct NTFS_DE *hdr_find_e(const struct ntfs_i=
ndex *indx,
>=20
>  	if (max_idx >=3D nslots) {
>  		u16 *ptr;
> -		int new_slots =3D QuadAlign(2 * nslots);
> +		int new_slots =3D ALIGN(2 * nslots, 8);
>=20
>  		ptr =3D ntfs_malloc(sizeof(u16) * new_slots);
>  		if (ptr)
> @@ -958,7 +958,7 @@ static struct indx_node *indx_new(struct ntfs_index *=
indx,
>  	index->rhdr.fix_num =3D cpu_to_le16(fn);
>  	index->vbn =3D cpu_to_le64(vbn);
>  	hdr =3D &index->ihdr;
> -	eo =3D QuadAlign(sizeof(struct INDEX_BUFFER) + fn * sizeof(short));
> +	eo =3D ALIGN(sizeof(struct INDEX_BUFFER) + fn * sizeof(short), 8);
>  	hdr->de_off =3D cpu_to_le32(eo);
>=20
>  	e =3D Add2Ptr(hdr, eo);
> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> index bf51e294432e..36f673857ebd 100644
> --- a/fs/ntfs3/inode.c
> +++ b/fs/ntfs3/inode.c
> @@ -1336,7 +1336,7 @@ struct inode *ntfs_create_inode(struct user_namespa=
ce *mnt_userns,
>  	fname->dup.ea_size =3D fname->dup.reparse =3D 0;
>=20
>  	dsize =3D le16_to_cpu(new_de->key_size);
> -	asize =3D QuadAlign(SIZEOF_RESIDENT + dsize);
> +	asize =3D ALIGN(SIZEOF_RESIDENT + dsize, 8);
>=20
>  	attr->type =3D ATTR_NAME;
>  	attr->size =3D cpu_to_le32(asize);
> @@ -1350,7 +1350,7 @@ struct inode *ntfs_create_inode(struct user_namespa=
ce *mnt_userns,
>=20
>  	if (security_id =3D=3D SECURITY_ID_INVALID) {
>  		/* Insert security attribute */
> -		asize =3D SIZEOF_RESIDENT + QuadAlign(sd_size);
> +		asize =3D SIZEOF_RESIDENT + ALIGN(sd_size, 8);
>=20
>  		attr->type =3D ATTR_SECURE;
>  		attr->size =3D cpu_to_le32(asize);
> @@ -1473,7 +1473,7 @@ struct inode *ntfs_create_inode(struct user_namespa=
ce *mnt_userns,
>  		attr->id =3D cpu_to_le16(aid++);
>=20
>  		/* resident or non resident? */
> -		asize =3D QuadAlign(SIZEOF_RESIDENT + nsize);
> +		asize =3D ALIGN(SIZEOF_RESIDENT + nsize, 8);
>  		t16 =3D PtrOffset(rec, attr);
>=20
>  		if (asize + t16 + 8 > sbi->record_size) {
> @@ -1509,7 +1509,7 @@ struct inode *ntfs_create_inode(struct user_namespa=
ce *mnt_userns,
>  				goto out5;
>  			}
>=20
> -			asize =3D SIZEOF_NONRESIDENT + QuadAlign(err);
> +			asize =3D SIZEOF_NONRESIDENT + ALIGN(err, 8);
>  			inode->i_size =3D nsize;
>  		} else {
>  			attr->res.data_off =3D SIZEOF_RESIDENT_LE;
> diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
> index b1ccd66172f2..0626844e6bdc 100644
> --- a/fs/ntfs3/namei.c
> +++ b/fs/ntfs3/namei.c
> @@ -57,7 +57,7 @@ int fill_name_de(struct ntfs_sb_info *sbi, void *buf, c=
onst struct qstr *name,
>  	fname->type =3D FILE_NAME_POSIX;
>  	data_size =3D fname_full_size(fname);
>=20
> -	e->size =3D cpu_to_le16(QuadAlign(data_size) + sizeof(struct NTFS_DE));
> +	e->size =3D cpu_to_le16(ALIGN(data_size, 8) + sizeof(struct NTFS_DE));
>  	e->key_size =3D cpu_to_le16(data_size);
>  	e->flags =3D 0;
>  	e->res =3D 0;
> diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
> index 40398e6c39c9..d6480845ce1f 100644
> --- a/fs/ntfs3/ntfs.h
> +++ b/fs/ntfs3/ntfs.h
> @@ -390,8 +390,8 @@ static inline u64 attr_ondisk_size(const struct ATTRI=
B *attr)
>  	return attr->non_res ? ((attr->flags &
>  				 (ATTR_FLAG_COMPRESSED | ATTR_FLAG_SPARSED)) ?
>  					le64_to_cpu(attr->nres.total_size) :
> -					le64_to_cpu(attr->nres.alloc_size)) :
> -			       QuadAlign(le32_to_cpu(attr->res.data_size));
> +					le64_to_cpu(attr->nres.alloc_size))
> +			     : ALIGN(le32_to_cpu(attr->res.data_size), 8);
>  }
>=20
>  static inline u64 attr_size(const struct ATTRIB *attr)
> @@ -527,8 +527,8 @@ static_assert(sizeof(struct ATTR_LIST_ENTRY) =3D=3D 0=
x20);
>=20
>  static inline u32 le_size(u8 name_len)
>  {
> -	return QuadAlign(offsetof(struct ATTR_LIST_ENTRY, name) +
> -			 name_len * sizeof(short));
> +	return ALIGN(offsetof(struct ATTR_LIST_ENTRY, name) +
> +		     name_len * sizeof(short), 8);
>  }
>=20
>  /* returns 0 if 'attr' has the same type and name */
> @@ -689,10 +689,10 @@ static inline bool de_has_vcn_ex(const struct NTFS_=
DE *e)
>  							sizeof(__le64)));
>  }
>=20
> -#define MAX_BYTES_PER_NAME_ENTRY					       \
> -	QuadAlign(sizeof(struct NTFS_DE) +				       \
> -		  offsetof(struct ATTR_FILE_NAME, name) +		       \
> -		  NTFS_NAME_LEN * sizeof(short))
> +#define MAX_BYTES_PER_NAME_ENTRY \
> +	ALIGN(sizeof(struct NTFS_DE) + \
> +	      offsetof(struct ATTR_FILE_NAME, name) + \
> +	      NTFS_NAME_LEN * sizeof(short), 8)
>=20
>  struct INDEX_HDR {
>  	__le32 de_off;	// 0x00: The offset from the start of this structure
> diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
> index 0c3ac89c3115..69bf1edc561e 100644
> --- a/fs/ntfs3/ntfs_fs.h
> +++ b/fs/ntfs3/ntfs_fs.h
> @@ -897,7 +897,7 @@ static inline bool run_is_empty(struct runs_tree *run=
)
>  /* NTFS uses quad aligned bitmaps */
>  static inline size_t bitmap_size(size_t bits)
>  {
> -	return QuadAlign((bits + 7) >> 3);
> +	return ALIGN((bits + 7) >> 3, 8);
>  }
>=20
>  #define _100ns2seconds 10000000
> diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
> index 0d4a6251bddc..721c14f83e2b 100644
> --- a/fs/ntfs3/record.c
> +++ b/fs/ntfs3/record.c
> @@ -206,7 +206,7 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, str=
uct ATTRIB *attr)
>  			return NULL;
>=20
>  		if (off >=3D used || off < MFTRECORD_FIXUP_OFFSET_1 ||
> -		    !IsDwordAligned(off)) {
> +		    !IS_ALIGNED(off, 4)) {
>  			return NULL;
>  		}
>=20
> @@ -235,7 +235,7 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, str=
uct ATTRIB *attr)
>=20
>  	/* Can we use the first field (attr->type) */
>  	if (off + 8 > used) {
> -		static_assert(QuadAlign(sizeof(enum ATTR_TYPE)) =3D=3D 8);
> +		static_assert(ALIGN(sizeof(enum ATTR_TYPE), 8) =3D=3D 8);
>  		return NULL;
>  	}
>=20
> @@ -539,7 +539,7 @@ bool mi_resize_attr(struct mft_inode *mi, struct ATTR=
IB *attr, int bytes)
>  	next =3D Add2Ptr(attr, asize);
>=20
>  	if (bytes > 0) {
> -		dsize =3D QuadAlign(bytes);
> +		dsize =3D ALIGN(bytes, 8);
>  		if (used + dsize > total)
>  			return false;
>  		nsize =3D asize + dsize;
> @@ -549,7 +549,7 @@ bool mi_resize_attr(struct mft_inode *mi, struct ATTR=
IB *attr, int bytes)
>  		used +=3D dsize;
>  		rsize +=3D dsize;
>  	} else {
> -		dsize =3D QuadAlign(-bytes);
> +		dsize =3D ALIGN(-bytes, 8);
>  		if (dsize > asize)
>  			return false;
>  		nsize =3D asize - dsize;
> @@ -596,7 +596,7 @@ int mi_pack_runs(struct mft_inode *mi, struct ATTRIB =
*attr,
>  		return err;
>  	}
>=20
> -	new_run_size =3D QuadAlign(err);
> +	new_run_size =3D ALIGN(err, 8);
>=20
>  	memmove(next + new_run_size - run_size, next + dsize, tail);
>=20
> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> index 6be13e256c1a..1f4784f8bfaf 100644
> --- a/fs/ntfs3/super.c
> +++ b/fs/ntfs3/super.c
> @@ -808,9 +808,9 @@ static int ntfs_init_from_boot(struct super_block *sb=
, u32 sector_size,
>  	sbi->attr_size_tr =3D (5 * record_size >> 4); // ~320 bytes
>=20
>  	sbi->max_bytes_per_attr =3D
> -		record_size - QuadAlign(MFTRECORD_FIXUP_OFFSET_1) -
> -		QuadAlign(((record_size >> SECTOR_SHIFT) * sizeof(short))) -
> -		QuadAlign(sizeof(enum ATTR_TYPE));
> +		record_size - ALIGN(MFTRECORD_FIXUP_OFFSET_1, 8) -
> +		ALIGN(((record_size >> SECTOR_SHIFT) * sizeof(short)), 8) -
> +		ALIGN(sizeof(enum ATTR_TYPE), 8);
>=20
>  	sbi->index_size =3D boot->index_size < 0
>  				  ? 1u << (-boot->index_size)
> @@ -858,9 +858,9 @@ static int ntfs_init_from_boot(struct super_block *sb=
, u32 sector_size,
>  	rec->rhdr.fix_off =3D cpu_to_le16(MFTRECORD_FIXUP_OFFSET_1);
>  	fn =3D (sbi->record_size >> SECTOR_SHIFT) + 1;
>  	rec->rhdr.fix_num =3D cpu_to_le16(fn);
> -	ao =3D QuadAlign(MFTRECORD_FIXUP_OFFSET_1 + sizeof(short) * fn);
> +	ao =3D ALIGN(MFTRECORD_FIXUP_OFFSET_1 + sizeof(short) * fn, 8);
>  	rec->attr_off =3D cpu_to_le16(ao);
> -	rec->used =3D cpu_to_le32(ao + QuadAlign(sizeof(enum ATTR_TYPE)));
> +	rec->used =3D cpu_to_le32(ao + ALIGN(sizeof(enum ATTR_TYPE), 8));
>  	rec->total =3D cpu_to_le32(sbi->record_size);
>  	((struct ATTRIB *)Add2Ptr(rec, ao))->type =3D ATTR_END;
>=20
> diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
> index 98871c895e77..6b17d46b9506 100644
> --- a/fs/ntfs3/xattr.c
> +++ b/fs/ntfs3/xattr.c
> @@ -26,9 +26,9 @@
>  static inline size_t unpacked_ea_size(const struct EA_FULL *ea)
>  {
>  	return ea->size ? le32_to_cpu(ea->size)
> -			: DwordAlign(struct_size(
> -				  ea, name,
> -				  1 + ea->name_len + le16_to_cpu(ea->elength)));
> +			: ALIGN(struct_size(
> +			      ea, name,
> +			      1 + ea->name_len + le16_to_cpu(ea->elength)), 4);
>  }
>=20
>  static inline size_t packed_ea_size(const struct EA_FULL *ea)
> @@ -289,7 +289,7 @@ static noinline int ntfs_set_ea(struct inode *inode, =
const char *name,
>  		goto out;
>  	}
>=20
> -	add =3D DwordAlign(struct_size(ea_all, name, 1 + name_len + val_size));
> +	add =3D ALIGN(struct_size(ea_all, name, 1 + name_len + val_size), 4);
>=20
>  	err =3D ntfs_read_ea(ni, &ea_all, add, &info);
>  	if (err)
> --
> 2.25.1

Thanks, applied!

Best regards
