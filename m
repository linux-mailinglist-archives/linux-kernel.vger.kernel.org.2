Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854D84444DD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 16:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbhKCPtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 11:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhKCPs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 11:48:58 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FA0C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 08:46:21 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id i3so6051518lfu.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 08:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LUFgqV2BeqlQdLiPN9gxuMdCmao9D8TOC5wrMIKCTOc=;
        b=fVf+NMzoGPq6KGTd45BRfVLWum48YsEIdLDF4TVmL8K7f2Bgz0yhgBdMyc4tdIITvY
         QBLrcAIHT9im5JHhnMTJnmVFDPraqJd/sqs2Xj1119W0XZIMm0wUGYcoY5g/dchxNRBa
         OPI+s9A3mVx3jJV7ZGqFdTbahHreInlzxr7Amw/npcXyDuKjTjWNWEaXrR6EU/S77hGR
         kGTkugp6VeJuy/7CD1xHucS7slzZPFtw8JeUjpenFyPerURoldrnBUjez03gSXVf2aBR
         jQgrzIWt/xUsO8GnZ20f+E5N4jCDK0dMsCwJsFPDTtUGB0REWWrNjMt7jBhIvV1m7thd
         42eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LUFgqV2BeqlQdLiPN9gxuMdCmao9D8TOC5wrMIKCTOc=;
        b=TTl53rh93lyNnrsiW/ZKqIMdHQcfRy5OM/CsdLsBAhpyeomZFKwAkgVWarB0ZgC2jH
         zQBOvRRn8H5jaKX6VAmJykHYlcbGNgSToA4eYbQru1Mm13x+cZV8WxO8jCcFsgnvEWA6
         mbAVZz2MZjXqGyqk67hyZCMUfx9M27HCmpe1p+JodvB5C5wnsst6o0UOxbO6PIj5vgM6
         IkhoF9MiC4NrDetGffOvP15lhNTqQkxhW6KVWjNkdKyGsWt6uMectSBskNlPlOijYQeW
         BHu9w62pPwYdZ23HM6zoZgI1kTUS/I9b/2TK++p6AGBvl7IsuXi8uTgtCX5YmQlqGKMX
         b4wA==
X-Gm-Message-State: AOAM533Pw860zgeXDQu9las0XmpIUIzdzirOCbIC1QgF0P8YzNDdWt/3
        Xm/sZD9B9JpOSlazKrO8OaPWzQl7xitRoQ==
X-Google-Smtp-Source: ABdhPJxWgAoHS252IWjkNnUgK0ekH385u8dmsIf0Cv4ar7mskAphkPhF6S64CZ9tBJbKyG1RBj7xuA==
X-Received: by 2002:a05:6512:3988:: with SMTP id j8mr32944575lfu.533.1635954380093;
        Wed, 03 Nov 2021 08:46:20 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id i1sm209022lfr.178.2021.11.03.08.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 08:46:19 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 90EB31033EB; Wed,  3 Nov 2021 18:46:18 +0300 (+03)
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3 0/4] Add generic MMIO instruction deconding to be used in SEV and TDX
Date:   Wed,  3 Nov 2021 18:45:51 +0300
Message-Id: <20211103154555.23729-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Both AMD SEV and Intel TDX has to decode MMIO instruction to be able to
handle MMIO.

Extract insn_decode_mmio() from SEV code. TDX will also use this helper.

v3:
 - Handle insn_get_opcode() in is_string_insn()
v2:
 - insn_get_modrm_reg_ptr() returns unsigned long pointer now (PeterZ);
 - Handle insn_get_opcode() failure in insn_decode_mmio() (PeterZ);

Kirill A. Shutemov (4):
  x86/insn-eval: Handle insn_get_opcode() failure
  x86/insn-eval: Introduce insn_get_modrm_reg_ptr()
  x86/insn-eval: Introduce insn_decode_mmio()
  x86/sev-es: Use insn_decode_mmio() for MMIO implementation

 arch/x86/include/asm/insn-eval.h |  13 +++
 arch/x86/kernel/sev.c            | 171 ++++++++-----------------------
 arch/x86/lib/insn-eval.c         | 109 +++++++++++++++++++-
 3 files changed, 160 insertions(+), 133 deletions(-)

-- 
2.32.0

