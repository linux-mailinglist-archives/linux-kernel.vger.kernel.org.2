Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10442455234
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 02:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242253AbhKRBah convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 17 Nov 2021 20:30:37 -0500
Received: from mgw-01.mpynet.fi ([82.197.21.90]:60792 "EHLO mgw-01.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236932AbhKRBac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 20:30:32 -0500
Received: from pps.filterd (mgw-01.mpynet.fi [127.0.0.1])
        by mgw-01.mpynet.fi (8.16.0.43/8.16.0.43) with SMTP id 1AI1HnAn018748;
        Thu, 18 Nov 2021 03:26:45 +0200
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-01.mpynet.fi with ESMTP id 3cd927829e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 18 Nov 2021 03:26:45 +0200
Received: from tuxera-exch.ad.tuxera.com (10.20.48.11) by
 tuxera-exch.ad.tuxera.com (10.20.48.11) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Thu, 18 Nov 2021 03:26:45 +0200
Received: from tuxera-exch.ad.tuxera.com ([fe80::552a:f9f0:68c3:d789]) by
 tuxera-exch.ad.tuxera.com ([fe80::552a:f9f0:68c3:d789%12]) with mapi id
 15.00.1497.026; Thu, 18 Nov 2021 03:26:44 +0200
From:   Anton Altaparmakov <anton@tuxera.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Guenter Roeck <linux@roeck-us.net>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>
Subject: Re: Linux 5.16-rc1
Thread-Topic: Linux 5.16-rc1
Thread-Index: AQHX2/BjbW+RzRGIzUCKxFRR/7nEBawIPJyAgAAQdgCAABA3AA==
Date:   Thu, 18 Nov 2021 01:26:44 +0000
Message-ID: <E1EED1BE-A0F0-4EFA-86A6-CF721E194CDC@tuxera.com>
References: <CAHk-=wjF=JzLkCi2wV+G=f8OWa5rNjPsZd2RMFG5MHwKZPgYvw@mail.gmail.com>
 <20211115045616.GA1012538@roeck-us.net>
 <CAHk-=whca4JrEExUZCf+iGhP+mV-_D2uyqiFHnaYqnfCOKyEVg@mail.gmail.com>
 <652edea7-28a0-70d9-c63f-d910b5942454@roeck-us.net>
 <87a6i4miwu.fsf@mpe.ellerman.id.au>
 <CAMuHMdVrpQJKKzpxrKKCCD_2+DzAvgFW+jsjPdR9JhBYeRgvNw@mail.gmail.com>
 <8D79B547-D606-4975-A79A-AEA65684F3A0@tuxera.com>
 <CAHk-=wgvzH=BaFg+kiWk1DXGLNELSmPS2VWcgSSmW5Y6vz-v_A@mail.gmail.com>
In-Reply-To: <CAHk-=wgvzH=BaFg+kiWk1DXGLNELSmPS2VWcgSSmW5Y6vz-v_A@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [81.154.174.177]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3944990A7630BC4CACC6C96A27942B11@ex13.tuxera.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-GUID: Jfv-9ZTBZae7cukbCOGLnOFMQdd8Zf4T
X-Proofpoint-ORIG-GUID: Jfv-9ZTBZae7cukbCOGLnOFMQdd8Zf4T
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2021-11-17_09:2021-11-17,2021-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 mlxlogscore=705 bulkscore=0
 adultscore=0 spamscore=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111180006
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

> On 18 Nov 2021, at 00:28, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> On Wed, Nov 17, 2021 at 3:29 PM Anton Altaparmakov <anton@tuxera.com> wrote:
>> 
>> What we need here is an array to store pointers to in-memory inodes that correspond to inodes in the inode table page being written out.
> 
> Do we actually need the array?
> 
> The ntfs_inode pointers in that array are always locked (using
> 'mrec_lock'), so ti could be just a linked list of entries.
> 
> Yeah, that would require adding a 'next' pointer to 'struct
> _ntfs_inode', but maybe that would be the right thing to do?
> 
> I don't know the code, but it looks to me like it's literally just a
> stack of locked ntfs_inode pointers - where the lock is taken before
> adding it to the stack, and released after taking it off the stack. So
> a singly-linked list would seem to be a very simple implementation.

Thanks for the idea.  Yes, you are correct.  That would be a viable alternative at the cost of that extra pointer in the ntfs_inode structure.

I am concerned that whilst this would fix this compiler warning, we have other such arrays in fs/ntfs/mft.c::write_mft_record_nolock() and ntfs_sync_mft_mirror() where in each of those functions we have:

	struct buffer_head *bhs[MAX_BHS];

And at the top of mft.c we have:

	#define MAX_BHS (PAGE_SIZE / NTFS_BLOCK_SIZE)

So those arrays are each the same size as the one the compiler warns about in fs/ntfs/aops.c::ntfs_write_mst_block() where we have:

	ntfs_inode *locked_nis[PAGE_SIZE / NTFS_BLOCK_SIZE];

So is it worth doing the singly linked list to fix one file only to have compilation fail a few files later when it gets to mft.c?

Best regards,

	Anton
-- 
Anton Altaparmakov <anton at tuxera.com> (replace at with @)
Lead in File System Development, Tuxera Inc., http://www.tuxera.com/
Linux NTFS maintainer

