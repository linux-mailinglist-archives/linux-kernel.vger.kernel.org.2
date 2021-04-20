Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C96365E02
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 18:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbhDTQ7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 12:59:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31318 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233288AbhDTQ7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 12:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618937922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T7OnI4g7y/j0j8gjLvALAW+SBNaqStqVNvhZwF+q8fQ=;
        b=X9dfAbFpw8hFy5Qw7bKTXT2gydl120EpLpRmNtaEKnojhqWog4KJvo84qMu39mWlppYOSU
        bPBxnSMlwr+z5AZrpZy0QPXZVKcGSOzlLaWdpd5xj1qm6iiksX9Z3PaLbK5TPAcDR4vun8
        4xs9nWMUM5r56o2MiWiG4B9uNjxStm8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-9ggozBhEOzWEwU0HE3ZJrg-1; Tue, 20 Apr 2021 12:58:37 -0400
X-MC-Unique: 9ggozBhEOzWEwU0HE3ZJrg-1
Received: by mail-qt1-f200.google.com with SMTP id s4-20020ac85cc40000b02901b59d9c0986so8689619qta.19
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 09:58:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T7OnI4g7y/j0j8gjLvALAW+SBNaqStqVNvhZwF+q8fQ=;
        b=isiNNyrg4LnPZUo/GlAEwF5cTnaoI/sf2gaMyEnqca0qqp1xF6tt+tPTyjZp+RjmqB
         H6RLQBrlekQHKaG3clxXSg7dvPnjgWAo6G3S0SYlK4p9faA34RKYe6+PJDRasEP4OfKf
         l7yoo7SCi9BDWiypfhF+vO08Dt7UftnxSNn7s0EGx6LB337aIENr+P8pA8HVzIoIaN4j
         2dU5pe9pgfNLG2hMALZHW+v34Sa4Sz1iOQM2+yeYP6Ffgxf0tcFN5dFzLseOEproV9ba
         PoITRoVag3XG9YbWR5ahQKATbkKWczAs+zpk+pkpe6CwqITiFeFRK3BBgPySQ2dcu+0o
         Z7Mw==
X-Gm-Message-State: AOAM530i2/fgs8zVSkc671HcCIhvg2P1rhZREaqjt9BXS38/u1aGNMIQ
        njgRMCeYOaVdJw0yhqlMroInTHsu25PhJgPaxqF0I3A47bZAZerueUsS7fpUkXbQD/dMj3jJQJb
        V3uZSXbeeKOQCgyloZ1Kobg7C
X-Received: by 2002:a0c:f546:: with SMTP id p6mr2800294qvm.6.1618937917006;
        Tue, 20 Apr 2021 09:58:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4vGLU180G23sXR7ipr4r0p+fP/T/k9RjNGzudGX4h5CRoFZSDKgPckbD3RgJpc83I6Xw8fQ==
X-Received: by 2002:a0c:f546:: with SMTP id p6mr2800271qvm.6.1618937916731;
        Tue, 20 Apr 2021 09:58:36 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-88-174-93-75-154.dsl.bell.ca. [174.93.75.154])
        by smtp.gmail.com with ESMTPSA id b4sm12604291qkf.64.2021.04.20.09.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 09:58:36 -0700 (PDT)
Date:   Tue, 20 Apr 2021 12:58:34 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: Always run vCPU thread with blocked
 SIG_IPI
Message-ID: <20210420165834.GC4440@xz-x1>
References: <20210420081614.684787-1-pbonzini@redhat.com>
 <20210420143739.GA4440@xz-x1>
 <20210420153223.GB4440@xz-x1>
 <84c52ebe-58a2-6188-270e-c86409e44fa3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <84c52ebe-58a2-6188-270e-c86409e44fa3@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 06:24:50PM +0200, Paolo Bonzini wrote:
> On 20/04/21 17:32, Peter Xu wrote:
> > On Tue, Apr 20, 2021 at 10:37:39AM -0400, Peter Xu wrote:
> > > On Tue, Apr 20, 2021 at 04:16:14AM -0400, Paolo Bonzini wrote:
> > > > The main thread could start to send SIG_IPI at any time, even before signal
> > > > blocked on vcpu thread.  Therefore, start the vcpu thread with the signal
> > > > blocked.
> > > > 
> > > > Without this patch, on very busy cores the dirty_log_test could fail directly
> > > > on receiving a SIGUSR1 without a handler (when vcpu runs far slower than main).
> > > > 
> > > > Reported-by: Peter Xu <peterx@redhat.com>
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > > 
> > > Yes, indeed better! :)
> > > 
> > > Reviewed-by: Peter Xu <peterx@redhat.com>
> > 
> > I just remembered one thing: this will avoid program quits, but still we'll get
> > the signal missing.
> 
> In what sense the signal will be missing?  As long as the thread exists, the
> signal will be accepted (but not delivered because it is blocked); it will
> then be delivered on the first KVM_RUN.

Ah right..  Thanks,

-- 
Peter Xu

