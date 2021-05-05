Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4FA374B37
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 00:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhEEW0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 18:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhEEW0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 18:26:02 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74770C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 15:25:05 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id o12so2530152qtx.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 15:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:organization:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VHF+1pzeQiV2IkLAVQY01JyDWVebdBsj7MiU0s3L8tA=;
        b=XggPzJIzxpaq1Flue+zJ4EgoPgBwaHnlXrfbikxdzI7pJwKyPeagv0NdgbVQxpOJhZ
         j3Q/D0x5BH3bLqHEPlF4TBRLp6I83RRdsWwsIVO8q9ozM8ZUgxR+8Euq1oBusjsUsFqo
         Z2cPan7ff+APIfWW5gWW6zS5qUlFjojTdzw/EbhIRjZJUva+cOlTt/LiQbD+ZxFhn14N
         /P3kzBbf3pA5eoiIkEBMvXE1h8wPjlklyvKCUAyTjab0e+GEqpAShfjYe7K/xJAQcn9Q
         dok3AHNvr/Hl3Hw7S4mgz6LDHzI4rzWZLR0yEpVco8R1YWmlv7ojR4/LVZeu82d3GEYX
         FFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=VHF+1pzeQiV2IkLAVQY01JyDWVebdBsj7MiU0s3L8tA=;
        b=NumqERIyeqibk3TmimxBzuR9EGcffVVSkaYYXkTcXkq7U2xpamKKPK00XVaIif54yu
         KUOPZCDfP1GcZQZRuFQjfmk5FiyLnedK3AJU4LFKfAAQj3d32MIxa6ggG84v5c8jeD1P
         kealhyeAyFPdwvGm/X1vc5UWdY84YqUHT8Qul1EZ2rACPymDEGNR9NxFl2URCtjpRo7r
         0x1GKAdg6tvoo/mivgV2Uv8Dd2cXsyQ2prB4eJKvRSnnBGNKSJ/9D/fot+rmlKzeFnZX
         TsmkDM8rBrgCmjkaN+IbyUpEOVbMPPfdY3apcUr3R6Xf5s8n1Nan1EJcgZnL9mAAejQ0
         UqFA==
X-Gm-Message-State: AOAM530Qj7s/jaywig5ZpqupyfbQwxNP0k/KxjxkKQ8I/vGFTUfuvX/k
        6RC92uaa0GZTwE6vflYhVxl1yA==
X-Google-Smtp-Source: ABdhPJyXjp04g/al6SaVrM35QSds1Dzfe4/k1h2ndJGPBzHYa6zeBKKlmYux+S0J5U+U2VW0Mja29g==
X-Received: by 2002:ac8:7244:: with SMTP id l4mr864209qtp.347.1620253504546;
        Wed, 05 May 2021 15:25:04 -0700 (PDT)
Received: from iron-maiden.localnet ([66.199.90.164])
        by smtp.gmail.com with ESMTPSA id p10sm546907qkg.74.2021.05.05.15.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 15:25:04 -0700 (PDT)
From:   Carlos Bilbao <bilbao@vt.edu>
To:     corbet@lwn.net, hdegoede@redhat.com, mchehab+huawei@kernel.org,
        Jonathan.Cameron@huawei.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Randy Dunlap <rdunlap@infradead.org>, bilbao@vt.edu
Subject: Re: [PATCH] Fixed typos in all directories of Documentation/ABI/
Date:   Wed, 05 May 2021 18:25:03 -0400
Message-ID: <4341223.LvFx2qVVIh@iron-maiden>
Organization: Virginia Tech
In-Reply-To: <de6f22e2-3f3c-0ce3-a73d-fb881646f1e8@infradead.org>
References: <2219636.ElGaqSPkdT@iron-maiden> <de6f22e2-3f3c-0ce3-a73d-fb881646f1e8@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Randy,

Thank you for your quick feedback that I address below, I will send the patch
again after this email.
 
> >  What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>/cpu
> >  Date:		September. 2017
> >  KernelVersion:	4.14
> >  Contact:	Stephen Hemminger <sthemmin@microsoft.com>
> > 
> > -Description:	VCPU (sub)channel is affinitized to
> > +Description:	PCP (sub)channel is affinitized to
> 
> Stephen- comment here?

Stephen, no need to comment. This was my fault, VCPU was already right. Fixed.

> > diff --git a/Documentation/ABI/stable/sysfs-class-infiniband
> > b/Documentation/ABI/stable/sysfs-class-infiniband index
> > 348c4ac803ad..bbaa7bab8af4 100644
> > --- a/Documentation/ABI/stable/sysfs-class-infiniband
> > +++ b/Documentation/ABI/stable/sysfs-class-infiniband
> > 
> > @@ -140,7 +140,7 @@ Description:
> >  		by LocalPhyErrors
> >  		
> >  		excessive_buffer_overrun_errors: (RO) This counter, indicates an
> > 
> > -		input buffer overrun. It indicates possible misconfiguration of
> 
> Above is correct AFAIK although my 3 quick dictionary searches didn't find
> it spelled either of those ways. :)

Also true, "misconfiguration" is accepted. Change removed.

> 
> codespell find 4 problems here (in ABI/testing):
> 
> $ codespell sysfs-devices-system-cpu
> sysfs-devices-system-cpu:100: internel  ==> internal
> sysfs-devices-system-cpu:283: specificed  ==> specified
> sysfs-devices-system-cpu:298: beyound  ==> beyond
> sysfs-devices-system-cpu:535: Symetric  ==> Symmetric
> 
> 
> Would you mind adding those to your patch?
> 

Changes added to the patch.




