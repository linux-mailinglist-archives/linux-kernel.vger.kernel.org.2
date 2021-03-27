Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6E034B7EE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 16:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbhC0PTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 11:19:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21680 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230370AbhC0PT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 11:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616858368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GlZlQk9I1up349GpliLX8QJ0mLSUUut4KG9WICbUZFU=;
        b=CmrMTHCNwccP+wKU6tZzcbCjLq1D70nI9Oo85L0zgZ+X5dIspRxHyMpootGaC08lbyPLiJ
        DYWjIVRnGXmvGska7/k8kk4nWQY6ILOD+E7rt4+p8hTn5WoKql8ydWVFm48HF+kD+/Pwp+
        eywduu29xYmBWa4pTPGQQhQgUE09TaE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-I5lu5fW_OZet0mGiOZfi2w-1; Sat, 27 Mar 2021 11:19:26 -0400
X-MC-Unique: I5lu5fW_OZet0mGiOZfi2w-1
Received: by mail-qv1-f70.google.com with SMTP id ev19so7978661qvb.7
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 08:19:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GlZlQk9I1up349GpliLX8QJ0mLSUUut4KG9WICbUZFU=;
        b=ny7wZS1up/5V6hbFEWFPPkIg/H+scFryXe6Zduz7Hi4OePgMrHC7IGvQi0aIpW/KOd
         58yycw5HfbB24VV/Eq0zlyeHweQwmcA2fdUKt2ReRRbIkTvdo7+5zOFaqDQ8Bmvjgrar
         oJJivWCT0AvymBrBSmNGzPLngDOTEOkK57IikgTYPcIfhq9xm4mzz9qhA2Ly+r7opUWC
         8O1KDQeANWGT9SZ6TBXJetAjfY7HZ+4IWADgfAxoZl7xmtkUcuexj/RD3akQ5ohM0UEP
         LAQU9fH81yiIRtGvzH2WBuIBRn8Z7UFLOpT9o8r6duoenTm94AgnAOrMyCoJdniFJLKd
         e/fQ==
X-Gm-Message-State: AOAM532qcCz8ETu0cFNW2twoY/P3DpsdRiwdlbmV+/oWP8xHOiihIh88
        Y4sIJBDulExzKbfQAhhHW9Qo9knrIhWnTi3r5zSDNQwB5bJxaCkEeZxJufHoCXbSeGKQxgDv0hC
        EkhEVZL/IUYOZg92JNHiAguMd
X-Received: by 2002:a37:396:: with SMTP id 144mr17554482qkd.412.1616858366123;
        Sat, 27 Mar 2021 08:19:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4iMFw6qhJGHj+S8N41lQRl3sWh4PqitPW4UkobOGHsY7mD0Zvb1EwUrwqQeKRJW+wbqXJWA==
X-Received: by 2002:a37:396:: with SMTP id 144mr17554474qkd.412.1616858365923;
        Sat, 27 Mar 2021 08:19:25 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id h13sm7573936qtn.26.2021.03.27.08.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 08:19:25 -0700 (PDT)
From:   trix@redhat.com
To:     richard.gong@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] MAINTAINERS: add self as reviewer to INTEL STRATIX10 FIRMWARE DRIVERS
Date:   Sat, 27 Mar 2021 08:19:19 -0700
Message-Id: <20210327151919.453669-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The Intel stratix 10 is a fpga.  I review fpga's. So I want to help
in this related subsystem.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 67b104202602..00828de0a7bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9266,6 +9266,7 @@ F:	tools/power/x86/intel-speed-select/
 
 INTEL STRATIX10 FIRMWARE DRIVERS
 M:	Richard Gong <richard.gong@linux.intel.com>
+R:	Tom Rix <trix@redhat.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-devices-platform-stratix10-rsu
-- 
2.27.0

