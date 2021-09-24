Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F79417CC6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 23:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346831AbhIXVKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 17:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbhIXVKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 17:10:48 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39887C061571
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 14:09:15 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id eg28so41185257edb.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 14:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9l0vLnZ07LMXxy/IHB8Q/PtOVi8eVZesGOSTgkOJwlA=;
        b=Ho/3CJvliGeBvjWN5lR83BRCWF8WjNxzn3BWENEZtG322ntHBBn3y6J5SbUupR3T5F
         6r7IzFRIAOcfbZhhvUKojnai+dqfuxNtXQ9i+pufen4rFVK8rP5rHaeqGFePf/3nxfbf
         3vFqOex2Digiv6Zj+8DdRUKiLZ6RDXId9JfCSLTOyYja3hL/3ulV7BDiqzD4U7inXITq
         Y5kW91w5cu+ENUBThE9LjwnvgrmccxK1NqyzxuL6uR24VXg76DRT/KrxnQyd5kftY0kv
         AN4QXLRDb4mNO+SjgnvwSKFSqzA0uWzdv9Ym6XpyULWmGPlNrfGjY1BCiRt7sF6HSN4+
         qRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9l0vLnZ07LMXxy/IHB8Q/PtOVi8eVZesGOSTgkOJwlA=;
        b=GohK3dIiwdCzewBeHd2iSc0hzuYItQXAahSmcu/CygUIm0cZ0D+e3xZDBirI16isXw
         ETvnCVOnSNzRACRv2Ek3riz8R0c12jSpFKfxkz17hHZJwLgLNjKrwwrs5DhZ/dm4UTYd
         9LJ1bYITwX0jmNdvAUV0oF4fecV4YB/zpnpytDJX9PVXGayj36t6fDbkjYi79UM1C+5T
         N8TizMI4jz21UoVe3YEDM+I+iJfkBdNJV9pGy1knD8/0CU2ACjYOUG9/N8tsloSu0P6p
         SyL4mJ4O5AqVgG00Z0eLcrrBzUmO8gtdlgMBawC2uwLY3NoEjAuwriiy/oggWt3Ml3Ku
         7QVg==
X-Gm-Message-State: AOAM532aLm0hkOYuWyE01L3M/0hx/eiFbM4lt3zT/vquAXMfaoSSXosC
        Gs1+8HQheplSlrifu5a6C+o=
X-Google-Smtp-Source: ABdhPJzPa4o/AIzPwMBAtAiqTMKOhVx6IUQVvjhTdoIjpuk8tM2p0hr7yj2l6zDt27LiZBtysNS0Xg==
X-Received: by 2002:a50:e1cd:: with SMTP id m13mr7509421edl.93.1632517753771;
        Fri, 24 Sep 2021 14:09:13 -0700 (PDT)
Received: from tom-desktop (net-93-71-218-228.cust.vodafonedsl.it. [93.71.218.228])
        by smtp.gmail.com with ESMTPSA id d22sm5541293ejk.5.2021.09.24.14.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 14:09:12 -0700 (PDT)
Date:   Fri, 24 Sep 2021 23:09:10 +0200
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Yujia Qiao <rapiz@foxmail.com>,
        Marcos Antonio de Jesus Filho <mdejesusfilho@gmail.com>,
        Edmundo Carmona Antoranz <eantoranz@gmail.com>,
        Aldas =?utf-8?B?VGFyYcWha2V2acSNaXVz?= <aldas60@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6655: Replace camel case variable name
Message-ID: <20210924210910.GA10906@tom-desktop>
References: <20210922225138.668520-1-tomm.merciai@gmail.com>
 <6695e45f-4530-ab39-923d-8347649762bb@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6695e45f-4530-ab39-923d-8347649762bb@embeddedor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 06:12:37PM -0500, Gustavo A. R. Silva wrote:
> 
> 
> On 9/22/21 17:51, Tommaso Merciai wrote:
> > Work in progress: replace camel case variables
> > 
> > PortOffset -> port_offset
> > 
> > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> > ---
> 
> When someone gives you feedback and you have to respin your
> patch, you should version the patches that you resend, and
> mention what changed, here:
> 
> Changes in v2:
>  - Variable should be port_offset instead of port_off_set.
  
  Thanks, you're right. Resend V2.

  Tommaso

> 
> I encourage you to take a look at this:
> 
> https://kernelnewbies.org/Outreachyfirstpatch
> 
> It will be of great help if you are trying to land
> your first patches. :)
> 
> --
> Gustavo
