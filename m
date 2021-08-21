Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F243F3778
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 02:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238544AbhHUAFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 20:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbhHUAFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 20:05:44 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BB3C061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 17:05:06 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b9-20020a5b07890000b0290558245b7eabso11242951ybq.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 17:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=v5+oztcUWF1tsHkXWU5dtrULoyd6t4n/rFzGBM2+LiE=;
        b=e+bb+TkiQMZJXlGX82szk2loy6RZejnh/9ul5hxji7BXLcGBs/qHQ2y3USTrrr3RLk
         G4qD2UDaZpqeuGtqDo/XCtu1vog/i+aVVz8wOwFtwncWz+N78YghqvOOjPMeJ5NJ6a0C
         VjK4ENTRg59Gb54HGfdyfZLyUsvNTLTwASucxsvnfc9EoZizmHOFouSyDryWXUtb7MaJ
         PYhCG7qmP192KO63u60EgYoNukRDrMsB/ltXQVdgnPTj/vw/MLP/T91JpzXqDMDrbGV5
         MFDdo+UVSz5IXVnSPx+G3CIma5sp+0yQ7nbMMhYLu5OvGUF+zG7FwUih5xFrZ15HjKBi
         Q5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=v5+oztcUWF1tsHkXWU5dtrULoyd6t4n/rFzGBM2+LiE=;
        b=PgfichDGRAjvVxeSkCw8BOXcdi/EaxSeRVpLQc/5FrmtQGaPqnjZg5NukTs5Motu8D
         2LY20CfjNphrx3Ghb9QAOvV5ZB+D92TgJw7A8T6Fd3j2bqNSAHx1kt6g85tYCZY9aM2v
         zI3YfTosmbmr7lIqEMbP0yYXYtpncSgdGTpsxHMYgJlXfUO0gYGKMQqRuaH7NUwot8Y3
         QojdCh3nNJAKBrFxQyIedImGcX6TVzBgUAHasKa+arB9B2OtA1mjFvVpL92fw8NjSV/u
         +2bekhsFsZfNbilflPcUM8mxqwwkCxplwhvNNBM4YsLGu7eqJwr8RTkj5REadpNtrbaC
         5K5g==
X-Gm-Message-State: AOAM530ycOOSjkyKz/aqX0+tk+EHQg3Txl8o9D096qc9i4gO3StwazER
        i4R+SVopbdlzQKjRaT4NgYPNF29urTw=
X-Google-Smtp-Source: ABdhPJw6qyZ/x0/x8bWL4yd+NvmJ6KamcS8WpBb1Ezie6D9yRM/YBI+Kr7Dfm9WJxC8UO8GuCupKMqxWjro=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:f11d:a281:af9b:5de6])
 (user=seanjc job=sendgmr) by 2002:a25:3625:: with SMTP id d37mr31728766yba.140.1629504305587;
 Fri, 20 Aug 2021 17:05:05 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 20 Aug 2021 17:04:59 -0700
Message-Id: <20210821000501.375978-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH 0/2] VM: Fix a benign race in kicking vCPUs
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Venkatesh Srinivas <venkateshs@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix benign races when kicking vCPUs where the task doing the kicking can
consume a stale vcpu->cpu.  The races are benign because of the
impliciations of task migration with respect to interrupts and being in
guest mode, but IMO they're worth fixing if only as an excuse to
document the flows.

Patch 2 is a tangentially related cleanup to prevent future me from
trying to get rid of the NULL check on the cpumask parameters, which
_looks_ like it can't ever be NULL, but has a subtle edge case due to the
way CONFIG_CPUMASK_OFFSTACK=y handles cpumasks.

Sean Christopherson (2):
  KVM: Clean up benign vcpu->cpu data races when kicking vCPUs
  KVM: Guard cpusmask NULL check with CONFIG_CPUMASK_OFFSTACK

 virt/kvm/kvm_main.c | 46 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 9 deletions(-)

-- 
2.33.0.rc2.250.ged5fa647cd-goog

