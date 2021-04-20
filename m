Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74CD36598B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 15:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbhDTNLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 09:11:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44979 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232034AbhDTNLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 09:11:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618924246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+zx2XFbE8gJYftGDtRd3mjOOLbDR+Xz7bpzucbSm34A=;
        b=ToRRhDD+r646bgFZ9jp8+MrncnZ2QcJqCls0nlVDGGyJ0d5Eip4kB7Zi6lsfyfR/4UxHjB
        wLO73ah9WiSmlcNX9YZZDaKEyfZNnuyBuo0hI/cvmDtM4OOlRjJeSxYOG3hsW7MTWT2kpH
        XSO/t2JW9B61uugSZBF4f41D1hOTdlY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-1360d6ZDPhik0nslwN8l7w-1; Tue, 20 Apr 2021 09:10:44 -0400
X-MC-Unique: 1360d6ZDPhik0nslwN8l7w-1
Received: by mail-qt1-f199.google.com with SMTP id i7-20020ac84f470000b02901b944d49e13so3241572qtw.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 06:10:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+zx2XFbE8gJYftGDtRd3mjOOLbDR+Xz7bpzucbSm34A=;
        b=VSP0AQl/XO4p4CSrghlWJ6hjwlmjGysJUiCIrP2hibO8XIXzg557hr7uy2rsK5vr4i
         2TGfDnr4jnEr+I4jt+rijfxsIXyBtaJz5Fvx7gcoI+vTRUWlU2zB4KZJ7u62BJMi9UK2
         39luBkzxkflNTRuYUlE/k5Xqj0bWty3vv5OKbGMvVWpxxuBxK4CYoERiKHc1xCxk7p6j
         oPwxfVqr/2HgchKJZgxRQ6V7qjs5cVgQp3eKeJ8e36g9QQyQ4AXEwPl+oSn0s1RdCHK4
         gvF76c+9SNdQT5Pem8L0d59SSSmKOH7jXR9ObyRHHbO4mXiKD3/PW7C+UQS5u8MakTCu
         I9pw==
X-Gm-Message-State: AOAM531Jra95QouVQXDCyjfJPu7DFr9gWPiT/pl/y9BkvoYlG7uNEW2z
        f0JgijDUSidHRjHLUKXk3qyMW2vgHAihGroVl7Gt4Zoe22BWLny5nbu1OhAhlc2Ew/B1hjt9s5E
        lpm86Ox2eIZfcd5OGmHnkNygG
X-Received: by 2002:a05:620a:24c6:: with SMTP id m6mr1867258qkn.11.1618924243926;
        Tue, 20 Apr 2021 06:10:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzeZ3xms+6PUbLdDTIPvaRzwj3NltarpvZMNVXG53FHuHheOUZSJ4pKUFysVDt4A0p2PVsHWA==
X-Received: by 2002:a05:620a:24c6:: with SMTP id m6mr1867217qkn.11.1618924243608;
        Tue, 20 Apr 2021 06:10:43 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-88-174-93-75-154.dsl.bell.ca. [174.93.75.154])
        by smtp.gmail.com with ESMTPSA id d4sm163480qtp.23.2021.04.20.06.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 06:10:42 -0700 (PDT)
Date:   Tue, 20 Apr 2021 09:10:41 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Andrew Jones <drjones@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH v3 1/2] KVM: selftests: Sync data verify of dirty logging
 with guest sync
Message-ID: <20210420131041.GZ4440@xz-x1>
References: <20210417143602.215059-1-peterx@redhat.com>
 <20210417143602.215059-2-peterx@redhat.com>
 <20210418124351.GW4440@xz-x1>
 <60b0c96c-161d-676d-c30a-a7ffeccab417@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60b0c96c-161d-676d-c30a-a7ffeccab417@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 10:07:16AM +0200, Paolo Bonzini wrote:
> On 18/04/21 14:43, Peter Xu wrote:
> > ----8<-----
> > diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
> > index 25230e799bc4..d3050d1c2cd0 100644
> > --- a/tools/testing/selftests/kvm/dirty_log_test.c
> > +++ b/tools/testing/selftests/kvm/dirty_log_test.c
> > @@ -377,7 +377,7 @@ static void dirty_ring_after_vcpu_run(struct kvm_vm *vm, int ret, int err)
> >          /* A ucall-sync or ring-full event is allowed */
> >          if (get_ucall(vm, VCPU_ID, NULL) == UCALL_SYNC) {
> >                  /* We should allow this to continue */
> > -               ;
> > +               vcpu_handle_sync_stop();
> >          } else if (run->exit_reason == KVM_EXIT_DIRTY_RING_FULL ||
> >                     (ret == -1 && err == EINTR)) {
> >                  /* Update the flag first before pause */
> > ----8<-----
> > 
> > That's my intention when I introduce vcpu_handle_sync_stop(), but forgot to
> > add...
> 
> And possibly even this (untested though):
> 
> diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
> index ffa4e2791926..918954f01cef 100644
> --- a/tools/testing/selftests/kvm/dirty_log_test.c
> +++ b/tools/testing/selftests/kvm/dirty_log_test.c
> @@ -383,6 +383,7 @@ static void dirty_ring_after_vcpu_run(struct kvm_vm *vm, int ret, int err)
>  		/* Update the flag first before pause */
>  		WRITE_ONCE(dirty_ring_vcpu_ring_full,
>  			   run->exit_reason == KVM_EXIT_DIRTY_RING_FULL);
> +		atomic_set(&vcpu_sync_stop_requested, false);
>  		sem_post(&sem_vcpu_stop);
>  		pr_info("vcpu stops because %s...\n",
>  			dirty_ring_vcpu_ring_full ?
> @@ -804,8 +805,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>  		 * the flush of the last page, and since we handle the last
>  		 * page specially verification will succeed anyway.
>  		 */
> -		assert(host_log_mode == LOG_MODE_DIRTY_RING ||
> -		       atomic_read(&vcpu_sync_stop_requested) == false);
> +		assert(atomic_read(&vcpu_sync_stop_requested) == false);
>  		vm_dirty_log_verify(mode, bmap);
>  		sem_post(&sem_vcpu_cont);
> 
> You can submit all these as a separate patch.

But it could race, then?

        main thread                 vcpu thread
        -----------                 -----------
                                  ring full
                                    vcpu_sync_stop_requested=0
                                    sem_post(&sem_vcpu_stop)
     vcpu_sync_stop_requested=1
     sem_wait(&sem_vcpu_stop)
     assert(vcpu_sync_stop_requested==0)   <----

Thanks,

-- 
Peter Xu

