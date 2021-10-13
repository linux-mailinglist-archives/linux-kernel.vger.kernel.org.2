Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E5B42C8EF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 20:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238276AbhJMSnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 14:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhJMSnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 14:43:47 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFADCC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 11:41:43 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id g25so11500345wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 11:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20210112.gappssmtp.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wNQLxL5fT4EiTSmW5ieC0H1n87lvo+3Lx9xHbo8gCfQ=;
        b=6x5PEfVYV9dk0TgkWnODuEW8HBlAHEHe5lFbg3kjPx4XnizNr0AzRQFEi2FkDTRafl
         qp7aAMgyO2H4RjcjYDZHk80PK5mrF/mAueUFu6TLpaLUNaHzQwYaxW/ENCOCnNYC4kSi
         cNFcvyaq9bX1Y01hd0Jg/xPoxL7/kp3Eut/0uJvHxdwP44B+tL/wl/JDoM8BDLvRaxWE
         ADqNyax9jX1a1tLST/Q/Iv2kkRKP9Uzy5AIRT92GP/D47mElzvwZswGt1uz25/mpE7GO
         4WMRvPvIftKmyRnaLNGdpvZJN+OQabZLOJbKasFTscc0ZWiPHBW1W0M+icgLcbJWvZ1I
         SKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wNQLxL5fT4EiTSmW5ieC0H1n87lvo+3Lx9xHbo8gCfQ=;
        b=jjUlSqyXbgbJLogIhaThM0HxB34AFMkj2v6sBnqKwYylQP2VjzhCzxSGzgFr+C7/ur
         wnRbOh6IC+KLw4RuZWNtWWOts6XM3lYB15A4Is1+o1CqleOarwSxpRMwb8qyvO7Ekxr0
         0P5jD8emUZaBlRy33klSQH1vPih3ZioPc1amSUnT/dpgMWVD9yjAgBCzABS0p2ioZFDN
         rzYLzPlzFWL3B2+HvWweChZPTb2n6HiyVH+mgEJ5MozF/TPdoxRlCoM/j9gaJLCb0m0z
         SjddrYtYBcYjW/FvqQKRULWnq2UWM7K529JFRPePRM8yQKhkbueLsNXAwYB67lYYAipS
         pv3A==
X-Gm-Message-State: AOAM532l52EGC85rcPp1aKOUKWoypHFSiEflYtkHVaHQmOz5XVbFDcW0
        LnKWTFjnei0cvYASXo1OPYNnQA==
X-Google-Smtp-Source: ABdhPJx+LOfDiWVro2yW4L9TMnVs6CvlieIvsnKNOKpZoZs47dGlEL1TOhE6zrGPAHs7vPwDLqiV0Q==
X-Received: by 2002:adf:d1ee:: with SMTP id g14mr917508wrd.165.1634150501848;
        Wed, 13 Oct 2021 11:41:41 -0700 (PDT)
Received: from localhost (5.186.124.144.cgn.fibianet.dk. [5.186.124.144])
        by smtp.gmail.com with ESMTPSA id h11sm315191wrz.5.2021.10.13.11.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 11:41:41 -0700 (PDT)
From:   "Javier =?utf-8?B?R29uesOhbGV6?=" <javier@javigon.com>
X-Google-Original-From: Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
Date:   Wed, 13 Oct 2021 20:41:40 +0200
To:     Adam Manzanares <a.manzanares@samsung.com>
Cc:     "yi.zhang@redhat.com" <yi.zhang@redhat.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: Cleanup per-namespace chardev deletion
Message-ID: <20211013184140.fevatn7xt6h565ow@mpHalley-2.local>
References: <CGME20211013150421uscas1p297a8bd51cf3f3b68dcef3a1c87da2959@uscas1p2.samsung.com>
 <20211013150413.320133-1-a.manzanares@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211013150413.320133-1-a.manzanares@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.10.2021 15:04, Adam Manzanares wrote:
>Decrease reference count of chardevice during char device deletion in order to
>fix a kmemleak. Add relese function for the device associated chardev and moved
>ida_simple_remove into the release function.
>
>Fixes: 2637bae (nvme: introduce generic per-namespace chardev)
>Reported-by: Yi Zhang <yi.zhang@redhat.com>
>Suggested-by: Sagi Grimberg <sagi@grimberg.me>
>Signed-off-by: Adam Manzanares <a.manzanares@samsung.com>
>---
> drivers/nvme/host/core.c      | 21 ++++++++++++---------
> drivers/nvme/host/multipath.c |  2 --
> 2 files changed, 12 insertions(+), 11 deletions(-)
>
>diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>index f9a25c61fb8b..3bc4bb620ab7 100644
>--- a/drivers/nvme/host/core.c
>+++ b/drivers/nvme/host/core.c
>@@ -3583,10 +3583,15 @@ static int __nvme_check_ids(struct nvme_subsystem *subsys,
> 	return 0;
> }
>
>+static void nvme_cdev_rel(struct device *dev)
>+{
>+	ida_simple_remove(&nvme_ns_chr_minor_ida, MINOR(dev->devt));
>+}
>+
> void nvme_cdev_del(struct cdev *cdev, struct device *cdev_device)
> {
> 	cdev_device_del(cdev, cdev_device);
>-	ida_simple_remove(&nvme_ns_chr_minor_ida, MINOR(cdev_device->devt));
>+	put_device(cdev_device);
> }
>
> int nvme_cdev_add(struct cdev *cdev, struct device *cdev_device,
>@@ -3599,14 +3604,14 @@ int nvme_cdev_add(struct cdev *cdev, struct device *cdev_device,
> 		return minor;
> 	cdev_device->devt = MKDEV(MAJOR(nvme_ns_chr_devt), minor);
> 	cdev_device->class = nvme_ns_chr_class;
>+	cdev_device->release = nvme_cdev_rel;
> 	device_initialize(cdev_device);
> 	cdev_init(cdev, fops);
> 	cdev->owner = owner;
> 	ret = cdev_device_add(cdev, cdev_device);
>-	if (ret) {
>+	if (ret)
> 		put_device(cdev_device);
>-		ida_simple_remove(&nvme_ns_chr_minor_ida, minor);
>-	}
>+
> 	return ret;
> }
>
>@@ -3638,11 +3643,9 @@ static int nvme_add_ns_cdev(struct nvme_ns *ns)
> 			   ns->ctrl->instance, ns->head->instance);
> 	if (ret)
> 		return ret;
>-	ret = nvme_cdev_add(&ns->cdev, &ns->cdev_device, &nvme_ns_chr_fops,
>-			    ns->ctrl->ops->module);
>-	if (ret)
>-		kfree_const(ns->cdev_device.kobj.name);
>-	return ret;
>+
>+	return nvme_cdev_add(&ns->cdev, &ns->cdev_device, &nvme_ns_chr_fops,
>+			     ns->ctrl->ops->module);
> }
>
> static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
>diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
>index fb96e900dd3a..bd490a7c4808 100644
>--- a/drivers/nvme/host/multipath.c
>+++ b/drivers/nvme/host/multipath.c
>@@ -434,8 +434,6 @@ static int nvme_add_ns_head_cdev(struct nvme_ns_head *head)
> 		return ret;
> 	ret = nvme_cdev_add(&head->cdev, &head->cdev_device,
> 			    &nvme_ns_head_chr_fops, THIS_MODULE);
>-	if (ret)
>-		kfree_const(head->cdev_device.kobj.name);
> 	return ret;
> }
>
>-- 
>2.25.1

Thanks for taking a look at this Adam. Looks good to me.

Reviewed-by: Javier González <javier@javigon.com>
