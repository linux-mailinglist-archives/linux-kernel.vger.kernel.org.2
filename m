Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32CAA3EDDA1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 21:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbhHPTHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 15:07:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:58372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229781AbhHPTHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 15:07:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DCB6860EAF;
        Mon, 16 Aug 2021 19:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629140793;
        bh=gbVkho5GRcWxEMUkS1t6U/1oMavMPJ9b9Lt9m90EGU8=;
        h=From:To:Cc:Subject:Date:From;
        b=mpi6Ef+mJXSBdBWk+F+3oijcYsOfFhmL3URC5d3XPE7wskFuT2pd6bCz9L5Vpw7zN
         y92eb7fakfdglM9mf7/VL9y2fqFWBQ8FjLFeHIS8Q4qrmUgG7TTBMCYFmMD16f9aDf
         QRbYI43+dnN7lOB1ms0Au97mb8AWWk3QZgiau+w/vcyHEPMhbwDzwYwq3f3vq6IOdi
         +AAGWWpB8SNwHcbS6HB5Ti4lSn1wJizoC9RqX5cVe0yFOL6kjJXYMIEDTrYn+ZShoi
         AJO/d5P60WWywzAgiMlKINJrSgrDzOVS4YG1Vp8oZrT2xI+mHU9E4kc6YwBzsNd6Qz
         JQSOVu3IyfvXA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] powerpc/xive: Do not mark xive_request_ipi() as __init
Date:   Mon, 16 Aug 2021 11:57:11 -0700
Message-Id: <20210816185711.21563-1-nathan@kernel.org>
X-Mailer: git-send-email 2.33.0.rc2
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling ppc64le_defconfig with clang-14 shows a modpost warning:

WARNING: modpost: vmlinux.o(.text+0xa74e0): Section mismatch in
reference from the function xive_setup_cpu_ipi() to the function
.init.text:xive_request_ipi()
The function xive_setup_cpu_ipi() references
the function __init xive_request_ipi().
This is often because xive_setup_cpu_ipi lacks a __init
annotation or the annotation of xive_request_ipi is wrong.

xive_request_ipi() is called from xive_setup_cpu_ipi(), which is not
__init, so xive_request_ipi() should not be marked __init. Remove the
attribute so there is no more warning.

Fixes: cbc06f051c52 ("powerpc/xive: Do not skip CPU-less nodes when creating the IPIs")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/powerpc/sysdev/xive/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index 943fd30095af..8183ca343675 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -1170,7 +1170,7 @@ static int __init xive_init_ipis(void)
 	return ret;
 }
 
-static int __init xive_request_ipi(unsigned int cpu)
+static int xive_request_ipi(unsigned int cpu)
 {
 	struct xive_ipi_desc *xid = &xive_ipis[early_cpu_to_node(cpu)];
 	int ret;

base-commit: a2824f19e6065a0d3735acd9fe7155b104e7edf5
-- 
2.33.0.rc2

