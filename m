Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2670456D2A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 11:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbhKSKYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 05:24:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45227 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233172AbhKSKYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 05:24:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637317305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yoOG1diMi0E/SvfVXv5alhyBNgdiAvTA9EtQDMJObdw=;
        b=JdWCSZ7Ld7lnSMHc1CAUQhb8/01rH9lk6N3tCcJAcp4nFEwSzKyhlr4u/BDDZRv7qfi+3k
        VgMFrAaHPJpBdQnN5747sW9skpYyUoqO3Fqus5S/RAAbfEzqHSQbZsuBTxkfFjlZPmhooS
        XRWFFaz95LHap9+dEeSDldkmPoAJGPs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-287-b2LkCoTENqymanNbkNN-Mw-1; Fri, 19 Nov 2021 05:21:44 -0500
X-MC-Unique: b2LkCoTENqymanNbkNN-Mw-1
Received: by mail-wr1-f70.google.com with SMTP id k8-20020a5d5248000000b001763e7c9ce5so1677339wrc.22
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 02:21:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yoOG1diMi0E/SvfVXv5alhyBNgdiAvTA9EtQDMJObdw=;
        b=oagOmNjQPT1MvtNifbvzHhNbbcUQibFaBOpLcepGAU4UVllerVSJ7319+EzW3ayiqU
         HHr6poAw3MkJS4crs055F8Stq/s04wLX5aA7dSURn5YQXEgM7OifxtBRG2k+aIHi0owL
         y/024HIKQ6YmpTS/IVdlMsx/0DHuf6AQg+OyU5ca0BLRmiiAl211KrnQ7BBobuudN4Z+
         /DMHhyeM16L/UPnYQhsOEthtkm+ayFcyQcdEHTcZ4ZTtvj6YMuOy1RK5AdQaspeABJ4e
         nOKfomFWjVYtDERtIDFGPSxhhf8ckK+jNrSGrShOAfCSF6KHYl2osWeLsjHM4kNOZFnf
         kr0Q==
X-Gm-Message-State: AOAM533EQEpKAPJLjaz2sM+Pwehuxau7mCZvhNCX4kYXQY1IwWG5whnI
        a/wjo7La2PHABLPawt755p4/j+BHbChTV4l/ZxOh5m9erh0PgU7vMWu/mT4w1+Gmg4HAhfSC11/
        QU2BWFwNqiq309vZh32amw6Kf
X-Received: by 2002:a5d:63ca:: with SMTP id c10mr5840312wrw.124.1637317303321;
        Fri, 19 Nov 2021 02:21:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwihTxczM5jqGJYFo9iUlthuKo/r0hHx/63+SRDngLpAOgUraQ7o+CZyQaRivyiAucHPrBPCQ==
X-Received: by 2002:a5d:63ca:: with SMTP id c10mr5840286wrw.124.1637317303163;
        Fri, 19 Nov 2021 02:21:43 -0800 (PST)
Received: from vian.redhat.com ([2a0c:5a80:3c10:3400:3c70:6643:6e71:7eae])
        by smtp.gmail.com with ESMTPSA id k27sm14336026wms.41.2021.11.19.02.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 02:21:42 -0800 (PST)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        rostedt@goodmis.org
Cc:     james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        nsaenzju@redhat.com, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, mingo@redhat.com,
        mtosatti@redhat.com, nilal@redhat.com
Subject: [RFC PATCH 0/2] KVM: arm64: Host/Guest trace syncronization
Date:   Fri, 19 Nov 2021 11:21:16 +0100
Message-Id: <20211119102117.22304-1-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small series introduces the necessary infrastructure to be able to
syncronize host and guest traces. The approach I'm following is a bit
biased since I tried to replicate the methods I've been using in the
past with x86.

This was tested on an Ampere Mt. Jade based machine.

---

Nicolas Saenz Julienne (2):
  arm64/tracing: add cntvct based trace clock
  KVM: arm64: export cntvoff in debugfs

 arch/arm64/include/asm/kvm_host.h    |  1 +
 arch/arm64/include/asm/trace_clock.h | 12 ++++++++++++
 arch/arm64/kernel/Makefile           |  2 +-
 arch/arm64/kernel/trace_clock.c      | 12 ++++++++++++
 arch/arm64/kvm/Makefile              |  2 +-
 arch/arm64/kvm/arch_timer.c          |  2 +-
 arch/arm64/kvm/debugfs.c             | 25 +++++++++++++++++++++++++
 include/kvm/arm_arch_timer.h         |  3 +++
 8 files changed, 56 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/include/asm/trace_clock.h
 create mode 100644 arch/arm64/kernel/trace_clock.c
 create mode 100644 arch/arm64/kvm/debugfs.c

-- 
2.33.1

