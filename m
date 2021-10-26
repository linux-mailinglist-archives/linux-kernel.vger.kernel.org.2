Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A863843B427
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236694AbhJZOcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236637AbhJZOcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:32:00 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CEDC061745;
        Tue, 26 Oct 2021 07:29:32 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id g205-20020a1c20d6000000b0032cc6bbd505so2749614wmg.5;
        Tue, 26 Oct 2021 07:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RHa+Rgak7KYfG/GiuSya4DwIwWSin95Lmp23d+Ek348=;
        b=gRQ6lVYFKlp6Z0xeJ7Hzq8kFxDXhHRAWN1qP/kdsZySvg4IxghT16L/+lNDXy9rMK4
         CE4LUg/2kUSuerAUdVkOJ93caOgdYi/PJLzD0Rx02/VJ4p1QHZuqToUaPXlW44ra7st+
         bfeqlsdYfoqUq7PkP9ybAoJp1Iw9Bi6RAGeqDVGnPHwq11bT9emw2LvuZ00qvCFQ8dkG
         Wx8gaPX7SVsb6uXY3oSqreLj9xBVx1sUB1BWBGtlE3m7fZOSFpfccVBlF9jKaZRJECuw
         EBGA8QaZXoeEJ70CflNR0I+YK9uw3UaylSfe8npxcgUrFZKYIb9I1Xt47Why+i188XG7
         Tvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RHa+Rgak7KYfG/GiuSya4DwIwWSin95Lmp23d+Ek348=;
        b=JUixoyqhPxQX74l+9hfh/STv4QnuFeMLJEqr3fzdJd/5n5neqBykmgp9n2bbWwv2Ji
         BFr+PURsP/uGC+XBBxUVX+T6OhELRO8Kohb+dO0k/RF58+msXJTSQPhfedNK+CL7Cj6U
         xOEC6amGW6rRKLBouiZ5RG+W9zhTHad4Q4EIqs63+Rb+ylIywru8rMuzGURGvvciK38Q
         LmbFitR3bbcWtge4J/+CiBxMUXOLLrhAncKHj4gpiVCqMUKwvbT2q1sRPzCm+vqzbjOB
         cF/WDBSAUo1ikv1fD+gMvNXJvQgkrpFV/BmasjOgTykL8ltJC6NKMlbeXkqKbLdQmPaN
         4xhA==
X-Gm-Message-State: AOAM530CevyWXVlQ1Jk9etfqz9SMDGYxaushPwbQTEboVSleyx0pwrpC
        2Sw/cNRZtxaHXzXoh1Dwgg4=
X-Google-Smtp-Source: ABdhPJzsqYlI5jjmeDTdd2RH7OeBlPYYybYzSTYReYGnh0Gd3mIODs2JSHDui0TosxuLT4W6SyvPsQ==
X-Received: by 2002:a05:600c:b41:: with SMTP id k1mr58259599wmr.4.1635258570950;
        Tue, 26 Oct 2021 07:29:30 -0700 (PDT)
Received: from localhost.localdomain (i5C74E3E5.versanet.de. [92.116.227.229])
        by smtp.gmail.com with ESMTPSA id f18sm18745717wrg.3.2021.10.26.07.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 07:29:30 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Yu Chen <chenyu56@huawei.com>, Sam Ravnborg <sam@ravnborg.org>,
        Edmund Dea <edmund.j.dea@intel.com>,
        kernel-janitors@vger.kernel.org, Joe Perches <joe@perches.com>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v5 4/4] MAINTAINERS: rectify entry for ALLWINNER HARDWARE SPINLOCK SUPPORT
Date:   Tue, 26 Oct 2021 16:19:02 +0200
Message-Id: <20211026141902.4865-5-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211026141902.4865-1-lukas.bulwahn@gmail.com>
References: <20211026141902.4865-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f9e784dcb63f ("dt-bindings: hwlock: add sun6i_hwspinlock") adds
Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml,
but the related commit 3c881e05c814 ("hwspinlock: add sun6i hardware
spinlock support") adds a file reference to allwinner,sun6i-hwspinlock.yaml
instead.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:

  warning: no file matches  F:  Documentation/devicetree/bindings/hwlock/allwinner,sun6i-hwspinlock.yaml

Rectify this file reference in ALLWINNER HARDWARE SPINLOCK SUPPORT.

Reviewed-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 88cc726c36c0..aa88e9a0a747 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -761,7 +761,7 @@ F:	drivers/crypto/allwinner/
 ALLWINNER HARDWARE SPINLOCK SUPPORT
 M:	Wilken Gottwalt <wilken.gottwalt@posteo.net>
 S:	Maintained
-F:	Documentation/devicetree/bindings/hwlock/allwinner,sun6i-hwspinlock.yaml
+F:	Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml
 F:	drivers/hwspinlock/sun6i_hwspinlock.c
 
 ALLWINNER THERMAL DRIVER
-- 
2.26.2

