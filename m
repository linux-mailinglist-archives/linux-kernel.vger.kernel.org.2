Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24193B0594
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 15:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbhFVNNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 09:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbhFVNMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 09:12:49 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBD8C061768
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 06:10:29 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id f16-20020a05600c1550b02901b00c1be4abso1733243wmg.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 06:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LTkyAehf8YDMFLVUk7PThGVVorkKOg4GbKlGuTWT6o8=;
        b=AK+v2MjgD4vvZAWM3SVsEeYwGJ9WR9AntYcuKmyrUeuTrJDlgT6QTLkRZbsLsE9udW
         wsHbhpmVJ+Hd1sZ343AMUtqa4C5/YtFS/R51bKgNsoGu0P2njmUxAxoAI0GfsHtoMlSb
         yCTvrOA9UbxJZYM9GAOoT/ZDdwgCLzDCso1g6XlMUJzh/yRBFJM0QYe3SyRRqdam7pEN
         KkLLmty4c8mI/XiqzOE7DVKysPy5ZOexmnkmbGnASkO13Dmjdr2TEPh1KFWV5z4uKpn4
         lDqiylRpLK/bEz5escG4DKi+hTrn/7O/PSgnJhqyb6hSgEo2i+gxJZEZNnvX1YG/nMwC
         /oMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LTkyAehf8YDMFLVUk7PThGVVorkKOg4GbKlGuTWT6o8=;
        b=CoIkiRiQ1ZjR/weu0Yj0xPFhGXUCrAUsaGpRih6igyT1d9uNpjw3DpEDZhlGh6dosS
         Q0GLjNm4j8dUHnQuCwDbhde6BKKweO6j0HxNDEDeDz08X0K7MC21OEKjiszhEPNvzXC+
         dIKo73dWljnWRJsKROh3HJWJSV0t9VCTda7TGV/GcXOM12+qApbqSs2w0GwCzs4muFsc
         jjA1t+APjT1jqE0KW0XPUYGRuekjooYitu3XLV2n1m9OgliGJgB1eJ0dq9Jb6w9E+pDr
         U7KRNoPsd2tv0HCMvLV40KYNX2bUGZV0oDfuqK9YdON+8BI+mGoilAQuEUtWik20ZVF1
         pHww==
X-Gm-Message-State: AOAM530h6Cmoc3sqs2LKYrzoDYERuYw37Ek8DPYdeSjS1eu/UgExW37x
        uXzOEBCj9BM6lhsAQ1HkYRhkXc+yfMFgbg==
X-Google-Smtp-Source: ABdhPJz7SSl1WNw82uGnS83f/NmIfznu+v4X9cIFsFGZ/Ztz/03ROqdl0+PxK4gVN3mVEjY8wMl3pA==
X-Received: by 2002:a1c:5f87:: with SMTP id t129mr4174601wmb.86.1624367428521;
        Tue, 22 Jun 2021 06:10:28 -0700 (PDT)
Received: from agape ([5.171.73.108])
        by smtp.gmail.com with ESMTPSA id x3sm2314112wmi.42.2021.06.22.06.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 06:10:28 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 17/17] staging: rtl8723bs: remove item from TODO list
Date:   Tue, 22 Jun 2021 15:10:01 +0200
Message-Id: <842b5ce0623be738d611d883433a8bf2aa895e90.1624367072.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1624367071.git.fabioaiuto83@gmail.com>
References: <cover.1624367071.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove item related to 5Ghz code deletion from
driver's TODO list.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/TODO | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/TODO b/drivers/staging/rtl8723bs/TODO
index afa620ceb2d8..3d8f5a634a10 100644
--- a/drivers/staging/rtl8723bs/TODO
+++ b/drivers/staging/rtl8723bs/TODO
@@ -1,6 +1,4 @@
 TODO:
-- find and remove remaining code valid only for 5 GHz. Most of the obvious
-  ones have been removed, but things like channel > 14 still exist.
 - find and remove any code for other chips that is left over
 - convert any remaining unusual variable types
 - find codes that can use %pM and %Nph formatting
-- 
2.20.1

