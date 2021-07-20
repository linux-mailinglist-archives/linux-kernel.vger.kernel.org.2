Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21C13CF672
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 10:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235434AbhGTIQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 04:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234941AbhGTIME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 04:12:04 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C45C061762
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 01:52:41 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id i16so4323634pgi.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 01:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=neBt+345X0N5pli5WyJQPDvAFg6VejoZfkgDTygaWmY=;
        b=WFzVlBxJfFJmdQwW3MeqB8pkEgcsPE24Lo8VfUrq1KnWREpx/3uZNT7zDLu79GZl2d
         Z96qv/hLA/MGTILMdJR77VAsy2lythcah0SF5i5yWe2UQX1N4arLhq0b9vU+8zNaM1ly
         V2qoChJ09NocNMFgJEOBcaunPEmZiqg1tDbakPHsq9TZ3Xl1s/8fYMWsVOwMYkA3cW52
         zbaB8FwnHTVz5G6VkcxaR/RiyS+Sr5z0ehYWcPmKWaatwNxMuOd0q/1tYIHzQwXusgrf
         at/mQZwHGu5/Q7BrYXzrWf0NU3ps4M5P9hfydVZBOnLmFNonFnWdWOCfKTtjooh5vchd
         0QiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=neBt+345X0N5pli5WyJQPDvAFg6VejoZfkgDTygaWmY=;
        b=NOSwIf/mvQ1ySxrQidl/YiyCdjvKeSAPT+vXbO9JnfBXQCZpbnDwa+apzpN3B+j6fs
         /F5DIupqp62sCZZFq3bDyYp1R4W3R8pvSs96C5m/WF4C944rZNu/QlczgjCePT0BJJfO
         iaawMJ8uvdZweirDsSMt3AT+9BB27vaLrY/rjo2UaZtE6SwkO5RjrzomONNzwVq+s8K6
         0JAzr/hVgZFT+bzPLeUrjZSVuOn4oo/0V8iOQf+LELgxSeuK1rJycFXbN4O+uPFMrB5C
         n62M2ZPM8WuQLlIItdPZy6CZSRCEIpAG59+W563LoGncEjiQNu1KmoPRsLMEOumcPnhA
         CO3w==
X-Gm-Message-State: AOAM5337cbmsvzydZlykDQ+SLV/bUJ7aCBbFK4NxEgzxo/kNT7W8zhWn
        8tl1zEZWNMov5pKHFNKFpDLRarnKEiE=
X-Google-Smtp-Source: ABdhPJxOmVRYcAJYPBUAwlqoDVHc2s48l811SwUXYECZw7ET/6/Yv9yG1V3cLT2ITW2OkAYGi4gm9g==
X-Received: by 2002:a65:63cf:: with SMTP id n15mr4668241pgv.392.1626771161295;
        Tue, 20 Jul 2021 01:52:41 -0700 (PDT)
Received: from [192.168.1.153] (M106072041033.v4.enabler.ne.jp. [106.72.41.33])
        by smtp.gmail.com with ESMTPSA id i6sm17126099pfa.44.2021.07.20.01.52.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jul 2021 01:52:41 -0700 (PDT)
Subject: [PATCH 3/4] riscv: __asm_copy_to-from_user: Remove unnecessary size
 check
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <37097718-c472-025a-2058-55667badc5b9@gmail.com>
From:   Akira Tsukamoto <akira.tsukamoto@gmail.com>
Message-ID: <94d4ec76-a987-348e-71ce-473511d44787@gmail.com>
Date:   Tue, 20 Jul 2021 17:52:36 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <37097718-c472-025a-2058-55667badc5b9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Clean up:

The size of 0 will be evaluated in the next step. Not
required here.

Signed-off-by: Akira Tsukamoto <akira.tsukamoto@gmail.com>
---
 arch/riscv/lib/uaccess.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
index 279876821969..54d497a03164 100644
--- a/arch/riscv/lib/uaccess.S
+++ b/arch/riscv/lib/uaccess.S
@@ -30,7 +30,6 @@ ENTRY(__asm_copy_from_user)
 	 * t0 - end of uncopied dst
 	 */
 	add	t0, a0, a2
-	bgtu	a0, t0, 5f
 
 	/*
 	 * Use byte copy only if too small.
-- 
2.17.1

