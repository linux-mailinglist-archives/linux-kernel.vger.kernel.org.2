Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAAC4407E8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 09:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbhJ3HqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 03:46:10 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:50895 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230365AbhJ3HqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 03:46:08 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id A48135C0066;
        Sat, 30 Oct 2021 03:43:38 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute1.internal (MEProxy); Sat, 30 Oct 2021 03:43:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm2; bh=0GqRrVIIvH4jDQ5g9KLIf6Zz+I/W
        jsTHhBMDMrQcgBs=; b=qxMtK6wZBhJFHdfK/UO/MclILIrCHDCP0GZZopI/VAJG
        g6KpsAzx3ede0gQXSY5ULI7uEZCq2V/+899fySlJCFSTF6ajlzEJh1uxRGBxizwN
        EvDnAkvETTNXOoqTQXeoN/p9QjNM8QvtGQAXBwfy+B6z8cG50tnFRr01SC9JzuRf
        36VCI70HhrjemeLryi1/dkKRpG6Ju12onytYWVNOJamprOn1ntCYJqm43Z/xI7ZS
        +X7hZ8KcSNdcEIt3WC0iboEMgcAd77iEQenjdilWr+hnQX9mj4O1HmEwEidNHOhI
        G7mxtzo0gIJ5YBhYeaTvzPKXk/pCb2o7Mnj7BgU2sQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=0GqRrV
        IIvH4jDQ5g9KLIf6Zz+I/WjsTHhBMDMrQcgBs=; b=WXZS+ZtrvjQe2r+ERWlUPf
        b2EWP7ds2cGRQIqAVOajVxQVLu3tCHMRdZBA1xvS/l5uwHBtcif6tZJRarwVPHt+
        TPgJX//nXjP6njOpOnpYKraJQ5iAkEeSEcPozotzaHOBQ34Yywm/nc3gZVG8Xjf7
        38tDpICFe9HT7EXfsDnaTMyaIATVqjeWMqhPVadgy9P0VGtKUzJDzsR9L46XRtjW
        2jHuKtxu9YcJg7xjeQ/Zeh00M68YylrgE/i9hqmMoiQHgfJMcYl5+HtCG7T1grxZ
        9VzhhsMBmlLRUZLNxKecbbBjht2oHukT3uTIbfdJvCjledFD3B6mDh3T1m+dxPww
        ==
X-ME-Sender: <xms:qfd8YWcgQpGlVDsh_lXVlE80iisLI2X4AacnRriVCpnA2Il3l1xmqw>
    <xme:qfd8YQNyLrutpDVzpXlaJTP6eXhFXuwLq-Tlvn84nZj5yGRr1Gma9_5iQm2dDa8KW
    YGiGUeNhwDUPPVXfEc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdegiedguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepgfeigeeiffeuhfettdejgfetjeetfeelfefgfefgvddvtdfghfffudeh
    vdefkeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:qfd8YXiVWRkYD3V9aFhsfgZ_JYJvN16uVFPwioIbOLNxA4jGgmHrxg>
    <xmx:qfd8YT_g8WYE_VE9qwbOfL3ziyiQy20J-ffP9LjfksQmA1WwyDIAUQ>
    <xmx:qfd8YSvZzLz7Df59i077Ttdb3Ty6ae4eu2Yfa2zPuq6p-aLmyHqymA>
    <xmx:qvd8YWhtJGCbKwonjdptBPWO40FtkC-AXFA5Ky7Tu84DDWwtiSLJ4g>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A3F9E2740063; Sat, 30 Oct 2021 03:43:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1369-gd055fb5e7c-fm-20211018.002-gd055fb5e
Mime-Version: 1.0
Message-Id: <96f0536e-6a45-4a44-85a7-1ce530a891cc@www.fastmail.com>
In-Reply-To: <YXiOYvnKmXNaLnoJ@robh.at.kernel.org>
References: <20211017125904.69076-1-sven@svenpeter.dev>
 <YXiOYvnKmXNaLnoJ@robh.at.kernel.org>
Date:   Sat, 30 Oct 2021 09:43:12 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Rob Herring" <robh@kernel.org>
Cc:     "Felipe Balbi" <balbi@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Hector Martin" <marcan@marcan.st>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Mark Kettenis" <mark.kettenis@xs4all.nl>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: usb: dwc3: Document role-switch-reset-quirk
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, Oct 27, 2021, at 01:25, Rob Herring wrote:
> On Sun, Oct 17, 2021 at 02:59:03PM +0200, Sven Peter wrote:
>> The dwc3 controller on the Apple M1 must be reset whenever a
>> device is unplugged from the root port and triggers a role
>> switch notification. Document the quirk to enable this behavior.
>> 
>> Signed-off-by: Sven Peter <sven@svenpeter.dev>
>> ---
>>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 6 ++++++
>>  1 file changed, 6 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> index 25ac2c93dc6c..9635e20cab68 100644
>> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> @@ -226,6 +226,12 @@ properties:
>>        avoid -EPROTO errors with usbhid on some devices (Hikey 970).
>>      type: boolean
>>  
>> +  snps,role-switch-reset-quirk:
>> +    description:
>> +      When set, DWC3 will be reset and reinitialized whenever a role switch
>> +      is performed.
>> +    type: boolean
>
> This binding is a example of why we don't do a property per quirk. We 
> end up with a gazillion of them.

Makes sense. I didn't think too much about this since I saw all those
other quirks and just did the same.

>
> Imply this from the SoC specific compatible (I don't recall seeing one 
> for the M1, so that's a problem).

Sure, I'll do that for v2. The compatible for the M1 doesn't exist yet
because the dwc3 nodes also don't exist in the upstream DT yet.
This was all blocked on getting I2C and the USB PD chip to work.



Sven
