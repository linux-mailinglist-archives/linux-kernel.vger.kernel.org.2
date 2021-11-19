Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2463E456EC5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 13:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234923AbhKSM06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 07:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234715AbhKSM05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 07:26:57 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98512C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 04:23:55 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id e3so42021900edu.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 04:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MuH5rThjE7AvNyMQmLc848IhLLeZHT+gUERcim6VkF0=;
        b=TS7FXlTOmqFvzipR3Itk3Umc3qnNUwe1nhkqpQ3ILKjuKdzftSFs5TWRRF6vx8BDrw
         xo7wHlm9E0oPaWn7gqXPWK5JiYcZdIjmr0lm+cq0RXkUhIEKPHN1nKwYCPSaA2WC+8I4
         oQrt43EyZO9s9wbf4fmbHzhyK3f63c4tCqJwrpBp90ey7guZkq4fLcmKH2K+IPAqiskK
         XRg2+pyyzwD4obSerJeoMPQesqFMGTib3mypObujRuzBTlbbDIPpp4OPpigvUv0TzaWq
         ninMtt+ALRK08dB2/n0TPyhlLnfQqbdX/5fSPDosXFpXwLbPuNZZXkgKHyATu0lGoNXf
         g3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MuH5rThjE7AvNyMQmLc848IhLLeZHT+gUERcim6VkF0=;
        b=ZJQPfw2S3gXfeB/bTsZfLYLPGjlYDvGfswiG/WhW/PyX0fBsV6AZpyExWI951JJ5gc
         KIO5ZXAuR5brvQjORfAiF4oadP6P3mzzXTyuCbBv2italY/SRacB5lztV1aPkyOAmlpq
         /0c3qKJl4vZcyrueiJVPK1s+fV9mMztmWd7YsMB0OIhWTMcGb8PeZleJqglznaK9rbW6
         lhmmR+ExjF35uxcTrNzyzhaK240Hp36s4q0XFbW1WngIwhjXUNjdLoye/7+kYIHCgES7
         qHhEqRAbMYlCvCkJ5lX8b6WJEAUxYWL44Ieh7PcUkfuVjCp30yHvjI5iuVaiDDLYp5Fk
         sCfw==
X-Gm-Message-State: AOAM530lF3bQPrUmG6FqKP3wgl8gMhxhveBjTbfYkvte1ZQRSddJufgi
        GxMtSaFYY8qJm5tvzqbdhOk=
X-Google-Smtp-Source: ABdhPJw9Zm7yVICd9q+JFfPFVWC1qPYjYnJmCimRDll3RhU37qa5+ki2ImYNo+W1f0glxr/vN0Gi1w==
X-Received: by 2002:a17:906:3c46:: with SMTP id i6mr7038004ejg.371.1637324634120;
        Fri, 19 Nov 2021 04:23:54 -0800 (PST)
Received: from alb3rt0-VirtualBox ([151.22.100.250])
        by smtp.gmail.com with ESMTPSA id b14sm1392741edw.6.2021.11.19.04.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 04:23:53 -0800 (PST)
Date:   Fri, 19 Nov 2021 13:23:51 +0100
From:   Alberto Merciai <alb3rt0.m3rciai@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        forest@alittletooquiet.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: vt6655: refactor camelcase uCurrRSSI to
 current_rssi
Message-ID: <20211119122351.GA2519@alb3rt0-VirtualBox>
References: <20211118202718.GA152832@t470p>
 <20211119085138.GR26989@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119085138.GR26989@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using the master branch of 
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/

Alberto

On Fri, Nov 19, 2021 at 11:51:38AM +0300, Dan Carpenter wrote:
> On Thu, Nov 18, 2021 at 09:27:18PM +0100, Alberto Merciai wrote:
> > Replace camelcase variable "uCurrRSSI" (current Received Signal Strength
> > Indicator) into linux kernel coding style equivalent
> > variable "current_rssi".
> > 
> > Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
> > ---
> > 
> > v2
> > - correct mailing list
> 
> Are you using the staging-next tree?
> 
> regards,
> dan carpenter
> 
