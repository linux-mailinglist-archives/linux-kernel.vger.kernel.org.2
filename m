Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965CD430309
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 16:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbhJPOf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 10:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbhJPOfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 10:35:25 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99999C061570
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 07:33:17 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v17so31591545wrv.9
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 07:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=idYztUyu5/NmJ0nSrqXeX0um6ddWJVBcDb90sOh6alA=;
        b=p4XbeylLjQhni1UJ8oKQys3fJiPZNxE04sbcPo9oeh9VOUPxMoN7IEwoI+arZe7orA
         P0LrLMPC2sLe6DStZ2SqmsnBYdoIVYP2R6FmgnzwYfSbXA2OAkn5lWou/+87n1N3Hjac
         eZ86YYLN/EG0qCWNaP+cjnR/WMpXmk80lERhXXZ5rFNJy7EAMa0+2LHR1n0mpS7CD9Ne
         WSjwRg1xm7m+2nIEGqXiZ1M5ptyElhMrGOwrESVC8nRAwX8t/79B4M+Z8oB4360Seg4A
         +VlsdKBQajR/9qXZNLRopoqW8XLw6DYP7oN8F3eCHoaHiw6zWz1WynlrY8OQNK6pSvOg
         2SOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=idYztUyu5/NmJ0nSrqXeX0um6ddWJVBcDb90sOh6alA=;
        b=3Qan7zBPH0BSEAiu8LwmAW2dLYc3ulRXa/XtzLvhpbbpfKPI2j8XJpLe/wMN88TlsP
         oqWrj65FkPNQiC6zqcNZTBh9zrOD61lpO7D8vHFFA0gcejiU6YlOqN0BboVu3WOlpIjJ
         R09dcVtX82op/hbjRutB6yPMwGaICiWmltohqsTZdz+r1/aOXD7h/qs3+CyHUIDAnyhJ
         MPLtI9z+1CGamzZKrlK2mK0PDAPSdeKsphTSBl9gQDS98dr60Ix8Sk9DpQdYLxjbEw0g
         nf2n8DUqBqlAXVc3rg3/9xhFLtwdESfB+StgVf8KFIpzRJyzwbVoGXDTjgGF6ttXkkc4
         TatA==
X-Gm-Message-State: AOAM533hEbfnTOd6TFBRkx9sH6s27va9Lv1OFfjmbKnBrZmI6BE17xJe
        BaS5zZSfBFdqNruM9J7SN+UKSGaxshjREg==
X-Google-Smtp-Source: ABdhPJxp8A6H5iId25YJ1awwSy3ISnoW5kjD9/jfit8S8kB8k77RN6ZxXS4EhVhlr1pisZz3AvI6Jw==
X-Received: by 2002:a5d:6e8d:: with SMTP id k13mr22321139wrz.295.1634394795614;
        Sat, 16 Oct 2021 07:33:15 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id g12sm13315099wme.3.2021.10.16.07.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 07:33:15 -0700 (PDT)
Date:   Sat, 16 Oct 2021 15:33:13 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: Re: [RFC PATCH] staging: r8188eu: Use completions instead of
 semaphores
Message-ID: <YWriqaly1skBHnIX@equinox>
References: <20211015110238.1819-1-fmdefrancesco@gmail.com>
 <YWm/x56aX+rNOlE0@equinox>
 <5414235.RPW7nLbG7U@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5414235.RPW7nLbG7U@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2021 at 08:59:27AM +0200, Fabio M. De Francesco wrote:
> P.S.: No need to apologize at all :)
> 
> I had noticed that you haven't been around for a while. I would have 
> appreciated a review from you (and Larry) on the series of 32 patches that 
> Pavel Skripkin and I co-developed and submitted some weeks ago.
> 
> However, I am 100% sure that you really had some important reasons for not 
> being here.
> 
> > 
> > Regards,
> > Phil
> > 
> 

I have no excuse, other than simply not having enough hours in the day
:-)

Regards,
Phil
