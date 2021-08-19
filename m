Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78173F1E93
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 19:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhHSRCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 13:02:46 -0400
Received: from foss.arm.com ([217.140.110.172]:42696 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229491AbhHSRCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 13:02:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 684C51042;
        Thu, 19 Aug 2021 10:02:08 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7017E3F70D;
        Thu, 19 Aug 2021 10:02:06 -0700 (PDT)
Subject: Re: [PATCH 2/4] dt-bindings: sound: add rockchip i2s-tdm binding
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210817101119.423853-1-frattaroli.nicolas@gmail.com>
 <20210817101119.423853-3-frattaroli.nicolas@gmail.com>
 <deb50900-fcfd-23d0-ab8a-0e64b2abb063@arm.com> <2412250.zZEsDtmPgG@archbook>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <70cb1e4b-ecb7-2a4b-ee35-02f5a6b8a986@arm.com>
Date:   Thu, 19 Aug 2021 18:02:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <2412250.zZEsDtmPgG@archbook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-19 14:52, Nicolas Frattaroli wrote:
> On Donnerstag, 19. August 2021 14:08:36 CEST Robin Murphy wrote:
>> On 2021-08-17 11:11, Nicolas Frattaroli wrote:
>>> +  rockchip,trcm-sync:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description:
>>> +      Which lrck/bclk clocks each direction will sync to. You should use
>>> the +      constants in <dt-bindings/sound/rockchip,i2s-tdm.h>
>>> +    oneOf:
>>> +      - const: 0
>>> +        description:
>>> +          RK_TRCM_TXRX. Use both the TX and the RX clock for TX and RX.
>>> +      - const: 1
>>> +        description:
>>> +          RK_TRCM_TX. Use only the TX clock for TX and RX.
>>> +      - const: 2
>>> +        description:
>>> +          RK_TRCM_RX. Use only the RX clock for TX and RX.
>>
>> I wonder if that might make sense to have boolean properties to describe
>> the latter two cases (which would effectively be mutually-exclusive),
>> rather than a magic number? Or possibly even just make the respective
>> clocks optional, if this is something which would be done per-SoC rather
>> than per-board?
>>
> 
>  From what I know from downstream vendor device trees, these are per
> board, not for the SoC as a whole. There are I2S/TDM controllers on the
> SoC which I think are hardwired to certain other IP blocks, such as I2S0
> being connected to HDMI, but I2S1 can be routed outside of the SoC where
> these come into play I believe.

That's fair enough. I know a lot more about DT bindings than I do about 
I2S, but I did guess it might be related to clocking requirements of the 
connected codec rather than a constraint of the I2S block itself.

> As for making them boolean properties, I'd rather not. If I were to make it
> two mutually exclusive booleans, this would result in 4 possible states
> rather than 3, and require complexity to check it both in the schema and
> in the probe function. Like this, I can get away with a switch case that
> has a fallthrough, and a list of consts in the schema.

Complexity?


	if (of_property_read_bool(node, "rockchip,trcm-sync-tx-only"))
		i2s_tdm->clk_trcm = RK_TRCM_TX;
	if (of_property_read_bool(node, "rockchip,trcm-sync-rx-only")) {
		if (i2s_td->clk_trcm) {
			dev_err(i2s_tdm->dev, "invalid trcm-sync configuration\n");
			return -EINVAL;
		}
		i2s_tdm->clk_trcm = RK_TRCM_RX;
	}
	if (i2s_td->clk_trcm)
		i2s_tdm_dai.symmetric_rate = 1;


If I'm counting correctly, that off-the-top-of-my-head example is a mere 
58% of the size of your switch statement ;)

The usual aim in designing bindings to robustly abstract the underlying 
features, not to be easy to implement. That's why the "put this magic 
value in this register" style of property is generally frowned upon.

As for the schema, it doesn't necessarily have to try to exhaustively 
catch every possible usage error - if a combination of properties is so 
obviously nonsensical that a driver shouldn't accept it anyway, I'd 
imagine it's unlikely to slip through testing.

>>> +
>>> +  "#sound-dai-cells":
>>> +    const: 0
>>> +
>>> +  rockchip,no-dmaengine:
>>> +    description:
>>> +      If present, driver will not register a pcm dmaengine, only the dai.
>>> +      If the dai is part of multi-dais, the property should be present.
>>> +    type: boolean
>>
>> That sounds a lot more like a policy decision specific to the Linux
>> driver implementation, than something which really belongs in DT as a
>> description of the platform.
> 
> I agree. Should I be refactoring this into a module parameter or
> something along those lines? I'm unsure of where this goes.

Depends on what it actually means, and whether that's something the 
driver can figure out for itself. I just see a DT property based around 
a particular Linux API call as a big red flag :)

>>> +
>>> +  rockchip,playback-only:
>>> +    description: Specify that the controller only has playback
>>> capability.
>>> +    type: boolean
>>> +
>>> +  rockchip,capture-only:
>>> +    description: Specify that the controller only has capture capability.
>>> +    type: boolean
>>
>> Could those be inferred from the compatible string, or are there cases
>> where you have multiple instances of the IP block in different
>> configurations within the same SoC? (Or if it's merely reflecting
>> whether the respective interface is actually wired up externally, could
>> that be inferred from the attached codec?)
>>
>> Robin.
>>
> 
> They can't be inferred from the SoC because there are indeed multiple
> instances of this IP block in different configurations on the same SoC.
> The RK3566 and RK3568 have four in total, of two different categories,
> each being able to be configured for a different format (though the
> number of channels and available formats vary for the two categories,
> one group only supports I2S and PCM with two channels)
> 
> The particular configuration may even vary per-board; an I2S/TDM
> controller may be connected to an external codec which does not
> support capture, whereas on another board it may be connected to
> one that does.

Fair enough again, but surely if the codec doesn't support capture then 
in the end no capture interface is going to be exposed anyway - does the 
low-level transport need to care?

> As an example, if I understand it correctly, I2S3 on the RK3566 and
> RK3568 can do 2 channels RX and TX in I2S mode, but only 2 channels
> either RX or TX in PCM mode, but I'm unsure of the language in the
> (still not public) documentation I have.

And that starts to sound like something the driver should probably be 
aware of anyway, but at very least only casts more doubt on these 
particular properties - even if an interface to a stereo PCM codec 
couldn't support simultaneous playback and recording, couldn't it still 
support doing either, separately?

Robin.
