Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF28642191C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 23:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbhJDVT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 17:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbhJDVT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 17:19:26 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E82EC061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 14:17:37 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id x7so67931152edd.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 14:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lfIbcNy8uRUeT/alGgQC1RAZh4dTZXYv6GLv/0r2a/Y=;
        b=aeY1Mie9I7CmWT72Q2XqRVY2H9Gs5T3E+Qdzz6OUZPf4u5gcrbmnxOe2WqoYU7XGyT
         vTUdzCwGyi1aZroFKjb9fZz4tM0DuYLHAxtv2sqiRdcQVckSsoOPLJ2QVM5Jx5XgLE1u
         lBqT+c9dPmSo58yOKKOxsqF36oDTxj9MoJXEJffUucT5ZRyHm6+Zf+tcsf93J0q1oSog
         R9RMZncqqc5vXMdC/GfVPm7JB5c1B4E1Bj2s/oUJaFzPmjkw99HHEfSKBUUZRLUIw84t
         LUcWc5CtcxQTHHO1tXA+R3aI1Vk2NJGR4PeMCigBh+sS+WNAWUmuUxOC5lIC2qxgsC1K
         LhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lfIbcNy8uRUeT/alGgQC1RAZh4dTZXYv6GLv/0r2a/Y=;
        b=04sWTEb6xD0/XH2pJxj4i3eZtMutoEX9rxkCn/bldYBJZOAw/CgzvtSZJl5BGCeSYv
         HborGWZFPBHNdFX4rX1/CCYtpLJIidU4RfZ5aL1CyMJ0J42dBQCpFwuNFMCGrA3zrVL9
         SbgJQX3MVgnV8GMdPMZxqt8cbAsCcmITSYItbWa2uZ4zXsIpriMlRzD3bR8iC4H7RW58
         FQuWPpbv5M+iofIfPdXbc/AqcrnEa4Op7pG6RKW0BKMGRuC+8zSgsN2jvP75wX/cQzeR
         a4S+6x97Y70gqyYVg35wakwPvkmABWyMqzwoi1394TTh3cU9CLJxZFo2P7RAaOsuU5jX
         qS4Q==
X-Gm-Message-State: AOAM532A9qW3lodz8WaMWckHj2Gg1SJ9ZzazuMrPKThDNu+StWRSXm/i
        JEWOuoZjtmLGt5p0ybZDXbsh99n3qtHKBIh/hWk=
X-Google-Smtp-Source: ABdhPJy4g68s5xZSNqK01V2f9gaZCfuyvWoUsyjuXX0Nfu/46CALquUFp4do1rs3uFQnOhg1MWmzAZtxT8A61rjJ9DA=
X-Received: by 2002:a05:6402:d52:: with SMTP id ec18mr6632042edb.67.1633382255772;
 Mon, 04 Oct 2021 14:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <20211002234313.3209294-1-martin.blumenstingl@googlemail.com>
 <1j35pivzho.fsf@starbuckisacylon.baylibre.com> <CAFBinCCCQebCEdLjYAfWkF4NDPdma8UzVMhHOhZPVreoV2qd2w@mail.gmail.com>
 <1jy279uprd.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jy279uprd.fsf@starbuckisacylon.baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 4 Oct 2021 23:17:24 +0200
