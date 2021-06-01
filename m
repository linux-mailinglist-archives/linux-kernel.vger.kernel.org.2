Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D12E397A61
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 21:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbhFATDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 15:03:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27232 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234685AbhFATDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 15:03:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622574127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OzyeX92287pCSCdjXYXY+AZCrTaKpCfaTR9pXZCLBvE=;
        b=NtlRp9jdqLb6OuJ/pMlI/Zk9rDqKdUZEyjRkMwN53/FLsBxm5Qz5jy2Vks7u0CFyKhh8a2
        UL3AAsPslOgWoKcfs2goeCAr4VvDYKEaByXzYhIR+QEdfenYec8rvtRzJZklVsyKI4AYha
        OlFohQzZ4Cukokj1YNUI3jts/qUnFJE=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-st6hAtQHNn2fRZDK7nrBHA-1; Tue, 01 Jun 2021 15:02:06 -0400
X-MC-Unique: st6hAtQHNn2fRZDK7nrBHA-1
Received: by mail-oi1-f197.google.com with SMTP id j12-20020a056808034cb02901f18cf8f4c5so229308oie.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 12:02:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OzyeX92287pCSCdjXYXY+AZCrTaKpCfaTR9pXZCLBvE=;
        b=lKnfa5DCDRIm7snfSI7IOcUljG6lNXr6lYXBDsFjgw/REW0WHbfYVQ/g11wudgjtK9
         IpvLK2YeK/d/t4xbMlcynQC1BiMS/TVhhVtZx4m5J2eq68y4xwRBN6kn534pspoSlZbu
         PuSwDv4741poZmvBja1FGtXfmIYXcmqAK/P7dH6m7puzyY8Ir85KeQlYR9wFXBMSQUdt
         0U579BGB/ijVtCEw1/g3TYOWRf2yyCVD0ikYDmThoIL+ptqGGsT9I6QQKyJCggaByYah
         QoxV6wwZ6811aqC3lAmeQU36D36pk96EcgkWSObqggyXmg+knOOCQhLfoWeNiXOED96h
         s4zA==
X-Gm-Message-State: AOAM532gm/EokP8R6chJAODAvS54BGibAFT+4Dz39LwrX2MKwobqHeVO
        y4Q1V/26AVcRMw/9cD/fnJS29kXAJCe0Y9TSK+owybbANHuR+Wq0OxFTgnzxqvL115Q3Te6sQEx
        TpjD2zLSYm/LTBE4kzOWP2mv4
X-Received: by 2002:a05:6830:19e5:: with SMTP id t5mr13680756ott.351.1622574125358;
        Tue, 01 Jun 2021 12:02:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwi1ijfArl6bJbOz+7gNbhwV8tt07NknMgOzP4eKM1GaXrNnLxFMcaBmzP/yXtHCkypQslZIg==
X-Received: by 2002:a05:6830:19e5:: with SMTP id t5mr13680730ott.351.1622574125169;
        Tue, 01 Jun 2021 12:02:05 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id d1sm3974430otu.9.2021.06.01.12.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 12:02:04 -0700 (PDT)
From:   trix@redhat.com
To:     agust@denx.de, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] powerpc: 52xx: add fallthrough in mpc52xx_wdt_ioctl()
Date:   Tue,  1 Jun 2021 12:02:00 -0700
Message-Id: <20210601190200.2637776-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

With gcc 10.3, there is this compiler error
compiler.h:56:26: error: this statement may
  fall through [-Werror=implicit-fallthrough=]

mpc52xx_gpt.c:586:2: note: here
  586 |  case WDIOC_GETTIMEOUT:
      |  ^~~~

So add the fallthrough pseudo keyword.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
index 8c0d324f657e..3823df235f25 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
@@ -582,6 +582,7 @@ static long mpc52xx_wdt_ioctl(struct file *file, unsigned int cmd,
 		if (ret)
 			break;
 		/* fall through and return the timeout */
+		fallthrough;
 
 	case WDIOC_GETTIMEOUT:
 		/* we need to round here as to avoid e.g. the following
-- 
2.26.3

