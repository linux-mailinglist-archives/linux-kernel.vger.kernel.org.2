Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 044F538C0BB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 09:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235590AbhEUHaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 03:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbhEUHaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 03:30:10 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A1FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 00:28:48 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id x8so19986951wrq.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 00:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lL/T9tKkLDZBnEdhk0ozmZWsOYDWqY6ffZ6HvfWIgbs=;
        b=Ceoyn7ldDAayDOl1FwPj5Ot9iRdkTEJqV8rEJMhbhQlBWqJJH2rn/24Pa1aMd0f5pY
         n+rGYbZCiOY3ZWSqVCkDBawKH/X1Bq8BAhpo3uEguIrtx1YIDv3fLJwQ4A3FtB6OhecJ
         DutqaYiyIWBrUspDN5l9sC/YgsEFmgrHzVEJP0EJEKC/B/kn9gyyr4WEK7RsDWKMwGDA
         0NypC8LmFJyGsF56/ncixXZ3+0pX8fiEfEI2VCdnJLj1MHdE3g+fwjJk1RPDZE9G+fzR
         U1a2gmyplkW9T9fJm4FHBUkdzPl8cnR3MEU2tmEluRZUvVrYRNsm1FgvkVgddfeIO3kn
         nVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lL/T9tKkLDZBnEdhk0ozmZWsOYDWqY6ffZ6HvfWIgbs=;
        b=CwjAcAqPAlLKV02oTBtukzZCUPf2hlBOJonUp0AuLBmVizF/ba727thbXkyQ0Ra4xt
         mlhfIPpT00GJd2oAwoiVlmfrLX3aimOEFkfYPwpCFzT2yunFcQkm5A7iHkXlwaDXIJfB
         zQTtIgsCu/1mKDk5NR/b/Qha5E0dZeF61B5tHfmfgRgS9OCrluAcul4ddpUsc2nMPjdO
         sRJtA9GBXsx/xPOLCGGP6SR86IFM922KVvTdl75MUfyBw5TrpJDdOel92v0u+DJ+sXQP
         Xo8S6mq82NVf5WywILck204q3yZUoyI2nJBBzwKrTwHdQ/tqn71yN1c/fVMIOsT8vWIn
         EPJQ==
X-Gm-Message-State: AOAM530m7JTCi1m8YZArjD/FpYICqSesXfZGzo2dhO6m6RGxY0GaUVb8
        tXs4FeQaq7CtbkGqb16qfPfjgA==
X-Google-Smtp-Source: ABdhPJza8l4RoojyAAr5ExFIr6FWcZiqqC3dKLk0ENmThHCjYt8xkFtyjBxsGEsyHmBGn/V14j1kgw==
X-Received: by 2002:a5d:6701:: with SMTP id o1mr8258946wru.390.1621582126616;
        Fri, 21 May 2021 00:28:46 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id e20sm11488349wme.26.2021.05.21.00.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 00:28:46 -0700 (PDT)
Date:   Fri, 21 May 2021 08:28:44 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Ian Abbott <abbotti@mev.co.uk>
Cc:     linux-kernel@vger.kernel.org,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Anders Blomdell <anders.blomdell@control.lth.se>,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 2/6] comedi: drivers: jr3_pci: Remove set but unused
 variable 'min_full_scale'
Message-ID: <20210521072844.GZ2549456@dell>
References: <20210520122538.3470259-1-lee.jones@linaro.org>
 <20210520122538.3470259-3-lee.jones@linaro.org>
 <9d0ac108-7256-be1a-fdd9-f48f52aaa38e@mev.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d0ac108-7256-be1a-fdd9-f48f52aaa38e@mev.co.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 May 2021, Ian Abbott wrote:

> On 20/05/2021 13:25, Lee Jones wrote:
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
> >   drivers/comedi/drivers/jr3_pci.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> Actually, that one is stale now (or will be when Greg's staging-next branch
> gets merged into linux-next soon):
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/?h=staging-next&id=b9f38e913a926b455e5048a95f53a993b515509f
> 
> | staging: comedi: Remove unused variable ‘min_full_scale’ and function
> 'get_min_full_scales'
> |
> | The variable ‘min_full_scale’ and function 'get_min_full_scales' are
> | not used, So delete them.
> 

No worries, if it's fixed, it's fixed.

Could you please take the patches that you are happy with.

I'll rework or drop the remainder, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
