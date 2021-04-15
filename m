Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0C2361368
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 22:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235356AbhDOUYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 16:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbhDOUYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 16:24:31 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909AEC061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 13:24:06 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id nm3-20020a17090b19c3b029014e1bbf6c60so9164653pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 13:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RAXoYkprowFqCX7hiZm4GG8LZxe+i0LK+61fU0cYCZ8=;
        b=yBOMS8XkuoYJFLD8ELgKzgG0pcHwh5wCBiDMqFCtVM8ebI0g0K/aBvjdoVq9VL1SuK
         gNkfQHnDMpYaYHVhv9+cpGhRVhWB09TZYulGFstGkV5ls7RfV5Gb8/YF/EFUd5/+/grJ
         dYPjPiOwVX2Rl5kahz8H12NtqSGhGXDiaCqZt6ysqw7uds2uBK/oplQf4pzQ65HMBuMO
         mSrE/3pmtU744C+xrY0sHUIQzBq5vODZAoXVUuOIHS27IMWWmIjLID08xW4MjGiK9Vjm
         ZJeS2dgiXNsfqeS6CSYfAe3JwwkBAirj6Nvj/jao0bOYxO3sXe+Q/kfwNS+SdUoCA1fR
         mE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RAXoYkprowFqCX7hiZm4GG8LZxe+i0LK+61fU0cYCZ8=;
        b=jBnXmefYY1Cg9QI11UZABXH/84rnE0QA8TbTaCEpNVyNx+kmWLZokLgnJXh1UFUHlo
         MfZuOeB5aDqaMmk0KtlJTOSdFpANTXGkqao/BE79bhNov2Ip4M9ak42ixnDpQnnJpehe
         niTAP0TSTz1E8esbUEC4efJ9J62vAFpzfDgcCP2d3g38O7cj+K0cDJeJxnn7hAw5wkaV
         UBpujAZ9QUjoBoB89bZ/McGyIfNMcMrVYNc55SikNZmuPQqSnXbJr/CPiCqkTKNat5xe
         tJ4fc20VijYVgj6hWuGkAlce7U41yBWtxuKqDufYrSxld4Myvo8SDdvR8jpeJiKEyg+Z
         oEqQ==
X-Gm-Message-State: AOAM532CJ8rXLzPSlv9F3PmImDfeNRxqo0i+wedpjsOqiceoIfoRHY9F
        LlYMhE3dYbfmX9Pu+xr70ra8qQ==
X-Google-Smtp-Source: ABdhPJzomE1CxA3N3z6sepYQr9clOVjiMwU4M7NrfFJ55uXZZxdOTUz5tcoYMZejFmyh27S3hn89mA==
X-Received: by 2002:a17:902:ff09:b029:eb:3d5a:1332 with SMTP id f9-20020a170902ff09b02900eb3d5a1332mr5706483plj.24.1618518246058;
        Thu, 15 Apr 2021 13:24:06 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id kk6sm3275829pjb.51.2021.04.15.13.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 13:24:05 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     mike.leach@linaro.org, leo.yan@linaro.org, suzuki.poulose@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] coresight: Fix for v5.12-rc7 
Date:   Thu, 15 Apr 2021 14:24:03 -0600
Message-Id: <20210415202404.945368-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please consider this patch as a fix for v5.12-rc7.  Applies cleanly
to your char-misc-linus branch (e49d033bddf5).

Thanks,
Mathieu

Mike Leach (1):
  coresight: etm-perf: Fix define build issue when built as module

 drivers/hwtracing/coresight/coresight-etm-perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.25.1

