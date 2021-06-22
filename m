Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699F03B047B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 14:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbhFVMdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 08:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbhFVMc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:32:26 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B99C061756
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 05:30:10 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id n7so23454316wri.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 05:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LTkyAehf8YDMFLVUk7PThGVVorkKOg4GbKlGuTWT6o8=;
        b=QKlI8ZsXBVJFrOHywZXptzJCNPPJjZdG4lqBi0+7xoN+uud0LZiP0TB9105F/n45zC
         gKKP9sR2c9TdFWhMbQxX7ZkfkleW+6oex2oPW4vWxzqFW9Qh74yRQNcrF1xdh7cm13px
         QuejxrYa0ER6E4GxMH3oQM6B0BZjKce2BQUqfkFrOvIixJyT21HcVmoQ5qGAKzg5efpY
         81ogsCEGjhkfom02kt2s+BdTA2u8voxu5AR5Eyx51oARpw+iXYBPf7BdN+nJkNBt2AWk
         MRY8dbb8jdgcPEML8JmN4l/SdGMIOPD5uILOPStLDKXeE6X+th8cv5h0E4F8th838isl
         TlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LTkyAehf8YDMFLVUk7PThGVVorkKOg4GbKlGuTWT6o8=;
        b=t0TtUrQfW7+U3o41B96nps6d049gheqfa0Iu5KzizUsxXUYISnGH7pNAtN3W5ggco/
         2+2WkY1w4BNW4g5tBAGWVpFJJUmqfCZeByxwq/UnbggRm10FpBvZLcVecdnKid1ehwR6
         Kk9Mt269ygDaDLjsxqpmo8iUvSH2NyRu1YLXpz0TvJR7vD1jv2U0thB/Bh9SvUrPwRxS
         Qky8vN6gxF99jXRxwImrKEa6oug1WDc4OTSf8d5jw0lsVCbYWWevzz+XDQ1rgafu6pFW
         ++TDQO81zwol/nVLGCVtb+qF5mrpicwLx4axbwZIJhjYYASYHS6+PwdJKBZRBo68hkZI
         TxPw==
X-Gm-Message-State: AOAM533/igPA2KgzsBQbV1oZfdKincTkLXFImLlVDI/b4eNcLsMBgmlW
        5VCMe0WhL820p9ppzp4NinfCmIlELprXmg==
X-Google-Smtp-Source: ABdhPJxWaQq4bojmGXyYu1FO0nytkwnxLd8+LLrIBVCmu0EAdaMoC1ECor2WMDrbIMpy1LZSoqzTig==
X-Received: by 2002:a05:6000:1091:: with SMTP id y17mr4550478wrw.100.1624365009121;
        Tue, 22 Jun 2021 05:30:09 -0700 (PDT)
Received: from agape ([5.171.73.108])
        by smtp.gmail.com with ESMTPSA id g15sm2809238wri.75.2021.06.22.05.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 05:30:08 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 17/17] staging: rtl8723bs: remove item from TODO list
Date:   Tue, 22 Jun 2021 14:29:42 +0200
Message-Id: <f2e1df5a77543f06d6ba2fedf0b5bbcc86cd30f6.1624364582.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1624364582.git.fabioaiuto83@gmail.com>
References: <cover.1624364582.git.fabioaiuto83@gmail.com>
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

