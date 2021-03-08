Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9663312B3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 16:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhCHP6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 10:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhCHP6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 10:58:15 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013A6C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 07:58:15 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so3372628pjv.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 07:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tV38FDWXIwSDUgFeSjN3RtzjqUjYpkfwAo3PpwIhaxQ=;
        b=ErBYBePCPB8Z2yrnGCAAmEr6Cx2IqktbakyWcUtYUMjI6dUa9KhCVu0wnQUdWE6ZZO
         7Q3UnwF/9+sIrG0HMnoiv6PEJNQ/+ipbUzGnjGurIFGinBAtR0wiNA9tiyr7yTrxyXXa
         rHqcNDg+YIuolXpmnVo4q8bIU1AP8r/As32IgdCvy3bsBN4V57mMbA3xVTMFXyG/4+Va
         D9aCWYzKuqY9meLE1/CItfgSqsk6vPUu19bg/CG2Y/BAT0nCcYul3xa3lULVeqYB9ahf
         WgeOvenaXWclypW/0ygdxWVGKtMbR4067LG3lmjCPB273JOVSW+BTYU1wxdbnfmBh6Yg
         XoSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=tV38FDWXIwSDUgFeSjN3RtzjqUjYpkfwAo3PpwIhaxQ=;
        b=h2iQkPDSWHG8R3O8XJC0cMKsztRJ3ATYiECvbzL1ju38TgbcS0GrI7BTRZsfqH3YlK
         SxdnpEIBeD/UMdc34fjkRWwwJ5LNVrF7hXNx9iAF93d5tULHiGP69rLY2aaiP5p6tpmy
         Y8zAaNuCEowGdPl7DrB0c0sU+TD2aLEbz+F2KgPVIxxuMlHjYvSUoz0But7fAAoD0Nnt
         h7V2j5nyrWJ3X2uz2SvOm/B5vpXad3+IfVSMM40v+7MUxcQXDCJYX9q/vS80rMDjStxG
         F0UAUbpPMPw9jfKRaOCdd9pLvM+WaF7+t0GsxSrU2zc6hPYipOC1hVgMyberLXeFWu2e
         c04Q==
X-Gm-Message-State: AOAM53055Ky3LAaC/hkaV69OfIodrVlS62f8NHTG1CKOzIer3dg3FpUC
        VTX1teGES3Nhl1wlepUGXq0=
X-Google-Smtp-Source: ABdhPJwbWISOhBxGHptp1gqbym0Nispm2/sYDjzuafiWOdybNE26U+RSKaLXfRFGR5LNy22QDvJ4yg==
X-Received: by 2002:a17:90a:bb8d:: with SMTP id v13mr24192531pjr.12.1615219094528;
        Mon, 08 Mar 2021 07:58:14 -0800 (PST)
Received: from google.com ([2620:15c:211:201:4ccc:acdd:25da:14d1])
        by smtp.gmail.com with ESMTPSA id f21sm9066040pjj.52.2021.03.08.07.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 07:58:13 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 8 Mar 2021 07:58:11 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, joaodias@google.com
Subject: Re: [PATCH] mm: be more verbose for alloc_contig_range faliures
Message-ID: <YEZJk8YpUypT7q/j@google.com>
References: <d3095ead-a762-61cd-0990-702e14e03d10@redhat.com>
 <YEEUq8ZRn4WyYWVx@google.com>
 <c08662f3-6ae1-4fb5-1c4f-840a70fad035@redhat.com>
 <YEEi1+TREGBElE5H@google.com>
 <YEEle5xBAc7FUDNI@google.com>
 <YEYdR8azcawau9Rl@dhcp22.suse.cz>
 <c1461e51-7ad0-7fb5-9dc2-7f7c5cdf128f@redhat.com>
 <YEYwdjvYGiZ4crMt@dhcp22.suse.cz>
 <9f7b4b8a-5317-e382-7f21-01667e017982@redhat.com>
 <YEZF81vXGR8TX8sE@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEZF81vXGR8TX8sE@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 04:42:43PM +0100, Michal Hocko wrote:
> On Mon 08-03-21 15:13:35, David Hildenbrand wrote:
> > On 08.03.21 15:11, Michal Hocko wrote:
> > > On Mon 08-03-21 14:22:12, David Hildenbrand wrote:
> > > > On 08.03.21 13:49, Michal Hocko wrote:
> > > [...]
> > > > > Earlier in the discussion I have suggested dynamic debugging facility.
> > > > > Documentation/admin-guide/dynamic-debug-howto.rst. Have you tried to
> > > > > look into that direction?
> > > > 
> > > > Did you see the previous mail this is based on:
> > > > 
> > > > https://lkml.kernel.org/r/YEEUq8ZRn4WyYWVx@google.com
> > > > 
> > > > I agree that "nofail" is misleading. Rather something like
> > > > "dump_on_failure", just a better name :)
> > > 
> > > Yeah, I have read through the email thread. I just do not get why we
> > > cannot make it pr_debug() and add -DDYNAMIC_DEBUG_MODULE for
> > > page_alloc.c (I haven't checked whether that is possible for built in
> > > compile units, maybe it is not but from a quick seems it should).
> > > 
> > > I really do not like this to be a part of the API. alloc_contig_range is
> > 
> > Which API?
> 
> Any level of the alloc_contig_range api because I strongly suspect that
> once there is something on the lower levels there will be a push to have
> it in the directly consumed api as well. Besides that I think this is
> just a wrong way to approach the problem.
> 
> > It does not affect alloc_contig_range() itself, it's used
> > internally only. Sure, we could simply pr_debug() for each and every
> > migration failure. As long as it's default-disabled, sure.
> > 
> > I do agree that we should look into properly including this into the dynamic
> > debugging ifrastructure.
> 
> Yeah, unless we learn this is not feasible for some reason, which I do
> not see right now, then let's just make it pr_debug with the runtime
> control.

What do you see the problem? It's the dynamic debugging facility
to enable only when admin want to use it. Otherwise, it's nop
unless is't not enabled. Furthermore, it doesn't need to invent
custom dump_page implementation(including dump_page_owner) by
chaning pr_debug.
Could you clarify your requirement?

https://lore.kernel.org/linux-mm/YEEUq8ZRn4WyYWVx@google.com/

Since David agreed to drop nofail option in the API, I will
keep the URL patch.

