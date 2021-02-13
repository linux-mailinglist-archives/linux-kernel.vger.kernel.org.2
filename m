Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA1DB31AD2B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 17:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhBMQkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 11:40:46 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:46335 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229574AbhBMQkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 11:40:39 -0500
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id B13FF5C00CF;
        Sat, 13 Feb 2021 11:39:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Sat, 13 Feb 2021 11:39:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=drnd.me; h=from
        :to:subject:date:message-id; s=fm2; bh=KF0yUk0R8wWOyzHnpDxTychZF
        bk8rzwni4MkOsB0N9E=; b=IC86tgxWxX3egT9X2lgsELYbjadSAPnytyKiAvBHv
        x/DUWDu2bgGDJn8GSLX9UXOHXPzKL94ZBtsVlE8TpU9WowI9N/xT0QU7UCK8v5/H
        xQh62Hr4LbIpwG10ziZb9ffJhrzb+IRjjQ2lh4fbbBPGpQuBQkfgpZkG5WrFVQSk
        3q1cJiJxFPOz03o5q9qW+ni7PZiYefp0xHZPuohF0yuX/GtfcCjIVY6eDWQ41Hvp
        rAnoudKupK88r2H7Xp0HSxQqNTNB1W4O1qURAxVvVpebnWk5NLxB9qCmlZl+OV5M
        5ZG6/DQmu6HggjbsxR11vBmQh6J8N/hloroTLOLJfhTHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=date:from:message-id:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=KF0yUk0R8wWOyzHnpDxTychZFbk8rzwni4MkOsB0N9E=; b=J4tkN2CD
        EKmy+aQCNhqKMRDpYU/K5KC8OW03zzGadla6RCj/DQQ4ukQ/8n/FjcjEZmmo/PxC
        4f9ftkIVJe/X4Krg7ll/zeweVFBcEdFLlTFxUlWbLPUVzY43CLlD2Xnu8f7i0gwP
        KYgZpIgpbx8ZnRkjIGZrf+gGi/N5P6eKS3zm3kTE16Sco1lTLlxutCPfxHlUSNas
        fllx5VMs0wHIxL3U/Lt8PlsDhmjdaSD/pyJfYeQ936nAWY/6oOZ1aEhtBDGISuuS
        /s8A2DTDlH/IMhLo8YkkpT6LDx7hUdSIOs4nfkmvk58pDS4ilNecuuDOKea34Vat
        iWjNnceO2fhNRQ==
X-ME-Sender: <xms:1AAoYI9c1meygtbvSxMkrScpX0eP-FeYYAohoVI3dhFgPT9In2NieQ>
    <xme:1AAoYApkt4u5tVtolXAHyXHVytdEoJ88kTmSD9UQ18tuCM_x941cTxP51sFaqbwP8
    xXRetts6R8_7-a5zA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrieefgdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofestddtredtredttdenucfhrhhomhephghilhhlihgrmhcuffhu
    rhgrnhguuceofihilhhlodhgihhtsegurhhnugdrmhgvqeenucggtffrrghtthgvrhhnpe
    ejteduieevjeefudeuhefgvdevgeehgeehgfdtueeuteevleeuhedtueekvdegteenucfk
    phepvddujedrvdefkedrvddtkedrjeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepfihilhhlodhgihhtsegurhhnugdrmhgv
X-ME-Proxy: <xmx:1AAoYK6JU8dfZCYL4CD9gyWTix8KjJ_HZ5gz1U9o5MiBiN1h1ybCug>
    <xmx:1AAoYAPgVn7hhS58s6E6XIB4CJCYbP3m6sEcwxb8wMEBh8HRVNYI_A>
    <xmx:1AAoYMMcAwSupb8SxzhpFB3e95ur1PYdxWqQcavasVW-Nxs15a4RSA>
    <xmx:1AAoYBsS0gXwMA63l1I6dKJvoJdmOiVw_TC0TlfmC5Z4fuMBsfOeWw>
Received: from vagrant.vm (pd9eed04a.dip0.t-ipconnect.de [217.238.208.74])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8FFD9240062;
        Sat, 13 Feb 2021 11:39:47 -0500 (EST)
From:   William Durand <will+git@drnd.me>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: remove multiple blank lines
Date:   Sat, 13 Feb 2021 03:47:11 +0000
Message-Id: <20210213034711.14823-1-will+git@drnd.me>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes some blank lines in order to fix a checkpatch issue.

Signed-off-by: William Durand <will+git@drnd.me>
---
This is my very first patch.

 drivers/staging/rtl8192e/rtllib_wx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
index aa26b2fd2774..2e486ccb6432 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -341,8 +341,6 @@ int rtllib_wx_set_encode(struct rtllib_device *ieee,
 		goto done;
 	}

-
-
 	sec.enabled = 1;
 	sec.flags |= SEC_ENABLED;

--
2.17.1

