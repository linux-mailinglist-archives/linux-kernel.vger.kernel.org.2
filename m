Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A515F397E3A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 03:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhFBBub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 21:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbhFBBua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 21:50:30 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5181AC061574;
        Tue,  1 Jun 2021 18:48:47 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 131so522301ljj.3;
        Tue, 01 Jun 2021 18:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ds1bzsU5BlYh6xsl5Py6PMpXcqnFFQEWiI7YJzooPwI=;
        b=rKNNSqKlhW4HMk6l41lUCvdFy4CtOyKuLJQJEVvxJin9Ri1l8pfcmVU67/4vI+/QYm
         2l3uCvWRWuuv+p1ToEU3UIz1uOampfO0um71N/5euDRUWgg6VhsEoDxixe1Vgsis0hNT
         OC+Rban6IednUvdrZGXQ0UDgx4aMwFkxbWJE67566ggXB5gCiKZbhF5bx7xklE1MTYlU
         zvrWZ/q7x7hPMfp1AW3IBR5vyKVMhv6TIn0uTQq/sr8IK1lW2YaOAlyn2TscAIeifYEb
         MfnjHvPdHUahy6XLHyeW7HrLADiYWImHSxT91uYmOmFEgE83aDEzDGGPMweLd4vyum6b
         pMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ds1bzsU5BlYh6xsl5Py6PMpXcqnFFQEWiI7YJzooPwI=;
        b=PqUrnLzkgc+0DtDURCDdi2sA0cZqjJWOiDLTBJO4w8TKlaFAAyHchIjMtCiWQY1F3r
         yE6ZR4ItURBGlaXzi78zv37/qKPT7+qNxY5kD5NpxBMyZkg0yb+bghW3PXxeW//iNRPm
         J9FSjEv4fLxgNSKjv35p+OVKGev5XramxsaNuHTinbaX0Bd4m/rehPXJ3omwNJSdsZ9J
         gW3si/fqF57p7bQPTCqrZsMDdWkGDf/01HTCVp5hKULKvOya/0uHW0TsB4GHv5Y/WVR0
         3FuQF5pcH1seAk/Am4gPgPrJUcLwuYzgIW+TbqwWF2mjR4UekFClJfPfbNehBFblaJ2m
         Gx3g==
X-Gm-Message-State: AOAM530kOfEK0YZptrESVj+hOJpI9IMipj+atwoIzKe4P+RV9d3L0Xic
        Opu6wlswUEMYku7ntGpXD21vlUY8D186srxmJxE=
X-Google-Smtp-Source: ABdhPJwc9xN16GvCeFBcl6Uy7SxWHFhj+DyJb/ipOIzMvIO/0qrRIMtE4gfXXEme7Ok9NbBNrriwMzMTFkjdW7S5YuU=
X-Received: by 2002:a2e:9b45:: with SMTP id o5mr24001309ljj.153.1622598525632;
 Tue, 01 Jun 2021 18:48:45 -0700 (PDT)
MIME-Version: 1.0
References: <1622008068-13474-1-git-send-email-u0084500@gmail.com>
 <1622008068-13474-2-git-send-email-u0084500@gmail.com> <YK4oGB5cZ/DhG5vm@sirena.org.uk>
 <CADiBU393NchfrTmgPApNRqSVrTBGT+bs+H+m2UF_H3tSGLyFVQ@mail.gmail.com>
 <CADiBU3-LjetAkzks4MZKiK=KXK5ziFhF9D13cAjJ4W5gytw74A@mail.gmail.com> <20210601155239.GD4089@sirena.org.uk>
In-Reply-To: <20210601155239.GD4089@sirena.org.uk>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Wed, 2 Jun 2021 09:48:34 +0800
Message-ID: <CADiBU380OPfhBv9-cToR2sstxPWQwgt2_TEisLi7zPn4P5rvBQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] regulator: rt6160: Add support for Richtek RT6160
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, Rob Herring <robh+dt@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        cy_huang <cy_huang@richtek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI, Mark:

Mark Brown <broonie@kernel.org> =E6=96=BC 2021=E5=B9=B46=E6=9C=881=E6=97=A5=
 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8811:52=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Thu, May 27, 2021 at 11:14:17AM +0800, ChiYuan Huang wrote:
>
> > I review the regulator_set_ramp_delay_regmap API.
> > If seems I need to fill in the ramp_delay_table by the descend order.
> > But this chip ramp delay table is designed the ascending value reg bit
> > field [0 1 2 3] by
> > the ascending order [1000 2500 5000 10000] uV/uS
> > Even if I tried to filler in descending order, I also need a inverted o=
peration.
>
> I see... that really should be supportable, and I'd have expected
> find_closest_bigger() to DTRT here, it's not obvious it's expecting
> ordering.
>
> > And I found the regulator_set_ramp_delay_regmap API has some logic erro=
r.
> > From the include/linux/regulator/driver.h, the set_ramp_delay function =
says to
> > set the less or equal one ramp delay value.
> > But your logic will get the larger or equal one from the descending
> > ramp delay table.
>
> The code is correct here, the documentation should be fixed - with a
> delay like this we should be erring on the side of delaying too long to
> be safe.

If so, I will upload v7 patch series to meet this selection logic.
Thanks.
