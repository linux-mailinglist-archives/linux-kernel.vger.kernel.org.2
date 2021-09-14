Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87EA640B23E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbhINO4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:56:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:45124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234417AbhINO4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:56:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F47161155;
        Tue, 14 Sep 2021 14:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631631328;
        bh=iLWidP+Yyr7kr4SxKTjJ8HR3fRmtgJH9oVnGI/YTrHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=un+RPhVPQi8x+UTR6k7BhDPLlbX/9SqilsJNFmN8Wowx7K75JpeDWz3K38GA00G+p
         wGHdBdqY7ldRQ17ZXvN5HuFTioZVcYDItkc0D4sW2F6P4WhB4l+jxw++Fmznm4DqGG
         2MtLWzyOY1wvM+G6UrpwBg0nCevRkEWFiAjxwn9W+TJABmHa/nytVSbtJQadatWGTN
         KPN0izKh5NW0H24/StgiOcU2jqWdj2LpdJ6P1Ck3qVMV0IvlEJemjeAxRx3ckG+qMk
         E4PGwR/ab5zn8wF8vZvPJ3Mcbvic7kboBSH+5f15cPS4Em8inYY29VTDP7fQMcceZ6
         Z5lOkEbgtIPOQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQ9qI-000L70-Oq; Tue, 14 Sep 2021 16:55:26 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/8] ABI: sysfs-devices: add /dev ABI
Date:   Tue, 14 Sep 2021 16:55:18 +0200
Message-Id: <f0c710294dfa98d1e215a027990e4e0403ce5ab0.1631630792.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631630792.git.mchehab+huawei@kernel.org>
References: <cover.1631630792.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 23681e479129 ("[PATCH] Driver core: allow struct device to have a dev_t")
added a /dev ABI for /sys/devices. Document it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/stable/sysfs-devices | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-devices b/Documentation/ABI/stable/sysfs-devices
index 42bf1eab5677..98a8ef99ac5f 100644
--- a/Documentation/ABI/stable/sysfs-devices
+++ b/Documentation/ABI/stable/sysfs-devices
@@ -23,3 +23,10 @@ Contact:	Device Tree mailing list <devicetree@vger.kernel.org>
 Description:
 		If CONFIG_OF is enabled, then this file is present. When
 		read, it returns full name of the device node.
+
+What:		/sys/devices/*/dev
+Date:		Jun 2006
+Contact:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+Description:
+		Major and minor numbers of the character device corresponding
+		to the device (in <major>:<minor> format).
-- 
2.31.1

