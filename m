Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1F031C217
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 20:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhBOTAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 14:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhBOS75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 13:59:57 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32053C061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 10:59:11 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id g24so2992455qts.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 10:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VLi1cAVxQP0XEts9J9hmyT1b9JpU8SbEP6ObLPtMdVk=;
        b=g+1PSz+YvWUDyE746jB8jc3O7ygSAaIAk88hp1P8F1Re/AOnP+TGlr1rkTnvUKYGyR
         3SoW6ET4b4NhpC62LzX1WQpwVA2V2pHIZv2/D8hz3aKNA3DD7Un4Cus9vrcqjQ8B5SxI
         pNCE16VCyMBBz/z6b8cHh7mP08V7WrlApNTZeKlybmAtGTGE/gxPUCuBFH4fheFSJciX
         9eZ48xCyQ2ZegftD/HLZu2mDKoeTuXpqEMV8sPo/HfQ6cZpqRtE0JR4Cdl8ZA9MMaSkh
         dLvuPFAGHtZI/VWedkVrPGBVPjDu1Ez8ZshJ52T0k1dpoSydKRn9tV2+03HjHC6GLo1+
         roPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VLi1cAVxQP0XEts9J9hmyT1b9JpU8SbEP6ObLPtMdVk=;
        b=sf04zmP4GiS10odj4ugD2DiHtC9eBEoqHq6th1e9xwaBodlR9IQbPna05M8SpJCqBq
         514bz1q1MaD4GDYs/yQbqhlQU8/lO+MkWaGaIHKu68SIg6WQesiSkyynnT3P2mVSR+eO
         7IVv1vu6ig/P7btZ5KTeu7pHb0RH0pxioOXDdwkR6ohlkV9UlVRgbn3aYKRn946JauPU
         FkdfeUs99bqzT3ifFaThPKGAhdrJKHrco1YsDfPEop5LQ9d/pjLH8OuWXwHF6IC8AYeg
         XWetFyhecdH9Ts6qOh3BWkUy+KxHwN2C9MDkuXW19ysnSCHmUo4wQ6T3idG5YSjT+SAY
         ZpAg==
X-Gm-Message-State: AOAM5321dPXaZvQyZs2gXNWSIrOSaVQUC72hbLq2/cHSxifzON6pOtl5
        7A/GVhfMqW3cv028xOjYySbrqQ==
X-Google-Smtp-Source: ABdhPJxJ8epjzr+kRTeRdKmmTxD52c8LN/gqM9fRMtaKrLDIFcwBqL/PhO0ZuO6UU9vajvZvIum3xQ==
X-Received: by 2002:a05:622a:109:: with SMTP id u9mr15385994qtw.116.1613415550412;
        Mon, 15 Feb 2021 10:59:10 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id z28sm8173017qkj.72.2021.02.15.10.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 10:59:09 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-arm-kernel@lists.infradead.org,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        tyhicks@linux.microsoft.com, will@kernel.org, james.morse@arm.com,
        ebiederm@xmission.com, kexec@lists.infradead.org
Subject: [PATCH 0/1] fix machine_kexec_post_load prototype.
Date:   Mon, 15 Feb 2021 13:59:07 -0500
Message-Id: <20210215185908.257724-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is against for-next/kexec, fix for machine_kexec_post_load
warning.

Reported by kernel test robot [1].

[1] https://lore.kernel.org/linux-arm-kernel/202102030727.gqTokACH-lkp@intel.com

Pavel Tatashin (1):
  kexec: move machine_kexec_post_load() to public interface

 include/linux/kexec.h   | 2 ++
 kernel/kexec_internal.h | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.25.1

