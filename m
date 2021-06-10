Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF15E3A2E2F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 16:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhFJObw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 10:31:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52020 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230406AbhFJObs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 10:31:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623335392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CXjwm022f1btPWZxExQD9Wi6mGGZrQ0Sf9jZNJK7BTY=;
        b=VrYFZps390baFKcGhWrcKktH5SVBsVJb8gRJ/jE6gL5bW7yroYkm0Ltrvaqn7thXJTIgMX
        onyUTqrm393OKqlQd+VUE04vh1kx05XTPHUwrOycUnomybCd4rQwLJBqhnjx2bcXbpIrlM
        5TTPGTD1vp/uo0/ZlQa8ufQOATQPksc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-knXZxfi7MGSU95veAR9Yfg-1; Thu, 10 Jun 2021 10:29:40 -0400
X-MC-Unique: knXZxfi7MGSU95veAR9Yfg-1
Received: by mail-wm1-f71.google.com with SMTP id g14-20020a05600c4eceb02901b609849650so3432412wmq.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 07:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=CXjwm022f1btPWZxExQD9Wi6mGGZrQ0Sf9jZNJK7BTY=;
        b=L+i6EGwKKkoAAKWKD5M3F70/lHVXg0lqOcEuDwvcjQ0/tIprd+IRmu8PQk3rbA0wFO
         cg7NL6+bw3ROe7hCwKEzl4X8vnHpdp46WIy+De0UbVTC8mlnOkRXANqN2C+80IIKOIpG
         UJniYz/iJstoUi8fRP2f19O4mf2hIEXKblwepLrrZJ6okOvYNozowxm2uQn8aS8EdLMi
         rBtG0I81Kqz5xp2JHh8S6JGIWvfYrLAryLejdOGb6TR2/tzhhtkJLQAK/zQGNjWzBlZg
         2PgZlKw6Ef+Gs8Q4Teg8viQ4uw8RBg8D3PcBvR5hwztuujkDfoP+lNzcJl7LClWYNikS
         nVNw==
X-Gm-Message-State: AOAM533dviFiKsHeovhLXQWuNGlaZfjYDtzQlWdzcqEawGihidnRdyRy
        7+Em4LsVU8XGv35fA3AgT13YX3T9J1aaAxXc1P8ERxSdDtvjIuE0XDryYgTucHv1aAVnyd7Sazb
        92eSq4MeJAEsPHUF92ow3LQXK
X-Received: by 2002:a1c:cc02:: with SMTP id h2mr2923735wmb.39.1623335379059;
        Thu, 10 Jun 2021 07:29:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5YKmQhpdePLhcFwXesjKPtPyXVB/I64T17TPcEfyOuMlHO8/sT0DjK7es33C6b3nxHNYgxg==
X-Received: by 2002:a1c:cc02:: with SMTP id h2mr2923721wmb.39.1623335378876;
        Thu, 10 Jun 2021 07:29:38 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id w8sm4235981wre.70.2021.06.10.07.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 07:29:38 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v3 00/11] KVM: nVMX: Fixes for nested state migration
 when eVMCS is in use
In-Reply-To: <20210526132026.270394-1-vkuznets@redhat.com>
References: <20210526132026.270394-1-vkuznets@redhat.com>
Date:   Thu, 10 Jun 2021 16:29:37 +0200
Message-ID: <87mtrxyer2.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> Changes since v2:
> - 'KVM: nVMX: Use '-1' in 'hv_evmcs_vmptr' to indicate that eVMCS is not in
>  use'/ 'KVM: nVMX: Introduce 'EVMPTR_MAP_PENDING' post-migration state'
>  patches instead of 'KVM: nVMX: Introduce nested_evmcs_is_used()' [Paolo]
> - 'KVM: nVMX: Don't set 'dirty_vmcs12' flag on enlightened VMPTRLD' patch
>  added [Max]
> - 'KVM: nVMX: Release eVMCS when enlightened VMENTRY was disabled' patch
>   added.
> - 'KVM: nVMX: Make copy_vmcs12_to_enlightened()/copy_enlightened_to_vmcs12()
>  return 'void'' patch added [Paolo]
> - R-b tags added [Max]
>
> Original description:
>
> Commit f5c7e8425f18 ("KVM: nVMX: Always make an attempt to map eVMCS after
> migration") fixed the most obvious reason why Hyper-V on KVM (e.g. Win10
>  + WSL2) was crashing immediately after migration. It was also reported
> that we have more issues to fix as, while the failure rate was lowered 
> signifincatly, it was still possible to observe crashes after several
> dozens of migration. Turns out, the issue arises when we manage to issue
> KVM_GET_NESTED_STATE right after L2->L2 VMEXIT but before L1 gets a chance
> to run. This state is tracked with 'need_vmcs12_to_shadow_sync' flag but
> the flag itself is not part of saved nested state. A few other less 
> significant issues are fixed along the way.
>
> While there's no proof this series fixes all eVMCS related problems,
> Win10+WSL2 was able to survive 3333 (thanks, Max!) migrations without
> crashing in testing.
>
> Patches are based on the current kvm/next tree.

Paolo, Max,

Just to double-check: are we good here? I know there are more
improvements/ideas to explore but I'd like to treat this patchset as a
set of fixes, it would be unfortunate if we miss 5.14.

-- 
Vitaly

