Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259B33A836F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 16:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhFOO6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 10:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbhFOO6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 10:58:05 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B67DC06121D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 07:56:01 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id x8so9954904vso.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 07:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6NlGGyHdfmhmT6ya+5jwsZDiCyDLrqcnWCoZ2x8RsE4=;
        b=v8vTFNRHvwUmBQ6w8rLfF8DHOx+02bK0BmujOz72D+iq0il8hrgQllhSxbvoJyCshL
         U2VUbKTQvaheXYUWFpFebpPVuvHNj7oLMcmIzXUM1AVOg6JVnwczsh1FHzKI0rx/FHUB
         5w5cwdhgB4KDu+texrBEgDR3m+6B7PMU7KI+IKfHIIMnN/fbDBtNL1ANO82BBoldOqgI
         SuidCyXsDfNF9DKvW3tl649EtyoBialHwDL0aOCR5p/VSF1H7K/t2d7YQfWbVPulBtdN
         p296CQ0UCZst/3b6L21Ii7zg6ZSmVH+3xVKFUZafBTMnr+HximS0lFijEdYIgaTMJzEV
         c4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6NlGGyHdfmhmT6ya+5jwsZDiCyDLrqcnWCoZ2x8RsE4=;
        b=Zr++Iix+vWUZfEvij8jFQhihAmUuwF2cKQYcufHQSCSYYBpchdYfMgw7enZ3JVTSMH
         vIMCz1YdDMwlq99ZoY0cCGH+Uj155kpilK2d+XO/J6NeGRtPo6oeJIQWScnNezhomftE
         8fSjxOEKbBRKcoGdACjNZPqr/pzSDHFQrB+a3EuT/L8YM5lwa2D6CGnkvyASx9LRSvfj
         OglkZ5eukEIKlFLZrvEP2WS42ntGiPXt6JKJ4lL6/LAZLG6ZJdkCKXdf51V67DXdKIS5
         uUbo0fBmMJm7HQm/CrDhBrlIs8+Gx52ywhs97bc5+LkORpoNUqII+KsCIEyBFJe7JhrU
         eyZg==
X-Gm-Message-State: AOAM5304Mwkw+OEba1H0RmUfja4Mfdjh7cCDvo3EOX9chgJIrKr31PIc
        9Sk7H/pmHEnh5YajqoNPJNZLDstj0S07GFkDn5djAw==
X-Google-Smtp-Source: ABdhPJwsi2xYFmituAXmkUFGyeCyfsNRM/VoJt6N+a5mCeHjNkY5Bf+20vC2pDDRay4zMFl8ffDhDguroQ9W8j6LsTQ=
X-Received: by 2002:a67:1087:: with SMTP id 129mr5712761vsq.42.1623768960305;
 Tue, 15 Jun 2021 07:56:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210611101540.3379937-1-dmitry.baryshkov@linaro.org>
 <20210611101540.3379937-3-dmitry.baryshkov@linaro.org> <CAPDyKFo5mUZZcPum9A5mniYSsbG2KBxqw628M622FaP+piG=Pw@mail.gmail.com>
 <CAA8EJprSj8FUuHkFUcinrbfd3oukeLqOivWianBrnt_9Si8ZRQ@mail.gmail.com>
 <CAPDyKFoMC_7kJx_Wb4LKgxvRCoqHYFtwsJ2b7Cr4OvjA94DtHg@mail.gmail.com> <20210615111012.GA5149@sirena.org.uk>
In-Reply-To: <20210615111012.GA5149@sirena.org.uk>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 15 Jun 2021 16:55:24 +0200
Message-ID: <CAPDyKFreV-RPzweG8SqFQtvZMOyFbaG2+tMFKc2JkbEj+erb=g@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM: domain: use per-genpd lockdep class
To:     Mark Brown <broonie@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2021 at 13:10, Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Jun 15, 2021 at 12:17:20PM +0200, Ulf Hansson wrote:
>
> > Beyond this, perhaps we should consider removing the
> > "regulator-fixed-domain" DT property, as to avoid similar problems
> > from cropping up?
>
> > Mark, what do you think?
>
> We need to maintain compatibility for existing users...

Normally, yes, I would agree.

In this case, it looks like there is only one user, which is somewhat
broken in regards to this, so what's the point of keeping this around?

Kind regards
Uffe
