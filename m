Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C0D3413CD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 04:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbhCSDsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 23:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbhCSDsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 23:48:17 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6286C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 20:48:16 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id l13so5799866qtu.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 20:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=B2RnqxUzVjAaF9SlFdp/h+e1t2F2emkuMz4kNyNbvto=;
        b=UAXzEV/Jy55ieTkPbGz6esq+7fFMXhejFTLq7AsyGdltaCDoP1xDBqUEvv1LDRcFNx
         AVBqLpW12gG3yHULkCjc5YJumvfA0d6XyZf0uKGs1S1295nckcInjsSnngkbhjaMj0TR
         +OdOQGqpPXZIOleAV0OSpd3Ouegh5NS5JTX/N9jsg37PY7wMXmsXv5xMit2ahswBUoEG
         afeTDAGSTWMSi8YBCati8NKvccfdb/wRW92QlNjJqJiFxJp9tZ247ermn64ZcneUejB0
         JFwaAxs1rWjOrgquexYgW3fYcr0Bjhl6yX+Q1fOZB1ndsPFS4JDd4phEMm1bKz1+k6iL
         KTrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B2RnqxUzVjAaF9SlFdp/h+e1t2F2emkuMz4kNyNbvto=;
        b=HdsmnFuTcYxb4N2MfITITyOgtrPCHg2ktQK4/EORpN9aEsz6TONzAWXhz95HCYbCML
         ElRNuOIxvJIusxPUW4SNbC0GqI9sa6fokpkzVnbuRnodhEmDn4CKM7kQFhkg6l5Q1tgM
         EzpFyLHBiQ1VPr83VzbuJ8pDZHX8nQB+v12ipBF+YcSPGBRiXK/ZfscGXy3KWQ4NgEIM
         PoG8SwS9hn903LpUmYFwmPDtnxnnwtMdyTejylb/ahlJBQqbMq2nPuUqINPj1nvQucC7
         LMH9ymSwcOrzjN3dxMqt8+Xzcm4dxk7B0Las72pw+UHqNIrUeG8c0FAW/TjNpB7l0ydJ
         E0mw==
X-Gm-Message-State: AOAM530UDR0E/Pz7LEApMZDrtzMfCXYR1qfj8lFFZCseWwRP31TpYZew
        fBslSUdIRxKnAOG004NBoWk=
X-Google-Smtp-Source: ABdhPJyroRNe9z6dDiAJCj1NfHjWUog+MKuMOilqeByW7LQEieZ1I23kdq206M8Xj50FgoVoXP5mKA==
X-Received: by 2002:ac8:702:: with SMTP id g2mr6738584qth.215.1616125695747;
        Thu, 18 Mar 2021 20:48:15 -0700 (PDT)
Received: from tong-desktop.local ([2601:5c0:c200:27c6:ed59:df3e:7ad8:c600])
        by smtp.googlemail.com with ESMTPSA id j1sm2974265qti.55.2021.03.18.20.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 20:48:15 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Tong Zhang <ztong0001@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: comedi: das800: fix request_irq() warn
Date:   Thu, 18 Mar 2021 23:47:52 -0400
Message-Id: <20210319034753.435811-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <8c65b02e-4315-153f-de2c-153862f195be@mev.co.uk>
References: <8c65b02e-4315-153f-de2c-153862f195be@mev.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

request_irq() won't accept a name which contains slash so we need to
replace it with something else -- otherwise it will throw a warning
and the entry in /proc/irq/ will not be created.
Since the .name might be used by userspace and we don't want to break
userspace, so we are changing the parameters passed to request_irq()

Suggested-by: Ian Abbott <abbotti@mev.co.uk>
Signed-off-by: Tong Zhang <ztong0001@gmail.com>
Reviewed-by: Ian Abbott <abbotti@mev.co.uk>
---
v2: fix commit log

 drivers/staging/comedi/drivers/das800.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/comedi/drivers/das800.c b/drivers/staging/comedi/drivers/das800.c
index 2881808d6606..bc08324f422f 100644
--- a/drivers/staging/comedi/drivers/das800.c
+++ b/drivers/staging/comedi/drivers/das800.c
@@ -668,7 +668,7 @@ static int das800_attach(struct comedi_device *dev, struct comedi_devconfig *it)
 	dev->board_name = board->name;
 
 	if (irq > 1 && irq <= 7) {
-		ret = request_irq(irq, das800_interrupt, 0, dev->board_name,
+		ret = request_irq(irq, das800_interrupt, 0, "das800",
 				  dev);
 		if (ret == 0)
 			dev->irq = irq;
-- 
2.25.1

