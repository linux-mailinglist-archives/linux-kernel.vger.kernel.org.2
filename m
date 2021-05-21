Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65C438BBF2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 03:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237747AbhEUBvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 21:51:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:36690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235589AbhEUBvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 21:51:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DFE916135C;
        Fri, 21 May 2021 01:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621561808;
        bh=S7/3ff93Mj7sM1z6GZwcsvA1idQokUB7jGPPhwZLJBA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G/KXauU52TYA4HxENirxJuGXo8MgQI8QIF+C1PL0s+rd2Fh7xiVeMixAlwk9503oP
         2ytvSAkJdBOadITWFLN1EBi970UCgynkB1MSQUg612WbCglj+W1NiLaC84QLEON1aa
         U6dNKPWnZR262YAdgjAPDwA83swrSQfL5rZlRC2PxmE0H2tXIAMfzXI5V2GeluD6xY
         PGffkHS0WIosbGC5uOKWbcrTmk05pL/Z2EKKY478fnjdneN5NuqEV6sxZPmLUPSw8p
         Ald7xKougASVjGmwtWNhpocfbD1G3eXBRVr7eZeMZF+/ebE5kUtCLOztUVKH/Womx+
         f8epUhwLbed4g==
Received: by mail-ed1-f44.google.com with SMTP id r11so21487956edt.13;
        Thu, 20 May 2021 18:50:08 -0700 (PDT)
X-Gm-Message-State: AOAM532Cx9eQZPGT+K+5YYiboneRY+eGENlu+S2qWf41GQm0VAAE9vPk
        dqGvQsHUNLKOwd6uIWj4P2Dazi/nx9QMd76d5w==
X-Google-Smtp-Source: ABdhPJyKCSeOAVSGMjIYxJSecYUm/pYxze27Ok54E4R02URqRmpRfqNw7bo+yG8CEi2WwQh8Saw5JM/Y2gnTWv0YUPs=
X-Received: by 2002:aa7:cd83:: with SMTP id x3mr7909049edv.373.1621561807474;
 Thu, 20 May 2021 18:50:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210519161847.3747352-1-fparent@baylibre.com> <20210521014815.GA2476751@robh.at.kernel.org>
In-Reply-To: <20210521014815.GA2476751@robh.at.kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 20 May 2021 20:49:56 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+HWxQwFuKM==g-PBROxGN_xoWCc060U0pDpsDdfWJWPg@mail.gmail.com>
Message-ID: <CAL_Jsq+HWxQwFuKM==g-PBROxGN_xoWCc060U0pDpsDdfWJWPg@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: arm: mediatek: mmsys: convert to YAML format
To:     Fabien Parent <fparent@baylibre.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 8:48 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, 19 May 2021 18:18:44 +0200, Fabien Parent wrote:
> > Convert the mmsys bindings to the YAML format.
> >
> > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > ---
> >  .../bindings/arm/mediatek/mediatek,mmsys.txt  | 31 ----------
> >  .../bindings/arm/mediatek/mediatek,mmsys.yaml | 57 +++++++++++++++++++
> >  2 files changed, 57 insertions(+), 31 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> >
>
> Applied, thanks!

Actually, should go with patch 3. So dropped and:

Reviewed-by: Rob Herring <robh@kernel.org>
