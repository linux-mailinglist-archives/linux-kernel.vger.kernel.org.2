Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85C2B3B8FE1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 11:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235694AbhGAJlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 05:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235296AbhGAJls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 05:41:48 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BD7C061756;
        Thu,  1 Jul 2021 02:39:18 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id m18so7359533wrv.2;
        Thu, 01 Jul 2021 02:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EteEmF3Lp/VaCzgm6zJMhc5umO2ASKXQnNmmMqr1tyY=;
        b=n27K8xSc5i9k4pRnthrnVcOCeJ7Nl2hOJLEBy4pNnYc/TBewzXbVZfhTzlnkCiSZkH
         +p1Ml12cArHwaAQuucyF4Y7bsC9WQLu3qOFSN5G8liifR9f/TYUXxg8Zr9qwoW21817z
         Ljigm3UGNACmRDtyQJ+XcTFhI423ymHuXLbP7HECNQFoy7CaNNRBzmQyCvjEfpgToYyj
         okdbdH9iH20L5JXc+M0diFvNYFBft9LDb1decwb2boaSbwXKriengXBtHtyruoR7vpHQ
         dkAI1A67aUvw+wzWs7fllAZ6Zd/rVs2+9pGhOTttsJCzoF2q7idqNXde1mPxDGQ1sBJ0
         kFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EteEmF3Lp/VaCzgm6zJMhc5umO2ASKXQnNmmMqr1tyY=;
        b=IwSvdeQXicPNvWItp3sWubunMdOyOM4WXaZtUDnwE/rp2OlzA00haeNdAm+9IpQKr+
         pb7wzWTs1clYpdqA9HQpLvX4S+FoKiMClI/NOMbgzpgtjrBb9K3wooBNYhUjU5s8zqQo
         L4ys6UXr+PzYOUrCuF15GX7PYLafD1oklqIKcATagL2x8G0UpGFh6EcT3lbeIVwuT81B
         GxU63cicS4IyWYf0tQK8CuoH9zRIVAm096gUJTnIVyeWa5J2lcF1A0aXn0E7b/v6v214
         8rzhHXG3sIJfYOwUUqgerIgwFCBqeDoelXrTgd50Z6znmNNlm+4TniGNTT4DE48s7VM2
         u3Pg==
X-Gm-Message-State: AOAM531AvampGsptftqReZw5rCQcnQmYXIeZa2QZvvl6lmLNlL6L8WfB
        kP21mtCinWz1z5pFsnV/UOfKBaretYk=
X-Google-Smtp-Source: ABdhPJy1ZxB6OSrNUo8EIlwIhP2R2Oh066AMEgk+CCD2AjW50J2Uohgej+UhDxh5J4YfsYDMcgb8FA==
X-Received: by 2002:a5d:6841:: with SMTP id o1mr14964784wrw.370.1625132356515;
        Thu, 01 Jul 2021 02:39:16 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2de7:3e00:21:6759:f8f2:826e])
        by smtp.gmail.com with ESMTPSA id k6sm22370164wms.8.2021.07.01.02.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 02:39:15 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        linux-phy@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-usb@vger.kernel.org,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: repair reference in USB IP DRIVER FOR HISILICON KIRIN 970
Date:   Thu,  1 Jul 2021 11:39:03 +0200
Message-Id: <20210701093903.28733-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8de6b7edd493 ("phy: phy-hi3670-usb3: move driver from staging into
phy") moves phy-hi3670-usb3.c from ./drivers/staging/hikey9xx/ to
./drivers/phy/hisilicon/, but the new file entry in MAINTAINERS refers to
./drivers/phy/hisilicon/phy-kirin970-usb3.c.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:

  warning: no file matches  F:  drivers/phy/hisilicon/phy-kirin970-usb3.c

Repair the file entry by referring to the right location.

Fixes: 8de6b7edd493 ("phy: phy-hi3670-usb3: move driver from staging into phy")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on next-20210701

Mauro, please ack.
Greg, please pick this non-urgent minor fix on top of commit 8de6b7edd493

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 66d047dc6880..a4e0c20b416a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19153,7 +19153,7 @@ M:	Mauro Carvalho Chehab <mchehab@kernel.org>
 L:	linux-usb@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml
-F:	drivers/phy/hisilicon/phy-kirin970-usb3.c
+F:	drivers/phy/hisilicon/phy-hi3670-usb3.c
 
 USB ISP116X DRIVER
 M:	Olav Kongas <ok@artecdesign.ee>
-- 
2.17.1

