Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09E332F143
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 18:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbhCEReM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 12:34:12 -0500
Received: from mail.micronovasrl.com ([212.103.203.10]:48380 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhCERd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 12:33:59 -0500
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id E1267B0485F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 18:33:57 +0100 (CET)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:user-agent:date:date
        :message-id:from:from:references:to:subject:subject; s=dkim; t=
        1614965636; x=1615829637; bh=eODxb9VuSlFhNpsqeLIuCjA+kSmV2Ml2tuY
        wtb7TzUg=; b=QAS/zB4c13tNsmfk3/WNdu+Q2AMBKKqTXjhQHAmoOLIItz1PoZz
        cUeq9TenABcXqccz8+Z8Ih4uy5Nd5I1QNu9/bbAHGJCFC0PPBZJ+1qtWFXsmqw9p
        hwMh5F6CNsGzTgZilIagfC9Qxtwy8kUwl9Qr80BjMJbt+HLcMQmQOkuQ=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.901
X-Spam-Level: 
X-Spam-Status: No, score=-2.901 tagged_above=-10 required=4.5
        tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, NICE_REPLY_A=-0.001]
        autolearn=unavailable autolearn_force=no
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id scMansTDIl7j for <linux-kernel@vger.kernel.org>;
        Fri,  5 Mar 2021 18:33:56 +0100 (CET)
Received: from [192.168.50.85] (146-241-168-111.dyn.eolo.it [146.241.168.111])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id 1252CB04750;
        Fri,  5 Mar 2021 18:33:55 +0100 (CET)
Subject: Re: [PATCH 1/3] dt-bindings: Add Hycon Technology vendor prefix
To:     =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.ne@posteo.net>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210305163834.70924-1-giulio.benetti@benettiengineering.com>
 <20210305163834.70924-2-giulio.benetti@benettiengineering.com>
 <YEJpogUgOHHPFUQ+@latitude>
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <f1c78d68-5e84-ab52-3de6-44a9312f2afa@micronovasrl.com>
Date:   Fri, 5 Mar 2021 18:33:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YEJpogUgOHHPFUQ+@latitude>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

Il 05/03/2021 18:25, Jonathan Neuschäfer ha scritto:
> Hello,
> 
> On Fri, Mar 05, 2021 at 05:38:32PM +0100, Giulio Benetti wrote:
>> From: Giulio Benetti <giulio.benetti@micronovasrl.com>
>>
>> Update Documentation/devicetree/bindings/vendor-prefixes.yaml to
>> include "hycon" as a vendor prefix for "Hycon Technology".
>> Company website: http://www.hycontek.com/
> 
> As far as I can see, https would be possible here.

+1

>> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
>> ---
>>   Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> index a1312637d6ff..51b00aa96dff 100644
>> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> @@ -488,6 +488,8 @@ patternProperties:
>>     "^hugsun,.*":
>>       description: Shenzhen Hugsun Technology Co. Ltd.
>>     "^hwacom,.*":
>> +    description: Hycon Technology Corp.
>> +  "^hycon,.*":
>>       description: HwaCom Systems Inc.
> 
> This is the wrong way around. You declared "hwacom," to mean "Hycon
> Technology Corp.", and "hycon," to mean "HwaCom Systems Inc.".
> 

Thank you, I've modified it and I'll send a v2 with the rest of
patchset.

Best regards
-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale € 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642
