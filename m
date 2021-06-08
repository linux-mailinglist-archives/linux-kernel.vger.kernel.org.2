Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0F739F3A4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 12:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhFHKgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 06:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbhFHKgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 06:36:16 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851C9C061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 03:34:12 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id u14so7576167qvq.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 03:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J48k4WcLJ93C6a4z5qvH4NdBXcXofCtpkZgQyGSY/Bw=;
        b=f9s3tlGdv+Y1LSpT+BfcUXtXM2IKhT7mXXeAXGNZVv9grY44lipLCrOVlyDsoNqFHY
         bgRAtbzCs0cwsYch3IqjUkRg21qKS89A0AvC/4hjJpGDX8cSkRKtUGIzPDwgYi9y+T31
         8TAJrWW5ruMltyaKoq0xV+xGYunqeX5PTvyvcT1gXDjiJ+SWx42GiARauzNeLu799E7w
         lDoMh2hpfafy5xC8CoMGZ4dlEujFKrS0wSuarkwsCOAPKTSiLxeRJBlLEVts/CKlGdvE
         mMCenIyU7M1vbyvJ3RVCjBI/ZXYJixFMzu/bSlpoKLuIDf0YZxDH93cd2ya4ma5A6ezs
         dAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J48k4WcLJ93C6a4z5qvH4NdBXcXofCtpkZgQyGSY/Bw=;
        b=mSniKYzeQUk7xLQAsLB9wcJpT7j+dzusH9gjdQ0JN+177BSIYuojf5p1k3JgiOIJVX
         Wm+oZRVWLrpdR/uLyFgVgdCkvQTJOlc1AKPYCfr4auAz5+5lRvTMkLEAqDKo+5AE5++e
         4V0NRdEiLk+Q1t/9Si60Zu4pK2fgymD13aLqB89ZRntqbhxLYTZy6MEDx8WlkVgo+hPg
         3Ks8jSQ9nDaDSiF7ezcLySeSUmQpXgfzhieJqB3wS6SJ+pB0tteJMpUcNJ9+Cy7fKHN5
         A4SiEd3w11WUKYHkYr4VFfPxoJ8GcoIWsutB7egSdTkRAsZofML+UhkVeYXBJ5aF3V6W
         Un7w==
X-Gm-Message-State: AOAM531KGJZINcI63Akv+nxUB0+wwSNo8IFOZBbx/4lxAOPcHM2E06j1
        HtO10QxYS6ttZs/qfghKoA==
X-Google-Smtp-Source: ABdhPJzwosaCGBBwjiwr3ftTAMod+g7XPn30t+/0BRzJxX9QrrUMaPQenkgIE6i5E4uZVVsWsh1sig==
X-Received: by 2002:a0c:ed46:: with SMTP id v6mr22752280qvq.46.1623148451751;
        Tue, 08 Jun 2021 03:34:11 -0700 (PDT)
Received: from qualcomm-amberwing-rep-18.khw4.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id e3sm2260682qts.34.2021.06.08.03.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 03:34:11 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Boris Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dave Anderson <anderson@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] crash_core, vmcoreinfo: Append 'SECTION_SIZE_BITS' to vmcoreinfo
Date:   Tue,  8 Jun 2021 06:33:59 -0400
Message-Id: <20210608103359.84907-1-kernelfans@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As mentioned in kernel commit 1d50e5d0c505 ("crash_core, vmcoreinfo:
Append 'MAX_PHYSMEM_BITS' to vmcoreinfo"), SECTION_SIZE_BITS in the
formula:
    #define SECTIONS_SHIFT    (MAX_PHYSMEM_BITS - SECTION_SIZE_BITS)

Besides SECTIONS_SHIFT, SECTION_SIZE_BITS is also used to calculate
PAGES_PER_SECTION in makedumpfile just like kernel.

Unfortunately, this arch-dependent macro SECTION_SIZE_BITS changes, e.g.
recently in kernel commit f0b13ee23241 ("arm64/sparsemem: reduce
SECTION_SIZE_BITS"). But user space wants a stable interface to get this
info. Such info is impossible to be deduced from a crashdump vmcore.
Hence append SECTION_SIZE_BITS to vmcoreinfo.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Boris Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Dave Anderson <anderson@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org
Cc: x86@kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 kernel/crash_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 825284baaf46..684a6061a13a 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -464,6 +464,7 @@ static int __init crash_save_vmcoreinfo_init(void)
 	VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
 	VMCOREINFO_STRUCT_SIZE(mem_section);
 	VMCOREINFO_OFFSET(mem_section, section_mem_map);
+	VMCOREINFO_NUMBER(SECTION_SIZE_BITS);
 	VMCOREINFO_NUMBER(MAX_PHYSMEM_BITS);
 #endif
 	VMCOREINFO_STRUCT_SIZE(page);
-- 
2.29.2

