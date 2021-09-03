Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6C84002D6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 18:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349880AbhICQD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 12:03:59 -0400
Received: from dnyon.com ([82.223.165.189]:56386 "EHLO dnyon.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349871AbhICQD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 12:03:59 -0400
Received: from dnyon.com (55.red-81-39-194.dynamicip.rima-tde.net [81.39.194.55])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dnyon.com (Postfix) with ESMTPSA id A26DF3FEB7;
        Fri,  3 Sep 2021 16:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dnyon.com; s=mail;
        t=1630684977; bh=VuoVMOLwXT0Lrus8Yp/9d+LE+TbVeNBkpQ5C8cJGLps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tHJSW7ZU6Fcphf5XNe2FSJmR6LOj0T/zjndyINcu+XJyJtUBy+tk/f3K4bx8jVDoB
         LS6j6fXu4AX3jDsTZ1tEyoKbR7NBKXDfeLyDzbF9xpMXEyvsfkpMuE7fJHxINvChAd
         3dVDJwl2DDSRjjCs9sgk/KYq7ZtyZyv9HBpldJwjbMhqiu0E/IjU0ZFxCTke+Ve2Pc
         g7Y4yeFgN9crDm+ftU5GR45/CUsH9BN8oY/5LTM3GBKJ9YErqYE+lC0hA5r0Wt9m4G
         UKWAY6tvTScd87I7ubAfN8wvnLAbONCGnleZi1Chn4a97oBJe4Ixsp5YMmECwtNaeS
         gyJ7UYI7erG+A==
From:   Alejandro Tafalla <atafalla@dnyon.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] Add reset-gpios handling for max98927
Date:   Fri, 03 Sep 2021 18:02:36 +0200
Message-ID: <2103571.irdbgypaU6@alexpc>
In-Reply-To: <CAHp75VdOw7fS055q9eccm9dP9nuAK8rcLXf4vuzA=-UnbqoUfQ@mail.gmail.com>
References: <cover.1630632805.git.atafalla@dnyon.com> <CAHp75VdOw7fS055q9eccm9dP9nuAK8rcLXf4vuzA=-UnbqoUfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/21 10:16 Andy Shevchenko wrote:
> On Fri, Sep 3, 2021 at 4:51 AM Alejandro <atafalla@dnyon.com> wrote:
> > The max98927 codec on some devices (i.e. Xiaomi Mi A2 Lite phone) require
> 
> requires
> 
> > hardware-resetting the codec by driving a reset-gpio. This series add
> 
> adds
> 
> > support for it through an optional reset-gpios property.
> 
> Where is the  changelog?
I'll fix the typos and add previous changelogs in the next version.
Thank you.

-- 
Alejandro Tafalla


