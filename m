Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972043CC3F5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 17:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbhGQPFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 11:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234330AbhGQPFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 11:05:24 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D71C061764
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 08:02:27 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id a5-20020a7bc1c50000b02901e3bbe0939bso7649216wmj.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 08:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fg1LMtio76TZBE+V6rtOm0zM6x8DkN+VarQiinH1Wgc=;
        b=faMTee1KLLK/gxHwB6xs8Qh7MSM+lyJqIllmAQzXHU9Rj+GaxvQ7gRItAlALDTfjbA
         U0LnhQZa9JnvVjfYEy0PDJ+3g736Bg58SGI88j3BPbsy64ZE7OZGlOlBmtGxEGKvxt9m
         wt1fBxB6f6nA/Hw1OfSj8WRTm/xjb2gIxTo8bAizXtnvhS9w/LZvcVStZsbpGJzE35M8
         X4H3gr3kPfYMSyVfMmha2c4pyVmM5LFl/tvJHlvfy+ohnIaiPN7WKPwlXD6GTvObQi8w
         yIUue95attXaHLhM5C0eGA7JFSY6NhbHLvuds0JDHwEaqiJHiz/UT1zhsB929cTP648H
         xMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fg1LMtio76TZBE+V6rtOm0zM6x8DkN+VarQiinH1Wgc=;
        b=TzsFBmMKAaC7n4sELcOXQfSJPKI+oxFoofjhOcyg5qk6iUMb/9N6o/X6jhmL1LOA+a
         ki9wJHHUM44ocQZbur0x0F2W5V2LIe2qxG0BXZAj1APp4rbRWY6QyCP6FcE29sk4NUMh
         uJmzmdjyZgge/qUub428pUg//Xhu3R1pZguOamJk0D9sbQCBiBVuZm5wC4c5ZSELlL/W
         1m5+n1PAFdxVeOc3sVXcSCMCh/b0G9/2lhdgI0mQB8LWwVNGpZ9jLoCNBLy/M7J/Ph6D
         hGBh/G56VCL8J2cQv1WWdKZZK6j92NC0/yvYj7jFi0Fz+gBCpoA/SNKgqinXcGHJNcBN
         sDNw==
X-Gm-Message-State: AOAM531KYufeCH0hMJ2Is24KXe8hn+PlFLPKBCWFDGw4iWUOI5badrTV
        Z/4vwbPai/IpLsBgYOMGKPfqXZyxGLCZ3g==
X-Google-Smtp-Source: ABdhPJzLE5PXsOdOG8/1nr+hubuiJIXWEW65BpE2t6FhngSXXLcApOIg0N3U6iYgEW844BU8Q8MWpA==
X-Received: by 2002:a7b:c955:: with SMTP id i21mr22579994wml.147.1626534145832;
        Sat, 17 Jul 2021 08:02:25 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id v9sm11372463wml.36.2021.07.17.08.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 08:02:25 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jakub Kicinski <kuba@kernel.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        YueHaibing <yuehaibing@huawei.com>, netdev@vger.kernel.org,
        stable@kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 0/2] xfrm/compat: Fix xfrm_spdattr_type_t copying
Date:   Sat, 17 Jul 2021 16:02:20 +0100
Message-Id: <20210717150222.416329-1-dima@arista.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the fix for both 32=>64 and 64=>32 bit translators and a
selftest that reproduced the issue.

Big thanks to YueHaibing for fuzzing and reporting the issue,
I really appreciate it!

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: YueHaibing <yuehaibing@huawei.com>
Cc: netdev@vger.kernel.org

Dmitry Safonov (2):
  net/xfrm/compat: Copy xfrm_spdattr_type_t atributes
  selftests/net/ipsec: Add test for xfrm_spdattr_type_t

 net/xfrm/xfrm_compat.c              |  49 ++++++++-
 tools/testing/selftests/net/ipsec.c | 165 +++++++++++++++++++++++++++-
 2 files changed, 207 insertions(+), 7 deletions(-)


base-commit: e73f0f0ee7541171d89f2e2491130c7771ba58d3
-- 
2.32.0

