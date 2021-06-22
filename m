Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175403B01B7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 12:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhFVKuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 06:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbhFVKuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 06:50:17 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA2FC061756
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 03:48:01 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m3so12501083wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 03:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=TcUa3oSLANdktYnkP5q+ONN+THT7Iggm9MfRQHIR0pQ=;
        b=MyEXlunycAFENLsOQanw8aJoDEgUKECP3HKTWIVS/tFeBaY7xN23K5slVSufsuFDsj
         0awsPRV7jcFJyntP9h8BGXeXELoaoY+lGZY1LxRh8NMHcgV6VE2b7xKGAkz+OVAD8eUT
         gKGVYbDTz8MgTfy3bmU/snSK8uB25ffZFBrt+o2lCk0oLTw3g/MMEy+zAX6nI7yZrUtU
         jN8uGETWnLx45eLg/506pLQExmmALFNZKBdATcs7abP3/YH6FXrgRElgAZS9BIvzH4eI
         8wo5nZHZBKOmDONmZO+ySPio4tq1puds4m07POMZ14eJB8P5O9XuNa0EUNcOqEDnzD58
         EZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=TcUa3oSLANdktYnkP5q+ONN+THT7Iggm9MfRQHIR0pQ=;
        b=nbdt5PIYF8yHTM7Wi0LwdPJh6KH+1+GG71wra/FzkC7+ian0o5v7kWbbxptHgWFQg9
         n3T0AFzSaqSnDOS8uHZvG6cWZ7T13o4EIn/+dfZOhLtQ29XTkWRTbO0iqVSkMHK9AHFI
         uRhr8wr8vB3me46pRW3mTqs1uOD+QwyXadlNkZbunuteO/6Q1nV3rDBzK2ZoaC+rrW25
         oxKK4aPk/QT8DguBW5yoU1uhA/N8YWk5Zs3gz+2QNaWwiKR60UZpon5HOffdOxK1ivwg
         ICfWUAec6dcZmZmqC4eHLBkcSPyGPwMELtSk4Ptwpt6dHDJnWZHrYQ0Fr5KTWyOI4EpC
         NBCQ==
X-Gm-Message-State: AOAM531JI8MrjyqGea/1uM+RSZJh7ivoYFb4ZSnJmug/w/JyOUhQvgTP
        BEx2TVwvWj91sI16HfGUHH/EaSq1z3djsA==
X-Google-Smtp-Source: ABdhPJxIsHGF8+r3v9hJEu3xJuMzgJE+oGBYEUmxnxnIeM+wZ9p480zvfXB/Zxyx4b8OnI0awFD2xg==
X-Received: by 2002:a1c:4954:: with SMTP id w81mr3800576wma.182.1624358880393;
        Tue, 22 Jun 2021 03:48:00 -0700 (PDT)
Received: from dell ([91.110.221.181])
        by smtp.gmail.com with ESMTPSA id t9sm2082733wmq.14.2021.06.22.03.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 03:47:59 -0700 (PDT)
Date:   Tue, 22 Jun 2021 11:47:58 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        linux-kernel@vger.kernel.org,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 21/24] usb: host: xhci: Move array of structs from the
 stack onto the heap
Message-ID: <YNG/3pqMNYEHgcP3@dell>
References: <20210526130037.856068-1-lee.jones@linaro.org>
 <20210526130037.856068-22-lee.jones@linaro.org>
 <8551978f-27b0-767e-f92b-e96ab3064b33@gmail.com>
 <20210526144451.GB543307@dell>
 <ad5d3a04-c065-675e-c53f-5d48b6367c89@gmail.com>
 <20210526152835.GE543307@dell>
 <23bb1fc5-acff-74a6-c67a-11b0e0d85011@linux.intel.com>
 <20210601092513.GC543307@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210601092513.GC543307@dell>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Jun 2021, Lee Jones wrote:

> On Thu, 27 May 2021, Mathias Nyman wrote:
> 
> > On 26.5.2021 18.28, Lee Jones wrote:
> > > On Wed, 26 May 2021, Sergei Shtylyov wrote:
> > > 
> > >> On 5/26/21 5:44 PM, Lee Jones wrote:
> > >>
> > >> [...]
> > >>>>> Fixes the following W=1 kernel build warning(s):
> > >>>>>
> > >>>>>  drivers/usb/host/xhci.c: In function ‘xhci_reserve_bandwidth’:
> > >>>>>  drivers/usb/host/xhci.c:2859:1: warning: the frame size of 1032 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> > >>>>>
> > >>>>> Cc: Mathias Nyman <mathias.nyman@intel.com>
> > >>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > >>>>> Cc: linux-usb@vger.kernel.org
> > >>>>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > >>>>> ---
> > >>>>>  drivers/usb/host/xhci.c | 8 +++++++-
> > >>>>>  1 file changed, 7 insertions(+), 1 deletion(-)
> > >>>>>
> > >>>>> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> > >>>>> index ac2a7d4288883..40ce4b4eb12ad 100644
> > >>>>> --- a/drivers/usb/host/xhci.c
> > >>>>> +++ b/drivers/usb/host/xhci.c
> > >>>> [...]
> > >>>>> @@ -2788,6 +2788,10 @@ static int xhci_reserve_bandwidth(struct xhci_hcd *xhci,
> > >>>>>  		return -ENOMEM;
> > >>>>>  	}
> > >>>>>  
> > >>>>> +	ep_bw_info = kzalloc(sizeof(*ep_bw_info) * 31, GFP_KERNEL);
> > 
> > GFP_KERNEL might not be suitable for all cases.
> > 
> > xhci_reserve_bandwidth() is called from xhci_configure_endpoint(), which again
> > is called from a lot of places.
> > For example from xhci_update_hub_device() which can be called with GFP_NOIO mem_flags.
> 
> What do you suggest as an alternative?

Just working on rectifying this now.

Which Get Free Page flag do you suggest here please?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
