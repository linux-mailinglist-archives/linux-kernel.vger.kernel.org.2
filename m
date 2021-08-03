Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8038E3DF536
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 21:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239534AbhHCTPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 15:15:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52482 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239520AbhHCTPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 15:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628018102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+rSWKM/T14hSNJ7CCzHqgndf9sQoQa3vUJu76cRGCd4=;
        b=Wo64BMVTJWoSadwuW50QSR6bLo9s6EB+IedqVRQTIbKp9bFHXjdNJ8neB+XN2U2iZLxshO
        jkkHIb+egIiw5rbo0iYcwPNqjnigfR/iBAvb5lp5CrRGGxDS1EivqD9j7pZhzPPDbwBlA/
        CW/EW6T/TL4L2jFr21dhbwDQnhqHSVM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-TsbnLVjgOve7DRQS5U3Jhw-1; Tue, 03 Aug 2021 15:15:00 -0400
X-MC-Unique: TsbnLVjgOve7DRQS5U3Jhw-1
Received: by mail-qk1-f198.google.com with SMTP id w26-20020a05620a129ab02903b9eeb8b45dso222368qki.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 12:15:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+rSWKM/T14hSNJ7CCzHqgndf9sQoQa3vUJu76cRGCd4=;
        b=U0eadOIxbKrD2baU2JbmsVYhr6tnks28TSMHY5xIz++JEyOBS6nqX6+3Cy0PtGBJTQ
         Vr7IFfkNIOFGogkL6MNUKABkvzImEJTngyk41FJhHbo39On+JkLVmphTMmJRtOFuWZK7
         ulK/obCKdxFb/26t/i3sJ1lGicgNION0lqyMCzZtBc39gIQyBpEyM1aBh+aF7ie6X71V
         k07nKfVt8pPNZ+hhHF9D0+83l41ldlNtcWSuOyRieg8xnSoo7u+HZYTCKsqjEs1Q5ncQ
         xZx952etPOFdDbRyqA9/MeaOZvVImb+t+3hIHUglMarA/Y2G+2fRIie3ogc6o5c5nXaZ
         2OuA==
X-Gm-Message-State: AOAM530HHy0uIW312JD/9/6DwRpA13KQYLJF55z8HMrKQVasrr0EbVF7
        3YOKdEti4Vx75cRjC5EkD+AKiQ5p/le30W/4QWkv9A5y9UOjrBBzxOkNV1FjCkTsNNSX/ABE96T
        ozPqOdwRg57jzodudaRwm0d+T
X-Received: by 2002:a37:d8c:: with SMTP id 134mr22409454qkn.433.1628018099293;
        Tue, 03 Aug 2021 12:14:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/g25mwjJPBW3GRsT658xAjK7WfPFxd5+EX8D2glJQaP3nTHkoEEbGh1NCY2uO0kxMEiXzLw==
X-Received: by 2002:a37:d8c:: with SMTP id 134mr22409441qkn.433.1628018099094;
        Tue, 03 Aug 2021 12:14:59 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-92-76-70-75-133.dsl.bell.ca. [76.70.75.133])
        by smtp.gmail.com with ESMTPSA id v6sm8503245qkp.117.2021.08.03.12.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 12:14:58 -0700 (PDT)
Date:   Tue, 3 Aug 2021 15:14:57 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v3 4/7] KVM: X86: Introduce mmu_rmaps_stat per-vm debugfs
 file
Message-ID: <YQmVsSKIPooRQakQ@t490s>
References: <20210730220455.26054-1-peterx@redhat.com>
 <20210730220455.26054-5-peterx@redhat.com>
 <8964c91d-761f-8fd4-e8c6-f85d6e318a45@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8964c91d-761f-8fd4-e8c6-f85d6e318a45@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 05:25:12PM +0200, Paolo Bonzini wrote:
> On 31/07/21 00:04, Peter Xu wrote:
> > Use this file to dump rmap statistic information.  The statistic is done by
> > calculating the rmap count and the result is log-2-based.
> > 
> > An example output of this looks like (idle 6GB guest, right after boot linux):
> > 
> > Rmap_Count:     0       1       2-3     4-7     8-15    16-31   32-63   64-127  128-255 256-511 512-1023
> > Level=4K:       3086676 53045   12330   1272    502     121     76      2       0       0       0
> > Level=2M:       5947    231     0       0       0       0       0       0       0       0       0
> > Level=1G:       32      0       0       0       0       0       0       0       0       0       0
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   arch/x86/kvm/x86.c | 113 +++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 113 insertions(+)
> 
> This should be in debugfs.c, meaning that the kvm_mmu_slot_lpages() must be
> in a header.  I think mmu.h should do, let me take a look and I can post
> myself a v4 of these debugfs parts.

Thanks, Paolo!

-- 
Peter Xu

