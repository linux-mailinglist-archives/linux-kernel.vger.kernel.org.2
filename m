Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07451346EFA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 02:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhCXBpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 21:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbhCXBoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 21:44:39 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BEFC061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 18:44:38 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id u8so352863qtq.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 18:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ptioshG+2dIFNP/OQB4kxeiMvcEgTk3PcQJ8b1Wlui4=;
        b=jxs+sx48jY9q1YOqNTS5XanF/iwJIMQahFq2kPojEMaYK2PVxwqZlQhUeIqPn6uX+C
         uPd3UPHLHesuU6uyioUWJWdwhVeHFDdNbab/L6NbQbZorUVtrC3fGAW7AT2gyb7OeFF7
         a0pJXJsE5K78tzkjvzGrY5tGpnGP2QWLYAEbR9MO+xUg4OnhYuwlkpGuUHnGxvW1Xf0F
         Njq7V77lwVapKjMUz+PdZmbY7AiY+4DrD8v2Rb6cChRjFlqPzU5BBy9+ZnZ9lA8qYlrO
         PtHItO/31nOvGJcKnCH54eqozZTWHuW9qz/dphkZ1DkvgZtYK1gVdV9FZoNYRgphoLvR
         4RWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ptioshG+2dIFNP/OQB4kxeiMvcEgTk3PcQJ8b1Wlui4=;
        b=d1puZEwhYpDOhRvv51zO1KvOoalZFRXGjxUDNBW4ijSr4uitCpEH0P2jsvEZPltkp7
         iOd26eIrR/jUiMoE7g3gobrbkSkhA+u4+uWDO71/Yqe6c44JgBCBJKspdA/jwRIcXT5H
         A0NLK7ck0tgd9wtw5L6fQ/88xIAlN2fkdpomsI7Jw9U5/WMwHs4+GK/jaVdOBcWfRWpi
         5/zwtqoMTfM3GR7tbkI3p8YofbSCom5+IqgYGbgfpWIrSI2M9VHW+qcN4J+dXoLtj+TG
         K7Ka18JNaY5B7sopnBC3RsmIj8Tx3p4iELzUPeU5tXdLvvH/klKhast1gMDsqWxK7wvT
         8Xuw==
X-Gm-Message-State: AOAM533CLNPwCavS5FS2be5XzgMHGtYX+nuZased4+EV3embR35dQRnF
        O7GsKyjcyWrOmTNqf0sLRmBDVROBUg1/I1YS4OE=
X-Google-Smtp-Source: ABdhPJxKcSdyS8HdLo4YR2hVKK5rxuhzXy8eprlF7YHHz/jSjMiCSwpeP9ucbyty5m4+XA51q4tdpxfvnQwtNvV9v2w=
X-Received: by 2002:a05:622a:454:: with SMTP id o20mr1067602qtx.292.1616550277946;
 Tue, 23 Mar 2021 18:44:37 -0700 (PDT)
MIME-Version: 1.0
References: <1615341642-3797-1-git-send-email-shengjiu.wang@nxp.com> <20210310132404.GB4746@sirena.org.uk>
In-Reply-To: <20210310132404.GB4746@sirena.org.uk>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Wed, 24 Mar 2021 09:44:26 +0800
Message-ID: <CAA+D8ANXcyJ+GrEqTNuoNJ4wGCQfqjRkhcevt-eXSrNj_V128w@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] ASoC: wm8960: Remove bitclk relax condition in wm8960_configure_sysclk
To:     Mark Brown <broonie@kernel.org>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        patches@opensource.cirrus.com, gustavoars@kernel.org,
        Takashi Iwai <tiwai@suse.com>, daniel.baluta@nxp.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark

On Wed, Mar 10, 2021 at 9:26 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Mar 10, 2021 at 10:00:42AM +0800, Shengjiu Wang wrote:
>
> > changes in resend v2
> > - Add acked-by Charles
>
> Please don't resend for acks, it just makes for more noise.

ok, but could you please review this patch?

Best regards
wang shengjiu
