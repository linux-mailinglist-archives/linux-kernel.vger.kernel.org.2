Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B54E417CDE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 23:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348529AbhIXVN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 17:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbhIXVNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 17:13:55 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C197CC061571
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 14:12:21 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id v10so36389196edj.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 14:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fln/GmzM5DcyRx7UwX874sUGXeT/rIbA9LYWk0Uly7s=;
        b=Tz5laGboS2hQTVSuQZSQjRHkiVrCRzF837aWkMY2kE3Ijyoe494iuXfPDCcX8bho4p
         cUPamznVW0ev+K+mE1b0/xLP2MMbngsmO5TOeIiPOcWxrXR/s3pTYYMblqVN2/1i27Ao
         nQ+GqDY1at7vfhx8+0+e35ImaDIJeLTIHYvzH1zP+R9hSynhB7jn52M1bCEQTGyGus+R
         e45MsyaFuR/6ZcuTEOeqZB8BXWCUpfnSFax1kOOx7KlbRV1dVG0Lbx1Mi78pfr272yhs
         3M0oCCxpeYo0WIAAqnNiry6XQ24wLSV0CfeJoEEsREmIQNSjGVbNEJ6k4bVM5qrHNDCH
         h3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fln/GmzM5DcyRx7UwX874sUGXeT/rIbA9LYWk0Uly7s=;
        b=NPe4/nWYWmCru5qSsongYBBUcevxBfowjqG4iV7lYEQqb40/hLjXyg+McZHZwd6Qfj
         EOVs7th4YEfLEgya3wApKmhuk5DxtMAS6QaRgw6EV5LeM4q3Z9LHsbdvLtXZWAEhCR0V
         wVryYRGAyFbdOjq0Li6iU+0TArBP/8qGLUgtN1X+QSK8yOh4RJen436mfISZU3+Q01W8
         kRes1XFMyGT4mWtbbVfTV6A4HWE7iVfFJQwf8I9NeSG/oyC0WqwVI+i7EksOmz97GucV
         vwHqNW8s3oqOqJpookXLXk+MSwKesAvJkFYhZ1w3HP1mx9j5WfHQHej478rh3gq4iZVg
         YJAQ==
X-Gm-Message-State: AOAM531hnQBkPBk34fVgA/iYGrF2QL6WCWUhiRedRrYSiCcarKg/zBwX
        ifvFRy9AIyJ3+GkBJz7ldYg=
X-Google-Smtp-Source: ABdhPJwhWCtAI9yRPrnORDj5ikTTLnZOAUjz0nP5i3BAGeMcZDOyzLfM4iEHZ9cQecZKSiaEnZWq1A==
X-Received: by 2002:a17:906:19d8:: with SMTP id h24mr14009510ejd.490.1632517940373;
        Fri, 24 Sep 2021 14:12:20 -0700 (PDT)
Received: from tom-desktop (net-93-71-218-228.cust.vodafonedsl.it. [93.71.218.228])
        by smtp.gmail.com with ESMTPSA id e13sm5589833eje.95.2021.09.24.14.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 14:12:19 -0700 (PDT)
Date:   Fri, 24 Sep 2021 23:12:17 +0200
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Yujia Qiao <rapiz@foxmail.com>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        Marcos Antonio de Jesus Filho <mdejesusfilho@gmail.com>,
        Edmundo Carmona Antoranz <eantoranz@gmail.com>,
        Aldas =?utf-8?B?VGFyYcWha2V2acSNaXVz?= <aldas60@gmail.com>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: vt6655: Replace camel case variable name
Message-ID: <20210924211217.GC10906@tom-desktop>
References: <20210922220802.584952-1-tomm.merciai@gmail.com>
 <4972337.8pBPQsAWaL@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4972337.8pBPQsAWaL@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 09:54:12PM +0200, Fabio M. De Francesco wrote:
> On Thursday, September 23, 2021 12:07:49 AM CEST Tommaso Merciai wrote:
> > Work in progress: replace camel case variables
> > 
> > PortOffset -> port_off_set
> > 
> > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> > ---
> >  drivers/staging/vt6655/baseband.c    |   6 +-
> >  drivers/staging/vt6655/card.c        |  88 ++++++++--------
> >  drivers/staging/vt6655/channel.c     |  10 +-
> >  drivers/staging/vt6655/device.h      |   2 +-
> >  drivers/staging/vt6655/device_main.c | 144 +++++++++++++--------------
> >  drivers/staging/vt6655/mac.c         |  46 ++++-----
> >  drivers/staging/vt6655/power.c       |  24 ++---
> >  drivers/staging/vt6655/rf.c          |  12 +--
> >  drivers/staging/vt6655/rxtx.c        |  12 +--
> >  9 files changed, 172 insertions(+), 172 deletions(-)
> 
> If you split "Offset" into "Off set", you convey the message that something 
> is "Off the set". Probably that's not what you want to express.
> 
> Regards,
> 
> Fabio
  
  Thanks, you're right. Resend V2.

  Tommaso
> 
> 
