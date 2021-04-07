Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA6A35668A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 10:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237557AbhDGIVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 04:21:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:48620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238107AbhDGIVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 04:21:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F72B613C0;
        Wed,  7 Apr 2021 08:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617783662;
        bh=M1IihHeu6cYV55NFKblShpi5cLLJx3a+ALZu3xjjEOY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cRr4L1LZkzF7oK8pTdAaf17GURsU4bJLXiK+fA1HcC9y7LWvWgIHYYhEDuHQkztwz
         RAsy3qKkr0DoF0+24PdpYx0/mLcBshfT50fkX8IpxwYhCp0BQIptlwmlaz9DzmK/xm
         quD51FQ/MPIT/3CBUtM3NeuS7V8Qam280jh9UKwJ3bl29rebIgQEPpaiRpW7yzDYIL
         c+k2eEXh13vDBJB6pO3tdIj2XdMpHQLcv6ZB/8o9j7XXYkcw5+saHeVHv72HnSPldR
         uHyqugJBJGM9KvITyVZ3OJxgP0yiqFclnFxP5o3fHVCXhOKp/BVsXZsig4adXl884M
         DmP3S/4l4x9GA==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lU3Qq-005i2S-JD; Wed, 07 Apr 2021 10:21:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/19] dt-bindings:iio:adc: update motorola,cpcap-adc.yaml reference
Date:   Wed,  7 Apr 2021 10:20:49 +0200
Message-Id: <702d97d71929bec342b8b60e408eccb68c4ed7a0.1617783062.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617783062.git.mchehab+huawei@kernel.org>
References: <cover.1617783062.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 1ca9d1b1342d ("dt-bindings:iio:adc:motorola,cpcap-adc yaml conversion")
renamed: Documentation/devicetree/bindings/iio/adc/cpcap-adc.txt
to: Documentation/devicetree/bindings/iio/adc/motorola,cpcap-adc.yaml.

Update its cross-reference accordingly.

Fixes: 1ca9d1b1342d ("dt-bindings:iio:adc:motorola,cpcap-adc yaml conversion")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/devicetree/bindings/mfd/motorola-cpcap.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/motorola-cpcap.txt b/Documentation/devicetree/bindings/mfd/motorola-cpcap.txt
index ebdccfb600b9..b52e7a33f0f9 100644
--- a/Documentation/devicetree/bindings/mfd/motorola-cpcap.txt
+++ b/Documentation/devicetree/bindings/mfd/motorola-cpcap.txt
@@ -23,7 +23,7 @@ which are described in the following files:
 - Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
 - Documentation/devicetree/bindings/rtc/cpcap-rtc.txt
 - Documentation/devicetree/bindings/leds/leds-cpcap.txt
-- Documentation/devicetree/bindings/iio/adc/cpcap-adc.txt
+- Documentation/devicetree/bindings/iio/adc/motorola,cpcap-adc.yaml
 
 The only exception is the audio codec. Instead of a compatible value its
 node must be named "audio-codec".
-- 
2.30.2

