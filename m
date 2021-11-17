Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF2C45513B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 00:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241675AbhKQXo7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 17 Nov 2021 18:44:59 -0500
Received: from mgw-01.mpynet.fi ([82.197.21.90]:46480 "EHLO mgw-01.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241656AbhKQXo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 18:44:58 -0500
X-Greylist: delayed 684 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Nov 2021 18:44:57 EST
Received: from pps.filterd (mgw-01.mpynet.fi [127.0.0.1])
        by mgw-01.mpynet.fi (8.16.0.43/8.16.0.43) with SMTP id 1AHNCgLI102835;
        Thu, 18 Nov 2021 01:29:49 +0200
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-01.mpynet.fi with ESMTP id 3cd92781d3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 18 Nov 2021 01:29:48 +0200
Received: from tuxera-exch.ad.tuxera.com (10.20.48.11) by
 tuxera-exch.ad.tuxera.com (10.20.48.11) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Thu, 18 Nov 2021 01:29:48 +0200
Received: from tuxera-exch.ad.tuxera.com ([fe80::552a:f9f0:68c3:d789]) by
 tuxera-exch.ad.tuxera.com ([fe80::552a:f9f0:68c3:d789%12]) with mapi id
 15.00.1497.026; Thu, 18 Nov 2021 01:29:48 +0200
From:   Anton Altaparmakov <anton@tuxera.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Michael Ellerman <mpe@ellerman.id.au>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>
Subject: Re: Linux 5.16-rc1
Thread-Topic: Linux 5.16-rc1
Thread-Index: AQHX2/BjbW+RzRGIzUCKxFRR/7nEBawIPJyA
Date:   Wed, 17 Nov 2021 23:29:47 +0000
Message-ID: <8D79B547-D606-4975-A79A-AEA65684F3A0@tuxera.com>
References: <CAHk-=wjF=JzLkCi2wV+G=f8OWa5rNjPsZd2RMFG5MHwKZPgYvw@mail.gmail.com>
 <20211115045616.GA1012538@roeck-us.net>
 <CAHk-=whca4JrEExUZCf+iGhP+mV-_D2uyqiFHnaYqnfCOKyEVg@mail.gmail.com>
 <652edea7-28a0-70d9-c63f-d910b5942454@roeck-us.net>
 <87a6i4miwu.fsf@mpe.ellerman.id.au>
 <CAMuHMdVrpQJKKzpxrKKCCD_2+DzAvgFW+jsjPdR9JhBYeRgvNw@mail.gmail.com>
In-Reply-To: <CAMuHMdVrpQJKKzpxrKKCCD_2+DzAvgFW+jsjPdR9JhBYeRgvNw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [81.154.174.177]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <53BF050F6FBEF9418ADDED7492B03C67@ex13.tuxera.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-GUID: jSQBxUkpt5SZayFWF0_0dtLBpC1LBY1o
X-Proofpoint-ORIG-GUID: jSQBxUkpt5SZayFWF0_0dtLBpC1LBY1o
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2021-11-17_09:2021-11-17,2021-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 spamscore=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111170108
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

> On 17 Nov 2021, at 20:18, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Michael,
> On Tue, Nov 16, 2021 at 12:39 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Guenter Roeck <linux@roeck-us.net> writes:
>>> fs/ntfs/aops.c: In function 'ntfs_write_mst_block':
>>> fs/ntfs/aops.c:1311:1: error: the frame size of 2240 bytes is larger than 2048 bytes
>>> 
>>> Bisect points to commit f22969a6604 ("powerpc/64s: Default to 64K pages for
>>> 64 bit book3s"), and reverting that commit does fix the problem.
>>> The problem is
>>>      ntfs_inode *locked_nis[PAGE_SIZE / NTFS_BLOCK_SIZE];
>>> 
>>> I don't see the problem in next-20211115, but I don't immediately see how it was fixed there.
>> 
>> I still see it in next.
>> 
>> I don't know what to do about it though. The NTFS folks presumably don't
>> want to rewrite their code to avoid a warning on powerpc, we have no
>> real interest in NTFS, and definitely no expertise in the NTFS code. We
>> don't want to revert the 64K change, and even if we did the warning
>> would still be there for other 64K page configs.
> 
> Do you have a pointer to that discussion? I couldn't find it.
> 
> Why does the ntfs code have a need to allocate an array
> (regardless whether it's on the stack or not) with a size related to
> PAGE_SIZE? Shouldn't the array's size be related to a parameter of
> the file system on the storage device, instead of a parameter of the
> system it is running on?

Yes and no.  (-:  As always the devil is in the details.

What you would know of as the inode table in a traditional Linux file system is in NTFS an actual file on disk and we access it via the page cache.  What we need here is an array to store pointers to in-memory inodes that correspond to inodes in the inode table page being written out.  We used to have a specific array using the per-filesystem parameteres but because those are variable (e.g. an inode can be 1024 bytes or it can be 4096 bytes depending on your sector size and also depending on how you format the volume in Windows) thus the array was a dynamically sized array.  This at some point in time was frowned upon so a commit was made to change the dynamically sized array to a statically/constant sized one.  To do that the maximum possible size had to be used and that means using NTFS_BLOCK_SIZE as the inode size (that is 512 bytes constant).  This then means that the number of inodes that can be present in a page is at most PAGE_SIZE / NTFS_BLOCK_SIZE and thus this is the size of the array.  The correct array size would be PAGE_SIZE / vol->mft_record_size and with MFT record size normally being 1024 bytes or on 4k sector disks usually 4096 bytes the array we actually need is normally either half or an eight of the size we actually allocate with the PAGE_SIZE / NTFS_BLOCK_SIZE but there is no helping that if we want it to be statically/constant sized array.

Unless that particular kernel can support such small stack sizes I think the solution would be to simply modify the frame size warning not to complain until a bigger size, maybe 3kiB instead of 2kiB or something and that warning would not happen any more.

Best regards,

	Anton
-- 
Anton Altaparmakov <anton at tuxera.com> (replace at with @)
Lead in File System Development, Tuxera Inc., http://www.tuxera.com/
Linux NTFS maintainer

