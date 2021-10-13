Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7E342CE2E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 00:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhJMWeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 18:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbhJMWeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 18:34:16 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB11C061746
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 15:32:12 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id j21so18674268lfe.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 15:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T/OomM9w2GusTbCVdWitYQJgC9/Z986cg3wMugLDkCc=;
        b=iIn8C5md7RBiGzfnw2bAipABPt+03zPtv/DOq/HLswL8ElO65blVWNj9Xi0OdYbSVO
         Eo4zFMFHuevfXEK92pXYjENk6eY1NWcLNe4lFjx75z+2MjgoQUkSqqpAoqRYLhfEJddo
         5uMzn/mOrXGlBg75XlWecvyBlqKFxEusfRgLWijGHPegycDKaFJbFlOBnqxtQXv31lGb
         d0X+r94JhCIkuxRKm6yBj/ouq7toJNfJ9SkyJwwK87fhNSxEja+J8JtvsDm5t5fZlr3/
         8tCIWi0WipX/kw0TTbIFGX0BTole/YW5bn6Vf3U8qbZhUTt3MFm/9LjEEtqjcFKoV/sP
         +PfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T/OomM9w2GusTbCVdWitYQJgC9/Z986cg3wMugLDkCc=;
        b=UBeMKSb0+7bHJNSZFQOsHvbCrRRdj7/3RpzNkrM1lWJXqA/Dc9P4wOjPplrI2pGJ+a
         Z3f5FtgX1YBPg4zFG52g06VnWKn8WOJd9jgVkbG4m++9bMNSxLekm/lbtSbIbScZbysh
         K1NzTKpyYLtHhbUxAP/zlcZNSoH1UwBHKpoMkO059XhyqWrMVfS/USISYmhK+tuh0at8
         UAj5ODWX1U6cNAzQ/1USPpsSJYtxdh88RlmPxuhww7gNiwFxNbla3bySIHRE84fDhryw
         Ui9AIjnTcA4rhyau9D1kRNmnhYXnT2jr2DuE4EKOukUASFBPfHbe6n76LhIFc7TLspm8
         IThw==
X-Gm-Message-State: AOAM530CPQ1YRm4K6xpt9DmxxHHu9z9AK2URxMQgIm+56Y/vvDTHpyLo
        aXKc6HXdfJZdmYWPHiyIfCcvuwpEvHTsonEINUf4pw==
X-Google-Smtp-Source: ABdhPJxBSo+RJ+XSsLVvldxL70PplGkXVK8P4+WfUMNkYtB7Bu45xbhCyoL5p3gR6ii06cEdUwToJESL+JN7cP8U8Pk=
X-Received: by 2002:a19:c10d:: with SMTP id r13mr1679243lff.339.1634164331067;
 Wed, 13 Oct 2021 15:32:11 -0700 (PDT)
MIME-Version: 1.0
References: <20211007144019.7461-1-jbx6244@gmail.com> <1633661172.660863.1409603.nullmailer@robh.at.kernel.org>
In-Reply-To: <1633661172.660863.1409603.nullmailer@robh.at.kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Oct 2021 00:31:59 +0200
Message-ID: <CACRpkdYArdPwEVf_5pwsROKPjbnVAtU3mf9v1z6WXGPoBb=SZg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: pinctrl: convert rockchip,pinctrl.txt
 to YAML
To:     Rob Herring <robh@kernel.org>
Cc:     Johan Jonker <jbx6244@gmail.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 8, 2021 at 4:46 AM Rob Herring <robh@kernel.org> wrote:

> On Thu, 07 Oct 2021 16:40:17 +0200, Johan Jonker wrote:
> > Convert rockchip,pinctrl.txt to YAML
> >
> > Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> > ---
> >
> > Changed V3:
(...)
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.

Rob can you tell me how you like me to handle this?
Do we merge the nice new bindings and deal with the
aftermath or do we need to fix the DTS files in the same
patch series?

Thanks,
Linus Walleij
