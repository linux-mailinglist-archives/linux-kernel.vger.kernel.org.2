Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B9839CB1C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 23:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhFEVER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 17:04:17 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:46747 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhFEVEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 17:04:16 -0400
Received: by mail-io1-f54.google.com with SMTP id o21so14166468iow.13
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 14:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NIy5STFt8B/kR9D8BVeg93HRdwmMgucQuLC6yJOK6dk=;
        b=lAJG4pOLeFVrMdUYm0OjIQElPvcRHUmHnw1HUNnP6tzmhnscLqh/Ak1Hkt9HoNZuWp
         oUU9jmELoZ1IOn4+oRjBxxUDWJn/QJoneqzujFEqcKPOD85uCgJxNvOrbzAaUJKkjVYW
         J3fCyTS5YoIJvM6gOdGH5PxftJbEYNLvVw8smmvlvDwZTYK3afxjyGbyKLhy5pqHTvAv
         QcxrnXmE67BLR0jSDptDU4ef5y9CJGi/qfZFKN3SrGGxMPgehmvTS4xDjIdJyJr1jQzN
         R3pGf9si34hU6as+y5inWYZeIAQbmIkUkohL6Gl8r6yHeuy1+JGBt/AQ6puBk9QtqqJj
         7WTg==
X-Gm-Message-State: AOAM533NjmaoBogUW1cgWkBEtvdrblnmeLt6V5Iuy3ZF0JphktCM6xeJ
        pP8MrTwj1O40STECuvoj2LQ=
X-Google-Smtp-Source: ABdhPJyWWrUSoYvQZHAGvmkQ8w2hjt/hHWfQs8X8zS6sFu5SF5NTFTWssaEfAwrwAJu3P4xyBg+cIQ==
X-Received: by 2002:a6b:a01:: with SMTP id z1mr1006458ioi.178.1622926947323;
        Sat, 05 Jun 2021 14:02:27 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id b8sm1567326iln.72.2021.06.05.14.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 14:02:26 -0700 (PDT)
Date:   Sat, 5 Jun 2021 21:02:25 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] percpu: memcg memory accounting rework
Message-ID: <YLvmYbbbeg6TK9Yh@google.com>
References: <20210603010931.1472512-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603010931.1472512-1-guro@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Jun 02, 2021 at 06:09:28PM -0700, Roman Gushchin wrote:
> This patchset reworks memcg-based accounting of the percpu memory:
> instead of using two types of chunks (memcg-aware and non-memcg-aware)
> it treats all chunks as memcg-aware. An extra memory used for objcg
> arrays will is compensated by a better chunks utilization, so the
> total memory footprint should be the same or smaller.
> 
> First two patches are preparational changes and cleanups on the memcg side.
> The third one is percpu accounting rework.
> 
> v2:
>   - make all chunks memcg-aware instead of on-demand objcg allocation, by Dennis
> 
> v1:
>   https://lkml.org/lkml/2021/5/11/1343
> 
> 
> Roman Gushchin (3):
>   mm, memcg: mark cgroup_memory_nosocket, nokmem and noswap as
>     __ro_after_init
>   mm, memcg: introduce mem_cgroup_kmem_disabled()
>   percpu: rework memcg accounting
> 
>  include/linux/memcontrol.h |   5 ++
>  mm/memcontrol.c            |  11 ++-
>  mm/percpu-internal.h       |  52 +--------------
>  mm/percpu-km.c             |   5 +-
>  mm/percpu-stats.c          |  46 +++++--------
>  mm/percpu-vm.c             |  11 ++-
>  mm/percpu.c                | 133 +++++++++++++++----------------------
>  7 files changed, 88 insertions(+), 175 deletions(-)
> 
> -- 
> 2.31.1
> 

Thanks for this! It greatly simplifies the chunk maintenance.

I've applied this to for-5.14.

There is a trivial merge conflict though due to my for-5.14 being based
on torvalds#v5.12-rc7, but that's fine.

Thanks,
Dennis
