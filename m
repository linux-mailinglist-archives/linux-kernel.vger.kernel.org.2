Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32C934C2F5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 07:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhC2FRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 01:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbhC2FQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 01:16:46 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E49C061574;
        Sun, 28 Mar 2021 22:16:46 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id h7so8566583qtx.3;
        Sun, 28 Mar 2021 22:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hWbihI/rNskUo3Z1Ofg/vJCTgDM+HiI+IoF/4RCkcE4=;
        b=UgIol5OM6ZSOzMV78k5xwb9vzBss/VCPzJgGUUtVTfewchWAiOChLsKuogCak3bLQC
         8538DRBmDZQ9Tdntitj1r75jBVgxIAYRqYSDGxCLH2UGcThXjQ5YL434++wQ8aZPXpRA
         q1queQ5gJtTBVj3qGFEwdI+i9CY2IF2osAegfZoM4VeUnfuPsC9rKjWnqHLyjBE9Pd6s
         fdZtQZ9DakNzjCBpu4nR/Uur+Qhd5lKcwc+j3+1GPJ+YaymmxtHXDT0fA6Nhd5Nxy2uh
         1RynJUxrpy2iWd6a7LH7mKT8NjeCMW2XKAwvf+cTPTjuXHd8rT2Hzh7FxqgWCwzTsKm3
         UvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hWbihI/rNskUo3Z1Ofg/vJCTgDM+HiI+IoF/4RCkcE4=;
        b=XIg1nFrCW8XDmSitkcImWLoQAZH5e5K9m/IlfEuzXimXhsPcSkHVKjohu+sYowPVKk
         ltAA8W5T1jtGAIiQcra5Uzac+Xw18NZOmaj6OXgx/vrvlwak+St1+6ub3mLdkvOVguMe
         uzRTFo2AzYpqKqWlikuPTtzcCC97PeSUKYR/t4gL504XugH2/KXk3FzpS18a7b9Av4JY
         gDFFy+wa9y2TW3Jtu1xsT75D7mKc8/OmM1VrI+Bl2xA1+22jq9Grm6q6E116w9qvJ1WC
         KKa97lmA6Bxh0wjqvhN9rKxUTZYuwflQEKNXdfDZPO9DHZSxC/AydM+w0NyfzwFLBVfD
         eoiA==
X-Gm-Message-State: AOAM531RFYVbENAQ/mv5Kn1bH7aWgBV1dhKjgMy7cdX2LtqO39bLvmbD
        VBo+Hckf8hd7aP0zrFyW8qo=
X-Google-Smtp-Source: ABdhPJw3XcmRfzotzFx4Fls/Td5vQcjRhBx0HHD1B2EqpDwQLjGlFSNKcnURy74mUvn93t9nw12VKw==
X-Received: by 2002:ac8:7d52:: with SMTP id h18mr21521005qtb.175.1616995005822;
        Sun, 28 Mar 2021 22:16:45 -0700 (PDT)
Received: from localhost.localdomain ([156.146.37.195])
        by smtp.gmail.com with ESMTPSA id z124sm12993181qke.36.2021.03.28.22.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 22:16:45 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 22/23] riscv: pmu.rst : A spello fix
Date:   Mon, 29 Mar 2021 10:42:58 +0530
Message-Id: <5a7e9b80fe31c53b30337da0bdbd853d1b7afe5f.1616992679.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616992679.git.unixbhaskar@gmail.com>
References: <cover.1616992679.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/resonable/reasonable/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/riscv/pmu.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/riscv/pmu.rst b/Documentation/riscv/pmu.rst
index acb216b99c26..fde31b6aa861 100644
--- a/Documentation/riscv/pmu.rst
+++ b/Documentation/riscv/pmu.rst
@@ -168,7 +168,7 @@ counter (event->count), but also updates the left period to the next interrupt
 But the core of perf does not need direct write to counters.  Writing counters
 is hidden behind the abstraction of 1) *pmu->start*, literally start counting so one
 has to set the counter to a good value for the next interrupt; 2) inside the IRQ
-it should set the counter to the same resonable value.
+it should set the counter to the same reasonable value.

 Reading is not a problem in RISC-V but writing would need some effort, since
 counters are not allowed to be written by S-mode.
--
2.26.3

