Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E656351E38
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237923AbhDASg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:36:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238932AbhDASPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:15:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA11A610FB;
        Thu,  1 Apr 2021 12:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617279475;
        bh=itOTsA9Hc55jfhAjB7JLE43YXbSusvTI5DNzBrhqvdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=me9DSodJd3C5oZ8FKtXHoM9ictPvn/3gBxWjASdbrSaFLgtFJmaU3jvRsXGfoYZ2l
         jFdZ4dSWh/9pmYkIxRU4Cv0RLoDHYKfxkpnBNVbz2G94AAiwvBHpeo355hv6vf4RlC
         aJj4WUWsFN9H7NDq2qHP3jdFMomNUIYX8nXRA+9hSfRPEAhvX9FSbTWxo0krv4mFyL
         AVh3aaLltdlNTOXPKByKxca7LfgDiBjVBKWu9fsjFXLzxnbhVN9SUK5wX06HAw1wmu
         cVBNRxnX/Cpt2d5TkQ1dgjvq1h7pdyLFIMYkEaihXdPaByJIcF+7zsvRSbKIEX574m
         VCOzqcjz2WCnQ==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lRwGn-001c2d-PT; Thu, 01 Apr 2021 14:17:53 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 08/32] MAINTAINERS: update current-sense-amplifier.yaml reference
Date:   Thu,  1 Apr 2021 14:17:28 +0200
Message-Id: <d0008b06f8ca65108eb1e7734ec6e3e32ec28172.1617279355.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617279355.git.mchehab+huawei@kernel.org>
References: <cover.1617279355.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset fbac26b9ad21 ("dt-bindings:iio:afe:current-sense-amplifier: txt to yaml conversion.")
renamed: Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.txt
to: Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.yaml.

Update its cross-reference accordingly.

Fixes: fbac26b9ad21 ("dt-bindings:iio:afe:current-sense-amplifier: txt to yaml conversion.")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 82220a72eba2..c7168833da8f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8795,7 +8795,7 @@ IIO UNIT CONVERTER
 M:	Peter Rosin <peda@axentia.se>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.txt
+F:	Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.yaml
 F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
 F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
 F:	drivers/iio/afe/iio-rescale.c
-- 
2.30.2

