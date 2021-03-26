Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A9734B1BC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 23:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhCZWBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 18:01:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33344 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231260AbhCZWA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 18:00:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616796057;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NwmpBP589O6V0JxrSUt13E4QZLT4xX4RH4BOYcChKvM=;
        b=jO7+FspRG2nRSQ0E8ro0zHL8JBVNoNxxVxzsJvAYL2SoRxZ6ZymtZmVk5KoAn45rSEYsor
        lkuWBo6efNe7JPY80RPqIV7MFv95Iwp13wklEnzmnWbppf5ezynmaBFv5sL4yzmQ9Skv53
        g36xpPNmlcfwiMrv/gxLcE22yQBq8D8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-602-8PZ_mwM9PPKiZ8c6X6s0nQ-1; Fri, 26 Mar 2021 18:00:54 -0400
X-MC-Unique: 8PZ_mwM9PPKiZ8c6X6s0nQ-1
Received: by mail-qk1-f197.google.com with SMTP id b127so7165372qkf.19
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 15:00:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=NwmpBP589O6V0JxrSUt13E4QZLT4xX4RH4BOYcChKvM=;
        b=k/jGqUsHYjXiSE3VFe1vjF02re9NUBjFldcKQ7uGUxh3xz8p1uBA2VApSPS+iQt8Cm
         S+XgIE8E1uJUbC8PaoBW+E2+gZhGduWNChtm8Ya4nbrQg9nrI2JVEJQTpDtZL0H2RiGs
         BSZTQ8UwJA3fhqyN1xRe4ZdQmqlckyBbfMVSj61AdNo0eopGOwH0KzWu5c3RoRpF4VZk
         iRy5ApXpGnblrrRlYywyekG0BuisdfQGuFLFjmzgxGuoR1QqLYXDh8fF42k/Ss2VgwXc
         EQKql3U67rpZ3u3vl6PvIl6HLnPJI+oXDcccAyUy7M4QxviwzZFIzS7Y+klUw1MGciMe
         CPUQ==
X-Gm-Message-State: AOAM530XRHWDRltH9t1dbdOjHiFSSrd5HgR2duVudoupMrJK+CCT4yE4
        158BeTG7lmFe3rZAM9XLbSLuP/LUk/CitZnIz38pAULD5lek+6qzGNWmznkSBgtvb4tVo1G1WhB
        1DO78DisBQXpeWFZXu7Ut8e9y
X-Received: by 2002:a37:a38e:: with SMTP id m136mr15199339qke.250.1616796053827;
        Fri, 26 Mar 2021 15:00:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdjc8K+Reia9/uZrIZA0FnyV82RIoH05Va+FBTVeF7yBkyt1wnjDJ4h2zusGmfId1aYTbjwQ==
X-Received: by 2002:a37:a38e:: with SMTP id m136mr15199330qke.250.1616796053657;
        Fri, 26 Mar 2021 15:00:53 -0700 (PDT)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id 21sm7965657qkv.12.2021.03.26.15.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 15:00:52 -0700 (PDT)
Message-ID: <b4da382b17a77b66e45fd374c9d806dac6054e3a.camel@redhat.com>
Subject: Re: [PATCH v2 0/3] drm/nouveau: fix a use-after-free in postclose()
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Jeremy Cline <jcline@redhat.com>, Ben Skeggs <bskeggs@redhat.com>
Cc:     Karol Herbst <kherbst@redhat.com>, David Airlie <airlied@linux.ie>,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 26 Mar 2021 18:00:51 -0400
In-Reply-To: <20201125202648.5220-1-jcline@redhat.com>
References: <20201103194912.184413-1-jcline@redhat.com>
         <20201125202648.5220-1-jcline@redhat.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is:

Reviewed-by: Lyude Paul <lyude@redhat.com>

Btw - in the future if you need to send a respin of multiple patches, you need
to send it as it's own separate series instead of replying to the previous one
(one-off respins can just be posted as replies though), otherwise patchwork
won't pick it up

On Wed, 2020-11-25 at 15:26 -0500, Jeremy Cline wrote:
> This series fixes a number of use-after-frees in nouveau's postclose()
> handler. It was discovered by pointing IGT's core_hotunplug tests at a
> nouveau device, but the steps to reproduce it are simple:
> 
> 1. Open the device file
> 2. Unbind the driver or remove the device
> 3. Close the file opened in step 1.
> 
> During the device removal, the nouveau_drm structure is de-allocated,
> but is dereferenced in the postclose() handler.
> 
> One obvious solution is to ensure all the operations in the postclose()
> handler are valid by extending the lifetime of the nouveau_drm
> structure. This is possible with the new devm_drm_dev_alloc() interface,
> but the change is somewhat invasive so I thought it best to submit that
> work separately.
> 
> Instead, we make use of the drm_dev_unplug() API, clean up all clients
> in the device removal call, and check to make sure the device has not
> been unplugged in the postclose() handler. While this does not enable
> hot-unplug support for nouveau, it's enough to avoid crashing the kernel
> and leads to all the core_hotunplug tests to pass.
> 
> This series reroll addresses a missing mutex_destroy() call and a typo
> in a commit message.
> 
> Jeremy Cline (3):
>   drm/nouveau: use drm_dev_unplug() during device removal
>   drm/nouveau: Add a dedicated mutex for the clients list
>   drm/nouveau: clean up all clients on device removal
> 
>  drivers/gpu/drm/nouveau/nouveau_drm.c | 42 +++++++++++++++++++++++----
>  drivers/gpu/drm/nouveau/nouveau_drv.h |  5 ++++
>  2 files changed, 42 insertions(+), 5 deletions(-)
> 

-- 
Sincerely,
   Lyude Paul (she/her)
   Software Engineer at Red Hat
   
Note: I deal with a lot of emails and have a lot of bugs on my plate. If you've
asked me a question, are waiting for a review/merge on a patch, etc. and I
haven't responded in a while, please feel free to send me another email to check
on my status. I don't bite!

