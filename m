Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B0E3BC5F6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 07:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhGFFPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 01:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbhGFFPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 01:15:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB942C061574;
        Mon,  5 Jul 2021 22:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HL8TXzIMAEiDs6New4fpmFiNo+lUInfaBflRDKvoc5k=; b=Qqqd5AK6Xkl+I69DpgFLrt62cS
        irSXMGizexUgIJpRLMozac0yiTiKfkl+RqrMjK5r2HjQU8ufQQ0O1zrZu9uDmxmNRsKRsgg4u4TMB
        1pQuwNXfkdf1DXCoMkOniI71yUgy9/g1nSppJ6OKxoI7BQVQIWoJHz21LOt0cAc696R6r06SF25uV
        8Xhv9aBWOFu3JgM1tQi6gGYdqU7h3BSVLXSai43OxDyCHT7OwxgRlA+3KMTSf9NstDnHuCmicMVRr
        r/c7SFMwFZSFNuDYaVYFxhhz6TWgQ8x4wgyijn85M5cBqp5snoJSMGK1WHo7l2YRv8066aWZ4940U
        ze2anFgw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0dNZ-00Ar8t-QF; Tue, 06 Jul 2021 05:12:24 +0000
Date:   Tue, 6 Jul 2021 06:12:17 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Rajat Asthana <thisisrast7@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Rajat Asthana <rajatasthana4@gmail.com>, axboe@kernel.dk,
        damien.lemoal@wdc.com, jack@suse.cz, rafael@kernel.org,
        syzbot+7d6c5587ec9cff5be65c@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com,
        linux-block@vger.kernel.org, hare@suse.de,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] block: Avoid accessing an already freed kobject in
 delete_partition
Message-ID: <YOPmMZdMQgXAyEMO@infradead.org>
References: <20210702231228.261460-1-rajatasthana4@gmail.com>
 <YN/1DOeSA5ODf1AV@infradead.org>
 <0c623d71-6d99-2e0d-4d8b-63a1ff814dc1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c623d71-6d99-2e0d-4d8b-63a1ff814dc1@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021 at 06:31:11AM +0530, Rajat Asthana wrote:
> 
> 
> On 03/07/21 10:56 am, Christoph Hellwig wrote:
> > This should be fixed properly by:
> > 
> > "block: check disk exist before trying to add partition"
> 
> Hi Christoph, thanks a lot for suggesting this fix. I have been
> working on implementing this and have tried the following:
> - I checked if the the kobject of device structure embedded in
>   gendisk structure is not NULL, to add the partition.
>   This didn't work.
> 
> - Then I checked the if kobject of the block_device struct (part0)
>   embedded in the gendisk struct is not NULL, to add the partition.
>   This also didn't work.
> 
> - Then I checked the i_state of the bd_inode field of block_device
>   struct embedded in the gendisk struct. I checked if the I_FREEING or
>   I_WILL_FREE fields are not set. The reason behind doing this was
>   to confirm that we only create partition on the disks which are not
>   being freed.
> 
> Am I going in the right direction? Can you point me to the correct
> direction if I am not?

No.  There should be no need to check anything, but the code needs
to ensure that the block device is alive.  I think the above mentioned
patch (now in Jens' tree) does that, so please try it.
