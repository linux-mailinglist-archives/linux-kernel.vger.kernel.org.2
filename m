Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A07843A494
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 22:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236374AbhJYU1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 16:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235943AbhJYU06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 16:26:58 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99952C06965B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 13:13:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id w199-20020a25c7d0000000b005bea7566924so19171377ybe.20
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 13:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=c9TMSSQDkdJckQqgk1hQJ6Z3xWFgZz2oJuTapjWnAto=;
        b=Hmmi585al96YhjrNsBozCKeUSsjxcY+9cb3dVhw8c8LAOlBpL6FI6zre4ofU/j2I/J
         V862W70ij9ivO1OZv5jdgJxaJ15S8Ia/rZT6P7IabKA/GJNEUL6a0wqOS32GO/wzzTtF
         Hx5w4djmSNoIi4SvDjNkaq5c/xl2t986X98KgD2AV3CZkE+ajJ/ANEYrZsaVGkx5CYa5
         7mhxXq5Byy5xgwFmlSplm6VWUcQobVycDE9HXKM5DooNjtSD2FtuwkkQRDeDFVnrUGRG
         ifhMl9/CMlLQ8EMsnorspXLn48zgLAklfYbmFEDiPYTggB7skFlhjYV32yZ8wKlb5Oe+
         29qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=c9TMSSQDkdJckQqgk1hQJ6Z3xWFgZz2oJuTapjWnAto=;
        b=ULRRrxpPVM1Jl47bVlnPyHpBQfNN/3/+h1f0DeGdubRvq5yCwWc5C9r9SkFUM0RdgH
         mH9PDgxUx5VCqfbPIfchQP+CPqoTbrnhriH+95VEKaYWT0nLcJeXOCX84WuSqlR+Fl82
         wCGqcvsjUKtIDW45JfSKiy1XSKtZtg5COfuePpd3E2NTswRfx8a/f0MbgBDlYK5A6wgm
         2ucQsaKd1y8NUzdcYMlepDzJjWVw1Xm/a5NoVoB+keeB7dIXco1+/tXTV9MiIQ2uJpWe
         mX8/Lq4Ug5Lp8BhdQYQUazx2x/knwM/MV0Au31RrLcp1v282s0FDPEBjBrqWONHPa/gy
         xsLA==
X-Gm-Message-State: AOAM533Xs+Ws4avFJ/WLHiOiEIJkWlICDhJCnsEqci2XzCYrMSa3DQZC
        g00+02GVI0o7Um1zh/SQ8B3Adfb7dfA=
X-Google-Smtp-Source: ABdhPJzn6GPUNwCw/iEfKewQMUshkaPgozSQ1anxYst/oAgSpVR/9rUQxDjo0whaxXVvN0vFpNOzpYrJQlc=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:ffbb:dc28:15d8:6cdc])
 (user=seanjc job=sendgmr) by 2002:a25:c88:: with SMTP id 130mr19489124ybm.176.1635192793836;
 Mon, 25 Oct 2021 13:13:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Mon, 25 Oct 2021 13:13:09 -0700
Message-Id: <20211025201311.1881846-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH 0/2] KVM: x86: Rep string I/O WARN removal and test
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a WARN that was added as part of the recent I/O overhaul to play
nice with SEV-ES string I/O.

For the record, my FIXME in lieu of a WARN was deliberate, as I suspected
userspace could trigger a WARN ;-)

Based on kvm/master, commit 95e16b4792b0 ("KVM: SEV-ES: go over the
sev_pio_data buffer in multiple passes if needed").

Sean Christopherson (2):
  KVM: x86: Don't WARN if userspace mucks with RCX during string I/O
    exit
  KVM: selftests: Add test to verify KVM doesn't explode on "bad" I/O

 arch/x86/kvm/x86.c                            |   9 +-
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/x86_64/userspace_io_test.c  | 114 ++++++++++++++++++
 4 files changed, 123 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/userspace_io_test.c

-- 
2.33.0.1079.g6e70778dc9-goog

