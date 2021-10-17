Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE9E43092E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 14:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343607AbhJQNBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 09:01:30 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:46033 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242268AbhJQNB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 09:01:29 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 5DCD95C0109;
        Sun, 17 Oct 2021 08:59:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 17 Oct 2021 08:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=knU1y68hFncbUMmEzLqabx16z9
        8FUfXq7euHxu34Zfk=; b=ck+WM73arOovdlimiqQK6Q6U73xPANY4l8bU8u4mpU
        7WkO/IzofiY8/F790PtkAT8FCf0va1CKQ1M/tOFVn/te876pZbyx9GqX8/1yEntq
        +oCHHxrAcKU0EX7M6ADLCH02sT959VlxTopO25mZZ1c6hZaF1FPR4ksGtKt65QMm
        wZyW3GdcJrztWBCUbotLSt4ievmQQ6iiDeu42iLitYtPqZWg62XwdKmHvttu2Rvo
        IiekldIqGvZgfEFz396LUNw9KYdA1gRhejiCI4FKXkop9h0lDvPb5fRRq+QucZmj
        RQZcMf1A1znnHjBLug2SmEmb6GElsyAYuSf+Je7MPMTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=knU1y68hFncbUMmEz
        Lqabx16z98FUfXq7euHxu34Zfk=; b=CGGsaPCgs+DGc7wcFucl+0LR+EJliQxUe
        JljDfa+H3ZHePBlc9Cl8R++65BACuH+dWKxVrnsrcE+IxqXib1KXMYpMqj5PG39r
        oHqnTZ0FnIWkhWFI7H1055EyrCsK8A5AwJ9azYP8/d64OMJgytFJepnqCLIYF8YE
        z/39C2d7It254wSuXTYGpO3iehrO0lYEFEc9YWRnAX4fXeQjxZdYQESPMqIH842E
        ppbrJsHBhuAZbyM2tnmBc8rlEOFWRO7gkJYxjOqQ8YkxXrEEpmVOldLhMXQByqBI
        MAYR3rZ5Eodm3rXJCQSiscdyyQ4AqPk7ewfOO9OHKlxbkc1VpRVMA==
X-ME-Sender: <xms:JR5sYf3YNwGmqqP45F30p6M3y_2s1pYvJHVuw8Yi5IEqmObFvWI5jw>
    <xme:JR5sYeHN7GjUyD1hi53XT8C2OZacjxvvuOdjwMOz1ds4BSVSqlUtRLF470sgXFxPK
    P3exuiFtZ_lSKsEDBk>
X-ME-Received: <xmr:JR5sYf4mmE4OffeXMP1enmSJcIfc5ktMPewLHizTWOdOGI7wYCMCi129pMQ8u0up0bFIRIpk6q6inhhXzEF6YTDFBPlEkUbBorhMr0NapEVTByCrNPXU7c8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddukedgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcurfgv
    thgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvghrnh
    epuefgleekvddtjefffeejheevleefveekgfduudfhgefhfeegtdehveejfefffffgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnse
    hsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:JR5sYU063KTkUf_L-gUR66FzyfQvD0buCE1P2f-xebCYAJZI49OE_w>
    <xmx:JR5sYSHFZc_M8_jbx0Zfv8vModOZeTV1aIKJWnIYPO8gTo7gXM5r2g>
    <xmx:JR5sYV8xw5bz5YlAQWQdQ8gDn9CNA9avOCs-Oq6uoq3LPVA3uZk-KA>
    <xmx:JR5sYQbLtkcrivqQnqioxU9jc5pMtYVqNwOwTriF0usctRL9UJnKhQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 Oct 2021 08:59:15 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Sven Peter <sven@svenpeter.dev>, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: usb: dwc3: Document role-switch-reset-quirk
Date:   Sun, 17 Oct 2021 14:59:03 +0200
Message-Id: <20211017125904.69076-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dwc3 controller on the Apple M1 must be reset whenever a
device is unplugged from the root port and triggers a role
switch notification. Document the quirk to enable this behavior.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index 25ac2c93dc6c..9635e20cab68 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -226,6 +226,12 @@ properties:
       avoid -EPROTO errors with usbhid on some devices (Hikey 970).
     type: boolean
 
+  snps,role-switch-reset-quirk:
+    description:
+      When set, DWC3 will be reset and reinitialized whenever a role switch
+      is performed.
+    type: boolean
+
   snps,is-utmi-l1-suspend:
     description:
       True when DWC3 asserts output signal utmi_l1_suspend_n, false when
-- 
2.25.1

