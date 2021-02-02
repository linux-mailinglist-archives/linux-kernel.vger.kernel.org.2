Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B500830B41C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 01:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhBBA1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 19:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbhBBA07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 19:26:59 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A254C061793
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 16:26:09 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id n42so18194581ota.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 16:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZaKN0kS6u64uQV+6FGLHQ/HFDrwuOhBJX+D4+gTt6r0=;
        b=tCDZIyKRfYkflVO/mtEEY/OhC27bA9kqcX/5z+t4BtDBqfjp5sZ49VjvxVeoplOarj
         AHmY7N+os6HUVETD7QEgDovkqXB9vRw9mosvTMB0EzWzWlaO05AsR204OzZKZglBwYiX
         pHQBMKa7/HwClvsBCbv5i43x7LoXh+9DL2zfBgKB+ONF2UqWACyeWSzlt2oyy3ElQkYU
         jU42fR2o3wK8iolXAqeuVQN1utwYgYnSs8VYPrrMqiVJVYcqHdUGJWMc9C9X41IuMgq9
         H5UcsTgNmbqCwr1LI57T+EnrptCtYRBZDYWAvgWbsMxvK6h1QSipoNDTD9tPto4A4sar
         N7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZaKN0kS6u64uQV+6FGLHQ/HFDrwuOhBJX+D4+gTt6r0=;
        b=qJ3rwDrWLvs1u0yRKUCjdfRdM//rq2OUaPj8y6ynSMw7O+7yuX2Jy9nvLdItw3qwY3
         6YTBWWOd/1ibD2CBVTtKUa52DG6DeZpyXyp8bpkOj4/ap/elZTPvfkadLolMY+rljSCK
         WSOu4RJDPLmG2WX7vPES1YCQpH9wGjVI/LVYk6HPbsOygHpVHuqxGznGYCWc7993pxED
         r3RL78mn6GwBf8a09J1BOU6ScXeTfGP5U/m64kfQVDtcxrmBNQyA5tn/HsX9y2XbTORw
         IbVXJ7duzuOzk7N1HoyUkA3f+BixC4sXnT4nfc24n+Px8wt0nR6dRJaHvSGpxSPCXV7t
         T4nQ==
X-Gm-Message-State: AOAM533eDF/olvH0XoUabxNNP6ELsD5co0ZBxXpx888gn+6X/tfVdHpW
        hRydVxsh9Ykc8RxxdJVb0KNB1381wJtN6RDU51YS4Q==
X-Google-Smtp-Source: ABdhPJyFgXBxhpe6iO2OHTC17kqmn9HUrbruwF7fouFTXMMPS3G9sjeY2vc7eAvB7AwHVf2zMFQpAJVvevVDT4EA30k=
X-Received: by 2002:a9d:7d12:: with SMTP id v18mr13319071otn.205.1612225568439;
 Mon, 01 Feb 2021 16:26:08 -0800 (PST)
MIME-Version: 1.0
References: <20210201183017.3339130-1-jxgao@google.com> <20210201183017.3339130-4-jxgao@google.com>
 <20210201205759.GA2128135@dhcp-10-100-145-180.wdc.com> <CAMGD6P2Gz9nWELMdsAhwQvXx3PXv2aXet=Tn9Rca61obZawfgw@mail.gmail.com>
 <CAMGD6P1_cs1W8jMt7Sz6broDdnFNPrxbiZW-JZ+GAtg5aoTdOQ@mail.gmail.com>
In-Reply-To: <CAMGD6P1_cs1W8jMt7Sz6broDdnFNPrxbiZW-JZ+GAtg5aoTdOQ@mail.gmail.com>
From:   Jianxiong Gao <jxgao@google.com>
Date:   Mon, 1 Feb 2021 16:25:55 -0800
Message-ID: <CAMGD6P0uwVxKuG503ahGTbPcwb+y2wRXSiE_gvzfdUrMfZ5YbA@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] Adding device_dma_parameters->offset_preserve_mask
 to NVMe driver.
To:     Keith Busch <kbusch@kernel.org>
Cc:     Erdem Aktas <erdemaktas@google.com>, Marc Orr <marcorr@google.com>,
        Christoph Hellwig <hch@lst.de>, m.szyprowski@samsung.com,
        Robin Murphy <robin.murphy@arm.com>,
        gregkh@linuxfoundation.org, Saravana Kannan <saravanak@google.com>,
        heikki.krogerus@linux.intel.com, rafael.j.wysocki@intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dan.j.williams@intel.com, bgolaszewski@baylibre.com,
        jroedel@suse.de, iommu@lists.linux-foundation.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, axboe@fb.com,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Why is this setting being done and undone on each IO? Wouldn't it be
> more efficient to set it once during device initialization?

I agree that setting it once is the right way of doing it.

So I have changed the patch to enable the mask once in nvme_probe.

 drivers/nvme/host/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 81e6389b2042..4ce78373f98d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2630,6 +2630,9 @@ static void nvme_reset_work(struct work_struct *work)
         */
        dma_set_max_seg_size(dev->dev, 0xffffffff);

+       if (dma_set_min_align_mask(dev->dev, NVME_CTRL_PAGE_SIZE - 1))
+               dev_warn(dev->dev, "dma_set_min_align_mask failed to
set offset\n");
+
        mutex_unlock(&dev->shutdown_lock);

        /*

However on boot of the system, the following error happens occasionally.
The error seems related to Journal service. Whenever "Stopping Journal
Service..."
appears, the boot succeeds. Otherwise boot fails with the following message.

----------------------------log start here--------------------------
[  OK  ] Started Journal Service.
[   10.774545] xfs filesystem being remounted at / supports timestamps
until 2038 (0x7fffffff)
[  OK  ] Started Remount Root and Kernel File Systems.
         Starting Flush Journal to Persistent Storage...
         Starting Load/Save Random Seed...
         Starting Create Static [   10.804340] systemd-journald[780]:
Received request to flush runtime journal from PID 1
Device Nodes in /dev...
[  OK  ] Started Load/Save Random Seed.
[  OK  ] Started Flush Journal to Persistent Storage.
[  OK  ] Started Create Static Device Nodes in /dev.
         Starting udev Kernel Device Manager...
[  OK  ] Reached target Local File Systems (Pre).
         Starting File System Check on /dev/disk/by-uuid/7281-17FC...
[  OK  ] Started File System Check on /dev/disk/by-uuid/7281-17FC.
         Mounting /boot/efi...
[  OK  ] Mounted /boo[   11.203461] systemd[1]: segfault at 2e0 ip
000055b08607cc24 sp 00007ffe13809090 error 4 in
systemd[55b086000000+140000]
t/efi.
[   11.216088] Code: 02 c7 44 24 10 fe ff ff ff 49 89 e4 89 06 48 8d
6c 24 08 48 8d 5c 24 10 48 c7 44 24 18 00 00 00 00 eb 10 0f 1f 00 48
8b 3c 24 <44> 39 b7 e0 02 00 00 74 3b 49 8b 7d 00 4c 89 e1 48 89 ea 48
89 de
---------------log ends here-----------

> Based on the Keith's comment it needs to be completely avoided in hot path.
>
> Did you get a chance to bisect the problem in the rc6 ? We need to know the
> root cause otherwise it might happen again after we add this patch.

I am now trying to bisect the problem.
I am not sure how the mapping offset could have caused the error.
Any suggestions are appreciated.

--
Jianxiong Gao
