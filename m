Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2E933424F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 17:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbhCJQAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 11:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbhCJP7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 10:59:38 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FE8C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 07:59:38 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id lr1-20020a17090b4b81b02900ea0a3f38c1so328580pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 07:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XYIw53FG6Pi0idyEbOGAM+kfG1SQqpJslcWfjDqB6js=;
        b=prYQIQ3qyXWCVibRtNvRq4flpOmaMd4lkcnSgz/w7bz6BKppSS0icpG1u485cofcxh
         l6GchQXDHIrUAS8oQUK55YNP3CeIQtaA6ZUGvtzehNMplVm2wt5zNf9nG2Osy6bhY9MC
         D/izinGXARDF/6KJv9HJ8k0h23vy9PBKh5N88D7D42lbhQngCpsUqVQmpvcdgzfQEyw5
         83yGT0xVrOVCbmQyXJxSbP553TQ0OwMmMAzUGXdLB6brA9hIsRNQv9MCbCFANc08hoRC
         IsExRfEvwiRtA9yHu8cgAbFBsLuUMvN8KQpKffzhU+PX/d2cm0vg0s05HP1H6R5Gk3mI
         MOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=XYIw53FG6Pi0idyEbOGAM+kfG1SQqpJslcWfjDqB6js=;
        b=tHdFk1O89NAjWDD8t8jMFELsr+Wmqp7v/3gMFnBqYBDj+GoCOMVktoCwB61DbbzX5n
         xSUtnwE8hhgtQYB2Z7BlDcw4aUBX9+cf21ZrmaoOYY3YUqYs8j+4x14WoufLaxw7oQLW
         EBYBoCYrbjir76bLhijlgsgw2YkqCAJsEuMgY2MeXIxyO1Q0b5Kit023OsbPaBOkHyuM
         cNY/CC0oTQ/FxicT5sA33cUCDyhHmUAP4jbpTsWnvticssdPzqHTAnXimJKubEADColq
         vpIIUzarqFZXDgNZd3fYoSrxFzTfZWw85vZ6MIxNPcL234BckWQq+qCFNcDONi7fhQBD
         Pz9w==
X-Gm-Message-State: AOAM530SasHMVF1aU9VHk2wHTiPJiVkkoh7A3pV4fDe0FYaBb3y6XlNJ
        ne8/1ITF0gbfKdDdpVxfxFQ=
X-Google-Smtp-Source: ABdhPJyoegNIOLarzPhAC3f6wVIE5ZPCpUJZiCanxiVr5Qw4WCeU0M8Sur02hLDMi1tBXT3I8ePCRg==
X-Received: by 2002:a17:902:d2c7:b029:e6:34e2:7a83 with SMTP id n7-20020a170902d2c7b02900e634e27a83mr3759493plc.60.1615391977985;
        Wed, 10 Mar 2021 07:59:37 -0800 (PST)
Received: from google.com ([2620:15c:211:201:64cb:74c7:f2c:e5e0])
        by smtp.gmail.com with ESMTPSA id c193sm17971105pfc.180.2021.03.10.07.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 07:59:36 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 10 Mar 2021 07:59:34 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Baron <jbaron@akamai.com>
Subject: Re: [PATCH v2] mm: page_alloc: dump migrate-failed pages
Message-ID: <YEjs5vxO/FRLUHhl@google.com>
References: <20210308202047.1903802-1-minchan@kernel.org>
 <YEdAw6gnp9XxoWUQ@dhcp22.suse.cz>
 <YEefLYiX6rF3Uk4E@google.com>
 <YEejCP5tzUtrAjcw@dhcp22.suse.cz>
 <YEewF8c1ydu2pU0A@google.com>
 <YEjD91BprqJMZUah@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEjD91BprqJMZUah@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 02:04:55PM +0100, Michal Hocko wrote:

< snip >

> > > Also are all those CONFIG_DYNAMIC_DEBUG* ifdefs necessary?  Can we
> > > simply enable DYNAMIC_DEBUG for page_alloc as I've suggested above?
> > 
> > They are different usecases.
> > 
> > With DYNAMIC_DEBUG_MODULE with CONFIG_DYNAMIC_DEBUG_CORE,
> > it works for only specific compile flags as you suggested.
> > (CONFIG_DYNAMIC_DEBUG_CORE is requirement to work DYNAMIC_DEBUG_MODULE.
> > 
> > With CONFIG_DYNAMIC_DEBUG, user could enable/disable every dynamic
> > debug places without needing DYNAMIC_DEBUG_MODULE flags for source
> > files.
> > 
> > Both usecase makes sense to me.
> 
> Well, this is more of a question for dynamic debugging maintainers. But
> it would be really great to reduce the ifdefery as much as possible.

I don't understand why this is something particular case which is okay
to lose either way to make dyndbg dynamic.
