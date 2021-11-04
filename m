Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3BD74459A0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 19:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbhKDSZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 14:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbhKDSZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 14:25:22 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B94C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 11:22:44 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id h10-20020a63df4a000000b002a6ba425b58so4294798pgj.17
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 11:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=kM0B8bXmtxJQyDrtFwNtoT3h6fl0Y/6oxzC/Fn7ZhOo=;
        b=oxOoTaeZ27CNUJC7/Bj3SmlT5emnVn3TwyMsGoaZIa1fgN08rv18BEATOv4chhfsIN
         /Als1rGQozi08Osb9IjdH8STnf07RO4ST0ekFMZnX1Wi1pDM9Il1XhHo6THs0BWVbTCT
         9aruOX29XhGCGGAyqWYeIrTvWl9p5KhO3xfYVBbWT+S4az5kV6ntH6LDoIvJH+oQzQwx
         WjZUdyO//XsYd/6bDrxrZtQjLqXHFSzERLXlNei0tKUYOWVukgSEMrmNCg4Ts1v4WTXn
         WmyjJmLExyAGGt2PrpxswhwCBULAXsSzh9CIg2W/gEBgrYV5SLhvSFsfRlXZOiQfXTPl
         xUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=kM0B8bXmtxJQyDrtFwNtoT3h6fl0Y/6oxzC/Fn7ZhOo=;
        b=QSIb3tZnIN6A6GP4ydNTA99VDupAVABjmdqmrBbqkvswkAWnuZnN694ufg0MjWPOc0
         7oDaQMr2GtyME3LTo3lGWPu6NW/P7l3LHdWCZoVebCWXBTeh6+KHCb3+MYAz9JP/q+xj
         tva6wUsMv/HhVobO0mXfxuTV9X2TLekzfcfjl9KCwcbH6QBwr57od/3HhDftlvjw7wFY
         0qjQ6Ol8OZbKyE5ORz/JRqee7xGFO7VAni5fqQWbyoa4BeNvcEFtjdfelbbmeKkhpppc
         3WPhvuz/W2Kt9/uMUDQ8hk+g/L6y1FgYTVfJvzcSJySo/nFgcjzop8RBlaej0WGrbqe4
         NjxQ==
X-Gm-Message-State: AOAM5324luz5XIcJz0gZdSYX1YmjIolJt92iqZSiulwNOt1rK/xZjgnP
        iYRt/Xr18N8z6dYwncTUsDTyjNuqeNI=
X-Google-Smtp-Source: ABdhPJwW98i7fCH9z5DYCWE+KzE7VMkZqiDtI4CnSgysEEolyyB/s5b7dgte2fV+3lBbfutac5GlPO5Ss6g=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:ea10:b0:142:112d:c0b9 with SMTP id
 s16-20020a170902ea1000b00142112dc0b9mr16685279plg.35.1636050163603; Thu, 04
 Nov 2021 11:22:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  4 Nov 2021 18:22:37 +0000
Message-Id: <20211104182239.1302956-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v2 0/2] x86/hyperv: Bug fix and enhancement
From:   Sean Christopherson <seanjc@google.com>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 01 is a fix for a NULL pointer deref that I ran into with a bad VMM
configuration.  That specific error path is remedied by patch 02, but
Hyper-V can still end up in an inactive state if a memory allocation fails.

Patch 02 effectively makes the required MSRs mandatory for recognizing
Hyper-V at all.

Some versions of QEMU prior to ~6.0 make it all too easy to advertise
Hyper-V and a slew of features without advertising the Hyper-V HYPERCALL
MSR, e.g. +hv-ipi,+hv-tlbflush,+hv-vpindex,+hv-reenlightenment advertises
a bunch of things, but not the HYPERCALL MSR.

That results in the guest identifying Hyper-V and setting a variety of PV
ops that then get ignored because hyperv_init() silently disables Hyper-V
for all intents and purposes.  The VMM (or its controller) is obviously
off in the weeds, but ideally the guest kernel would acknowledge the bad
setup in some way.

v2:
  - Add Vitaly's review.
  - Rebase to hyperv-next, commit 285f68afa8b2 ("x86/hyperv: Protect
    set_hv_tscchange_cb() against getting preempted"). [Vitaly]
  - Tweak the changelog in patch 01 to omit the example about a bad VM
    config since the NULL check is needed even if that specific issue is
    resolved.

v1: https://lore.kernel.org/all/20211028222148.2924457-1-seanjc@google.com/t/#u

Sean Christopherson (2):
  x86/hyperv: Fix NULL deref in set_hv_tscchange_cb() if Hyper-V setup
    fails
  x86/hyperv: Move required MSRs check to initial platform probing

 arch/x86/hyperv/hv_init.c      | 12 ++++--------
 arch/x86/kernel/cpu/mshyperv.c | 20 +++++++++++++++-----
 2 files changed, 19 insertions(+), 13 deletions(-)

-- 
2.34.0.rc0.344.g81b53c2807-goog

