Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989C4425235
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 13:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241089AbhJGLpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 07:45:50 -0400
Received: from first.geanix.com ([116.203.34.67]:37342 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230091AbhJGLpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 07:45:49 -0400
Received: from skn-laptop (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 2D7CFC38AD;
        Thu,  7 Oct 2021 11:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1633607033; bh=tGOv96CmxfPCWNX+fP5w3IPJ826kr0pX+QTLBAEyfMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=d3v9mOJiEKq3Da4jxgpms5lSzfw1TT0oPw2CDqwQd1zh7t3Fs87Hje8lRRWD5rtJ6
         czUsZbiH/BCEr+QGOZZfvY2sYcEmltPHfXCppcDa0MDLpv7p76u2BmkV2hY1henf1V
         53mn0o7yW3CyWcPhAO4zm3wShfxuHlGA3mYn7YcXgYZbhefR11yd9Zaw9JYZhiwW5n
         e2LHZCf7ISxH7C7ZiVtlBBiqDctt2scc9hnjxMlJziiUbhntDMPKEOv4WNHeGIKo3N
         mHqwW5Ty0aci2yzH3bQEJKmYBsFXLbx9Pz6iNUjPQoc5KTVua4iEpafpACQ0zo/lHC
         9d3SzDw+Pi+Jg==
Date:   Thu, 7 Oct 2021 13:43:51 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mtd: rawnand: use mutex to protect access while in
 suspend
Message-ID: <20211007114351.3nafhtpefezxhanc@skn-laptop>
References: <20211004065608.3190348-1-sean@geanix.com>
 <20211004104147.579f3b01@collabora.com>
 <20211004085509.iikxtdvxpt6bri5c@skn-laptop>
 <20211004115817.18739936@collabora.com>
 <20211004101246.kagtezizympxupat@skn-laptop>
 <20211004134700.26327f6f@collabora.com>
 <20211005070930.epgxb5qzumk4awxq@skn-laptop>
 <20211005102300.5da6d480@collabora.com>
 <20211005084938.jcbw24umhehoiirs@skn-laptop>
 <20211005105836.6c300f25@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211005105836.6c300f25@collabora.com>
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on 13e2a5895688
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 10:58:36AM +0200, Boris Brezillon wrote:
> On Tue, 5 Oct 2021 10:49:38 +0200
> Sean Nyekjaer <sean@geanix.com> wrote:
> 
> > On Tue, Oct 05, 2021 at 10:23:00AM +0200, Boris Brezillon wrote:
> > > On Tue, 5 Oct 2021 09:09:30 +0200
> > > Sean Nyekjaer <sean@geanix.com> wrote:  
> > 
> > [ ... ]
> > 
> > > > 
> > > > Have you seen the reproducer script?  
> > > 
> > > How would I know about this script or your previous attempt (mentioned
> > > at the end of this email) given I was not Cc-ed on the previous
> > > discussion, and nothing mentions it in this RFC...
> > >   
> > 
> > That's why I shared it here ;)
> > Initially I thought this was a bug introduced by exec_op.
> > 
> > > > ---
> > > > root@iwg26-v1:/data/root# cat /data/crash.sh
> > > > #!/bin/sh -x
> > > > 
> > > > echo enabled > /sys/devices/platform/soc/2100000.bus/21f4000.serial/tty/ttymxc4/power/wakeup
> > > > 
> > > > rm /data/test50M
> > > > dd if=/dev/urandom of=/tmp/test50M bs=1M count=50
> > > > cp /tmp/test50M /data/ &
> > > > sleep 1
> > > > echo mem > /sys/power/state
> > > > ---
> > > > 
> > > > As seen in the log above disk is synced before suspend.
> > > > cp is continuing to copy data to ubifs.
> > > > And then user space processes are frozen.
> > > > At this point the kernel thread would have unwritten data.
> > > > 
> > > > We tried to solve this with:
> > > > https://lkml.org/lkml/2021/9/1/280  
> > > 
> > > I see. It's still unclear to me when the write happens. Is it in the
> > > suspend path (before the system is actually suspended), or in the
> > > resume path (when the system is being resumed).
> > > 
> > > Anyway, let's admit writing to a storage device while it's suspended is
> > > a valid use case and requires the storage layer to put this request on
> > > old. This wait should not, IMHO, be handled at the NAND level, but at
> > > the MTD level (using a waitqueue, and an atomic to make
> > > suspended/resumed transitions safe). And abusing a mutex to implement
> > > that is certainly not a good idea.  
> > 
> > I did't say this was the right solution ;) I actually asked in the RFC:
> > "Should we introduce a new mutex? Or maybe a spin_lock?"
> > 
> > What are you proposing, a waitqueue in mtd_info? That gets checked in
> > mtd_write()/mtd_read()?
> 
> Yes, and replacing the suspended state by an atomic, and providing a
> helper to wait on the device readiness. Helper you will call in every
> path involving a communication with the HW, not just mtd_read/write()
> (you're missing erase at least, and I fear there are other hooks that
> might lead to commands being issued to the device). But before we get
> there, I think it's important to understand what the kernel expects.
> IOW, if and when threads can do a request on a suspended device, and
> when it's acceptable to wait (vs returning -EBUSY), otherwise I fear
> we'll end up with deadlocks in the suspend/resume path.

I have a proposal [0] and yes I have ended up in many deadlocks during
testing. The hardest part is the locking when going into suspend.
I'm not sure the wait_queue is initialized the right place :)
And I'm kinda abusing the nand_get_device() for this...

Who do you think we should add to the discussion?

/Sean

[0]:
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 3d6c6e880520..735dfff18143 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -337,11 +337,10 @@ static int nand_isbad_bbm(struct nand_chip *chip, loff_t ofs)
  */
 static int nand_get_device(struct nand_chip *chip)
 {
+       struct mtd_info *mtd = nand_to_mtd(chip);
+
+       wait_event(mtd->wait_queue, atomic_read(&chip->suspended) == 0);
        mutex_lock(&chip->lock);
-       if (chip->suspended) {
-               mutex_unlock(&chip->lock);
-               return -EBUSY;
-       }
        mutex_lock(&chip->controller->lock);

        return 0;
@@ -4562,11 +4561,15 @@ static int nand_suspend(struct mtd_info *mtd)
        struct nand_chip *chip = mtd_to_nand(mtd);
        int ret = 0;

+       atomic_inc(&chip->suspended);
        mutex_lock(&chip->lock);
        if (chip->ops.suspend)
                ret = chip->ops.suspend(chip);
-       if (!ret)
-               chip->suspended = 1;
+       if (ret) {
+               /* Wake things up again if suspend fails */
+               atomic_dec(&chip->suspended);
+               wake_up(&mtd->wait_queue);
+       }
        mutex_unlock(&chip->lock);

        return ret;
@@ -4581,10 +4584,12 @@ static void nand_resume(struct mtd_info *mtd)
        struct nand_chip *chip = mtd_to_nand(mtd);

        mutex_lock(&chip->lock);
-       if (chip->suspended) {
+       if (atomic_read(&chip->suspended)) {
                if (chip->ops.resume)
                        chip->ops.resume(chip);
-               chip->suspended = 0;
+
+               atomic_dec(&chip->suspended);
+               wake_up(&mtd->wait_queue);
        } else {
                pr_err("%s called for a chip which is not in suspended state\n",
                        __func__);
@@ -5099,6 +5104,9 @@ static int nand_detect(struct nand_chip *chip, struct nand_flash_dev *type)
        pr_info("%d MiB, %s, erase size: %d KiB, page size: %d, OOB size: %d\n",
                (int)(targetsize >> 20), nand_is_slc(chip) ? "SLC" : "MLC",
                mtd->erasesize >> 10, mtd->writesize, mtd->oobsize);
+
+       init_waitqueue_head(&mtd->wait_queue);
+
        return 0;

 free_detect_allocation:
@@ -6264,6 +6272,8 @@ static int nand_scan_tail(struct nand_chip *chip)
        if (chip->options & NAND_SKIP_BBTSCAN)
                return 0;

+       atomic_set(&chip->suspended, 0);
+
        /* Build bad block table */
        ret = nand_create_bbt(chip);
        if (ret)
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 88227044fc86..f7dcbc336170 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -360,6 +360,8 @@ struct mtd_info {
        int (*_get_device) (struct mtd_info *mtd);
        void (*_put_device) (struct mtd_info *mtd);

+       wait_queue_head_t wait_queue;
+
        /*
         * flag indicates a panic write, low level drivers can take appropriate
         * action if required to ensure writes go through
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index b2f9dd3cbd69..c25c0749f8d0 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1293,7 +1293,7 @@ struct nand_chip {

        /* Internals */
        struct mutex lock;
-       unsigned int suspended : 1;
+       atomic_t suspended;
        int cur_cs;
        int read_retries;
        struct nand_secure_region *secure_regions;
