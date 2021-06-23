Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5373B21F5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 22:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhFWUmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 16:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhFWUmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 16:42:08 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B20C061767
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 13:39:50 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g4so2207725pjk.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 13:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pz31bWQ9kj3qQxfwbW4zNhCR6wU6ct/Uhdf374m05ZM=;
        b=bVah6ky5q1Oyu9Bp7zUuTiUXvq5aoO9izpLs3ix4WNWc7MmO6OWAc+KUoYmrjiaT8q
         Y45rQu0/kDD5K2LbPpN/5KIewbmXUkAd2EISHTAOFbWVbLTMpd4QC9MtGZcqXQMtn+Zt
         G9ATsaYiGlyYF4qtjGeUvi+nh3DWNzahK7ysY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pz31bWQ9kj3qQxfwbW4zNhCR6wU6ct/Uhdf374m05ZM=;
        b=OSHE8dBhB6avnGmsmJL8tBF5du7t88Mg6KvQYAOdHmqq1XBKZqP/EHfMLcBw8uYgHI
         4BukGvv4ZTcilyUjjo3XX++tFQtEThWwP4ZFP9hX/ICMu5/xAr7W7t79jfGdhTAzrXcC
         Mj96xYUIBgRSW0BRijWwSNqRuDbeTb6bIuGL2WTddVsTrlfJVgTpOsn4/V5rPW7aexkf
         8fevMuo3gfwjeJD7UTNzh63/LOaDI2NYxLQmrhllY3qLMfYG5MHZRr65nm6m0ZQbKAhJ
         NW4XwVyNkLGTyY6RFZrDGrp34dPbbLQwxHOK/IhcsI6v2yIF0b7oluXeBda8gY7XOqTa
         SbFA==
X-Gm-Message-State: AOAM5309sLAfHSvRPv7BoMCUBOJ24QanG8+YTk39uwdDmSV8HWXpsRCI
        qL4R6/ilXFaC438sFXjPxYDYiQ==
X-Google-Smtp-Source: ABdhPJyseZfK6ymKJ1p5VaH3usDgxd6X9v2WJaXwac+1vU0OCFOx4hrbbiaiMbNuXL3Niss8HQPHiA==
X-Received: by 2002:a17:902:c409:b029:122:5537:95a6 with SMTP id k9-20020a170902c409b0290122553795a6mr1169407plk.11.1624480789847;
        Wed, 23 Jun 2021 13:39:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k9sm11010pgq.27.2021.06.23.13.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 13:39:48 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, kernelci@groups.io,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 8/9] selftests/lkdtm: Enable various testable CONFIGs
Date:   Wed, 23 Jun 2021 13:39:35 -0700
Message-Id: <20210623203936.3151093-9-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210623203936.3151093-1-keescook@chromium.org>
References: <20210623203936.3151093-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=938; h=from:subject; bh=mdLx0vJytUGz90du5cztVKVI/zg4LXTq/ivSPE9DL2U=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBg05wH6iQBLxV7pGZqSa7Oe0Zz9JY7N80557pAMpGH Y/TrfFmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYNOcBwAKCRCJcvTf3G3AJi9cD/ 4pY9gsJ0RUllyeaqn5C+w1B8pZc3dk6y9Dg4l5Uj+b4YJtlbDih3/wCb8cgUm0wo1sPAVse8PVeE+G J4Sepi+DP76OW+fuC4Ytf2zJST1Y47xdldZ2r3QAeduXBlCrGyLdziGma1HEeDRRcIUPq0G4lZvUJG g2aAhicvvMuGZsafw3WrOkiOkrMjYOM7eY/YHfv0UD34kHI9AnhzU+ZYbilOTxSdLbBzsJ3RtYnSiT HXLwCW+7YT8qQs8+fCMTtYTRfnGHG/FYYHosthcrUVjpE55x9l/l22JYd5tqpqGT0Iaz98Y4yKdZH0 ty/hAVob66L0hVjQHp624rqU0nXd0xr9Q+Y2fmc3DS3/HMrrhlMo7nhsVUOSf98/G2l5ldSjdxl/hm 9B9TTY2DyCxTsDOeSkAOVHA0RzE2g4Lhf7P41ConRrs0nI5RYrL6dR8vA/nfxf93yxGtGeUEWkeWL4 x4mbMwUUjJM7duARlmqNJZqYvVSviR2nFf+HpIfC2nNzgGJ0IbvQan66MFQSZIIrmPoJ+Q7JzPmwF5 QXVnAcFsH8h3ZGw4oEdrafr4BjLrvrVDrnTh+PUFvAKpoFWhXKuVsi0TIX45xjUIcHQcvScoXdCJQu +pDKxVhxnnFHoI+JA16YzjmHm6J7XzIApnpp4hoOhvym/RPNV771Bfqw1FXg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a handful of LKDTM-testable features that depend on certain CONFIGs
so that they are visible in logs for CI systems that run the selftests.
Others could be added, but may be seen as having too high a trade-off
for general testing.

Cc: kernelci@groups.io
Suggested-by: Guillaume Tucker <guillaume.tucker@collabora.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/lkdtm/config | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/lkdtm/config b/tools/testing/selftests/lkdtm/config
index d874990e442b..849799bcfa95 100644
--- a/tools/testing/selftests/lkdtm/config
+++ b/tools/testing/selftests/lkdtm/config
@@ -1 +1,7 @@
 CONFIG_LKDTM=y
+CONFIG_DEBUG_LIST=y
+CONFIG_SLAB_FREELIST_HARDENED=y
+CONFIG_FORTIFY_SOURCE=y
+CONFIG_HARDENED_USERCOPY=y
+# CONFIG_HARDENED_USERCOPY_FALLBACK is not set
+CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
-- 
2.30.2

