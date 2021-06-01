Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3817639767D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 17:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbhFAP0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 11:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233924AbhFAP0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 11:26:03 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F15C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 08:24:22 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id j15so1282071vsf.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 08:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SHY1Su43K3ELrQR9CrBAbBOQHJtxQOdLocpoZ2X7Ng8=;
        b=FkPjp6FbTjUVq0pXGa6pXaYuNulBbgZ3zjSZhG9UJqpFTSCH8y84SKHJER94xQE4Cn
         cykpvCo8tmeqKzyTSGAEvcES7HBlyJ+TBL+c9dqLUIAeiIt66tj6Feg42qZca/cWLFrP
         8IXz2k7nKsD/90QvJiwFL8082iMK1XOCW7vdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SHY1Su43K3ELrQR9CrBAbBOQHJtxQOdLocpoZ2X7Ng8=;
        b=N5Bqbl6plh/v+xvxEnRRinGZSYj/Rqep54hYogyu0E0S1P9/ehm0ZtD3AVfjfaHC5G
         fWrnNcP0/fajdCS+OBJ5JXaNb2uDfty7dej9GrlDsnLaKhPRZ3amb8sHaIusSvFvOa/E
         sD5onayos8j/cPvvDIyG0g8Bs/tgls0ye3DpCIPtt+zgugno/2KVFTQUGaM2vrR86Wfc
         uMIoLbtVQFv6Epq7etHXL1Be5f8iWefOYWnPG0kQRQ6n3sfqjOcGhcUAjC4ahknNh2BI
         JG02rVn+hpTR6NIrV/hvWsAn2i3Ns6h9c2SENe80ABzk3kwVocWpde34Nmjtx5aGYSAB
         2CrA==
X-Gm-Message-State: AOAM532ac2R4s5zacD0gytcsQHH0D/YQaN0S068HnNb+vQlgXbgZRLei
        Lz4u2OnwWCrBkBlwPQzs0JgDtkguDL1jtg==
X-Google-Smtp-Source: ABdhPJwc4LzHyMStjUZSX2qFz2SUpXHZCFOj0AF/G3tlLoKxHGhubTgw59GnNxPTI6plx55dGT2S4A==
X-Received: by 2002:a67:ec4f:: with SMTP id z15mr19115950vso.27.1622561061186;
        Tue, 01 Jun 2021 08:24:21 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id m187sm496371vsc.15.2021.06.01.08.24.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 08:24:21 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id x1so8675801uau.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 08:24:21 -0700 (PDT)
X-Received: by 2002:a25:6088:: with SMTP id u130mr40579283ybb.257.1622560637314;
 Tue, 01 Jun 2021 08:17:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210524142114.18676-1-srivasam@codeaurora.org>
In-Reply-To: <20210524142114.18676-1-srivasam@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 1 Jun 2021 08:17:06 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X+3qP3uj2AVkejmVBmMYqWAxMCS7HBRSkKcPgwP0XGdQ@mail.gmail.com>
Message-ID: <CAD=FV=X+3qP3uj2AVkejmVBmMYqWAxMCS7HBRSkKcPgwP0XGdQ@mail.gmail.com>
Subject: Re: [PATCH v3] ASoC: qcom: lpass-cpu: Fix pop noise during audio
 capture begin
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Judy Hsiao <judyhsiao@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, May 24, 2021 at 7:21 AM Srinivasa Rao Mandadapu
<srivasam@codeaurora.org> wrote:
>
> This patch fixes PoP noise of around 15ms observed during audio capture begin.
> Enables BCLK and LRCLK in snd_soc_dai_ops prepare call for introducing some delay
> before capture start and clock enable.
>
> Co-developed-by: Judy Hsiao <judyhsiao@chromium.org>
> Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> ---
> Changes Since V2:
>         -- Updated comments as per linux style
>         -- Removed unrelated changes.
> Changes Since V1:
>         -- Enableed BCLK and LRCLK in dai ops prepare API instead of startup API
>         -- Added comments
>
>  sound/soc/qcom/lpass-cpu.c | 54 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 53 insertions(+), 1 deletion(-)

Presumably related with Srinivas Kandagatla's comments: this patch
causes a bad splat at bootup. Specifically, here's what I saw when
this patch was in the Chrome OS 5.4 kernel:

------------[ cut here ]------------
lpass_audio_core_lpaif_pri_ibit_clk already disabled
WARNING: CPU: 0 PID: 2066 at drivers/clk/clk.c:958 clk_core_disable+0x4a0/0x670
CPU: 0 PID: 2066 Comm: cras Not tainted 5.4.122-lockdep #4
Hardware name: Google Lazor (rev1 - 2) with LTE (DT)
pstate: 60400089 (nZCv daIf +PAN -UAO)
pc : clk_core_disable+0x4a0/0x670
lr : clk_core_disable+0x4a0/0x670
sp : ffffff81727cf8a0
x29: ffffff81727cf8a0 x28: 1ffffff033d2b8d5
x27: dfffffd000000000 x26: ffffff81a3781980
x25: 1ffffff03493d3b3 x24: ffffff816f433480
x23: dfffffd000000000 x22: 1ffffff035b66e2f
x21: 00000000ffffffff x20: ffffff81adb3717c
x19: ffffff81adb37100 x18: 0000000000000339
x17: ffffffffffffffff x16: 0000000000000006
x15: 0000000000000001 x14: 0720072007200720
x13: 0000000000000000 x12: ffffffd0132c1e00
x11: 0000000000000001 x10: 0000000000000000
x9 : cff2cb5e2cb22e00 x8 : cff2cb5e2cb22e00
x7 : ffffffd010288f74 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001
x3 : ffffffd010429d10 x2 : 0000000000000001
x1 : 0000000000000008 x0 : 0000000000000034
Call trace:
 clk_core_disable+0x4a0/0x670
 clk_disable+0x50/0x64
 lpass_cpu_daiops_shutdown+0x190/0x204 [snd_soc_lpass_cpu]
 snd_soc_dai_shutdown+0x8c/0x9c
 soc_pcm_close+0x258/0x478
 snd_pcm_release_substream+0xfc/0x1e8
 snd_pcm_release+0x8c/0x124
 __fput+0x1e4/0x4fc
 ____fput+0x1c/0x28
 task_work_run+0x12c/0x164
 do_notify_resume+0x1e04/0x2c48
 work_pending+0x8/0x14
irq event stamp: 101552

-Doug
