Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A98CD3BEA0C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 16:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbhGGOuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 10:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbhGGOuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 10:50:37 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC09C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 07:47:55 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id u25so2988566ljj.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 07:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YvjmMvDpczJUOj6MRPrVMSwe4+RsIZimfDsJ8UxpWfc=;
        b=tvInKCoNOpOC+YvG2+0TqVANv95mKzSnq6V9suFz+Hd4UqEU4Ys7itHxue76ks7obE
         UQqE9/+t1X5EBUkcL84GPLoNftEHdiqJjdDuPItFLRdl35x6aShvoicRmIUv0Hnzx5EI
         NDLNWeWNUm65CJIygNHNOIt7foAlYvkDXrPVJGLhrlWJgj+9qfS7oIITinxrL5K4Ft7Z
         ZCruFz1qX3x0eN+yBY63CeTioG7vQWSNWoJhUT2ERP5KnHmZQEItUcSf0RMgKYVgtmjJ
         Ol4gTTHGSVyjT6a6rv0XBIS5CZnrlWvP44/qXnqvbqufQVrzzDVWGiK+AJSk9jkQr1a8
         kd0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YvjmMvDpczJUOj6MRPrVMSwe4+RsIZimfDsJ8UxpWfc=;
        b=fxRx7ztzLsEklZHUDjMn6O3Y6E4Znc8qPqKJbKj3Ufb6M+qZR6w9es9stdVuH4P39g
         +fVDkf2wYqOMYDmnImMh92gTdCHoJNns+GP5oYKO9Jcf6+jnTkOEKPZjbvqSH56BUI9+
         l8tO7E5VHHK+HjECSiH/P0VGOYFmLvbPbLN7z5yTjfWeWu+RA5Kc8wzVcoXb74Q85Hr2
         2RbGNm5GUFrlhHorgcKvYW/1TkJh6A1LngAqUsoDyKJV+jTBykMMKkAu3lDIIGTWzeS6
         Yen6sX7AJgaymJR/EZaf3JC4YYJhh6fAnfQRH/wC/n6LT1/IDNATPIHtWO6kq4X7So8f
         6XPg==
X-Gm-Message-State: AOAM531/1sFEf/wjyouDisdzbLls6x/bDA8XxTnlxgq5Jyw0V6jCcjgE
        +zTfOnmYUHYG6Juy/06yWEo=
X-Google-Smtp-Source: ABdhPJwarOPGDwnlHyB+XJypRB7sAaEv/wMWsX8dJkaqDxDZ4K2YzM0B3HgD6E6EnzgCbTE6FcYKhQ==
X-Received: by 2002:a2e:9e1a:: with SMTP id e26mr19810601ljk.265.1625669274105;
        Wed, 07 Jul 2021 07:47:54 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id 70sm1352466ljj.81.2021.07.07.07.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 07:47:53 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Wed, 7 Jul 2021 16:47:51 +0200
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 1/2] mm/vmalloc: Use batched page requests in
 bulk-allocator
Message-ID: <20210707144751.GB1863@pc638.lan>
References: <20210705170537.43060-1-urezki@gmail.com>
 <20210706132653.8374852963b25989e360d599@linux-foundation.org>
 <YOVo9bBtncG3/uLi@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOVo9bBtncG3/uLi@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2021 at 10:42:29AM +0200, Michal Hocko wrote:
> On Tue 06-07-21 13:26:53, Andrew Morton wrote:
> > On Mon,  5 Jul 2021 19:05:36 +0200 "Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:
> > 
> > > In case of simultaneous vmalloc allocations, for example it is 1GB and
> > > 12 CPUs my system is able to hit "BUG: soft lockup" for !CONFIG_PREEMPT
> > > kernel.
> > > 
> > > <snip>
> > > ...
> > >
> > > are obtained, i.e. do batched page requests adding cond_resched() meanwhile
> > > to reschedule. Batched value is hard-coded and is 100 pages per call.
> > > 
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > 
> > Can we please have a Fixes: for this?
> 
> Is this a fix for any actual real life problem? I mean allocating 1GB of
> vmalloc space back and forth sounds like a stretch to me.
>  
It is not a real scenario. I simulated it by the stress-suite tests. So the
Fixes tag is not needed, IMHO.

> > Is this fix important enough for 4.14-rcx?  I think so...
> 
> I do not think so. This is an improvement so that vmalloc behaves more
> sanely for those abusers...
>
A bulk-allocator has recently been introduced, so 4.x does not have it,
i.e. this change is not applicable and 4.x kernel does not suffer from
it.

--
Vlad Rezki
