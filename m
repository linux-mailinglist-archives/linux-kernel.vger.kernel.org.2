Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB0A456F30
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 14:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbhKSNC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 08:02:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50523 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230373AbhKSNC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 08:02:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637326796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nGjEoGfSIB/BQ0tfbin1wzwYv7vDPPU6oTjvPfD/ErE=;
        b=boKwOoqTkFC7eSGpu0pDYSrR2wiDw6yFzFf+aaHmJfSHTEDgCZ1CXw+xXkVM/9VQL3SkYY
        gURl3ZJIj8p+/hCD9CoU8X2MV7T/c9ZePvjQw+wIrrdcHyA9VAMfe8a7mKm+k+NKWWAT4r
        XhXNjiQEYiSxGhl/beoYBRfLoh8AzJs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-450-LpzY-ur4PS6QJz9b_MnkeA-1; Fri, 19 Nov 2021 07:59:53 -0500
X-MC-Unique: LpzY-ur4PS6QJz9b_MnkeA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8239E744;
        Fri, 19 Nov 2021 12:59:51 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6CEC6196E5;
        Fri, 19 Nov 2021 12:59:50 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 585934172ED4; Fri, 19 Nov 2021 09:59:46 -0300 (-03)
Date:   Fri, 19 Nov 2021 09:59:46 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        linux-arm-kernel@lists.infradead.org, rostedt@goodmis.org,
        james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        mingo@redhat.com, nilal@redhat.com
Subject: Re: [RFC PATCH 2/2] KVM: arm64: export cntvoff in debugfs
Message-ID: <20211119125946.GA57544@fuller.cnet>
References: <20211119102117.22304-1-nsaenzju@redhat.com>
 <20211119102117.22304-3-nsaenzju@redhat.com>
 <87fsrs732b.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fsrs732b.wl-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 12:17:00PM +0000, Marc Zyngier wrote:
> On Fri, 19 Nov 2021 10:21:18 +0000,
> Nicolas Saenz Julienne <nsaenzju@redhat.com> wrote:
> > 
> > While using cntvct as the raw clock for tracing, it's possible to
> > synchronize host/guest traces just by knowing the virtual offset applied
> > to the guest's virtual counter.
> > 
> > This is also the case on x86 when TSC is available. The offset is
> > exposed in debugfs as 'tsc-offset' on a per vcpu basis. So let's
> > implement the same for arm64.
> 
> How does this work with NV, where the guest hypervisor is in control
> of the virtual offset? How does userspace knows which vcpu to pick so
> that it gets the right offset?

On x86, the offsets for different vcpus are the same due to the logic at
kvm_synchronize_tsc function:

During guest vcpu creation, when the TSC-clock values are written
in a short window of time (or the clock value is zero), the code uses
the same TSC.

This logic is problematic (since "short window of time" is a heuristic 
which can fail), and is being replaced by writing the same offset
for each vCPU:

commit 828ca89628bfcb1b8f27535025f69dd00eb55207
Author: Oliver Upton <oupton@google.com>
Date:   Thu Sep 16 18:15:38 2021 +0000

    KVM: x86: Expose TSC offset controls to userspace
    
    To date, VMM-directed TSC synchronization and migration has been a bit
    messy. KVM has some baked-in heuristics around TSC writes to infer if
    the VMM is attempting to synchronize. This is problematic, as it depends
    on host userspace writing to the guest's TSC within 1 second of the last
    write.
    
    A much cleaner approach to configuring the guest's views of the TSC is to
    simply migrate the TSC offset for every vCPU. Offsets are idempotent,
    and thus not subject to change depending on when the VMM actually
    reads/writes values from/to KVM. The VMM can then read the TSC once with
    KVM_GET_CLOCK to capture a (realtime, host_tsc) pair at the instant when
    the guest is paused.

So with that in place, the answer to 

How does userspace knows which vcpu to pick so
that it gets the right offset?

is any vcpu, since the offsets are the same.

> I also wonder why we need this when userspace already has direct
> access to that information without any extra kernel support (read the
> CNTVCT view of the vcpu using the ONEREG API, subtract it from the
> host view of the counter, job done).

If guest has access to the clock offset (between guest and host), then
in the guest:

	clockval = hostclockval - clockoffset

Adding "clockoffset" to that will retrieve the host clock.

Is that what you mean?

