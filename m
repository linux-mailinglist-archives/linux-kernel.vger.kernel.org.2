Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB79C417DB5
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 00:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236288AbhIXWUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 18:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhIXWUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 18:20:12 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC1EC061571
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 15:18:39 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id dm26so7299417edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 15:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UuF9SWLSjABI/1Jpz43G/QsqNJ35Tke8xKdnzurRjxs=;
        b=cLYtdLZJbkvxLJd1sTMJw+QDInA8HpR9XQBa+CWRGvhogu8ULr72KPvgR56M3LjzAg
         4f5wmJ6//MaPxObEhZZbtXVA2X9tYkn/NgzSM5k0cAjGWhTR/f/G0CWTQqW2PiQUOMSG
         xpQch3aPzmZdUVvWCKAH3mOmuMnBpEMr5yrvL/dqhu2GPdWKyhmQz2ufcNHfYFfvyQVj
         6F8jSsPwm2Xpt/u+WuSvNdSas+93iNpkc8KNitOxhK3aueujuAi8kfS6BKH42YAcWbt9
         t39io5IaLTBlfaktX3SGeRAAutODf+ADtEVsjczMZn69ZPvq/NCPEPQVeIQYEq07aN4g
         hQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UuF9SWLSjABI/1Jpz43G/QsqNJ35Tke8xKdnzurRjxs=;
        b=HGI0O0NzuOf0nIIIADYxgoKAbBIXoJvKhATYVi4saZQXMKFk7uqGc42Eq/T4QmPJmI
         UYEzIbyBC9vX9+VmW8Ks1mJYqJLGLM/VPVncIOWI8MAHzaMhZQtqxmp09orZQsS6mqyM
         NqKUsydj2AIMrWUDIvun8Xc7lkJT3auQf8iFJS4GKwn3PRGhvkw8oRhOvGXKIKwdZZNI
         uffe6oE3TlkdhKGB3X3O/25hRztFERxXjPNIH3IzCzQt6Af7zEpUX+a9hTqZUPgsDtL+
         Hc1lsBJ6JdsSuYuFhONspYuaDeWFhM82X7PO6cOTpTfO3azXoQRsTLkL5gTPVSSFPiyd
         Pj3Q==
X-Gm-Message-State: AOAM531F8lWXFeO0iHqmjttI2almUlvvFmrqrXqwir1zX/p0yruQ3zBI
        MuK2E6PwOahXecPkTryHbks=
X-Google-Smtp-Source: ABdhPJz7byuw2ETHYLzDyK7KhWdN7sO9wjBSpybLNIVjBoCaAaHJlo+Yy50C+xz6fOIdiepWaIjNzA==
X-Received: by 2002:a17:906:4e8d:: with SMTP id v13mr13830793eju.436.1632521917565;
        Fri, 24 Sep 2021 15:18:37 -0700 (PDT)
Received: from tom-desktop (net-93-71-218-228.cust.vodafonedsl.it. [93.71.218.228])
        by smtp.gmail.com with ESMTPSA id cf16sm763461edb.51.2021.09.24.15.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 15:18:37 -0700 (PDT)
Date:   Sat, 25 Sep 2021 00:18:35 +0200
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Yujia Qiao <rapiz@foxmail.com>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        Marcos Antonio de Jesus Filho <mdejesusfilho@gmail.com>,
        Edmundo Carmona Antoranz <eantoranz@gmail.com>,
        Aldas =?utf-8?B?VGFyYcWha2V2acSNaXVz?= <aldas60@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] staging: vt6655: replace camel case port_offset
 instead of PortOffset.
Message-ID: <20210924221835.GB4788@tom-desktop>
References: <20210924210008.106355-1-tomm.merciai@gmail.com>
 <20210924210008.106355-4-tomm.merciai@gmail.com>
 <58c61a30-c368-8e4f-d9c9-1f39cadda869@embeddedor.com>
 <20210924220142.GA4788@tom-desktop>
 <cb4c2cfe-a2ad-a72d-16c2-02dcf4d32ab8@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb4c2cfe-a2ad-a72d-16c2-02dcf4d32ab8@embeddedor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 05:15:46PM -0500, Gustavo A. R. Silva wrote:
> 
> 
> On 9/24/21 17:01, Tommaso Merciai wrote:
> > On Fri, Sep 24, 2021 at 04:56:16PM -0500, Gustavo A. R. Silva wrote:
> >>
> >>
> >> On 9/24/21 16:00, Tommaso Merciai wrote:
> >>
> >> Where is the changelog text? :/
> >>
> >> Sorry but I insist: take a look at this:
> >>
> >> https://kernelnewbies.org/Outreachyfirstpatch
> >   
> >   Hi Gustavo,
> >   You mean the changelog in the cover letter?
> 
> That's not how it works. :)
> 
> What's the hurry?
> Check section "Versioning one patch revision" and then read the
> whole thing, so you can learn how to smoothly land as many patches
> as you want:
> 
> https://kernelnewbies.org/Outreachyfirstpatch
> 
> --
> Gustavo
  
  Hi Gustavo,
  Thanks again for your time. I will read it and retry.

  Tommaso
> 
> > 
> >   Thanks.
> >   Tommaso
> >>
> >> Thanks
> >> --
> >> Gustavo
> >>
> >>> Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
