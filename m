Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25143AFB5D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 05:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbhFVDXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 23:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbhFVDXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 23:23:53 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B9CC061574;
        Mon, 21 Jun 2021 20:21:37 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id j12so620235qtv.11;
        Mon, 21 Jun 2021 20:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tg/j861/b54HVSOeClLT8QfFckb9TmiVSdubGvNwtSU=;
        b=ORSfYcN8IwFmo9qTvMX0yuoION5QXuA82EV0y7lz2XatYKNee5Ri/dLT93GaApKIg7
         gSUSw05+KUpFtGUu0rLkzrpXeQa45tZDlIZYbeDUd99ZrkRpq3yIn5vH6iHnPaXtiqjC
         2AxJh2fmF6epsjtdxA3WZvPiCEZeDtD/SIBwxhJrsBbYbOQjof/iLI1+X1qCTcBjAdCl
         WAd9bQ7HqxYRUuQKcpdVaxcdrlzxm4HXSj1Eibel7cGvbENtHMSnM5fDBXQloOlYpz3q
         Rj6cxh/QdEM89xg8vRszWSoCuKLloRXrLWJrOiML8a4mjniL2mI+scx1WiHWkdbRziPQ
         lEVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tg/j861/b54HVSOeClLT8QfFckb9TmiVSdubGvNwtSU=;
        b=eUUdLIctOpn1gDDj1wUXel1SdpUftmzjIzxTzu+hYAYlg2S1Y4YTfJaxaClccW87RQ
         l00EfzPycXMO2Mr0CSuv3fytQBqnymzECg7NmSZrChw2FFAHJ6kd4LPwMM9IcytT5D5T
         Ygl+XkRJMqo3aCmnN7g0hCM6Fv/O8fzwmSVHETrQRYmtgAgrDtAfWHIRSIh0kfE066yH
         YsRQ3kd+W7x2NQokOyFpRskYez9bppMzSxnoLYaf9XLCFC9+Shf/8YUap0p0LS1bbeaJ
         9BhbS+HycnBxhBV3swP9KEs29B2Fit96BJgnqf32ewjYR1l0OizapgPztdohk0NOZoZL
         yQ1Q==
X-Gm-Message-State: AOAM530VXf5VOF7hkUExzhf5pdTF35BlCXdBG3z1hlhxfMK90U17PWVm
        amy8RbfdhSjU52ng1yakNQ==
X-Google-Smtp-Source: ABdhPJwulfis05xxcZtcUkeFIlRp7hYtaS+/X+LDIPdtaCiZP0jTKb2VehoBHn+N+oXpzvJvM2nXjQ==
X-Received: by 2002:a05:622a:c1:: with SMTP id p1mr1649816qtw.231.1624332096237;
        Mon, 21 Jun 2021 20:21:36 -0700 (PDT)
Received: from localhost.localdomain ([209.94.140.245])
        by smtp.gmail.com with ESMTPSA id o15sm791308qtw.5.2021.06.21.20.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 20:21:35 -0700 (PDT)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Zefang Han <hanzefang@gmail.com>,
        Wei Lin Chang <r09922117@csie.ntu.edu.tw>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Peilin Ye <yepeilin.cs@gmail.com>
Subject: [PATCH] docs: x86: Remove obsolete information about x86_64 vmalloc() faulting
Date:   Mon, 21 Jun 2021 23:19:10 -0400
Message-Id: <20210622031910.141262-1-yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86_64 vmalloc() mappings are no longer "lazily synchronized" among page
tables via page fault handling since commit 7f0a002b5a21 ("x86/mm: remove
vmalloc faulting").  Subsequently, commit 6eb82f994026 ("x86/mm:
Pre-allocate P4D/PUD pages for vmalloc area") rendered it unnecessary to
synchronize, whether lazily or not, x86_64 vmalloc() mappings at runtime,
since the corresponding P4D or PUD pages are now preallocated during
system initialization by preallocate_vmalloc_pages().  Drop the "lazily
synchronized" description for less confusion.

It is worth noting, however, that there is still a slight complication for
x86_32; see commit 4819e15f740e ("x86/mm/32: Bring back vmalloc faulting
on x86_32") for details.

Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
---
Hi all,

I was trying to understand vmalloc() when I saw this "lazily synchronized"
statement, which confused me for a while.  Please correct me if my
understanding is wrong or out of date.

Thank you,
Peilin Ye

 Documentation/x86/x86_64/mm.rst | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/x86/x86_64/mm.rst b/Documentation/x86/x86_64/mm.rst
index ede1875719fb..9798676bb0bf 100644
--- a/Documentation/x86/x86_64/mm.rst
+++ b/Documentation/x86/x86_64/mm.rst
@@ -140,10 +140,6 @@ The direct mapping covers all memory in the system up to the highest
 memory address (this means in some cases it can also include PCI memory
 holes).
 
-vmalloc space is lazily synchronized into the different PML4/PML5 pages of
-the processes using the page fault handler, with init_top_pgt as
-reference.
-
 We map EFI runtime services in the 'efi_pgd' PGD in a 64Gb large virtual
 memory window (this size is arbitrary, it can be raised later if needed).
 The mappings are not part of any other kernel PGD and are only available
-- 
2.25.1

