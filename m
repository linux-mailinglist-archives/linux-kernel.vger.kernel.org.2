Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D66338AF90
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 15:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242808AbhETNFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 09:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237416AbhETNE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 09:04:59 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918C7C06135C
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:40:09 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id p20so19521574ljj.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=CZBjnoBLTFoBWgdZyV2FVeoTbN+eKb/uryygiH4YrpY=;
        b=EL/9tWdDAAgPYiKLZWvquX27VMrn7Xr+NGnZkjlYQjUB8zNKZjriS8yICU3uhFZewf
         5zrIoXKAbdXM+UNezuBr496uXTyzGzqnmjrL3u1TgocPzkQqUJraEP6GN1wCZxPXN37T
         ISLnlbwoCp/1/sKnph9qYuqjPVQoBcbhEYHguaYXv4PWrKcsUXJZ8YLxOKYqY6/feNpb
         fN112IJtV0Mgjchw65Lw3ZO3RxbfKqdk6xF6ZywxZ9zNSjS6BCt220iUXkScCni7C4B/
         W17LIo7iK/rZVa3IkhA5SRBVC6926J8b8ofB4A1XM2WaboaYKBtva2rKeeXX/udtSasJ
         KJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=CZBjnoBLTFoBWgdZyV2FVeoTbN+eKb/uryygiH4YrpY=;
        b=qs3A84ez8IgTxGLRIRm9B0uEHgotYFGL/9ymSPKYUSBZFmVCLuqICwi2R30XuoHmlr
         2XXADCcVeQNB7GvH7jRDJl37c/hj2crwnjFcY1LbCqQuUhFrs/vQMm6Ftyf834zBb1tu
         NnsBWbPPnsae2NmGoOly4QP0T/Y9ohX8u3J2fjo7WSM1t5ZeKSl13G2PUv3WMKPa5Dp8
         gVZQL08tWdNcmUYkmW74B2aihZRkEjIEvJorLYeGnnYLXtMAH/V3azqvUpwK4p6TcOA+
         nda1/8bu/zxmXFMBXX1Rh309m4/LID95o6hTRbHex4mX66+UbEbDgXUVP/KTEJbTOpRA
         WfqA==
X-Gm-Message-State: AOAM531IVquwtfXGOgOviUqfyWaSVKXK3Mf9ajTOQtFih8jWOOyHQwkv
        i5anwM7yKM/PTQTlBUo2VvIAD67300x+35VfWpA=
X-Google-Smtp-Source: ABdhPJwLTQTF7ZaEFYikpAktLc9lNMuBHnImOkdrdUUckIR0l1RMjKY7xTo9JSPumZBBfhnoZSiZnJVXkxyfDbUAm2Y=
X-Received: by 2002:a05:651c:232:: with SMTP id z18mr2948628ljn.489.1621514407950;
 Thu, 20 May 2021 05:40:07 -0700 (PDT)
MIME-Version: 1.0
From:   Jason Andryuk <jandryuk@gmail.com>
Date:   Thu, 20 May 2021 08:39:56 -0400
Message-ID: <CAKf6xptjmd9BMuiKpRgj1YyyR97gGXKgYgj-4CKaTvBk4+FeoA@mail.gmail.com>
Subject: Calling queue_work() multiple times with the same work_struct
To:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm looking for clarification of the behavior of queue_work().  From
the header description, I'm not sure if I need additional complexity
for re-queuing work.

I want to ensure the following cases all occur when calling queue_work().
1) work_struct not queued -> work_struct queued
2) work_struct queued -> work_struct queued (no change)
3) work_struct running -> work_struct queued (so it will run again)

1 & 2 look supported from workqueue.h.  Is the 3rd case true and
guaranteed?  Is it okay to re-use the same work_struct in that case
while it's being executed?  A work_struct function can re-queue
itself, so I hope #3 is supported.

The virtual device I'm working on has a single interrupt shared for
multiple rings.  So whenever an interrupt occurs, I need to re-queue
the single work_struct on the workqueue to ensure we don't miss an
event.  That is, we need to re-iterate all the rings if the interrupt
comes halfway through processing the list of rings.  If multiple
interrupts come through while running, we only need to re-queue a
single work item for all of them.

Below is what I hope works for the code to give something tangible.

Thank you,
Jason

DECLARE_WORK(argo_work, argo_work_fn);
static struct workqueue_struct *argo_wq = alloc_workqueue("argo_wq",
                    WQ_UNBOUND | WQ_HIGHPRI | WQ_CPU_INTENSIVE | WQ_SYSFS, 1);

static void argo_work_fn(struct work_struct *work)
{
    argo_interrupt_rx();  /* iterates multiple "rings" */
    argo_notify();
}

static irqreturn_t argo_interrupt(int irq, void *dev_id)
{
    queue_work(argo_wq, &argo_work);

    return IRQ_HANDLED;
}
