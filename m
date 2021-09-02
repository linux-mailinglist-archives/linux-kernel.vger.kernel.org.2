Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE4A3FEF82
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 16:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345595AbhIBOga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 10:36:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29217 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345576AbhIBOg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 10:36:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630593329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UXAhxJKeZF3J+7oqF+kPNby+2j1qsB6aw7GpNeUB5QM=;
        b=YHmzDzOVP8fZUk++6rCAUcJOsrlHsgE8XHs9GiokWRQiEULRuwRD4eaRaySs6IhmAaPr9c
        3K/NUgl7N743jZJr4wF9bLkYy3VoFtaneAilv42XWq2xhaeE2588K38iSFvTowox4GPGSn
        vuWoVwZATVMFR0igjrWc5Yhwgsj4OAo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-ZQJnYl1YM8aBjcW6md6gmg-1; Thu, 02 Sep 2021 10:35:28 -0400
X-MC-Unique: ZQJnYl1YM8aBjcW6md6gmg-1
Received: by mail-wr1-f69.google.com with SMTP id h1-20020adffd41000000b0015931e17ccfso606023wrs.18
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 07:35:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UXAhxJKeZF3J+7oqF+kPNby+2j1qsB6aw7GpNeUB5QM=;
        b=RcGJQARbcTM3N2DkPT3B96F1N2pE177QEo+V7IgI7jj2k9fi8zjlB+QDWf3pWSZqKp
         Kfs0kA1rvoauGLhaA2ekYLDBdJDtyTBmKo296JpqBUSd6kyX5UKqkScEMXB0pncPTDoZ
         6dt7lIwTUgbRdpsyNJAJJRLeR1O/TVzzTzZqlGvsDAqMbAsbuI9RVRAKI4x1B032/7oS
         pY9SV2AwpEU1hZ+4wE8FSF95r0n5LeSXKiZz/9kdFV6EB+jA3yVAsVXu2WvuNiClBBdi
         ycAjvFFSyQq5Vlhl9icZkgYOoQ6kWkiMS5pNx4UMEISSkDpzRzRLzaIhSXRsP/3gIh2d
         wvLA==
X-Gm-Message-State: AOAM530DXj4LRThmBRlcBiS8qFuNIXMlfN1xPC3X1Z1nxMC2E+G+6/8x
        Xut1A/Ocz5oy0LJaYahbJrjVkPpMRotTeG7iLhtOGo3bKeDPx6ZxDupzvs7Dpt2WIrkPOS88ixU
        X6UZxjmlYhNLrw1rSYtM/rgc4
X-Received: by 2002:a05:600c:35d6:: with SMTP id r22mr3535280wmq.44.1630593327076;
        Thu, 02 Sep 2021 07:35:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9o3Br43dEQefXp6QdLiHjyMHkpP9VDy99DVBV7/iLzkKW8NQEuihUoh0UpylVyROp15dTRw==
X-Received: by 2002:a05:600c:35d6:: with SMTP id r22mr3535261wmq.44.1630593326922;
        Thu, 02 Sep 2021 07:35:26 -0700 (PDT)
Received: from gator (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id l17sm2107112wrz.35.2021.09.02.07.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 07:35:26 -0700 (PDT)
Date:   Thu, 2 Sep 2021 16:35:24 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Raghavendra Rao Ananta <rananta@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Peter Shier <pshier@google.com>, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 05/12] KVM: arm64: selftests: Add basic support to
 generate delays
Message-ID: <20210902143524.h74zmunzjrtb3o2v@gator>
References: <20210901211412.4171835-1-rananta@google.com>
 <20210901211412.4171835-6-rananta@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901211412.4171835-6-rananta@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 09:14:05PM +0000, Raghavendra Rao Ananta wrote:
> Add udelay() support to generate a delay in the guest.
> 
> The routines are derived and simplified from kernel's
> arch/arm64/lib/delay.c.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> ---
>  .../selftests/kvm/include/aarch64/delay.h     | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/include/aarch64/delay.h
>

Reviewed-by: Andrew Jones <drjones@redhat.com>

