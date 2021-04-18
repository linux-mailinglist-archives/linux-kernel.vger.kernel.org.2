Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A86736369C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 18:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhDRQa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 12:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbhDRQa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 12:30:28 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3585AC06174A;
        Sun, 18 Apr 2021 09:30:00 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id lr7so416846pjb.2;
        Sun, 18 Apr 2021 09:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=plYJzTMB4IF8o2Kb1fTizM5x9MX/++4z6Vb+EGhKM7k=;
        b=u5Nl6WGisgzkSfSXdEyX/z1/JV/ZI2TZHmarj5QrnYgwtHv/wLVu0p4E60Z5r68Y8J
         IizTuR3wz6SnjY3p0Dq8oVwhumO/+yw1j1YGIOSpEZzroLaRbIPqwdaUTbyjre/i8PGH
         HAKj0iIO8gCj5J4uLeRNZewgk+/2fGXdHdDecfiJeAl6Y9bWr8ROGUE7RwJnei4yyRQU
         QUf4DI6RGELxrpnBi0AXN1SwR9IWmHBZgi971jOU1iBIXTdDHAxfH1mMcAooMQuJz/FS
         10VyLaCXS59/Gy3CMGHQFyFIoKl/E1AsCog7qJ7lD3f3BDWrpJrynVMyz/jPcR5JGZix
         MTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=plYJzTMB4IF8o2Kb1fTizM5x9MX/++4z6Vb+EGhKM7k=;
        b=RIiapqiYfIxEpXawwP60VW6kmKQQSmS0w3pCdyZJR9KtahrpSoMCUbiyjhJhs0SLlA
         Z3x8O9CGt6fs76e6F0/iTM0Wk0jiRGr3bTiwdH/+TD2fXRu/bSDTuKjP12HDIofJhSRx
         yx3/Vr5Hztw4yd7Pppg71kbf8BGsy8a/G+orsu3atNeZU9BA8mu/1XDi98flJcN7MnvY
         gEnon4CFkcm460ZlzQUdupAKlgpB/PbICWg9tR6vgFMXwKQVajx27/lLbqd22L/tzmp8
         9C+j9AzlKSIBIzW4UQnOH1P8HpfQpFSkUcFZ/eDxAYoN1IgwuZp3imwg7+taUt1nQt69
         /u/w==
X-Gm-Message-State: AOAM531S3gykvtkbOcjQigu+2w4pfpIT6ymkRCwg6J5RnC0SBUzw8edE
        IHhL5yr+nWOhAxCLmbRE3RgrEKq0RTY8FMBeLTQakEC0
X-Google-Smtp-Source: ABdhPJw1i3nbu6NUC290ON9ySjibhbPkCNjsFcFfquSfj1kq/ebowiG+AclwHKjsoUEuLLbZKEF07w==
X-Received: by 2002:a17:90a:c203:: with SMTP id e3mr20059164pjt.173.1618763399819;
        Sun, 18 Apr 2021 09:29:59 -0700 (PDT)
Received: from localhost.localdomain.local ([43.128.12.3])
        by smtp.gmail.com with ESMTPSA id i131sm3550292pgc.20.2021.04.18.09.29.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Apr 2021 09:29:59 -0700 (PDT)
From:   Liang Zhou <lullaby2005@gmail.com>
X-Google-Original-From: Liang Zhou <zhoul110@chinatelecom.cn>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        zhoul110@chinatelecom.cn
Subject: [PATCH] docs: fix the invalid vt-d spec location
Date:   Sun, 18 Apr 2021 09:29:46 -0700
Message-Id: <1618763386-29562-1-git-send-email-zhoul110@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the invalid vt-d spec location.

Signed-off-by: Liang Zhou <zhoul110@chinatelecom.cn>
---
 Documentation/x86/intel-iommu.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/x86/intel-iommu.rst b/Documentation/x86/intel-iommu.rst
index 099f13d..e95ee34 100644
--- a/Documentation/x86/intel-iommu.rst
+++ b/Documentation/x86/intel-iommu.rst
@@ -4,7 +4,7 @@ Linux IOMMU Support
 
 The architecture spec can be obtained from the below location.
 
-http://www.intel.com/content/dam/www/public/us/en/documents/product-specifications/vt-directed-io-spec.pdf
+https://software.intel.com/content/dam/develop/external/us/en/documents-tps/vt-directed-io-spec.pdf
 
 This guide gives a quick cheat sheet for some basic understanding.
 
-- 
1.8.3.1

