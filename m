Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8A635D2F7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 00:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343668AbhDLWVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 18:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343666AbhDLWVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 18:21:13 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8AFC061756
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 15:20:54 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i6so14147268ybk.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 15:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=FmBbxZ043goYbQIFSTxJ5QFyMNro4zr+9usEl2+6KDo=;
        b=hebwHaNs+u2Qy3E5HnHs5sMbimi6gtUB5qGU2iwPTwr39qciShPjHjm2OjWEBnJv/H
         2Z5lGaeZ/CxTwz0GnZt4uyBMidroUpcfjHNxD54TFfmT7toDqzikl9Kp3K708NdTulaq
         W4OEOj+1tePlpcyup7wK3zdUH2C+ypfZ8CSjfzyfsQWY8Cp3lkXJ7quWGdr9OyKdluhS
         sAGgDl84wKM4pJWIvxCUz5iIFkXGbBy2e4pKVc/RfErxIS8M7GpgnWrctmIW06X5AoFQ
         r2LHB4gYWVJVQ7b3s/WBQz5yD9mZ15LQChGVrPOYofyYgxHHbWTzu0E6ydSR4VVS8EYU
         /c4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=FmBbxZ043goYbQIFSTxJ5QFyMNro4zr+9usEl2+6KDo=;
        b=XgP9BpgFyd/QMfcw8IjSXa+zJyPLBqY6QOFCs1224V1JMaaJWt5+7qalpuVmP6/vvf
         8SAEHdFVySuJRQZozMLMEz8P135Dla5h0YPHKVipqOFgzV6+6nRDeHib04Hz+7INMYOq
         gMGo9HezEORDfQQrsAMitvl4iIQ9hk6KDkUYMOxe3JNcYyr9eue1opNRkZKEaizDo4p3
         BdPaeuOvHa0lHZEmhFZDyIMnDivSMbIY6SpKleh3I1e3OP8ZHTMkL7mYspHoxRc6aNky
         W8Rpui/R6Rz+XlI3p0Hov5xptqeuaLTnvMB4w7VllBtYnfdf+vSpPlj+ODz8VXvQLoQB
         Jjcg==
X-Gm-Message-State: AOAM530Lhsar+4KhcV1IjJeMwPTPkBSiFddHo9jRV5rjjkdG5V/21QWM
        BBa6/Di7wNPAWf2DVnGjSQuyatBoKEg=
X-Google-Smtp-Source: ABdhPJxLzjwHbeMX6Sc39ErUuoMnIIuqepvQr0GA8yDCc1C9yqhYjoovvhYRQv4GKHvI5QOlH8N/sWIX7t0=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:f031:9c1c:56c7:c3bf])
 (user=seanjc job=sendgmr) by 2002:a25:25d0:: with SMTP id l199mr27919439ybl.256.1618266053917;
 Mon, 12 Apr 2021 15:20:53 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Mon, 12 Apr 2021 15:20:47 -0700
Message-Id: <20210412222050.876100-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH 0/3] KVM: Fixes and a cleanup for coalesced MMIO
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Hao Sun <sunhao.th@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix two bugs that are exposed if unregistered a device on an I/O bus fails
due to OOM.  Tack on opportunistic cleanup in the related code.
 
Sean Christopherson (3):
  KVM: Destroy I/O bus devices on unregister failure _after_ sync'ing
    SRCU
  KVM: Stop looking for coalesced MMIO zones if the bus is destroyed
  KVM: Add proper lockdep assertion in I/O bus unregister

 include/linux/kvm_host.h  |  4 ++--
 virt/kvm/coalesced_mmio.c | 19 +++++++++++++++++--
 virt/kvm/kvm_main.c       | 26 ++++++++++++++++----------
 3 files changed, 35 insertions(+), 14 deletions(-)

-- 
2.31.1.295.g9ea45b61b8-goog

