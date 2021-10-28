Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A6A43DBDF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 09:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhJ1HYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 03:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhJ1HYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 03:24:34 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC0FC061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 00:22:07 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id v1-20020a17090a088100b001a21156830bso7264804pjc.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 00:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1WkBYivlRpU/qv9aW7KPkwhapF6qXC4a16HmR784fCA=;
        b=AWIhfCHEiV1WfK4W2cNYSMls5iouLn9g8oLeTw8eu/sWdAgKDwJ486k4QxjJT6OOSD
         eJzkto0I1awYRO4WyZT0CkIS/l0ykF4tZzZqLI/G6C7UuEExxqoD7kPeg3kQeACiBnVW
         NJ50/5+EPNwsOhQaK64v2CAQl/43BiIDB67V0xpncV1yRZLhqCgNgwpp54ICFO6cH800
         OgIeNJszGdo7n9/fqXro2FCiIBsxySHqu6nDE+/wnYvQCQuYnzvJdAGPML93r420YnX2
         gbbEukPILygrZxBlUO9SlOVPnwWYbC2IFv3gkKwCyqmXDBh6CldMW19B6kcXnWMRrmnu
         4rWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1WkBYivlRpU/qv9aW7KPkwhapF6qXC4a16HmR784fCA=;
        b=q4CwqSSgRlS6ORc/WgaM6GnBnhLiOtmBuBy+IvckMB4/DRh80z8C6RP9XIJowI99Fh
         0fNH8fsL/2kBw/KpKqcKxG4jKLNvuvitVWRl65NrGMa9dCeHfLdo64CiK/NE71yzfWKm
         H8k6pX9HFFuGx8p07yKFhSO4PZQW5GkBTMccgfdji8aPo8Bnuqo17yBKcvxL/eExFP9o
         UCTDaCSO/xDlIQjWk2SkwJ28PKWSb4XkD10uF7Zf8uIvI7Y4C4Gj+drTkM6Wt/QpJFLg
         pctsT0Wo0Tzr9R9I9dZ/TyUnzpUxuQq9o2Bpx/+IVTdeTmcKOXcGcDDW2I3lpmCx6OeL
         boLw==
X-Gm-Message-State: AOAM533yR4yKuOMxAiFoOnJaKGHrNN1cTeC1YfASBGXH37g1F7ixdiBG
        y5B0d6N1yfRWYq4pWHygyOzse04pV4Y=
X-Google-Smtp-Source: ABdhPJyJg0rhPxTJz8pNWp5G52cfc65351rHzPbnJ6+v1ZB3qqOoZGZjjPhbwSOHqdeBi1JQy6YG6w==
X-Received: by 2002:a17:90b:3908:: with SMTP id ob8mr4955762pjb.78.1635405727150;
        Thu, 28 Oct 2021 00:22:07 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id ob5sm6979299pjb.2.2021.10.28.00.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 00:22:06 -0700 (PDT)
From:   luo penghao <cgel.zte@gmail.com>
X-Google-Original-From: luo penghao <luo.penghao@zte.com.cn>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, luo penghao <luo.penghao@zte.com.cn>
Subject: [PATCH linux-next] include/linux/zstd.h: Fix spelling errors in comments
Date:   Thu, 28 Oct 2021 07:22:02 +0000
Message-Id: <20211028072202.12532-1-luo.penghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It’s just a small problem. Although it doesn’t affect reading,
it seems that it should be revised.

Reported-by: luo penghao <luo.penghao@zte.com.cn>
Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
---
 include/linux/zstd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/zstd.h b/include/linux/zstd.h
index e87f78c..a093e18 100644
--- a/include/linux/zstd.h
+++ b/include/linux/zstd.h
@@ -90,7 +90,7 @@ size_t ZSTD_compressBound(size_t srcSize);
  * ZSTD_isError() - tells if a size_t function result is an error code
  * @code:  The function result to check for error.
  *
- * Return: Non-zero iff the code is an error.
+ * Return: Non-zero if the code is an error.
  */
 static __attribute__((unused)) unsigned int ZSTD_isError(size_t code)
 {
-- 
2.15.2


