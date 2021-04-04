Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97923538D6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 18:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhDDQZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 12:25:17 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:44010 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhDDQZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 12:25:15 -0400
Received: by mail-lf1-f42.google.com with SMTP id m12so14238819lfq.10;
        Sun, 04 Apr 2021 09:25:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc
         :in-reply-to:references:mime-version:date:user-agent
         :content-transfer-encoding;
        bh=Cc9OZ3/HdSn1w5+QMW7ijody6XT1pbnxnHm8ChXhshQ=;
        b=a7yw9NQ2LN9NhQTWR0+FHreisYU7xmyNIRRiw4VEDKbvMrYHIUy4Bbj06TsiX3mg0e
         prgwnIiYfX64jsV2Y8YsFojW10EIx2lS/tgKJn6fK4m45qTl5dZNNOy1xFnBS2bAg8bZ
         ygI4zrSI5doV9piArMpJPQeWZSt9tgaqnhfA+AjnQhCcakFLWWHDialoqrMg1oFG5BtM
         vogTo4O8JT88agpyRXFXqYyCy65J4fXgHZGk6gSvrVNETmTrB3bCBi8V/iPj9elI9Lvj
         syWet4DTFbRBHX+LIKRDiTqzj3ZeTA7G4dJo3huDHZYwSmrY72tSJ2eEz67etH4ryRYG
         Ar4Q==
X-Gm-Message-State: AOAM532zmLJNNuikrXagYXv1tOz7IUbAh4HxoJ5ZB2JDNwTfjR3L+yre
        rFCLDwrScy5gWKvbc+DKb2w=
X-Google-Smtp-Source: ABdhPJxk4cwLvVS6RMIMc0MFzuh8DsyfON1dX7i3o9nR4Zqode/DpW8+nP7EdHsyzJZM1KCcELMyDA==
X-Received: by 2002:a05:6512:3996:: with SMTP id j22mr14708771lfu.267.1617553508518;
        Sun, 04 Apr 2021 09:25:08 -0700 (PDT)
Received: from dc7vkhyyyyyyyyyyyyydy-3.rev.dnainternet.fi (dc7vkhyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::6])
        by smtp.gmail.com with ESMTPSA id h62sm1484015lfd.234.2021.04.04.09.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 09:25:07 -0700 (PDT)
Message-ID: <46d07779766f80162ab42ad20b529973df293cc8.camel@fi.rohmeurope.com>
Subject: Re: [PATCH v5 16/19] regulator: bd71815: use ramp-delay helper
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reply-To: matti.vaittinen@fi.rohmeurope.com
To:     Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-power@fi.rohmeurope.com
In-Reply-To: <20210402190211.GJ5402@sirena.org.uk>
References: <cover.1617020713.git.matti.vaittinen@fi.rohmeurope.com>
         <31db9c2bf1e9e1883d8caf4bf3b90475a8a1166e.1617020713.git.matti.vaittinen@fi.rohmeurope.com>
         <20210402190211.GJ5402@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Sun, 04 Apr 2021 19:19:21 +0300
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2021-04-02 at 20:02 +0100, Mark Brown wrote:
> On Mon, Mar 29, 2021 at 04:00:13PM +0300, Matti Vaittinen wrote:
> > Use generic regamp ramp-delay helper function instead of
> > implementing own.
> 
> This is patching something which was just added in the previous
> patch...
> 
> Acked-by: Mark Brown <broonie@kernel.org>

Correct. Reason was that I weren't sure if the idea of adding ramp-
delay helper was accepted. If it was seen as bad idea, then just
dropping this patch would have left the BD71815 with in-driver helper.

Best Regards
	Matti Vaittinen

