Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2F130A68E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 12:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhBALao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 06:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhBALad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 06:30:33 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF613C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 03:29:49 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id y142so3388369pfb.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 03:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8KCQl/gPKG5hY2dWpY33pBHeXNEX1+5+2w4qCOb2UH0=;
        b=fJEWm6mu8qztco9OUrjWv8uoyKW0BrK/UURiZmWqkU7MOC92a6QL8K4H1LVbAlLvO3
         0Bk/m8RM0AmPHxe+m1ACrrMvdXtjBnNN5UEPfcKBI/EFjIlQDY2Xii/M9mMdeQNyv/P9
         f7guQvFGKLU5NmD9ikLkP1+rR+Rdw9eHbcQnci/T+CvF8TXserxx1BvOFhEnSeMgm8kH
         Ua5uUyi7xk45mXjfgbRMAs4PZyDT9IMz67zq9XZYaxMlV+HzS2zonpibuYKbXjeZR07W
         ki2oC4wWxJQVtQRWeti1OLKyNZNNiG0u/MfHm/3xmjGYIcCKtl+D0Pqi9L0EQUcQ2Atm
         9H9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8KCQl/gPKG5hY2dWpY33pBHeXNEX1+5+2w4qCOb2UH0=;
        b=MS3hgbBWHahdDqADbpbGB+dawma/d/zlH6PPkbuq/yCaSwNjX/VszF1pKCgr0PblEJ
         R2WK/+ZExZTf1PJkvg+Xeoeuhj3q63+tyH7ZgXqgx0a/Zbyzq/ZxpCYYDk2EqOhwfA9g
         BOLLFQyV29bbam49WmAjv9fYuzaJm8eEcRhuPdcw4YRjUQJ9pcjprWYmq00yHdUvI+kP
         e+fTgUAKM+kqSwDdyBd9a4M2+c50emdRa1prudoX+vN9x4qm5YR/aOrW/ON2M5nNyZ8/
         rfMyeGMrFIK7+ryOuZsvcU8ZpI85p/9eBdQal2lBoXI1DlcGZORtSh8rGvKVPsSgLcYS
         9CEg==
X-Gm-Message-State: AOAM530y+aWLwRUaB/G7j6q7XYzjpo+5hRJ+tqc+JTslU7R9d5/FS1JU
        7fBtZSrXHV0uxNC5enEOAW2ehMgWs1PO+A==
X-Google-Smtp-Source: ABdhPJz9AKxQT+ESOe9AWQd2dNjg45gbmxQYjje2reRPxuyJsjWodpyGJ8DUH3yRYUH/qQ7dqgvV0w==
X-Received: by 2002:a63:7f10:: with SMTP id a16mr16550840pgd.416.1612178989086;
        Mon, 01 Feb 2021 03:29:49 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id a20sm17567926pfo.104.2021.02.01.03.29.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2021 03:29:48 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mailmap: Fix name/email for Viresh Kumar
Date:   Mon,  1 Feb 2021 16:59:42 +0530
Message-Id: <d6b80b210d7fe0ddc1d4d0b22eff9708c72ef8b3.1612178938.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some of the patches the email id was misspelled to linaro.com
instead of linaro.org and for others Viresh Kumar was written as "viresh
kumar" (all small). Fix both with help of mailmap entries.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index cc4e91d3075e..d6580d267a1b 100644
--- a/.mailmap
+++ b/.mailmap
@@ -334,6 +334,8 @@ Vinod Koul <vkoul@kernel.org> <vkoul@infradead.org>
 Viresh Kumar <vireshk@kernel.org> <viresh.kumar2@arm.com>
 Viresh Kumar <vireshk@kernel.org> <viresh.kumar@st.com>
 Viresh Kumar <vireshk@kernel.org> <viresh.linux@gmail.com>
+Viresh Kumar <viresh.kumar@linaro.org> <viresh.kumar@linaro.org>
+Viresh Kumar <viresh.kumar@linaro.org> <viresh.kumar@linaro.com>
 Vivien Didelot <vivien.didelot@gmail.com> <vivien.didelot@savoirfairelinux.com>
 Vlad Dogaru <ddvlad@gmail.com> <vlad.dogaru@intel.com>
 Vladimir Davydov <vdavydov.dev@gmail.com> <vdavydov@parallels.com>
-- 
2.25.0.rc1.19.g042ed3e048af

