Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918483C8BF3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 21:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhGNTkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 15:40:17 -0400
Received: from mail-yb1-f169.google.com ([209.85.219.169]:46832 "EHLO
        mail-yb1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbhGNTkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 15:40:16 -0400
Received: by mail-yb1-f169.google.com with SMTP id i18so5014648yba.13;
        Wed, 14 Jul 2021 12:37:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dfg6v8U+e94N9MYk6+AqPP4xfh304fF8ksCvTr/cIag=;
        b=cApeQgwIWStrsy98JwtT2zLaEs55Ii1ZPlgtLeg6zLukHIRA3fbgrfQY/sOXfzVwGb
         co0dU2o9otjlJpskApk7Dybi5cryuuK555pHC4l7vfFOKro3BwtDkju4SKXS4AVCgVZN
         yOAmB0K5NZ9x/etSUV6cKb1gguv+Rf7H8ItoQVEiR5Ci7tBPLTqG5gMYysFP8uoSm7DB
         JrZmNg5uvlPh6XsZUVzyU3Vh3iHsWpaq4gSKamnBY8av2hnN8tsMKbXDyr+O07/Mi1Qn
         WT3wGCEa8B1y3wLL3JJJkhzfaIvzfzFy5vJ4t5YhMZlNIZGdrvgBT8fMd4Df3rxXYH6k
         Y87g==
X-Gm-Message-State: AOAM530Fwontt1v9NxlG6SuucI5wtoYqW5flw9LGWnT8XmpBzz69zFmb
        UB8CXHC3X06C8jGgU4GdZqRSS0VETjqeyOP0eRQ=
X-Google-Smtp-Source: ABdhPJyUZ8N52pS5NpkhNdSd7dw7L4cwUfs6AS5py8VjBZ4AAZt9nUOJ5DSR7XxK3u1Ol1cvvSA45OmRsordlLFIn0s=
X-Received: by 2002:a25:b093:: with SMTP id f19mr15903363ybj.90.1626291444162;
 Wed, 14 Jul 2021 12:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210624162108.832518-1-esmil@mailme.dk> <20210624162108.832518-2-esmil@mailme.dk>
 <20210714193246.GA3134908@robh.at.kernel.org>
In-Reply-To: <20210714193246.GA3134908@robh.at.kernel.org>
From:   Esmil <esmil@mailme.dk>
Date:   Wed, 14 Jul 2021 21:37:13 +0200
Message-ID: <CANBLGcwb-Z9OPM2q7nZY218gPXuwv80Xstu1FXre4ZFhXHHeAw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: add starfive,jh7100-temp bindings
To:     Rob Herring <robh@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-hwmon@vger.kernel.org,
        Samin Guo <samin.guo@starfivetech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jul 2021 at 21:32, Rob Herring <robh@kernel.org> wrote:
> On Thu, 24 Jun 2021 18:21:07 +0200, Emil Renner Berthing wrote:
> > From: Emil Renner Berthing <kernel@esmil.dk>
> >
> > Add bindings for the temperature sensor on the StarFive JH7100 SoC.
> >
> > Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> > ---
> >  .../bindings/hwmon/starfive,jh7100-temp.yaml  | 43 +++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/hwmon/starfive,jh7100-temp.yaml
> >
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Thank you!
