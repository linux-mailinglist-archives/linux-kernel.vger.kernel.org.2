Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A2332514D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 15:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbhBYOKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 09:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbhBYOJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 09:09:56 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9087C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 06:09:10 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id jx13so92041pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 06:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tKcivPFN2h0/UnBHfn2oaLkXaEoyZMnjPH5QcCiUS+0=;
        b=TX/HcySKKK8XnsD5gnNA9IaluRvYuYTE4k0lPmWFDtfTgaCCK4AG10jTRYIjsGHFQa
         Owf16ImiPkPRFHphQkwKE8Y9KSdBpBc24eKjAL1Cdu8YPaCjplmm5LkytDiRinEco0X9
         1qQ3wLJ1fHRQ9Q5UlooG9LMWRxIpGSxJRlsVqaNurJQ7PwjUk3ny3vNEKvoQEkUG5Gj9
         PTxVT+dKjNPOKBMwcg3nLO4HTlor3vuWcZrtdJJopym10kPSwuyXW7fAbVZiSSen5xux
         PxYW1GMHkqCnVozClhhbyF4p0awjdendxJveY0hCf5P2fyP8nPbJRYoNdJbX7JrUsF1n
         7QZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tKcivPFN2h0/UnBHfn2oaLkXaEoyZMnjPH5QcCiUS+0=;
        b=PGJAujhSnzJWnV+NGK3yVuZyUsy8s/n7MquBcJPqSuNcTaXQWi8aet3C85Dk6TMM84
         6XSY/84fyEFzYLvJmD6SYRlKwRf6p+nW42SYmHTjTiXbNRrVOdX9sGmsQZrldFOcAaax
         AHda/fZAJwn+C0ERYEicDKc7+E2I27RFaXZYlYr4jb+OwaClJrbOxKkPi/hrblch1e6N
         ekh/U7qx7l/+K+t0WrKw4NmAC/oYWSi1209yu8QsjDeWKOVPp2Lh7C+6RmLjS2QZa1K/
         eP7E95au/o5kPm2adTygs5Cvl/xdvHb6RxxClj4FCb+T4/CV1Nz0dIJS2sb2jCzIBO9z
         p7rg==
X-Gm-Message-State: AOAM530LOXQXcIHaJtwflmQcfj7/qrcKXdz8THdoqEmfsbwY54ZP5F5t
        Zqccqqb3tVlWGbjYmkIpd0W3wDxJqmiG
X-Google-Smtp-Source: ABdhPJxscaya0qL8fgFVo7mx9w6+pyaHb01XtiJTko0mYD4+CSg09xG96lMEB0GxL+lgRSoqF0yIvQ==
X-Received: by 2002:a17:90b:92:: with SMTP id bb18mr3415429pjb.40.1614262149867;
        Thu, 25 Feb 2021 06:09:09 -0800 (PST)
Received: from localhost.localdomain ([103.66.79.45])
        by smtp.gmail.com with ESMTPSA id f3sm6228918pfe.25.2021.02.25.06.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 06:08:52 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        boris.brezillon@collabora.com, Daniele.Palmas@telit.com,
        bjorn.andersson@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 0/3] Add support for secure regions in Qcom NANDc driver
Date:   Thu, 25 Feb 2021 19:38:39 +0530
Message-Id: <20210225140842.66927-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a typical end product, a vendor may choose to secure some regions in
the NAND memory which are supposed to stay intact between FW upgrades.
The access to those regions will be blocked by a secure element like
Trustzone. So the normal world software like Linux kernel should not
touch these regions (including reading).

So this series adds a property for declaring such secure regions in DT
so that the driver can skip touching them. While at it, the Qcom NANDc
DT binding is also converted to YAML format.

Thanks,
Mani

Changes in v3:

* Removed the nand prefix from DT property and moved the property parsing
  logic before nand_scan() in driver.

Changes in v2:

* Moved the secure-regions property to generic NAND binding as a NAND
  chip property and renamed it as "nand-secure-regions".

Manivannan Sadhasivam (3):
  dt-bindings: mtd: Convert Qcom NANDc binding to YAML
  dt-bindings: mtd: Add a property to declare secure regions in NAND
    chips
  mtd: rawnand: qcom: Add support for secure regions in NAND memory

 .../bindings/mtd/nand-controller.yaml         |   7 +
 .../devicetree/bindings/mtd/qcom,nandc.yaml   | 196 ++++++++++++++++++
 .../devicetree/bindings/mtd/qcom_nandc.txt    | 142 -------------
 drivers/mtd/nand/raw/qcom_nandc.c             |  72 ++++++-
 4 files changed, 266 insertions(+), 151 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mtd/qcom_nandc.txt

-- 
2.25.1

