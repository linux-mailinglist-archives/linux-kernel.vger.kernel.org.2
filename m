Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3D73E835C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 21:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhHJTCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 15:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhHJTCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 15:02:25 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1C2C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 12:02:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b4-20020a252e440000b0290593da85d104so320758ybn.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 12:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=X6g7ICk492Gxyfph4kIwhGSOwiekjxuFWOsErFX/4sw=;
        b=Gm9Lhds1E+qOMg/ChCJsQf3NfCNOPV2A0uhEAObtIbJbeEGAh6+favE4VWlWimjvtm
         jU94uSGExUcNHEufojQCvmZfk+SGsm2aDwgBsInte8E0JgCDRmjMsEQEl3pOimzjqoKW
         Bo1oYRlZm2qI03BP1I+tX2AHwI1dVRdt24PQvEE1cOZTMcowffSZYJ/+IawFRW2sjd/l
         8jiMrrQ1fhmmmJknIuoXiDkVr4NIy8JPVfTunaWSObhGIvqptB4Toamo151y29Ubt2Ub
         k6uSlOw+X1SLqECz9bA8VQW/bRHa7YPgf76arb0gq87eWsKEP4SISNSNRAIIB9x+yZSc
         WI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=X6g7ICk492Gxyfph4kIwhGSOwiekjxuFWOsErFX/4sw=;
        b=j5K1SsK41IxfjiQXRRG2yOH1bMvQJj7v0EMVE/PmwpEVSJwSwSpNzum3qzluAkPTNg
         sk5qFVJrH+/OlQIgX8+gQSfAXmmmhJEVOhm/g4TLDs3TkkrakLhDOjA4SjLhp7iZoBkb
         l5hx3L3/QU72MHosJtzVBhD/UWw1gDIQAkOf+N6QXnVYSDSJeL3mop/KNoL0qjt4LK9M
         6umx9dV6M42O+dYvyDkioPMkD4HtHwB0M9bWjKzEoxPPSdTKEfwMBu8qAtSZEflttnkS
         Sx9zAZSMw7K4AVPh1RoNLJAmyiDxQmwg4ipu3C1XfEXJzEa7aonvLBzvNmNAX2gTBuyS
         xX8A==
X-Gm-Message-State: AOAM532OG1KYaezgTF0UAYnb22JXvwv0qQBVBN4Bgzfl+7ysPEidUPbB
        fRxaYE48cPbffYfaq1Jyq118buLYUACoayvxPg/sSw==
X-Google-Smtp-Source: ABdhPJw9czGkntFlj8rDww5lPMiKUDUzrfBLWDNHuf/ED9JGGaslY72cFL5vGwpuC6B229nCZrayPk7nO6u+JCKvEwm9cg==
X-Received: from mustash.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:337b])
 (user=richardsonnick job=sendgmr) by 2002:a25:eb0c:: with SMTP id
 d12mr40983840ybs.206.1628622122396; Tue, 10 Aug 2021 12:02:02 -0700 (PDT)
Date:   Tue, 10 Aug 2021 19:01:52 +0000
Message-Id: <20210810190159.4103778-1-richardsonnick@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH V2 0/3] pktgen: Add IMIX mode
From:   Nicholas Richardson <richardsonnick@google.com>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     nrrichar@ncsu.edu, promanov@google.com, arunkaly@google.com,
        Nick Richardson <richardsonnick@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Di Zhu <zhudi21@huawei.com>, Ye Bin <yebin10@huawei.com>,
        Leesoo Ahn <dev@ooseel.net>,
        Yejune Deng <yejune.deng@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Richardson <richardsonnick@google.com>

Adds internet mix (IMIX) mode to pktgen. Internet mix is
included in many user-space network perf testing tools. It allows
for the user to specify a distribution of discrete packet sizes to be
generated. This type of test is common among vendors when perf testing 
their devices.
[RFC link: https://datatracker.ietf.org/doc/html/rfc2544#section-9.1]

This allows users to get a
more complete picture of how their device will perform in the
real-world.

This feature adds a command that allows users to specify an imix
distribution in the following format:
  imix_weights size_1,weight_1 size_2,weight_2 ... size_n,weight_n

The distribution of packets with size_i will be 
(weight_i / total_weights) where
total_weights = weight_1 + weight_2 + ... + weight_n

For example:
  imix_weights 40,7 576,4 1500,1

The pkt_size "40" will account for 7 / (7 + 4 + 1) = ~58% of the total
packets sent.

This patch was tested with the following:
1. imix_weights = 40,7 576,4 1500,1
2. imix_weights = 0,7 576,4 1500,1
  - Packet size of 0 is resized to the minimum, 42
3. imix_weights = 40,7 576,4 1500,1 count = 0
  - Zero count.
  - Runs until user stops pktgen.
Invalid Configurations
1. clone_skb = 200 imix_weights = 40,7 576,4 1500,1
    - Returns error code -524 (-ENOTSUPP) when setting imix_weights
2. len(imix_weights) > MAX_IMIX_ENTRIES
    - Returns -7 (-E2BIG)

This patch is split into three parts, each provide different aspects of
required functionality:
  1. Parse internet mix input.
  2. Add IMIX Distribution representation.
  3. Process and output IMIX results.

Changes in v2:
* Remove __ prefix outside of uAPI.
* Use seq_puts instead of seq_printf where necessary.
* Reorder variable declaration.
* Return -EINVAL instead of -ENOTSUPP when using IMIX with clone_skb > 0 

Nick Richardson (3):
  pktgen: Parse internet mix (imix) input
  pktgen: Add imix distribution bins
  pktgen: Add output for imix results

 net/core/pktgen.c | 163 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 162 insertions(+), 1 deletion(-)

-- 
2.32.0.605.g8dce9f2422-goog

