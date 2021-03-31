Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0BEF3507FB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 22:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236450AbhCaUQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 16:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236412AbhCaUQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 16:16:05 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C98C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 13:16:04 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id h25so112666pgm.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 13:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jlWSSoi6sy6UHWMT+v1PaZmsAgCmFgO2q1+KR74XicI=;
        b=CQY8x+TvnMDSfSmiD2oXUHMuQLXZ38oXtxiRbVY/bMFC5iyRXRtUNJEI/nL8QGZJO3
         uCZeJr/LCn8UE+xniYVb/4u0+jxWUWA+q7hUvk92LCcFLkS/fJqFt+tNz2QcklwQQaWn
         HvmjLhB61wZx5a5mvaQtupa2/vEyFX9Vua2CFTe6XDyB1KEIrw7j4MAG1vVvIOYtt7P3
         pHQharrI6lixPIKmzhnGtbgX+luBHbesS+HGqteLdSBUx8hGONbonRnToFN5Hs5EJ77K
         vKUbLwvu9gSWWmSpGD7GsVEqiFtnjRQ/qBYqBI2cKy6097T2AypJtX31JiYLExgQSWnk
         FlJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jlWSSoi6sy6UHWMT+v1PaZmsAgCmFgO2q1+KR74XicI=;
        b=hZON3dty0sa7YJ/C8iRRK3ytPdw5tEaujY5tqTa6AerYgL1WaKAJLhNsVHEtZ0SWv2
         WGVX81V6gM/T9vU3gwERUIbZdodQ4EzXkNI4OK9xrZDfmGHaxKemxMxMk+jVPMOLapcO
         B7peyuJom0MUNoewYYtO4JhcfmHqveomKMyq2x1EeZgb5pwJnUnaStBIIY9MAmdzhRLA
         Xy0IkBG00sUEPfwmUeWX69fkOopzw5rH6MphDnelRS1hiNNpIFgcrnH44BEclYq48Lfh
         jPvkIt5liQObQmnQ+PpmS0UsCMCW222DuW/J6fSguuekKuG2dklPKZ8Cl1YCNw6TENML
         IXzw==
X-Gm-Message-State: AOAM5324sqkZEHDrN3pV56DYN1LWmHXxq69+9pCfe4vOwTA+jG1vqYHW
        3CcihggclKYtoCHeVS5P7e8YPw==
X-Google-Smtp-Source: ABdhPJyQTtvfP4m42vBD0iJXhxNzS92c8e0qkUYdFgjeJAzyVz49/jbMuCy/LNbWI3efb+yjNskWQQ==
X-Received: by 2002:a63:2ec7:: with SMTP id u190mr4731324pgu.18.1617221764095;
        Wed, 31 Mar 2021 13:16:04 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id 144sm3196471pfy.75.2021.03.31.13.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 13:16:03 -0700 (PDT)
Date:   Wed, 31 Mar 2021 20:15:59 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Marc Zyngier <maz@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Gardon <bgardon@google.com>
Subject: Re: [PATCH 16/18] KVM: Don't take mmu_lock for range invalidation
 unless necessary
Message-ID: <YGTYf9sWVIJqqswq@google.com>
References: <20210326021957.1424875-1-seanjc@google.com>
 <20210326021957.1424875-17-seanjc@google.com>
 <6e7dc7d0-f5dc-85d9-1c50-d23b761b5ff3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e7dc7d0-f5dc-85d9-1c50-d23b761b5ff3@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021, Paolo Bonzini wrote:
> On 26/03/21 03:19, Sean Christopherson wrote:
> > +	/*
> > +	 * Reset the lock used to prevent memslot updates between MMU notifier
> > +	 * range_start and range_end.  At this point no more MMU notifiers will
> > +	 * run, but the lock could still be held if KVM's notifier was removed
> > +	 * between range_start and range_end.  No threads can be waiting on the
> > +	 * lock as the last reference on KVM has been dropped.  If the lock is
> > +	 * still held, freeing memslots will deadlock.
> > +	 */
> > +	init_rwsem(&kvm->mmu_notifier_slots_lock);
> 
> I was going to say that this is nasty, then I noticed that
> mmu_notifier_unregister uses SRCU to ensure completion of concurrent calls
> to the MMU notifier.  So I guess it's fine, but it's better to point it out:
> 
> 	/*
> 	 * At this point no more MMU notifiers will run and pending
> 	 * calls to range_start have completed, but the lock would
> 	 * still be held and never released if the MMU notifier was
> 	 * removed between range_start and range_end.  Since the last
> 	 * reference to the struct kvm has been dropped, no threads can
> 	 * be waiting on the lock, but we might still end up taking it
> 	 * when freeing memslots in kvm_arch_destroy_vm.  Reset the lock
> 	 * to avoid deadlocks.
> 	 */

An alternative would be to not take the lock in install_new_memslots() if
kvm->users_count == 0.  It'd be weirder to document, and the conditional locking
would still be quite ugly.  Not sure if that's better than blasting a lock
during destruction?
