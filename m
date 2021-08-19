Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39973F123D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 06:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhHSEMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 00:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhHSEMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 00:12:09 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4553FC061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 21:11:32 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id oc2-20020a17090b1c0200b00179e56772d6so533692pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 21:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l9V52lFXnbzIWhvicXmSUoCiNa+k48jmUozZvt1wwMA=;
        b=JeDWLhWYL5wrSLivNoZl63hO5tzIxwhTMBYGb4KkCaIPoo8GYi0ZSflOROX3slGOg7
         E/hW3L4YHevt5OSBpLYNFeGE3DapiQz0gf1u+T0hajTgwuVoQZLzgcLrb+1GtqdP6/I4
         hG3BZ2SMViADd80+l41SzSiDTq6UPXPWo0HprOoosWR0ICdwkX6LafzICjxtRaI699DO
         xzbyRJ8vt6VKIchufCuYauLIBg7WLX8ezAmmOt3UerFAewVD3GDcIf1NO0c3LR9/S6iD
         NgGO9/H6fJ9UsL0JK/WLLxQf/r7SRAUl9SFmkWK+evolcvhvTTLq4wQhZPPwr3aHanQj
         GrFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l9V52lFXnbzIWhvicXmSUoCiNa+k48jmUozZvt1wwMA=;
        b=uknEQixu1e3XKmxjjPzuUHUaM7zPqNQQYWvhseUnunJPjnBRkDC4LVMKzoCTSAOS2H
         3u1LmThq9M7ByDEkgCu0t4PcCKqf6E2JNjRVyLQyaLtgCKID/SxM6TAEoBmvKjcMYmxv
         57J1zakBA5vvTcAcT507bnpPzDwaCfFC/tA46lr+Boxa7qnLRlyoXkRZjeDJLqzn/EO4
         Qn3f+q6JuhohDp3Uv4y7i4yjOluJIsIivLv6g1paXW1ga6QtyuUUqLQIBgS+V4u9iK02
         y39pdu0keeaxqhBOwxmUoM2CjDjBdpgXbNCEM/w3jnK0NPvRB3TdoWOgyShgP6LVIAkN
         atWQ==
X-Gm-Message-State: AOAM530Dq96ZGXMyyvc8mKMJQBTwbt1VA4tKDP3KqLR3KbFORtEpKmQp
        oVhuIOYtNj+qVvf42CzulVlNKpK/Tyfv0pT6
X-Google-Smtp-Source: ABdhPJyVc7alcNLAZaxiTjphOI675WFj9OYd1quw6wkhMgVFJvvcLF/cqq/2Fh3YvqOoujxNHkNvBg==
X-Received: by 2002:a17:90a:2fc2:: with SMTP id n2mr12330350pjm.112.1629346291807;
        Wed, 18 Aug 2021 21:11:31 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id z19sm1408338pfn.94.2021.08.18.21.11.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Aug 2021 21:11:31 -0700 (PDT)
From:   yanghui <yanghui.def@bytedance.com>
To:     john.stultz@linaro.org
Cc:     tglx@linutronix.de, sboyd@kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com, duanxiongchun@bytedance.com,
        yanghui <yanghui.def@bytedance.com>
Subject: [RFC] Time/clocksource:The clock source was misjudged as unstable
Date:   Thu, 19 Aug 2021 12:10:08 +0800
Message-Id: <20210819041008.14693-1-yanghui.def@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We use clocksource_watchdog() to monitor whether the current clocksource is
stable every WATCHDOG_INTERVAL. But clocksource_watchdog() can't be schedule
in time when current CPU occurs Softlockup. This will bring following 
clocksource misjudgment problem:

if the clocksource_watchdog() schedule time longer then WATCHDOG_INTERVAL,
the value of abs(cs_nsec - wd_nsec) will be enlarged a lot, but both of
the clocksource is normal at this time. And if the value is bigger than
md, system will misjudge that current clocksource is unstable then to select
another clocksource.

So we think this is a situation that Softlockup causes the clocksource
to be misjudged. We want to know is there have some good idea to solve
this problem ? Actually we want to use hrtimer to replace normal timer.
But hrtimer is difficult to execute in turn on each CPU when the system 
is just boot up. Is there a better way to solve this problem ?

Thanks

Signed-off-by: yanghui <yanghui.def@bytedance.com>
---
 
-- 
2.20.1

