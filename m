Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 627E5330FFF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 14:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbhCHNuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 08:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbhCHNuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 08:50:18 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D0AC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 05:50:18 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id ba1so4916801plb.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 05:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=adfhT8U0L+7VLfUl0nWw3YYASV+ZuqZ/oFoFnZughRY=;
        b=a8jH717Cs4y8ATQHzg30HqY8eCX+wPo68Fs+UwAwfozpk4dhf4R4NVQ3TbFJ+bySfp
         2sDKIvHxRu2heNA9MqkmBQxGUx5sJllyfVLAvhQPA0diG5MclCo+MmQvMHqTL+wEnqGI
         hDmk2UnWIUH+BD4YFWn3cOXiMdvN/0p5lsQ4Rif2pva1492t9i6jfh2K+uoVHPYFiCK7
         E8W+CxNx6piw0Jc5j3lUghg/70XAtQE5aACumt//+alN6g3Rj9iJBFv80+ny85rZVjzC
         kBa2h2pyETSTPFdX0EBymNbFSO1vAhngc6uv5En0BJllZclkWRZSyeEvkAisGvDq26wQ
         O4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=adfhT8U0L+7VLfUl0nWw3YYASV+ZuqZ/oFoFnZughRY=;
        b=WuQUhaxw9qwkttaZSKDJOmGXK18I859V7ZujYsS994dA/FvgWcALV+S9a2j6ChmR3I
         s5EgHit0pOLtiTwX5382qvXcFaIWof61rF1V00MwLUU2V4NWG/dzbwo/v0+a4OeGt1vp
         pVCm/L6ip0nXdUTHw4XAkPDPgxT1s70YhbninKj0lSy6BfS9daf5U4oG0P/b17AZ+4vs
         QXVxCfZilupB36ltqHYViRFjaLM8gEe47qBH5LEVeXRWUlEn5ajXygRfa+Ra/w8/nvwL
         YBA+qmKS43AtupJldBFV+BD/eavUBpr4D9Tb2g0sowE5T+/LnVExENZLVhG1VAQbjMEW
         rjcA==
X-Gm-Message-State: AOAM532BwrvlVSGoOLqEcSDVyVMYVMqciHSXjvS63QB+7upG/s0KkIwe
        J4M60wUAvt4PuT3Cf9Wo2/LrFkX3Dm/hzJD+
X-Google-Smtp-Source: ABdhPJyjh1D1kPT4RnbPcBSt9dihAd3PyGsRl0HOwVcxBMz26Tbum8gDo+sb7mtN9pRMSpiFq+4mmQ==
X-Received: by 2002:a17:902:b609:b029:e3:4b8d:994 with SMTP id b9-20020a170902b609b02900e34b8d0994mr20866426pls.44.1615211417651;
        Mon, 08 Mar 2021 05:50:17 -0800 (PST)
Received: from localhost.localdomain ([8.210.239.156])
        by smtp.gmail.com with ESMTPSA id p20sm10412794pgb.62.2021.03.08.05.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 05:50:17 -0800 (PST)
From:   youling257 <youling257@gmail.com>
To:     yu.c.chen@intel.com
Cc:     lenb@kernel.org, rjw@rjwysocki.net, dsmythies@telus.net,
        linux-kernel@vger.kernel.org
Subject: Re: [3/3,v3] tools/power turbostat: Enable accumulate RAPL display
Date:   Mon,  8 Mar 2021 21:49:57 +0800
Message-Id: <20210308134957.23852-1-youling257@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <1f6d32e14f121a8ccf8807b8343597c3ae88c7d2.1587196252.git.yu.c.chen@intel.com>
References: <1f6d32e14f121a8ccf8807b8343597c3ae88c7d2.1587196252.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this cause turbostat not work on amd cpu.


root@localhost:~# /turbostat
turbostat version 20.09.30 - Len Brown <lenb@kernel.org>
CPUID(0): AuthenticAMD 0xd CPUID levels; 0x8000001f xlevels; family:model:stepping 0x17:18:1 (23:24:1)
CPUID(1): SSE3 MONITOR - - - TSC MSR - HT -
CPUID(6): APERF, No-TURBO, No-DTS, No-PTM, No-HWP, No-HWPnotify, No-HWPwindow, No-HWPepp, No-HWPpkg, No-EPB
CPUID(7): No-SGX
RAPL: 234 sec. Joule Counter Range, at 280 Watts
/dev/cpu_dma_latency: 8000 usec (constrained)
current_driver: acpi_idle
current_governor: menu
current_governor_ro: menu
cpu1: POLL: CPUIDLE CORE POLL IDLE
cpu1: C1: ACPI FFH MWAIT 0x0
cpu1: C2: ACPI IOPORT 0x414
cpu1: cpufreq driver: acpi-cpufreq
cpu1: cpufreq governor: powersave
cpufreq boost: 1
cpu0: MSR_RAPL_PWR_UNIT: 0x000a1003 (0.125000 Watts, 0.000015 Joules, 0.000977 sec.)
root@localhost:~#
