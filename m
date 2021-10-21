Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC79436178
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 14:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbhJUMWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 08:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbhJUMWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 08:22:11 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE639C061749
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 05:19:55 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e12so803100wra.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 05:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=1MAcWNR4eIJHPkpF0pYcakZ/CD1b8OAEZ6esT1QDubc=;
        b=hBCnOWpAXWArLg0uH9UGShDwvTdqrT6J/fDuC7xhthw0qa2wBVNACShsI7AISgfR+d
         YJIVZHIJPWeNFDiq2VIA+I///w1zDmM5lO2OWmh9154MduFB2OM8IhFLstq+rvPCmTTj
         AecQMUgLfL7ChrRfMLg/mNhdLPy1a4IxlgTb33oc6uytvUdukI63bZhtEYHVnEXLbWkD
         OE9r4iwGFvJIRzMDWVfad0JxcBuig+jD6hK518WZWIHfAicg0CstlGMEM5jHiD8E3pSE
         pFiZx0isZAP5kHfk+EPvELt6K0hFc+4j3i7TBbr9LAffw8aCWZIjAequzLZy9FP46rPy
         V1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=1MAcWNR4eIJHPkpF0pYcakZ/CD1b8OAEZ6esT1QDubc=;
        b=mA/LaS1qmBU3bx0CuYTd11BD3ObPXQwaQxW09ePm93pmfy+EBweFLkD81pmCCqLCeH
         sKqIpO733s4KivKtpVOHfYiu1eGA0jRTZPMPpeDrzKwXpEQNVi+Up1a2Ye9p12tD2hT0
         HCgZT76Q0+YnIMlqKNv7N5vbYz9NTatRkEw1NSD5yOi6tJZtDStaz9i4cDsK23e3sBEv
         2lSXJZtUGjkpBgdyBD/bbPCxf55//KqY7eHCSn0FjLZ8H/bJuLleHj80JeYBeoIejKIj
         jDrXwpkp++pAGgcVUlJR0mMRcfhQsv71Qm2sR7uPi40iy4W0eQoXZx5+3zusFfjv3Vok
         Lxdg==
X-Gm-Message-State: AOAM5307ius19uyPBbIMGSKCaS67EXmvfAmckAQ3KhFIDpP+bvzxSh7K
        LKqxC6LCeNTgip5jINtaTO+lQ6xL2/AEUoF5Xpc=
X-Google-Smtp-Source: ABdhPJzJvoUSpjaqHzOXELw1I39FiK/03T2TYTk/qaJuwZGyqBujn5meTTPNaXiPnO9TLEbK6mN7ZQ==
X-Received: by 2002:adf:ff91:: with SMTP id j17mr6555798wrr.132.1634818794258;
        Thu, 21 Oct 2021 05:19:54 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 133sm7971860wmb.24.2021.10.21.05.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 05:19:53 -0700 (PDT)
References: <20211016145939.15643-1-martin.blumenstingl@googlemail.com>
 <1j5ytuvdmw.fsf@starbuckisacylon.baylibre.com>
 <CAFBinCBGZi3MRqTRshyCkq8AAaqHi2NkZVV80ppZr4Lx=xWOWA@mail.gmail.com>
 <1jmtn6tu99.fsf@starbuckisacylon.baylibre.com>
 <CAFBinCCRWS6j=6hDo_sOBmQZw5X8L4GYP=rHQVqHd04keCrbuQ@mail.gmail.com>
User-agent: mu4e 1.6.7; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Christian Hewitt <christianshewitt@gmail.com>
Subject: Re: [PATCH] clk: meson: gxbb: Add the spread spectrum bit for MPLL0
 on GXBB
Date:   Thu, 21 Oct 2021 14:18:01 +0200
In-reply-to: <CAFBinCCRWS6j=6hDo_sOBmQZw5X8L4GYP=rHQVqHd04keCrbuQ@mail.gmail.com>
Message-ID: <1jfssumuxi.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 20 Oct 2021 at 20:16, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> Hi Jerome,
>
> On Mon, Oct 18, 2021 at 2:03 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
> [...]
>> > The difference here is BIT(14). un-setting BIT(14) (documented as
>> > EN_DDS0) did not change anything according to Christian's test.
>> > That also means that SDM, SDM_EN and N2 have the expected values.
>> > I manually did the maths:
>> > (2000000000Hz * 16384) / ((16384 * 6) + 12808) = 294909640.7Hz
>> > which matches what clk_summary sees:
>> > 294909641Hz
>>
>>  ... and (2000000000Hz * 16384) / ((16384 * 6) = 333MHz which is fairly close
>>  to what you get w/o flipping the bit
> This is actually a great hint. So far MPLL clocks have "just worked"
> for me and I didn't have to work with this.
> With your explanation it makes sense that SDM_EN makes the hardware
> use or ignore the SDM value.
>
> [...]
>> For example yes. I am asking check a bit more what this bit does and
>> what it does not:
>>  - I need confirmation whether or not it does spread spectrum. Yes this
>>  needs to be observed on a SoC pin, like MCLK with a fairly low divider
>>  to the averaging effect which could partially mask spread spectrum.
> I did some more tests with Christian. It turns out that on GXBB
> HHI_MPLL_CNTL7[15] has no impact on the rate seen by meson-clk-msr.
> On the other hand, HHI_MPLL_CNTL[25] makes MPLL0 use or ignore the SDM
> value (again, verified through meson-clk-msr).
>
>>  - Get an idea what it actually does. The 2 calculations above are an
>>  hint. (Spread spectrum does not change the rate mean value)
> Indeed!
> My conclusion is that on GXBB:
> 1) HHI_MPLL_CNTL[25] doesn't control the spread spectrum setting of
> MPLL0 - just like you thought
> 2) HHI_MPLL_CNTL[25] is actually SDM_EN (and HHI_MPLL_CNTL7[15]
> doesn't seem to have any impact on MPLL0's output rate)
>
> Please let me know if there's anything else we can test.
> Else I'll send a patch for making HHI_MPLL_CNTL[25] the SDM_EN bit of
> MPLL0 on GXBB.

Fine by me if you are confident that HHI_MPLL_CNTL7[15] has indeed no
effect. Maybe add a comment about this oddity.

>
>
> Best regards,
> Martin

