Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A947035FAA0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352932AbhDNSP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352591AbhDNSMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:12:52 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748C5C061343
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:29 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id ba6so24833451edb.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s8OST0xufbhkOg8bq/II3lYCmlLBTeSK+I0VSNE/vKQ=;
        b=fwSJ0qBGY4EpGSC6jbiXacV7NqfWFtL6GbVHhRgHLfD8LB9cfd/gbzae843uScn3h8
         642chEhytynS56Bb6W2cL6plzq6j0L+7DI5uRH/hijeGBQV1GT2wbzLnT5I1P1syV5Xx
         Kl8QiB+RkZ33Vyz1B3QXjfQOhuio5mTz65NqiLIZHckNRXas30NalIQ544p74bW+CBMb
         HR/PvKzANwxuvhJQVUVMjNSgFy05f9SDob6D228otS5KfHQJAdS4VgIM28QU90DnenTl
         pnqtI6mg9srpE8JKmCJoE85r3azWQ1QbNhv20KT3hfAu1OjK/NPm/M5bP7NhaQYPf93I
         S3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s8OST0xufbhkOg8bq/II3lYCmlLBTeSK+I0VSNE/vKQ=;
        b=kfzpp/Sy/DoSFCvh5bwaqKuJ3QlZ+7xO5WsznqlpBmjfEZ/Jfy9KTxmep72KpPZZSs
         b/SNkP+4mycl0ooHqekGb/kljZqIcf7QnNY4zqosigxu7U36tl/uXD7hHZtyr59nY6fE
         DE02p6HfPjJH6STD2BmwHpfqV5r0hz/nj3Cx1K4djR+yANEACQFPrZk7d5Zx8hTzZV6r
         8vtvnImh+ECl50FcOXWOdsxIAmGWxYdNQsiu2EGysNBFDwYCruaipUPyH1tRX+/OU/RS
         +mObYAK37E+da04FEjL3ZJIMX9VoGgq5tBRa7qpJQnZtCogUatG/4XUNCkxzKjkq0Mho
         45Dg==
X-Gm-Message-State: AOAM5333QaBsPMZFoPhD46jd4b5cXT+MbTxexuZvrCG9/EHJSEJQKRs8
        aUNkEhSOKfPoGHWJJdR/3PW/rQ==
X-Google-Smtp-Source: ABdhPJyGoJlrw9typPW7k6oNawhZAjHzYNp6uC7k4FbauiHDJw64BxkBg5ZLZnWJrtoxpYw/AHkYKQ==
X-Received: by 2002:aa7:df95:: with SMTP id b21mr182229edy.338.1618423948264;
        Wed, 14 Apr 2021 11:12:28 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:12:27 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jacob Feder <jacobsfeder@gmail.com>,
        linux-staging@lists.linux.dev
Subject: [PATCH 51/57] staging: axis-fifo: axis-fifo: Fix function naming in the documentation
Date:   Wed, 14 Apr 2021 19:11:23 +0100
Message-Id: <20210414181129.1628598-52-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414181129.1628598-1-lee.jones@linaro.org>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/staging/axis-fifo/axis-fifo.c:356: warning: expecting prototype for axis_fifo_write(). Prototype was for axis_fifo_read() instead

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jacob Feder <jacobsfeder@gmail.com>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/axis-fifo/axis-fifo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index 8eee17dc77ab9..b23eabb863d17 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -337,7 +337,7 @@ static void reset_ip_core(struct axis_fifo *fifo)
 }
 
 /**
- * axis_fifo_write() - Read a packet from AXIS-FIFO character device.
+ * axis_fifo_read() - Read a packet from AXIS-FIFO character device.
  * @f: Open file.
  * @buf: User space buffer to read to.
  * @len: User space buffer length.
-- 
2.27.0

