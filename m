Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01461418063
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 10:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbhIYInO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 04:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbhIYInN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 04:43:13 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BF5C061570
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 01:41:38 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id y12so9530105edo.9
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 01:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TWXubKOvMz8RPY80gbWSplFIj9VL/MAsdT5ulfYEg5s=;
        b=Yzhy4VYAihYPNk68Q4uYq3tw96m2O/PpPGP4Uk2zg2vo0xh3ppb8W5YTlP+53E4pI0
         u0fsuFDEcX93I7dH8bb9SgGKRjhOd9TfYhc1uG7b4KUn5bH/iH4G5oPuwifDXggazKZG
         6RrP864voUkyyf7zbDdQ8ryDqgjJUzEwb7xU/4kQmTKt1R2hM5JO0MuAdTzT3uYZbwOO
         OEKT7HpCBboY3/qBTu7ND53JX6M++SDVKMla5KSZxwhS8AxUXLI7cgfWZeTFeWH+FDNs
         0M5/a1xVi63kEi9ldYlJZfrP/r353BwWLMpI8uRNskK0t+KqMQXDXmoWfdlyXo4t0Ziz
         PZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TWXubKOvMz8RPY80gbWSplFIj9VL/MAsdT5ulfYEg5s=;
        b=S5EmoHlEq2Z4h3vDqOuHqdEdlPW3Cn49kpCsgKIaQ597GSNwSjC4HPldSR3ju4OC4Z
         U23EBXkLjOCOD9jHPW+4KD3q1BKhi3hy+GUMo9L0FL1cp+x6rs5NXVV31o6/gbLSk1dT
         +B+yphk42OIGS5cN+tQcqVD3godTBZXAGyDwL6c6dyDqdmS4OyYdLP0EHGap6cFgzajr
         zQhUL1NvrG9UrMEW8BXdmjLumfedTWw8AtkbXBUqvkpXnKHz2OGASB2vX7DBXOtpcVFD
         EMdoLO+DksfhD4hFLvLvdYJ+sLiuBQCtyQlrvQOw6mP+R0KgUGx5W+fyW7gZapnhHTU9
         m1VA==
X-Gm-Message-State: AOAM533pEcIYGZjaezoo3zQcSLNH3A2lBoX/HhWE4kvF1C6qgR2u838k
        gCmBaxO9wQ6vWOldArydjRA=
X-Google-Smtp-Source: ABdhPJx608ZOfp8CfukkMnRsT/CCD/4F5yQ2ZCozjRb8IELVkYCYHqPuEp+Fnj3pFtliU7iIPHn8gw==
X-Received: by 2002:a17:906:4ccf:: with SMTP id q15mr16221751ejt.9.1632559297269;
        Sat, 25 Sep 2021 01:41:37 -0700 (PDT)
Received: from tom-desktop (net-93-71-218-228.cust.vodafonedsl.it. [93.71.218.228])
        by smtp.gmail.com with ESMTPSA id 10sm6004676eju.12.2021.09.25.01.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Sep 2021 01:41:36 -0700 (PDT)
Date:   Sat, 25 Sep 2021 10:41:34 +0200
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Yujia Qiao <rapiz@foxmail.com>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Marcos Antonio de Jesus Filho <mdejesusfilho@gmail.com>,
        Aldas =?utf-8?B?VGFyYcWha2V2acSNaXVz?= <aldas60@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] staging: vt6655: replace camel case
 b_short_slot_time instead of bShortSlotTime.
Message-ID: <20210925084134.GA4727@tom-desktop>
References: <20210925074531.10446-1-tomm.merciai@gmail.com>
 <20210925074531.10446-2-tomm.merciai@gmail.com>
 <YU7XBPzQAq2s7d4L@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YU7XBPzQAq2s7d4L@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2021 at 10:00:04AM +0200, Greg Kroah-Hartman wrote:
> On Sat, Sep 25, 2021 at 09:45:22AM +0200, Tommaso Merciai wrote:
> > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> 
> I can not take patches without any changelog text at all, sorry.
> 
> My bot pointed you at the instructions for how to write a good
> changelog, please read that before resubmitting.
> 
> thanks,
> 
> greg k-h
  
  Hi,
  Thanks for your time. Sorry but I'm trying to check what I'm missing
  "Versioning one patch revision" as suggested by Gustavo A. R. Silva.

  https://kernelnewbies.org/Outreachyfirstpatch

  I put Changes since vN after git format-patch "---". Maybe I'm missing
  other stuff?

  Thanks for your patience.
  Tommaso
