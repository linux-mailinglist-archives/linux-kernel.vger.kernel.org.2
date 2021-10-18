Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72FC4322F1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 17:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbhJRPft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 11:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbhJRPfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:35:45 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C92C061745
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 08:33:34 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id t9so612820lfd.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 08:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8EDzkh2mrKfuyzPQUpymiYZWQumIf6fFE5eW3wZ5cNU=;
        b=PNmzELn/RUoqnGcsoZ/h+kH2Bn5QmyDn1wgXqX26wWJQl+5IQ9cjF2zuOGqquSnhOX
         VWmteF7BEB3DpDP3+AfsKHp9WfUdB0g8Ry+LK1nXLZlrQWe7Z3X4EygwvLblhlNKaT+w
         Eb9Wj91hH0bR5+Z7MggDlmEFCRZdH6a8NNJXXN9s9Z5EiGs3OJkYRiPNVGevjNJhaups
         qDfToB5uSFe6Th/pvzVbsOSZPfN7HNVYoeOI8vsbqIXSMYH8TJEYfFUgACpw9DPFTUE4
         IusDYVCUNGpIGGqiCLAu2jvTs7rcJvtqll7tPorXZLn/q3gz3rpE0xfxEVsqnCuDOQhq
         1npQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8EDzkh2mrKfuyzPQUpymiYZWQumIf6fFE5eW3wZ5cNU=;
        b=s8kK0RT9+JMi1UXlSXPSTqQ6WOsr6FNn7+cv1aeaijFRx3XDSUgwiXLGfpQWGJNk4W
         ndJQEicZBeeAuuCChh2qbw69EPOeU7uafkeyBNyT+2mE0kLewrXJOo+6czn4Wo4u8rgC
         G7nsUH69FMGIbzjGVwH8sEoXHAm9CUOwKphBzugTkjsiXUWuYhLjC8GiloUxKWadMMml
         r2mW405FzJpAvKnnXTCEle2KR4gbQBAnLyF/RVlIL7gZ8uLC0TIqzdZEhYB0TOECA5i7
         VW5LpW7mJtJN2pmuWYh6817dKFADjf7oLhAv5H0uDoMENCWSLFY/glRHKgXK78dUNPov
         E45w==
X-Gm-Message-State: AOAM5311YzWufJcQO115v6tQlOD2Au/lSJEhIxh+3/ojHIftclWYFum7
        i5Wxexxt/rKigpbdvkYoibykDA==
X-Google-Smtp-Source: ABdhPJwaEbm+XEo59nKz13ShzVeUlOUkoy1l2VHYplbqhvskI7gORMVvGwfqMwIRhXkxohki/952UA==
X-Received: by 2002:ac2:4c51:: with SMTP id o17mr392572lfk.457.1634571212838;
        Mon, 18 Oct 2021 08:33:32 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id v7sm1770181lji.81.2021.10.18.08.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 08:33:31 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 0F0E510309A; Mon, 18 Oct 2021 18:33:35 +0300 (+03)
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 0/3] Add generic MMIO instruction deconding to be used in SEV and TDX
Date:   Mon, 18 Oct 2021 18:33:30 +0300
Message-Id: <20211018153333.8261-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both AMD SEV and Intel TDX has to decode MMIO instruction to be able to
handle MMIO.

Extract insn_decode_mmio() from SEV code. TDX will also use this helper.

Kirill A. Shutemov (3):
  x86/insn-eval: Introduce insn_get_modrm_reg_ptr()
  x86/insn-eval: Introduce insn_decode_mmio()
  x86/sev-es: Use insn_decode_mmio() for MMIO implementation

 arch/x86/include/asm/insn-eval.h |  13 +++
 arch/x86/kernel/sev.c            | 171 ++++++++-----------------------
 arch/x86/lib/insn-eval.c         | 102 ++++++++++++++++++
 3 files changed, 155 insertions(+), 131 deletions(-)

-- 
2.32.0

