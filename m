Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0956141CF2F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 00:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347214AbhI2W0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 18:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244776AbhI2W0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 18:26:11 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A84C061767
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 15:24:29 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id q8-20020a056902150800b005b640f67812so5440199ybu.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 15:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=61sZ0SNgwXPNf3V+owOVdRofuwGz+nCq8DE4HjWKibg=;
        b=ez3i1OlGyqUrVYhHauJMvlM1c1FCO+m8e1KgiFXDez4TBDQ5jxF94Gow3OIMubd+Cs
         2Vgs6GfKJy8YRLtFWmO2ZbV/X7KMGgFVo8EFNUp3MrqfffrFiY8ipBzxxWFfaJ7Uabs6
         OwgYHJr/lxl2pSFS+HLYtjzOZPL5rRaVGl98JIoB9DBfp/f3UdCTWy1oqdalIhIBfCmG
         43yfNyg3naFolsAwlwKf/f6qypVW6M02Dj3k9XQ8MhjrOivV9wYD+m0Aq9id3QiNJeMn
         1HnV8aUazG8g/TsL/1ZvNSaOvWsa8ynZ0AqG4+gtDRFnfGz3WKNR7p8O+W6+eypp9U9y
         nmIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=61sZ0SNgwXPNf3V+owOVdRofuwGz+nCq8DE4HjWKibg=;
        b=tsW6Zkksqag9bfwTLSFkcBT4v3PRRK1Vf17ZnB8QxBsZVuBsam6hoHUNYUZSKWKM7L
         cKcGsETLe9UmAfXGb4CLGvMorZuyDo6jIsQ/K2lbDMv8VX1oEBg0rf0lZdprF9fXXn6+
         8ppTvZCY8FgCtO1vqM6mhQ7+S1J6PebQIcscSFgOxacTDxkxMHQkM2x2NtG9euvU9Y2h
         +20jSIUpRnWG5T7eYefmbEABbCfI1CvSMnQiIqV+dKizfFJLAzt3J5RMpze+qyvB2v6/
         osJ5SaKwfK27nGouHX6zvr7/ycI904Z9gOYwBC4xfxHMLP0R6NrpLf4ENM0/QVxrS73j
         6hYg==
X-Gm-Message-State: AOAM533PhiSSQNH/o1xgWQ2A626JAW9MIGGUHRhR/1o1z0JoEHD7IVdJ
        VGw+Btwct6ZusGBMvZAaK5bTz0L9+ek=
X-Google-Smtp-Source: ABdhPJyBpKqT35hufjeTkOJZFLtv7LvyNOdCDwXIBmGkHt9PaMw8GpNSrEnXhv+6j2VxNuaVWRKs+p5jgB8=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:e777:43b7:f76f:da52])
 (user=seanjc job=sendgmr) by 2002:a5b:381:: with SMTP id k1mr2731873ybp.271.1632954268965;
 Wed, 29 Sep 2021 15:24:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 29 Sep 2021 15:24:24 -0700
Message-Id: <20210929222426.1855730-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH 0/2] KVM: x86: Fix mostly theoretical undefined behavior
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+f3985126b746b3d59c9d@syzkaller.appspotmail.com,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a mostly theoretical undefined behavior bug due to consuming
uninitialized data when searching for a matching CPUID entry during vCPU
RESET/INIT.  The bug is mostly theoretical because it requires very
aggressive inlining from the compiler, as well as deliberate "sabotage"
from the compiler (which _is_ allowed by the C standard) in the face of
known uninitialized data.

Patch 1, the "fix" that is tagged for stable, is all kinds of gross in that
it doesn't directly address uninitialized data, and instead tweaks a low
level CPUID helper to avoid consuming the uninitialized data.  I went that
route for the fix so that the fix would be easily/directy consumable
downstream, as porting the fix from v5.15-rcN to literally any other buggy
kernel would require hand coding the fix due to refactoring and code
movement across files.

Patch 2 directly addresses the uninitialized data.

If patch 1 is unpalatable, an alternative would be to do a bit of merge
magic and feed in a fix to initialize "dummy" in svm.c, which was the only
buggy path prior to v5.15-rcN.  However, KVM lived from 2012-2020 with
what's effectively the behavior after applying patch 1, and no one noticed
that the behavior was broken in 2020 until v5.15-rc1 introduced the bad
behavior to VMX, i.e. opened up the validation surface to bots that
presumably run the majority of their cycles on Intel CPUs.

Sean Christopherson (2):
  KVM: x86: Swap order of CPUID entry "index" vs. "significant flag"
    checks
  KVM: x86: Manually retrieve CPUID.0x1 when getting FMS for RESET/INIT

 arch/x86/kvm/cpuid.c |  4 ++--
 arch/x86/kvm/x86.c   | 11 +++++------
 2 files changed, 7 insertions(+), 8 deletions(-)

-- 
2.33.0.685.g46640cef36-goog

