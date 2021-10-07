Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2118B425076
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 11:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237335AbhJGJz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 05:55:27 -0400
Received: from dnyon.com ([82.223.165.189]:43434 "EHLO dnyon.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232475AbhJGJzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 05:55:25 -0400
Received: from dnyon.com (55.red-81-39-194.dynamicip.rima-tde.net [81.39.194.55])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dnyon.com (Postfix) with ESMTPSA id 0E1443FD71;
        Thu,  7 Oct 2021 09:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dnyon.com; s=mail;
        t=1633600073; bh=qd7kluRu5cKVXNfP+NrNpCRiRCxNL9FJkxiisrNtYzM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L7+U4QBwCMGyl+J+gFJ4w569/sVHmCHJ/cv/+NK/69qyg5/UHGmRJDHvJJMKwWcnC
         i/Eiwg7nIWfMrlYeP4c5rVQPR8HE+uc1kaG4HD/a4mB6nnOD1PsUeok00w8M92KHp0
         0RKOFJxTxx9X9AZSiHZ1f24so4LK00CuznGzPWfCLeseF95DgY27uw6UK8bFq7lYEj
         /QHMRxiDPMAMtfjTTVeEIJ9eTkvP/pewzN6VJ5xm/m0c1CWKy8FgiS1aq3fo3Ig0RS
         YlUDZ5eB4klGSH+/V60Ky9S0pHSo47b+5VS+wNF9MjpX6zJnBkAVnYPsYSCqRlEncI
         H+n2TSDTlgISw==
From:   Alejandro Tafalla <atafalla@dnyon.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        =?ISO-8859-1?Q?P=E9ter?= Ujfalusi 
        <peter.ujfalusi@linux.intel.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy
        Shevchenko <andy.shevchenko@gmail.com>," 
        <~postmarketos/upstreaming@lists.sr.ht>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] dt-bindings: sound: max98927: Add reset-gpios optional property
Date:   Thu, 07 Oct 2021 11:47:46 +0200
Message-ID: <5529627.DvuYhMxLoT@alexpc>
In-Reply-To: <CAHp75VdbZmGeCq8A1E3AJU4T39xPUhomzrQqZNaDj8Zi0x9WrA@mail.gmail.com>
References: <cover.1633572679.git.atafalla@dnyon.com> <4682758.31r3eYUQgx@alexpc> <CAHp75VdbZmGeCq8A1E3AJU4T39xPUhomzrQqZNaDj8Zi0x9WrA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/21 9:06 Andy Shevchenko wrote:
> On Thu, Oct 7, 2021 at 5:45 AM Alejandro Tafalla <atafalla@dnyon.com> wrote:
> > On 7/10/21 4:38 Alejandro Tafalla wrote:
> > > Signed-off-by: Alejandro Tafalla <atafalla@dnyon.com>
> > > ---
> > > 
> > >  Documentation/devicetree/bindings/sound/max9892x.txt | 3 +++
> > >  1 file changed, 3 insertions(+)
> > 
> > Sorry, I forgot to add:  Acked-by: Rob Herring <robh@kernel.org>
> 
> And commit messages?

Right, can I resend this patch with the commit message or I have to resend the 
other one too?
-- 
Alejandro Tafalla


