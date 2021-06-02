Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5349E398531
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 11:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbhFBJZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 05:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhFBJZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 05:25:20 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE15C061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 02:23:37 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso3312818wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 02:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WmVa2b7NUFKbzMkhRQoxLzdNVa4IgoT+niyCi15lBaU=;
        b=fJRU2AeKIPcQx11KLen+Ij89vZ+kwU0B8R7ieQATn/S0NLwL1fvRl5LLh3ACQr34HC
         O/8C0RF/0XjOPLbaQwJxsyQTmFiVL+Csf6hhVR3MNdjIKQDCPOwwgZZMoGIc35TOnpPe
         pYii0GAXsOF3dYFSG/Q0zJeCb6QtDpn02L6GGQSwx7MZ9E9s317Gsikz/vHIA3HLacl9
         3ZZRtTIXdgDwIgatsDJ1EBqZI7eZWxX4fgyowEP5VzxlJvcFR/j5QGj3pUgUr+hlWyY5
         d0JiS7tPfNQp6xOkVawGkmAOHWLu632QX4JEKAoYuAX+6eVgjx1gIPD/QQsd63szgsgx
         218A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WmVa2b7NUFKbzMkhRQoxLzdNVa4IgoT+niyCi15lBaU=;
        b=Jplowd79URXOAs6hoXAUrG5P2nyQ3T2hU99lJgNpMGywgVeRtQvmETfcH8SBeYV1fp
         OT8LCCvKEjVbFtEqcvZ2Q+BprFpTDO4XfoPt/4b8I+ZTAW+BuaZdI5kD1TsvhYBH+tKh
         ati2lRZixdH015SulmMSBvwBjFBZ2Dbc1KX3ISbW4WM7CvBhH8XCXB61nKGFKtzw0bTn
         kLvlu5qgjXR6Hi3BcP49LRxm1t/q61Ki2AOLvMQGJh5uugMR8XxYIicNKFvAriAgUnmL
         JhO79tAZRSPQ987Hvtr2fsW2hTHe07Z6/nB+cBrsPL2DLduph1ELQf/UHzhdI5vzQV/B
         5a1Q==
X-Gm-Message-State: AOAM532V2qRD2sCkyk6HQZY4r+JqAhjMIKmh050OAZ4X7N5lGcXa4tX9
        jZ6igWCRgdCf0ZHsLB0WmnDI+w==
X-Google-Smtp-Source: ABdhPJxrBmcIQdy1jyLXdbeY8xm3r2YATiuKPsOu+SRZUU2eDFxWBsAmhIOgoXGcJfVGwfjPxAVmew==
X-Received: by 2002:a1c:f016:: with SMTP id a22mr31888176wmb.65.1622625816371;
        Wed, 02 Jun 2021 02:23:36 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id h14sm2009325wmb.1.2021.06.02.02.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 02:23:35 -0700 (PDT)
Date:   Wed, 2 Jun 2021 09:23:33 +0000
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     will@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        catalin.marinas@arm.com, suzuki.poulose@arm.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] KVM: arm64: Remove list_head from hyp_page
Message-ID: <YLdOFUPjgCK33Vd5@google.com>
References: <20210527125134.2116404-1-qperret@google.com>
 <20210527125134.2116404-4-qperret@google.com>
 <87k0nd1wgx.wl-maz@kernel.org>
 <YLZWtnGVQSguI1P6@google.com>
 <87fsy11nz6.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fsy11nz6.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 Jun 2021 at 18:41:49 (+0100), Marc Zyngier wrote:
> On Tue, 01 Jun 2021 16:48:06 +0100,
> Quentin Perret <qperret@google.com> wrote:
> > 
> > On Tuesday 01 Jun 2021 at 15:38:22 (+0100), Marc Zyngier wrote:
> > > On Thu, 27 May 2021 13:51:30 +0100,
> > > Quentin Perret <qperret@google.com> wrote:
> > > > +/*
> > > > + * Pages that are available for allocation are tracked in free-lists, so we use
> > > > + * the pages themselves to store the list nodes to avoid wasting space. As the
> > > > + * allocator always returns zeroed pages (which are zeroed on the hyp_put_page()
> > > > + * path to optimize allocation speed), we also need to clean-up the list node in
> > > > + * each page when we take it out of the list.
> > > > + */
> > > > +static inline void page_remove_from_list(struct hyp_page *p)
> > > > +{
> > > > +	struct list_head *node = (struct list_head *)hyp_page_to_virt(p);
> > > 
> > > Nit: How about changing hyp_page_to_virt() so that it returns a
> > > convenient 'void *', and get rid of the ugly casts?
> > 
> > It should already return void *, but I kind of liked the explicit cast
> > here for documentation purpose. We're turning a 'random' piece of unused
> > memory into a typed object, so that felt like a useful annotation. Happy
> > to get rid of it though.
> 
> My expectations were that using hyp_page_to_virt() already serves as a
> pretty big warning that we're doing something unusual.
> 
> I guess that if we want to be really careful about those, we should
> then be consistent and make it return a uintptr_t (or unsigned long)
> instead, actively making use of the cast, consistently, everywhere.

Right, so I'd prefer keeping it void * for consistency with the EL1
equivalent -- much of this aims to be API compatible with the Linux
stuff. I'll get rid of the cast and post a v2 shortly.

Cheers,
Quentin
