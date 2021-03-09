Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B557C331DC5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 05:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhCIEDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 23:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhCIECj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 23:02:39 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15F2C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 20:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iM+/dn+YhIAlWAYAVQcoqGr6ZVF7ceWPf6AbVrGnBfA=; b=OUj945fp0c25Ck1x1CORIjI7y6
        uxhLXajEd83UoACqAIgCF/aJsafBbA3E/oQxWukhEUctxbGmAFCJxd1UETGApes1n/nBXjkTCOxeF
        KvlOQzcwbKscc3/4essTpANC3nKPpZBq3Nk5G+zLCmWKBYA1wnh+pkJfOVwsa87mksG4tCv5lMwUo
        SLh+TtNEb5/W4aJE5T0m4Mf4FlysP1hlG5LPoUJthuk793Ckev5Dr2je4AsMRb1FKF4xOhp3M39TY
        SAOO61+7sbjuCE8nZyUCAkGdDxur8vlS0cplB9nFuFUgenR3eHzQW3dmWrwiOlScZSRRu7nx5JIvj
        S0bINp6w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lJTZ2-00HLCQ-Bk; Tue, 09 Mar 2021 04:01:53 +0000
Date:   Tue, 9 Mar 2021 04:01:44 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Weichao Guo <guoweichao@oppo.com>
Cc:     rpalethorpe@suse.de, kernel test robot <oliver.sang@intel.com>,
        "huangjianan@oppo.com" <huangjianan@oppo.com>, lkp@intel.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, ltp@lists.linux.it
Subject: Re: [LTP] [f2fs] 02eb84b96b: ltp.swapon03.fail
Message-ID: <20210309040144.GH3479805@casper.infradead.org>
References: <20210308072510.GA902@xsang-OptiPlex-9020>
 <87h7llhnfe.fsf@suse.de>
 <c75229cc-e325-1c8b-0afa-fd236db8319c@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c75229cc-e325-1c8b-0afa-fd236db8319c@oppo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 10:23:35AM +0800, Weichao Guo wrote:
> Hi Richard,
> 
> On 2021/3/8 19:53, Richard Palethorpe wrote:
> > Hello,
> > 
> > > kern  :err   : [  187.461914] F2FS-fs (sda1): Swapfile does not align to section
> > > commit 02eb84b96bc1b382dd138bf60724edbefe77b025
> > > Author: huangjianan@oppo.com <huangjianan@oppo.com>
> > > Date:   Mon Mar 1 12:58:44 2021 +0800
> > >      f2fs: check if swapfile is section-alligned
> > >      If the swapfile isn't created by pin and fallocate, it can't be
> > >      guaranteed section-aligned, so it may be selected by f2fs gc. When
> > >      gc_pin_file_threshold is reached, the address of swapfile may change,
> > >      but won't be synchronized to swap_extent, so swap will write to wrong
> > >      address, which will cause data corruption.
> > >      Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> > >      Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> > >      Reviewed-by: Chao Yu <yuchao0@huawei.com>
> > >      Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > The test uses fallocate to preallocate the swap file and writes zeros to
> > it. I'm not sure what pin refers to?
> 
> 'pin' refers to pinned file feature in F2FS, the LBA(Logical Block Address)
> of a file is fixed after pinned. Without this operation before fallocate,
> the LBA may not align with section(F2FS GC unit), some LBA of the file may
> be changed by F2FS GC in some extreme cases.
> 
> For this test case, how about pin the swap file before fallocate for F2FS as
> following:
> 
> ioctl(fd, F2FS_IOC_SET_PIN_FILE, true);

No special ioctl should be needed.  f2fs_swap_activate() should pin the
file, just like it converts inline inodes and disables compression.
