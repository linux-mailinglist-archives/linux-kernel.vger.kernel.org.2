Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB03D3C831A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 12:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239167AbhGNKo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 06:44:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34633 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239159AbhGNKoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 06:44:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626259323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dAjFnFSwXhtDku/cti7oeiFEPP5+1wu9i+QNCPxp84k=;
        b=breymNR2Rhdc32e8un2jUIn9RIbaXyGaUb6lEcQu/fDvGBU/xpAgR9pH+K3uyHI6/Vombj
        KTD/IQBLgQzukDwjGYQtRolpy9POPyeB//BCC0JF/Jh+MIjN2ZERfa92UzBOnid4+T+7s7
        fvm1llWOWXznb719EHLm2BNRcfhS30Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-S9pPf_G1NqCw7YpIY1GFYg-1; Wed, 14 Jul 2021 06:42:02 -0400
X-MC-Unique: S9pPf_G1NqCw7YpIY1GFYg-1
Received: by mail-wm1-f69.google.com with SMTP id d16-20020a1c73100000b02901f2d21e46efso617499wmb.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 03:42:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dAjFnFSwXhtDku/cti7oeiFEPP5+1wu9i+QNCPxp84k=;
        b=SiD+5QE1Nc+y9g59fKn3uBMGq2qo0/+sR7Mt7eOU7gx3ZsuJrEXRq0Q3G41970FXM0
         PI2MR7Wzjq9Z6yYX1fpQh90frPggGTk5WpnbJ5r18Nq3u43mkxlFw4IYAGcOlGCksp/D
         T/LW9ipXXHr9OLMqGvO+pHk0XoNqhPumwQXX5fBGrxRzzNI+ngVFLAGAnZmY7RRjqPNs
         yroSe6RNj4sJXlj2YMF4dGB4xAOsA3tP4zXkyQ3S68iOGXXQo6i0fhAMyUBJiKnFciRD
         GYgFkiwKEpBZ+Sgp1X8crbm1eJupm2VcQGtJx2r//FH7yUBsM3oGPMk4wCfOCCLvwP/f
         aCCw==
X-Gm-Message-State: AOAM532b5YpmoHZcjoBF7AjX3vVNlbHZTe2e3Sf7v3bTWfCgqBl6IoVG
        i6CexCfHpHhqcqx6n+yaX5aW0XR3Bp7zTCrQQRDoIKBdeVvTitnBysvgSOvN4StdG47aEPmNtqh
        UPpQnLhXkspO6VnlKgIr2e2oI
X-Received: by 2002:a5d:4527:: with SMTP id j7mr11913716wra.137.1626259321632;
        Wed, 14 Jul 2021 03:42:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwx7Anq0PNI8xFMs/ABWdpoGUMZ6pXRdm6DCKVYAGNUBvv5ibSayqVD+IKdQGUodfnXoe0LFw==
X-Received: by 2002:a5d:4527:: with SMTP id j7mr11913702wra.137.1626259321429;
        Wed, 14 Jul 2021 03:42:01 -0700 (PDT)
Received: from redhat.com ([2.55.15.23])
        by smtp.gmail.com with ESMTPSA id b12sm2171358wro.1.2021.07.14.03.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 03:42:00 -0700 (PDT)
Date:   Wed, 14 Jul 2021 06:41:57 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        He Zhe <zhe.he@windriver.com>
Subject: Re: 5.13-rt1 + KVM = WARNING: at fs/eventfd.c:74 eventfd_signal()
Message-ID: <20210714063814-mutt-send-email-mst@kernel.org>
References: <df278db6-1fc0-3d42-9c0e-f5a085c6351e@redhat.com>
 <8dfc0ee9-b97a-8ca8-d057-31c8cad3f5b6@redhat.com>
 <f0254740-944d-201b-9a66-9db1fe480ca6@redhat.com>
 <475f84e2-78ee-1a24-ef57-b16c1f2651ed@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <475f84e2-78ee-1a24-ef57-b16c1f2651ed@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 12:35:27PM +0200, Paolo Bonzini wrote:
