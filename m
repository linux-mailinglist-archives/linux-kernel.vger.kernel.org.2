Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03100351E3D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236591AbhDASgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:36:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238919AbhDASPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:15:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B684261104;
        Thu,  1 Apr 2021 12:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617279475;
        bh=tf6mk4tDSkuuXHih9C91KDP5x2yd9YzWtjieeb+uIOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IjhGV0vnXDznyg+t9b/saMyTnVwFU8RYvADa4YtZlBAxzVvevARcAKWBR57iAHNQB
         ggC0ly8aLtlJYtjdqGUNRV50ROswN+3VQGBjMEqWjEFqBzumtrGCV3ShDjmf8D/opZ
         pQmZQMkSGqznANKoJjQqM17LjexgH9ism9kx5cbM2w52ynh/bdQSoWbIFnb6Zi0aPJ
         tyWKY2ZpvQE418g9pMOiP1Yi1BFbiZaWlI+bP2g+ckWsfA1U5PdPnXWZ86CL8DOlDD
         pL8kBeloraRVfPY4AIF1Ub1MqnVaXk0VgXrm8h3ZT3gkZXRlSVf3iVwskj3xRjP30Y
         yL5p9XUpoR1dg==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lRwGn-001c2g-R3; Thu, 01 Apr 2021 14:17:53 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 09/32] MAINTAINERS: update current-sense-shunt.yaml reference
Date:   Thu,  1 Apr 2021 14:17:29 +0200
Message-Id: <49371c37a988ffcae9188cbe4735e6eab920b2e0.1617279355.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617279355.git.mchehab+huawei@kernel.org>
References: <cover.1617279355.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset ce66e52b6c16 ("dt-bindings:iio:afe:current-sense-shunt: txt to yaml conversion.")
renamed: Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
to: Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml.

Update its cross-reference accordingly.

Fixes: ce66e52b6c16 ("dt-bindings:iio:afe:current-sense-shunt: txt to yaml conversion.")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c7168833da8f..71950316c736 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8796,7 +8796,7 @@ M:	Peter Rosin <peda@axentia.se>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.yaml
-F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
+F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml
 F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
 F:	drivers/iio/afe/iio-rescale.c
 
-- 
2.30.2

