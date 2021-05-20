Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3604F38AF36
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243209AbhETMxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242540AbhETMvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:51:37 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D77CC069173
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:14:15 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id u4-20020a05600c00c4b02901774b80945cso5280012wmm.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=63aR0ApZJ3bwroQWXqAaSkH9cV6NbSWgeKUqcgHI7+A=;
        b=FwbLKM2KkOv0flbvtj3nJnPuN0+A2r3yE/1kP07JVzwHo5CAewGS3FlOHT47wv+eje
         Ukb+qynmxWBL1JoL3mzRQiWF+x5dTlrdiwmyJ1CelSy6zUItrLRiDVyOfMFbL7uj7hon
         waxf4ZxdWSpAi2zOuJAXJ0NcgWVnl7PXa7AePVpn/y5ZdvWmSqVp1aflW3D9V9+i0Smu
         ALyRNqMW9E3jjT1z1bLSeRAlyh22qBbRn3ci9A+j298IVUCYzQo/vZEkvDm2KeUd0mX2
         lUWLleyUEqIDi8dwHDGlDdxoey80XmBjZKrw+PwTLvI1LP87RDpDU+HjgP8iSc/+8PBJ
         GPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=63aR0ApZJ3bwroQWXqAaSkH9cV6NbSWgeKUqcgHI7+A=;
        b=m9Zgge9Sv2z2PP+QHi5q29OMPuG3trQnRA596jC2bJn/ateQbYEzcTz/Pz8vd8m34u
         dyUIVPzegIU+3qN7RdDmBc4APAGy67A6bGdDVaVDMgtBoNS7No6WJCrzbaxvC9qaKw9k
         lI+Qkg+mswfK3dlFox00Fw88yafbsDXdCZiXHamHNpzaQhDby05DjtNrBMXzFqz7XvR+
         Srlz61lBs3XJLix0EDI801AsbKNi0oaaeRgEQW6oOjKIgNG/lkTZmouHSgyw3S+odQ/N
         6zb1+HioPL4r8hPDkH0yvET3su0s4HLO0e4kNt+rGFNTfsHKdRyLVPxcX2ZsQkI6GBE1
         ykFQ==
X-Gm-Message-State: AOAM532aAOCs4I3bLEiIC6KMDVubXcj9QNltysg3soHOBfiaXYhOJpak
        MZ+ZWtu5UPuEzZJOYaem4nA1EA==
X-Google-Smtp-Source: ABdhPJw1Fp+Jmjls9UkJh6YCn4HHFBXPq5pRCzpBsC65iVfftho44k60NMHVqYTzgP4lBPc3lSuE+g==
X-Received: by 2002:a05:600c:410a:: with SMTP id j10mr3730747wmi.26.1621512853737;
        Thu, 20 May 2021 05:14:13 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id 61sm3393704wrm.52.2021.05.20.05.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:14:13 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Lijun Pan <ljp@linux.ibm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Neuling <mikey@neuling.org>,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 15/16] char: hw_random: pseries-rng: Demote non-conformant kernel-doc header
Date:   Thu, 20 May 2021 13:13:46 +0100
Message-Id: <20210520121347.3467794-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520121347.3467794-1-lee.jones@linaro.org>
References: <20210520121347.3467794-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/char/hw_random/pseries-rng.c:42: warning: Function parameter or member 'vdev' not described in 'pseries_rng_get_desired_dma'

Cc: Matt Mackall <mpm@selenic.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Lijun Pan <ljp@linux.ibm.com>
Cc: "Uwe Kleine-König" <uwe@kleine-koenig.org>
Cc: Tyrel Datwyler <tyreld@linux.ibm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michael Neuling <mikey@neuling.org>
Cc: linux-crypto@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/char/hw_random/pseries-rng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/pseries-rng.c b/drivers/char/hw_random/pseries-rng.c
index f4949b689bd5a..62bdd5af1339f 100644
--- a/drivers/char/hw_random/pseries-rng.c
+++ b/drivers/char/hw_random/pseries-rng.c
@@ -29,7 +29,7 @@ static int pseries_rng_read(struct hwrng *rng, void *data, size_t max, bool wait
 	return 8;
 }
 
-/**
+/*
  * pseries_rng_get_desired_dma - Return desired DMA allocate for CMO operations
  *
  * This is a required function for a driver to operate in a CMO environment
-- 
2.31.1

