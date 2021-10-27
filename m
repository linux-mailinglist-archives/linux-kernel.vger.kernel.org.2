Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55BBD43CD8E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 17:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242784AbhJ0PdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 11:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242770AbhJ0PdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 11:33:05 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF20EC061745
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 08:30:39 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id t184so3114363pfd.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 08:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8HVWDdXXt0AD/xSFizk+AYjOVZmIDbS9XwzvKXYRSt8=;
        b=OEfG9fsgSPXFsuD00eYA/4hb/4nOJhqt3Fa3DsCVNZsfitbSN/e7Fn81m4qSyNF6U/
         mhh/R9TUBiF7pjmngLNdEADzgfxtm/aVHY0H9J+z6ozxZ49ZZu8j36ZA8vNS+jc3P4K8
         39l9ZJZa9RV8xzTd4Pq6XBto9wKnNJruu9xTNPgxAnhf+lq+LyLyNX9Nl8mvXteW2N67
         +TcMWmCTLvtk136TTAc8/TraiE87+QKjoC7eTJ2OAuWqRKMp2hqkYHzHc/UrtgHJUjNB
         S90jgPj6NxctTlEeFg16F+/ojMD4VkEXJciV+yM/BHrhD9Juzesc0Jpe/IsL5krJCSuw
         Hz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8HVWDdXXt0AD/xSFizk+AYjOVZmIDbS9XwzvKXYRSt8=;
        b=7cH1xJtRnx2UfgvESJIv8+wfUj6L7YGUuAn2j6axcuh6hWrAgfBpIqXFNBwGbwXurx
         po6DWWVdR+Uzinb9OdkS331LDxDS0pjh9ds1LtZZ8zuaXnck+XWoJbtGOA+HnI9VuvHq
         SzNau6vE7vkvOh5vkX59yP7B/qWuuVEEtPqV6WciEwNnRZWGYKEqAnej0LN9SWd7hKV0
         EhcG44BDbgtwNIOivyokGhD7nctyklMW2n5ZM/kgoOs7WqgHP9utxpB1grILYYkl2+3b
         byVYoN/tQjAVexsOYQ6KT9L4VoH68QKS2zeS45XRwM5GPlzLeAWr5j5q85o7yzbH+6cH
         3C9Q==
X-Gm-Message-State: AOAM531J92rVrG6Re+fib4qyGUk7CW0RhTPVvk3WC6NEcxULKrVtAiCL
        uStNSS903IdDxn5hHVJbQTvEvg==
X-Google-Smtp-Source: ABdhPJxZ0e6i7j4AtLY0aYMSXG5aUrKCFCUTxCqVHzekft57NleHTTPCd6QukrG2yYLrBLX5jK+rLA==
X-Received: by 2002:a63:698a:: with SMTP id e132mr24303698pgc.434.1635348638933;
        Wed, 27 Oct 2021 08:30:38 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id w11sm180048pge.48.2021.10.27.08.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 08:30:38 -0700 (PDT)
Date:   Wed, 27 Oct 2021 15:30:34 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Marc Zyngier <maz@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Anup Patel <anup.patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Atish Patra <atish.patra@wdc.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Matlack <dmatlack@google.com>,
        Oliver Upton <oupton@google.com>,
        Jing Zhang <jingzhangos@google.com>
Subject: Re: [PATCH v2 40/43] KVM: VMX: Wake vCPU when delivering posted IRQ
 even if vCPU == this vCPU
Message-ID: <YXlwmrrRVIoaU2kG@google.com>
References: <20211009021236.4122790-1-seanjc@google.com>
 <20211009021236.4122790-41-seanjc@google.com>
 <a2a4e076-edb8-2cb5-5cb2-6825a1a4559a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2a4e076-edb8-2cb5-5cb2-6825a1a4559a@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021, Paolo Bonzini wrote:
> On 09/10/21 04:12, Sean Christopherson wrote:
> > 
> > Lastly, this aligns the non-nested and nested usage of triggering posted
> > interrupts, and will allow for additional cleanups.
> 
> It also aligns with SVM a little bit more (especially given patch 35),
> doesn't it?

Yes, aligning VMX and SVM APICv behavior as much as possible is definitely a goal
of this series, though I suspect I failed to state that anywhere.
