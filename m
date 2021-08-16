Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964FE3ED1B4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 12:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbhHPKMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 06:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbhHPKMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 06:12:41 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66059C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 03:12:09 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id f5so22711797wrm.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 03:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=/Xw0w3UumgW2mMQhotzUeGKDXtTAf814g5ImZXZMSUU=;
        b=r4q56nvxlILzVmJM+4o3pcJYZmcz6dS7vOR5e5DEe7vYuq6yXpIp8CSEVIQuwUFyRg
         4w//Gnwm5TEEm6XxxlqChOI4cDxdGGNvEpfDUkYB27Hgp4wKbhFZMrRBCerr5Mdd0Wcj
         LsoePaL2AkwcoXkxzlEse6i4D2qtT8HkwZh8K5x4wARGT6ZY7hfBi93APMel/iUvdfS6
         uzGvyi1ZK0ztDs4HIIJSQlpviQsyCdmCZkPBv9dqCR6oNeDAZSIKJ7slaWKKlccsa6GR
         E23nwGDWVRMLeQihKn+AUHR4voWbp14dCI8Wn6tsTVkgzzeCfNEPVZ/xN1OLFw89xccs
         1Pxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=/Xw0w3UumgW2mMQhotzUeGKDXtTAf814g5ImZXZMSUU=;
        b=ZRPaKatTUKBF6SoS/z8vHP+fIGLXG0wccZob1xXDikyFCcid94U2jlWLVmHe9gM34N
         MWtQ27Zxw9UfmP75BeJAdug6ldZadayDtEHAVb2Jgr/FW2wm0XA97WjJzmaNBnSsyLm9
         awTGriSz4We4bD5DYBIIFFwfN11RIXEm+8ZX2iGOySOqt953+9slPy5Cv0cXgIqTzzQC
         jyiR28OZSrDXXniUwzJdd+o4UaqkFzXYAXBf+atv5RhBQDVr+ommxNdgvNOpvi/80J1+
         vxnEglJK0oCTkUCDxgxM50i5byKaniesiatvYrQI9o8yQAYYrYTonaT1eMmoxZ1hlYxs
         sDPw==
X-Gm-Message-State: AOAM5322we3OhTA8oD2+IGePE1Y8v2IimMxDtXDGNBOLxRpuBfotBZ7z
        aeID8hOVR1Rxckm4E1eVogLIEg==
X-Google-Smtp-Source: ABdhPJwupi42NaXOB8VmG0JKkps3S9A6p0zAzW0nYNFE9rTtQAtU2SNR+PoPc7+faRwX24NyUfPJLg==
X-Received: by 2002:adf:e507:: with SMTP id j7mr18100703wrm.113.1629108727841;
        Mon, 16 Aug 2021 03:12:07 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:4ab8:21c4:bd1f:eac2])
        by smtp.gmail.com with ESMTPSA id q17sm10702152wrr.91.2021.08.16.03.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 03:12:07 -0700 (PDT)
Date:   Mon, 16 Aug 2021 12:12:01 +0200
From:   Marco Elver <elver@google.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: LKMM: Read dependencies of writes ordered by dma_wmb()?
Message-ID: <YRo58c+JGOvec7tc@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Commit c58a801701693 added a paragraph to the LKMM:

	+Although we said that plain accesses are not linked by the ppo
	+relation, they do contribute to it indirectly.  Namely, when there is
	+an address dependency from a marked load R to a plain store W,
	+followed by smp_wmb() and then a marked store W', the LKMM creates a
	+ppo link from R to W'.

Defining that certain _marked reads_ will also be ordered by smp_wmb().
But otherwise, other reads (especially plain reads!) will _never_ be
ordered by smp_wmb(). Is my understanding correct?

I am asking because KCSAN is growing limited support for weak memory
modeling and memory barriers, and I'm trying to figure out if I'm seeing
a false positive or genuinely allowed race.

One caveat is the case I'm trying to understand doesn't involve just 2
CPUs but also a device. And for now, I'm assuming that dma_wmb() is as
strong as smp_wmb() also wrt other CPUs (but my guess is this
assumption is already too strong).

