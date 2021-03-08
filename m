Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6E233106F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 15:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhCHOLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 09:11:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:38012 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229468AbhCHOLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 09:11:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615212663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pbE7xUaOZUpTd375UrFXZhkfFNrYHw34Jke7GnznOGQ=;
        b=AmEVNKxKn3lR7k0MSGq5MFHlmMPFI8Gsethwq6QHO33ZqkS2gJhixIzGUIZZt6nDeU5wZT
        Rfu20YmV/uNTcAnq1K8f4lkn+PzD7az7pv/56RQqO9wGviIeAla230+4OHtOAD9cvHVDux
        oO92keGhrZ4qGLmsJgq135Y+n7VDT2I=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CE9E3AE15;
        Mon,  8 Mar 2021 14:11:02 +0000 (UTC)
Date:   Mon, 8 Mar 2021 15:11:02 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, joaodias@google.com
Subject: Re: [PATCH] mm: be more verbose for alloc_contig_range faliures
Message-ID: <YEYwdjvYGiZ4crMt@dhcp22.suse.cz>
References: <YEEES/K8cNi8qOJe@google.com>
 <d83a03dd-fdff-ed62-a2ad-77b25d8249f0@redhat.com>
 <YEEJf0itS/8vn8Iy@google.com>
 <d3095ead-a762-61cd-0990-702e14e03d10@redhat.com>
 <YEEUq8ZRn4WyYWVx@google.com>
 <c08662f3-6ae1-4fb5-1c4f-840a70fad035@redhat.com>
 <YEEi1+TREGBElE5H@google.com>
 <YEEle5xBAc7FUDNI@google.com>
 <YEYdR8azcawau9Rl@dhcp22.suse.cz>
 <c1461e51-7ad0-7fb5-9dc2-7f7c5cdf128f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1461e51-7ad0-7fb5-9dc2-7f7c5cdf128f@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 08-03-21 14:22:12, David Hildenbrand wrote:
> On 08.03.21 13:49, Michal Hocko wrote:
[...]
> > Earlier in the discussion I have suggested dynamic debugging facility.
> > Documentation/admin-guide/dynamic-debug-howto.rst. Have you tried to
> > look into that direction?
> 
> Did you see the previous mail this is based on:
> 
> https://lkml.kernel.org/r/YEEUq8ZRn4WyYWVx@google.com
> 
> I agree that "nofail" is misleading. Rather something like
> "dump_on_failure", just a better name :)

Yeah, I have read through the email thread. I just do not get why we
cannot make it pr_debug() and add -DDYNAMIC_DEBUG_MODULE for
page_alloc.c (I haven't checked whether that is possible for built in
compile units, maybe it is not but from a quick seems it should).

I really do not like this to be a part of the API. alloc_contig_range is
a best effort allocator. Complaining about failure is too noisy. I do
agree that some sort of easy to enable debugging is due but please let's
make it as transparent to the code as possible.
-- 
Michal Hocko
SUSE Labs
