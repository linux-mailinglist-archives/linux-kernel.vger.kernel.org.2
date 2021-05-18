Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA73F388189
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 22:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352228AbhERUmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 16:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbhERUmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 16:42:17 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98529C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 13:40:57 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id i12-20020ac860cc0000b02901cb6d022744so8236200qtm.20
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 13:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IfF2H1j3I1t32Qp6CZlQegbMzyiGyECr+WNser52IpQ=;
        b=H1+CLq87C5xK1VRznrjO+ht+yPAucXYxPJ5BM6bLjABg5c2lojiuq31aQ/OaYSx+Vf
         N4UxQ+D0dy8jCjOcy7LIDJbrk3Zln4nuigGUAVN3FcENOwcThk+afw1WTjRJL7hJ+3A8
         gcSirCtASOf8fIdxlSpjbop5rXxXYKH11QM3yUBu9B5Gt/2pmkkYFsUjOep6X89iubnU
         AcjqcYMa5GjIWoTdkUdNc5LLSQyy48gLemx2efyuRboWtFv4txbBIcnccFr+VjBbEPAX
         9XxOyWfTabF8/mXSc8sNRUxf55+e7LaoHC04RksFtW5n2TkuyxWyJ3dUlibMfyMRbAeh
         2QTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IfF2H1j3I1t32Qp6CZlQegbMzyiGyECr+WNser52IpQ=;
        b=OsX5tiGEI1dgwjvgh3NdWjgNG+df5LoYeH6SL6pHGrtz5uUFDsFLlROg72ldXRcvXn
         wRf0FAFYbraokrIOeK9wqFYU6eMRyE9kUaA03sbM4C5NFF9b4iq1tY3GqkHARQOh6K55
         kB5ooF8SKntb9FYeTrDeZfzvXWx1PY9MTOvQAjePeausnN9ox64c5tKehkh7A0DLhhPy
         qRP6GtCzOfd11QyOtJ8lZthdL2y0+KM2oEG7wtyMdTRRcVqPV+/6cl02fxX86o4Lfbfq
         TzZHfzBrXghrK2CR+uQbbYw1sJO1PzZbRKROrQ+vOQrNhRsXDFDvMfHCiQNH+13jUBcT
         Fq7A==
X-Gm-Message-State: AOAM530j591BOlBjMBqghI/wjkGEKhoDPfK08J88Kw3D41oUbJzoeVm7
        YabIQUAZY1aLuIH9lLcPGefa1QpxJAmzFstUBlM=
X-Google-Smtp-Source: ABdhPJwL37MmHN+duACl9QYa5rSGSQ/1t1hbZdxtQ5vtPTJbJh7hWSFoOj8MSc1j7MlvRsj+NdUiwGaleaJgrPPWceg=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:c3e7:2f43:8f78:4b8f])
 (user=ndesaulniers job=sendgmr) by 2002:ad4:446c:: with SMTP id
 s12mr2008135qvt.34.1621370456656; Tue, 18 May 2021 13:40:56 -0700 (PDT)
Date:   Tue, 18 May 2021 13:40:41 -0700
In-Reply-To: <87cztok1r5.fsf@mpe.ellerman.id.au>
Message-Id: <20210518204044.2390064-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <87cztok1r5.fsf@mpe.ellerman.id.au>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH v2] powerpc/powernv/pci: fix header guard
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     "Oliver O'Halloran" <oohall@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Joe Perches <joe@perches.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While looking at -Wundef warnings, the #if CONFIG_EEH stood out as a
possible candidate to convert to #ifdef CONFIG_EEH.

It seems that based on Kconfig dependencies it's not possible to build
this file without CONFIG_EEH enabled, but based on upstream discussion,
it's not clear yet that CONFIG_EEH should be enabled by default.

For now, simply fix the -Wundef warning.

Suggested-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: Joe Perches <joe@perches.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/570
Link: https://lore.kernel.org/lkml/67f6cd269684c9aa8463ff4812c3b4605e6739c3.camel@perches.com/
Link: https://lore.kernel.org/lkml/CAOSf1CGoN5R0LUrU=Y=UWho1Z_9SLgCX8s3SbFJXwJXc5BYz4A@mail.gmail.com/
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/powerpc/platforms/powernv/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index b18468dc31ff..6bb3c52633fb 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -711,7 +711,7 @@ int pnv_pci_cfg_write(struct pci_dn *pdn,
 	return PCIBIOS_SUCCESSFUL;
 }
 
-#if CONFIG_EEH
+#ifdef CONFIG_EEH
 static bool pnv_pci_cfg_check(struct pci_dn *pdn)
 {
 	struct eeh_dev *edev = NULL;
-- 
2.31.1.751.gd2f1c929bd-goog