Message-ID: <CAFBinCBrYUPOkvJUAiEF9X0Z76ta3jSrKkLkaHvJUaiWNyR0yw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/1] ASoC: meson: aiu: HDMI codec control questions
 and issues
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, linux-amlogic@lists.infradead.org,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Mon, Oct 4, 2021 at 11:02 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
[...]
> > old 32-bit u-boot sources from the Endless Mini do have some
> > documentation on AIU_I2S_SYNC [0]:
> > // 8'b0_000_1_1_10
> > // A write to this register will cause the interface to repeat the current
> > // sample. Can be used to regain synchronization.
> > // A read from this register indicates that the next sample to be sent
> > // out of the interface should go into the _left_ channel of the dac.
> >
> > There's also a note about AIU_I2S_MISC stating:
> > // Bit 4 if true, force each audio data to left or right according to
> > the bit attached with the audio data
> > // This bit should be used with Register AIU_i2s_sync(0x511) together
> >
> > To be honest: to me this is not helpful since I don't understand
> > how/why the left channel is of importance.
>
> Same here, I already had this description and it is not really that helpful.
OK, so I guess this leaves experimenting (which requires luck)... :-(

[...]
> This bit could also be a remain of an older design, not really connected
> to anything meaningful. It would not be the first time.
>
> The AIU looks like an IP that has evolved a lot over the years, not always
> in a coordinated fashion. Some scenario are well supported and easy,
> others seem to require a magic spell.
>
> Last (but not least), in AML vendor kernel, the only time this bit poked
> is around 8ch support (1 for 8ch, 0 otherwise) ... I have no idea why.
The 32-bit SoCs use SPDIF to feed 2-channel audio to the HDMI TX
controller and I2S to feed 8-channel audio to the HDMI TX controller.
It seems that Amlogic stopped this for (at least some) 64-bit SoCs.

My testing results indicate that AIU_CLK_CTRL_MORE[6] is still relevant.
I can do another round of testing with various combinations of
AIU_CLK_CTRL_MORE[6] and AIU_HDMI_CLK_DATA_CTRL register values.
If you want me to test any specific combinations then please let me know.

> > So to me this means that there's three different muxes:
> > - data mux to choose between 0x0 (all zeros), 0x1 (PCM) and 0x2 (I2S)
> > - clock mux to choose between 0x0 (disabled), 0x1 (PCM) and 0x2
> > (hdmi_tx_audio_master_clk)
> > - hdmi_tx_audio_master_clk clock mux to choose between 0x0 (cts_i958)
> > and 0x1 (cts_aoclkx2_int)
> >
> > Based on that I think that it's not possible to have AIU output the
> > I2S and SPDIF signals at the same time to the HDMI TX controller and
> > then letting the HDMI TX controller choose which one to use.
>
> i2s and spdif can be 2 independent paths (with different clock sources).
> I have already made them work concurrently. I believe (but have no
> proof) that the same should be possible with the HDMI.
>
> Until the hdmi controller has support for both inputs, we don't need to
> worry about it.
My work-in-progress HDMI TX controller driver for the 32-bit SoCs [0]
does support both (I2S and SPDIF) inputs. That's how I am able to test
all of this.
I wasn't aware of the fact that it's known that the "machine gun
noise" (MGN) issue is related to I2S only. Since I couldn't find a
workaround or fix for the MGN issue I wanted to narrow it down by
adding SPDIF support to the HDMI TX path.

> > Based on whichever signal (I2S or SPDIF) we want to use for HDMI we
> > need to configure AIU accordingly (data and clock).
>
> TBH, I'm not really sure what this bit does. From the description, it
> seems it allows to select an HDMI clock (not idea which one actually)
> for either the i2s or the spdif path.
>
> Nothing says it is related to the HDMI_CTRL (codec), maybe it is not.
> Maybe (MAYBE) it defines what will become "the AIU clk" in
> AIU_HDMI_CLK_DATA_CTRL[1:0].
This is what I am thinking

> Until we can feed the i2s encoder from the spdif FIFO, I'm not sure we
> need to play with it.
I think it's also relevant when we feed HDMI TX from the SPDIF (FIFO +
encoder) which is what I am attempting here.

[...]
> >> It is not meant to. The dai_link and the endpoint are i2s.
> >> Your HDMI controller should have 2 inputs and should have a way to
> >> select one or the other. The format at each of the (internal) input does
> >> not change
> > ah, that makes sense.
> > Let's say AIU has some internal muxing for the HDMI output then AIU
> > would have two outputs as well (let's call them HDMI_OUT_I2S and
> > HDMI_OUT_SPDIF).
>
> I don't think there is another output the HDMI_CTRL mux block. If SPDIF to
> HDMITX is supported, I suspect the output of the spdif encoder is
> hardwired to the spdif input of the HDMI controller and it is up to the
> HDMI controller to take it or not.
I think you are correct with this.
My theory is that AIU_CLK_CTRL_MORE[6] and AIU_HDMI_CLK_DATA_CTRL will
enable one of the outputs (I2S or SPIDF) from AIU to the HDMI TX
controller, meaning that only one signal can be active at a time. The
HDMI TX controller then needs to "select" the correct input based on
the selected output from AIU.

> That being said, I don't see any hard evidence that AML used SPDIF to
> HDMI in their tree, so maybe it does not work at all.
For the 32-bit SoCs the easiest to understand code-snippet is the HDMI
TX audio input configuration [1]
Which basically translates to:
  if (more_than_two_channel_audio) {
    enable_audio_i2s();
  } else {
    enable_audio_spdif();
  }

The code in the AIU driver just assumes that whatever it's configuring
is what the HDMI TX driver expects - without a clear link between
these two.


Best regards,
Martin


[0] https://github.com/xdarklight/linux/blob/meson-mx-integration-5.15-20211003/drivers/gpu/drm/bridge/transwitch/txccq-txc-48352.c
[1] https://github.com/endlessm/linux-meson/blob/d6e13c220931110fe676ede6da69fc61a7cb04b6/arch/arm/mach-meson8/hdmi_tx_hw/hdmi_tx_hw.c#L3035:L3038
