Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBA83D3AC6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 14:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbhGWMSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 08:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234909AbhGWMSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 08:18:40 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4FDC061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 05:59:14 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id f1so3145018plt.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 05:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=admFING+RTwbfb4knH3wY0aguWQ8mq91cUYAMzqn6ZY=;
        b=WDOtDkjiFEClp/1dGC+DmEeghNPtOkKgH+2CbbTqLzl86nXh39DjrOL29GlO2l0YpE
         tSqt59ExJJhqIuLls0zBfNdulOX/TCK/CRRZDtfb9S03gYNmfymoT45hfp+U8+MNQEBO
         Z7BghqfiPc24awdBF28qCON6SqJa690UZ2v0tYadUAF8V3rTHsoT8jfdnUTFLBzVRDUo
         RO9XbimJJiXBEzE0zKZ3FfyHBVIJ5DXzt1azyCFinR80CVFBxOenwANpfsmtuemzFMTV
         bbOP+fYYaZlEJlsn7CE6a5kAnF61WK1cawtGhqO48RwnAeBNzMs+WDczu8ZieiB23sPv
         AUYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=admFING+RTwbfb4knH3wY0aguWQ8mq91cUYAMzqn6ZY=;
        b=b6U98alWUnJ/oi1TbX6j8gU9KX4jxVUZeo5l2/U5s6pZipQP0FKN+dkvZsGM6R1S1G
         25MJvoxaqkwtNW7XwxCJuLkVmLg66CnhMPEOzPTw8uGfvJwXNRcB/NM5vnJpu6TocFr8
         iarhN9J/kP9OPu8iZH2YtLTFtvlVy/yrxZT2q7PTfqJj1tkZRFbvtltcvz+1VlHnagRw
         xn5pj1UfVZ3U547Y8XnD0aCw1VYRV8Xmwn5PcT7Ym59ENl4X/YXdEODjMF7w8LDzpAX7
         oEzh3fR3WTyaKjrZgfOUaecN0FAVa9Q9vLIQgQDiimEMvhxHonTf9AWtcdepXLAp0RF2
         5BoQ==
X-Gm-Message-State: AOAM533QzcslZQH2F6VzO2hk7kpYH/Pt5IxuQ25oCSkquDgc3+tlC2Hl
        Y2AftBMCljN1js6+7nSDLUc=
X-Google-Smtp-Source: ABdhPJwDFkxQliqpPV+ayjxdoyQilsjLkT4M0H0k1VhO6v+eON3/S4gIfLAe7fgx9iUJA/6Fj6CJQg==
X-Received: by 2002:a63:a1c:: with SMTP id 28mr4660873pgk.445.1627045153855;
        Fri, 23 Jul 2021 05:59:13 -0700 (PDT)
Received: from ojas ([122.161.50.107])
        by smtp.gmail.com with ESMTPSA id k4sm27967694pjs.55.2021.07.23.05.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 05:59:13 -0700 (PDT)
Date:   Fri, 23 Jul 2021 18:29:00 +0530
From:   Ojaswin Mujoo <ojaswin98@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     nsaenz@kernel.org, stefan.wahren@i2se.com,
        dan.carpenter@oracle.com, phil@raspberrypi.com,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/5] vchiq: Patch to separate platform and cdev code
Message-ID: <20210723125900.GA279903@ojas>
References: <cover.1626882325.git.ojaswin98@gmail.com>
 <YPqh0SHa8n3BugnB@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPqh0SHa8n3BugnB@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 01:02:41PM +0200, Greg KH wrote:
> On Wed, Jul 21, 2021 at 09:50:48PM +0530, Ojaswin Mujoo wrote:
> > Hello,
> > 
> > This patchset adderesses the TODO item number 10 specified at:
> > 
> >     drivers/staging/vc04-services/interface/TODO
> > 
> > For reference, the task is:
> > 
> >     10) Reorganize file structure: Move char driver to it's own file and join
> >     both platform files
> > 
> >     The cdev is defined alongside with the platform code in vchiq_arm.c. It
> >     would be nice to completely decouple it from the actual core code. For
> >     instance to be able to use bcm2835-audio without having /dev/vchiq created.
> >     One could argue it's better for security reasons or general cleanliness. It
> >     could even be interesting to create two different kernel modules, something
> >     the likes of vchiq-core.ko and vchiq-dev.ko. This would also ease the
> >     upstreaming process.
> > 
> > A summary of the patches is as follows:
> > 
> > - Patch 1: Move cdev init code into a function
> > - Patch 2: Shift some devlarations from vchiq_arm.c to vchiq_arm.h for
> >            sharing
> > - Patch 3: Move vchiq cdev init code from vchiq_arm.c into vchiq_dev.c
> > - Patch 4: Decouple cdev code by defining a Kconfig entry to allow
> >            optional compilation of it.
> > - Patch 5: Merge code in vchiq_2835_arm.c to vchiq_arm.c
> > 
> > Changes since v3 [2]:
> > 
> > * In Patch 5, replace forward declarations of some of the functions with
> >   function definition 
> 
> You dropped the reviews of others, so now I need to wait for them again
> :(
> 
Hello Greg,

Apologies for that, I was under the impression that a new version
needed a separate review :(

If its okay, I can alternately resubmit this (as v5?) with Stefan's
Reviewed-By tags on unchanged commits intact. Let me know if that's okay
or if its better to wait out.

Thank you!
Ojaswin
