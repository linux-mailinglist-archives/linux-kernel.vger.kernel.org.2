Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0886732AB1E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 21:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836262AbhCBUIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 15:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1580135AbhCBRaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 12:30:25 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBC8C0617A7
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 09:29:21 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id l18so2477513pji.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 09:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3aMc27tpAIEfKlaleQ63UwE+oQiX3xp96PGjmghrhTg=;
        b=iUwjJGNfPxHb9Lk8qYHVrPWUX+3s+sN3sTys7j387re1W2aHHgvnCu+5BErtGgbufa
         8yLRV+PZVRpkXCcVfwcm3pvpK3yZA/ID0YyAYYFumfgYbizl7E2JSojdq/FTtZr2cNZv
         z4jN+B5NNg8v4XzwXFH5TePq93QtmtkYJdPGFN7Iugt30e7toqDSUnC5tIg7LmEQsLc5
         2A+8WMf95zaUxlk33oPgSG/7TlEjiSxH1YPbZMhqL/rhOcygTvIL0Rrc+/E6ndoIO6ef
         jcDKy/nLnsDodMZj+GuykGbXTYx9gkVpjxct6XAW5txZujQAaq/01PdvS/Cx9CwKeErm
         eJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=3aMc27tpAIEfKlaleQ63UwE+oQiX3xp96PGjmghrhTg=;
        b=rZ0gw3zu5g+SiKblw0OjpJqxLxDhtaTixT9/snXFWEVfKBdZk0YXgUcaW1sOpQvS5t
         mXorid5MLpdhgm6UuH7Vk+KTQ6RHAjWvh3KhiRzve/kak+QU7NuKSQQsV2GYWjVVUON+
         byJOdbQ2tzzfVzUXNrQUxE7mGGXATf5n/pc/xadp650J2M94cfa+JcG8RduksHXWqgXB
         f32gda68Q2emiU2uIrqG+s/dRx3OnTCFmW4gNr8LeB0Q2F5uXjfRnkEtc4SmsIX0HGk/
         GDRitFD8Wt/GWRfxlPWE2UsQ0rE3UN0MeUR7lAPGhS6MBdygoe+cUyy2r3b00SPygh/L
         PnuA==
X-Gm-Message-State: AOAM532E1gGDsc81g3u+RBFFxcl8UOkQLZH1S3sNnCBbYVAzm1d1U4SL
        rVU8xGvfKhEJk6V2vm2Nguw=
X-Google-Smtp-Source: ABdhPJwo06XEcbjKhcPToXinlb0dWl2XGRjySi5KIHLpgZ1P0zL/Tw34MyTvOh8jXZ32KZOSz+3fOw==
X-Received: by 2002:a17:902:8697:b029:e3:9724:e260 with SMTP id g23-20020a1709028697b02900e39724e260mr4460941plo.31.1614706161096;
        Tue, 02 Mar 2021 09:29:21 -0800 (PST)
Received: from google.com ([2620:15c:211:201:297a:af1:8ccf:6094])
        by smtp.gmail.com with ESMTPSA id b188sm23106282pfg.179.2021.03.02.09.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 09:29:20 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 2 Mar 2021 09:29:18 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v1] mm/page_alloc: drop pr_info_ratelimited() in
 alloc_contig_range()
Message-ID: <YD517sld9BFO0W6e@google.com>
References: <20210301150945.77012-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301150945.77012-1-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 04:09:45PM +0100, David Hildenbrand wrote:
> The information that some PFNs are busy is:
> a) not helpful for ordinary users: we don't even know *who* called
>    alloc_contig_range(). This is certainly not worth a pr_info.*().
> b) not really helpful for debugging: we don't have any details *why*
>    these PFNs are busy, and that is what we usually care about.
> c) not complete: there are other cases where we fail alloc_contig_range()
>    using different paths that are not getting recorded.
> 
> For example, we reach this path once we succeeded in isolating pageblocks,
> but failed to migrate some pages - which can happen easily on
> ZONE_NORMAL (i.e., has_unmovable_pages() is racy) but also on ZONE_MOVABLE
> i.e., we would have to retry longer to migrate).
> 
> For example via virtio-mem when unplugging memory, we can create quite
> some noise (especially with ZONE_NORMAL) that is not of interest to
> users - it's expected that some allocations may fail as memory is busy.
> 
> Let's just drop that pr_info_ratelimit() and rather implement a dynamic
> debugging mechanism in the future that can give us a better reason why
> alloc_contig_range() failed on specific pages.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: David Hildenbrand <david@redhat.com>

I agree it's not useful to dump just range. Rather than, dump_page
would be much helpful.

Acked-by: Minchan Kim <minchan@kernel.org>
