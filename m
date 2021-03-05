Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB10232F3EF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 20:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbhCETcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 14:32:42 -0500
Received: from smtpweb146.aruba.it ([62.149.158.146]:36890 "EHLO
        smtpweb146.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhCETcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 14:32:16 -0500
Received: from [192.168.126.129] ([146.241.168.111])
        by Aruba Outgoing Smtp  with ESMTPSA
        id IGBKlk06d1jmzIGBKlEDoe; Fri, 05 Mar 2021 20:32:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1614972735; bh=aWcSdCyOdN8bFj+KL9uggJlcu9J1GAlTZV/p6mAPXfQ=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=PmSPrya+P5IFvlbZR4LOvV24OWPq/aZF36OpmG4lAcx6NOznd6oBLk50DY2fnRuHa
         DkF7dyC9V1/nlfWwbuQabM+GmA26c/m91X0BvF07frSWvYXFGNqCd9sZfJ32OJYGgn
         SpUjWljcTfs7nSGK3DIptRnqrM2N5lR2WNQwNKknQPHSWgayEkd3rzykITTrAFFowV
         RbIRB2Zcu2w4Tjglr/4r1wQxvo4FBGo92YxD/78SDjRRQx9lY7rYfn2fKGWiY1VpK8
         7tWLDKVl+fvEmFp5k688X1N4DvvkwAgVude4IW4SqdbJZb17SLm5EWwNtXZSLHNEnh
         hnH2u8pI8YV4w==
Subject: Re: [PATCH 1/3] dt-bindings: Add Hycon Technology vendor prefix
To:     Giulio Benetti <giulio.benetti@micronovasrl.com>,
        =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.ne@posteo.net>
Cc:     Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <20210305163834.70924-1-giulio.benetti@benettiengineering.com>
 <20210305163834.70924-2-giulio.benetti@benettiengineering.com>
 <YEJpogUgOHHPFUQ+@latitude>
 <f1c78d68-5e84-ab52-3de6-44a9312f2afa@micronovasrl.com>
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
Message-ID: <5f2b2d8f-40a5-1a2c-2491-273c371241f5@benettiengineering.com>
Date:   Fri, 5 Mar 2021 20:32:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <f1c78d68-5e84-ab52-3de6-44a9312f2afa@micronovasrl.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfHyp0t4xqITEPZZGaawoHXLASJ1gdUXaoJP3ueZzXWcDGKJYSAog/IykCiSteU7LLc3sUKuGQOOCIJLKHBb6oiTTMMID3Jxvaov41bdnopumhqLNmJd3
 OkXo2DlCDnLAbztS7sylIwbROc3Z3fcsYukAYT4pxvo1NthwY+KmaqBKHXbYlmuZjZNIBFd4Bwmjfh3+WVD8efDLjJRbIn9sb6iX13cwgwJU/sHtOnLhNmZP
 JA01q+HcQ4N+M5LW4ApNLSaIW1ho9KTMxvGidhm0ABwklCMsP53T8oT1jmii7M72YHYz2ksW0ZMJAaDdNtg7OfyvR2b73gSu4Rmh7KvCSEY7RMZp7MAyUExm
 dgoYS/4HuLG0QlHCuAzfVQeygGMdRMExlsZP3CL8lEdg4C08XRLT0F9+CP4n3cMmEKHxBFxM
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc Dmitry

On 3/5/21 6:33 PM, Giulio Benetti wrote:
> Hi Jonathan,
> 
> Il 05/03/2021 18:25, Jonathan Neuschäfer ha scritto:
>> Hello,
>>
>> On Fri, Mar 05, 2021 at 05:38:32PM +0100, Giulio Benetti wrote:
>>> From: Giulio Benetti <giulio.benetti@micronovasrl.com>
>>>
>>> Update Documentation/devicetree/bindings/vendor-prefixes.yaml to
>>> include "hycon" as a vendor prefix for "Hycon Technology".
>>> Company website: http://www.hycontek.com/
>>
>> As far as I can see, https would be possible here.
> 
> +1
> 
>>> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
>>> ---
>>>    Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
>>> index a1312637d6ff..51b00aa96dff 100644
>>> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
>>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
>>> @@ -488,6 +488,8 @@ patternProperties:
>>>      "^hugsun,.*":
>>>        description: Shenzhen Hugsun Technology Co. Ltd.
>>>      "^hwacom,.*":
>>> +    description: Hycon Technology Corp.
>>> +  "^hycon,.*":
>>>        description: HwaCom Systems Inc.
>>
>> This is the wrong way around. You declared "hwacom," to mean "Hycon
>> Technology Corp.", and "hycon," to mean "HwaCom Systems Inc.".
>>
> 
> Thank you, I've modified it and I'll send a v2 with the rest of
> patchset.
> 
> Best regards
> 

-- 
Giulio Benetti
Benetti Engineering sas
