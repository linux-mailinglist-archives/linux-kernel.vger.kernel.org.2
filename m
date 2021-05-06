Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818E2374DD7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 05:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbhEFDMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 23:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbhEFDMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 23:12:45 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF38C06138A;
        Wed,  5 May 2021 20:11:47 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id v20so3731964qkv.5;
        Wed, 05 May 2021 20:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zc0foFEf07MuR8qaneLKD/X5hm20pyFwaRxV9GZ2KfE=;
        b=CH99u9WVl9l1o63moek4ExybUAXX8763nmXJ5/Z5YVN/q/eG9n7M59QFu65Nur6BVi
         DxSvwonY4ZLUUg/zcqMyYf6AJTCQFo7WcraaUP5cJqfcdFEVPUdESMz6EHerT9nESQJz
         4CZag33e3hOmTBECqQTuR7ktZOW35p2j/JGI3ReqdO0IrrdUW5wGXFxPI2DXeUwmr9Uz
         ZVg7VCxmtFdnUQwqCbgIzggJl/34Txn+StQYkzftXBiuSA6lNRnlEoXGk7y0W6/OK/Rb
         ndSoITm1Z/uSH4b8RNu7EB2qJAfitv0RLtLMWtlhFSJFh7ltcbAJNJzXr/p6C2PkYa1p
         +qJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zc0foFEf07MuR8qaneLKD/X5hm20pyFwaRxV9GZ2KfE=;
        b=jpy4TSgk6GUwU6OrIC2KAbQN14BNx3xODFcLBpDZBurnmezHvlT61Dq3v+6b5OPQz9
         kx3Nz3L9ekIbytW085ueD/Qak1IyDWuZ5DSA2LlEHkYooNoXG/u6I4MtOi5FE2DXFql0
         vAdoDyTVDGLsM3WqCQKTS0VTo6SjV0t8UOui8/BVF/ixYsDK+ZuNj/nM9LojZV4Iw+Pn
         4xtVJj+1F7KhKQ9RpD0OD7QNMSM9d2icHkUWQ8AcrPC4zTkr3RNO5TQlklJHQzhOPzLE
         B4Z6LYZhWMV2jL2XqUiBjhIBhjmj2UtzYnU6k/X5mCRtQx/uIBG70bxXrRd/1qfX3ZIm
         s44w==
X-Gm-Message-State: AOAM531xozYzNZLYtUDt2xNQuShJhfj84h/xpPzDkHt2BwPUF5s5WDsI
        sLVinpd56s55X/sba/ejOPdtP8/H9PB8f+bH09Kpl4Id
X-Google-Smtp-Source: ABdhPJyaDpHlAXmnOf7gjN0KdB/9SHzvyjBkqysUTMm4Kuy0d74TwTnGSBPrzWEgPu3aDsd+dk34EaKl4dU9u1V/SHc=
X-Received: by 2002:a05:620a:2903:: with SMTP id m3mr1924718qkp.37.1620270707000;
 Wed, 05 May 2021 20:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <1619664627-12470-1-git-send-email-shengjiu.wang@nxp.com>
 <1619664627-12470-2-git-send-email-shengjiu.wang@nxp.com> <CAOMZO5A3-GjEv_U4RmQXz__s=SmHkkJid-DXxr2Om6pB6_imAg@mail.gmail.com>
In-Reply-To: <CAOMZO5A3-GjEv_U4RmQXz__s=SmHkkJid-DXxr2Om6pB6_imAg@mail.gmail.com>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Thu, 6 May 2021 11:11:36 +0800
Message-ID: <CAA+D8ANC_J8gHcKs2YVCv3efUimb-dq6uTcGM=252N0jMg5ctQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: imx6qdl-sabresd: Configure the gpio for hp detect
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 3, 2021 at 10:38 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Shengjiu,
>
> On Thu, Apr 29, 2021 at 12:06 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> > +               pinctrl_hp: hpgrp {
> > +                       fsl,pins = <
> > +                               MX6QDL_PAD_SD3_RST__GPIO7_IO08          0x80000000
> > +                               MX6QDL_PAD_GPIO_9__GPIO1_IO09           0x80000000
>
> Please avoid using 0x80000000. Use the real PAD_CTL value instead.

Ok, will send v2.

best regards
wang shengjiu
