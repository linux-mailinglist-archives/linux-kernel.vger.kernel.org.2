Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92E443244E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 18:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbhJRQ6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 12:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbhJRQ63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 12:58:29 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46B0C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 09:56:17 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id u21so1087386lff.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 09:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mbcT0T8xq3XNgTUXqz2+ByWnayp/uSOsy9ph+kQ6X0c=;
        b=brUiTfjwok4PjD9QSS7nohCKMG/OAWw2099UKmKCx2sDMlEszUHThA3nA2iu3edZqA
         hfiIKhuk/w4KVkdgUGEYr+Cs781f7Ads6b0Tem/q5k9eCEI6twkIpyWH2C29mgJfmDnU
         AYYaeBx983h7VMUstKCpPwcqHvA20ksMdMalPPQzPrp8PzA+sKrbP3CscsSvKM0xjOKk
         dOp4NN2P2ZhKNN+2CY84w6vBCMf0fd7jnF/RHegjSR1plc4ITno/qF9/ArpNX9GSMJvj
         dgCAjZDfMIQTFoDV7VUFg3RjhTE40gxS1b8JV1yhfVYtJhpOR+0yg+03eRR2DeQfq2L/
         qdFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mbcT0T8xq3XNgTUXqz2+ByWnayp/uSOsy9ph+kQ6X0c=;
        b=I/s2VmNBOunijamIA1wcp6vqgn7h8BgkdsXQ0e9WIQdAEg9KWtwggiFyf0NN7qCtYO
         PaQctX918VmtMlYXG4mArwV9hyKWi2yG3C9iBVdM0rlQpV1gBNK+V4Ed7PkDTbAgsc+X
         hAa8HO/c02fLekUAUDQjPKZsLu7xLASQh2QK4AjCZiAl4IL3SgILz5odXVMSfcBDdPXx
         v7c+yrJpzaJF8eFaXRzXF2X69qbIRGzG01TWiLTrZla9x5fOePGyi1sxSjcIXkWmEU4c
         t/c+Kg4CXon/9cwLY/oUTArqpbOSRHmm6fioK/zf3fMPn0rohJM23DOm96YcxJ/u0QL8
         UYbg==
X-Gm-Message-State: AOAM531K30Nvl0jkgZwL4cx6GprqNFMxrP/5ydSlnmfZQwLovXQHjgAD
        nGQ3qVOlfaEMBWJ/0bJ9ixgSSw==
X-Google-Smtp-Source: ABdhPJzCtIOVITAIH8oBwslvWDq2511jciAklJX/W9tpWjXJYrJVmUC/9J34+JDycxoPInCrEQ+/uQ==
X-Received: by 2002:a19:f20b:: with SMTP id q11mr867056lfh.48.1634576176245;
        Mon, 18 Oct 2021 09:56:16 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id g10sm466460lfu.103.2021.10.18.09.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 09:56:15 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 88DDB10309A; Mon, 18 Oct 2021 19:56:19 +0300 (+03)
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
Subject: [PATCHv2 0/3] Add generic MMIO instruction deconding to be used in SEV and TDX
Date:   Mon, 18 Oct 2021 19:56:11 +0300
Message-Id: <20211018165614.20153-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both AMD SEV and Intel TDX has to decode MMIO instruction to be able to
handle MMIO.

Extract insn_decode_mmio() from SEV code. TDX will also use this helper.

v2:
 - insn_get_modrm_reg_ptr() returns unsigned long pointer now (PeterZ);
 - Handle insn_get_opcode() failure in insn_decode_mmio() (PeterZ);

Kirill A. Shutemov (3):
  x86/insn-eval: Introduce insn_get_modrm_reg_ptr()
  x86/insn-eval: Introduce insn_decode_mmio()
  x86/sev-es: Use insn_decode_mmio() for MMIO implementation

 arch/x86/include/asm/insn-eval.h |  13 +++
 arch/x86/kernel/sev.c            | 171 ++++++++-----------------------
 arch/x86/lib/insn-eval.c         | 104 +++++++++++++++++++
 3 files changed, 157 insertions(+), 131 deletions(-)

-- 
2.32.0

