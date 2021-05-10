Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDC03779FF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 03:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhEJBzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 21:55:45 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:55217 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230079AbhEJBzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 21:55:45 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id E874C148D;
        Sun,  9 May 2021 21:54:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 09 May 2021 21:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        to:cc:references:from:subject:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=V
        Y3By0hTVrgL1Wi0xkBOrRleVr54f/DNNwnd5BZJjaA=; b=pGpd2a3hEYPtw8aqQ
        +i2ffsCP9ymghOwUlqzfuRZInSsCJm9tu5CYVaWjUlrxVe9ZQnUxvxqtqgcMlFQN
        oJdfIFm6CmQboalb/TqRz3SL1fBYVTkPN9QvSmjybknry88Uc+J/UPMIb5UP8PzG
        BAC7wcM4bS25TFfWQtyeVJVYUKAbiIilVvmYBb0M/xY079eVjHR6zh78n875PcMc
        CNYPRex/cGNRYN5NPDj1ZIQfaznZPJumM/8wa8VQw9b4d6l+p+rF95hC8FyQfAIB
        e+7e3YLOPdRILQsv2qJmBV4zaK99z/Z+tOvAfqB9jbmLW8ZMORhvQB+LrGpsGGi0
        4mvmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=VY3By0hTVrgL1Wi0xkBOrRleVr54f/DNNwnd5BZJj
        aA=; b=sarEq2CBOzSjNs8a2vzbddBSpeaQolx6LtSuQQE7kjn5LiDCI4WE4o76M
        RS0CiTXyj91I5RNM+EGkQ7/1xTLeNNVBuXim3/zMPPKoD7ojStn09AxNq2keQPwn
        zRtPUgC4PEYG6pyO8oEPHn8O9NSDK2gCrOQuozBAHJTQfoLzOmRYoO3XuTNQNu73
        HHGfexPIC+9KSizd/IrmrOh5Wsz32ellipZNUAeXHIwbLZcpBRv10a4yqEtKJdOs
        uEOHmJgNifJED9Sm5BtkFaUx5OdfEpOjBGgJhQkY1Sat6WHHeWy/Kfbvheo1ZdBd
        rNCM1VhDUlsrrMiLtZxo4VyvRkX5Q==
X-ME-Sender: <xms:XZKYYEdaVOUCJU4GXbyFsQFumYUYY7q-oou88Bm3h-H1XAWLe4aL_A>
    <xme:XZKYYGNWcIFNLj11fMoO61TkGtbG3s10ZbvDQhApNKVy0r_5cRZ0FKER3cQhl6cee
    tI18Fme0iiVpusQLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdegjedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepvfhfhffukffffgggjggtgfesthekredttdefheenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepheejgefhudeffeetleeigefgheetveeiteeuffehhfffkeeuvdff
    veffveetudefnecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgr
    nhgurdhorhhg
X-ME-Proxy: <xmx:XZKYYFgSFn9K13zLdm6J3GQYlJ9fVxpbakg1XNsMEvsKsutTGhbmjg>
    <xmx:XZKYYJ9L5G49w7oLZFozOL6Tv6nB1IRnpqGOmShXG4VLZOFxMJ3v6w>
    <xmx:XZKYYAvR_Cd9Pbm2-VPqL-72WxqFRjFmQv_fyQfUwZBbGMqOaccrTQ>
    <xmx:X5KYYCKSr_Hw5rYS9vmO3YbrfgafmOyGuwm5fqPp3JLhyqvBM6YvIN6JpFc>
Received: from [70.135.148.151] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Sun,  9 May 2021 21:54:37 -0400 (EDT)
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>
References: <20210430035859.3487-1-samuel@sholland.org>
 <20210430035859.3487-8-samuel@sholland.org>
 <20210507080942.lxysxdbrviv3ys7m@gilmour>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v3 7/7] arm64: dts: allwinner: pinephone: Set audio card
 name
Message-ID: <2c8e512c-59f4-8869-be2e-0bf4c3cc2415@sholland.org>
Date:   Sun, 9 May 2021 20:54:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210507080942.lxysxdbrviv3ys7m@gilmour>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/21 3:09 AM, Maxime Ripard wrote:
> Hi,
> 
> On Thu, Apr 29, 2021 at 10:58:59PM -0500, Samuel Holland wrote:
>> From: Arnaud Ferraris <arnaud.ferraris@collabora.com>
>>
>> Add the "PinePhone" name to the sound card: this will make
>> upstreaming an ALSA UCM config easier as we can use a unique name.
>>
>> It also avoids an issue where the default card name is truncated.
>>
>> Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
>> [Samuel: Split out change, updated commit message]
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>  arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
>> index 51cbfdc12936..02712f85f6bd 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
>> @@ -433,6 +433,7 @@ &reg_rtc_ldo {
>>  
>>  &sound {
>>  	status = "okay";
>> +	simple-audio-card,name = "PinePhone";
>>  	simple-audio-card,aux-devs = <&codec_analog>, <&speaker_amp>;
>>  	simple-audio-card,widgets = "Microphone", "Headset Microphone",
>>  				    "Microphone", "Internal Microphone",
> 
> Isn't that reported to the userspace? I'm not sure we can just change it
> without breaking it.

Yes, this is seen by userspace.

Ideally, we would add this property with a unique value when enabling
audio for any board, but as you mention, it would be a breaking change
to add those properties now.

In practice, all distributions supporting the PinePhone are already
carrying this patch, because the ALSA setup needed for the PinePhone is
very different from most other boards. So it would be similarly breaking
for them (and their users) to drop this patch.

Regards,
Samuel
