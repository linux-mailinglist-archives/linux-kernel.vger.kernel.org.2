Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00BD53BC6B2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 08:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhGFGff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 02:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbhGFGfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 02:35:34 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CF6C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 23:32:55 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id p21so14664502lfj.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 23:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0R9RNAketJhxYpc/XXD+X4512dTYOq/NUYNFt1MPbwc=;
        b=B8ONM1o9nZAeCeMY9N+sTVw8QDWQGNs9iT4EDMGWlhkKRw06xoZT4OBOILhByeMJHb
         32YcMzeZygkOePUB0aDQVWuU2sFGi4KgVjiLMcOD3tmateFpL4TPmS1U8yBTgobPjLGD
         LNSXkqvaE+BurAez6phiDmblXCk3L0ApZp0W4CgnmZRiiqo6Lt6O3luOLrxwijC68WAY
         eo/n8IaRtTWBKqmnULCDR9SV3QlgK/YY0N1w+YQGITrC6pbbWM7PSsR9G/a+XXHA/MFw
         kyLTM3HaD4hCdbYp1AiAQtB/TGV/gE6AHwVups8hPGasLinXzcaKHHToUKffjz6iT06U
         nWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0R9RNAketJhxYpc/XXD+X4512dTYOq/NUYNFt1MPbwc=;
        b=RnWKHZykhJWQSjhzAeEm9feX9SIcWDRzRaRjGHe+OZw5a1XKmNzyhGveL8zyzrkX1Z
         Q8F5cA0aWIWw/tlY6XbNXEkHYjHmciqgM5lk8VrTanhdeiqnAYxm5cFPGijXboh1n2jN
         QCPFfsb7xkULhMO3ES/5tN+FTW6Z9dDDl9HNiCL2gimcrRT7/pCpZRmVlXNQOVkVzhLE
         cQ8ljHDdprwNcsUzpfFYyEdnGkf6Mg3fE6JPY39ONLwXFuttFs3BL4x2MV7bWn7cnT00
         wNsmdaA+9nQKufMga1WKqDdOF4cZj8ybmleSIvZVsmGmiyb4dpBPFChb6P3dh4qxI1/o
         aUsQ==
X-Gm-Message-State: AOAM532OALHDXlQzkTqC20YBgv9yhxVNc3fzp8KK/UbXS2KVqMCt5sIS
        TFDXzFheQtcfU6rvCZr2Lq0oRrdkSld+AaDSxnw=
X-Google-Smtp-Source: ABdhPJwyNf1lJvyheN+sv5QtdqylQin6D6vIJM9g/ClU3NRET+VB8Pp/HQbZqRgr3qWk2pmYcUnEARBO3W2TrAD89HM=
X-Received: by 2002:a19:4f57:: with SMTP id a23mr8787392lfk.408.1625553173232;
 Mon, 05 Jul 2021 23:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <1625111646-3955-1-git-send-email-u0084500@gmail.com>
 <CAFRkauCNf6fP8zAz+0gY_Vzb_wCtVyYqLjw8s1T+t2s=bR0RQw@mail.gmail.com>
 <CADiBU3_dCNvZRwewiztB0UGFvDz3g5sw-q+95sg9akqte1YJsA@mail.gmail.com>
 <CADiBU3-i2tg33iCjX83NEYAhYYabnHjL129+tOm9_h=MrPhraw@mail.gmail.com> <20210705165255.GD4574@sirena.org.uk>
In-Reply-To: <20210705165255.GD4574@sirena.org.uk>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Tue, 6 Jul 2021 14:32:41 +0800
Message-ID: <CADiBU39oN-OeHnw8xgJY21YX_uDyXBNRZPC8maG79fF806hLyw@mail.gmail.com>
Subject: Re: [PATCH] regulator: rt5033: Use linear ranges to map all voltage selection
To:     Mark Brown <broonie@kernel.org>
Cc:     Axel Lin <axel.lin@ingics.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown <broonie@kernel.org> =E6=96=BC 2021=E5=B9=B47=E6=9C=886=E6=97=A5=
 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8812:53=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, Jul 02, 2021 at 11:47:50PM +0800, ChiYuan Huang wrote:
> > ChiYuan Huang <u0084500@gmail.com> =E6=96=BC 2021=E5=B9=B47=E6=9C=881=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=881:53=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > > Axel Lin <axel.lin@ingics.com> =E6=96=BC 2021=E5=B9=B47=E6=9C=881=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8812:41=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> > > From the regulator register in probe, it will get the current voltage
> > > from the IC.
> > > If the vout sel is not is over N_VOLTAGES, it will return the error n=
umber.
>
> > > But as I think it's the side effect to change the vout step num.
> > > To use the linear range is just to guarantee all vout sel range are i=
ncluded.
>
> > > That's my initial thoughts.
>
> >    Like as you said,  the first revision is from 2014.
> > It is almost EOL for this product.
> > To fix this seems redundant.
>
> Even if something is old it's still posible that people can use it, and
> if someone's done the work to fix it then why not?

Got it, I'll send the v2 patch to fix it.
Thanks.
