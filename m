Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58FC351E55
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbhDASjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:39:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239626AbhDASQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:16:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 011CF6113D;
        Thu,  1 Apr 2021 12:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617279476;
        bh=5h0nnE4zwlXL7ldx2Hbt9tmk5s9p58Y5ga/nkfSe48g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W/0gpkPo4MbwhyvvtTMez6bPjC5U0Rcjv//uJTGSY7y5VKFwA8nu+yKHHdfFVxZcp
         ECnfpBk6SU7P3+8qiHUpYjJN5LNVVGnJW9BmquxLFkBT3lQQDDKtv4expGZrN9qEBs
         1T7wV96fgDC0Tew1BGa3qYa7vdKCDwv9dZ4bH74c29qh512epIR2ZukqEfehW6q6he
         1Bs3nRhHHAUsI7vnAx8Iezx6wd/3BuWUibCBk5490CaOkZCSXFCTU2Rz5+70VFGRf6
         FRvKhB/NwsWZyMliRCJ8XApHd2SC/6YE8e3GTYlnZ1KwLqQpzMgTUOQ+FWjjHcebRo
         NyrwmmIN+TBPQ==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lRwGo-001c31-3D; Thu, 01 Apr 2021 14:17:54 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 16/32] MAINTAINERS: update pni,rm3100.yaml reference
Date:   Thu,  1 Apr 2021 14:17:36 +0200
Message-Id: <d9090dc18907b4c534bf12a47e47a96ed1d3b45a.1617279355.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617279355.git.mchehab+huawei@kernel.org>
References: <cover.1617279355.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset f383069be33e ("dt-bindings:iio:magnetometer:pni,rm3100: txt to yaml conversion.")
renamed: Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
to: Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.yaml.

Update its cross-reference accordingly.

Fixes: f383069be33e ("dt-bindings:iio:magnetometer:pni,rm3100: txt to yaml conversion.")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 89ed435ca6c3..636b29fd2d4b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14445,7 +14445,7 @@ PNI RM3100 IIO DRIVER
 M:	Song Qiang <songqiang1304521@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
+F:	Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.yaml
 F:	drivers/iio/magnetometer/rm3100*
 
 PNP SUPPORT
-- 
2.30.2

