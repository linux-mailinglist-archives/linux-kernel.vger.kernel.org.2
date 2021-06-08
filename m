Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D1B39F3DD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 12:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbhFHKpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 06:45:19 -0400
Received: from mail-vs1-f47.google.com ([209.85.217.47]:45682 "EHLO
        mail-vs1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbhFHKpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 06:45:17 -0400
Received: by mail-vs1-f47.google.com with SMTP id y207so2230638vsy.12;
        Tue, 08 Jun 2021 03:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xSpARCXEY9r5sC5PxBnmVPG/+mNFD4xLIb8KPhmPVtE=;
        b=msVMQRl3rRY6vtpEbar3uxySaGsAwi4O06HjvPIMV4Ej+WbanGLgEGHfXDwhwhQ/UC
         5lzmaiu5ZmICYnZkxFT6PgzCC/JhTTYI1tYdF+LzdYRCWSZoyfQn0O04ijkrA5y9GsuA
         o1bvIWyxsLIUIJLn0eRoLDjScz6qSnbbmoKW07t4qEXlA4D6CI9ZV5KXaQI+qpCmcK6Y
         CNjLI2MNAshSD9ZPsS98WfCarppqgkPCBw6POizJSGfD8HxOkHVc3HIc0xrhUmgEntid
         7M1VT1cxfj/cXJAgyJRF/fhgp70iSj712QHtwU2TxOkI4upubdxMekP11GkYSk8xWj8T
         P5mA==
X-Gm-Message-State: AOAM531it0qq37kRjsbBkj60GemI9QvmZr3lrJUel0El+U5TwnspU+Xi
        FSy47S1vkIIngx+cRMAc/cKjAY0/qmfvBNOWZyk=
X-Google-Smtp-Source: ABdhPJyWVn2KezQdjunvFca9KXFsmRggMf0glvDI0gjObu5ODDYPdSBPHjvrB8I0zR1cpmXLdpUxBUw5zDVm7Os6A+8=
X-Received: by 2002:a67:f106:: with SMTP id n6mr7769858vsk.40.1623149004456;
 Tue, 08 Jun 2021 03:43:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210603110315.81146-1-colin.king@canonical.com>
In-Reply-To: <20210603110315.81146-1-colin.king@canonical.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Jun 2021 12:43:13 +0200
Message-ID: <CAMuHMdV0kOjRo6DBksoaLBuXrw_BiUaF6e6DOj9OwSjrs405pw@mail.gmail.com>
Subject: Re: [PATCH][next][V2] ASoC: rsnd: check for zero node count
To:     Colin King <colin.king@canonical.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

Thanks for your patch!

On Thu, Jun 3, 2021 at 1:05 PM Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Most callers of_get_child_count() check that "nr" is non-zero so it

Note that there is no longer a call to of_get_child_count(), as of the commit
referred to from the Fixes tag below.

> causes a static checker warning when we don't do that here.  This
> does not cause a problem or a crash, but having zero SSUIes does not
> make sense either so let's add a check.
>
> Addresses-Coverity: ("Unchecked return value")
> Fixes: c413983eb66a ("ASoC: rsnd: adjust disabled module")
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
> V2: Rephrase commit message based on Dan Carpenter's suggestion.
>     Thanks Dan!


Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
