Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9924D30DFD3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 17:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbhBCQfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 11:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234069AbhBCQfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:35:15 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E843C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 08:34:33 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id x9so160607plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 08:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=squareup.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=DFGVEiHxg24uMdv6R4xvyMV6FOUeg6NdVr0skbtnwI8=;
        b=VM1tRgZLzx9Balr4tiy3MwFBLb7SfnyRMyvmpMEaUHjccISpm+boHNd4S9IElbizBP
         H7U3jQLmvKPYMXiLTUGD/+v3iLN490GGrTZDLdAO/gzhyZk9/esFo+zJ12vVLsPJwm4a
         HPjdgjMWguZ45EFfF7FMVohV0PubMaXYpwRxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DFGVEiHxg24uMdv6R4xvyMV6FOUeg6NdVr0skbtnwI8=;
        b=l6xMVSeJHqMaTk7dsjqj7SragWGW/CoYhegFB1oe/KGORd/cm/36f2hnGldf5VsbNt
         IwIBb+GcpdQXN9CQsDbwmm76vPuxynq0HLPVROggSYuiby0VJ1LGJbkkLCyVT3m1ERZp
         D1FNa0LhP+OTuBbL6378OW77O1R41CevH/jO5TZXrBnRRfB4kpYRV2pcgX8pbb54QbvV
         6o09x9BobiK4W2SJEvlILGxfEQTuwXFRmBAqoP7dBF6OIfylcjumDWqe6uB0gBiEbXff
         TfcgHcMX3zR4C50+cjXi76LKjyvSycrG28uBUi45larUZJ6cnc+ORybrD7G2O9bfHTl5
         I1pg==
X-Gm-Message-State: AOAM532g+F6Gs+jlkYxADi+Ko0M86mPx+JKV1/e7dZf1Jez3C6wmVj1X
        /JcP+lErSPGvPgb5hQNnbYoEGQ==
X-Google-Smtp-Source: ABdhPJxVFieHHvztwzGRBxoj7pt/73HY8QHXbsNiMFjFOdn+9OF/OoE3lz8tCEkS1Yt9SMRYg7vRBw==
X-Received: by 2002:a17:902:5998:b029:e1:880c:a352 with SMTP id p24-20020a1709025998b02900e1880ca352mr3928416pli.70.1612370072639;
        Wed, 03 Feb 2021 08:34:32 -0800 (PST)
Received: from localhost (162-207-206-139.lightspeed.sntcca.sbcglobal.net. [162.207.206.139])
        by smtp.gmail.com with ESMTPSA id d18sm2526515pjs.31.2021.02.03.08.34.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2021 08:34:31 -0800 (PST)
From:   Benjamin Li <benl@squareup.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     square@linaro.org, kernel@squareup.com,
        Benjamin Li <benl@squareup.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Clean up MSM8939 interconnect driver
Date:   Wed,  3 Feb 2021 08:34:05 -0800
Message-Id: <20210203163407.9222-1-benl@squareup.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following up on a review comment on commit 6c6fe5d3dc5e ("interconnect: qcom:
Add MSM8939 interconnect provider driver") to clean up some log pollution.

This is based on icc-next (which appears to contain a refactor commonizing
functions into icc-rpm.c).

Benjamin Li (2):
  interconnect: qcom: icc-rpm: record slave RPM id in error log
  interconnect: qcom: msm8939: remove rpm-ids from non-RPM nodes

 drivers/interconnect/qcom/icc-rpm.c |  4 ++--
 drivers/interconnect/qcom/msm8939.c | 16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.17.1

