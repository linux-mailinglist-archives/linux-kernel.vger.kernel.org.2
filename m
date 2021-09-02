Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 545F53FEFA8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 16:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345645AbhIBOqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 10:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345546AbhIBOqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 10:46:45 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3B4C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 07:45:46 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id u9so3342473wrg.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 07:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SBemzdNlacrnzlvpl8xEUdWlxlnHw5Q7DGxxpD9O63Y=;
        b=F8wErhsmbA7OzEGYxYwrW/Ypa4d2zsPTUaFJ2kuCx++KprCEIFpMBzF+cr7aJETYo+
         KFhZn4WGn0jMyyuX+h7O1akoKvYdNc9yVDCQSnh9D5m2DTmRMyJW/lkNwpL/JTqWL6CH
         qGStHPYxUqdTVkuLr1dlgkH9PG9a59+CYai+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=SBemzdNlacrnzlvpl8xEUdWlxlnHw5Q7DGxxpD9O63Y=;
        b=OIys6KbpKficVyYO75nSQvAomxgSj5MccZkSDUfu/rRi2BQTMcj42xsPLwhzqep3VF
         mK3EvyHclMqOL90P9cvw+KsTQ28k8BIJiyye86YVhVmrPtIIVVS73aB0Nz/Nhoi+s9mi
         4BUNq97TcNqd5k3XY32ehJL5pvGivzhOxvw1pSwo8WhxN4wmWVNWo8rTIH+myZzeW8tC
         stOp0Be4RJyO3G+bmvOOiCOQmHVi5Gw2UvdUsDNbUsBt9iN4kEcbJ8rPXa7CNnQf7t0y
         BqIt2INxD5T+iFa3cAF8z/PcsrppHAzIMiwUz9iK0kANqbK6eInu+it46YLLEugNfx22
         8jow==
X-Gm-Message-State: AOAM532PWrQgFJzL2iEzSmb9x1X0cOfTLdsPdro3agig113x/CYKNPcJ
        7VFInXoUUAs1kuJGylQwwVoEViYF1rMsqA==
X-Google-Smtp-Source: ABdhPJzCf8R2j8AB7PFlwy6aj/BOqLVbGNBReozZiXXYkSZ3rkJO8mhoVRbpW+vAiWPAyABsC+xqdw==
X-Received: by 2002:a05:6000:1627:: with SMTP id v7mr4233886wrb.195.1630593944785;
        Thu, 02 Sep 2021 07:45:44 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id j20sm1952481wrb.5.2021.09.02.07.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 07:45:44 -0700 (PDT)
Date:   Thu, 2 Sep 2021 16:45:42 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Thomas =?iso-8859-1?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, dri-devel@lists.freedesktop.org,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/ttm: provide default page protection for UML
Message-ID: <YTDjlixwDWi7Y2uR@phenom.ffwll.local>
Mail-Followup-To: Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, dri-devel@lists.freedesktop.org,
        Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, David Airlie <airlied@linux.ie>
References: <20210902020129.25952-1-rdunlap@infradead.org>
 <9faacbc8-3346-8033-5b4d-60543eae959e@cambridgegreys.com>
 <f978cae5-7275-6780-8a17-c6e61247bce7@infradead.org>
 <0887903c-483d-49c7-0d35-f59be2f85bac@cambridgegreys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0887903c-483d-49c7-0d35-f59be2f85bac@cambridgegreys.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 07:19:01AM +0100, Anton Ivanov wrote:
> On 02/09/2021 06:52, Randy Dunlap wrote:
> > On 9/1/21 10:48 PM, Anton Ivanov wrote:
> > > On 02/09/2021 03:01, Randy Dunlap wrote:
> > > > boot_cpu_data [struct cpuinfo_um (on UML)] does not have a struct
> > > > member named 'x86', so provide a default page protection mode
> > > > for CONFIG_UML.
> > > > 
> > > > Mends this build error:
> > > > ../drivers/gpu/drm/ttm/ttm_module.c: In function
> > > > ‘ttm_prot_from_caching’:
> > > > ../drivers/gpu/drm/ttm/ttm_module.c:59:24: error: ‘struct
> > > > cpuinfo_um’ has no member named ‘x86’
> > > >    else if (boot_cpu_data.x86 > 3)
> > > >                          ^
> > > > 
> > > > Fixes: 3bf3710e3718 ("drm/ttm: Add a generic TTM memcpy move for
> > > > page-based iomem")
> > > > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > > > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > > > Cc: Christian König <christian.koenig@amd.com>
> > > > Cc: Huang Rui <ray.huang@amd.com>
> > > > Cc: dri-devel@lists.freedesktop.org
> > > > Cc: Jeff Dike <jdike@addtoit.com>
> > > > Cc: Richard Weinberger <richard@nod.at>
> > > > Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> > > > Cc: linux-um@lists.infradead.org
> > > > Cc: David Airlie <airlied@linux.ie>
> > > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > > ---
> > > >   drivers/gpu/drm/ttm/ttm_module.c |    4 ++++
> > > >   1 file changed, 4 insertions(+)
> > > > 
> > > > --- linux-next-20210901.orig/drivers/gpu/drm/ttm/ttm_module.c
> > > > +++ linux-next-20210901/drivers/gpu/drm/ttm/ttm_module.c
> > > > @@ -53,6 +53,9 @@ pgprot_t ttm_prot_from_caching(enum ttm_
> > > >       if (caching == ttm_cached)
> > > >           return tmp;
> > > > +#ifdef CONFIG_UML
> > > > +    tmp = pgprot_noncached(tmp);
> > > > +#else
> > > >   #if defined(__i386__) || defined(__x86_64__)
> > > >       if (caching == ttm_write_combined)
> > > >           tmp = pgprot_writecombine(tmp);
> > > > @@ -69,6 +72,7 @@ pgprot_t ttm_prot_from_caching(enum ttm_
> > > >   #if defined(__sparc__)
> > > >       tmp = pgprot_noncached(tmp);
> > > >   #endif
> > > > +#endif
> > > >       return tmp;
> > > >   }
> > > 
> > > Patch looks OK.
> > > 
> > > I have a question though - why all of DRM is not !UML in config. Not
> > > like we can use them.
> > 
> > I have no idea about that.
> > Hopefully one of the (other) UML maintainers can answer you.
> 
> Touche.
> 
> We will discuss that and possibly push a patch to !UML that part of the
> tree. IMHO it is not applicable.

I thought kunit is based on top of uml, and we do want to eventually adopt
that. Especially for helper libraries like ttm.

But also that's quite a bit in the future.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
