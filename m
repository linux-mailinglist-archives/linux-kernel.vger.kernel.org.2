Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4342C31919E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 18:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbhBKRyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 12:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhBKRVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 12:21:21 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF73C061788
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 09:20:41 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id d2so3776440pjs.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 09:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jf7uz7KkvG7cuDcx18HVh+0IJQIL4h8EveTLHjDAfiU=;
        b=iCnUnCFOpfLcPGLQ1cfdZVP4ekS9UJfidbrUINg1rY3vIelBJ9xUq+mV7Wpqkkfybj
         M5XX/HHJDwJMUS6QE1JLORhUHscDG1MxXRebf+82uD+8qxnSJvgFX+VqXaFX5+hMzISO
         IZoCm8ZZ7tmulH89bbKUyDpejY0juzcZJyfK9JyrdSdiD1uqvkSKlCU89H53e9EALk4y
         hmeU80bgxDam3iWslqmsR3bInjCsD6pgYDK43ucZALlVYkdMOqIWCArRH8IT7BssT/hp
         wv0EIFQ1RQvXwZz43SINeReGz2QJSXYwAygZ//9WwaCEqm/3xetrkFKCY2BEDwyJUaqX
         zOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jf7uz7KkvG7cuDcx18HVh+0IJQIL4h8EveTLHjDAfiU=;
        b=MQaIUSIyie1CfdIunn586M51nbQ5hLkMCZQfFyzf7VsGjWrE2MIUcYOw/2ERyBWek4
         aOpm+PnKWEP7U0QYT5Izz270dy4cjRfEM1kIPIOp9rQ2lipzjAJLt4uX00fGyMXVGjoS
         wG9xV2KddK7ST1zMS5P4jxa1A2AN3uWZxc7NnP+0TlqDRsn2xD2edk3NEuBnojO6EOjA
         SoUcGtNT12RJsR0WejsI1Uehi4LL5iKjUY1p/kBPSZGFGS+qfH/384ykf4NEbU9GXO5L
         /bRNMKmYx9PUT+4BpcpjTrTMevm6ahuqEoRfr/z+XaOhAgjMLoaus1uDykYkAd5Zdrnq
         9Zvw==
X-Gm-Message-State: AOAM530k20v1x8DeuCqd37RsuCKNaKSkCwKL2wINj2+MDIBHBWJ/WfTq
        OiXA1JTD2jROLNIiHLAuQl2Ihg==
X-Google-Smtp-Source: ABdhPJwY0Se4VDZCQ5dyTr1QsViauTzwNsI6dapdeOb6n28m3VplVdAODI9Ix3+fTwTpSLqT5DS37Q==
X-Received: by 2002:a17:902:d48b:b029:e1:f87:265d with SMTP id c11-20020a170902d48bb02900e10f87265dmr8649453plg.1.1613064040857;
        Thu, 11 Feb 2021 09:20:40 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e15sm7415384pgr.81.2021.02.11.09.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 09:20:40 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] coresight: Patches for v5.12 (part 2)    
Date:   Thu, 11 Feb 2021 10:20:35 -0700
Message-Id: <20210211172038.2483517-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning,

My previous submission had the wrong baseline and as such was missing a patch.
This set applies properly on [1].

Thanks for the patience,
Mathieu

[1]. 48139bad913d ACRN: update MAINTAINERS: mailing list is subscribers-only

Leo Yan (2):
  coresight: etm-perf: Clarify comment on perf options
  Documentation: coresight: Add PID tracing description

Suzuki K Poulose (1):
  coresight: etm-perf: Support PID tracing for kernel at EL2

 Documentation/trace/coresight/coresight.rst   | 32 +++++++++++++++++++
 .../hwtracing/coresight/coresight-etm-perf.c  | 32 +++++++++++++++++--
 .../coresight/coresight-etm4x-core.c          | 13 ++++++++
 include/linux/coresight-pmu.h                 | 20 +++++++++---
 4 files changed, 90 insertions(+), 7 deletions(-)

-- 
2.25.1

