Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062FA3E54B1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 09:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237832AbhHJH6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 03:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbhHJH6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 03:58:40 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16AEC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 00:58:18 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id h13so24999074wrp.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 00:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Vy1q2TxaPPh8VuhM7PWbw+oYxzHvSHzhjKECTf8T59c=;
        b=qxTYWxirw6u8gFBYajAfd3ku9NgbKaEO2fOvsmj69Arm0I30frcoDfwoZGJjOSXRUl
         CIGAe5G43eBs1kK6cLUpseTXOW5DGaTFGH4wc5GZol5pEvZC7dSte57fiszy5SlPjxvd
         v2ShhTU0HOs+H6CEBw5/T3599G3EVMm2zRfEKS88LkswiYvZnFhlYigCg/wkZLBX5R6O
         6rLbDH1apoqRaIe1XjziwTlavR4D3HgsNdO0MMfzvSBoZFsWJLTcWiYF0BKfvTb6sIPf
         cOHhRiJ/8nT/4mhwuhBzO9T8QkK+DgkNgPTolNyZlK0GHXM41er+4prcJFDZvIm1cb/w
         JSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Vy1q2TxaPPh8VuhM7PWbw+oYxzHvSHzhjKECTf8T59c=;
        b=B3syEaBhlkFHqeaProQHdRm6Ux0LpX9c/wYW6PbLG5MbPo95fGQM5eirvnKsMRLy1q
         gdybvRXzwKyQZK4N3zuUSOBHFVV+IbLkXGAHIShi19PoXMIjm0e/TvHYi34MhusDNnGS
         Li/ti2RWJzXOFlCrfOmLBZy4FG7uUWe6DDPZxW5y95YHvkr+Fn52RAiFlN2vZAl+/UsT
         0OwCgafhwsXc204CTspe1y/Z44Ecxz2x/wFyLjb5W5RIsp83UhIlqSn7t4Hw4OhTKZkP
         7v49nzpOCRscl5MWYquKLxY46DrEpYFHPTJ4hxipkgUXPo9+11+G+0nWz5s6s0RSlqE5
         7Mvg==
X-Gm-Message-State: AOAM530oHw257fmy1f+4j62exILfbT+A+S8cL/Y5j/nlM/Hi9xgwg2lW
        dEMLA4GS5xA7gB1DppeVaCW0/tDBC9trPw==
X-Google-Smtp-Source: ABdhPJzHofmXuHhcOk6Ah+VqehLGqVx28KfPrTazcWj37JDIDjmObNHRqLwq4+mUHmZMUcGndMktkQ==
X-Received: by 2002:a05:6000:186f:: with SMTP id d15mr28578189wri.89.1628582297379;
        Tue, 10 Aug 2021 00:58:17 -0700 (PDT)
Received: from google.com ([95.146.142.85])
        by smtp.gmail.com with ESMTPSA id c15sm22257789wrx.70.2021.08.10.00.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 00:58:16 -0700 (PDT)
Date:   Tue, 10 Aug 2021 08:58:14 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] arch: Export machine_restart() instances so they can
 be called from modules
Message-ID: <YRIxluiYdZo9OOAn@google.com>
References: <20210803155452.435812-1-lee.jones@linaro.org>
 <20210803155452.435812-2-lee.jones@linaro.org>
 <CAMuHMdXpYV+pbiOwiCjZ+aZYR-xPDGkeANfLt0fwhg4zevAKgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdXpYV+pbiOwiCjZ+aZYR-xPDGkeANfLt0fwhg4zevAKgg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Aug 2021, Geert Uytterhoeven wrote:

> On Tue, Aug 3, 2021 at 5:56 PM Lee Jones <lee.jones@linaro.org> wrote:
> > A recent attempt to convert the Power Reset Restart driver to tristate
> > failed because of the following compile error (reported once merged by
> > Stephen Rothwell via Linux Next):
> >
> >   ERROR: "machine_restart" [drivers/power/reset/restart-poweroff.ko] undefined!
> >
> > This error occurs since some of the machine_restart() instances are
> > not currently exported for use in modules.  This patch aims to rectify
> > that.
> >
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> > NB: If it's safe to omit some of these, let me know and I'll revise the patch.
> 
> How do you plan to handle that? Isn't this an all-or-nothing export?

That's the way I see it, but I don't have an in-depth knowledge of all
of the architectures.  There may be a method there that isn't part of
the core API.  If that's the case, I can drop the export.

> >  arch/m68k/kernel/process.c         | 1 +
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks Geert.

I'll pick this up when I do the re-spin shortly.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
