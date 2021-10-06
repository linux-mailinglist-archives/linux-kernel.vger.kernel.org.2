Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F411642402F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 16:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238765AbhJFOhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 10:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbhJFOhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 10:37:02 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B7FC061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 07:35:10 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r7so9451295wrc.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 07:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KPOp+gHRFHEckyZ/prCkdAsp9ixLDQ5xQ4Qz3H0Eoig=;
        b=gTur4BdQsCq/4uXE/8sk9li+8MxASFMtUy27itgU8I6jM4nJYFksJX1LS0+AsF7AF3
         O7FSGD5jNVbmIm4TWjxyDgD/akAW9slMtXAxOZ9jcvJ/QhAbzCw3bspah3Z3P6ifNRRg
         zNqsJRJ3CQ/mvktpPBE7uqIWc5Anhc4wdv/yn1WoOZN74R4Hx2IyHBH8tAGvNLv/I2lk
         OeAr3J4utsyA2JjI/A8ETahePWfViHkfX89VejBCXmZWBre+5zFUpfGJ6VPtDb9DngpZ
         evrNHhHqW3PyLiZ983dinUHSEHgreM6xw9C1aNdYoeNxLKS1ek4Ac8QZRh6HSK00HJgo
         tZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KPOp+gHRFHEckyZ/prCkdAsp9ixLDQ5xQ4Qz3H0Eoig=;
        b=hQx92n4shzkyC+j+UMyjzmzImZUNWmvnutxd2ubxf/UPspvoGomDhQ/cH3Si9fCu5D
         PyS68ZFcMyUIxXMbIt9pIMdBIrwn7koW4j4zwBVvTKxGb5ZIErkVoNgXTGXq59TRhqNS
         H/GQQrY+kI4DuUsBYwrrHvsmG7/vbk5soWR1A3sIacO2//M7Hj3rJOnPz+hEAhZE33bq
         siFt0i1ECUBJIa0y/IN981bV4tCdoyhd1C6zEyrj0dkbaWigwvZ8Uz81lvhfnFsd1vRH
         pgxBpUAlTldmv+b6wZIBAUEsPDihChK1rP42G5g009TDcm6fdMoVDMBHfl9W9NP3fVOj
         T3Tg==
X-Gm-Message-State: AOAM5313FPM1yRP3jUgJzJqXG/t/hzdp0zgMDAVbPiYKX/QliL230Lkj
        kq8Ln1o13QEldMecuE8MRmE=
X-Google-Smtp-Source: ABdhPJzgaK47np5RwIA4ClGOe/L6/lBmwbS5Rot0XNVTDZ8RJSfC5W/PbaQFPClom5pyOj5n/6JyMw==
X-Received: by 2002:a5d:58ec:: with SMTP id f12mr29109980wrd.24.1633530909008;
        Wed, 06 Oct 2021 07:35:09 -0700 (PDT)
Received: from localhost.localdomain ([197.49.35.129])
        by smtp.gmail.com with ESMTPSA id j6sm7574969wrh.76.2021.10.06.07.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 07:35:08 -0700 (PDT)
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
To:     sohaib.amhmd@gmail.com
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bean Huo <beanhuo@micron.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Can Guo <cang@codeaurora.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <avri.altman@wdc.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: Fix typo in sysfs-driver-ufs
Date:   Wed,  6 Oct 2021 16:35:05 +0200
Message-Id: <20211006143506.129409-1-sohaib.amhmd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove repeated world: "the The amount"

Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
---
 Documentation/ABI/testing/sysfs-driver-ufs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
index 863cc4897277..57aec11a573f 100644
--- a/Documentation/ABI/testing/sysfs-driver-ufs
+++ b/Documentation/ABI/testing/sysfs-driver-ufs
@@ -983,7 +983,7 @@ Description:	This file shows the amount of data that the host plans to
 What:		/sys/class/scsi_device/*/device/dyn_cap_needed
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
-Description:	This file shows the The amount of physical memory needed
+Description:	This file shows The amount of physical memory needed
 		to be removed from the physical memory resources pool of
 		the particular logical unit. The full information about
 		the attribute could be found at UFS specifications 2.1.
-- 
2.25.1

