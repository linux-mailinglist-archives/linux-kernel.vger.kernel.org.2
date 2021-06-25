Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F173B3DEF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 09:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhFYHsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 03:48:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229949AbhFYHsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 03:48:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4DC2E61425;
        Fri, 25 Jun 2021 07:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624607172;
        bh=ZO9EAEaYw/bHyl31+q2cZi/I7oBtV4iKluYTqwM8Gfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PYnxweGDhIJdJ0zhTxfGv0A1o3o2vd4VCspTkROM0aTEBEGu1+MAuV8W5+c6XcIFr
         MKrGqToAIsuj9uCHW1OAGVY5mXM1Mkd7Ot5+3wtuSO7zIOEB2Qrv/YCRMDvfGZvM1i
         LqBy4HVTCkscm3cSDdQuaLeGRhiPfz+DbGcg+OhbO0jdaiucubN5kouUzl8cXlcKXr
         SLjzbLrUzRdXXBLOVgiks2xAl5oWOb9Ekyixcu/cfU3PhI55GqzuC0Z2VOHMthVKio
         cn22hb2hebopSVSWcutrB8OLqvZ9Y563ln8kSM756LYnvS5iFpRaEmjxjgpVL8vtNC
         2XKPo2DNB+jpg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lwgXS-004aeE-Cy; Fri, 25 Jun 2021 09:46:10 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Lee Jones" <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH v8 03/12] staging: hisilicon,hi6421-spmi-pmic.yaml: cleanup descriptions
Date:   Fri, 25 Jun 2021 09:45:55 +0200
Message-Id: <9f421e254061a42b7b598bd96b12f05460c175c9.1624606660.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1624606660.git.mchehab+huawei@kernel.org>
References: <cover.1624606660.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor cleanups at the schema:
 - There's no need to describe interrupt-controller;
 - gpios need a description.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml b/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
index d57316c57d7b..8e355cddd437 100644
--- a/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
+++ b/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
@@ -32,12 +32,11 @@ properties:
   '#interrupt-cells':
     const: 2
 
-  interrupt-controller:
-    description:
-      Identify that the PMIC is capable of behaving as an interrupt controller.
+  interrupt-controller: true
 
   gpios:
     maxItems: 1
+    description: GPIO used for IRQs
 
   regulators:
     type: object
-- 
2.31.1

