Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B7934C2D8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 07:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbhC2FQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 01:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhC2FPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 01:15:41 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E543C061574;
        Sun, 28 Mar 2021 22:15:41 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id g20so11408741qkk.1;
        Sun, 28 Mar 2021 22:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9E5lwVVMPFlPDvt7erVKylfE9P5XxckNHLW8/31JcNw=;
        b=E+OEDHgkYPiiknbl4EqkqsOU+hsHKW20+J8ideezGsnMozalJiB9Qt9fVY8MMsR0RO
         cSAvg8hAIhymzFIXByrFRazYXzSB1Ng9Lb6utLb28nePOrU4kIRs6U8enuTCmZOQ2dnv
         aWuN5Nppay19e5yKLx4fwF1W3KSiCoU6nw8MSNMLso6ord27ofuUiuxauSM0etv8T0t0
         z8U2GBuN9zFV8iLXHIPt27EsJqNQWmRzdNCYqlmt9lQSzDY76Meqc5RWnadFHS+V6wS0
         lMntqh4auugyZji5lh/D5TrnDaJi4KXlq7jHO/TEFnqi5DSb9qhUZRrQHIpmVZQZhLQu
         9s7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9E5lwVVMPFlPDvt7erVKylfE9P5XxckNHLW8/31JcNw=;
        b=kt6h1jAm2VbFqCBBFHDytytVCvSDy52YZR1nrtK6bO5RpMEdhZad8A+C8Pcg110q76
         uDhwm0swrAOjp1rQAXOq28F8fluaocMkrwpo33sfrPzmDWOJMLMjtB0bXdbmG/H8co1V
         iCDXoeQqR+7p7Pv09+efBity3TrItgCP686GEMvcsiXlw2WL8IDG3J1mwfLBpGqWcLtl
         IU5zRPmb2P0PPky/DLC7X0KQmLZzbJeDGPs37TltvkChKZc84fKxvADEutcs2vyytZL4
         XTG4Ncz7ML87/JtjiWI1aphDl1IDvmya1Rm7HUSVhXT7V7eZ/BHJKp0rhmNwWAFxXUHh
         GNlQ==
X-Gm-Message-State: AOAM5302JRDZdODhSQEEG4bcrYlPVByVbgYxZjj6OF2M88F+3Gcrijt1
        ZFsLpnGFVGzKkyEuBx0I4Tc=
X-Google-Smtp-Source: ABdhPJxYaowbcvqCU904w4MFX0D+Cq/LQBx/fCAy7Rsmsf5zIvK339fvi51n1GuY1Uu/ekGXcqlhGg==
X-Received: by 2002:a37:4017:: with SMTP id n23mr22465636qka.338.1616994940691;
        Sun, 28 Mar 2021 22:15:40 -0700 (PDT)
Received: from localhost.localdomain ([156.146.37.195])
        by smtp.gmail.com with ESMTPSA id z124sm12993181qke.36.2021.03.28.22.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 22:15:40 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/23] vm: unevictable-lru.rst: Fix a typo
Date:   Mon, 29 Mar 2021 10:42:41 +0530
Message-Id: <dd0a854c59729abe2cca69db5a952857a93475af.1616992679.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616992679.git.unixbhaskar@gmail.com>
References: <cover.1616992679.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/mmaped/mapped/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/vm/unevictable-lru.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/vm/unevictable-lru.rst b/Documentation/vm/unevictable-lru.rst
index 0e1490524f53..74e7d5ded114 100644
--- a/Documentation/vm/unevictable-lru.rst
+++ b/Documentation/vm/unevictable-lru.rst
@@ -467,7 +467,7 @@ In addition the mlock()/mlockall() system calls, an application can request
 that a region of memory be mlocked supplying the MAP_LOCKED flag to the mmap()
 call. There is one important and subtle difference here, though. mmap() + mlock()
 will fail if the range cannot be faulted in (e.g. because mm_populate fails)
-and returns with ENOMEM while mmap(MAP_LOCKED) will not fail. The mmaped
+and returns with ENOMEM while mmap(MAP_LOCKED) will not fail. The mapped
 area will still have properties of the locked area - aka. pages will not get
 swapped out - but major page faults to fault memory in might still happen.

--
2.26.3

