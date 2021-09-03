Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE59840046D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 19:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350356AbhICR7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 13:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348537AbhICR7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 13:59:34 -0400
Received: from dnyon.com (unknown [IPv6:2001:ba0:1800:12f::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1542EC061575;
        Fri,  3 Sep 2021 10:58:34 -0700 (PDT)
Received: from dnyon.com (55.red-81-39-194.dynamicip.rima-tde.net [81.39.194.55])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dnyon.com (Postfix) with ESMTPSA id 3159E3FEB7;
        Fri,  3 Sep 2021 17:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dnyon.com; s=mail;
        t=1630691912; bh=ErtwNa/frJs0yBr+aZbsmsBfg5pYbwl7hzB9MOn20n0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TPS2lJvySiAaJLDIxC8jYRFF1OVe9bIBK1DyVVKTC5CK8YNSR/iciif60ega/XNU3
         odwuWx1FCt0IogCzaoLPaBU16oK5TWH3OCHQX0Zp5TE5KCejm9N4kgE+xnU4XIM5LR
         RlcA4Hvr+mv/CTunhAhZYtb1bPHE7Y1gE4BViItrPrNEY5k5/CAc2HyA3p06GsWiLc
         gelO9JLIFYTC956XumJiLlMnEI1rQyPop+7vcVTGtJJU0oXpVYWunrvjwc238LQNpw
         kO1+i2MArSuL4dXTHZE78b9l6LRpIgO57zXBmuBmvO/5cJklKroTA/1J5rF48p712M
         Gyq6cS/42t+Ww==
From:   Alejandro Tafalla <atafalla@dnyon.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: sound: max98927: Add reset-gpios optional property
Date:   Fri, 03 Sep 2021 19:58:13 +0200
Message-ID: <5749833.lOV4Wx5bFT@alexpc>
In-Reply-To: <YTJeMGMAeRjmI5Mu@robh.at.kernel.org>
References: <cover.1630632805.git.atafalla@dnyon.com> <102ae6df3b5398e8c66b954ac5e13a9d565fab6f.1630632805.git.atafalla@dnyon.com> <YTJeMGMAeRjmI5Mu@robh.at.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/21 19:41 Rob Herring wrote:
> On Fri, 03 Sep 2021 03:49:51 +0200, Alejandro wrote:
> > From: Alejandro Tafalla <atafalla@dnyon.com>
> > 
> > Add the reset-gpios as an optional property because some devices might
> > not need it to work properly.
> > 
> > Signed-off-by: Alejandro Tafalla <atafalla@dnyon.com>
> > ---
> > 
> >  Documentation/devicetree/bindings/sound/max9892x.txt | 3 +++
> >  1 file changed, 3 insertions(+)
> 
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
> 
> If a tag was not added on purpose, please state why and what changed.
Okay. I was gonna send another version so I'll add it there.

-- 
Alejandro Tafalla


