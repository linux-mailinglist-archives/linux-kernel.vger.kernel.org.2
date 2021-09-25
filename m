Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0924180B4
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 11:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238015AbhIYJF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 05:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237084AbhIYJFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 05:05:50 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E5BC061570
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 02:04:16 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id v18so10537384edc.11
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 02:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kPe7eruAntmWYArF3I0EPN4/ZWlqsPwMhUGBU3D+dvo=;
        b=jvx1fApsAGsLZMK9vaJVnP9Z7QQ3/Vx/4WCa2bv29M8LSsfp3QVq5+Uc3p2XpLJsqO
         cKIljeQnvV8JYxGAWBX/QoC6/8IOIPwUIwxJ2C+OBQrIrOW2UqMqpI4gFbNahqQDzIW0
         J4ioESelWa4/HppAdeGeJCi51YSLUugzEq1NvbvoSg2bxRUYr6PwqEVu/+h5oi0rLo+P
         C5Y1cnoQlWXHl39DofDLtN0e8C9ZpYT0pGfuClX14K4w5FZe87BxzPptstZF1uTS3APa
         1gz0d8eSxg3W3GmQaukkyme/qyMItzzkDLmvuXne+xCSr70bcGV9jyUwJzB/FzTWsFG+
         7PhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kPe7eruAntmWYArF3I0EPN4/ZWlqsPwMhUGBU3D+dvo=;
        b=qxZ+J+3+TxI+P0UOBTN4+pfBiJzHe6u1stjv5qldkv2xSf6Wx8ptB7R3qa3zVGS8q3
         iYhTUnWIitCRW202oqlHh5SqG1IcN9AyAmsNn3INtWSUP9bmcL9rrEp6Lm0hGjbHM4j4
         ze9/OXBz/JcUVhap4PpqV5BsC+LdlkhrxEf2q/ZYWvvGxYVIbImMfMv9rD1CUnEylfE+
         c4Ww1jj9+HGDDw6MX7mq9N9hO+eKTpifM672zXBejzf0nazxVYzwPuejVSS/wVnkbogc
         8pBQFGKfnerUiXeEi6EmvLxuzNtnuBXngC8te44V3fae7R+JDwzhixtFRtP5zc6CHh1X
         uU4A==
X-Gm-Message-State: AOAM532Iw/ZRumWJgGlmylJwv6bUhbwMYwQw6ivZCBG1KLLHctPWIEGK
        /mda8nlNfzLAB4mxdUvQRqVUNhVE5Eo=
X-Google-Smtp-Source: ABdhPJxumk5Lhz7AznMan428nRWghjeaZun1PZxvQP+8m+K8I50tg8kNh2Eihl7c51a1yFs2L4YqSw==
X-Received: by 2002:a50:da04:: with SMTP id z4mr9923281edj.52.1632560654748;
        Sat, 25 Sep 2021 02:04:14 -0700 (PDT)
Received: from tom-desktop (net-93-71-218-228.cust.vodafonedsl.it. [93.71.218.228])
        by smtp.gmail.com with ESMTPSA id z12sm6886201edx.66.2021.09.25.02.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Sep 2021 02:04:14 -0700 (PDT)
Date:   Sat, 25 Sep 2021 11:04:12 +0200
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
Message-ID: <20210925090412.GB4727@tom-desktop>
References: <20210925074531.10446-1-tomm.merciai@gmail.com>
 <20210925074531.10446-2-tomm.merciai@gmail.com>
 <YU7XBPzQAq2s7d4L@kroah.com>
 <20210925084134.GA4727@tom-desktop>
 <YU7iHvNQPI81WvsM@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YU7iHvNQPI81WvsM@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2021 at 10:47:26AM +0200, Greg Kroah-Hartman wrote:
> On Sat, Sep 25, 2021 at 10:41:34AM +0200, Tommaso Merciai wrote:
> > On Sat, Sep 25, 2021 at 10:00:04AM +0200, Greg Kroah-Hartman wrote:
> > > On Sat, Sep 25, 2021 at 09:45:22AM +0200, Tommaso Merciai wrote:
> > > > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> > > 
> > > I can not take patches without any changelog text at all, sorry.
> > > 
> > > My bot pointed you at the instructions for how to write a good
> > > changelog, please read that before resubmitting.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> >   
> >   Hi,
> >   Thanks for your time. Sorry but I'm trying to check what I'm missing
> >   "Versioning one patch revision" as suggested by Gustavo A. R. Silva.
> > 
> >   https://kernelnewbies.org/Outreachyfirstpatch
> > 
> >   I put Changes since vN after git format-patch "---". Maybe I'm missing
> >   other stuff?
> 
> You are missing other stuff :)
> 
> Notably the actual text that goes in the git changelog that explains
> what this patch is doing and why it is needed.  Again, please read the
> link that my bot pointed you at.
> 
> thanks,
> 
> greg k-h
  
  Thanks again.
  Tommaso
