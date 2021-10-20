Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4247434AC5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 14:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhJTMHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 08:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbhJTMHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 08:07:11 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEF9C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 05:04:57 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id i76so2754232pfe.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 05:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pU7j7Xk9+/byWORMoTjuh+PtfIleRNtFNR9pisRaOIs=;
        b=V++5qWbqy5428E4+L8MN0z76u0WFToo1W/QPmRiz3Y2mC128yoEwYEbB+FWVhgenuB
         n+q6iWsUMxoBq63k7TZlDaAFsLpNQMhhMZKNtAvJHVTqVAJ9VUojVmNE8vYiYx8R+ufz
         cVJPMZ5WhVbo7SnHuHoClSMPP6oZyFSv/o/vg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pU7j7Xk9+/byWORMoTjuh+PtfIleRNtFNR9pisRaOIs=;
        b=16nbKpevv1hXRq36dbvTkqC3KFAgzCHpsLPlWFRuhQuGOVaefU6AbFjb83lB7wavHW
         bdSpDJYDuuOS+kicj0cytTFpmJUdGa92J//7x9ZcY5yBTMu3PALANymE0OxEqqEzuGpv
         Fk80nLRKjpvVbOtSYgbes6YqREzQ119W4kh5W5ouXo9HTpQy/7fSLDwqQGXRQVAjx1he
         iXz+kQjDkNuKjS+T8nvm2unok+Qi/h74Ey5oJQlNFO3KkckIFMX1sMD/HHf9idDQOJIi
         1juY8ozjcIOixQ1XokGEjW9ZxBChOkTyig/7zaGTajAozIqQ5moWmrhBFJ6yN+TQMuIl
         ud+g==
X-Gm-Message-State: AOAM530po9IvoIt0CcQNigH6IuStXYHXJOuFGbdQAM0qzu/l8J5t3Ncp
        WHpE4R1w589pwoa/bDnKXCSbOx63HluMLQ==
X-Google-Smtp-Source: ABdhPJxaf4wQew/0fxehgf4we7eoDadSQ+ziLebkvEYdeY0bf6NB9PnUwEUIMDvlNw3FihCdjsAaDA==
X-Received: by 2002:a63:710d:: with SMTP id m13mr33036191pgc.467.1634731496586;
        Wed, 20 Oct 2021 05:04:56 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:e516:d575:e6f:a526])
        by smtp.gmail.com with UTF8SMTPSA id i12sm2108246pgd.56.2021.10.20.05.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 05:04:56 -0700 (PDT)
From:   Hikaru Nishida <hikalium@chromium.org>
To:     linux-kernel@vger.kernel.org, dme@dme.org, tglx@linutronix.de,
        mlevitsk@redhat.com, linux@roeck-us.net, pbonzini@redhat.com,
        vkuznets@redhat.com, maz@kernel.org, will@kernel.org
Cc:     suleiman@google.com, senozhatsky@google.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Hikaru Nishida <hikalium@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ingo Molnar <mingo@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [RFC PATCH v3 1/5] timekeeping: Expose tk->offs_boot via ktime_get_offs_boot_ns
Date:   Wed, 20 Oct 2021 21:04:26 +0900
Message-Id: <20211020210348.RFC.v3.1.Ic2211981441d0504581923b8770809f0750a4d0d@changeid>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
In-Reply-To: <20211020120431.776494-1-hikalium@chromium.org>
References: <20211020120431.776494-1-hikalium@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose tk->offs_boot to be used in kvm virtual suspend injection.

Signed-off-by: Hikaru Nishida <hikalium@chromium.org>
---

Changes in v3:
- Added this patch.

 include/linux/timekeeping.h |  2 ++
 kernel/time/timekeeping.c   | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 78a98bdff76d..f7be69c81dab 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -179,6 +179,8 @@ extern u64 ktime_get_raw_fast_ns(void);
 extern u64 ktime_get_boot_fast_ns(void);
 extern u64 ktime_get_real_fast_ns(void);
 
+extern u64 ktime_get_offs_boot_ns(void);
+
 /*
  * timespec64/time64_t interfaces utilizing the ktime based ones
  * for API completeness, these could be implemented more efficiently
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index b348749a9fc6..e77580d9f8c1 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -565,6 +565,16 @@ u64 ktime_get_real_fast_ns(void)
 }
 EXPORT_SYMBOL_GPL(ktime_get_real_fast_ns);
 
+/**
+ * ktime_get_offs_boot_ns - boottime offset to monotonic.
+ * Return: boottime offset in nanoseconds.
+ */
+u64 ktime_get_offs_boot_ns(void)
+{
+	return ktime_to_ns(tk_core.timekeeper.offs_boot);
+}
+EXPORT_SYMBOL_GPL(ktime_get_offs_boot_ns);
+
 /**
  * ktime_get_fast_timestamps: - NMI safe timestamps
  * @snapshot:	Pointer to timestamp storage
-- 
2.33.0.1079.g6e70778dc9-goog

