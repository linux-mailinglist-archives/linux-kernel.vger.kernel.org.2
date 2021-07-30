Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83073DB68B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 11:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238359AbhG3J70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 05:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238089AbhG3J7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 05:59:24 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0C5C061765
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 02:59:19 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id b7so10568227wri.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 02:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L8Pxe8lLduahkjt47S3R5pZsRevGx6MbH7exEXrhDL8=;
        b=nP7UARZ9M3AyP+yeBpmEXBrEr47Ihy0JlhkSGI7LEOe4ol/rwgtlE9JCLG8LXBvjIq
         5yw2qt3bh7bnA6p8ciiLwQB//WBDVN9tVwzZiUaaMRZVsZ4j27Fb2BKObiobgO3yk/pP
         cMs4sRKC9kD954VX3myXew8RVwI4IBXAtkGxkMHFrLBM1uuVPvcF2h2YXtHzufvhEOUl
         ilYtSjDeToa+qpKu0J05vWsiUCMPpImg8neM0SAkerRqHEhQdrEohukOm0dcM1cY/vl2
         bo0OAaBZoW+iS3x9omNHa2vDoX24u2TLE25PPMfjGtAigvGAIFSl4hYZ45tcSIIfBOIH
         wRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L8Pxe8lLduahkjt47S3R5pZsRevGx6MbH7exEXrhDL8=;
        b=Do+Uj5FoXU6lUu2WSaT/mIBh8YOnlOA0sf5+TlOHB5iFtmOIm/hMAT/JrHD8dxMUoy
         Vk+H+FbFe4hGlK+Qn4tKeAWczkyYF69j5NIaecqlPR7lfiN8lCqVI/JAQI84lkASDc5z
         dGJt2oDS6p4Di1D6oaIIq+mziX57vxYNIgs4ZLoSuP2zZW5NVfIlTdozXtSNo7e8yUEX
         HTb8E3I2jTG9rrWYCkcKplzaqSxOgulxTUwiOvDr0O3wEu1o6CcWdUujDNyNGSO5Cqpj
         glGD16ewMoWIio159Fk3+qKZd2sEO6ehZP2fMUhtzN9HR20k40M7vLuV15dFZPpC+dWO
         xD9A==
X-Gm-Message-State: AOAM531YitvZoCftpEG7NZtHUD69ZyoZo2KOPKO++BFhGM6EdEddr7we
        dnppLaIA4d4nG/X0K34id1LZ9A==
X-Google-Smtp-Source: ABdhPJzBopbT+/Qh9WULFjmHf5wY+MNNMhpx3FM6u/zemdxXOfOxPhhDLNX2y3xCQUW73sTgvS2Zow==
X-Received: by 2002:a5d:508b:: with SMTP id a11mr2264917wrt.244.1627639157651;
        Fri, 30 Jul 2021 02:59:17 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id l7sm1090016wmj.9.2021.07.30.02.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 02:59:16 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Gilles Muller <Gilles.Muller@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: [PATCH] scripts: coccinelle: allow list_entry_is_head() to use pos
Date:   Fri, 30 Jul 2021 10:58:56 +0100
Message-Id: <20210730095856.2038286-1-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently use_after_iter.cocci generates false positives for code of the
following form:
~~~
	list_for_each_entry(d, &ddata->irq_list, node) {
		if (irq == d->irq)
			break;
	}

	if (list_entry_is_head(d, &ddata->irq_list, node))
		return IRQ_NONE;
~~~
[This specific example comes from drivers/power/supply/cpcap-battery.c]

Most list macros use list_entry_is_head() as loop exit condition meaning it
is not unsafe to reuse pos (a.k.a. d) in the code above.

Let's avoid reporting these cases.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---

Notes:
    I'm pretty much a complete beginner w.r.t. SmPL. This is written
    entirely by finding previous fixes and emulating them!
    
    However I did test it by running the checker across the current kernel
    tree. The changes reduced the error count by four... which was small
    enough for me to eyeball each one and check they match the pattern I
    was targetting.

 scripts/coccinelle/iterators/use_after_iter.cocci | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/coccinelle/iterators/use_after_iter.cocci b/scripts/coccinelle/iterators/use_after_iter.cocci
index 9be48b520879..676edd562eef 100644
--- a/scripts/coccinelle/iterators/use_after_iter.cocci
+++ b/scripts/coccinelle/iterators/use_after_iter.cocci
@@ -123,6 +123,8 @@ hlist_for_each_entry_safe(c,...) S
 |
 list_remove_head(x,c,...)
 |
+list_entry_is_head(c,...)
+|
 sizeof(<+...c...+>)
 |
  &c->member

base-commit: 2734d6c1b1a089fb593ef6a23d4b70903526fe0c
--
2.30.2

