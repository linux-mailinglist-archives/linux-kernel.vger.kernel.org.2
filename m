Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88430316B7F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 17:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbhBJQlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 11:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbhBJQgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 11:36:55 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B043C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 08:36:15 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id d2so1446702pjs.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 08:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=305bawbr6bhDzFzbvjwe6q07nccKcFNv0FLOKbFicwA=;
        b=fjW6xgTMI9f3NirGTVlh2npLqQ3mgg3Wyrdapdb2Q3FFEX1OAzxYyC63BRaAKLE4P1
         qHURKnyq8QIKBax2PSCAjPOShi9tvt9tUY0lGhhlNbGD/nA2q6PI2Y1fQTuZUPG2OLWV
         EeKEvSNHBgpUXZPt9RL1h0oAgVB+0m0vQkJtfXq4Inqfglda9XP+rm/cwX2fFxj6ra7o
         3M1f+WlKO5qAnmofHSoXf+J72v6vcVbDlTLJGB1lxnfwhSYpnl6zRVQKqw6ouAHV7MTf
         uT6SvlQ3eLIogQ2MqPSvV8i93nxmxTdl1hum5/1NSrbhGrCN5/kf0+L6gJZ/nazCaThk
         M5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=305bawbr6bhDzFzbvjwe6q07nccKcFNv0FLOKbFicwA=;
        b=G9jMRv9vYKPYL/UAK7sXlLR8Dvmzk11UyG6qZdhPQDdh9gjVrQ6dnYTDcWxrgNTWi/
         uZbxQGuksXJuVCyLTXkLpVtuJeThiaoBKDUZso0Zd87oOTvQISbCj2HLMAgSYD89GN2k
         wl9XCRMMslNOVhaJi3BUzeWp4FRedCMxfasRso+HX/vA/MfPjg90ONk5yRqVne6LvY0H
         pxaS7vf7FSbKF/Thc8GneAaw2ParWLViLHV5Ijelciob5px0r1oBiShGub9G0wo32tkb
         kYUIQVnmjf4hynT2PNnlRoWZWaag59zqfkJxddTeJ8Uh+yQ4Phu8RWrvEkmNvPMiSYFC
         wX6A==
X-Gm-Message-State: AOAM5311jeCP09UzGBr8xDZZTmjMN8EGOe8tpMeD+Hb6AuGiBFSEhRkh
        +zdTk5RbQ+N4PDtfwenu4OssPgEVvMbFhg==
X-Google-Smtp-Source: ABdhPJxn+/ALnUerZmnhHi5/jLdTqT716P33qbFDoOb7NCqOfDLitQr7We+vkGnqgl7jZs3attDqSQ==
X-Received: by 2002:a17:902:9008:b029:e2:e6fd:2d16 with SMTP id a8-20020a1709029008b02900e2e6fd2d16mr3841002plp.35.1612974972644;
        Wed, 10 Feb 2021 08:36:12 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id bv21sm2914637pjb.15.2021.02.10.08.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 08:36:10 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] coresight: Patches for v5.12 (part 2)
Date:   Wed, 10 Feb 2021 09:36:08 -0700
Message-Id: <20210210163610.2338491-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please see if you can add these 2 patches to your 5.12 tally.  No worries
if you think it is too close to the merge window, I'll simply queue them
for the next one.

Thanks,
Mathieu

Leo Yan (1):
  Documentation: coresight: Add PID tracing description

Suzuki K Poulose (1):
  coresight: etm-perf: Support PID tracing for kernel at EL2

 Documentation/trace/coresight/coresight.rst   | 32 +++++++++++++++++++
 .../hwtracing/coresight/coresight-etm-perf.c  | 27 +++++++++++++++-
 .../coresight/coresight-etm4x-core.c          | 13 ++++++++
 include/linux/coresight-pmu.h                 |  3 ++
 4 files changed, 74 insertions(+), 1 deletion(-)

-- 
2.25.1

