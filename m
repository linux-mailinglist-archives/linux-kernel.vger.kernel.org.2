Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847483F8ED6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 21:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243512AbhHZTkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 15:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243505AbhHZTkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 15:40:35 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE590C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 12:39:47 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id n27so8737803eja.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 12:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=k0TN+1OXwj1OvOaPyWX765yOTzhznhjpBp8I73Q7icY=;
        b=DK5zXCVzSZz/Xzh0vtV6p9he9ljx28tLWBFqdR0+QwSIivV8UKQkbM/Xepf5uR2WEE
         0CBkjyzwc/yxlILrHDxRz6Y+1rSQDHShT1zJVolTUgsUsCRUxPBr/0xttP5oJShLmDm2
         eahvoux1cLB92gDf3Lymyt3iT9ErfeVQ2HUds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=k0TN+1OXwj1OvOaPyWX765yOTzhznhjpBp8I73Q7icY=;
        b=Jr0ugg47E2H38hMHIK8RigllZJYrtkTVNaCXUJDF7lcIJOVD+7gCIih4ykQ/xm2svp
         xrPPw5Z2bX+HMHTS+eVTmogwdQcmIcJyZFJXoHW2wKelcsTIy7+wQlV5OZjDr6ivDXJ+
         wbGDIpCqJ6vbQyHGTQIRO2w/lHHNjVW15Zl8zXVY3kuglBW88dk+aM0B/i/zQ/q2ZbpQ
         dR1DFpgs+OY+WgUNngqz0pxI8Z4/aX1ZqGX3VqL66ptwVSRKFzmFSIrFsAvBsN9eDcqx
         P9BVaIuaEfV6heSuDzlqyW9LzYlPcpUYlQw15StS3/eVPHLmTMS9+c7pGHnr90YZPt7F
         gaiQ==
X-Gm-Message-State: AOAM531y0/Cr57ltjRbxKxuB8zQYyvORTgbKKRGFj+JuKkWUXPjIjT+X
        3si8BMALTkhwRGsy0HxsmDh1vQ==
X-Google-Smtp-Source: ABdhPJxPHkFJzAKrlUX5R7ClfeOsL/+djIiR8g6na/Ens9JDk5nTEi4+EBYnqBdP/H5gzhu284YCAg==
X-Received: by 2002:a17:906:704e:: with SMTP id r14mr6045015ejj.293.1630006786423;
        Thu, 26 Aug 2021 12:39:46 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id n23sm2316314eds.41.2021.08.26.12.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 12:39:45 -0700 (PDT)
Date:   Thu, 26 Aug 2021 21:39:44 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH] MAINTAINERS: Add dri-devel for component.[hc]
Message-ID: <YSfuANJ2ULizWfO6@phenom.ffwll.local>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20210826091343.1039763-1-daniel.vetter@ffwll.ch>
 <YSdzWthRL+C9/LMN@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSdzWthRL+C9/LMN@kroah.com>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 12:56:26PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Aug 26, 2021 at 11:13:43AM +0200, Daniel Vetter wrote:
> > dri-devel is the main user, and somehow there's been the assumption
> > that component stuff is unmaintained.
> > 
> > References: https://lore.kernel.org/dri-devel/CAAEAJfDWOzCJxZFNtxeT7Cvr2pWbYrfz-YnA81sVNs-rM=8n4Q@mail.gmail.com/
> > Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > ---
> >  MAINTAINERS | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index ac58d0032abd..7cdc19815ec4 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -5707,6 +5707,11 @@ F:	Documentation/admin-guide/blockdev/
> >  F:	drivers/block/drbd/
> >  F:	lib/lru_cache.c
> >  
> > +DRIVER COMPONENT FRAMEWORK
> > +L:	dri-devel@lists.freedesktop.org
> > +F:	drivers/base/component.c
> > +F:	include/linux/component.h
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Will you merge this through your tree? I think merging component patches
through driver core makes sense (or topic branch or whatever) still. This
is just so that there's a wider reviewer pool than just you & Rafael.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
