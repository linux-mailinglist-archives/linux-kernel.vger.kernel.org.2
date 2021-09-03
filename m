Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3425440072D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 22:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350462AbhICU6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 16:58:24 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:41207 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350361AbhICU6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 16:58:18 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 32EC55C00D0;
        Fri,  3 Sep 2021 16:57:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 03 Sep 2021 16:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        to:cc:references:from:subject:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=P
        OkR53bpiytg3PxhnG+iPG0KgVHiDmhYTOhrNM2TBK8=; b=or3Plv4161tY48aBE
        Z3/6qfS4TluR1yI1v/xoq9Anj0tbUVUsRu3nMdsHaj7mjqKUIN0LGQ2zGpuSjCYC
        bgarS3q0blM+oFzDj7TplibBFQxO4qmv/0h8KXdPBERxtOABaDqb9oSUHlDdI8KW
        i3q5VjsCwPt583p28ddEwhvyGUj9kpKU/FR5AlFRQK4nqUB6sb7YcAlzJKGVqiOi
        hIQnHB5DrfBCDJVWx2jS8sMRWOL2OY/NQZ19ijKFyviOflo0pf/+CDvVBihhLlqT
        NtobzXMpu/DoQIZJUKT7ClREQB/GMsnMYYZioe3nuF9+HZodYfPPNyO1MbeV5HUV
        JDQ6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=POkR53bpiytg3PxhnG+iPG0KgVHiDmhYTOhrNM2TB
        K8=; b=fILS8KHRP18Yb28LBzT0oNZ7zNryQiB3SyZISgp2opU8XaHUB6PyzUw8c
        rwnscn+ZP5nNXCsdusldyoE83k/Bt23UaQOqy/y3APmvCSaP+2STukfBh3imrBqG
        pxJtKDg23O78T/SdXxzvwVQn04qXToqUGFFhThiKYT6+ZJFiuNKTkQV05/po4qvs
        yExmiexeuCBXG3Xd4/NcGRUSAXN6PaAJb8R0xz1BmGbEOwkUzQkTidKmVYRK27pk
        eeR6ewcmOthLkboTQd9bd5pXJ4pl7ri1jnX5l+TsYMJnQKFIdWlOHfvUCi55poKI
        q4fnqutak7fjOxP9OeFTDnK18hqCg==
X-ME-Sender: <xms:LIwyYWRwN_vH5_D3BF79vTAk5VC1Yvi1JahpKI-gaqSZVVinvsssfg>
    <xme:LIwyYbzOumHoAXT1ETk4wwiCIprKSqiwIXbA4Zd7estRecMRVBOBtqLsfWapxwpn_
    msMPaLnXiN-M_61Nw>
X-ME-Received: <xmr:LIwyYT1G9wZIh5OBZPkCzPuwvvCbIQ8-DaRCq1crJKBPdY_QfyRxOW-pVfsUluhM99vbL9ZICvgEQKdPJEVzIvcR1PRMjJOHBTFFOBNbT8aRvOLypgiXo-fPCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvjedgudehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefvfhfhuffkffgfgggjtgfgsehtkeertddtfeehnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeehjeeghfdufeefteelieeggfehteevieetueffhefhffekuedv
    ffevffevtedufeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:LIwyYSAigwu7JRvcmRFlsK9Vg0XSwgFdGEeiNfzHgTSerYiiimrbHw>
    <xmx:LIwyYfgLQikdsc-Q6-ZPkkYolWjrg_nlV_4l0xYfo-whUJrNOXfd4w>
    <xmx:LIwyYeqEZoGFA19h7mYFeQAXPl3IlN0nXezAv24FWQjahGBAWWzexw>
    <xmx:LYwyYfh_pWWwsTHUqzCijPmtWIJTYmmxJkLg6YHM1k73JPp12ii7cA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Sep 2021 16:57:15 -0400 (EDT)
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210901050526.45673-1-samuel@sholland.org>
 <20210901050526.45673-5-samuel@sholland.org>
 <20210903091040.2bngsvhem2ftzhaz@gilmour>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 4/8] clk: sunxi-ng: Rename files to match Kconfig and
 drivers
Message-ID: <1d269ff8-9219-cc0a-fda7-236bfd4b4510@sholland.org>
Date:   Fri, 3 Sep 2021 15:57:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210903091040.2bngsvhem2ftzhaz@gilmour>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On 9/3/21 4:10 AM, Maxime Ripard wrote:
> Hi,
> 
> On Wed, Sep 01, 2021 at 12:05:22AM -0500, Samuel Holland wrote:
>> When the drivers are built as modules, the file name will become the
>> module name. Rename the files so everything matches: the Kconfig symbol,
>> the platform driver name (as seen in sysfs), and the module name.
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
> 
> I'm not a big fan of big renames like this, it makes merging and
> backporting patches harder in the long term.

I can split this into two commits, first the .c files and then the .h
files, so everything is a 100% rename, if that makes a difference.

> I assume you did this to make the module autoloading work? If so, using
> MODULE_ALIAS would be less intrusive

Autoloading should work anyway, since there is a module alias for the
compatible string. This change is more about the principle of least
surprise. The compatible is allwinner,sun50i-a64-ccu, the Kconfig symbol
is SUN50I_A64_CCU, the driver name (in /sys/bus/platform/drivers) is
sun50i_a64_ccu, but yet the module name is ccu-sun50i-a64???

Once we allow building modules, the names are ABI, and this
inconsistency will bother me until the end of time :)

If there is a way to completely rename the module without renaming the
files (not adding an alias), then that would be enough for me.

Regards,
Samuel
