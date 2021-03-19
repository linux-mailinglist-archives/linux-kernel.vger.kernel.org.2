Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F10342078
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 16:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhCSPDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 11:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhCSPDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 11:03:21 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0739EC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 08:03:21 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id v2so3861564pgk.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 08:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q7Roh7B5+FwQQexECP34LRGge0KD+9IdWHo1Er07uE0=;
        b=i3kH2vg4RsZbccsmkM2GFQkVr/zwjO7RemoQUXUoIr7wfFJm9ZZ3MLzkl8lytEX5YA
         7OOIa9cJPIQhCIIxcbliLvLHLwAmw3G7BGAfj94cR1lJpYo7pifIdMwttDgfK0M+oZs9
         YMWXgd1sg32vMCiGf0MsnxAerHRh/EwFeNJ4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q7Roh7B5+FwQQexECP34LRGge0KD+9IdWHo1Er07uE0=;
        b=PODB5xzTXwMkOvzJcaPKeseYJCwzUOxDNi9MiYt7LTSrDiPVVG+L7PAcM8hOQ7H7ya
         7KSMzWkl2u9qJTef0V/HxVAXjU6B5n6QQltWcxao4JEkt5Q0UFNFRY8sLqv9ljOjSFKo
         dk59Ng61T4I0QlxTAhMZKXC97ysqxpXav3vjnpIy7zyDbVPvtURVMJsG0B8SrfXpeHF3
         XCD/+D0pZf38nKfr8ONtrU1NbQMxucqxX3GAijqTknIkM8LmQgg/v0l8HmCkty/9i3oM
         21a6wenusqvF4AmHfN3UnqxE52ym16DIbFZYce+NwLOCslFN7sWtRUypSfZnM5MhnloF
         9q/A==
X-Gm-Message-State: AOAM533kxmCMHmz22fXvhdG1hRLsYrutLoXSzwRH40iQZILOoGCCSvNz
        kJdEToREIvk4kKGpFYL3h85UoQ==
X-Google-Smtp-Source: ABdhPJzDhitGQobwUHAwMl2GkNZZr/BwlBh+dQLC1RA9lQikmH7lAUCxagM8szjGT0olxg3tJFH5OQ==
X-Received: by 2002:a65:41c6:: with SMTP id b6mr11563567pgq.7.1616166200586;
        Fri, 19 Mar 2021 08:03:20 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:6577:f83d:5865:dfac])
        by smtp.gmail.com with ESMTPSA id y15sm6607609pgi.31.2021.03.19.08.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 08:03:19 -0700 (PDT)
Date:   Sat, 20 Mar 2021 00:03:11 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     pmladek@suse.com, willy@infradead.org,
        andriy.shevchenko@linux.intel.com, david@redhat.com,
        linmiaohe@huawei.com, vbabka@suse.cz, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, joe@perches.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, lkp@intel.com
Subject: Re: [PATCH v6 resend 0/3] mm, vsprintf: dump full information of
 page flags in pGp
Message-ID: <YFS9L6vmwcR/z7hs@google.com>
References: <20210319101246.73513-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319101246.73513-1-laoar.shao@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/03/19 18:12), Yafang Shao wrote:
> 
> The existed pGp shows the names of page flags only, rather than the full
> information including section, node, zone, last cpuipid and kasan tag.
> While it is not easy to parse these information manually because there
> are so many flavors. We'd better interpret them in printf.
> 
> To be compitable with the existed format of pGp, the new introduced ones
> also use '|' as the separator, then the user tools parsing pGp won't
> need to make change, suggested by Matthew. The new added information is
> tracked onto the end of the existed one, e.g.
> [ 8838.835456] Slab 0x000000002828b78a objects=33 used=3 fp=0x00000000d04efc88 flags=0x17ffffc0010200(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
> 
> The documentation and test cases are also updated. The result of the
> test cases as follows,
> [68599.816764] test_printf: loaded.
> [68599.819068] test_printf: all 388 tests passed
> [68599.830367] test_printf: unloaded.
> 
> This patchset also includes some code cleanup in mm/slub.c.

The series looks good to me. FWIW,

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
