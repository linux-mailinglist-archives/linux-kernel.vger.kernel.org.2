Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 459923CB75A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 14:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238665AbhGPM2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 08:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237729AbhGPM2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 08:28:45 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B96EC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 05:25:50 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 59-20020a9d0ac10000b0290462f0ab0800so9638181otq.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 05:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=jXHUmaf0y4/dZXXr0fZDyHacF0cZd0H8h+cDQdqOEEI=;
        b=uKODhxEVzy9dSJXhy+XN5tiHq9sMkKG1iBbWcWLaum2oTIcqLPxErKusLW0eBHNdHo
         4PFs9E0S8/w514nndILWNOHjOfSkV+GYH13S2tB2Kwb5L/iqP7QgLrrCvpHZ0FCPDqUD
         qbe0LNORN+x5XFtt2QSb7VScrt+IW8Og8lZZDhDvGIe5kV4eoDjdQ59Zrpf0b1o08PSY
         y41gTB/MsAWAsKz5zW2Cs2laPSDiNfC+SkZa5lJjZcG2XegAu7y3fTW9M+XRHX6lYYBI
         wsdgbjq1im34CzGKj0qwWl+HLURAZfF3ATZujlS+50LwCYoXo3MvNsGybp+Y6fP4uSOe
         iUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=jXHUmaf0y4/dZXXr0fZDyHacF0cZd0H8h+cDQdqOEEI=;
        b=p59aWCV/eXQO95e26VDS/FJH1Sknk87dXlETmA8AYD/sK3iNsvK7n9b/EOKMcCbpbT
         dtmLYiA9t2Axh1esa86Yd6Fi/56UXoKoZOZHUYX//pVYatR7JV/5zhaXbw5ZJvGf2G/g
         StzW8XkusKEix904XzcZoDWrgk0/NaXqXq/IlXQf2a1OmzOP+E2yWPFSVT3vrl+zJsRW
         Ezfo3ws5A43o7WsCsBxqwt22oLZYyOD0kWIrUpmWqCP+kaH2sMzmmc8kEmXBNpK4rtK3
         /pPmUAVy/3KGc/JdR9AApRZRl9MpuqkyYoFYRtCQ85xI93Hl9DkQIVMsA7BwxyKPtqf+
         45xg==
X-Gm-Message-State: AOAM5325k1emgbc2qQQ3c41UoBqdcacV93vSLyUqZqoPbvIKfbE4fxZ3
        TPcQX8jPD0T/P88HAreptXPCLg==
X-Google-Smtp-Source: ABdhPJz2/+owQkmQWuaI4LwLrBXqPA0Kkm19a8FSPQnyrS1wTBuTRzbuACHavWO/MnXehGrvO6Hg8w==
X-Received: by 2002:a9d:7a8e:: with SMTP id l14mr7790897otn.304.1626438349886;
        Fri, 16 Jul 2021 05:25:49 -0700 (PDT)
Received: from minyard.net ([2001:470:b8f6:1b:8515:1333:671e:f6ae])
        by smtp.gmail.com with ESMTPSA id y28sm1825305oti.80.2021.07.16.05.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 05:25:49 -0700 (PDT)
Date:   Fri, 16 Jul 2021 07:25:47 -0500
From:   Corey Minyard <cminyard@mvista.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     minyard@acm.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] oom_kill: oom_score_adj broken for processes with small
 memory usage
Message-ID: <20210716122547.GI3431@minyard.net>
Reply-To: cminyard@mvista.com
References: <20210701125430.836308-1-minyard@acm.org>
 <YPEW3H+W/uiRYIfn@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPEW3H+W/uiRYIfn@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2021 at 07:19:24AM +0200, Michal Hocko wrote:
> On Thu 01-07-21 07:54:30, minyard@acm.org wrote:
> > From: Corey Minyard <cminyard@mvista.com>
> > 
> > If you have a process with less than 1000 totalpages, the calculation:
> > 
> >   adj = (long)p->signal->oom_score_adj;
> >   ...
> >   adj *= totalpages / 1000;
> > 
> > will always result in adj being zero no matter what oom_score_adj is,
> > which could result in the wrong process being picked for killing.
> > 
> > Fix by adding 1000 to totalpages before dividing.
> 
> Yes, this is a known limitation of the oom_score_adj and its scale.
> Is this a practical problem to be solved though? I mean 0-1000 pages is
> not really that much different from imprecision at a larger scale where
> tasks are effectively considered equal.

Known limitation?  Is this documented?  I couldn't find anything that
said "oom_score_adj doesn't work at all with programs with <1000 pages
besides setting the value to -1000".

> 
> I have to say I do not really like the proposed workaround. It doesn't
> really solve the problem yet it adds another special case.

The problem is that if you have a small program, there is no way to
set it's priority besides completely disablling the OOM killer for
it.

I don't understand the special case comment.  How is this adding a
special case?  This patch removes a special case.  Small programs
working different than big programs is a special case.  Making them all
work the same is removing an element of surprise from someone expecting
things to work as documented.

-corey
