Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B73351E20
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238907AbhDASf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:35:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238938AbhDASPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:15:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B3F4561103;
        Thu,  1 Apr 2021 12:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617279475;
        bh=vW/LERpdsUzSzE7KQ13xROwk34nGxHd7fjfMMDyTTj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YTau8xEfkCCi/3DZwU9/26rwPDdpMOQoLgOmz/tAU88KWWnH3czj84vCBJI2zkiyp
         lPmZ9j0MWLnBKctuFuYHo19uY8waPVkg0kQSwur4Dgq7MIfl2qDyh1MyEJicfsZkuK
         y3OzATY41SnQwfr9OMMQ8Fr4EqozAoiKw22uG7TsjS2N+nDf9geGabTVcQ16s7odDX
         IEZap/4HO48u2Yv1IIk2hQ4TMkPDyPQTSCF6Cc470OasB0oQrQaJsDV4gZlCZO8ghK
         bSdT6t/MjQVP9pleuYGPBsxChdGjmsuiKj0bam2i2WvXQpGcLcQdqfriNRcqiVam7x
         D5cKetAIlj5pw==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lRwGn-001c2M-Gw; Thu, 01 Apr 2021 14:17:53 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 01/32] MAINTAINERS: update adi,ad5758.yaml reference
Date:   Thu,  1 Apr 2021 14:17:21 +0200
Message-Id: <ca35b929c098163cfda9682ce791572629b763e2.1617279355.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617279355.git.mchehab+huawei@kernel.org>
References: <cover.1617279355.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 1e6536ee349b ("dt-bindings:iio:dac:adi,ad5758 yaml conversion")
renamed: Documentation/devicetree/bindings/iio/dac/ad5758.txt
to: Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml.

Update its cross-reference accordingly.

Fixes: 1e6536ee349b ("dt-bindings:iio:dac:adi,ad5758 yaml conversion")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 38d823d72e52..4c8a926ef201 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1141,7 +1141,7 @@ W:	http://ez.analog.com/community/linux-device-drivers
 F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9523
 F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
 F:	Documentation/devicetree/bindings/iio/*/adi,*
-F:	Documentation/devicetree/bindings/iio/dac/ad5758.txt
+F:	Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml
 F:	drivers/iio/*/ad*
 F:	drivers/iio/adc/ltc249*
 F:	drivers/iio/amplifiers/hmc425a.c
-- 
2.30.2

