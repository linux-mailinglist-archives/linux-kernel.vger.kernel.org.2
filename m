Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC01F42B102
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 02:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbhJMAiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 20:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbhJMAh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 20:37:59 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95171C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 17:35:57 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id h8-20020a05620a284800b0045ec745583cso641211qkp.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 17:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=bNMsQGBmtJcsL+f2JEtI6WHNz/oM/2I9pWdaF81Yh3g=;
        b=ChlnA879mCqQnxov2MNS+l1VdsTIJgCGvHOgT7z9fMUaRX2oxqszjkErc6AMn6wYwm
         pu3F1wlzdvEuQvlvf74PzFpSWmXluDqygWtteGj8Mh8z0yxBDO7pS8SsTLkbrOr7vjuT
         fzcIBZJ4r8w6eHanPMcIFsmWg3mDUghkOngqTMDevB5gy8W0dtfUhj7gLeSlK8AIy6V8
         cIqVRH/Kxkz+YBiqSezxP5JvFjSQCtmnEMSCp0fb1yRIajWXb681e4jNHiPQk5vQb/Kh
         dtB5vbD5z6IW/1I4lpEdbWdMMRERQmCYeaw8TFJk+nU4TwAffumQsdSf3QzWHgDJYzfD
         dqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=bNMsQGBmtJcsL+f2JEtI6WHNz/oM/2I9pWdaF81Yh3g=;
        b=F+sfN3wTqdG4qwZhA6P2sQ1tK9T6S/LowXeoXazdGn1xULbOp/1yAd193DegquqpOF
         5FnpjAL2eyXjUjp8SA4tHzTRCROOdsTLbZ5YCKlCiOoJ9hQVrld9RyozU5c0a1SU6Bsp
         JqRoR/9W1R3aRDsm2nZUR2yoT/TBOUIqT88c3cRliDzFGOKG8vvmXAhuUO+tvX7gGRyQ
         xiUNov+HKyzvwEl6Hz+fYKyyZ9efNLs6XQXblSeiGcfYH/anmbKPngiqgKVRCko9Npd3
         3sQkfDyv65URqTZdSBF2V6PYkeiQH5xF/gPSb/1w8zOPAo8dJAlAP116hHqvW0qgtrEW
         S6Ww==
X-Gm-Message-State: AOAM532AlMP7QO7R3PJvKTved4gLFissZQWnZP+ubJ4Z0BDemXlRZf44
        Tr1Ys2+admedUV5sEZh0jjWToK2EQlo=
X-Google-Smtp-Source: ABdhPJyRTuR3nWx6ltREyOknYOe+wYccN8lUtdRJBAQdpBFepQlQhMXKfgWmb9OYSRA1ncnMYGSXnpFBcok=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:e55e:31ed:7b83:d4a6])
 (user=seanjc job=sendgmr) by 2002:ac8:5e0d:: with SMTP id h13mr25862181qtx.403.1634085356711;
 Tue, 12 Oct 2021 17:35:56 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 12 Oct 2021 17:35:52 -0700
Message-Id: <20211013003554.47705-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH 0/2] KVM: x86: Revert to fix apic_hw_disabled underflow
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+9fc046ab2b0cf295a063@syzkaller.appspotmail.com,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Revert (mostly) a patch from the vCPU RESET cleanup that open coded some
APIC shenanigans to avoid stuffing vcpu->arch.apic_base at vCPU creation,
and completely overlooked the side effects on apic_hw_disabled.  I went
for a revert as I think the original behavior is the least awful solution,
just somewhat poorly documented.

The second patch adds WARNs to detect "overflow", where "overflow" means
KVM incorrectly increments apic_hw_disabled.

Sean Christopherson (2):
  Revert "KVM: x86: Open code necessary bits of kvm_lapic_set_base() at
    vCPU RESET"
  KVM: x86: WARN if APIC HW/SW disable static keys are non-zero on
    unload

 arch/x86/kvm/lapic.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

-- 
2.33.0.1079.g6e70778dc9-goog

