Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAC234703E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 04:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbhCXDv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 23:51:28 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:37967 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232735AbhCXDvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 23:51:04 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 82A50580547;
        Tue, 23 Mar 2021 23:51:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 23 Mar 2021 23:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        to:cc:references:from:subject:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=A
        E6NnJPKV2HGKkqUizuPKiLtp1l2SFt8bu1DsJsxHZY=; b=BiQGrTiSud40CZI10
        JLpaiDMeXiRBJa3abdfi/OUM7Trc0KmGfd91j/JDjgG5SrU3IHjNnD7oLIurK93e
        z6ajXxgcdETtxeNqYHSAOb/rxcRWxfO5LCrolOIcv3caU9UZ6ndKAB0mlbjdOHOC
        fwIMXhdns8WXaMxH3Vek3hgHrE8/Wh+G4yY1bJkDltjEU8SmTBF//uVgZt7AaRFD
        SUsQDgKZjAHjhgdFtsse1LOm5HF5NrpJaR6w5f6bt1mMMiRaI9VMYXP6HRARz1FA
        NjmTL0x9rngh0jD2Gyjz9lUhsSu1bGgwKorKRI6X8Vkcl8Py63320TpioXxTN73g
        u8W0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=AE6NnJPKV2HGKkqUizuPKiLtp1l2SFt8bu1DsJsxH
        ZY=; b=OB+Izy6e3hZ2kQeK5HWwqXY9Q91NO3mxrHNcPaquRB+SxZHTYu4UJ1orx
        YX1nvCon8Dq1Y8Cn8/lfGi4rtFbY008iCfuM3oZ5z+IGcTyVVJ1fbs53oi4u59E4
        ZZCEiHLp2dMt931Tq+lfgrGteCh3B0BLAWnNS8F+HPCDlLZiVeB/iRJKqINF5J7e
        t2nTQE1BE3MvFEMwuHlDZ+7CIeav1ciNe0qRr/6eiYh0zhcZ+AMCqAX1QFx4Cany
        uhWyMR5A9IQf5u2AQFihcCbXyMMrhEtWOhGaaei4PYxfQOgQLnmCnHI/Gxi7YDvs
        0XbQBOUTiQaSFA/NNuNBxzwg/YnmQ==
X-ME-Sender: <xms:JbdaYJchcMRDY8wNeB4snLLh6PfOFUtpFfl3UwT4HCKBMpUtjM_jDA>
    <xme:JbdaYHMTFpMENmnv14pHwTaRHJtHBQrS6B4njURLSgNOSRbTdJxU0pACDL_F1ZO4R
    K9uxWuf8ODdWEq9wA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudegjedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepvfhfhffukffffgggjggtgfesthekredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvddttdejieduudfgffevteekffegffeguddtgfefkeduvedukeff
    hedtfeevuedvnecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgr
    nhgurdhorhhg
X-ME-Proxy: <xmx:JbdaYCjyQxWZNDKArMP1T3SdN1p6EqKmidS47viJoVNuouzJKUaAvA>
    <xmx:JbdaYC93QUs9bA2u-Gj_kYDnm-CFbsbQdbeBdlS-IMIgH6bLhMDVCQ>
    <xmx:JbdaYFu9i7nPfm_pjVaVCr8xwo9Rkl2IiGT_1zlKQzUxtelQpO5SDA>
    <xmx:J7daYLLB7lyQbuPU-_WgJYmhq9ZjZJADFZtzmnoayX1TjwRf51_mmw>
Received: from [70.135.148.151] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 07D33240423;
        Tue, 23 Mar 2021 23:51:00 -0400 (EDT)
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210322044707.19479-1-samuel@sholland.org>
 <7bb14a82-5dc9-cefe-4b58-1d2c83974965@linaro.org>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2 0/5] arm64: sunxi: Enable the sun4i timer
Message-ID: <64f6d712-11fe-4626-aa24-8e31c21a8ad4@sholland.org>
Date:   Tue, 23 Mar 2021 22:51:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <7bb14a82-5dc9-cefe-4b58-1d2c83974965@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/21 9:18 AM, Daniel Lezcano wrote:
> On 22/03/2021 05:47, Samuel Holland wrote:
>> In preparation for adding CPU idle states, hook up the sun4i timer.
>> Having a non-c3stop clockevent source available is necessary for all
>> CPUs to simultaneously enter a local-timer-stop idle state.
> 
> Why simultaneously ?
Because the CPU providing (the hrtimer providing) the broadcast timer
cannot enter an idle state which would stop that timer. So in my case,
with 4 CPUs, I was seeing at most 3 CPUs enter idle at any given time.
This prevented any cluster-level idle states from doing anything. After
applying this series, I was able to observe the whole cluster powering
down when appropriate.

Regards,
Samuel

>> Changes from v1:
>>   - Removed H616 changes (depends on an unmerged patch set)
>>   - Reworded the patch 4-5 commit messages for clarity
>>   - Added Acked-by tags
>>
>> Samuel Holland (5):
>>   dt-bindings: timer: Simplify conditional expressions
>>   dt-bindings: timer: Add compatibles for sun50i timers
>>   arm64: dts: allwinner: a64: Sort watchdog node
>>   arm64: dts: allwinner: Add sun4i MMIO timer nodes
>>   arm64: sunxi: Build the sun4i timer driver
>>
>>  .../timer/allwinner,sun4i-a10-timer.yaml      | 42 +++++++++----------
>>  arch/arm64/Kconfig.platforms                  |  1 +
>>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 25 +++++++----
>>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  9 ++++
>>  4 files changed, 46 insertions(+), 31 deletions(-)
>>
> 
> 

