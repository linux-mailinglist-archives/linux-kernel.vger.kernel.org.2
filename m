Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378EB3A5B85
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 04:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbhFNCPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 22:15:50 -0400
Received: from mail-pj1-f52.google.com ([209.85.216.52]:37385 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbhFNCPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 22:15:49 -0400
Received: by mail-pj1-f52.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so9137622pjs.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 19:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gIs+Dwa4YB8s9iK40ccyfE3brt/FVPHgMtnsfMB/YQQ=;
        b=T6rfps4hk8jXV+vVjlPo2YcvZksWU3htx/21N7tanZvOw1EJIj+C4+Z7QgDnMs8k19
         E14aahCkAT4lbBVc+ScUGLUViPq5S7xH546wn3WA9h76eiEg1y8B66PFqDuZwJWxyW3H
         tyBGWK3lvOuY9mDNx8tz1ra2Kiuhh0ieif18SBU7lb/giLWz4h9W+9TcGI0S7WJPXt1Q
         OkJ4HS3vEZXp4ajy6YER9cO6xuD2gsPqt/A6qitjn3xk9embV12YfuzutQGSGO9pvBRQ
         EKxFU1wpTs04VqKgkk5ED8bfbe7VJVcnIa/Wx0RapJKmSQ/nPHBUgaA8rfTXPuy1wfQt
         Jpyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gIs+Dwa4YB8s9iK40ccyfE3brt/FVPHgMtnsfMB/YQQ=;
        b=c+rJHFpU4CRc6puww3FLzJ8V0oH0OIQ87NppXbTr4Hi/0u0XrqEEed3p2sNHwjf395
         KwyQMVAZqXi/xGbuadPDSMfO1hhvh7bM1FNCQRFdKyxh0b9gzM0IrHKxbkajeHUOMBgx
         Bgu50ekNmoCtV4wrnyqh4SX3OtcNig99bCJk+pWqXlyOOgi8Zox+nXK5w+7CBXHcxEz0
         TUY/pldNqHFMBSTisyZUvDbeOV7/UNxEIMdk/MCPuGLdoCxwNZco5lMamaEz49qGSOhq
         42+N3IkhiRvMMzv07P4JDM9om8J3t+BY3Rgp1Zx453D3H/qrn5Y4PwV8AJ7aFaQ4+tg1
         0C/Q==
X-Gm-Message-State: AOAM532a7ilE04AV1tXMeofXjHTdAEDGxzHPfRSw9BwOaXq9GrJuc2iK
        re6do+6GaFWM0LjBUigxJA==
X-Google-Smtp-Source: ABdhPJxH72pb6ziU7YQ25+rMunImKsUEj2DatwNxJyDtt4XYuDUpNvN3m0N5HJfDfDbZ1rYY0fPhrg==
X-Received: by 2002:a17:90a:6304:: with SMTP id e4mr16476639pjj.222.1623636753886;
        Sun, 13 Jun 2021 19:12:33 -0700 (PDT)
Received: from localhost.localdomain (h175-177-040-153.catv02.itscom.jp. [175.177.40.153])
        by smtp.gmail.com with ESMTPSA id z14sm10952986pfn.11.2021.06.13.19.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 19:12:33 -0700 (PDT)
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Ding Hui <dinghui@sangfor.com.cn>,
        Tony Luck <tony.luck@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/6] mm/hwpoison: introduce MF_MSG_PAGETABLE
Date:   Mon, 14 Jun 2021 11:12:09 +0900
Message-Id: <20210614021212.223326-4-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210614021212.223326-1-nao.horiguchi@gmail.com>
References: <20210614021212.223326-1-nao.horiguchi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

Page table pages could have some amount of share on system memory,
so define it for a separate page type message.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 include/linux/mm.h      | 1 +
 include/ras/ras_event.h | 1 +
 mm/memory-failure.c     | 1 +
 3 files changed, 3 insertions(+)

diff --git v5.13-rc5/include/linux/mm.h v5.13-rc5_patched/include/linux/mm.h
index c274f75efcf9..45008654f695 100644
--- v5.13-rc5/include/linux/mm.h
+++ v5.13-rc5_patched/include/linux/mm.h
@@ -3103,6 +3103,7 @@ enum mf_action_page_type {
 	MF_MSG_KERNEL,
 	MF_MSG_KERNEL_HIGH_ORDER,
 	MF_MSG_SLAB,
+	MF_MSG_PAGETABLE,
 	MF_MSG_DIFFERENT_COMPOUND,
 	MF_MSG_POISONED_HUGE,
 	MF_MSG_HUGE,
diff --git v5.13-rc5/include/ras/ras_event.h v5.13-rc5_patched/include/ras/ras_event.h
index 0bdbc0d17d2f..2f459f6f87fb 100644
--- v5.13-rc5/include/ras/ras_event.h
+++ v5.13-rc5_patched/include/ras/ras_event.h
@@ -357,6 +357,7 @@ TRACE_EVENT(aer_event,
 	EM ( MF_MSG_KERNEL, "reserved kernel page" )			\
 	EM ( MF_MSG_KERNEL_HIGH_ORDER, "high-order kernel page" )	\
 	EM ( MF_MSG_SLAB, "kernel slab page" )				\
+	EM ( MF_MSG_PAGETABLE, "page table page page" )			\
 	EM ( MF_MSG_DIFFERENT_COMPOUND, "different compound page after locking" ) \
 	EM ( MF_MSG_POISONED_HUGE, "huge page already hardware poisoned" )	\
 	EM ( MF_MSG_HUGE, "huge page" )					\
diff --git v5.13-rc5/mm/memory-failure.c v5.13-rc5_patched/mm/memory-failure.c
index e7910386fc9c..30d6519ce203 100644
--- v5.13-rc5/mm/memory-failure.c
+++ v5.13-rc5_patched/mm/memory-failure.c
@@ -708,6 +708,7 @@ static const char * const action_page_types[] = {
 	[MF_MSG_KERNEL]			= "reserved kernel page",
 	[MF_MSG_KERNEL_HIGH_ORDER]	= "high-order kernel page",
 	[MF_MSG_SLAB]			= "kernel slab page",
+	[MF_MSG_PAGETABLE]		= "page table page",
 	[MF_MSG_DIFFERENT_COMPOUND]	= "different compound page after locking",
 	[MF_MSG_POISONED_HUGE]		= "huge page already hardware poisoned",
 	[MF_MSG_HUGE]			= "huge page",
-- 
2.25.1

