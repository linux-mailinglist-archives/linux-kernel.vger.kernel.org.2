Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD77734E519
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 12:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbhC3KIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 06:08:11 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:36013 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbhC3KH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 06:07:58 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 3726E22236;
        Tue, 30 Mar 2021 12:07:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1617098876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tiLq4LE7BnrDVBVgGUBZ/04kcMa38cE2DDY48MfDYgU=;
        b=Rma71OlPQQXc0DGu35iz2chpo6I+EegIfjfHWe5vFVJ4Qe4qGnMjrn44My6ocspogp+iIg
        jTr6N+XQXP2KLOwJbN3+OOmFUxfH+XvHlK2EVC8j/qTmKbz/UE0bDPoyX57BWR/69zysHl
        24HRXFHEeX0+MN3YfA/+ofFnZ6Li/Ko=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 30 Mar 2021 12:07:56 +0200
From:   Michael Walle <michael@walle.cc>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        =?UTF-8?Q?Rafa?= =?UTF-8?Q?=C5=82_Mi=C5=82ecki?= 
        <rafal@milecki.pl>
Subject: Re: [RFC PATCH 3/4] dt-bindings: mtd: add OTP bindings
In-Reply-To: <20210327170920.GA249312@robh.at.kernel.org>
References: <20210322181949.2805-1-michael@walle.cc>
 <20210322181949.2805-4-michael@walle.cc>
 <20210327170920.GA249312@robh.at.kernel.org>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <1c3e047fe0527abbeb73cd34219f6b49@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Am 2021-03-27 18:09, schrieb Rob Herring:
>> +    spi {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        flash@0 {
>> +            reg = <0>;
>> +            compatible = "some,flash";
> 
> Soon (in linux-next, but off by default) this will be a warning for
> undocumented compatible string. Use a real device.

Two questions:
(1) I guess this is also true for "PATCH 2/4", where you already added
     your Reviewed-by?
(2) I'd add the "jedec,spi-nor" because, that is the one I target. But
     before doing so, I'd need to add the otp subnode to the spi-nor
     schema, correct? Otherwise, the schema validation will fail. Eg.

--- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
+++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
@@ -9,6 +9,9 @@ title: SPI NOR flash ST M25Pxx (and similar) serial 
flash chips
  maintainers:
    - Rob Herring <robh@kernel.org>

+allOf:
+  - $ref: "mtd.yaml#"
+
  properties:
    compatible:
      oneOf:
@@ -82,6 +85,9 @@ patternProperties:
    '^partition@':
      type: object

+  "^otp(-[0-9]+)?$":
+    type: object
+
  additionalProperties: false

  examples:

-michael
