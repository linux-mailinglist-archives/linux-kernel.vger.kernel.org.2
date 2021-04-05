Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF51353D14
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 10:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbhDEI6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 04:58:17 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:56902 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbhDEI5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 04:57:40 -0400
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 1358vWaW079891
        for <linux-kernel@vger.kernel.org>; Mon, 5 Apr 2021 11:57:32 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1617613047; x=1620205047;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mIPpwtuqwCFbpjCfBOR3TLBkCrvCUYLFEkh8taAhOfc=;
        b=pwwaSblYBhSSJSM7pAEj6oqeUc+/LE/kltnkrlydWZUSTmzm0l992cgtYjeUWPEX
        Lw04Vpaj5gumdjg/r4CJBK9iapw+bIOsJxulMn+xPRrC9E6Rzzw3+WBIAtlBxiEN
        ATEQH0lYhrn0KzuBJxsgmuoFBu6Vx5PNHlmoeLY+CHh0Tl4We40901L7vkPOeHVB
        G7HRFSQm6qBYOa7g4qCkY2hnIIoVlkzg907ZTXE4DpPUXsuMtD3POHYnyEL/K0aT
        atqCL3aa6/fb/SBPGluvRDhRkX6B4yoBEpkZkxWmcG+VsJkK2hM/KPJDX03LbO0+
        qJ+BZYBLZY1/1V73ZvnxWg==;
X-AuditID: 8b5b014d-a4c337000000209f-d8-606ad0f7e44b
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 87.77.08351.7F0DA606; Mon,  5 Apr 2021 11:57:27 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user: mick@ics.forth.gr at ics.forth.gr
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     linux-riscv@lists.infradead.org, palmer@dabbelt.com
Cc:     paul.walmsley@sifive.com, linux-kernel@vger.kernel.org,
        Nick Kossifidis <mick@ics.forth.gr>
Subject: [PATCH v3 1/5] RISC-V: Add EM_RISCV to kexec UAPI header
Date:   Mon,  5 Apr 2021 11:57:08 +0300
Message-Id: <20210405085712.1953848-2-mick@ics.forth.gr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210405085712.1953848-1-mick@ics.forth.gr>
References: <20210405085712.1953848-1-mick@ics.forth.gr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJLMWRmVeSWpSXmKPExsXSHT1dWff7hawEg1l3pCwu75rDZrHtcwub
        RfO7c+wWLy/3MFu0zeJ3YPV48/Ili8fDTZeYPDYvqfe41Hyd3ePzJrkA1igum5TUnMyy1CJ9
        uwSujJnt5xgLHrJVLPrTztbAeJ61i5GTQ0LARGJJ4yT2LkYuDiGBo4wSf7eAOCAJN4nb93eC
        FbEJaErMv3SQBcQWETCXaJ75mhHEZhbIkDi67xdYvbCAo0R3wzwmEJtFQFXiRetxsHpeAQuJ
        358XQS2Tl2hfvp0NxOYUsJTYdn4RWL0QUM31Yz2MEPWCEidnPmGBmC8v0bx1NvMERr5ZSFKz
        kKQWMDKtYhRILDPWy0wu1kvLLyrJ0Esv2sQIDj1G3x2Mtze/1TvEyMTBeIhRgoNZSYT3YUNW
        ghBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFeXr0J8UIC6YklqdmpqQWpRTBZJg5OqQam7VeuK5dt
        vSrOeO7NxCVM3H6HnAIrF0ioG17u6n9x+5v20xl/22Z6vLdhbJHe5Phx6dqVh9Qj8wp/OTgk
        5lldMYzj+CUpvda10PXFERunXF4ld89Pqh/ZYg/USIXsFFTxONz4IviLgdx+Hf32jZvs6g3N
        vk7JD3s6aW3IwiXHZ8j/v/kw1ZtF7DHjvbvucxLC1Crk79maRUrNeK+0eIOo0aUIJb3Eyhv6
        n5jYjif4pq7bz6d+Kn+LJ8+NzrM9iWIiD4JKf7E28q+LvdH6/g+n5SLrpKK51y9/Lyk6zDkr
        vmqicXJC8/c3B3dMfjzF9bfe9ls3newbU189rzmaqPbe113367NtkZVSu+t8/99RYinOSDTU
        Yi4qTgQAgxNljqwCAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add RISC-V to the list of supported kexec architecturs, we need to
add the definition early-on so that later patches can use it.

EM_RISCV is 243 as per ELF psABI specification here:
https://github.com/riscv/riscv-elf-psabi-doc/blob/master/riscv-elf.md

Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>
---
 include/uapi/linux/kexec.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
index 05669c87a..778dc191c 100644
--- a/include/uapi/linux/kexec.h
+++ b/include/uapi/linux/kexec.h
@@ -42,6 +42,7 @@
 #define KEXEC_ARCH_MIPS_LE (10 << 16)
 #define KEXEC_ARCH_MIPS    ( 8 << 16)
 #define KEXEC_ARCH_AARCH64 (183 << 16)
+#define KEXEC_ARCH_RISCV   (243 << 16)
 
 /* The artificial cap on the number of segments passed to kexec_load. */
 #define KEXEC_SEGMENT_MAX 16
-- 
2.26.2

