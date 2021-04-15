Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6085436063B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 11:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbhDOJxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 05:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbhDOJxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 05:53:17 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2F6C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 02:52:52 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id o20so997137edc.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 02:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jqk85jcp1CgJeODOUcztiz6h1RU5+xOxDLRjfSfhkOA=;
        b=Uc+nG8spCoPVY15XaL+6cF2AqftQ74Ym6tZcb+zNAp9y0LPcEOb2vHyFESETHdoASf
         h8w5tELp6L4a5truv4RxGQnLAMNPki5oun3jvdjeG21T8/tKZRBNlByWh6TAuGLnd85/
         w59HJ572Gb7oiYUYnTn6ViTtn7kh6Dop64KJY0nJ4vt5t1/gG5WDt9Fd6Bw1mgFvqNJz
         nUvBjqvVU/MiH6EtTUT8GvcdbUxAPftOFGq75hqY1mp+UhJR/NviftUwKdthjI7S939l
         N9ZMOOceLLjgYpBptVUmJ0YhvZHNLSIJeGPlL+jETS0gBXO8hfeJi5n76AyknW4nCy8Q
         3qtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jqk85jcp1CgJeODOUcztiz6h1RU5+xOxDLRjfSfhkOA=;
        b=tCt5p1zurhRcp9PJKrNL01QAjufOVyKoI/3TAyGLg9pz6z8lHyoWUSupE21a4SLgp+
         SbbtId0BKR3chDvZohg2ELaEv6Q8wo5zQsm8VZXgnfnkY7osTUYAtl02l10Kpr26G7JI
         hR31CVGwU8JKbTDqyBqyNKY+n3ISixFBLNYXIRjeLfLTkT7RshBi0uhgrj4pHVk3ylNw
         X2Dug3866Ru1BghPju/VqvIYVAAgsf0Sp7YCmkKWWdn0QFVWurt+M8l2xewnJEq0v5uV
         UYPHG0DgKF0cKAXH9Wbn2D/rhdpueikX3SgGO1f7EhZGv1lo7iSNrEwndVV0gIOoR1BF
         RYFw==
X-Gm-Message-State: AOAM532tI8GoyHk6vD4k8f+H27nTVL8ps4EWJmIc9MUN0y1wr3OfWB34
        wTlhj5wAi4BbuweMIbWJhOnTPI+6CXx5dw==
X-Google-Smtp-Source: ABdhPJzMheoKxuIQgjFPHqkXkWDzlviec56G0OscLsDaNGS3wOE2qrJj6tmNFKXrXXotnYFJf6Y1cQ==
X-Received: by 2002:aa7:c247:: with SMTP id y7mr3136820edo.305.1618480371653;
        Thu, 15 Apr 2021 02:52:51 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id i10sm2000122edt.3.2021.04.15.02.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 02:52:51 -0700 (PDT)
Date:   Thu, 15 Apr 2021 10:52:49 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Ian Abbott <abbotti@mev.co.uk>
Cc:     linux-kernel@vger.kernel.org,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Anders Blomdell <anders.blomdell@control.lth.se>,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 48/57] staging: comedi: drivers: jr3_pci: Remove set but
 unused variable 'min_full_scale'
Message-ID: <20210415095249.GW4869@dell>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
 <20210414181129.1628598-49-lee.jones@linaro.org>
 <9ccd6fe2-91ce-3a0d-d652-567ecf6b8b0a@mev.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ccd6fe2-91ce-3a0d-d652-567ecf6b8b0a@mev.co.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Apr 2021, Ian Abbott wrote:

> On 14/04/2021 19:11, Lee Jones wrote:
> > Fixes the following W=1 kernel build warning(s):
> > 
> >   drivers/staging/comedi/drivers/jr3_pci.c: In function ‘jr3_pci_poll_subdevice’:
> >   drivers/staging/comedi/drivers/jr3_pci.c:507:22: warning: variable ‘min_full_scale’ set but not used [-Wunused-but-set-variable]
> > 
> > Cc: Ian Abbott <abbotti@mev.co.uk>
> > Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>
> > Cc: Anders Blomdell <anders.blomdell@control.lth.se>
> > Cc: linux-staging@lists.linux.dev
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >   drivers/staging/comedi/drivers/jr3_pci.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/comedi/drivers/jr3_pci.c b/drivers/staging/comedi/drivers/jr3_pci.c
> > index 7a02c4fa3cda8..afa2f8d5c8c0c 100644
> > --- a/drivers/staging/comedi/drivers/jr3_pci.c
> > +++ b/drivers/staging/comedi/drivers/jr3_pci.c
> > @@ -504,10 +504,9 @@ jr3_pci_poll_subdevice(struct comedi_subdevice *s)
> >   			result = poll_delay_min_max(20, 100);
> >   		} else {
> >   			/* Set full scale */
> > -			struct six_axis_t min_full_scale;
> >   			struct six_axis_t max_full_scale;
> > -			min_full_scale = get_min_full_scales(sensor);
> > +			get_min_full_scales(sensor);
> >   			max_full_scale = get_max_full_scales(sensor);
> >   			set_full_scales(sensor, max_full_scale);
> > 
> 
> get_min_full_scales() could be removed altogether.  It was only being called
> originally so the driver could printk the values, but those printks have
> since been removed.

Even better.  Thanks Ian.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
