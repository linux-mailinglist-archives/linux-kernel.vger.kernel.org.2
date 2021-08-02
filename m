Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3677B3DDAE4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 16:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbhHBOXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 10:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235398AbhHBOX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 10:23:28 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB79C05177E
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 07:14:12 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id cf5so13145018edb.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 07:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1pBlyQkB8jDj+kHSLqZwSFrA1UHmCtAGPqJJQMibeRE=;
        b=kTtcJk37j1vKTstkvnb9Q9LO2eY4SJ1nYwIJId5or0JtSKuOKVw4MRS8OJM5HQjbNL
         DZ9jsI/t29CgFpE77ZPJMlJcQitVaMPYP6hKTRFCMB9eQUhD7k9F1wwjBHYtTRIJPEvP
         OUrxtNbLNhiOR8YQ+lF45WknjLkIjfsYWFK7pGKuWp6LS4/h+o8kbDA1ro1+FeOIo7ra
         fVE0fTzUJgC3wUJ5mMYjufllC2yv5c/87IQ+s6ZK+DbXpa3tdMa+JYYmvHV9Pcj+Mu3m
         eValmNBUHorlxIqzxytaKfkgBdXzO4Hwt+65aPrNiNR8JxyqkAGp9Y5K96UoqNF98CVk
         32ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1pBlyQkB8jDj+kHSLqZwSFrA1UHmCtAGPqJJQMibeRE=;
        b=HB69JfwllxX+e20gfuMLgPZUI1I/HkPvo1Yrr7vICdtOYgM17pjoR2n8fmfouJPQLM
         0KyfEHdj2N4GZqWzjZ8EqdhgL9DgvW7m73QdvzR9xs6W7I48yMzL0Pw/G7pFcXFlr81I
         t+m37apdjFhuL0LzD+hsIDq+6Ls2R/QBL6sJ6J6JmWxIy/v/p99bBqVHIMv0fmsOaT+m
         9YE7j8iXG77kqvWVLlmLeN6ueidlWg7Uv1+TzZMBuWSbW1jwHNAGlMthnIueMZbBYQW3
         w8vLb0rvCVySZiSFRm/VSRXNQsyNpquGlFSaFG9EdqKGCS6yyNrBEBTKyuY66sOZx2Bl
         89pA==
X-Gm-Message-State: AOAM530tXc7YqOHdZt580kYWGoEyyLHqNow5NTZe8AtI/DwRM3zZ2FsF
        OAldyjhkpDPgqH6+RSMbUOvwKh9ISOjuUHfV
X-Google-Smtp-Source: ABdhPJzZDW7bsIJonPJM/RWpGsJ5/vFWJAn83JVvwtZKZv4zG8eq+2qIqHjNxwCjZWRA0ZoCnF5MEw==
X-Received: by 2002:a05:6402:160c:: with SMTP id f12mr19594868edv.122.1627913651577;
        Mon, 02 Aug 2021 07:14:11 -0700 (PDT)
Received: from localhost.localdomain ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id o3sm6084403edt.61.2021.08.02.07.14.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Aug 2021 07:14:11 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        davidezini2@gmail.com, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX 0/1] block, bfq: fix a bug causing a memory leak
Date:   Mon,  2 Aug 2021 16:13:51 +0200
Message-Id: <20210802141352.74353-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,
this patch fixes a bug that should not be super critical, in that it
should not cause any crash, but only occasional memory leaks.

Thanks,
Paolo

Paolo Valente (1):
  block, bfq: honor already-setup queue merges

 block/bfq-iosched.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

--
2.20.1
