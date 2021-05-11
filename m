Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A9A379DA2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 05:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhEKDZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 23:25:53 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:36399 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhEKDZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 23:25:52 -0400
Received: by mail-lj1-f177.google.com with SMTP id o16so23362877ljp.3;
        Mon, 10 May 2021 20:24:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc
         :in-reply-to:references:mime-version:date:user-agent
         :content-transfer-encoding;
        bh=t5dihwh6taxcRIhzyzPXuTSAxXGXraKDtiK/9X4Jh/Y=;
        b=JqcF7yLJ1Tp42uiWQltIBHjIKDzcN8bYpR3dzB7Uo0lE7CBjXyMuirE1ni7OVTZ8HN
         IbGpnmbrJME2NEw8lw1CGmfzKORKqGa0vKNdquU43OcP3nEEQFkrJ7XTqX2NGs9q9dA/
         QjVRTbU5dR6iG8sY3N55lAgTbXOqO/WZnpaBB3aG2wZlvbHFD7+3NwLm6R8boJqPtI9a
         zCUxdKy6JkKmOWqVxTz7Iwqxg3Dc+8TlYn8Mxah9ua/nmSeiTdHV0buJaAC8nyRyeH3d
         14NJZGIXyLPmxUM7xW2e3We7311Sb94bp6t2TaZkZ2qVKgnIwXf358rV66fhbCzKSN7t
         MGLA==
X-Gm-Message-State: AOAM531iFfpQbCV5R2rncKOBAUq2r00MdVhWSVxXQ99qphUgD+PNeF8S
        syB05KsIK1D8SLOYulzAfXblsJT619JtMw==
X-Google-Smtp-Source: ABdhPJwD3l/iF8tqr97idrVOmnyHS3NJ37MZAL/xw4/7kF3eFrOciG1X6h4w5Okm/ESeb7iU1NJe6A==
X-Received: by 2002:a2e:9dc3:: with SMTP id x3mr23213877ljj.206.1620703484941;
        Mon, 10 May 2021 20:24:44 -0700 (PDT)
Received: from dc7vkhyyyyyyyyyyyyyby-3.rev.dnainternet.fi (dc7vkhyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::2])
        by smtp.gmail.com with ESMTPSA id f22sm835673lfc.102.2021.05.10.20.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 20:24:44 -0700 (PDT)
Message-ID: <6121a55d7db8cc4376c068e289fb29b9d4479dbd.camel@fi.rohmeurope.com>
Subject: Re: [PATCH v9 05/10] regulator: IRQ based event/error notification
 helpers
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reply-To: matti.vaittinen@fi.rohmeurope.com
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, Mark Brown <broonie@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "agross@kernel.org" <agross@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-power <linux-power@fi.rohmeurope.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <CAHp75Vfw+5R-qN+iGC4hYSbL6phOoSZ7nuNsyroQPODxEmMaNA@mail.gmail.com>
References: <a22cf56239512f52ae5927f226e79d890d7a1240.1620645507.git.matti.vaittinen@fi.rohmeurope.com>
         <202105110342.Oembupaq-lkp@intel.com>
         <CAHp75Vfw+5R-qN+iGC4hYSbL6phOoSZ7nuNsyroQPODxEmMaNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Tue, 11 May 2021 06:24:32 +0300
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy, All,

On Mon, 2021-05-10 at 23:20 +0300, Andy Shevchenko wrote:
> On Mon, May 10, 2021 at 10:46 PM kernel test robot <lkp@intel.com>
> wrote:

> > 
> >    include/linux/bitops.h:35:2: warning: this 'for' clause does not
> > guard... [-Wmisleading-indentation]
> >       35 |  for ((bit) = find_first_bit((addr), (size));  \
> >          |  ^~~
> >    drivers/regulator/irq_helpers.c:242:3: note: in expansion of
> > macro 'for_each_set_bit'
> >      242 |   for_each_set_bit(j, &stat->notifs, BITS_PER_TYPE(stat-
> > >notifs))
> >          |   ^~~~~~~~~~~~~~~~
> >    drivers/regulator/irq_helpers.c:244:4: note: ...this statement,
> > but the latter is misleadingly indented as if it were guarded by
> > the 'for'
> 
> Seems like missed {}
> 
> Matti, there is a serious question: how had you tested this...

I actually did. I did not just run rebase for the series and threw new
version but I actually did run this in real HW, with real break-out
board and with a fresh info print to see the event being sent.

> (besides obvious compilation error)
> Perhaps you have to fix your process somewhere to avoid missing
> important steps?

Yes. Can't deny this. And process fix should be simple. If code/patch
needs a change (even a print removal/print severity change/parameter
change)  - then it needs to be tested again prior formatting the
patches.

Sorry folks.

--Matti

