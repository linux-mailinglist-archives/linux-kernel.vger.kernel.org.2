Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1873F7A76
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbhHYQ1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:27:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28612 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230112AbhHYQ0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:26:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629908768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=81MH9LvvmF94Xq/fdROYPDvLqRHwmN8vJwPNmh3G3RI=;
        b=g4x9JWbAi1TmYe7z3C9zCbBxVolElUuCXawYVqLdlLsx9yk/7RwDT0cvw8JGkP5uqnlyH6
        VOstPcRzpseBf3nl0vn16yBfrgAqLRMUJccvV75UUAH6+qn+3eVjlwBTbo2YKsmncFsenu
        48re8Oig0Nxd1PL0uaYiZBydObtHjJ4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-pe3KOs5nM665kgNCXrbVdw-1; Wed, 25 Aug 2021 12:26:07 -0400
X-MC-Unique: pe3KOs5nM665kgNCXrbVdw-1
Received: by mail-qt1-f200.google.com with SMTP id l24-20020ac84a98000000b00298c09593afso12920020qtq.22
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 09:26:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=81MH9LvvmF94Xq/fdROYPDvLqRHwmN8vJwPNmh3G3RI=;
        b=AjNYbUdVSFDa+2c4+z/d3NuDvKFmVi8Css8H70ztnw7koC0lWPQ5R8ZTOPgCKtAv6w
         r/zM2Y9sSf1dyl5fNDSF0cHXZe8IQne1FhN0rPJdRPEiDoX/cMC+o6Ar31N0NjLMXLbe
         BIOGXWP88IvrpQODyrHWqveW7JEZnSaLSk/HXJw06c4xtBfQzVoxWyPXKm4WxnNL3rYX
         aO5rWDX/ayqxjfvYJoQ2a9ousOoHkz9FEekvOyd3tpK1Oz0NNlZPx9LH0wcMOgKprUjf
         7qfogxrAcmURzxULkvTmfYNay7vCFiwX6q/JjdFqEvTaxWb9IZ6xtMH8g8chocFkv82a
         iquQ==
X-Gm-Message-State: AOAM530VD1XYyRBYc/h1AwCQtHQ20KRxILs+n6R2yhnrIJ5a2O6k/Ntu
        5ivumMxIk0wHJN4UvXT7V7h6IuXFdhtVJLIOnrGeUnqAZnktK7P0stNUmR0Eeid1A1SeF3jCnNY
        xRFaWasofutJBqRmZlXN4V9Uz
X-Received: by 2002:a05:620a:cd0:: with SMTP id b16mr33236663qkj.136.1629908766818;
        Wed, 25 Aug 2021 09:26:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2hbGvq6X6Eeo1e/X0RrlLiDx0IZFm+v9074G6Af3gBq7QNBz9w7hpyaUv9eJGkjMTtQrdGg==
X-Received: by 2002:a05:620a:cd0:: with SMTP id b16mr33236646qkj.136.1629908766609;
        Wed, 25 Aug 2021 09:26:06 -0700 (PDT)
Received: from [192.168.8.104] (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id c68sm327240qkf.48.2021.08.25.09.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 09:26:06 -0700 (PDT)
Message-ID: <88b5fbe60c95bcdf42353bec9f8c48aefa864a31.camel@redhat.com>
Subject: Re: [PATCH v3] drm/dp_mst: Fix return code on sideband message
 failure
From:   Lyude Paul <lyude@redhat.com>
To:     khsieh@codeaurora.org
Cc:     Jani Nikula <jani.nikula@linux.intel.com>, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, abhinavk@codeaurora.org,
        aravindh@codeaurora.org, rsubbia@codeaurora.org,
        rnayak@codeaurora.org, freedreno@lists.freedesktop.org,
        airlied@linux.ie, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 25 Aug 2021 12:26:03 -0400
In-Reply-To: <64049ef6c598910c1025e0e5802bb83e@codeaurora.org>
References: <1625585434-9562-1-git-send-email-khsieh@codeaurora.org>
         <87zguy7c5a.fsf@intel.com>
         <a514c19f712a6feeddf854dc17cb8eb5@codeaurora.org>
         <2da3949fa3504592da42c9d01dc060691c6a8b8b.camel@redhat.com>
         <d9ec812b4be57e32246735ca2f5e9560@codeaurora.org>
         <79c5a60fc189261b7a9ef611acd126a41f921593.camel@redhat.com>
         <696a009e2ab34747abd12bda03c103c7@codeaurora.org>
         <e725235a77935184cd20dab5af55da95b28d9e88.camel@redhat.com>
         <64049ef6c598910c1025e0e5802bb83e@codeaurora.org>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch was pushed yes (was part of drm-misc-next-2021-07-29), seems like it
just hasn't trickled down to linus's branch quite yet.

On Wed, 2021-08-25 at 09:06 -0700, khsieh@codeaurora.org wrote:
> On 2021-07-27 15:44, Lyude Paul wrote:
> > Nice timing, you literally got me as I was 2 minutes away from leaving 
> > work
> > for the day :P. I will go ahead and push it now.
> > 
> Hi Lyude,
> 
> Had you pushed this patch yet?
> We still did not see this patch at msm-nex and v5.10 branch.
> Thanks,
> 
> 
> > BTW - in the future I recommend using dim to add Fixes: tags as it'll 
> > add Cc:
> > to stable as appropriate (this patch in particular should be Cc:
> > stable@vger.kernel.org # v5.3+). will add these tags when I push it
> > 
> > On Tue, 2021-07-27 at 15:41 -0700, khsieh@codeaurora.org wrote:
> > > On 2021-07-27 12:21, Lyude Paul wrote:
> > > > On Thu, 2021-07-22 at 15:28 -0700, khsieh@codeaurora.org wrote:
> > > > > 
> > > > > It looks like this patch is good to go (mainlined).
> > > > > Anything needed from me to do?
> > > > > Thanks,
> > > > 
> > > > Do you have access for pushing this patch? If not let me know and I
> > > > can
> > > > go
> > > > ahead and push it to drm-misc-next for you.
> > > no, I do not have access to drm-misc-next.
> > > Please push it for me.
> > > Thanks a lots.
> > > 
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

