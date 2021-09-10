Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B8840651B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 03:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235965AbhIJBYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 21:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbhIJBYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 21:24:01 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AD5C061A2E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 18:20:38 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id i21so877977ejd.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 18:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=s87a4kLYskz8I39/PMyVgm/9D4JsaFL+PLylS+GVBGk=;
        b=fL8l6HIwbgPW3mMVDvj1Hjiys1GcMJa3bBiUhh8+cTHGnjh9M+y7HAqL6977h1BYpl
         3LHqtx19njgpUhdih0lKM3qdx8dkSbTSlF36/md+61rzF82PJAx5IolN2P7rnIOMuFAk
         obAsrSPHsej/+lxjhtVUgjMrhraj8qVnhCJKkKGkOr37oB1xdFiD/bSbWWYmzd+kBvcd
         ulxbBWu5dZYO1+BT56JRYhzgnBtB6mdUHzS2C3hENlwPIAgYAjxU9gtPIfPkr1v8Ocp2
         SRFCTNOVpaP6rB/nuphOG0issdOSucP6GoUZoMA84cFpp2yu1RX4s9F7sqbUj6xqpgr4
         U9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=s87a4kLYskz8I39/PMyVgm/9D4JsaFL+PLylS+GVBGk=;
        b=MFv9FTW27TVtN90H3I8aJjqtccPnkx40UbaNJdBrefQZQqBV3/GOlyLt0erAZobBlu
         KoFSKgzQOrYreB5tPSH+/wrKdZZCRtF91HOHwf6l6tvdtbZB46ZuFTjaJ7Kvbqlvi2FW
         Uq0pPqvj7vrNaEhzy+IunKwbIsse/gz7nco3iUiTmnUTtk/Z811U61IH2hZgY766SA7x
         HDdvRComE87pQWlUyULBDB0QRccOsudDvEtjXhXyUNQvDEFDviEyn2k/d4ndky7wVS27
         Ry8GFfctYiSaWu51AKvBcOKYA5oXh9HqtKcLT+lv5/EZkjjk6Ruq0nJdxPhwB6ld1soN
         hbjQ==
X-Gm-Message-State: AOAM5339+vppxkp2mMb3SJ2L4jlGHEGnB+yrGFaGQw1AhX07/ld1lAqp
        wlCOzg+PWhylB36aSVND4DAA16kXGoPimRWpugM=
X-Google-Smtp-Source: ABdhPJzenYYErzdjhufpvlHoanxR6kti4HROlAGdyVuF2NEdLPYXgau8d66hPZv+Yh+WFbjLl88L8B7f4BGh1JS6We8=
X-Received: by 2002:a17:906:144e:: with SMTP id q14mr6475371ejc.19.1631236836530;
 Thu, 09 Sep 2021 18:20:36 -0700 (PDT)
MIME-Version: 1.0
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Fri, 10 Sep 2021 10:20:25 +0900
Message-ID: <CAM7-yPRHKg-=7ezm5PpxAvhmBx6_bXRkeLsmCNuAWH-DN4MKCA@mail.gmail.com>
Subject: About Full c3-stop status.
To:     Thomas Gleixner <tglx@linutronix.de>, preeti@linux.vnet.ibm.com,
        mingo@elte.hu, rmk+lkml@arm.linux.org.uk,
        dmitri.vorobiev@movial.com
Cc:     youngjun.park@ahnlab.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

Sorry to interrupt you but I have a question while I am reading the
tick-broadcast codes.

When a cpu goes to c3-stop, I confirm it calls the
tick_broadcast_enter function with TICK_BROADCAST_ENTER.

While entering, it calls the broadcast_needs_cpu with current cpu.

In the last condition of broadcast_needs_cpu, it checks whether the
broadcast device is bound on this cpu.

However, except the ce_broadcast_hrtimer in tick-broadcast-hrtimer.c,
all other real devices set bound_on fields as 0, Therefore, it seems
that cpu 0 couldn't enter c3-stop though it has the feature.

My question is
     1. Couldn't cpu 0 enter c3-stop?
     2. If true, why don't we set bound_on fields specifically?

Thanks.

HTH.
Levi.
