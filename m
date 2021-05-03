Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D6A371817
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 17:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhECPgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 11:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhECPgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 11:36:22 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B35C06174A;
        Mon,  3 May 2021 08:35:28 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id y7so8492483ejj.9;
        Mon, 03 May 2021 08:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W1PWtzVUy7B6825OBB8ZeJD50r7eCh8stJaf1S2Tnn8=;
        b=DPd6o4YVw63v43ugoINIMP0Ns66RGzJvKqhUadTCA8FuU/iB9p2ZqNQq62YrKsHTvT
         9AEj5CDTQ3gwQrkc1EVmBqlveECEMlVraM3rNteXlGjPJ1TTNImot4LuY1rYljRU1gZM
         Qz0Wc7DPGfQqMktWYey9kXh+z8ZRzBwWrsEL6SSdtw5EumTgv/HJwsJtWNxJbi2U2Rit
         nlpkrraMLBWwsIUCLNZIDZsoQwMZU9A5OIyXExN95FsRvZ6pBUBF+KEMA0dJRuj7bj/V
         m02Bqgu8sVJ1C+SoB2ri07UumjMy7hWw2haLuaWykF6fCtwQlgG4+yMm9SJ2EqhwEGkB
         zHAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W1PWtzVUy7B6825OBB8ZeJD50r7eCh8stJaf1S2Tnn8=;
        b=kJFfNryaRz9VeNa/EvAKJv0fNJQ8pc1c1Rf5tkrul7N/1OpiJnYW2WXFvErrMMTr8K
         YLocCzeQMA1D2AYC1ny5VJuDWrWtg5xR0L0jCz3eIRR5W0gYvffJk9HbHI6LIHNEsB2K
         lxSaLL8U1zGBomw1M4Mv6nT4bmV2p4taIjs7j4XEZBRnaJ+TdwTp5KKdmX30FsXHB3mV
         zwU/mee7MLfr5rkR0SZpndCFQAI/CMPgHn6JV9buHvLeEToJ8QdCbyZ6/Gr6z6F8MFFy
         cp4Ai+DrQEHwfqtOBXfyBbnJNjt3LcYCQi+FqD8xmZWylq0yjBorkTEDZryGLlASH9s0
         ofjw==
X-Gm-Message-State: AOAM530FZHUi1EdobUTmIU6gISWVr888SGhi3o34v7SZCRX725QQivYl
        afY1ojKWKhynDqRWnJw82V/b1ug1OJQvUmJff3A=
X-Google-Smtp-Source: ABdhPJxxcjijY0bRqQKCJgp4M/RuYW0jeM1Agfsa6Rq7dQx5YhS78mT2TIp017G6Mw3vCdMTOaIH+XJquptSAP1NzyY=
X-Received: by 2002:a17:907:2bc7:: with SMTP id gv7mr17236354ejc.187.1620056126503;
 Mon, 03 May 2021 08:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210503145503.1477-1-linux.amoon@gmail.com> <20210503145503.1477-4-linux.amoon@gmail.com>
 <CAFBinCCxMvomKt9E0jT_XXpyL1_-qXH4=zVDMNdbDCnZCsnT=A@mail.gmail.com> <CANAwSgTdFHwtKd-sgQq0Jp8WP55fZG3wsn7feCGo257yqiFkpw@mail.gmail.com>
In-Reply-To: <CANAwSgTdFHwtKd-sgQq0Jp8WP55fZG3wsn7feCGo257yqiFkpw@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 3 May 2021 17:35:15 +0200
Message-ID: <CAFBinCDUc7VG7T9c8snP4ujMMViS0GRdztP6QGJvF9LNESHHCw@mail.gmail.com>
Subject: Re: [PATCHv1 3/9] soc: amlogic: meson-ee-pwrc: Add hdmi power domain
 Meson g12a SoCs
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

On Mon, May 3, 2021 at 5:29 PM Anand Moon <linux.amoon@gmail.com> wrote:
[...]
> > > +static struct meson_ee_pwrc_mem_domain meson_pwrc_mem_hdmi[] = {
> > > +       { HHI_MEM_PD_REG0, GENMASK(15, 8) },
> > > +};
> > > +
> > the VPU power domain already includes:
> >   VPU_HHI_MEMPD(HHI_MEM_PD_REG0),
> > whereas VPU_HHI_MEMPD is bits[15:8]
> >
> > Having two power domains which are managing the same registers sounds
> > like it'll be causing some trouble
> > So for now this is (as I am not even sure what the goal here is):
> > NACKed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> >
>
> Ok, thanks. On the line of Ethernet PD, I tried to add this accordingly.
From what I understand the VPU power domain is special because the
display pipeline consists of multiple components (HDMI, VPU, ...)
that's why the handling currently is special

> whenever I try something new it fails. Please ignore this series.
if the VPU and HDMI power domains were separate (from hardware
perspective, not from driver perspective) then your change is a good
step forward.
in that case VPU_HHI_MEMPD would need to be removed from wherever it's
currently used -> that means we need to also decide if we want to
break compatibility with older (before this series) .dtbs


Best regards,
Martin
