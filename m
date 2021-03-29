Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FB934D262
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 16:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhC2O3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 10:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbhC2O2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 10:28:50 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CB7C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 07:28:50 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id f12so9434297qtq.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 07:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dm/wVurAlohhjt5oDyqVhTnciFW3HtIHWRD4m8Eljsw=;
        b=eSOv0/X4qRNjBNZceFe/tFhg/4p6TzLzpHzcUjj3BGNQ9MvEmVUdq17RgMPnm+JPra
         LNcueVyGelrmIEpzuZhbEfI+j9Bj3qv7+wY0mepge5LJR5NZ5SZbTdop97yWB8N+Zmlx
         Tp9C99OOidPbYnO86zKP2DOD7hxO58fJ+ynQVD459BIhdr01R9W0jqOcBmsCKP87FYZE
         vJY8UNtZaVlPS0FCijYPkeJXgH2wPf4CxqiPOMgL4S+uBtS9XLTGo99+AjIMHGrpf2qw
         PAa1gQaKVP9A5sTh44ct5Q9VqfmbUQ2IScd/yCTFDjNmIFIwnAjy6XIO1u1tYkhnAGsG
         YpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dm/wVurAlohhjt5oDyqVhTnciFW3HtIHWRD4m8Eljsw=;
        b=Bcqvmdj/IFOX/VdmW8Ii91e0QXIlK20seW9vubnIRmdMbIzZqi3s3a44hMR+mF9/zC
         U2PmCiQtHp4FAHySuIBRzlUrxGNvqh2a9SzSoP5FadQSVw3rFSn0/+Aevcp9dmatk+cX
         dIpu82g9CtcUepeuaLK7P+MwHSZKqZXBLLyMenSBUhGRpqTRQRMlF+d+l4loa/1IxsPx
         Fuf1ri6J9JFZFjNJ99dBfxnE3WZmB4y4LbCYewSeMd2y68ehHx4zNioxDpbEq+IibCBp
         BGOAFf5zxTtXYFByGAZ1EH4fxPJ4rMnBL7UypgTmr2IO2sdYXxF9/ZiJ29futM0423CE
         1c8w==
X-Gm-Message-State: AOAM531HkAPP1hteJFqDwkHELs4i1Y7Q/M00qiCp/sfOqC89jJ9HfG7n
        9kfFh9KyYdJuyMQqHA89tylPzE7eOp0EJw==
X-Google-Smtp-Source: ABdhPJxAR59lGYh39TicUo/TLeKy92Gn4FW0Ih0n0yDxlUib25l3AfiHPV8bcj+xJGYugdxZot+biA==
X-Received: by 2002:ac8:4508:: with SMTP id q8mr22399408qtn.48.1617028129113;
        Mon, 29 Mar 2021 07:28:49 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id f26sm10960472qtq.29.2021.03.29.07.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 07:28:48 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, tyhicks@linux.microsoft.com,
        jmorris@namei.org, will@kernel.org, anshuman.khandual@arm.com,
        ardb@kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH] [Backport for stable 5.11] arm64: mm: correct the inside linear map boundaries during hotplug check
Date:   Mon, 29 Mar 2021 10:28:47 -0400
Message-Id: <20210329142847.402167-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit ee7febce051945be28ad86d16a15886f878204de upstream.

Memory hotplug may fail on systems with CONFIG_RANDOMIZE_BASE because the
linear map range is not checked correctly.

The start physical address that linear map covers can be actually at the
end of the range because of randomization. Check that and if so reduce it
to 0.

This can be verified on QEMU with setting kaslr-seed to ~0ul:

memstart_offset_seed = 0xffff
START: __pa(_PAGE_OFFSET(vabits_actual)) = ffff9000c0000000
END:   __pa(PAGE_END - 1) =  1000bfffffff

Fixes: 58284a901b42 ("arm64/mm: Validate hotplug range before creating linear mapping")
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Tested-by: Tyler Hicks <tyhicks@linux.microsoft.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/mm/mmu.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 6f0648777d34..ee01f421e1e4 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1445,14 +1445,30 @@ static void __remove_pgd_mapping(pgd_t *pgdir, unsigned long start, u64 size)
 
 static bool inside_linear_region(u64 start, u64 size)
 {
+	u64 start_linear_pa = __pa(_PAGE_OFFSET(vabits_actual));
+	u64 end_linear_pa = __pa(PAGE_END - 1);
+
+	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
+		/*
+		 * Check for a wrap, it is possible because of randomized linear
+		 * mapping the start physical address is actually bigger than
+		 * the end physical address. In this case set start to zero
+		 * because [0, end_linear_pa] range must still be able to cover
+		 * all addressable physical addresses.
+		 */
+		if (start_linear_pa > end_linear_pa)
+			start_linear_pa = 0;
+	}
+
+	WARN_ON(start_linear_pa > end_linear_pa);
+
 	/*
 	 * Linear mapping region is the range [PAGE_OFFSET..(PAGE_END - 1)]
 	 * accommodating both its ends but excluding PAGE_END. Max physical
 	 * range which can be mapped inside this linear mapping range, must
 	 * also be derived from its end points.
 	 */
-	return start >= __pa(_PAGE_OFFSET(vabits_actual)) &&
-	       (start + size - 1) <= __pa(PAGE_END - 1);
+	return start >= start_linear_pa && (start + size - 1) <= end_linear_pa;
 }
 
 int arch_add_memory(int nid, u64 start, u64 size,
-- 
2.25.1