> On 14/07/21 11:23, Jason Wang wrote:
> > > This was added in 2020, so it's unlikely to be the direct cause of the
> > > change.  What is a known-good version for the host?
> > > 
> > > Since it is not KVM stuff, I'm CCing Michael and Jason.
> > 
> > I think this can be probably fixed here:
> > 
> > https://lore.kernel.org/lkml/20210618084412.18257-1-zhe.he@windriver.com/
> 
> That seems wrong; in particular it wouldn't protect against AB/BA deadlocks.
> In fact, the bug is with the locking; the code assumes that
> spin_lock_irqsave/spin_unlock_irqrestore is non-preemptable and therefore
> increments and decrements the percpu variable inside the critical section.
> 
> This obviously does not fly with PREEMPT_RT; the right fix should be
> using a local_lock.  Something like this (untested!!):
> 
> --------------- 8< ---------------
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH] eventfd: protect eventfd_wake_count with a local_lock
> 
> eventfd_signal assumes that spin_lock_irqsave/spin_unlock_irqrestore is
> non-preemptable and therefore increments and decrements the percpu
> variable inside the critical section.
> 
> This obviously does not fly with PREEMPT_RT.  If eventfd_signal is
> preempted and an unrelated thread calls eventfd_signal, the result is
> a spurious WARN.  To avoid this, protect the percpu variable with a
> local_lock.
> 
> Reported-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> Fixes: b5e683d5cab8 ("eventfd: track eventfd_signal() recursion depth")
> Cc: stable@vger.kernel.org
> Cc: He Zhe <zhe.he@windriver.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>


Makes sense ... 

Acked-by: Michael S. Tsirkin <mst@redhat.com>

want to send this to the windriver guys so they can test?
Here's the list from that thread:

To: xieyongji@bytedance.com, mst@redhat.com, jasowang@redhat.com,
	stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
	hch@infradead.org, christian.brauner@canonical.com,
	rdunlap@infradead.org, willy@infradead.org,
	viro@zeniv.linux.org.uk, axboe@kernel.dk, bcrl@kvack.org,
	corbet@lwn.net, mika.penttila@nextfour.com,
	dan.carpenter@oracle.com, gregkh@linuxfoundation.org,
	songmuchun@bytedance.com,
	virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, qiang.zhang@windriver.com,
	zhe.he@windriver.com


> 
> diff --git a/fs/eventfd.c b/fs/eventfd.c
> index e265b6dd4f34..7d27b6e080ea 100644
> --- a/fs/eventfd.c
> +++ b/fs/eventfd.c
> @@ -12,6 +12,7 @@
>  #include <linux/fs.h>
>  #include <linux/sched/signal.h>
>  #include <linux/kernel.h>
> +#include <linux/local_lock.h>
>  #include <linux/slab.h>
>  #include <linux/list.h>
>  #include <linux/spinlock.h>
> @@ -25,6 +26,7 @@
>  #include <linux/idr.h>
>  #include <linux/uio.h>
> +static local_lock_t eventfd_wake_lock = INIT_LOCAL_LOCK(eventfd_wake_lock);
>  DEFINE_PER_CPU(int, eventfd_wake_count);
>  static DEFINE_IDA(eventfd_ida);
> @@ -71,8 +73,11 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n)
>  	 * it returns true, the eventfd_signal() call should be deferred to a
>  	 * safe context.
>  	 */
> -	if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count)))
> +	local_lock(&eventfd_wake_lock);
> +	if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count))) {
> +		local_unlock(&eventfd_wake_lock);
>  		return 0;
> +	}
>  	spin_lock_irqsave(&ctx->wqh.lock, flags);
>  	this_cpu_inc(eventfd_wake_count);
> @@ -83,6 +88,7 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n)
>  		wake_up_locked_poll(&ctx->wqh, EPOLLIN);
>  	this_cpu_dec(eventfd_wake_count);
>  	spin_unlock_irqrestore(&ctx->wqh.lock, flags);
> +	local_unlock(&eventfd_wake_lock);
>  	return n;
>  }

