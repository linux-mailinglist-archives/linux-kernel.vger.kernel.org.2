Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C12742D177
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 06:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhJNEXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 00:23:15 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:44395 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229457AbhJNEXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 00:23:12 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8EE74580E8C;
        Thu, 14 Oct 2021 00:21:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 14 Oct 2021 00:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        to:cc:references:from:subject:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=u
        qzOZZz/9vc/TqZeIFjYvMXtaliYQ5uBgCj+mfMcLxk=; b=lWV2Cka9t1PKMYuyf
        ofDip9RtHUqtnB/80isuPb0hEvPO+MRhBBqmxHTnIJ6wGNlml4ZpTZgi68O3CenU
        w4J0NPIFiWgBbx/3PJcfO7dBHiO1RfV2d8JoLQvNh8i82rxsbJ8bcwpLxmuMvJ0r
        ohmOfgF92mzMP3jmgV9oxNBBYtsISjET4MHuZFgvjwLAMlCykkW3pzjEKgvYAVL4
        qnJJomscyOcyfRAlQCTvhmqqr2rNBYsMj60nbN8CK/ITILZvCdGHi9E87hPUSrZA
        KZOvT5PfE/abacvpQpBn1bZVK926Sa5qtWCnLgjtSHww5wtYiIjUO5nUb+EIfyLl
        4dcTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=uqzOZZz/9vc/TqZeIFjYvMXtaliYQ5uBgCj+mfMcL
        xk=; b=mfhJaY4uAJ6gAdEusHNedUEk+Mnk5hHnaGWnCSC7RiL4yTzqOISpb1iL3
        MlCLnUoMRa9XD3BHE9JIC8RSQfOTymLfi7wQ11uBMz2wzwGwS6ED/35uMIndAI4s
        jB1Pzo2V5Ck1y651ZLUcXfAA99uz+Rm0zBP47D1vVLO7fwnc4kP8zJd/RoFA6/wl
        Dr7CK/+s/9gcD6Ah6MValXgF3F2pP1qGS5w5YMob+nMU2p8UORtybjJK5Jf6pqyf
        fxaVA43lHQCp7a0SAaGoo1vwwJz0pCuS7KCBZ9i4+jQ+6Pbu/KfcHt7gO1crYT+p
        OgouDbhMs3ksZJNFq/S3cjyRppj1Q==
X-ME-Sender: <xms:MrBnYXqgNcyfesEY5VAekg5z7i44BH7TDnBgMnW5b7vDP_0HLH9jUw>
    <xme:MrBnYRoMcSUYLI9xUg_mIJYG-uLiMgjqmV3ruiGFo-5Hm6glsB8ga8oTyluxRo3rU
    TL9Q3HVuUqXhzRgvw>
X-ME-Received: <xmr:MrBnYUPbWS1LQhICO3HS0tfHIuAUYmqjOXQB14LqCEf1RUMtae5GIwLUA8qhTrbBzAgA748gnX8JV1WZ2hXXAvqnxVB--SIo5H9g0maNuWKUAxqYt2pB1a3iEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdduuddgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepvfhfhffukffffgggjggtgfesthekredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvddttdejieduudfgffevteekffegffeguddtgfefkeduvedukeff
    hedtfeevuedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:MrBnYa7554oYAxmUaI9FdzofPzlq135aKSfXYxzp3ckCW3VwZCzjMw>
    <xmx:MrBnYW5nw9uYCfEtdR62N8M4oW6w_vTNm6sbeYO99ZjbGCN1qHXTjA>
    <xmx:MrBnYSh6bl-Yh5QrDDhYUs-e3j-ekfGINqEKujaemXcyRqhm_WY_tA>
    <xmx:M7BnYTyxqgHfKjg83eNpaNoeSph4PTnuP2TFQEaqCxLVaXsLck6Neg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Oct 2021 00:21:06 -0400 (EDT)
To:     Guo Ren <guoren@kernel.org>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc:     Anup Patel <anup@brainfault.org>,
        Atish Patra <atish.patra@wdc.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Rob Herring <robh@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
References: <20211013012149.2834212-1-guoren@kernel.org>
 <4245323.jvX0RauA9x@diego>
 <CAAhSdy29WAXfBz6Ag-kAjNo_uhJO+AuC0e-UyWhwhaCmrw7pjw@mail.gmail.com>
 <4027415.QZv1u5a1DM@diego>
 <CAJF2gTTDZ0QjY9JL=U61=ubWrGWVOe2VBbW6hgzsHqsePgN0Ww@mail.gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH V3 1/2] dt-bindings: update riscv plic compatible string
Message-ID: <693a609c-4278-84ab-8a9b-448936bb13d0@sholland.org>
Date:   Wed, 13 Oct 2021 23:21:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAJF2gTTDZ0QjY9JL=U61=ubWrGWVOe2VBbW6hgzsHqsePgN0Ww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/21 7:49 AM, Guo Ren wrote:
>>>>>>>>        - const: sifive,plic-1.0.0
>>>>>>>
>>>>>>> The PLIC DT node requires two compatible string:
>>>>>>> <implementation_compat>, <spec_compat>
>>>>>>>
>>>>>>> The C9xx PLIC is not RISC-V PLIC so, the DT node should
>>>>>>> be: "thead,c900-plic", "thead,c9xx-plic"
>>>>>>>
>>>>>>> You need to change "- const: sifive,plic-1.0.0" to
>>>>>>> - enum:
>>>>>>>     - sifive,plic-1.0.0
>>>>>>>     - thead,c9xx-plic
>>
>> isn't XuanTie the series containing the c906 and c910?
> XuanTie contain two CPU series:
> riscv: c906, c910
> csky: c807, c810, c860
> 
>> So maybe
>>         thead,xuantie-plic
>> for the spec compatible.
>>
>> So doing in full
>>         compatible = "thead,c906-plic", "thead,xuantie-plic"
> How about:
> compatible = "allwinner,d1-plic", "thead,c900-plic"

To follow the <family>-<soc>-<device> pattern of existing Allwinner
compatibles, the first string should be "allwinner,sun20i-d1-plic".
Otherwise, this looks to me like the right thing to do.

Regards,
Samuel
