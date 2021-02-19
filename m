Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1705A31F3B9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 02:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhBSBzs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 18 Feb 2021 20:55:48 -0500
Received: from mgw-01.mpynet.fi ([82.197.21.90]:55090 "EHLO mgw-01.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhBSBzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 20:55:47 -0500
Received: from pps.filterd (mgw-01.mpynet.fi [127.0.0.1])
        by mgw-01.mpynet.fi (8.16.0.42/8.16.0.42) with SMTP id 11J1sWv7126920;
        Fri, 19 Feb 2021 03:54:32 +0200
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-01.mpynet.fi with ESMTP id 36t3dpg1bw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 03:54:32 +0200
Received: from tuxera-exch.ad.tuxera.com (10.20.48.11) by
 tuxera-exch.ad.tuxera.com (10.20.48.11) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 19 Feb 2021 03:54:31 +0200
Received: from tuxera-exch.ad.tuxera.com ([fe80::552a:f9f0:68c3:d789]) by
 tuxera-exch.ad.tuxera.com ([fe80::552a:f9f0:68c3:d789%12]) with mapi id
 15.00.1497.010; Fri, 19 Feb 2021 03:54:31 +0200
From:   Anton Altaparmakov <anton@tuxera.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Rustam Kovhaev <rkovhaev@gmail.com>
Subject: Re: [PATCH] ntfs: check for valid standard information attribute
Thread-Topic: [PATCH] ntfs: check for valid standard information attribute
Thread-Index: AQHXBUX43Bx0ygm+wEC4t5YdRoTv2qpemD8A
Date:   Fri, 19 Feb 2021 01:54:30 +0000
Message-ID: <42B686E5-92C1-4AD3-8CF4-E9AB39CBDB7B@tuxera.com>
References: <20210217155930.1506815-1-rkovhaev@gmail.com>
In-Reply-To: <20210217155930.1506815-1-rkovhaev@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [109.155.251.193]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <24CC84ECF93335439462256E65680542@ex13.tuxera.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-18_14:2021-02-18,2021-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 phishscore=0 spamscore=0 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102190009
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Can you please push this one upstream?  Thanks a lot in advance!

Best regards,

	Anton

> On 17 Feb 2021, at 15:59, Rustam Kovhaev <rkovhaev@gmail.com> wrote:
> 
> we should check for valid STANDARD_INFORMATION attribute offset and
> length before trying to access it
> 
> Reported-and-tested-by: syzbot+c584225dabdea2f71969@syzkaller.appspotmail.com
> Signed-off-by: Rustam Kovhaev <rkovhaev@gmail.com>
> Acked-by: Anton Altaparmakov <anton@tuxera.com>
> Link: https://syzkaller.appspot.com/bug?extid=c584225dabdea2f71969
> ---
> fs/ntfs/inode.c | 6 ++++++
> 1 file changed, 6 insertions(+)
> 
> diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
> index f7e4cbc26eaf..be4ff9386ec0 100644
> --- a/fs/ntfs/inode.c
> +++ b/fs/ntfs/inode.c
> @@ -629,6 +629,12 @@ static int ntfs_read_locked_inode(struct inode *vi)
> 	}
> 	a = ctx->attr;
> 	/* Get the standard information attribute value. */
> +	if ((u8 *)a + le16_to_cpu(a->data.resident.value_offset)
> +			+ le32_to_cpu(a->data.resident.value_length) >
> +			(u8 *)ctx->mrec + vol->mft_record_size) {
> +		ntfs_error(vi->i_sb, "Corrupt standard information attribute in inode.");
> +		goto unm_err_out;
> +	}
> 	si = (STANDARD_INFORMATION*)((u8*)a +
> 			le16_to_cpu(a->data.resident.value_offset));
> 
> -- 
> 2.30.0
> 


-- 
Anton Altaparmakov <anton at tuxera.com> (replace at with @)
Lead in File System Development, Tuxera Inc., http://www.tuxera.com/
Linux NTFS maintainer

