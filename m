Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C4131C5B6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 04:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhBPDCQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 15 Feb 2021 22:02:16 -0500
Received: from mgw-02.mpynet.fi ([82.197.21.91]:40400 "EHLO mgw-02.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229767AbhBPDCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 22:02:14 -0500
X-Greylist: delayed 1228 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Feb 2021 22:02:12 EST
Received: from pps.filterd (mgw-02.mpynet.fi [127.0.0.1])
        by mgw-02.mpynet.fi (8.16.0.42/8.16.0.42) with SMTP id 11G2c4K5025249;
        Tue, 16 Feb 2021 04:40:39 +0200
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-02.mpynet.fi with ESMTP id 36p3b99csk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 16 Feb 2021 04:40:39 +0200
Received: from tuxera-exch.ad.tuxera.com (10.20.48.11) by
 tuxera-exch.ad.tuxera.com (10.20.48.11) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 16 Feb 2021 04:40:38 +0200
Received: from tuxera-exch.ad.tuxera.com ([fe80::552a:f9f0:68c3:d789]) by
 tuxera-exch.ad.tuxera.com ([fe80::552a:f9f0:68c3:d789%12]) with mapi id
 15.00.1497.010; Tue, 16 Feb 2021 04:40:38 +0200
From:   Anton Altaparmakov <anton@tuxera.com>
To:     Rustam Kovhaev <rkovhaev@gmail.com>
CC:     "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        LKML <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] ntfs: move check for valid resident attribute offset and
 length
Thread-Topic: [PATCH] ntfs: move check for valid resident attribute offset and
 length
Thread-Index: AQHXAx6ulE0VKfu7TUyB68x/V5vzsapZ8nKA
Date:   Tue, 16 Feb 2021 02:40:37 +0000
Message-ID: <2727F0B7-4992-4B24-963F-CC3C4D94CFD2@tuxera.com>
References: <20210214221247.621431-1-rkovhaev@gmail.com>
In-Reply-To: <20210214221247.621431-1-rkovhaev@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [109.155.251.193]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <282F6835C1C3B048817C8EB2AD57F61B@ex13.tuxera.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-15_16:2021-02-12,2021-02-15 signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 malwarescore=0 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102160024
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rustam,

Thank you for the patch but it is not quite correct:

1) The first delta: yes that is a good idea to add this check but the error message is incorrect.  It should say "Corrupt standard information attribute in inode." instead.

2) The second delta: The check of the attribute list attribute needs to remain, i.e. your second delta needs to be deleted.

Please could you address both of the above comments and then resend?  Please then also add: "Acked-by: Anton Altaparmakov <anton@tuxera.com>" to the patch.

Thanks a lot in advance!

Best regards,

	Anton

> On 14 Feb 2021, at 22:12, Rustam Kovhaev <rkovhaev@gmail.com> wrote:
> 
> we should check for valid resident atribute offset and length before
> loading STANDARD_INFORMATION attribute in ntfs_read_locked_inode()
> let's make that check a bit earlier in the same function to avoid
> use-after-free bug
> 
> Reported-and-tested-by: syzbot+c584225dabdea2f71969@syzkaller.appspotmail.com
> Signed-off-by: Rustam Kovhaev <rkovhaev@gmail.com>
> Link: https://syzkaller.appspot.com/bug?extid=c584225dabdea2f71969
> ---
> fs/ntfs/inode.c | 15 +++++++--------
> 1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
> index f7e4cbc26eaf..70745aea5106 100644
> --- a/fs/ntfs/inode.c
> +++ b/fs/ntfs/inode.c
> @@ -629,6 +629,13 @@ static int ntfs_read_locked_inode(struct inode *vi)
> 	}
> 	a = ctx->attr;
> 	/* Get the standard information attribute value. */
> +	if ((u8 *)a + le16_to_cpu(a->data.resident.value_offset)
> +			+ le32_to_cpu(
> +			a->data.resident.value_length) >
> +			(u8 *)ctx->mrec + vol->mft_record_size) {
> +		ntfs_error(vi->i_sb, "Corrupt attribute list in inode.");
> +		goto unm_err_out;
> +	}
> 	si = (STANDARD_INFORMATION*)((u8*)a +
> 			le16_to_cpu(a->data.resident.value_offset));
> 
> @@ -731,14 +738,6 @@ static int ntfs_read_locked_inode(struct inode *vi)
> 				goto unm_err_out;
> 			}
> 		} else /* if (!a->non_resident) */ {
> -			if ((u8*)a + le16_to_cpu(a->data.resident.value_offset)
> -					+ le32_to_cpu(
> -					a->data.resident.value_length) >
> -					(u8*)ctx->mrec + vol->mft_record_size) {
> -				ntfs_error(vi->i_sb, "Corrupt attribute list "
> -						"in inode.");
> -				goto unm_err_out;
> -			}
> 			/* Now copy the attribute list. */
> 			memcpy(ni->attr_list, (u8*)a + le16_to_cpu(
> 					a->data.resident.value_offset),
> -- 
> 2.30.0
> 


-- 
Anton Altaparmakov <anton at tuxera.com> (replace at with @)
Lead in File System Development, Tuxera Inc., http://www.tuxera.com/
Linux NTFS maintainer

