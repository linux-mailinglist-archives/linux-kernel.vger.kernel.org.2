Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE89440C79
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 03:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbhJaCKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 22:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbhJaCJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 22:09:59 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9051C061746
        for <linux-kernel@vger.kernel.org>; Sat, 30 Oct 2021 19:07:28 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id t7so13780787pgl.9
        for <linux-kernel@vger.kernel.org>; Sat, 30 Oct 2021 19:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=FZws8a0NnRSfwKNA4DrXN6xO9IuC3RkTXLzHBaK74pk=;
        b=eDNKkWqtGF0RWMlK58QTj864wOzXAzCXSKL9KtcgTbTd2gMCLI98kC8pPmwD7DFf4/
         12qDdcW8DLjQfaztzlMBd5DRJMtX0YQi/zHDaIQDbDe0W+0dcxEUoF//deFOVdJiulgV
         iGIYyE7GmyEO0u9tHxUP62iczBXLTFdXdQyv3H3FClkFZpvF/8wRXlQpO5Avn0a+ka63
         ajIE6i2e5fhS40igGpxanW//H+xW5ypoLCqdzPzMtjVP3kKCw0XQS2fr6OohH1G7LIh4
         thv1nwuc0Lci5Suv97vvmPAo+fFm1M+q02nz48v49YwwFVqfRZ+L8WKpqxFAJQFyZQnJ
         YeaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FZws8a0NnRSfwKNA4DrXN6xO9IuC3RkTXLzHBaK74pk=;
        b=cvj7qAyDUTiwb/rx8ILV0RKbqYL85iQPcjafRlyBWsCaT7lbMeuKYdHrX4fjPfU2BU
         nLjDeLyKjG0aBLivY4XFQDMYA79695lXxbYjYVGQG8NkvOCZgwwjcw/kWymnYzRC7x8/
         ypq75PGMv6Lwop3zwoE/A3DEzjFXa4NYDUOclvUjvqiGzAuuHtTdM2rJf5aUTsjExSZs
         KqyuocYxuovyYkVQcnZ1zI4XiWiigHaONJyNQkEJnmvuU/RjnEqJBH0MzOO4yJatukZX
         BLSfunR5OxKY4dqpiNDI8thWxa9PgMyvfQWJiCzfktWCpXIu8hfHPpsWvRv+8rux5kpF
         19uA==
X-Gm-Message-State: AOAM531nIkMw3brBmyf4KEx5qVrTQ8kikhaj/Olkz8bJZ/88IHDDI0+1
        wJUwgBjRmo3j8QJB++rBnR9aZQ==
X-Google-Smtp-Source: ABdhPJxZRsL6oy18FF58BzLeRINGjp4Deyiv1s1R/0ulZXTTdGGk268zD341ubKIUG9CWFVgkQWqtw==
X-Received: by 2002:a65:6a54:: with SMTP id o20mr62852pgu.227.1635646048199;
        Sat, 30 Oct 2021 19:07:28 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id p9sm10748986pfn.7.2021.10.30.19.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 19:07:27 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 0/3] A few smd-rpm clock driver cleanups
Date:   Sun, 31 Oct 2021 10:07:12 +0800
Message-Id: <20211031020715.21636-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a few smd-rpm clock driver cleanups found in the code
inspection.

Shawn Guo (3):
  clk: qcom: smd-rpm: Drop MFD qcom-rpm reference
  clk: qcom: smd-rpm: Drop the use of struct rpm_cc
  clk: qcom: smd-rpm: Drop binary value handling for buffered clock

 drivers/clk/qcom/clk-smd-rpm.c | 31 ++++---------------------------
 1 file changed, 4 insertions(+), 27 deletions(-)

-- 
2.17.1

