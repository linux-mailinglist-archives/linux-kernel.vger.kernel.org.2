Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E1541ABEA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 11:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240004AbhI1Jck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 05:32:40 -0400
Received: from thorn.bewilderbeest.net ([71.19.156.171]:50585 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239831AbhI1JcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 05:32:22 -0400
Received: from hatter.bewilderbeest.net (71-212-29-146.tukw.qwest.net [71.212.29.146])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 41FDA293;
        Tue, 28 Sep 2021 02:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1632821027;
        bh=97KklhLeQh76YRY1Elsbf7cYcTo9pXXl9b7LWGG1VS4=;
        h=From:To:Cc:Subject:Date:From;
        b=g7IOBn658cEz3nJKuSFKelzRTGj5KyBz0QVD6IXVFO2KUJR9QTtkpTdyT6Rp8ZRfP
         vLrDpbi19J7Pgi7/Bw6ej6VsdYfNtlci/9IZMn8ox9HmwRtEToRzjUrQGlFWd1Dq4/
         eYgW8rlW8o6IqhuWVKQOGTP49VINHTKGxHYLu7BA=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Zev Weiss <zev@bewilderbeest.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 0/8] hwmon: (pmbus/lm25066) Configurable sense resistor, other cleanups
Date:   Tue, 28 Sep 2021 02:22:34 -0700
Message-Id: <20210928092242.30036-1-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm working with a board that uses LM25066s with sense resistor values
significantly different than the 1mOhm assumed by the coefficients
provided in the datasheet; the power and current readings produced by
the existing driver are thus fairly inaccurate.

This patch series started out as merely adding support for a
shunt-resistor-micro-ohms DT property as found in the adm1275 driver,
but along the way I noticed a number of other minor bits in the
lm25066 driver that looked like they could use some fixes, so I've
included those as well.

Patches 1 and 2 bring the m/b/R coefficients in line with what's in
the relevant datasheets, patches 3 through 5 are fairly generic
(minor) code cleanups, and patches 6 through 8 add the desired OF
support for the driver.


Thanks,
Zev


Zev Weiss (8):
  hwmon: (pmbus/lm25066) Add offset coefficients
  hwmon: (pmbus/lm25066) Adjust lm25066 PSC_CURRENT_IN_L mantissa
  hwmon: (pmbus/lm25066) Avoid forward declaration of lm25066_id
  hwmon: (pmbus/lm25066) Let compiler determine outer dimension of
    lm25066_coeff
  hwmon: (pmbus/lm25066) Mark lm25066_coeff array const
  hwmon: (pmbus/lm25066) Add OF device ID table
  hwmon: (pmbus/lm25066) Support configurable sense resistor values
  dt-bindings: hwmon/pmbus: Add ti,lm25066 power-management IC

 .../bindings/hwmon/pmbus/ti,lm25066.yaml      | 54 +++++++++++
 Documentation/hwmon/lm25066.rst               |  2 +
 drivers/hwmon/pmbus/lm25066.c                 | 90 +++++++++++++++----
 3 files changed, 128 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/ti,lm25066.yaml

-- 
2.33.0

