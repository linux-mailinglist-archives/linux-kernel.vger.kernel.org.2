Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 275A9321A57
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 15:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbhBVO2H convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 22 Feb 2021 09:28:07 -0500
Received: from mgw-02.mpynet.fi ([82.197.21.91]:36122 "EHLO mgw-02.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231601AbhBVOUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 09:20:02 -0500
Received: from pps.filterd (mgw-02.mpynet.fi [127.0.0.1])
        by mgw-02.mpynet.fi (8.16.0.42/8.16.0.42) with SMTP id 11MEH0wD032555;
        Mon, 22 Feb 2021 16:18:51 +0200
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-02.mpynet.fi with ESMTP id 36tq071dhd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 22 Feb 2021 16:18:51 +0200
Received: from tuxera-exch.ad.tuxera.com (10.20.48.11) by
 tuxera-exch.ad.tuxera.com (10.20.48.11) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 22 Feb 2021 16:18:50 +0200
Received: from tuxera-exch.ad.tuxera.com ([fe80::552a:f9f0:68c3:d789]) by
 tuxera-exch.ad.tuxera.com ([fe80::552a:f9f0:68c3:d789%12]) with mapi id
 15.00.1497.010; Mon, 22 Feb 2021 16:18:50 +0200
From:   Anton Altaparmakov <anton@tuxera.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Rustam Kovhaev <rkovhaev@gmail.com>
Subject: Re: [PATCH] ntfs: check for valid standard information attribute
Thread-Topic: [PATCH] ntfs: check for valid standard information attribute
Thread-Index: AQHXBUX43Bx0ygm+wEC4t5YdRoTv2qpemD8AgAEbtgCABGs/AA==
Date:   Mon, 22 Feb 2021 14:18:50 +0000
Message-ID: <A4498E63-33DC-4DAA-837D-D97B8F29F70C@tuxera.com>
References: <20210217155930.1506815-1-rkovhaev@gmail.com>
 <42B686E5-92C1-4AD3-8CF4-E9AB39CBDB7B@tuxera.com>
 <20210219104956.09e869c36f065a78d1901725@linux-foundation.org>
In-Reply-To: <20210219104956.09e869c36f065a78d1901725@linux-foundation.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [109.155.251.193]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E0CA92CF3C57764CBAD62349D499E051@ex13.tuxera.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-22_02:2021-02-22,2021-02-22 signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 phishscore=0 adultscore=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220132
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Sorry for the delay in replying.

> On 19 Feb 2021, at 18:49, Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> On Fri, 19 Feb 2021 01:54:30 +0000 Anton Altaparmakov <anton@tuxera.com> wrote:
> 
>> Hi Andrew,
>> 
>> Can you please push this one upstream?  Thanks a lot in advance!
> 
> The changelog is a bit brief...

Yes you are right it is a bit brief.  I guess I thought the syzkaller link was sufficient...  Rustam would you like to resubmit with an improved/extended description?

>>> On 17 Feb 2021, at 15:59, Rustam Kovhaev <rkovhaev@gmail.com> wrote:
>>> 
>>> we should check for valid STANDARD_INFORMATION attribute offset and
>>> length before trying to access it
> 
> It's a kernel a crash and I assume it results from mounting a corrupted
> filesystem?
> 
> I think it's worth a cc:stable, yes?

The problem is an invalid memory access due to corrupt on-disk metadata.

The issue with NTFS is that it is effectively a relational database so it is full of "struct X, field A" contains offset to "struct Y" so you get: "&struct Y = &struct X + X->A" and if the value of A is corrupt on-disk then your Y pointer is now pointing to random memory.

The patch fixes one such place by validating that Y pointer is within bounds of the structure/buffer it is in.

So I guess this could be worth a cc:stable?  I guess we can add it and Greg / others can decide whether to put it into stable or not...  Rustam when resubmitting with better description, please also add the "Cc: stable@vger.kernel.org" line together with the "Signed-off-by", etc lines (note no need to actually put this in CC: field of the email iteslf).

Best regards,

	Anton
-- 
Anton Altaparmakov <anton at tuxera.com> (replace at with @)
Lead in File System Development, Tuxera Inc., http://www.tuxera.com/
Linux NTFS maintainer

