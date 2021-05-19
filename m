Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B6538869E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 07:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244551AbhESFhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 01:37:18 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:40806 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241566AbhESFf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 01:35:28 -0400
Received: by mail-lf1-f48.google.com with SMTP id w33so9239548lfu.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 22:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc
         :in-reply-to:references:mime-version:date:user-agent
         :content-transfer-encoding;
        bh=fC1CaIU+pSkmYQdi6dJq59uRpeoDdhiocnnvg2FvKyE=;
        b=YPcjqPRqtGlTinuTKNkuYKS05PxjkL0lQS5iWhoaY/H1/eQ0fZe9bCkYiLBejXsusR
         UoFKEFO4jYe6nGsXNTWLBm1FY9By6+TIZypWpeSpRGtdZlOwbcz19s4k6rSIvsZ3Hrak
         z98ffjbf/1HbdkALHKZQ412y1U+52O2PbSC1J3wcUWQc+IHL4jNAercBVMPYpMSPVagB
         0gG9SlG4Q5vuQM6QglVESPjG36mfCZQNlDPXUlPGrQUjjmHHomRhNJaiKORRzogG3oqq
         MwVHqvwvYkrXLJT9d472GjMl0GYHLE2jgoteg13ZwlwzdsbUeN4SIoPUS6Ssi7Vd4JTp
         RxNQ==
X-Gm-Message-State: AOAM5322lTJyn83mImdo7sZ0i1MWlcgker1x2HWZViide9t0MRmsxUZi
        rxusgYC28vre459Vu6SGOQgRY48icmrxJw==
X-Google-Smtp-Source: ABdhPJyX4yTCbPOoWfrgd7DmBR3ZO5Rh49nIBfzOpw5Io832iLT5WCwHyiyQsWHhGZKuwNA/5WcOkw==
X-Received: by 2002:a05:6512:21d:: with SMTP id a29mr7150382lfo.391.1621402447397;
        Tue, 18 May 2021 22:34:07 -0700 (PDT)
Received: from dc7vkhyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc7vkhyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::1])
        by smtp.gmail.com with ESMTPSA id b24sm2480405lff.93.2021.05.18.22.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 22:34:07 -0700 (PDT)
Message-ID: <278ddbfcb0f5a9326eefdc22b35f2a476c482caa.camel@fi.rohmeurope.com>
Subject: Re: [PATCH v2 0/5] Add devm helper for work-queue initialization
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reply-To: matti.vaittinen@fi.rohmeurope.com
To:     Rob Herring <robh@kernel.org>
Cc:     hanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210519003938.GA1649581@robh.at.kernel.org>
References: <cover.1621340116.git.matti.vaittinen@fi.rohmeurope.com>
         <20210519003938.GA1649581@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Wed, 19 May 2021 08:33:58 +0300
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 2021-05-18 at 19:39 -0500, Rob Herring wrote:
> On Tue, May 18, 2021 at 03:31:37PM +0300, Matti Vaittinen wrote:
> > This series adds new devm_work_autocancel() helper.
> > 
> > Many drivers which use work-queues must ensure the work is not
> > queued when
> > driver is detached. Often this is done by ensuring new work is not
> > added and
> > then calling cancel_work_sync() at remove(). In many cases this
> > also requires
> > cleanup at probe error path - which is easy to forget (or get
> > wrong).
> > 
> > Also the "by ensuring new work is not added" has a gotcha.
> > 
> > It is not strange to see devm managed IRQs scheduling work.
> > Mixing this with manual wq clean-up is hard to do correctly because
> > the
> > devm is likely to free the IRQ only after the remove() is ran. So
> > manual
> > wq cancellation and devm-based IRQ management do not mix well -
> > there is
> > a short(?) time-window after the wq clean-up when IRQs are still
> > not
> > freed and may schedule new work.
> > 
> > When both WQs and IRQs are managed by devm things are likely to
> > just
> > work. WQs should be initialized before IRQs (when IRQs need to
> > schedule
> > work) and devm unwinds things in "FILO" order.
> 
> Wouldn't it be better to convert drivers to use threaded IRQ
> handlers?

Morning Rob,

I think for example the extcon drivers were using threaded IRQs. In
general, there may be legitimate use-cases for having threaded IRQs but
still offloading some work to WQ. I guess that for example the
IRQF_ONESHOT usage could be such, right?

Best Regards
	Matti Vaittinen


