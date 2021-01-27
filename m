Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE55930667E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 22:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbhA0VkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 16:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbhA0VhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 16:37:16 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022A1C061574
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 13:36:36 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id t14so2596330qto.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 13:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lNOvbjt1bUfMGcZugNLjUI/737MPDTbeRw1IzKJi2eQ=;
        b=ZUHYKvD/f7gfdzVlNTUsYDwgvYc+DJ7QGuWrtX/oOfWv8lCGGWUUq2SURXDRPtqBOY
         5f3ZzIVpXCX9iveXRHWT4AlUX9hGfIuGxxYxmQ7pE+aN/NzGYhuoeZtOMXi1tfOZljI7
         4UY2kgugvmeBKAV+6+BYM/e/hFWQQY4asnID3TB7GIyjD1IUa3nPNlxRDctzmu6jP0qX
         IUf64VkjBES5TZUoo+5Z7CfX6W7Fi21VmDiOG/7E9iehScjKlSqbFmdnYZC+P9h6nLGS
         4aSQF6N9wX4SynT0XXFYkIfkS/25ofcAnoiuoc4H+58zZxS7vCmekaKX5cXJLUtSybTk
         IlwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=lNOvbjt1bUfMGcZugNLjUI/737MPDTbeRw1IzKJi2eQ=;
        b=CoK+IhUqx10gAWap21zy7aXD/KHn+jkQ/roWM+YLUlv/pSl5iuhLHTW6RSmZQhiQe2
         UZnMCLJSDqxgvJFz1M6zmxqWXYlw4zutFjIWSeRfgrmzRBn3bbpvydKIdB2TuD74zHZh
         XgvMmSjgbKRP6osVU0e03vx0oVljB0NqZYRfqXq03RsYyg7nkdovulw3nu1asTSe+tWz
         DcxY4j0sk57FgN7xM5g5zAUrUEASkiRD3j6CdOTcTJ6G6txjUYCyrIu9rRPvMgHRMUbQ
         D5EmMde6rcR6LSBUdcdCpX4OTwIHvRlYmHmXeG6VlgJTq5GSkUs0py5IhaTl/mXddv07
         J2eg==
X-Gm-Message-State: AOAM533KYsVt4IJ1IkF7yLi5J5bjP6Dygx9jZh+DK4DCIJQuj0P/kRUj
        g1u0N6fZJVLXyKr418jDil4=
X-Google-Smtp-Source: ABdhPJxbS67Gfx8AilzTBxRUK4WKIE/R+t15gzjlSWGDgYELeNH+0bTmtOM4Z6f75U44uLv8nuWt/g==
X-Received: by 2002:ac8:5d44:: with SMTP id g4mr11986656qtx.93.1611783395084;
        Wed, 27 Jan 2021 13:36:35 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id w27sm2124076qtt.1.2021.01.27.13.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 13:36:34 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 27 Jan 2021 16:36:32 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Saravanan D <saravanand@fb.com>, x86@kernel.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH V2] x86/mm: Tracking linear mapping split events
Message-ID: <YBHc4JHc4ogwV93W@slm.duckdns.org>
References: <bd157a11-8e6b-5f44-4d91-d99adb9f8686@intel.com>
 <20210127175124.3289879-1-saravanand@fb.com>
 <YBHVCZscdVsxbFUk@slm.duckdns.org>
 <5562757e-578b-0ad7-1a9c-c64238283ab7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5562757e-578b-0ad7-1a9c-c64238283ab7@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Jan 27, 2021 at 01:32:03PM -0800, Dave Hansen wrote:
> >>  arch/x86/mm/pat/set_memory.c  | 117 ++++++++++++++++++++++++++++++++++
> >>  include/linux/vm_event_item.h |   8 +++
> >>  mm/vmstat.c                   |   8 +++
> >>  3 files changed, 133 insertions(+)
> > 
> > So, now the majority of the added code is to add debugfs knobs which don't
> > provide anything that userland can't already do by simply reading the
> > monotonic counters.
> > 
> > Dave, are you still set on the resettable counters?
> 
> Not *really*.  But, you either need them to be resettable, or you need
> to expect your users to take snapshots and compare changes over time.
> Considering how much more code it is, though, I'm not super attached to it.

Saravanan, can you please drop the debugfs portion and repost?

Thanks.

-- 
tejun
