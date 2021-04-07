Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E83357143
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 18:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353996AbhDGQAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 12:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245406AbhDGQAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 12:00:18 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E25C061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 09:00:09 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id c204so9459596pfc.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 09:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rDqBmqtcjCQnS2ELUddbb59S8zRaad/3uX3MFWpjJMI=;
        b=aZ+EbS8xAhDpR+j0vK1tcPzg/dQZ7tMknFDgLQ7dGI7KV69YQmnBZHUboF8oh6SVSL
         p1yvQD7M2hxJB8IqSkN2uXg8h8GfFQgu6e4oz6QL/Cu+r3GW7lt4dxXusWyM1AH3xiB/
         GtvFSUUsk3Wsy2xmP7ISBVF0X9DC7pea1zGWKwAi6/T9aXWFRFmOT9ZWtS3p7YBfKVki
         JQotLFXpfuJ5aSgCbrIFScugCdpvkkDAfF5YH9hwvXQEkHKKb97oXD6aMg6ktcH5yc7w
         gW1F0HhSXS2//jSi2etinywCS9oBlGoOkJWvarf5DCtxEFe05ORWPjJ2HhFpOcgpdRUL
         wSjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rDqBmqtcjCQnS2ELUddbb59S8zRaad/3uX3MFWpjJMI=;
        b=AeCUi9RdtAadMADM5VRS52qSvARw7R4Q+6qdwjPqadCqAlxRZb6ciAlNMsojewsQjE
         FW+YTxK1SWgh8hyk/0EAqbhLs3Lh9VhdtcvTi2A1aDZtAzU8YYzZLqt1joepnEW7UUzR
         vwtGjwh6AhReXpVLw4HP5HnNaszBTMdeb1UnRrJTVBb810h6QqY5eZNEGZGVEoya3Y5Z
         n0hWK096LOVbZIWx533CHOMiad+2xNVUzA5BxI7XU+u2j0MMYkyF808owf/kHRBQhdFR
         +JVXDkss/LX/644YhRZQuPSOMMvRyBfg2bL0nu7sRf3Jk6hIBcjT8K0npSJ00ccg/qIP
         2xVQ==
X-Gm-Message-State: AOAM5320XKLe5OWilirQk7/ojzXS76KuZ35KUs/UxhOazQWPCrKLUnFw
        wzLKOvw26FANHqICVQHoM6GDag==
X-Google-Smtp-Source: ABdhPJyNtskc4EXOAkfyuZ2yXMDiVucjly1QnBlRu9zJwxmWM7UhArY/Mcmpb1eSeLk3bJkRgxWXhQ==
X-Received: by 2002:a62:9253:0:b029:242:2150:f98a with SMTP id o80-20020a6292530000b02902422150f98amr3043311pfd.24.1617811208936;
        Wed, 07 Apr 2021 09:00:08 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id s22sm21464713pfe.150.2021.04.07.09.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 09:00:08 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] coresight: Patches for v5.13
Date:   Wed,  7 Apr 2021 10:00:03 -0600
Message-Id: <20210407160007.418053-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

These are the coresight patches I'd like you to consider for
the v5.13 cycle.  There is only 4, the other ones will go
go through Marc's kvmarm tree as previously agreed.

I may have another (big) set coming later this week or early
next week but it may be on the late side for this much code.
We'll see when we get there.

Thanks,
Mathieu   


Mathieu Poirier (1):
  MAINTAINERS: Add CoreSight header files

Qi Liu (1):
  coresight: core: Fix typo in coresight-core.c

Sai Prakash Ranjan (1):
  coresight: etm4x: Add ETM PID for Cortex-A78

Wei Yongjun (1):
  coresight: etm: perf: Make symbol 'format_attr_contextid' static

 MAINTAINERS                                        | 1 +
 drivers/hwtracing/coresight/coresight-core.c       | 2 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c   | 2 +-
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 1 +
 4 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.25.1

