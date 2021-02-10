Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5627F31708E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 20:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbhBJTs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 14:48:26 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:38768 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbhBJTsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 14:48:17 -0500
Received: by mail-ot1-f46.google.com with SMTP id e4so2963226ote.5;
        Wed, 10 Feb 2021 11:48:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+qy1Z5qodeKEvo9pP+CsKbcmPA1dn3m2Hb7iTrfGUn4=;
        b=rZzMro43D09FrYThiJ0jWfgjtn0qOBEW4aXscnSW5yplTh2Kq1lVObL0ZrOFwc3fOR
         8BWckURS1S565+t5EoSoRRP7swSOIagx1TEgxvXfd5EvOU+lOC63dx9f6/lRCdcPkquv
         wjwXtz9hE5J+tRGfz9PbAZZY/z+B5MVFTM24A7cfULi56QHyWeGcr1nXa/Seamh2yhEV
         IG7R9QYILKuNjGt71Dlh9MF1AcYZGJvF/wMJM7mih9dSBt4pypo1ep+aQXeNOP3f+bKD
         jhj/NJjcwe154zUHhL+37csCY6XGQ5LBQRs1cHVtpHEgrr3akoszVmFfQ9kpj1OZuMXy
         Exww==
X-Gm-Message-State: AOAM5333pMqIq+yWA3FHkXpABO3m+bKD5JT3C5Fah/I0DvKFpF/p5f+e
        sAZ0qn+R06hH+LGH6vhG1A==
X-Google-Smtp-Source: ABdhPJy3gzJ5yC7lL+2rZ4ttWIAdk76QcwvGJd4d9ENMiSwxUsXXbjIKGRMba+Jlnks/WW3LxoLGcA==
X-Received: by 2002:a05:6830:200f:: with SMTP id e15mr3255771otp.306.1612986455932;
        Wed, 10 Feb 2021 11:47:35 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s1sm554303ooj.30.2021.02.10.11.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 11:47:35 -0800 (PST)
Received: (nullmailer pid 2633976 invoked by uid 1000);
        Wed, 10 Feb 2021 19:47:34 -0000
Date:   Wed, 10 Feb 2021 13:47:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Jean Delvare <jdelvare@suse.com>,
        "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/4] hwmon: lm75: Add lm75 to of_match list
Message-ID: <20210210194734.GA2609450@robh.at.kernel.org>
References: <2588ea5c-630e-6509-689d-4c8fea358e9b@roeck-us.net>
 <20210206095121.20625-1-matwey@sai.msu.ru>
 <20210206095121.20625-2-matwey@sai.msu.ru>
 <164495f0-9b53-2523-f178-bd52bbb40ae6@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164495f0-9b53-2523-f178-bd52bbb40ae6@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 06, 2021 at 08:46:16AM -0800, Guenter Roeck wrote:
> On 2/6/21 1:51 AM, Matwey V. Kornilov wrote:
> > Currently, many boards use just 'lm75' as a compatible string.
> > 
> > Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
> > ---
> >  Documentation/devicetree/bindings/hwmon/lm75.yaml | 1 +
> >  drivers/hwmon/lm75.c                              | 4 ++++
> >  2 files changed, 5 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/hwmon/lm75.yaml b/Documentation/devicetree/bindings/hwmon/lm75.yaml
> > index 96eed5cc7841..aec8edd1e0c6 100644
> > --- a/Documentation/devicetree/bindings/hwmon/lm75.yaml
> > +++ b/Documentation/devicetree/bindings/hwmon/lm75.yaml
> > @@ -13,6 +13,7 @@ maintainers:
> >  properties:
> >    compatible:
> >      enum:
> > +      - lm75
> 
> Please split the .yaml file changes into a single patch, separate
> from the code changes. Also please make sure that the subject indicates
> that this is a bindings change.
> 
> For this change, we'll definitely need feedback from Rob. I am not sure
> if such a generic compatible string is permitted or if we need to change
> the dts files instead.
> 
> On a higher level, while lm75 is an extreme case, I see a few other
> violators as well.
> 
> drivers/macintosh/windfarm_ad7417_sensor.c:     { .compatible = "ad7417", },
> drivers/macintosh/windfarm_max6690_sensor.c:    { .compatible = "max6690", },

Old as dirt PowerMac stuff...

> arch/arm/boot/dts/socfpga_arria10_socdk.dtsi:           compatible = "ltc2977";
> arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts:                           compatible = "tmp421";

Pretty much a dead platform...

> arch/arm/boot/dts/nuvoton-npcm750-evb.dts:              compatible = "tmp100";
> arch/arm/boot/dts/nuvoton-npcm750-evb.dts:              compatible = "tmp100";
> 
> so it would be good to know how to handle those in general.

The dts files can be fixed without a compatibility issue (at least for 
Linux), so we should update them and leave the documentation as-is. We 
just can't add a new vendor compatible to the driver and then change the 
dts files like these as old kernels wouldn't recognized the new 
compatibles (though we should backport compatibles like PCI IDs).

> 
> Note that there is also:
> 
> Documentation/devicetree/bindings/display/repaper.txt:          compatible = "lm75b";
> 
> but maybe that doesn't matter as much since it is not actually
> used in dts files.

Right.

Rob
