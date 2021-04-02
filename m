Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597BE352F27
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 20:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbhDBSZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 14:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhDBSZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 14:25:25 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C64EC0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 11:25:24 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id i81so5680598oif.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 11:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=j/8kqi2RzLaV+tl67ICL3y3OLhR7VMGrEFOXn5sbrIw=;
        b=U9aR8sIhlMWss915BMjr4dOCFnbwtKYGK8K+pSdO/IR7Z523O1bz9qUHdcVwRhFeyd
         bocjBCjNVOQsDoFVlscAA9IjBIohVynFC/kkOL7SpTCt9yZEBspKqm5LnXbNdMm2lhmd
         eyQFdvMOicX/rsQYw5p/eN0udh7AQNezdjmfSdw8JyanCT94wuurTkCe3kfsFzSl0F53
         l+ITjQYsrl6YoQoTmbMkS+25u/Fn4ij9CxJkO8fXy84CRv9aDSKuy3sRUXS84qEVbDhr
         vewsdhafCMcrrn0mD+o9sv0Io3Ro7TVy5SbUrguo4WKPb9scDSw3uH5ZrzbIopFAKaBL
         xClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=j/8kqi2RzLaV+tl67ICL3y3OLhR7VMGrEFOXn5sbrIw=;
        b=Fdl/4hTGEuErCT67NmeaEQY1fbN2dmVf74HvLxPEMhjVg6sOCjQRIPEFhBJXlATOvC
         GpJfwyrsqmgAhxU1AMUYi9hUGy3BkUZ1bZloljjzuicZMwdo8xeG8w1GUdp12KhCT3Te
         Nd1W8tdwaMJ3l6ZilkJUN8YCpsNQceuqT5XiQ+1YCh8rPL+wPGjLy0ibDMLFYbLqa9bK
         YlVa9npumnRsfLZ78PxbaN3YxeGAhc53mysYCq02q1OpVf5Hs1uiAZJwG7jNjHgXp/ab
         JhN+YUsAbfWYPJ1e+BxEejZxk7kHn9OTSPYIjS2eV/Wq+rsir2xCcYQhHIklLQ9uV33d
         RvdQ==
X-Gm-Message-State: AOAM531AZwuyvDMsz/+JPU5ZYigPSf2AXNi5f50/sUxl43gT6sqd54Rc
        koecZNGxBy3gSafRqKwLLA==
X-Google-Smtp-Source: ABdhPJyg8NjnwNN5qdOUaRIaeljwQA6KWBzkKsF3jz1qQ+ernlsCE+e5GXERUHs141Cd2IAzPWfJFw==
X-Received: by 2002:a05:6808:94:: with SMTP id s20mr10488250oic.25.1617387923286;
        Fri, 02 Apr 2021 11:25:23 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id m14sm2032594otn.69.2021.04.02.11.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 11:25:22 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:f99f:823a:495e:5af])
        by serve.minyard.net (Postfix) with ESMTPSA id E2F02180053;
        Fri,  2 Apr 2021 18:25:21 +0000 (UTC)
Date:   Fri, 2 Apr 2021 13:25:20 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Corey Minyard <cminyard@mvista.com>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] ipmi_si: Set of clean ups
Message-ID: <20210402182520.GZ507977@minyard.net>
Reply-To: minyard@acm.org
References: <20210402174334.13466-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402174334.13466-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2021 at 08:43:24PM +0300, Andy Shevchenko wrote:
> The series contains set of clean ups, main parts of which are:
>  - use ne platform_get_mem_or_io() API
>  - use match_string() API

As I have already said, a very nice set of cleanups.  Thank you.
These are applied and in the ipmi linux-next tree.

-corey

> 
> Since v2:
> - patch 3: rephrased commit message (Corey)
> - patch 5: added a comment that array maps to enum (Corey)
> - patch 5: added "ipmi" prefix to the name of the array
> - patch 6: just exported array w/o moving to header (Corey)
> - wrapped up cover letter
> 
> Andy Shevchenko (10):
>   ipmi_si: Switch to use platform_get_mem_or_io()
>   ipmi_si: Remove bogus err_free label
>   ipmi_si: Utilize temporary variable to hold device pointer
>   ipmi_si: Use proper ACPI macros to check error code for failures
>   ipmi_si: Introduce ipmi_panic_event_str[] array
>   ipmi_si: Reuse si_to_str[] array in ipmi_hardcode_init_one()
>   ipmi_si: Get rid of ->addr_source_cleanup()
>   ipmi_si: Use strstrip() to remove surrounding spaces
>   ipmi_si: Drop redundant check before calling put_device()
>   ipmi_si: Join string literals back
> 
>  drivers/char/ipmi/ipmi_msghandler.c  | 54 ++++++----------
>  drivers/char/ipmi/ipmi_si.h          |  8 ++-
>  drivers/char/ipmi/ipmi_si_hardcode.c | 73 ++++++++-------------
>  drivers/char/ipmi/ipmi_si_hotmod.c   | 24 ++-----
>  drivers/char/ipmi/ipmi_si_intf.c     | 32 ++++------
>  drivers/char/ipmi/ipmi_si_pci.c      | 22 ++-----
>  drivers/char/ipmi/ipmi_si_platform.c | 95 ++++++++++++----------------
>  7 files changed, 112 insertions(+), 196 deletions(-)
> 
> -- 
> 2.30.2
> 
