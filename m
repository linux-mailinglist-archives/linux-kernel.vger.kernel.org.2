Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6212A401AE3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 14:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241496AbhIFME2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 08:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241333AbhIFMEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 08:04:15 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126EEC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 05:03:11 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id a13so8403436iol.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 05:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O7ISh/OwFD2H80nlF7WhKIYbG9cBOwzE8UDDaZsXvsA=;
        b=PT3/Qdobfe0XUw4ybHv2sxcU7bEZ4U8GpCM75nkOhP5SL755yd4LdmI5e96ScqA2L3
         J8Ffv1NMhvlqSijsiavC45D52SLRkaWocVM0GP0s7TNnbHyXAfahuP1zrqdib+ujk+EM
         CU1LizVvzDHmBLU+Wwf8TzBAzyzy/eGNKb8fjnrchdaF05wK2rVfgOaIh5Hc8dMjIKN1
         GTKQm1Ot2cd7xF+PxmzXai7Ru372heQ158Pv8KT9oqxZLHrVTFGEHLKOiN3TyS7nOKf9
         sRtb6KrzVdz90nATiOqiUkRxnLac/Ph+juUv9DQjEosiGvAAlj2Srl51NPJOM3jY/uCv
         mSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O7ISh/OwFD2H80nlF7WhKIYbG9cBOwzE8UDDaZsXvsA=;
        b=MEP6kAbQtaSiJ2NQ50krrBmR8x+astbetyY7keC+Op/oQIxFqQl5G5XfZdXL44Ev7r
         Z17DOTcnfJr4Hcu5zKj30m07wmiyLJkpiUryeCytDo4aPqeaLBpFW1/3mHof0TrxE7iL
         Ib2jL1ihqsf8DPk0o8iCKv2wD96SHcVilCiyFB8mxymBov6RwJ4bmi7GqTzELUcy9ILA
         TuI0DWK9b8iPQDAhhyGzXdFoD5jzvs+vp4u/wKCPKSNY78NQao8bEjnfw4E3y3K2pPvd
         Z8WjecsnbvXh53RGxKScANaW0lOgKkgYZ/qbmyOjd4o+vCw0+H7ImLFHbn5aYsvSDoVZ
         LMyg==
X-Gm-Message-State: AOAM530vyqeBeCGp5H4aMJecZk6SAcNxo9I7s38Osuu7eEoAI91GOXXl
        T5+COGaE/eIU026Dyp300OOjP9ZSsbbncxLlpM8=
X-Google-Smtp-Source: ABdhPJzA51CZzsXmRD/8mfSkSWFTnPv6HG06K4ZkpxKx5Ats57sEW7izaxtVJ1LHGNNDeMnzRanXapodSqQiPmAFRYk=
X-Received: by 2002:a05:6602:2211:: with SMTP id n17mr9431211ion.142.1630929790513;
 Mon, 06 Sep 2021 05:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210812051059.1103641-1-art@khadas.com> <247c746b-621c-5db0-25c0-1ef0d0a0d77e@baylibre.com>
 <1jpmtmys2t.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jpmtmys2t.fsf@starbuckisacylon.baylibre.com>
From:   Art Nikpal <email2tema@gmail.com>
Date:   Mon, 6 Sep 2021 20:02:59 +0800
Message-ID: <CAKaHn9KLYNo9p_Ythq5eXjJSJyJ2=+uhB22A0xp+msLZ9JhJCw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: meson: sm1-khadas-vim3l use one sound node
 configuration with VIM3
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Artem Lapkin <art@khadas.com>, Nick Xie <nick@khadas.com>,
        Gouwa Wang <gouwa@khadas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Take a look at the Loopback sink - it is different between the sm1 based
vim3 and the g12b one ... this is simply because the audio block is
different on these SoCs

Maybe you are right ! i will test it soon too

Another question is:  loopback necessary ? same as 3 alsa sub devices
? mixer configuration is already not easy for  understanding;)

> However the model name here is
> a) probably too long

yes i think need to be like other model = "KHADAS-VIM3L";

On Mon, Sep 6, 2021 at 5:24 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
>
> On Thu 02 Sep 2021 at 15:31, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> > Hi,
> >
> > On 12/08/2021 07:10, Artem Lapkin wrote:
> >> Khadas VIM3L board sound configuration same as Khadas VIM3, its already
> >> defined in meson-khadas-vim3.dtsi and no need overwrite it with different
> >> card names and routing configurations.
> >>
> >> Signed-off-by: Artem Lapkin <art@khadas.com>
> >> ---
> >>  .../boot/dts/amlogic/meson-sm1-khadas-vim3l.dts     | 13 -------------
> >>  1 file changed, 13 deletions(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
> >> index f2c098143..06de0b1ce 100644
> >> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
> >> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
> >> @@ -32,19 +32,6 @@ vddcpu: regulator-vddcpu {
> >>              regulator-boot-on;
> >>              regulator-always-on;
> >>      };
> >> -
> >> -    sound {
> >> -            model = "G12B-KHADAS-VIM3L";
> >> -            audio-routing = "TDMOUT_A IN 0", "FRDDR_A OUT 0",
> >> -                            "TDMOUT_A IN 1", "FRDDR_B OUT 0",
> >> -                            "TDMOUT_A IN 2", "FRDDR_C OUT 0",
> >> -                            "TDM_A Playback", "TDMOUT_A OUT",
> >> -                            "TDMIN_A IN 0", "TDM_A Capture",
> >> -                            "TDMIN_A IN 13", "TDM_A Loopback",
> >> -                            "TODDR_A IN 0", "TDMIN_A OUT",
> >> -                            "TODDR_B IN 0", "TDMIN_A OUT",
> >> -                            "TODDR_C IN 0", "TDMIN_A OUT";
> >> -    };
> >>  };
> >>
> >>  &cpu0 {
> >>
> >
> > Jerome could you quickly review this ?
>
> Removing that is wrong.
> Take a look at the Loopback sink - it is different between the sm1 based
> vim3 and the g12b one ... this is simply because the audio block is
> different on these SoCs
>
> So audio-routing property can't go way, Because of that, the cards are
> slightly different and should have different model.
>
> However the model name here is
> a) probably too long
> b) misleading :/
>
> >
> > Thanks,
> > Neil
>
