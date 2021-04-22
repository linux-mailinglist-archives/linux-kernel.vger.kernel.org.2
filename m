Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6AB0367826
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 05:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhDVEAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 00:00:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:42226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229441AbhDVEAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 00:00:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD9C460FE8;
        Thu, 22 Apr 2021 03:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619063986;
        bh=sOG50lQx/QyWi7j6X1avXiDvNEAO7rg4qaEucXSQ1Tw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t7ZL6RfSErQPWDiuAw4uHwdubQmq5UUdMNl9yY1psmQ2HkGEGp+aXIDrPz6srDEfy
         aQSN3Y4PnBuDYNrOsyZUVaRpiZ2+BkZlpiiiaxE2ikW1eFASKlWIob8zMukl5HDNdS
         IirlBf+BL2qYWpnMfCw/vbdNIkEGlXqopcGNlnfxurN9dO/s7AG7MrlwCaXsiFnPtg
         CqS7rDPI03c/MMyZCsaM3+HLPDlVl9Y3Hwwmbo2Zrfytq4rvZ17t0jz3KFS2Um1aZ8
         LXXrJuDN74Ktcbssv8ajY5HENCjX41Wm6KKZ5bZ9wUFcxb+zpyXGeqlSf96QJbADev
         SIH49g8EeZN+g==
Date:   Wed, 21 Apr 2021 20:59:44 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: compress: add compress_inode to
 cache compressed blockst
Message-ID: <YID0sDPrUxOJLz+A@google.com>
References: <20210202080056.51658-1-yuchao0@huawei.com>
 <46e9924c-0086-cd2a-2e93-7149b92ba27e@huawei.com>
 <YDsleDjeIcpuBXKA@google.com>
 <YEFBAuP26t0RzVHZ@google.com>
 <01a0ff76-6fa7-3196-8760-e7f6f163ef64@huawei.com>
 <YEa66ekikyuPWSyd@google.com>
 <a40929d4-a8de-98ea-8dd8-6c807d8a6adc@huawei.com>
 <YEkxpAp8FQjRUfm6@google.com>
 <157988c7-079f-0c9f-5cf9-e83bc2f835d1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157988c7-079f-0c9f-5cf9-e83bc2f835d1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/21, Chao Yu wrote:
> On 2021/3/11 4:52, Jaegeuk Kim wrote:
> > On 03/09, Chao Yu wrote:
> > > On 2021/3/9 8:01, Jaegeuk Kim wrote:
> > > > On 03/05, Chao Yu wrote:
> > > > > On 2021/3/5 4:20, Jaegeuk Kim wrote:
> > > > > > On 02/27, Jaegeuk Kim wrote:
> > > > > > > On 02/04, Chao Yu wrote:
> > > > > > > > Jaegeuk,
> > > > > > > > 
> > > > > > > > On 2021/2/2 16:00, Chao Yu wrote:
> > > > > > > > > -	for (i = 0; i < dic->nr_cpages; i++) {
> > > > > > > > > +	for (i = 0; i < cc->nr_cpages; i++) {
> > > > > > > > >      		struct page *page = dic->cpages[i];
> > > > > > > > 
> > > > > > > > por_fsstress still hang in this line?
> > > > > > > 
> > > > > > > I'm stuck on testing the patches, since the latest kernel is panicking somehow.
> > > > > > > Let me update later, once I can test a bit. :(
> > > > > > 
> > > > > > It seems this works without error.
> > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=4e6e1364dccba80ed44925870b97fbcf989b96c9
> > > > > 
> > > > > Ah, good news.
> > > > > 
> > > > > Thanks for helping to test the patch. :)
> > > > 
> > > > Hmm, I hit this again. Let me check w/o compress_cache back. :(
> > > 
> > > Oops :(
> > 
> > Ok, apprantely that panic is caused by compress_cache. The test is running over
> > 24hours w/o it.
> 
> Jaegeuk,
> 
> I'm still struggling troubleshooting this issue.
> 
> However, I failed again to reproduce this bug, I doubt the reason may be
> my test script and environment(device type/size) is different from yours.
> (btw, I used pmem as back-end device, and test w/ all fault injection
> points and w/o write_io/checkpoint fault injection points)
> 
> Could you please share me your run.sh script? and test command?
> 
> And I'd like to ask what's your device type and size?

I'm using qemu with 16GB with this script.
https://github.com/jaegeuk/xfstests-f2fs/blob/f2fs/run.sh

./run.sh por_fsstress

> 
> Thanks,
> 
> > .
> > 
