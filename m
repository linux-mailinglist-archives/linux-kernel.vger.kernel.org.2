Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672003EEAC2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 12:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236416AbhHQKRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 06:17:34 -0400
Received: from mail-yb1-f177.google.com ([209.85.219.177]:37860 "EHLO
        mail-yb1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234895AbhHQKRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 06:17:33 -0400
Received: by mail-yb1-f177.google.com with SMTP id r4so15549635ybp.4;
        Tue, 17 Aug 2021 03:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gxMsR1IWBs0Lk61k0jAWpBrlAFrzQnrb9nCTFB3yrx4=;
        b=spDegW/oXy0VQOv1PpveTMEXurYr1Ht8Jh55xa8pA3+ddKZcB/Qe8HHH1QbxWOeWuL
         7LzBaTPyZM1A2j1470OkBTy9++fc9JM+nExoGG3JRMLQ5bQMgtJGrwlhjX4U81vtUs3c
         rgGh9EjEQLck8pjyFnVMBLQzJOrE5ot/LzPtVTrg2Nhnbcn/NiUpUddCNeP8qW6nO+NR
         Hz2BNUbVOcqONkTsU+nXUZ6UmmitZ5V8lnLcxji3DmJ8oCLBeloOp29aiEcYvXSvcP+o
         M/RYzBKG89gfUrUUe7yx1dN6n6es5KLxPUHe4p+Po64+/XbjHP+dvtBMPh4Jb7ZS3FI7
         EvcA==
X-Gm-Message-State: AOAM530MYTyMm22hNNQuUR+Ewkrg/9W1+0vD77WvbrlPexnWTUzDqoRs
        zH5i41gUEM7mnCSpLm9KlN2+hT37Iha08yjRxKs=
X-Google-Smtp-Source: ABdhPJwvZnKMs3lFFW/Id5/OLwGanBe4iPHTEvWKY+hRB61xXJa0joK7FfGUMFXjkVaq6kaxvRd17AgiYb4NgtuSeac=
X-Received: by 2002:a25:d113:: with SMTP id i19mr3396679ybg.39.1629195420644;
 Tue, 17 Aug 2021 03:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210629094038.18610-1-harini.katakam@xilinx.com>
 <20210629094038.18610-3-harini.katakam@xilinx.com> <20210714210803.GA3522064@robh.at.kernel.org>
In-Reply-To: <20210714210803.GA3522064@robh.at.kernel.org>
From:   Harini Katakam <harinik@xilinx.com>
Date:   Tue, 17 Aug 2021 15:46:49 +0530
Message-ID: <CAFcVECJXhjQLZdfQm8n_0cLsuh6CFPJbSA4A5XXQL+6+okb+CQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: mscc: Add RGMII RX and TX delay tuning
To:     Rob Herring <robh@kernel.org>
Cc:     Harini Katakam <harini.katakam@xilinx.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>, linux@armlinux.org.uk,
        David Miller <davem@davemloft.net>, kuba@kernel.org,
        steen.hegelund@microchip.com, bjarni.jonasson@microchip.com,
        ioana.ciornei@nxp.com, likaige@loongson.cn,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        radhey.shyam.pandey@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for the review and sorry I din't reply earlier.
<snip>
> > +- vsc8531,rx-delay   : RGMII RX delay. Allowed values are defined in
>
> 'vsc8531' is not a vendor. The form is <vendor>,<propname>.

I was just aligning it with existing optional property names in this document.
Could you please let me know if mscc,rx-delay is more appropriate?

Regards,
Harini
