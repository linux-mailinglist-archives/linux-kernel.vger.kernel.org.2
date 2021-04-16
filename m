Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0464E362896
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 21:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243078AbhDPT0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 15:26:35 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:37575 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235362AbhDPT0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 15:26:31 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 01C1022253;
        Fri, 16 Apr 2021 21:26:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1618601164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iOKsLNHAvUNt6FOKX0n36qA6s7ZucezMgWOSW4v76s8=;
        b=Hb1xtI/WzADiaRibdpmonxBtIdj9F1hpRIoWgSNvarzwJvNlayCeXjwOHk4k/q5vapGRy0
        mZ4MWe8zwkie5eb66+W6rIaiyGkCEb3cCFQga8gMElsiMmwCxqHLmjmrU3+LW7L9M/xtGG
        VEhMEaxzSx5188bB+2nPXjtvkdJNma0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 16 Apr 2021 21:26:03 +0200
From:   Michael Walle <michael@walle.cc>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 0/5] mtd: core: OTP nvmem provider support
In-Reply-To: <20210416184423.GA3715339@robh.at.kernel.org>
References: <20210416114928.27758-1-michael@walle.cc>
 <20210416184423.GA3715339@robh.at.kernel.org>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <9f33229a8fe83b49210289fc93a8554e@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Am 2021-04-16 20:44, schrieb Rob Herring:
> On Fri, Apr 16, 2021 at 01:49:23PM +0200, Michael Walle wrote:
>> The goal is to fetch a (base) MAC address from the OTP region of a SPI 
>> NOR
>> flash.
>> 
>> This is the first part, where I try to add the nvmem provider support 
>> to
>> the MTD core.
>> 
>> I'm not sure about the device tree bindings. Consider the following 
>> two
>> variants:
>> 
>> (1)
>>     flash@0 {
>>         ..
>> 
>>         otp {
>>             compatible = "mtd-user-otp";
> 
> mtd is a linuxism. Why not just 'nvmem-cells' here or as a fallback if
> we come up with a better name?

There are two different compatibles: "mtd-user-otp" and 
"mtd-factory-otp"
to differentiate what kind of OTP should be used (and both are possible
at the same time). Thus nvmem-cells alone won't be enough. We could drop
the "mtd-" prefix though.

Is there a benefit of having the following?
   compatible = "user-otp", "nvmem-cells";


>>             #address-cells = <1>;
>>             #size-cells = <1>;
>> 
>>             serial-number@0 {
>>                 reg = <0x0 0x8>;
>>             };
>>         };
>>     };
>> 
>> (2)
>>     flash@0 {
>>         ..
>> 
>>         otp {
>>             compatible = "mtd-user-otp";
>>             #address-cells = <1>;
>>             #size-cells = <1>;
>> 
>> 			some-useful-name {
>>                 compatible = "nvmem-cells";
>> 
>>                 serial-number@0 {
>>                     reg = <0x0 0x8>;
>>                 };
>> 			};
>>         };
>>     };
>> 
>> Both bindings use a subnode "opt[-N]". We cannot have the nvmem cells 
>> as
>> children to the flash node because of the legacy partition binding.
>> 
>> (1) seems to be the form which is used almost everywhere in the 
>> kernel.
>> That is, the nvmem cells are just children of the parent node.
>> 
>> (2) seem to be more natural, because there might also be other 
>> properties
>> inside the otp subnode and might be more future-proof.
>> 
>> At the moment this patch implements (1).
> 
> I think approach (1) seems fine.

ok

-michael
