Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 137FB331885
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 21:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhCHU1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 15:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbhCHU13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 15:27:29 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180FFC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 12:27:29 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id l7so7977744pfd.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 12:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hRPr7bnVWx2uLZbAR2SmsL4C/BUZ3foyYS3yoqELctA=;
        b=CQ+22zVCKbytUwtlSHsq2hjwFobUy+C9SvYr9BU1S5e6NNM7CI9S+Pe0Z7CaEjt2nu
         Mgkz29NQvQD/LkysXDVMir8DsTKW82Yk0V2PC1j24ZvvihJu5seqMoo4LMs2MeE2Zb8Z
         RhBg29gAlMtrg+SwG+pzDgjpX6T5uRJd/p3yQRn6dPEtjnYh020mSMDt+djhVhmixOsI
         Xk4V1T//5txX1lhpofjI9MFOtF4tP+74zLBZhIp7I9mNAXGNuhoxPVakB0/SN73qsxIH
         s2Gi7VxtXxQlQwzj96/C97TuIGEEb9nl4r6JgbP2ZbQdXq7ctT6tNAOnoZxBL48Bq669
         C4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=hRPr7bnVWx2uLZbAR2SmsL4C/BUZ3foyYS3yoqELctA=;
        b=sHW1tQcSN2672slE105bX2Y0XSwXFF6BClzXvhMoU3XU+hVeONW55/tfnDwzdlRBdF
         AD46IJLtLIbfhPwO0hG56YxynD/4PBAATEdo/m9wWAylW3FPg9a6s75yZ42xXZGg6ytm
         7KEbj1Dna1IVbE47koWlOj42yjPKfQsT5rKR3wy2zakJc9lQ0CH3KkaeOvbXipCwvOH4
         omU4plS7Fnz23cot1VhuzyRlseZBot5vMi0yX/wv7ta9Nx1k6ELRJbGnN0QzFkwioUJY
         IOtKYIwiq05nKUnId2jbmbJRSShibdXH12VnDG+2Ox+B0d4J4rBiCZVWflV4cau0HW/m
         Nnzw==
X-Gm-Message-State: AOAM532CgfgJPx/DDAQYFbUpx7FvJotXY4fQDllBDxEvQ7eccVHVUH/J
        SlchFYdUDcdpczlvGAi2Itc=
X-Google-Smtp-Source: ABdhPJxGj8Vm9an4DDqk0D1+m0qqdClAMlqRoMzd1HW58FTJNENo873vU0iPcZCzEor3g2Jeh95xaQ==
X-Received: by 2002:a63:fa02:: with SMTP id y2mr21676670pgh.412.1615235248690;
        Mon, 08 Mar 2021 12:27:28 -0800 (PST)
Received: from google.com ([2620:15c:211:201:4ccc:acdd:25da:14d1])
        by smtp.gmail.com with ESMTPSA id 134sm11299449pfc.113.2021.03.08.12.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 12:27:27 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 8 Mar 2021 12:27:25 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, joaodias@google.com
Subject: Re: [PATCH] mm: be more verbose for alloc_contig_range faliures
Message-ID: <YEaIrZ8YBZbFcX42@google.com>
References: <YEEUq8ZRn4WyYWVx@google.com>
 <c08662f3-6ae1-4fb5-1c4f-840a70fad035@redhat.com>
 <YEEi1+TREGBElE5H@google.com>
 <YEEle5xBAc7FUDNI@google.com>
 <YEYdR8azcawau9Rl@dhcp22.suse.cz>
 <c1461e51-7ad0-7fb5-9dc2-7f7c5cdf128f@redhat.com>
 <YEYwdjvYGiZ4crMt@dhcp22.suse.cz>
 <9f7b4b8a-5317-e382-7f21-01667e017982@redhat.com>
 <YEZF81vXGR8TX8sE@dhcp22.suse.cz>
 <YEZJk8YpUypT7q/j@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEZJk8YpUypT7q/j@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 07:58:11AM -0800, Minchan Kim wrote:
> On Mon, Mar 08, 2021 at 04:42:43PM +0100, Michal Hocko wrote:
> > On Mon 08-03-21 15:13:35, David Hildenbrand wrote:
> > > On 08.03.21 15:11, Michal Hocko wrote:
> > > > On Mon 08-03-21 14:22:12, David Hildenbrand wrote:
> > > > > On 08.03.21 13:49, Michal Hocko wrote:
> > > > [...]
> > > > > > Earlier in the discussion I have suggested dynamic debugging facility.
> > > > > > Documentation/admin-guide/dynamic-debug-howto.rst. Have you tried to
> > > > > > look into that direction?
> > > > > 
> > > > > Did you see the previous mail this is based on:
> > > > > 
> > > > > https://lkml.kernel.org/r/YEEUq8ZRn4WyYWVx@google.com
> > > > > 
> > > > > I agree that "nofail" is misleading. Rather something like
> > > > > "dump_on_failure", just a better name :)
> > > > 
> > > > Yeah, I have read through the email thread. I just do not get why we
> > > > cannot make it pr_debug() and add -DDYNAMIC_DEBUG_MODULE for
> > > > page_alloc.c (I haven't checked whether that is possible for built in
> > > > compile units, maybe it is not but from a quick seems it should).
> > > > 
> > > > I really do not like this to be a part of the API. alloc_contig_range is
> > > 
> > > Which API?
> > 
> > Any level of the alloc_contig_range api because I strongly suspect that
> > once there is something on the lower levels there will be a push to have
> > it in the directly consumed api as well. Besides that I think this is
> > just a wrong way to approach the problem.
> > 
> > > It does not affect alloc_contig_range() itself, it's used
> > > internally only. Sure, we could simply pr_debug() for each and every
> > > migration failure. As long as it's default-disabled, sure.
> > > 
> > > I do agree that we should look into properly including this into the dynamic
> > > debugging ifrastructure.
> > 
> > Yeah, unless we learn this is not feasible for some reason, which I do
> > not see right now, then let's just make it pr_debug with the runtime
> > control.
> 
> What do you see the problem? It's the dynamic debugging facility
> to enable only when admin want to use it. Otherwise, it's nop
> unless is't not enabled. Furthermore, it doesn't need to invent
> custom dump_page implementation(including dump_page_owner) by
> chaning pr_debug.
> Could you clarify your requirement?
> 
> https://lore.kernel.org/linux-mm/YEEUq8ZRn4WyYWVx@google.com/
> 
> Since David agreed to drop nofail option in the API, I will
> keep the URL patch.

I posted formal patch with Ccing dynamic debug maintainer.
https://lore.kernel.org/linux-mm/20210308202047.1903802-1-minchan@kernel.org/

Let's discuss stuff related to dynamic debug there.
