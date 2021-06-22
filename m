Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEFB3B0914
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbhFVPcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbhFVPbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:31:36 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0421C061787
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 08:29:19 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id n12so8628607pgs.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 08:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ZLZP6SLEvIJeycmW3JhlHuN2dQQJzCXGQZn2s6TLB4=;
        b=RYJB9JUXHW7xXPq+dMRozgFH87tS0IUdoLh7RH0SUo9y89FI3Ue27pcpi15xDHpBvo
         eU3Tu+La9+6r889uvnKAWHTj60zBSjds5/ujKo2C4afCa82aIIeDt6vBZSX4GxMh6SFR
         vNsR18Kz8MOyQwDmsNwE0pG8K/i0zcZ9q7Lr9OThw6MTzKTjo81Gp5HG4QVPZ6nTl3Mo
         vO2rUncIkXKcJWGYB2Uf4Xt566ySCBAx/8SNec7PMwJMyKo5FnfkWMlUeM1Fy//5pneO
         2eMwmTuO6DFKQ/4K0uARRv99oafBtkTRiCZKwTG+CeMfxV2vP1+pKez84O1uox5tN4Q5
         UIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ZLZP6SLEvIJeycmW3JhlHuN2dQQJzCXGQZn2s6TLB4=;
        b=rw2+3ap+qmiHNcNzwYFcUYMkzROgg/pc/XfBLLjeZw9eY3eFtUytDoNnv+MatYBobj
         ldGnLYxlt0cPUnuk/acAHxJN88L2Ct7JtmxNs6SUCbAsLaEzNCtb31E3iqoS5ukQiMUB
         Z2T5jHuAl2Yzq33dOlQvYhGvQ6pyEKJq0AW2A4AKU0DlfXEqNxY3gq1Djqtw9wcQrz6O
         BH663KYP2SWqL37RGfFuN5NcekujbUeWq0Deefz3P+GmbQw0d5AjU2wd5oAKJtldjy8p
         JqbA/asVR1m4mxUMEHiRt651PyKcFugtLx9fvuWQd68rAUsDnofhjxKRvduaqRWOUWxL
         ogaQ==
X-Gm-Message-State: AOAM532CRkviUkwVoWkvgsyN4X58et1FEpRNM9hBSZt9E1Z1DPQfdn61
        UUqfYWLCrdme3oGWQ5xRgh2UR4fhryYLnMxGAyQ=
X-Google-Smtp-Source: ABdhPJwkPGv9EyB/moqSzq2pvKN77usgX4g31HeXSLU9Agxr77HbcxJOZz3aHbN5CleB2+3KAt2q03VPO/8N1+6NxTE=
X-Received: by 2002:a63:b00d:: with SMTP id h13mr4312110pgf.74.1624375759398;
 Tue, 22 Jun 2021 08:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75VfP2h_aLVR9cgfXWHmqNbUZg-KZj2UwMs6dAkbS5eSghg@mail.gmail.com>
 <YM8rY5hi+zuAekg+@owl.dominikbrodowski.net> <CAHp75VdSyM7JdGDhdo5t+FbmouEA7ZSOwGAtSwSRD8vTwTc+LA@mail.gmail.com>
 <CAHp75Ve=j+u-9TF0az3o82wOyzixCezkgOm=yUHh37JS_Awiig@mail.gmail.com>
 <YNBU3Jjme1lQ3MdV@owl.dominikbrodowski.net> <YNBjJnxrXaWmfUqo@smile.fi.intel.com>
 <YNBsB6zIo4A4vD4w@kuha.fi.intel.com> <YNCw5k9vwdQiS0u4@owl.dominikbrodowski.net>
 <YNGa021IIj+C8H7h@kuha.fi.intel.com> <YNHvZGLE9lgS/FRe@kuha.fi.intel.com> <YNH1bo6BesNGY3gu@owl.dominikbrodowski.net>
In-Reply-To: <YNH1bo6BesNGY3gu@owl.dominikbrodowski.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 22 Jun 2021 18:28:41 +0300
Message-ID: <CAHp75VffvF0R4qmunbDKpaQpTj900Pv6KK31KNkEfuDuvUSN-A@mail.gmail.com>
Subject: Re: v5.13-rcX regression - NULL pointer dereference - MFD and
 software node API
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 5:37 PM Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
> Am Tue, Jun 22, 2021 at 05:10:44PM +0300 schrieb Heikki Krogerus:
> > On Tue, Jun 22, 2021 at 11:09:58AM +0300, Heikki Krogerus wrote:

...

> > Before I send the patch to Rafael and Greg, can you confirm that the
> > appropriate API (device_is_registered()) also works? I'm attaching
> > patch that should be the final version (if it works).
>
> Heikki, that works perfectly. Many thanks, especially for the speedy
> development of the bugfix!

May we transform this to the Tested-by tag?

-- 
With Best Regards,
Andy Shevchenko
