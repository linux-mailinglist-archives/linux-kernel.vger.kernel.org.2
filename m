Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D13434158
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 00:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbhJSW2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 18:28:51 -0400
Received: from ixit.cz ([94.230.151.217]:54002 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229632AbhJSW2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 18:28:40 -0400
Received: from [192.168.1.138] (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id AD26920064;
        Wed, 20 Oct 2021 00:26:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1634682386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5jg69UQKQD2tfZXqs0E8mJ/KCQlQAP8qmUqnBxG4Qmc=;
        b=oDJMZM2oqDFrpN31K5nWQscg6a1VUzgAVbDDln45t1tsQpX4+3jO4cNelc7PqdzfMzUG3j
        7JHGAVnRzDU9vMNIfQrp6L7UYoWI/n8rUDcQbovynNtE3tN5Ex8QnhXTAaHBIKs/1lB/as
        lgRsGXHVAyppd4bcv4qIBgcBaULVj9M=
Date:   Wed, 20 Oct 2021 00:24:52 +0200
From:   David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH] WIP: dt-bindings: arm: firmware: tlm,trusted-foundations:
 Convert txt bindings to yaml
To:     Rob Herring <robh@kernel.org>
Cc:     Stephen Warren <swarren@nvidia.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~okias/devicetree@lists.sr.ht
Message-Id: <GXW81R.AUXV3AJ9VUDL@ixit.cz>
In-Reply-To: <YW86yrhJBTunU121@robh.at.kernel.org>
References: <20211009104518.45596-1-david@ixit.cz>
        <YW86yrhJBTunU121@robh.at.kernel.org>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




On Tue, Oct 19 2021 at 16:38:18 -0500, Rob Herring <robh@kernel.org> 
wrote:
> On Sat, Oct 09, 2021 at 12:45:18PM +0200, David Heidelberg wrote:
>>  Convert Trusted Foundation binding to the YAML syntax.
> 
> Looks fine. Why WIP?
> 

Can you drop the WIP prefix I forgot or should I resend?


> If version number ranges are known, you could add constraints on 
> those.

from driver:
         * we are not using version information for now since currently
         * supported SMCs are compatible with all TF releases
so I guess at least driver currently doesn't care and know any enums.

David

> 
>> 
>>  Signed-off-by: David Heidelberg <david@ixit.cz>
>>  ---
>>   .../arm/firmware/tlm,trusted-foundations.txt  | 20 --------
>>   .../arm/firmware/tlm,trusted-foundations.yaml | 46 
>> +++++++++++++++++++
>>   2 files changed, 46 insertions(+), 20 deletions(-)
>>   delete mode 100644 
>> Documentation/devicetree/bindings/arm/firmware/tlm,trusted-foundations.txt
>>   create mode 100644 
>> Documentation/devicetree/bindings/arm/firmware/tlm,trusted-foundations.yaml
>> 
>>  diff --git 
>> a/Documentation/devicetree/bindings/arm/firmware/tlm,trusted-foundations.txt 
>> b/Documentation/devicetree/bindings/arm/firmware/tlm,trusted-foundations.txt
>>  deleted file mode 100644
>>  index 780d0392a66b..000000000000
>>  --- 
>> a/Documentation/devicetree/bindings/arm/firmware/tlm,trusted-foundations.txt
>>  +++ /dev/null
>>  @@ -1,20 +0,0 @@
>>  -Trusted Foundations
>>  --------------------
>>  -
>>  -Boards that use the Trusted Foundations secure monitor can signal 
>> its
>>  -presence by declaring a node compatible with 
>> "tlm,trusted-foundations"
>>  -under the /firmware/ node
>>  -
>>  -Required properties:
>>  -- compatible: "tlm,trusted-foundations"
>>  -- tlm,version-major: major version number of Trusted Foundations 
>> firmware
>>  -- tlm,version-minor: minor version number of Trusted Foundations 
>> firmware
>>  -
>>  -Example:
>>  -	firmware {
>>  -		trusted-foundations {
>>  -			compatible = "tlm,trusted-foundations";
>>  -			tlm,version-major = <2>;
>>  -			tlm,version-minor = <8>;
>>  -		};
>>  -	};
>>  diff --git 
>> a/Documentation/devicetree/bindings/arm/firmware/tlm,trusted-foundations.yaml 
>> b/Documentation/devicetree/bindings/arm/firmware/tlm,trusted-foundations.yaml
>>  new file mode 100644
>>  index 000000000000..9d1857c0aa07
>>  --- /dev/null
>>  +++ 
>> b/Documentation/devicetree/bindings/arm/firmware/tlm,trusted-foundations.yaml
>>  @@ -0,0 +1,46 @@
>>  +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>  +%YAML 1.2
>>  +---
>>  +$id: 
>> "http://devicetree.org/schemas/arm/firmware/tlm,trusted-foundations.yaml#"
>>  +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>>  +
>>  +title: Trusted Foundations
>>  +
>>  +description: |
>>  +  Boards that use the Trusted Foundations secure monitor can 
>> signal its
>>  +  presence by declaring a node compatible under the /firmware/ node
>>  +
>>  +maintainers:
>>  +  - Stephen Warren <swarren@nvidia.com>
>>  +
>>  +properties:
>>  +  $nodename:
>>  +    const: trusted-foundations
>>  +
>>  +  compatible:
>>  +    const: tlm,trusted-foundations
>>  +
>>  +  tlm,version-major:
>>  +    $ref: /schemas/types.yaml#/definitions/uint32
>>  +    description: major version number of Trusted Foundations 
>> firmware
>>  +
>>  +  tlm,version-minor:
>>  +    $ref: /schemas/types.yaml#/definitions/uint32
>>  +    description: minor version number of Trusted Foundations 
>> firmware
>>  +
>>  +required:
>>  +  - compatible
>>  +  - tlm,version-major
>>  +  - tlm,version-minor
>>  +
>>  +additionalProperties: false
>>  +
>>  +examples:
>>  +  - |
>>  +    firmware {
>>  +      trusted-foundations {
>>  +        compatible = "tlm,trusted-foundations";
>>  +        tlm,version-major = <2>;
>>  +        tlm,version-minor = <8>;
>>  +      };
>>  +    };
>>  --
>>  2.33.0
>> 
>> 


