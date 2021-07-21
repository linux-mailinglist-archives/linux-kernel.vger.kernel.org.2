Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2878F3D1958
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 23:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhGUVCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 17:02:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43218 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229561AbhGUVCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 17:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626903769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EgnuYo/9YupwfYuRzS/3EAJrECOCz9JZzyHEzGBP/Do=;
        b=Os4Pq/yX6SU5pRGKAMrzEK4C3EBkYn67OLfEn/OfeJulgBJNUhB+lmvI2TkQDAuynv/o86
        t9ZrKcOd8g4BOra2wSVLoYIFnmew2PQin7Ea8owRcjeQLuNZBJ5baL527Z6frHNv37y704
        3oZN3c59TNyNGGXySrJDMnumcTsVUTY=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-bNXfJSR3NPyBr8MkF_sSJg-1; Wed, 21 Jul 2021 17:42:47 -0400
X-MC-Unique: bNXfJSR3NPyBr8MkF_sSJg-1
Received: by mail-il1-f198.google.com with SMTP id b8-20020a92c8480000b0290208fe58bd16so2359433ilq.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 14:42:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EgnuYo/9YupwfYuRzS/3EAJrECOCz9JZzyHEzGBP/Do=;
        b=ExQmIxUWF/q18H+jHTqYLoPAySCgMqx5eYlX2mpLCtxk0+JNDhirdSei+oPEuIVkSj
         DyWXIStaWqBOlUIy1YSeSZOHe54v5GD7HGpwPHj1XMSKmsUvAGJ87rPa71AeVAMitCeI
         0q05zXSYwyXJ3bTAj+AKdv8wL8xHPnoQDH9LTXXx0/H7TKlwL+pVmrTo4r94b+9EHfVY
         RiXz3mVdLw1AdtZxQzrikNHOm4UhQ6NSq943FabjNFju9kdyGI5BEkvB+Rtv35Q3MNcN
         DsDvtegY97ZH00PhzzPZiYB5UsUHhILFgJFdlDyQ7xd40EwYeup5NYZSI1XOqDazjeJC
         HEnw==
X-Gm-Message-State: AOAM531fUAe+PI+BQaNx9M+6sCSwjvmufi+aD+qBVmDgCmQyq/xR/JyJ
        lJDkWLdZRyWcpSyeIcMLEnmKy+bqs/M7gNRFVWxFWThMgkmJlh7AFnKyfxhRyviVsFebhVRhCNJ
        kKZRSjLcBLlWN+9Sngr46P9sz
X-Received: by 2002:a92:cb06:: with SMTP id s6mr26042738ilo.87.1626903767248;
        Wed, 21 Jul 2021 14:42:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7rBCtquDD6lbxgOm4tFTVO+wR+CyYZ/EAkJBC/eHDwdFdEua1cvqGXWw7KmnzajQrtWPbOw==
X-Received: by 2002:a92:cb06:: with SMTP id s6mr26042710ilo.87.1626903766552;
        Wed, 21 Jul 2021 14:42:46 -0700 (PDT)
Received: from gator ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id h13sm12599982ila.44.2021.07.21.14.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 14:42:45 -0700 (PDT)
Date:   Wed, 21 Jul 2021 23:42:43 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Srivatsa Vaddagiri <vatsa@codeaurora.org>,
        Shanker R Donthineni <sdonthineni@nvidia.com>,
        will@kernel.org
Subject: Re: [PATCH 00/16] KVM: arm64: MMIO guard PV services
Message-ID: <20210721214243.dy6d644yznuopuqx@gator>
References: <20210715163159.1480168-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715163159.1480168-1-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 05:31:43PM +0100, Marc Zyngier wrote:
> KVM/arm64 currently considers that any memory access outside of a
> memslot is a MMIO access. This so far has served us very well, but
> obviously relies on the guest trusting the host, and especially
> userspace to do the right thing.
> 
> As we keep on hacking away at pKVM, it becomes obvious that this trust
> model is not really fit for a confidential computing environment, and
> that the guest would require some guarantees that emulation only
> occurs on portions of the address space that have clearly been
> identified for this purpose.

This trust model is hard for me to reason about. userspace is trusted to
control the life cycle of the VM, to prepare the memslots for the VM,
and [presumably] identify what MMIO ranges are valid, yet it's not
trusted to handle invalid MMIO accesses. I'd like to learn more about
this model and the userspace involved.

> 
> This series aims at providing the two sides of the above coin:
> 
> - a set of PV services (collectively called 'MMIO guard' -- better
>   name required!) where the guest can flag portion of its address
>   space that it considers as MMIO, with map/unmap semantics. Any
>   attempt to access a MMIO range outside of these regions will result
>   in an external abort being injected.
> 
> - a set of hooks into the ioremap code allowing a Linux guest to tell
>   KVM about things it want to consider as MMIO. I definitely hate this
>   part of the series, as it feels clumsy and brittle.
> 
> For now, the enrolment in this scheme is controlled by a guest kernel
> command-line parameters, but it is expected that KVM will enforce this
> for protected VMs.
> 
> Note that this crucially misses a save/restore interface for non
> protected VMs, and I currently don't have a good solution for
> that. Ideas welcome.
> 
> I also plan to use this series as a base for some other purposes,
> namely to trick the guest in telling us how it maps things like
> prefetchable BARs (see the discussion at [1]). That part is not
> implemented yet, but there is already some provision to pass the MAIR
> index across.
> 
> Patches on top of 5.14-rc1, branch pushed at the usual location.
> 
> [1] 20210429162906.32742-1-sdonthineni@nvidia.com

The fun never stops.

Thanks,
drew

