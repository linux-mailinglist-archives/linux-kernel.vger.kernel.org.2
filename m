Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4101F338177
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 00:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhCKX3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 18:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhCKX2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 18:28:49 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC9FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 15:28:49 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id 30so3425726qva.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 15:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZsSTpigG2EoWvSWDLvggAQ39g5J0AwVfYh+qxTHZ8LU=;
        b=IWOEEnWQoNSOrS2PqbGH9PEDsz/QWKgm5I7jMWtbuGawERSQrp1bg6FD4+Y2OIwXWv
         lhFlSM6FGcFFbGyYFuwHQKjIhB4pVNZIP59Yb6NotJT8Wfnh5Aj5AXw3QHD7LFIVeuC8
         D+4y67T5V2yyzsFyj7VqJyyjXjgx/YciTHlTrUQ9ek4mGeyVWUlF1reMf/kd7HcxEjrc
         IozCtDPPSYApjRSHjtSm3M6GWYJ6a3gpmx40MRAuKqzXC2f+AMdl0cEmzX/RDDdPx0Rr
         6oXxr+/go8dW7Dx9lM6AjEGVlwxZlb1dadji1aWpUORogDpU+4gwp8w5hiRo9SVKh7Sk
         2s7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZsSTpigG2EoWvSWDLvggAQ39g5J0AwVfYh+qxTHZ8LU=;
        b=LbLyjntVB2v+zCGxtnMHP2j9Dt2hvmMqPkUdpVHILymTXatHmzRJ0CB9V4XqJhgwyJ
         eDNGkEI4TmnGABLrTaM0qAv+8OOKimTXaR39LTWySm8uYNyYmfMiBuqn6865nSMrf4LI
         sDj4kmZsH01MT3f1Xnv9FK91E3g6nyxXHPAJJwK+Puo63cBeMlaSdHErDc5TWI5W8+vP
         mxOzlrSDP3kyjyXCxEpS8B+m3zZbQyCMUlJXKYNRb5JpYat+dnQyVvGEUnuFRej7PyqN
         mYnRgefss1Tx9nwjZ4PfXlqNYY3OjTBvXsJyIGn5QyZnmFODe15QkV8HL8HE02RQcF7w
         NCGg==
X-Gm-Message-State: AOAM533Do9RDgV3o+F1L35ze6g751yj7g6GD5Rb0g6mKKYGSaAMY3sim
        5DPwq7L0HZODXlI//tq9VNdvUQ==
X-Google-Smtp-Source: ABdhPJzBjsjG7Pl5Zhuv6V4OecqUGWpRQDn0c//JMhL+sHbYjjgsaUY8upg9kadvBAaVvK5/NwWRmQ==
X-Received: by 2002:a05:6214:c8a:: with SMTP id r10mr10077768qvr.13.1615505328343;
        Thu, 11 Mar 2021 15:28:48 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id n136sm3118483qke.123.2021.03.11.15.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 15:28:47 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lKUjX-00BZaI-6h; Thu, 11 Mar 2021 19:28:47 -0400
Date:   Thu, 11 Mar 2021 19:28:47 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Rientjes <rientjes@google.com>,
        Ben Gardon <bgardon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>
Subject: Re: [PATCH v2] mm/mmu_notifiers: Esnure range_end() is paired with
 range_start()
Message-ID: <20210311232847.GA2710221@ziepe.ca>
References: <20210311180057.1582638-1-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210311180057.1582638-1-seanjc@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 10:00:57AM -0800, Sean Christopherson wrote:
> If one or more notifiers fails .invalidate_range_start(), invoke
> .invalidate_range_end() for "all" notifiers.  If there are multiple
> notifiers, those that did not fail are expecting _start() and _end() to
> be paired, e.g. KVM's mmu_notifier_count would become imbalanced.
> Disallow notifiers that can fail _start() from implementing _end() so
> that it's unnecessary to either track which notifiers rejected _start(),
> or had already succeeded prior to a failed _start().
> 
> Note, the existing behavior of calling _start() on all notifiers even
> after a previous notifier failed _start() was an unintented "feature".
> Make it canon now that the behavior is depended on for correctness.
> 
> As of today, the bug is likely benign:
> 
>   1. The only caller of the non-blocking notifier is OOM kill.
>   2. The only notifiers that can fail _start() are the i915 and Nouveau
>      drivers.
>   3. The only notifiers that utilize _end() are the SGI UV GRU driver
>      and KVM.
>   4. The GRU driver will never coincide with the i195/Nouveau drivers.
>   5. An imbalanced kvm->mmu_notifier_count only causes soft lockup in the
>      _guest_, and the guest is already doomed due to being an OOM victim.
> 
> Fix the bug now to play nice with future usage, e.g. KVM has a potential
> use case for blocking memslot updates in KVM while an invalidation is
> in-progress, and failure to unblock would result in said updates being
> blocked indefinitely and hanging.
> 
> Found by inspection.  Verified by adding a second notifier in KVM that
> periodically returns -EAGAIN on non-blockable ranges, triggering OOM,
> and observing that KVM exits with an elevated notifier count.
> 
> Fixes: 93065ac753e4 ("mm, oom: distinguish blockable mode for mmu notifiers")
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: stable@vger.kernel.org
> Cc: David Rientjes <rientjes@google.com>
> Cc: Ben Gardon <bgardon@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> 
> v2: Reimplemented as suggested by Jason.  Only functional change relative
>     to Jason's suggestion is to check invalidate_range_end before calling to
>     avoid a NULL pointer dereference.  I also added more comments, hopefully
>     they're helpful...
> 
> v1: https://lkml.kernel.org/r/20210310213117.1444147-1-seanjc@google.com

Looks fine, thanks. I think you need some commit message remark to
discourage backporting, the added WARN_ON will trigger on older
kernels that have many more things implementing
invalidate_range_end(). It should not be backported to anything that
has more invalidate_range_ends()'s than today's kernel.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
