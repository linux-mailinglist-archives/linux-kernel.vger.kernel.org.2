Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14A33B0D31
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 20:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbhFVSvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 14:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhFVSvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 14:51:06 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69008C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 11:48:49 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id e20so8019623ual.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 11:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=+D9GL/a0tUI3plKrlEmSJ7OI5JyRd5f1tadWzbi57fk=;
        b=GUUyxFYHHOnxOgj5lrM6+zLRG+BoYVCdWuKIFX4WqaDpjMZPqtDhv/3vW3hxxwtGSz
         M+VYCOCfb9pePtQUaxBQh85HD5R9lGCNvQv3sHJxZu4A4iWLit34ZePWvIYz1rQhPG8g
         wZ8d2vGElpPRCCDEDYxWvHz7VLA1L9PCDwqxeU9IB0GZ7+p+J6c+KnF0gyV0AB+JiU/M
         eyAKT2WBw7T942vp6NzNIGaIM1s6SkcXFUhXOA/LrYSlyHvonNX4qywaLmrOszApDmAy
         M681hp6ac3d6R1v6CHoBXwemKmh7/AOvl66nzP7B4TusPVDIiJY94JeF9YDu8IYoN7wG
         JtfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+D9GL/a0tUI3plKrlEmSJ7OI5JyRd5f1tadWzbi57fk=;
        b=Mrbc96EmkP/HlI6/LP3CHVgz/LCo2xo0ZGuhZZ52d2l2f71oo0QbOLuuaCksh4R49w
         YrDc+vrQVBmQ5t9kx2iQJkO9WxtIbYPeFul5qkRbYp1kCwuMTVRX111GKh1DmBrQRoBG
         BUOiAjaCpVGx3wvUZVEWDkS+meCmWey/mZl3uYKyR7+ur3UhX0TGSzKuspOyCh5NPhW/
         9EaaWr7ZuypDY7D6jnIn4w1GlmIlmGXZMoJ6pzx4Ri45H1DME5Yybp1Ne061E2GTGZKZ
         iHK2ld4gxbl3zbOWezYJu5b2OmmJTXit2RHFPFLg4xip5DU3oSVPSa9Figw5L94qhXRl
         8PMg==
X-Gm-Message-State: AOAM530pEj3HM+b55ZYKewyigr1sAHOXLBbyjUugQ5+sISqFN0hjpM5p
        BuyEVxQxH1z0RJgY/HEaqBCyUUB8T8AxKMUqsKg=
X-Google-Smtp-Source: ABdhPJzeLgNQxZA+wrhGcPtmM6fR8BdNEDlJYdpzO1GdFjLnc6xPvzadLx3H1r6wm+9sdiNk2y4eMXbzK7jzx4p9dA4=
X-Received: by 2002:ab0:45e5:: with SMTP id u92mr307663uau.23.1624387728510;
 Tue, 22 Jun 2021 11:48:48 -0700 (PDT)
MIME-Version: 1.0
From:   jim.cromie@gmail.com
Date:   Tue, 22 Jun 2021 12:48:22 -0600
Message-ID: <CAJfuBxwfODtFYbP6cJnq4fU94AtK0oe2hGbKg-vOApb2ERk1eQ@mail.gmail.com>
Subject: BUG: KCSAN: data-race in vring_interrupt+
To:     virtualization@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I got this on rc7 + myhacks
Im testing on virtme ( kvm + qemu + 9p )

lemme know if I can test something.

[   18.081278] virtme-init: starting udevd
Starting version v248.3-1.fc34
[   18.763364] virtme-init: triggering udev coldplug
[   18.893238] ==================================================================
[   18.894240] BUG: KCSAN: data-race in vring_interrupt+0xf7/0x130
[   18.895108]
[   18.895334] race at unknown origin, with read to 0xffff888005ca5942
of 2 bytes by interrupt on cpu 0:
[   18.896791]  vring_interrupt+0xf7/0x130
[   18.897389]  __handle_irq_event_percpu+0x64/0x260
[   18.898218]  handle_irq_event+0x93/0x120
[   18.898883]  handle_edge_irq+0x123/0x400
[   18.899550]  __common_interrupt+0x3e/0xa0
[   18.900204]  common_interrupt+0x7e/0xa0
[   18.900844]  asm_common_interrupt+0x1e/0x40
[   18.901625]  native_safe_halt+0xe/0x10
[   18.902180]  default_idle+0xa/0x10
[   18.902808]  default_idle_call+0x38/0xc0
[   18.903439]  do_idle+0x1e7/0x270
[   18.903972]  cpu_startup_entry+0x19/0x20
[   18.904717]  rest_init+0xd0/0xd2
[   18.905443]  arch_call_rest_init+0xa/0x11
[   18.906125]  start_kernel+0xacb/0xadd
[   18.906681]  secondary_startup_64_no_verify+0xc2/0xcb
[   18.907392]
[   18.907624] Reported by Kernel Concurrency Sanitizer on:
[   18.908440] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
5.13.0-rc7-dd7i-00038-g4e27591489f1-dirty #124
[   18.910025] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.14.0-3.fc34 04/01/2014
[   18.911392] ==================================================================
