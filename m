Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B52133194F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 22:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhCHVVC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 8 Mar 2021 16:21:02 -0500
Received: from aposti.net ([89.234.176.197]:42810 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229650AbhCHVU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 16:20:56 -0500
Date:   Mon, 08 Mar 2021 21:20:29 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/3] dt-bindings/timer: ingenic: Add compatible strings
 for JZ4760(B)
To:     Rob Herring <robh@kernel.org>
Cc:     od@zcrc.me, Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Message-Id: <5Y5OPQ.S54VI8HHK9HS2@crapouillou.net>
In-Reply-To: <20210308173932.GA2679461@robh.at.kernel.org>
References: <20210307171553.72591-1-paul@crapouillou.net>
        <20210308173932.GA2679461@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le lun. 8 mars 2021 à 10:39, Rob Herring <robh@kernel.org> a écrit :
> On Sun, 07 Mar 2021 17:15:51 +0000, Paul Cercueil wrote:
>>  Add compatible strings to support the system timer, clocksource, 
>> OST,
>>  watchdog and PWM blocks of the JZ4760 and JZ4760B SoCs.
>> 
>>  Newer SoCs which behave like the JZ4760 or JZ4760B now see their
>>  compatible string require a fallback compatible string that 
>> corresponds
>>  to one of these two SoCs.
>> 
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>   .../bindings/timer/ingenic,tcu.yaml           | 28 
>> ++++++++++++++-----
>>   1 file changed, 21 insertions(+), 7 deletions(-)
>> 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/timer/ingenic,tcu.yaml:62:13: 
> [warning] wrong indentation: expected 14 but found 12 (indentation)
> ./Documentation/devicetree/bindings/timer/ingenic,tcu.yaml:201:17: 
> [warning] wrong indentation: expected 18 but found 16 (indentation)
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/ingenic,tcu.example.dt.yaml: 
> timer@10002000: timer@e0:compatible: 'oneOf' conditional failed, one 
> must be fixed:
> 	['ingenic,jz4770-ost'] is too short
> 	'ingenic,jz4770-ost' is not one of ['ingenic,jz4725b-ost', 
> 'ingenic,jz4760b-ost']
> 	'ingenic,jz4760-ost' was expected
> 	From schema: 
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml

Totally my fault, looks like I didn't check the bindings before sending 
the patchset. I'll V2.

-Paul

> See https://patchwork.ozlabs.org/patch/1448709
> 
> This check can fail if there are any dependencies. The base for a 
> patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up 
> to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.


