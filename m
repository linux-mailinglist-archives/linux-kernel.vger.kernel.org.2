Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0DFB351E63
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239523AbhDASkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:40:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:45712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239655AbhDASQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:16:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 34ADE61176;
        Thu,  1 Apr 2021 12:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617279476;
        bh=XU02mroyMGGRNt0K9S9cUjAETj+4JkpRRKM6C2MXloE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=msm/hvskl/qCOHX/HeMNMQpM5NYbN0yo4i6lLjJBb306VxfT+sin5JGVIg/KZo9gY
         Np0J6aXwNwqW5pyGAietwEHHwAYsij0TAY41HGEbpuHU9rRVToDbtuP3h3cqFcZoa+
         sAfvurhoyPgWnsV5PYenzyS56iJIzSZEtmPIFdjBbNv4/tkPsy5/7nIKfLqQDDSTWp
         bOzv/NstJVFlrhTdNHbHhE/mJ/GknTlmwkd+tPwZritHVA1/yCB7Yuo/Rki9CP0eTt
         OhBZXAl8lj4NdceWabZme2JpP8U9oUoVskuCeDngBJj6Niu5vmcJdDuIKSp/1LnIdz
         BA6YZq6WXEnMA==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lRwGo-001c39-6J; Thu, 01 Apr 2021 14:17:54 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 19/32] MAINTAINERS: update st,vl53l0x.yaml reference
Date:   Thu,  1 Apr 2021 14:17:39 +0200
Message-Id: <c315ff7435bb4382b9c729a6242d098befb7796d.1617279355.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617279355.git.mchehab+huawei@kernel.org>
References: <cover.1617279355.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset b4be8bd1c6a2 ("dt-bindings:iio:proximity:st,vl53l0x yaml conversion")
renamed: Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
to: Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml.

Update its cross-reference accordingly.

Fixes: b4be8bd1c6a2 ("dt-bindings:iio:proximity:st,vl53l0x yaml conversion")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 54c469933f66..d6708b3fdbd9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17171,7 +17171,7 @@ ST VL53L0X ToF RANGER(I2C) IIO DRIVER
 M:	Song Qiang <songqiang1304521@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
+F:	Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml
 F:	drivers/iio/proximity/vl53l0x-i2c.c
 
 STABLE BRANCH
-- 
2.30.2

