Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86DCD3712BB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 10:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbhECI4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 04:56:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:60608 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233035AbhECI4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 04:56:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A6375B01F;
        Mon,  3 May 2021 08:55:09 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4B8BE1F2B6B; Mon,  3 May 2021 10:55:11 +0200 (CEST)
Date:   Mon, 3 May 2021 10:55:11 +0200
From:   Jan Kara <jack@suse.cz>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     syzbot <syzbot+7fbfe5fed73ebb675748@syzkaller.appspotmail.com>,
        jack@suse.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [syzbot] UBSAN: array-index-out-of-bounds in udf_statfs
Message-ID: <20210503085511.GB2994@quack2.suse.cz>
References: <000000000000683df205c1359d10@google.com>
 <272c7c70-9ea0-b7d0-5fa7-01f0c5650bd8@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <272c7c70-9ea0-b7d0-5fa7-01f0c5650bd8@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 02-05-21 20:03:46, Randy Dunlap wrote:
> Hi all--
> 
> On 4/30/21 12:28 PM, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    e77a830c Merge branch 'akpm' (patches from Andrew)
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=14c63e6dd00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=c0a6882014fd3d45
> > dashboard link: https://syzkaller.appspot.com/bug?extid=7fbfe5fed73ebb675748
> > compiler:       Debian clang version 11.0.1-2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17612825d00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=132cb56dd00000
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+7fbfe5fed73ebb675748@syzkaller.appspotmail.com
> > 
> > loop0: detected capacity change from 0 to 3974
> > UDF-fs: INFO Mounting volume 'LinuxUDF', timestamp 2020/09/19 18:44 (1000)
> > ================================================================================
> > UBSAN: array-index-out-of-bounds in fs/udf/super.c:2524:12
> > index 0 is out of range for type '__le32 [0]'
> 
> 
> Is this just due to (from fs/udf/ecma_167.h) the "[0]" struct items?
> Do they need to be "[]" instead?  Will that satisfy USBAN?
> 
> 
> /* Logical Volume Integrity Descriptor (ECMA 167r3 3/10.10) */
> struct logicalVolIntegrityDesc {
> 	struct tag		descTag;
> 	struct timestamp	recordingDateAndTime;
> 	__le32			integrityType;
> 	struct extent_ad	nextIntegrityExt;
> 	uint8_t			logicalVolContentsUse[32];
> 	__le32			numOfPartitions;
> 	__le32			lengthOfImpUse;
> 	__le32			freeSpaceTable[0]; // <<<<<<<<<<<<<<<<
> 	__le32			sizeTable[0]; // <<<<<<<<<<<<<<<<<<<
> 	uint8_t			impUse[0]; // <<<<<<<<<<<<<<<<<<<<<<<
> } __packed;
> 
> 
> (I ask because I cannot reproduce the problem -- maybe a bad GCC
> version?)

Well, checks for numOfPartitions and lengthOfImpUse are certainly missing
as well so maliciously corrupted filesystem (we have checksums for random
corruptions) could certainly cause bad access. I'll fix that. You have a
valid point that [0] arrays could confuse the compiler as well and
certainly are not the suggested way of doing stuff like this these days.
I'll get rid of those as well.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
