Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B557D3FC2C8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 08:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbhHaG25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 02:28:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43206 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233032AbhHaG2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 02:28:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630391280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hEPnuo65Qwng2L+Utb7e5ueojU9F4bLfB1V9DmTMPmk=;
        b=GM5PkKtyWKerk1IVMHYmLuOBZH/dcDPpWl3p+mkn8641af7Lm2FNg8SBiL2/FKY7xfjxkA
        EEN+09vFRDweEeLWwHelen5yAbfHa/dcFIHRO8A4dhy+fZRevAce2+zW8MjIfMaiJMYOiP
        FdIiecOpd8pP4S8wCmQbHrQWQP06W68=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-dS3C9REDMyi958vsuPrHlQ-1; Tue, 31 Aug 2021 02:26:34 -0400
X-MC-Unique: dS3C9REDMyi958vsuPrHlQ-1
Received: by mail-ed1-f69.google.com with SMTP id z17-20020a05640240d100b003cac681f4f4so3289748edb.21
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 23:26:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hEPnuo65Qwng2L+Utb7e5ueojU9F4bLfB1V9DmTMPmk=;
        b=LXtPuGXMkxxHG5rJN/G7tiOeEWaDkGGLC77t0CtGFGxXO38ZVgNIBRNbpOCQj/0NP2
         PffJuqzsVp/4RTVYSqmgZS0gfoN+8c3NgyUW1N3MNDOKLawfx6E3x2BLOztB/TSo7IU5
         sUWNc3oIiySpzO+KXtXeZ9yYBY3Fi7FD/dU0oY/eebXqVWw3RPWdin9u43XiKKHoaAWV
         kmcxII0HwQP/bJs3XXUw1hm8nqw+W1RsoK5T7pd4aUHn40XhFFokx/IbjEpPFmocwCa+
         rgVzuOC6R6eZDVq3rDcGSjQNZAOKMea9XYKEJOrzYZAqZM3v4RGvw2PCyXm3E8hzh4+T
         KLng==
X-Gm-Message-State: AOAM532KM1C/8QSbUzavsKbbxwgLfRWS7yV3y7gbDF37nxdfAoinqg1r
        wYY4uRS+aJfhaSdBN9pPD+pamqScY7Rjw5umaspU10ucx9xr+LAQKlxsQKBzQ3bvdkoYTj9d51H
        SSBmAuHX6u33MlCTidSvRAYlz
X-Received: by 2002:a17:906:7848:: with SMTP id p8mr28411735ejm.212.1630391193308;
        Mon, 30 Aug 2021 23:26:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0ENtKRCXEgDAfYv9QFQ79jja5d57DPHChIvu4gbEetyNiq/qMcRLJnMhi1cyEze9WmqAobQ==
X-Received: by 2002:a17:906:7848:: with SMTP id p8mr28411715ejm.212.1630391193158;
        Mon, 30 Aug 2021 23:26:33 -0700 (PDT)
Received: from redhat.com ([2.55.138.60])
        by smtp.gmail.com with ESMTPSA id c17sm8820979edu.11.2021.08.30.23.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 23:26:32 -0700 (PDT)
Date:   Tue, 31 Aug 2021 02:26:27 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Viresh Kumar <vireshk@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        stratos-dev@op-lists.linaro.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH V7] gpio: Add virtio-gpio driver
Message-ID: <20210831022536-mutt-send-email-mst@kernel.org>
References: <56ca9b1fc803e393a67e875bed4f900c6a432085.1629347189.git.viresh.kumar@linaro.org>
 <CAMRc=Mfm7EekU_LbujfPxo+NzGTErC44yj-aB+Zg8DXqo7eX5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=Mfm7EekU_LbujfPxo+NzGTErC44yj-aB+Zg8DXqo7eX5g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 09:52:22AM +0200, Bartosz Golaszewski wrote:
> On Thu, Aug 19, 2021 at 6:30 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > This patch adds a new driver for Virtio based GPIO devices.
> >
> > This allows a guest VM running Linux to access GPIO lines provided by
> > the host. It supports all basic operations, except interrupts for the
> > GPIO lines.
> >
> > Based on the initial work posted by:
> > "Enrico Weigelt, metux IT consult" <lkml@metux.net>.
> >
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> > Bartosz,
> >
> > Can you please pick this up for 5.15, the specification is already merged now:
> >
> > https://github.com/oasis-tcs/virtio-spec/blob/master/virtio-gpio.tex
> >
> > I will follow up with the IRQ stuff separately.
> >
> 
> Applied, thanks!
> 
> Bart

Um. didn't expect this to be applied yet, the driver is not
sparse clean, kernel build bot gave some other warnings too.

