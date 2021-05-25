Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3D138F8DA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 05:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhEYDeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 23:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhEYDeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 23:34:23 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5970C061756
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 20:32:53 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so27262329oth.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 20:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6Y5oK5vW+T21O5OAKzPC8r5w90JD3+B+yQGGc1yRB6w=;
        b=bT5pDSpFo9iPBIuOv4+ktrHZ/to73R8DrxvaSL1vu9VZG57l4+Hki8/0www/Wy8uCo
         4yc85wcpDh7u4/FXjqYkznMpdh60J/AgbuPiaiQjxoiXppGDUupddmzXldCyK/NR2fh3
         qlf9VeNy1Cegg+b7rvokrjYlaKNnIgCEPrfkuhDKuDITxcWYiI1ilbrMx0yUb0l1gjgR
         XrUObTvjzragPptGXntV74m5oGGQ/NYZajmLAH7hF4x6EF1jLzTf0laq2N8ila6oFDi1
         Jtm9vu76IYDLeepOPDRrvr+1zQGpuDstM5Pxhe/LJZGxsyaDFfnyy2tPSO1vDC7kRJB7
         UJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6Y5oK5vW+T21O5OAKzPC8r5w90JD3+B+yQGGc1yRB6w=;
        b=tRJtwu/GS/QNig8+Qg2uowTVwInWnK5TNsxb2XeZttgu8g0/num5qybkrwpVhMnDtk
         DFRkL0JNmliO55gW/AhI9fXBgD4gXZ4v+c6mEQgK9GXeLc7GNPclNT8L1SomvEssdQ6e
         9Tz+xg7kfEenoK2O4CSam2u1lYx/BSP55DnKsogHlInkyeCgg16ERW8/Ou8vyK7ZHOV4
         ZVluzOQgXXouHGwAaIfO2ZsewvRFFL4nTvQhXdugoPwwP7Z/8VVEMNXwZkyZNfSazQ4k
         2AQF2zIlfmrymSpXfJqUW6hlI+9mb3UHVypO8cMz0POXUREPMCPSoPGCj40R47pNNw9z
         C+Cw==
X-Gm-Message-State: AOAM532EiRnrIz6ppnBC8/UsEv9VW8n/KltaMbwAHIyXrmnf/Id9Kqzg
        eVO/klbSFIz77VDxfOLmZX2xmh3j3O1Y0A==
X-Google-Smtp-Source: ABdhPJwN1NZlTvBjdJW3k+BDrCONIgMoegnREK22KoQp4Y5UADt29qHuaIc3pG4DSG+NUI1041P/QA==
X-Received: by 2002:a9d:4b9c:: with SMTP id k28mr21671489otf.183.1621913573206;
        Mon, 24 May 2021 20:32:53 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id i18sm3216334oot.48.2021.05.24.20.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 20:32:52 -0700 (PDT)
Date:   Mon, 24 May 2021 22:32:50 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Elliot Berman <eberman@codeaurora.org>,
        Sebastian Reichel <sre@kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Trilok Soni <tsoni@codeaurora.org>, rananta@codeaurora.org,
        open list <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/2] reboot: Export reboot_mode
Message-ID: <YKxv4h8ebMQlNR37@yoga>
References: <1573256452-14838-1-git-send-email-eberman@codeaurora.org>
 <1573256452-14838-2-git-send-email-eberman@codeaurora.org>
 <CAF2Aj3jYtL_42h_4W5zA8uz9e-QVquja70nARSRD4vbECVjxKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF2Aj3jYtL_42h_4W5zA8uz9e-QVquja70nARSRD4vbECVjxKw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 24 May 07:09 CDT 2021, Lee Jones wrote:

> On Fri, 8 Nov 2019 at 23:41, Elliot Berman <eberman@codeaurora.org> wrote:
> 
> > Export reboot_mode to support kernel modules wishing to modify reboot_mode.
> >
> > Signed-off-by: Elliot Berman <eberman@codeaurora.org>
> > ---
> >  kernel/reboot.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> 
> Reviewed by Bjorn and GregKH, but never merged.
> 
> I guess all the parties are still solving this downstream.
> 
> Andrew, is this still something you'd consider?
> 

Seems more reasonable that it would go together with patch 2, which
Sebastian pointed out doesn't build.

Regards,
Bjorn

> diff --git a/kernel/reboot.c b/kernel/reboot.c
> > index c4d472b..b1fbc22 100644
> > --- a/kernel/reboot.c
> > +++ b/kernel/reboot.c
> > @@ -32,7 +32,9 @@ EXPORT_SYMBOL(cad_pid);
> >  #define DEFAULT_REBOOT_MODE
> >  #endif
> >  enum reboot_mode reboot_mode DEFAULT_REBOOT_MODE;
> > +EXPORT_SYMBOL_GPL(reboot_mode);
> >  enum reboot_mode panic_reboot_mode = REBOOT_UNDEFINED;
> > +EXPORT_SYMBOL_GPL(panic_reboot_mode);
> >
> >  /*
> >   * This variable is used privately to keep track of whether or not
> > --
> > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> > a Linux Foundation Collaborative Project
> >
> >
> 
> -- 
> Lee Jones [?????????]
> Linaro Services Senior Technical Lead
> Linaro.org ??? Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
