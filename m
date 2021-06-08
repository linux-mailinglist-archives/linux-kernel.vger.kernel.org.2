Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2CC39F31C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 12:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhFHKCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 06:02:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52472 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230409AbhFHKCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 06:02:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623146427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JND2frCWRGgyWqu7W6hdAZIyDUa7F8JPqLflBI5a/oo=;
        b=W+kxHJ+3fglTu2lbzgq5xNIcgpfZgF3UDW1ioTGpWEbudwpFu3C6ed7V8BNtjt/xZcMlGV
        4tLwUBqfsH8fUdePGpQQ1h2cE5J2yFjXsLj82tX8YzzEOza/o9IXrWVnX+YfR6DKZTeCri
        //9dLCQ23DdcCeGlEOZHp5R7QyPIT9U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-956BlhM5PRqTPWzQOlbLWg-1; Tue, 08 Jun 2021 06:00:25 -0400
X-MC-Unique: 956BlhM5PRqTPWzQOlbLWg-1
Received: by mail-wm1-f71.google.com with SMTP id z25-20020a1c4c190000b029019f15b0657dso520921wmf.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 03:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JND2frCWRGgyWqu7W6hdAZIyDUa7F8JPqLflBI5a/oo=;
        b=cJcCjsicPXfiBXwIbQPBxLBoBmuUr2KydVi3QDuOPT+1Fnqam0VjYrtCVkDp5V1pYy
         Y6087V+MMVGwigw61elhRcn+oi5VUgJr/MTC+sR4Rzzg5TPYe1LfBG+mFX9lbQ8sSoLd
         ladpiGo6w6TD1QuJGyeAMHnKkd5mlqZf2owLUZpJ3zg+9e4iC3WtBXMcb57VEIRY3zF6
         zOVkHZePJDDcF5pjXNrTfSReXHHCDlAG/7z2ZQXWdnNovWviWXfo+amN+WOrTzQPNp6D
         W+JunhJ62ACKaCbP/GveEO8DGk48QrHONFfDKrZyNEL4OLI1OvTlCB7f65kehg45fQYw
         iZGQ==
X-Gm-Message-State: AOAM530gMyUTHuvrn87Gjl78SWqZMGkQCLgJ3ml2UNL3xWr4s86icw/Y
        iTzxklZ6TyKYLxLBc0gGeZKBQX9xRTiq7E6meR83KTA1ogqas8kSfSBh0BOxg7MeBhMNuQvAAjW
        1Hhy2v0rXPLYI/BVuCiXNEbA=
X-Received: by 2002:a1c:2584:: with SMTP id l126mr230571wml.83.1623146423660;
        Tue, 08 Jun 2021 03:00:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyR3GgjmmBrMhF1WwnNBpcXzUOchhaVQjlPkLqb0xyECxK4WlBe39PUW6HAMFccKOA/QvuIuA==
X-Received: by 2002:a1c:2584:: with SMTP id l126mr230555wml.83.1623146423474;
        Tue, 08 Jun 2021 03:00:23 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id b15sm18337797wru.64.2021.06.08.03.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 03:00:23 -0700 (PDT)
Date:   Tue, 8 Jun 2021 11:00:22 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Waiman Long <llong@redhat.com>, Shakeel Butt <shakeelb@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm/oom_kill: allow oom kill allocating task for
 non-global case
Message-ID: <20210608100022.pzuwa6aiiffnoikx@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20210607163103.632681-1-atomlin@redhat.com>
 <c16893a9-35e2-7625-d7f3-83488f874040@redhat.com>
 <CALvZod4eUoquGTQ5AsWgbWTQyqtCNNwb-9+fRw_ZPavH-r9dbA@mail.gmail.com>
 <dc7f54eb-933e-5bbb-7959-815dfbfcc836@redhat.com>
 <YL5tqdw+iWLLavxV@dhcp22.suse.cz>
 <6d23ce58-4c4b-116a-6d74-c2cf4947492b@redhat.com>
 <YL51Tp/3jVHUrpuj@dhcp22.suse.cz>
 <YL57rLFwAo7EpYeH@dhcp22.suse.cz>
 <353d012f-e8d4-c54c-b33e-54737e1a0115@redhat.com>
 <YL8MjSteKeO7w0il@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YL8MjSteKeO7w0il@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-06-08 08:22 +0200, Michal Hocko wrote:
> OK. A full report (including the backtrace) would tell us more what is
> the source of the charge. I thought that most #PF charging paths use the
> same gfp mask as the allocation (which would include other flags on top
> of GFP_KERNEL) but it seems we just use GFP_KERNEL at many places.

The following is what I can provide for now:

  [ 8227.242706] Out of memory and no killable processes...
  [ 8227.242731] node invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), nodemask=(null), order=0, oom_score_adj=999
  [ 8227.242732] node cpuset=XXXX mems_allowed=0-1
  [ 8227.242736] CPU: 12 PID: 1703347 Comm: node Kdump: loaded Not tainted 4.18.0-193.51.1.el8_2.x86_64 #1
  [ 8227.242737] Hardware name: XXXX
  [ 8227.242738] Call Trace:
  [ 8227.242746]  dump_stack+0x5c/0x80
  [ 8227.242751]  dump_header+0x6e/0x27a
  [ 8227.242753]  out_of_memory.cold.31+0x39/0x8d
  [ 8227.242756]  mem_cgroup_out_of_memory+0x49/0x80
  [ 8227.242758]  try_charge+0x58c/0x780
  [ 8227.242761]  ? __alloc_pages_nodemask+0xef/0x280
  [ 8227.242763]  mem_cgroup_try_charge+0x8b/0x1a0
  [ 8227.242764]  mem_cgroup_try_charge_delay+0x1c/0x40
  [ 8227.242767]  do_anonymous_page+0xb5/0x360
  [ 8227.242770]  ? __switch_to_asm+0x35/0x70
  [ 8227.242772]  __handle_mm_fault+0x662/0x6a0
  [ 8227.242774]  handle_mm_fault+0xda/0x200
  [ 8227.242778]  __do_page_fault+0x22d/0x4e0
  [ 8227.242780]  do_page_fault+0x32/0x110
  [ 8227.242782]  ? page_fault+0x8/0x30
  [ 8227.242783]  page_fault+0x1e/0x30

-- 
Aaron Tomlin

