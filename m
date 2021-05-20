Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A077538ACD1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 13:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243342AbhETLt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 07:49:28 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:18700 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241471AbhETL1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 07:27:37 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1621509958; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=sy10FlllC1Fgizp2EP+bAeb7KDOxxOzQHZM+MGFKv05AaHKvYqh7rkKBbDoCPrOXmi
    NI8K7v8D4XdUplY1A97cECFxEUmjabdTIPzytDQCZkc4UKYHHwBV2oPOE4lugO2bi+15
    VRIfecmQHO5jV/lpYtdwBwuoZFqfBj+P1OCCtZZDHj/x2XDFtQoTfnlAE21aJLgIjPH7
    ICJv0i6UlNSPnnL65ClKHzvcFn1PIPZeTRD2KKILLVTRtzhr7xBQIgrrii3+DDr8Sgg9
    RSpP0SaNqDYU+JAQnXUC/cs4k39tNKcRkZuZHoMM0ODxV2ADEWrT4ctPemnCP/Owk5/J
    WTmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1621509958;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=QJ7EL3rdKbTeB2eISpfKJ6qyYsqnmKEy5taAecFN25g=;
    b=L/VTzvlJg9qBg9+D09yJ2Nj14dnCLARMZFow0Q2/JMghKWItVAIWmqvRBktSAKGf2o
    TDA/T1mGXC2huV6FFpl02NWX+aY2xLL9MqmA+kKSt2AwNDW83+tjZRMK8X15e2sJwWVG
    0zgCVHITTDPzTS73LkxjQtVr6MBllO/osSUEwDopjpPEMVQvEZAX9dG8AhjILQoh65xL
    ACb/67Ey5A4dknRFO40oVAxchNn6pbc6EfmfMzxWtJFxmdb3+liCp6FsY9YZyp8Gqkaj
    qMqHZJDIkBxJ4tkat8qn9mDR4rqwZ92NoShl+FcVwr+2MohzLkYhzCbb1MP77gFl307o
    vf6Q==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1621509958;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=QJ7EL3rdKbTeB2eISpfKJ6qyYsqnmKEy5taAecFN25g=;
    b=Ob+RciMyx+BYZ6xZ5HrnG/72nFAOfT3/8LomyCVrg8NJHbuiOm//wNdELiEvPe1Slt
    6aU+zwabVwJTrMJogewDdZmuao8zy0IXfxlHXFKrOYj/0Aa+6GHIZA7HjnPfzXAYuvs4
    QqPzWQ3cjc+0L88p7YlECI3wSsyYK/pMAhUzuf9Djw8ejQv6j65gZ7iTPO+YfVzhOx9t
    /Ji4pIgRbuRMXEoVmjtuxYVIgHAJdtGL2xDcw6pYfudUrLJPavkRCnKYNdWble8wtC7M
    +RFb36AhxYsrxUh70jEYTgEI99jcCfIGWkASHgho4HDXRqQuhHsmUczUzhyCJScRmFNG
    v1xg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB4G6FtFQ="
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.26.1 DYNA|AUTH)
    with ESMTPSA id 400bd8x4KBPv22V
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 20 May 2021 13:25:57 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 3/6] extcon: sm5502: Drop invalid register write in sm5502_reg_data
Date:   Thu, 20 May 2021 13:23:31 +0200
Message-Id: <20210520112334.129556-4-stephan@gerhold.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520112334.129556-1-stephan@gerhold.net>
References: <20210520112334.129556-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When sm5502_init_dev_type() iterates over sm5502_reg_data to
initialize the registers it is limited by ARRAY_SIZE(sm5502_reg_data).
There is no need to add another empty element to sm5502_reg_data.

Having the additional empty element in sm5502_reg_data will just
result in writing 0xff to register 0x00, which does not really
make sense.

Fixes: 914b881f9452 ("extcon: sm5502: Add support new SM5502 extcon device driver")
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/extcon/extcon-sm5502.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/extcon/extcon-sm5502.c b/drivers/extcon/extcon-sm5502.c
index 907ecd01ebb7..9f40bb9f1f81 100644
--- a/drivers/extcon/extcon-sm5502.c
+++ b/drivers/extcon/extcon-sm5502.c
@@ -88,7 +88,6 @@ static struct reg_data sm5502_reg_data[] = {
 			| SM5502_REG_INTM2_MHL_MASK,
 		.invert = true,
 	},
-	{ }
 };
 
 /* List of detectable cables */
-- 
2.31.1

