Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04CAA42C27D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 16:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbhJMOOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 10:14:52 -0400
Received: from mail-ua1-f53.google.com ([209.85.222.53]:43830 "EHLO
        mail-ua1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhJMOOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 10:14:50 -0400
Received: by mail-ua1-f53.google.com with SMTP id i22so4727393ual.10;
        Wed, 13 Oct 2021 07:12:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=//wmfsyzKN6sJRRuiRVe+9SYGGdywfnaIIbc8fN2K7Q=;
        b=oyT3vF27MSFthurAT5RuDd/pFQfLtivjkLhrFCEjqTdFDDCIgsxWDWVXjfLc5MnIyD
         f7SsTZ/4vNrbfPjZVHNKS7rDrVzcQtBnTFux9Qyh2n3N/Yz9b4ApS8LCF687E4gI8tRA
         Q88cqVgA/hDWzhX9yVdj4Muh2E7Viwp/F1J3QViBIcGDn2JogvWKiKmUnEZuYTuzRuix
         GurD9H8Wo5BGxeNf2SbXC1yMa3Iao3mHn8ugKkG8tNHcTQphJeg+qTauVvAnU7CLyEFr
         zrpCE1FQqUFq5f2KcsAYkYWCUv+P9F7G63cnSlU8FGsQC+tW2TA0lxqg9qgs92+Aw7YN
         5d9w==
X-Gm-Message-State: AOAM533/q7dCH9tFjhblk4sJl8jTH8/+mliWCv3lqiYTV5hYnUo6vnxL
        zpG6plIyCCS+meZ7eFPxkVl3mQQaNtXlV20G1ss=
X-Google-Smtp-Source: ABdhPJygQZTdnnxtn8/RdCByAxCkJnr3ICGmYP0XCgAaXRUmsyM4Ot4y+nF6DbYBk7d7NqHTmTxXiSc8WNrzdFRyx/8=
X-Received: by 2002:ab0:311a:: with SMTP id e26mr30390992ual.122.1634134367074;
 Wed, 13 Oct 2021 07:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210914200539.732093-1-paul.kocialkowski@bootlin.com>
 <20210914200539.732093-3-paul.kocialkowski@bootlin.com> <YUtBkOFeQWnteG5L@google.com>
In-Reply-To: <YUtBkOFeQWnteG5L@google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Oct 2021 16:12:35 +0200
Message-ID: <CAMuHMdWO2AhtMwtq+QkAO7nLs+AQjt=fQ0JoSag3B+uRQj-o-w@mail.gmail.com>
Subject: Re: [PATCH v9 2/4] dt-bindings: mfd: logicvc: Add patternProperties
 for the display
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On Wed, Sep 22, 2021 at 4:46 PM Lee Jones <lee.jones@linaro.org> wrote:
> On Tue, 14 Sep 2021, Paul Kocialkowski wrote:
> > The LogiCVC multi-function device has a display part which is now
> > described in its binding. Add a patternProperties match for it.
> >
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  Documentation/devicetree/bindings/mfd/xylon,logicvc.yaml | 3 +++
> >  1 file changed, 3 insertions(+)
>
> Applied, thanks.

Unknown file referenced: [Errno 2] No such file or directory:
'.../dt-schema/dtschema/schemas/display/xylon,logicvc-display.yaml'

as 1/4 hasn't been applied yet.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
