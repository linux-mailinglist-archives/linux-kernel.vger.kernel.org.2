Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE8F3BA7BA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 10:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhGCIIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jul 2021 04:08:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58097 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229893AbhGCIH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jul 2021 04:07:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625299524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kKIOnpxOcNmgTRp3B6WHqjm7D0aNgAomWGm0e5Ck0pA=;
        b=Lhc2UT0daKaN1WVFPj/Pcu3czimNPLyDBm2E2UofvpH/aOfIUzs63HlgFBL/2buStHGill
        XyA0uzQTSuziwRnXBAlqlxbtqwuQJ2sLEAuxn9osWQtPm5fRpiJIWH96UK79POoYVlsRBU
        SoCsTlEo47PYw8giBn8+wuiDY+dEKNU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-Kf9XjO17MdO7XSQSvTPRuA-1; Sat, 03 Jul 2021 04:05:21 -0400
X-MC-Unique: Kf9XjO17MdO7XSQSvTPRuA-1
Received: by mail-wr1-f71.google.com with SMTP id a4-20020a0560001884b0290124b6e4a437so4463843wri.16
        for <linux-kernel@vger.kernel.org>; Sat, 03 Jul 2021 01:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kKIOnpxOcNmgTRp3B6WHqjm7D0aNgAomWGm0e5Ck0pA=;
        b=NglZwGGb8bHQpp0Bg3un/4JK5wqTPSdG0f5/13DJ7DtTOBgdUEB2/C5/f7IjYEaTeq
         PJoBxIv64EOf3RwLBqlGt98d/wvCa6aJnrtYpVfVngNT97GmX/YXkMeziOFbQ0tJj3CV
         3H6yI5mpVMkZBpfXG0kFJJQHXtPlNjL8ECwsBm36x9VAhkPeIl9qzE9x+6yoj+z20HgE
         L3BLcfdsTQbE6Cit1gDePKqK6V/K9r+I0Snpguu58XzqNQLT1FmI+dmHXrYIHUNIx7e0
         V6tZoP56JJuhJwzEMBnwpmQVc5pa/QAc25QHw2BJ5svGqolh5053tkOmArGa3NvemVsy
         a5Yg==
X-Gm-Message-State: AOAM532oGHWgHMBHlhtORqe6P8/EKPB7Zf3iJTdldQyUlnayd/p5ycI8
        31YplHNLZUJD+973dqImRV5bQeuLgPsawZzFytzbQ5kxcXeAdP6PQP/t8OGvbXxrZnP38PwaN15
        NDQjbLbSc3IjZxk0hAbnTGH3O
X-Received: by 2002:adf:a74a:: with SMTP id e10mr3938750wrd.185.1625299520741;
        Sat, 03 Jul 2021 01:05:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKSHjkKeNS1veZXd/UH5HPoz05bwQZrIGUjhF4ktH5u6/iyfCkd4WgsIejTPdf0V3pNrgQdQ==
X-Received: by 2002:adf:a74a:: with SMTP id e10mr3938741wrd.185.1625299520609;
        Sat, 03 Jul 2021 01:05:20 -0700 (PDT)
Received: from redhat.com ([2.55.4.39])
        by smtp.gmail.com with ESMTPSA id c8sm5566926wri.91.2021.07.03.01.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jul 2021 01:05:19 -0700 (PDT)
Date:   Sat, 3 Jul 2021 04:05:15 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        bgolaszewski@baylibre.com, Jason Wang <jasowang@redhat.com>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/2] drivers: gpio: add virtio-gpio guest driver
Message-ID: <20210703040504-mutt-send-email-mst@kernel.org>
References: <20201203191135.21576-1-info@metux.net>
 <20201203191135.21576-2-info@metux.net>
 <CAOh2x=kcM351ObubnQSzUa=FVBQUmAUhz4u8ExORUthQQ0WbGQ@mail.gmail.com>
 <253f218d-07ac-1963-75e1-9ac2d035437a@metux.net>
 <20210526033206.5v362hdywb55msve@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526033206.5v362hdywb55msve@vireshk-i7>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 09:02:06AM +0530, Viresh Kumar wrote:
> On 25-05-21, 14:59, Enrico Weigelt, metux IT consult wrote:
> > On 24.05.21 13:27, Viresh Kumar wrote:
> > 
> > Hi,
> > 
> > 
> > > We (Linaro's Project Stratos
> > > https://linaro.atlassian.net/wiki/spaces/STR/overview)
> > >   are interested in this stuff. I was trying to look at the last status
> > > of all this. Few
> > > questions for you:
> > > 
> > > - Was the spec ever posted to virtio-dev list ? I thought that's the
> > > very first step before
> > > we merge the code.
> > 
> > I had posted some spec quite some time ago, but it wasn't in the form
> > of patches against the .tex documentation files yet. It's been laying
> > aside for quite a while, since I've been busy w/ other things.
> 
> Will you be fine if I take that up and restart the thread ?

It's been a while - why not right?

> -- 
> viresh