The whole area of the memory model that includes talking to devices and
devices talking back to CPUs seems quite murky, and need to confirm that
I either got it right or wrong. :-)

The report (explained below):

| assert no accesses to 0xffff8880077b5500 of 232 bytes by interrupt on cpu 1:
|  __cache_free mm/slab.c:3450 [inline]
|  kmem_cache_free+0x4b/0xe0 mm/slab.c:3740
|  kfree_skbmem net/core/skbuff.c:709 [inline]
|  __kfree_skb+0x145/0x190 net/core/skbuff.c:745
|  consume_skb+0x6d/0x190 net/core/skbuff.c:900
|  __dev_kfree_skb_any+0xb8/0xc0 net/core/dev.c:3195
|  dev_kfree_skb_any include/linux/netdevice.h:3979 [inline]
|  e1000_unmap_and_free_tx_resource drivers/net/ethernet/intel/e1000/e1000_main.c:1969 [inline]
|  e1000_clean_tx_irq drivers/net/ethernet/intel/e1000/e1000_main.c:3859 [inline]
|  e1000_clean+0x302/0x2080 drivers/net/ethernet/intel/e1000/e1000_main.c:3800
|  __napi_poll+0x81/0x430 net/core/dev.c:7019
|  napi_poll net/core/dev.c:7086 [inline]
|  net_rx_action+0x2cf/0x6b0 net/core/dev.c:7173
|  __do_softirq+0x12c/0x275 kernel/softirq.c:558
| [...]
| 
| read (reordered) to 0xffff8880077b5570 of 4 bytes by task 1985 on cpu 0:
|  skb_headlen include/linux/skbuff.h:2139 [inline]
|  e1000_tx_map drivers/net/ethernet/intel/e1000/e1000_main.c:2829 [inline]
|  e1000_xmit_frame+0x12fd/0x2720 drivers/net/ethernet/intel/e1000/e1000_main.c:3243
|  __netdev_start_xmit include/linux/netdevice.h:4944 [inline]
|  netdev_start_xmit include/linux/netdevice.h:4958 [inline]
|  xmit_one+0x103/0x2c0 net/core/dev.c:3658
|  dev_hard_start_xmit+0x70/0x130 net/core/dev.c:3674
|  sch_direct_xmit+0x1e5/0x600 net/sched/sch_generic.c:342
|  __dev_xmit_skb net/core/dev.c:3874 [inline]
|  __dev_queue_xmit+0xd26/0x1990 net/core/dev.c:4241
|  dev_queue_xmit+0x1d/0x30 net/core/dev.c:4306
| [...]
|   |
|   +-> reordered to: e1000_xmit_frame+0x2294/0x2720 drivers/net/ethernet/intel/e1000/e1000_main.c:3282

KCSAN is saying there is a potential use-after-free read of an skb due
to the read to 0xffff8880077b5570 potentially being delayed/reordered
later. If the memory was reallocated and reused concurrently, the read
could read garbage data:

1.	The e1000 driver is being instructed to transmit in
	e1000_xmit_frame(). Here it uses the data in the skb in various
	places (e.g. in skb_headlen() above) to set up a new element in
	the ring buffer to be consumed by the device via DMA.

2.	Eventually it calls e1000_tx_queue(), which seems to publish the
	next entry into the ring buffer and finally calls dma_wmb().
	Until this point I see no other barriers (although there's a
	writel(), but it doesn't always seem to be called).

3.	e1000_clean_tx_irq() is called on another CPU after transmit
	completes, and we know the device has consumed that entry from
	the ring buffer. At this point the driver then says that the
	associated skb can be kfree()'d.

4.	If I interpreted dma_wmb() (and smp_wmb()) right, plain reads
	may be reordered after it, irrespective if a write that depended
	on such reads was ordered by the wmb(). Which means the
	reordering of the plain reads accessing the skb before it may in
	fact happen concurrently with the kfree() of skb if reordered
	after. For example reordered to the very end of
	e1000_xmit_frame() (line 3282) as KCSAN simulated in this case.

Is the above result allowed by the kernel's memory model?

In practice, my guess is no compiler and architecture combination would
allow this today; or is there an arch where it could?

Thanks,
-- Marco
