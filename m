Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3855A3638E9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 02:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236954AbhDSA4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 20:56:37 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:46685 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbhDSA4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 20:56:31 -0400
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 13J0u0FX011027
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 03:56:00 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1618793755; x=1621385755;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rEmZ8MA7Mmcm1B3W8WjBdSUosxLDHFbHVrbU4iEAoGY=;
        b=bkfr8VsqmbGkclM0AXFQxA6auVIAgLUl5JUWAj4wzRYSlXuZnAQvRAtZMdZEtXJ7
        fYRcvDb/YJrxlut0r4nkkeCxijTCUhtxbi2K8E4xz7MGsCgZ+yBOekMhCU8sxZej
        3jfjz3n6GpXpQMJBDUi4sOyWMJmMkhWWQ1X0UEaPGE/Mtp50vGc9Ap4EosGMhdSb
        H9fGnq+JdquTT/pPxw+epoptFmoeAk5Ja2TUvcWmwD53vC5s+ulkhVFuX+2I22SY
        nK29bcZqelW0YsrzEUYWvLnDoXmR44/zfdy2sqaUU3X2eJlc8akgOirK2ff4BMJi
        cJjt955JQQB8OLqe5Np2BQ==;
X-AuditID: 8b5b014d-a70347000000209f-e3-607cd51bb1fa
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 04.FF.08351.B15DC706; Mon, 19 Apr 2021 03:55:55 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user: mick@ics.forth.gr at ics.forth.gr
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     linux-riscv@lists.infradead.org, palmer@dabbelt.com
Cc:     paul.walmsley@sifive.com, linux-kernel@vger.kernel.org,
        Nick Kossifidis <mick@ics.forth.gr>
Subject: [PATCH v4 1/5] RISC-V: Add EM_RISCV to kexec UAPI header
Date:   Mon, 19 Apr 2021 03:55:35 +0300
Message-Id: <20210419005539.22729-2-mick@ics.forth.gr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210419005539.22729-1-mick@ics.forth.gr>
References: <20210419005539.22729-1-mick@ics.forth.gr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJLMWRmVeSWpSXmKPExsXSHT1dWVf6ak2CQcMDOYvLu+awWWz73MJm
        0fzuHLvFy8s9zBZts/gdWD3evHzJ4vFw0yUmj81L6j0uNV9n9/i8SS6ANYrLJiU1J7MstUjf
        LoEr4+b6Z2wFj9gqNn3ZyN7AeIG1i5GTQ0LARGLRgf3MXYxcHEICRxkl9n3axAaRcJO4fX8n
        WBGbgKbE/EsHWUBsEQFzieaZrxlBbGaBDImj+36xg9jCAo4SZ46uBouzCKhK9O27DFbPK2Am
        cXDtayaImfIS7cu3g83nBJozZcJnsHohoJp5/+8yQdQLSpyc+YQFYr68RPPW2cwTGPlmIUnN
        QpJawMi0ilEgscxYLzO5WC8tv6gkQy+9aBMjOPQYfXcw3t78Vu8QIxMH4yFGCQ5mJRHe+7U1
        CUK8KYmVValF+fFFpTmpxYcYpTlYlMR5efUmxAsJpCeWpGanphakFsFkmTg4pRqYUk1jnmxq
        m84nJf9kzppvjq0blx1xt7ib+XSalGtJ1acGbdObV5h6jTQEts5Mn9LJeb6xUFHN8sKnxN3O
        Mpwdy3MjHj10Snvaekz44wqn8/pFL3g2VwswJ3Us9VuruW9Kd3SHalWtidREP/O9lyrn1X9r
        8JxTez0mVFeojHvaVta0rANiR+O1Pmb8WmW2wMGcU6ru84e3B28wuSquZ9RYuPDolkfhir9m
        zmR+v+5gzfmJX+7PXPvUw2fZi/I/5lZaJS2i93PjJbP35pxe6rdol92s6JJZnZ8mqmQd7La+
        yinzVXZF5c3bB5MfdX+ay2v5cr6A1MVgvbtLMhdcXi36/LB7b6HR9NPLvghFbzOTUWIpzkg0
        1GIuKk4EANdfFgmsAgAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add RISC-V to the list of supported kexec architectures, we need to
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

