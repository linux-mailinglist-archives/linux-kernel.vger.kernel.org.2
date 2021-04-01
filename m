Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37137351E71
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240867AbhDASlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:41:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:45702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236989AbhDASSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:18:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADE11610EA;
        Thu,  1 Apr 2021 12:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617279475;
        bh=qY7yRKYLQQw52+8ORVZxJA0MGftwIHF+RJBN/4jSMug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OL4+Uqgk4JLZ9lraI4paAFEjvIPwpUE674NFtIdQe/Y7xUy02uuwAwi9PTQLYff3Y
         I0uqFpCF1Y4LvxjEXu9ANq068QvYlNcHR/1GSRckkWmVGKjjFSciZtVUT39rKD66zg
         7WKw/uWEhDBIvOx9z/yytqVyT9gD2X8NIOn8jAOw6VektuMakgwfc7199Bj9O7Xndl
         pZB2Oq5zJyvkj+K5cjBoJbV/OxMVwJLFwxZYmpg+VqcI9k0Afoy81G7eWSrM67IWmb
         mj4qEn8mTuaDnDXrYZF6Edvlmr/W30rNoPGsPZfCiEuYrz2UTNu8FClrWwnjCntCgk
         3F+XILpVBkw8w==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lRwGn-001c2Y-Ms; Thu, 01 Apr 2021 14:17:53 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 06/32] MAINTAINERS: update dpot-dac.yaml reference
Date:   Thu,  1 Apr 2021 14:17:26 +0200
Message-Id: <efda999adce3332dc1b5c20a998f3824c1cc1b0f.1617279355.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617279355.git.mchehab+huawei@kernel.org>
References: <cover.1617279355.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 06d2ff6fe11e ("dt-bindings:iio:dac:dpot-dac: yaml conversion.")
renamed: Documentation/devicetree/bindings/iio/dac/dpot-dac.txt
to: Documentation/devicetree/bindings/iio/dac/dpot-dac.yaml.

Update its cross-reference accordingly.

Fixes: 06d2ff6fe11e ("dt-bindings:iio:dac:dpot-dac: yaml conversion.")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1985d75d59c7..52ce258fab37 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8753,7 +8753,7 @@ M:	Peter Rosin <peda@axentia.se>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-iio-dac-dpot-dac
-F:	Documentation/devicetree/bindings/iio/dac/dpot-dac.txt
+F:	Documentation/devicetree/bindings/iio/dac/dpot-dac.yaml
 F:	drivers/iio/dac/dpot-dac.c
 
 IIO ENVELOPE DETECTOR
-- 
2.30.2

