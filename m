Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2779C3B5B7D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 11:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbhF1Jnv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Jun 2021 05:43:51 -0400
Received: from mgw-02.mpynet.fi ([82.197.21.91]:49958 "EHLO mgw-02.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232488AbhF1Jnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 05:43:50 -0400
X-Greylist: delayed 1104 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Jun 2021 05:43:49 EDT
Received: from pps.filterd (mgw-02.mpynet.fi [127.0.0.1])
        by mgw-02.mpynet.fi (8.16.0.43/8.16.0.43) with SMTP id 15S9M979115613;
        Mon, 28 Jun 2021 12:22:26 +0300
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-02.mpynet.fi with ESMTP id 39f9xh82tp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 12:22:25 +0300
Received: from tuxera-exch.ad.tuxera.com (10.20.48.11) by
 tuxera-exch.ad.tuxera.com (10.20.48.11) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Mon, 28 Jun 2021 12:22:25 +0300
Received: from tuxera-exch.ad.tuxera.com ([fe80::552a:f9f0:68c3:d789]) by
 tuxera-exch.ad.tuxera.com ([fe80::552a:f9f0:68c3:d789%12]) with mapi id
 15.00.1497.018; Mon, 28 Jun 2021 12:22:25 +0300
From:   Anton Altaparmakov <anton@tuxera.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        "syzbot+213ac8bb98f7f4420840@syzkaller.appspotmail.com" 
        <syzbot+213ac8bb98f7f4420840@syzkaller.appspotmail.com>
Subject: Re: [PATCH] ntfs: Fix validity check for file name attribute
Thread-Topic: [PATCH] ntfs: Fix validity check for file name attribute
Thread-Index: AQHXYNr9xtdXtYfpBEGmty8mpcDGlaspCjOA
Date:   Mon, 28 Jun 2021 09:22:24 +0000
Message-ID: <F53B518A-A1D4-4ED3-9339-4625CAD98B2F@tuxera.com>
References: <20210614050540.289494-1-desmondcheongzx@gmail.com>
In-Reply-To: <20210614050540.289494-1-desmondcheongzx@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [86.134.197.70]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <99C2CF21868B1447B5C705333F109AC2@ex13.tuxera.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-GUID: Vo0XTbXZ_dePF2syDtdnkrOgOV9_0Wl2
X-Proofpoint-ORIG-GUID: Vo0XTbXZ_dePF2syDtdnkrOgOV9_0Wl2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-28_07:2021-06-25,2021-06-28 signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106280065
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Please can you merge this patch?  I am also marking it for stable.

Thanks a lot in advance!

Best regards,

	Anton

---

When checking the file name attribute, we want to ensure that it fits
within the bounds of ATTR_RECORD. To do this, we should check
that (attr record + file name offset + file name length) < (attr
record + attr record length).

However, the original check did not include the file name offset in
the calculation. This means that corrupted on-disk metadata might not
caught by the incorrect file name check, and lead to an invalid memory
access.

An example can be seen in the crash report of a memory corruption
error found by Syzbot:
https://syzkaller.appspot.com/bug?id=a1a1e379b225812688566745c3e2f7242bffc246

Adding the file name offset to the validity check fixes this error and
passes the Syzbot reproducer test.

Reported-by: syzbot+213ac8bb98f7f4420840@syzkaller.appspotmail.com
Tested-by: syzbot+213ac8bb98f7f4420840@syzkaller.appspotmail.com
Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Acked-by: Anton Altaparmakov <anton@tuxera.com>
Cc: stable@vger.kernel.org
---
fs/ntfs/inode.c | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index f5c058b3192c..4474adb393ca 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -477,7 +477,7 @@ static int ntfs_is_extended_system_file(ntfs_attr_search_ctx *ctx)
		}
		file_name_attr = (FILE_NAME_ATTR*)((u8*)attr +
				le16_to_cpu(attr->data.resident.value_offset));
-		p2 = (u8*)attr + le32_to_cpu(attr->data.resident.value_length);
+		p2 = (u8 *)file_name_attr + le32_to_cpu(attr->data.resident.value_length);
		if (p2 < (u8*)attr || p2 > p)
			goto err_corrupt_attr;
		/* This attribute is ok, but is it in the $Extend directory? */
-- 
2.25.1



-- 
Anton Altaparmakov <anton at tuxera.com> (replace at with @)
Lead in File System Development, Tuxera Inc., http://www.tuxera.com/
Linux NTFS maintainer

