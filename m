Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF58831658C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 12:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhBJLrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 06:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhBJLos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 06:44:48 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3424DC0617A7;
        Wed, 10 Feb 2021 03:43:43 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 1385141EE3;
        Wed, 10 Feb 2021 11:43:38 +0000 (UTC)
To:     Tony Lindgren <tony@atomide.com>
Cc:     Arnd Bergmann <arnd@kernel.org>, devicetree@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>, soc@kernel.org,
        robh+dt@kernel.org, Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org
References: <20210204203951.52105-1-marcan@marcan.st>
 <20210204203951.52105-19-marcan@marcan.st>
 <20210208110441.25qc6yken4effd6c@kozik-lap>
 <cd67b2ce-9676-31b4-85f7-de1ec9b2bf72@marcan.st>
 <YCOzLSqdsr83xf0b@atomide.com>
 <4481998a-27f6-951e-bb4f-a9d2b95f211f@marcan.st>
 <YCPE2lPpBlhCi7TH@atomide.com>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 18/18] arm64: apple: Add initial Mac Mini 2020 (M1)
 devicetree
Message-ID: <4dd911d8-ce84-bf4d-3aae-95ef321b4a97@marcan.st>
Date:   Wed, 10 Feb 2021 20:43:37 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YCPE2lPpBlhCi7TH@atomide.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2021 20.34, Tony Lindgren wrote:
> * Hector Martin <marcan@marcan.st> [210210 11:14]:
>> That means it'll end up like this (so that we can have more than one
>> fixed-clock):
>>
>> clocks {
>>      #address-cells = <1>;
>>      #size-cells = <0>;
>>
>>      clk123: clock@0 {
>>          ...
>>          reg = <0>
>>      }
>>
>>      clk456: clock@1 {
>>          ...
>>          reg = <1>
>>      }
>> }
>>
>> Correct?
> 
> Yeah, just don't use an imaginary dummy index for the reg. Use a real
> register offset from a clock controller instance base, and a register
> bit offset too if needed.

I mean for fixed input clocks without any particular numbering, or for 
temporary fake clocks while we figure out the clock controller. Once a 
real clock controller is involved, if there are hardware indexes 
involved that are consistent then of course I'll use those in some way 
that makes sense.

The purpose of the clock in this particular case is just to make the 
uart driver work, since it wants to know its reference clock; there is 
work to be done here to figure out the real clock tree (e.g. we don't 
even know yet if the uart supports alternate clocks, that's tricky to 
test until we have some form of I/O other than uart!).

> Doing it right will save you tons of time later on ;)

Absolutely, I'm just pointing out that instances of it being done right 
are in short supply right now :-) (which makes it tricky for people like 
me, trying to put this together for a new soc, to guess what the right 
approach is by looking at existing examples)

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
