Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77491388E9D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 15:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239957AbhESNHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 09:07:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51923 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231434AbhESNHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 09:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621429574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xqzvhqKhh1nFQM60OV9hcT/mMJVDvQ3rAokoQfYzmz4=;
        b=ckzUFq7gmIf0T+2h7tVlUshE9TKbHSUYU6m56fZIpPru5HaZ3wcrTAYb8hdvAebnykc24t
        vNPtEqSHvSssj0Hd1VouVkzvluK9ZUTJlyj40yPMSfYY4w+ylVb5j4EA8f7i4P0eyoLl09
        jwwwX83akG3vpingPt6MoX+UCJ8rDro=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-BthQQSlnNA-e0WNPFJsJqA-1; Wed, 19 May 2021 09:06:12 -0400
X-MC-Unique: BthQQSlnNA-e0WNPFJsJqA-1
Received: by mail-wm1-f71.google.com with SMTP id f8-20020a1c1f080000b0290169855914dfso1506859wmf.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 06:06:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xqzvhqKhh1nFQM60OV9hcT/mMJVDvQ3rAokoQfYzmz4=;
        b=NdVhfAubHcQgWGGqhpwz1rtlsgpVt4JOBQ53Q+vEogUMuJQK/ElYYoYzULDiqo1dj4
         ac4MWdqUIdyQx4Pa6vRr7p3DkeCS3ftiTUrsfm7IwZfZ2cqAkyFf1baOQvUhv++XBMkG
         EEoQByppmbCSI/49O8slrIahaINOXJkwJAfD7kNDDcaHAl/m/BafeC5vNoNpnBjvN10o
         KwL3/NcrmCGoi0MvpUy/ja11pRpxcAqlYeCwF5KQjoZz2w53Pq5Jfgbgf8uw7f1O6xG5
         0SmfUk6sKHDTxEKdyKd12qgs909R0d6MIgiyIxIokghA6vALVr3uctqUCUmmaDhMJ2h4
         Smxg==
X-Gm-Message-State: AOAM532jeHB3KxQ0GCgIojhXRFzk+dStDaKZ3S2HEN5InM7HNh+LmCSk
        UXJe1yILjY6kCLvutlwP2bpfT55r7GW476Y5OVXJOD/vEC7qljl6CvKTICtA5z84oOwcRpdqA+X
        r03LL83hHaub63NXejiegC7k=
X-Received: by 2002:a5d:64aa:: with SMTP id m10mr14731769wrp.291.1621429571653;
        Wed, 19 May 2021 06:06:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmkaVogALKjMKQCJnqNqqS951xIsSZNejhsUEMl2kc6HJVeWXrLDE4wji4CEWD3+ScKdprvA==
X-Received: by 2002:a5d:64aa:: with SMTP id m10mr14731738wrp.291.1621429571451;
        Wed, 19 May 2021 06:06:11 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id s11sm3277535wmf.14.2021.05.19.06.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 06:06:11 -0700 (PDT)
Date:   Wed, 19 May 2021 14:06:09 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/page_alloc: try oom if reclaim is unable to make
 forward progress
Message-ID: <20210519130609.r3ml6ohb2qsrfq2t@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20210315165837.789593-1-atomlin@redhat.com>
 <YFN8wXwJA59w9twA@dhcp22.suse.cz>
 <20210319172901.cror2u53b7caws3a@ava.usersys.com>
 <YFh10eSTKY5lbE9u@dhcp22.suse.cz>
 <20210325210159.r565fvfitoqeuykp@ava.usersys.com>
 <YF2YTNnyzWNHfrEg@dhcp22.suse.cz>
 <20210326112254.jy5jkiwtgj3pqkt2@ava.usersys.com>
 <YF3/YZPd+iz/xGu6@dhcp22.suse.cz>
 <20210518140554.dwan66i4ttmzw4hj@ava.usersys.com>
 <YKTyKSDrFZjCS6Wu@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YKTyKSDrFZjCS6Wu@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal,

On Wed 2021-05-19 13:10 +0200, Michal Hocko wrote:
> > Looking at try_to_compact_pages(), indeed COMPACT_SKIPPED can be returned;
> > albeit, not every zone, on the zone list, would be considered in the case
> > a fatal signal is found to be pending. Yet, in should_compact_retry(),
> > given the last known compaction result, each zone, on the zone list, can be
> > considered/or checked (see compaction_zonelist_suitable()). If a zone e.g.
> > was found to succeed then reclaim/compaction would be tried again
> > (notwithstanding the above).
> 
> I believe Vlastimil would be much better fit into looking into those
> details but it smells like pending fatal signals can lead to a unbound
> retry indeed.

Understood.

I will post a trivial patch to hopefully address this particular condition
in the compaction retry code path, shortly for further discussion.


Kind regards,

-- 
Aaron Tomlin

