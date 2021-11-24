Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C459F45B7B7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 10:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbhKXJs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 04:48:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22801 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229633AbhKXJs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 04:48:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637747148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/ocPRPURvuCP4fzE5T0eVQSQIxy0gRmJcpuXxwEQtHM=;
        b=UqQJ2Z6JnRTP7Gw0KZ6sMAFwJKwHJhOf0Dxfk2JwPXEKawIU9Im1PuqqG/oCgDaCUqAPvt
        AoeRuICMZ5ovjYpy+0CMP09ohaCJsDdUmnXwqdemqw99rbX+MfP154poeFVqoeOQP7bLs+
        ayWoaolUuSl0GF/xC3axPA0BKd0S3ds=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-QnpHVsvrM-GM6BS9DeQccg-1; Wed, 24 Nov 2021 04:45:46 -0500
X-MC-Unique: QnpHVsvrM-GM6BS9DeQccg-1
Received: by mail-wm1-f69.google.com with SMTP id 145-20020a1c0197000000b0032efc3eb9bcso2731023wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 01:45:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=/ocPRPURvuCP4fzE5T0eVQSQIxy0gRmJcpuXxwEQtHM=;
        b=mr1HgmdKImpAC5UZuLISldXovOsgD0Vo/9A6UqSRfH0r63DwXiEchiswGYe9/uWunP
         eBT/wFDU00uzg/Yi51bmH9zvd6v+GI1YdUHw5fA7h2xZtar43+Ptz7N/aAwkA2xTTd65
         ogNQRt5GWTYVYc3J5tKwBA6+gk+LqCtbHGXD/Un23jMyexKzgrbOWCdF9LobvkzjedI7
         D+PQxugnyS6zYVI7WbYDxz0f9PqE8epbj1qJobX+XSqAEWWqBrpDXoluLbS4kP4KvCQx
         +y/zZWcTgizy2gKa6KIKJ96huQHXub8Z7I8zAGqbzHsp5hprjOrTXwsjYWoIZPP8kE3I
         stYw==
X-Gm-Message-State: AOAM530I47Zsw2gC/RqJ6bPhWRXNqauldT84MfLVZP1ZcRWmE/kInm3S
        X4bCa6Msskdp0D3akn+GxLmW7WgFXaghsa7ehXpiwXmIbEUALQM1K7IlsTQEEMa/KeE8upageMz
        LUOX7sb0CFCMFUzBwYx3CqmL3
X-Received: by 2002:a5d:58f9:: with SMTP id f25mr17470498wrd.206.1637747145589;
        Wed, 24 Nov 2021 01:45:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwP0zHgPBVMJ6rnPoEJ8gNRRURG0BefwNCQkWdV/Pp5YgDYW6ukSyMMP2OQX0rFvd7bFyHeUw==
X-Received: by 2002:a5d:58f9:: with SMTP id f25mr17470474wrd.206.1637747145442;
        Wed, 24 Nov 2021 01:45:45 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:3c10:3400:3c70:6643:6e71:7eae? ([2a0c:5a80:3c10:3400:3c70:6643:6e71:7eae])
        by smtp.gmail.com with ESMTPSA id a10sm4350726wmq.27.2021.11.24.01.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 01:45:45 -0800 (PST)
Message-ID: <482c55bc52b17c4ddf113a75acaca73a0c0a7b9b.camel@redhat.com>
Subject: Re: [RFC PATCH 1/2] arm64/tracing: add cntvct based trace clock
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        mingo@redhat.com, mtosatti@redhat.com, nilal@redhat.com,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>
Date:   Wed, 24 Nov 2021 10:45:44 +0100
In-Reply-To: <20211122095735.2340f38f@gandalf.local.home>
References: <20211119102117.22304-1-nsaenzju@redhat.com>
         <20211119102117.22304-2-nsaenzju@redhat.com>
         <20211122095735.2340f38f@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-11-22 at 09:57 -0500, Steven Rostedt wrote:
> On Fri, 19 Nov 2021 11:21:17 +0100
> Nicolas Saenz Julienne <nsaenzju@redhat.com> wrote:
> 
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _ASM_ARM64_TRACE_CLOCK_H
> > +#define _ASM_ARM64_TRACE_CLOCK_H
> > +
> > +#include <linux/types.h>
> > +
> > +extern u64 notrace trace_clock_arm64_cntvct(void);
> > +
> > +# define ARCH_TRACE_CLOCKS \
> > +	{ trace_clock_arm64_cntvct, "cntvct", .in_ns = 0 },
> > +
> > +#endif  /* _ASM_ARM64_TRACE_CLOCK_H */
> 
> So this will appear as a usable clock in trace-cmd.
> 
> And since this will be used to synchronize between host and guest like the
> x86_tsc is used, that means that trace-cmd needs to know that this is the
> an arch "CPU" clock. I wonder if we should rename x86_clock (or at least
> make it an alias) to "kvm_clock". Then we can have trace-cmd use
> "kvm_clock" as the clock for synchronization between host and guests for
> all architectures?
>
> Thinking about this, instead of renaming it, I'll add code to create an
> alias to these clocks. Then every arch can pick what clock is used that is
> the same between hosts and guests such that user space tooling doesn't have
> to keep a database of what clocks are used for synchronization between
> hosts and guests for each arch.
> 
> I'll go add some code ;-)

I really like the idea, please keep me in the loop if you send something
upstream.

-- 
Nicolás Sáenz

