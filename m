Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5BD931C26B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 20:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbhBOTXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 14:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbhBOTXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 14:23:22 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160E9C061756
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 11:22:42 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id y10so3625829qvo.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 11:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CZE34n9hYz5SU1Put+7gb17jfhnpLjCCxD5CNJQ2yQw=;
        b=VzPEW28qSfuTQX8GSdTH45qhuK313Kx443CZzOeXV5C/arFRf6Bn4H0eDPjE6gV58J
         L4hbJxJEslsXIDYdeS4QVGUHzs4QwZZsQs2PmSquFlDX+jHX+KWh57BdQExZ6ZE23myj
         fWK4PwkjQWiY7xrfbvn85o4Yz8hhNDnHqXxxSd1NCGPalZ2keFnVgBuda22LERbKr6CG
         af2Yor8UWYEb/hu2vy/y4ZWsd3mV9wCT2fJJGwRHBK0mEM67+IVCPsRW4Kna6RfBbm27
         lRHXfhrKAM63HPHEL6r3cww0YtSatUIOSxIAbKcSt+barjLUi60UqEjQjkVpYghtJ0to
         Qr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CZE34n9hYz5SU1Put+7gb17jfhnpLjCCxD5CNJQ2yQw=;
        b=PaAjB1dyaiet9RSc6F9j4+IDYR+bt3VYqQZyW0tBzL7+/siOFe2FkY0QeZ/PL2EdAs
         acH4U9QnhU8J1gbtBNRRifAy+sDgfuuJhCxfGGwJj/Sum2B/AMKo0msy6/a/l5vtI0GT
         3z7Io/IS7JjoXSr4i/IJrpmO1ewNbP7IRXDV0NFf0igh5cF/FCkLlwgF9X7RM0mHFMzD
         wMj1dy6NVnUWgGKAjma4VXDiQiUR5zjAL/t0Sji2wXBMxf3V+9AMBoXVmtSJeZFoi4H4
         CG28ouJbGVkDFoPSdHbQ3U7vo/fIKy57RnjV0TXtS7xK3EOugNRgqBqoUZOTd/H7sac7
         k4dQ==
X-Gm-Message-State: AOAM532B6yZxTQDgvqMuMIxbYcDoAQP1y23hOk3QeOeAaBgigNat+isg
        SQX7NcnkQUnU8ZVaXC4zxT5BAA==
X-Google-Smtp-Source: ABdhPJy/TKL3Y7MKryyo5k14Om/vlqNOQCs6gq+2BRR6qmdgiYzW6H6m0flC1JJ49VbBtOoqJa4ZIw==
X-Received: by 2002:ad4:458f:: with SMTP id x15mr16461481qvu.39.1613416959759;
        Mon, 15 Feb 2021 11:22:39 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id i20sm11631668qtv.73.2021.02.15.11.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 11:22:39 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, tyhicks@linux.microsoft.com,
        jmorris@namei.org, catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        rppt@kernel.org, logang@deltatee.com, ardb@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] correct the inside linear map boundaries during hotplug check
Date:   Mon, 15 Feb 2021 14:22:36 -0500
Message-Id: <20210215192237.362706-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
	- Added test-by Tyler Hicks
	- Addressed comments from Anshuman Khandual: moved check under
	  IS_ENABLED(CONFIG_RANDOMIZE_BASE), added 
	  WARN_ON(start_linear_pa > end_linear_pa);

Fixes a hotplug error that may occur on systems with CONFIG_RANDOMIZE_BASE
enabled.

v1:
https://lore.kernel.org/lkml/20210213012316.1525419-1-pasha.tatashin@soleen.com

Pavel Tatashin (1):
  arm64: mm: correct the inside linear map boundaries during hotplug
    check

 arch/arm64/mm/mmu.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

-- 
2.25.1

