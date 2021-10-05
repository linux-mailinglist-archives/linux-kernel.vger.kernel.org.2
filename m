Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C354232DE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 23:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236658AbhJEVdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 17:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235845AbhJEVdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 17:33:35 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B23C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 14:31:44 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id dj4so1911557edb.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 14:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dyVXlnP2EO7sin30ak6UOPtTEL7Y82rXmT1HaZJEwO8=;
        b=EFN/EvkcYsa4w188RyqHCgrfIifhUY80k3vng6CANfrvzyfsDaVjfDtTPGoR518LhV
         GD5oDuzos+B9/T9xu3L51B88VpK7ug1wdWoYUKxCIx5iYryNBRqmOK3f1s0NVN3zNmSx
         ik2H8dDm4T9B6uiATyk6B/1DooH4Mqlz0oMcA15tRRXuCYjA43xQqokHbVsoWkx5638U
         JjpXaSt8duZuGSYl3aAv73jpt0xE3eIMEnCrfjLShz4nsq98JtPv0HCuTUjPusvYOHhS
         wqyE1xXpysKBlZ38l2YPGNjL6L1GamN+Nt8+bjyG/KZ7AgLrfLwbW2aQdn2pBfCWRgpX
         cngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dyVXlnP2EO7sin30ak6UOPtTEL7Y82rXmT1HaZJEwO8=;
        b=ziv+XmmZZIHx7cSF3Res1UfBBTn5XYMYF3JKWEm7Iu25/3Qq+nR0gP2kcGXjxzV5zg
         Ij02WQHK1EpC4HW8+41NuqsIEGJh1bnliWqSLJ+s6qyLVwYdgzlZGzhnM8gbHEDcejvM
         QMbG3Ti9CoNHJHgORZexI8EyYFWAJs7HIqzqsCAl5S+pAY+uN8CSpsIL5vMbl7arJpV6
         Erhkv2abaa3niJQjN824RxUWY1OKNFrzZ6rvaJg+7+9Mm7y0LPE8Gpe23Fn4qDhW5wgE
         B5XNJ64M+EtjafTQTuu4bIVwWuRlv7xNHIOmixCtnNhAO+XaYeLcW6OAswf507GOWTHS
         ta4Q==
X-Gm-Message-State: AOAM5303oBhh0p5ZsAkTopxupWWHYPFB1E47xPDsq3keciR88h/76gfc
        EarqAaRn2dIplTiHi8Ks0D2OSLcpzGiyJZX+wdc=
X-Google-Smtp-Source: ABdhPJwKILTM9G/OOo7WWONLMHq2ef2R6ySw+NYb6dhPKjGQkfzxEG/W1fih0HC2WwHMp8T9yaPB74McG7c/6kHtQQ0=
X-Received: by 2002:a17:906:318f:: with SMTP id 15mr27839463ejy.206.1633469502753;
 Tue, 05 Oct 2021 14:31:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211002234313.3209294-1-martin.blumenstingl@googlemail.com>
 <1j35pivzho.fsf@starbuckisacylon.baylibre.com> <CAFBinCCCQebCEdLjYAfWkF4NDPdma8UzVMhHOhZPVreoV2qd2w@mail.gmail.com>
 <1jy279uprd.fsf@starbuckisacylon.baylibre.com> <CAFBinCBrYUPOkvJUAiEF9X0Z76ta3jSrKkLkaHvJUaiWNyR0yw@mail.gmail.com>
In-Reply-To: <CAFBinCBrYUPOkvJUAiEF9X0Z76ta3jSrKkLkaHvJUaiWNyR0yw@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 5 Oct 2021 23:31:31 +0200
Message-ID: <CAFBinCBv0GWDUL+WYBU4JAgKgie07m+duxReh2tSopGOHwh4=Q@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/1] ASoC: meson: aiu: HDMI codec control questions
 and issues
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, linux-amlogic@lists.infradead.org,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000076acda05cda1c165"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000076acda05cda1c165
Content-Type: text/plain; charset="UTF-8"

Hi Jerome,

On Mon, Oct 4, 2021 at 11:17 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
[...]
> > This bit could also be a remain of an older design, not really connected
> > to anything meaningful. It would not be the first time.
> >
> > The AIU looks like an IP that has evolved a lot over the years, not always
> > in a coordinated fashion. Some scenario are well supported and easy,
> > others seem to require a magic spell.
> >
> > Last (but not least), in AML vendor kernel, the only time this bit poked
> > is around 8ch support (1 for 8ch, 0 otherwise) ... I have no idea why.
> The 32-bit SoCs use SPDIF to feed 2-channel audio to the HDMI TX
> controller and I2S to feed 8-channel audio to the HDMI TX controller.
> It seems that Amlogic stopped this for (at least some) 64-bit SoCs.
>
> My testing results indicate that AIU_CLK_CTRL_MORE[6] is still relevant.
> I can do another round of testing with various combinations of
> AIU_CLK_CTRL_MORE[6] and AIU_HDMI_CLK_DATA_CTRL register values.
> If you want me to test any specific combinations then please let me know.
I have tested various combinations, see the attached result file
(which can be viewed with "column -t /path/to/results.txt").
The short summary is that...
...I2S output requires:
  AIU_HDMI_CLK_DATA_CTRL[1:0] = 0x2
  AIU_HDMI_CLK_DATA_CTRL[5:4] = 0x2
  AIU_CLK_CTRL_MORE[6] = 0x1

...SPDIF output requires:
  AIU_HDMI_CLK_DATA_CTRL[1:0] = 0x2
  AIU_HDMI_CLK_DATA_CTRL[5:4] = (any)
  AIU_CLK_CTRL_MORE[6] = 0x1

My test consisted of running speaker-test -c2 and playing an mp3 with
ffplay on an Odroid-C1.

In other words: this confirms what we have suspected before.
What is your suggestion on how to model these muxes in the driver?

In the meantime I finally understood what #sound-dai-cells = <1>; does
thanks to your previous hints.
With that I can wire up the I2S and SPDIF inputs to the HDMI TX
controller's "HDMI codec".
Many thanks again for this hint!


Best regards,
Martin

--00000000000076acda05cda1c165
Content-Type: text/plain; charset="US-ASCII"; name="results.txt"
Content-Disposition: attachment; filename="results.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_kuekxzbb0>
X-Attachment-Id: f_kuekxzbb0

QUlVX0hETUlfQ0xLX0RBVEFfQ1RSTFsxOjBdIEFJVV9IRE1JX0NMS19EQVRBX0NUUkxbNTo0XSBB
SVVfQ0xLX0NUUkxfTU9SRVs2XSBJMlMgU1BESUYKKENUUkxfQ0xLX1NFTCkgKENUUkxfREFUQV9T
RUwpIChBTUNMSykgKEkyUykgKFNQRElGKQoweDAgMHgwIDB4MCBzaWxlbmNlIHNpbGVuY2UKMHgw
IDB4MCAweDEgc2lsZW5jZSBzaWxlbmNlCjB4MiAweDAgMHgwIHNpbGVuY2UgcGxheWJhY2sKMHgy
IDB4MCAweDEgc2lsZW5jZSBzaWxlbmNlCjB4MiAweDIgMHgxIHBsYXliYWNrIHNpbGVuY2UKMHgy
IDB4MiAweDAgc2lsZW5jZSBwbGF5YmFjawo=
--00000000000076acda05cda1c165--
