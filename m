Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6023429AB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 02:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhCTBlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 21:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhCTBlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 21:41:06 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2155C061760
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 18:41:06 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id r17so4857885pgi.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 18:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oWdIOPAkZfr1BoujvrjjbGLV84XJk3QFa5vSlgO7ACI=;
        b=sOLb6DanI+zm5MFPForuIykm6CHj/PtN+oXFpBhQmcrrR5idcrXbqKnIB7N7bOLuuq
         p3SHcXX/mt2M8rwjX5aN1Zi259kXlIpgHYettXIDWhdimrHhk+Czv1vdVdu2qE7+6qPL
         L0T6JZYa+2G9AYm3I+7Qlt9VVMnF6WXsT+z5FLopQfWZ1lJBeyOPI4EStu4fORX+AmE9
         jKSsOp5uQJq89Fa140cV2bxJfA+y3+ztNrbSUgg8HuvDu2UMGQM/wd4jwomQqtlkM6Tf
         c0iG8fb5Q7CezO2+iLCMHy8JrhzfTpqxrQzgF+F24HUNU1v5itQx039AKXGvcEFMvqmD
         WVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oWdIOPAkZfr1BoujvrjjbGLV84XJk3QFa5vSlgO7ACI=;
        b=XwWtT8BP56v75SgIS+Anwp7um41Mae2YrH7XuWmENxj88GYEosV9hzZAwYwfJooW5a
         ApkwH67lSC0YPzMk9ylt+mDWljdTvZmqqvepSXEu3+U0KccCZbx/U/H9Tu5Z/4CmHUkS
         llmsppeSFJjgcMO1dhCMrp28u/NpTjgd/VjbNCrDWUT2/x7jmxgjIiuodwpi1+r900B7
         rCI4/phxfKRL8J9WzS5entfh/zsUKU1Nngdap44N3SRyjgN3g9TGvyChwVrVRCoJhEn4
         34Zc9lCqaB/aykqUSbUUHzJtXzs4B9DwgdXRw1lcVQL0jQA6d7AQ6HJvErqc9Ly3n6hg
         qP/Q==
X-Gm-Message-State: AOAM5336ptn6mbcAP10tVHKhLDOzye8fJwseH/78Z9+OkO78pjbciwOh
        baRLArWFmvGEtHxRSJzeecg=
X-Google-Smtp-Source: ABdhPJx0W9fCwaT8UQdJG3P26P2B6HAB0ynZeZvZHx2tVy0Y5WbW6HCKUtmhyouZzzOoxt8gqGFNZg==
X-Received: by 2002:a65:44c5:: with SMTP id g5mr14108950pgs.295.1616204466016;
        Fri, 19 Mar 2021 18:41:06 -0700 (PDT)
Received: from localhost ([103.250.185.142])
        by smtp.gmail.com with ESMTPSA id y29sm6830981pfp.206.2021.03.19.18.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 18:41:04 -0700 (PDT)
Date:   Sat, 20 Mar 2021 12:40:57 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Daniel Axtens <dja@axtens.net>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@csgroup.eu, aneesh.kumar@linux.ibm.com
Subject: Re: [PATCH v11 0/6] KASAN for powerpc64 radix
Message-ID: <20210320014057.GA77072@balbir-desktop>
References: <20210319144058.772525-1-dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319144058.772525-1-dja@axtens.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2021 at 01:40:52AM +1100, Daniel Axtens wrote:
> Building on the work of Christophe, Aneesh and Balbir, I've ported
> KASAN to 64-bit Book3S kernels running on the Radix MMU.
> 
> v11 applies to next-20210317. I had hoped to have it apply to
> powerpc/next but once again there are changes in the kasan core that
> clash. Also, thanks to mpe for fixing a build break with KASAN off.
> 
> I'm not sure how best to progress this towards actually being merged
> when it has impacts across subsystems. I'd appreciate any input. Maybe
> the first four patches could go in via the kasan tree, that should
> make things easier for powerpc in a future cycle?
> 
> v10 rebases on top of next-20210125, fixing things up to work on top
> of the latest changes, and fixing some review comments from
> Christophe. I have tested host and guest with 64k pages for this spin.
> 
> There is now only 1 failing KUnit test: kasan_global_oob - gcc puts
> the ASAN init code in a section called '.init_array'. Powerpc64 module
> loading code goes through and _renames_ any section beginning with
> '.init' to begin with '_init' in order to avoid some complexities
> around our 24-bit indirect jumps. This means it renames '.init_array'
> to '_init_array', and the generic module loading code then fails to
> recognise the section as a constructor and thus doesn't run it. This
> hack dates back to 2003 and so I'm not going to try to unpick it in
> this series. (I suspect this may have previously worked if the code
> ended up in .ctors rather than .init_array but I don't keep my old
> binaries around so I have no real way of checking.)
> 
> (The previously failing stack tests are now skipped due to more
> accurate configuration settings.)
> 
> Details from v9: This is a significant reworking of the previous
> versions. Instead of the previous approach which supported inline
> instrumentation, this series provides only outline instrumentation.
> 
> To get around the problem of accessing the shadow region inside code we run
> with translations off (in 'real mode'), we we restrict checking to when
> translations are enabled. This is done via a new hook in the kasan core and
> by excluding larger quantites of arch code from instrumentation. The upside
> is that we no longer require that you be able to specify the amount of
> physically contiguous memory on the system at compile time. Hopefully this
> is a better trade-off. More details in patch 6.
> 
> kexec works. Both 64k and 4k pages work. Running as a KVM host works, but
> nothing in arch/powerpc/kvm is instrumented. It's also potentially a bit
> fragile - if any real mode code paths call out to instrumented code, things
> will go boom.
>

The last time I checked, the changes for real mode, made the code hard to
review/maintain. I am happy to see that we've decided to leave that off
the table for now, reviewing the series

Balbir Singh.
