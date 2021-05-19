Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35033886D3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 07:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237558AbhESFnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 01:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242639AbhESFhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 01:37:21 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0B5C06134C
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 22:35:11 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id f22so744117pfn.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 22:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZnXQTZd4YFiMxjzLc+WeIPzH5Cugof+bDJeafEZszhA=;
        b=OWZHAZGSoROkzO2D07Qx34Q2pTN/VV2QPYjA6sI+a5Mzw19NU6NO1dGrrvlKE6jE/A
         f357jaHElfq3C8/Q5Li3LkEkQdZvPxtRHUJIJ8qR5wwUvrEH6w1fAdA//kgPzaCbGVwP
         qHZpdC89rPPqrRdX0NaV/a2hndUrexpx1e8A0omE5npzPx+TdVnEMHbfh6xpmATIt9SD
         z0ZUhz+Fxe0LTo5EckuZuaRNv661aK7wGkNcmTyw3/Cp6zR8c3bJ0HO8+P048SMQQDHg
         SlorePs2V97iUM+6qysZMOk6R+En8+SnbwZWwu3TRCKQFyGXvtPRs6YjzijP7hmBFv/s
         JmqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZnXQTZd4YFiMxjzLc+WeIPzH5Cugof+bDJeafEZszhA=;
        b=pnKl3mOFbp1lKjVraBJ5hm7OU5fm/bsH1OloFxtQW5xqTOHkMerT31eQqTGAQLZAkc
         GsD/qyW28hu3A5YnUyNoTRZHQmtci7V1EKTGQsHzr7pr1i7OPFTVSlLb6p61zysA3FiM
         I22kIBtyCcwmYohKPlrNhrXSlAZOIAU5LIS0g5jEFe62iZG5g04h+IYbHx6NRF+/U0j4
         OJGumnnJh7UcBWefb5LOiGCTPjhX22TfjitQjkHeygc9duh2zFv3JKRS+Xiai6NMQJGw
         TPAKYUSUIdqvjK5lqosehCUVMljjhqkkw2amfdNvYycGCHN32DYf5yvmH5Hu9A78Sgkh
         x/8A==
X-Gm-Message-State: AOAM533TMJtb+yM7X+7CzEQeBJ3V5HUKu3OWcPc+z1pJ6qhvApPmZmpM
        qHpYQKNR8m/jKjw5KqVZU3k/+cTBkj9wY1Gjr/6Ysg==
X-Google-Smtp-Source: ABdhPJxRVRGQRmTOrx5g0fwZQ40vUC2OtgTmQ1h1QHlPsnFidYfsegpgCrqjFWNAVWbiD7CLjNy9sS0H5nOMl+lOapE=
X-Received: by 2002:aa7:8c59:0:b029:28e:9093:cd4d with SMTP id
 e25-20020aa78c590000b029028e9093cd4dmr8891246pfd.25.1621402510627; Tue, 18
 May 2021 22:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210424004645.3950558-1-seanjc@google.com> <20210424004645.3950558-23-seanjc@google.com>
In-Reply-To: <20210424004645.3950558-23-seanjc@google.com>
From:   Reiji Watanabe <reijiw@google.com>
Date:   Tue, 18 May 2021 22:34:54 -0700
Message-ID: <CAAeT=FzLMNr3QtTjchzvr9QStaQPJaQNvaqHGzfsRpp5fOBSEg@mail.gmail.com>
Subject: Re: [PATCH 22/43] KVM: VMX: Remove direct write to vcpu->arch.cr0
 during vCPU RESET/INIT
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 5:51 PM Sean Christopherson <seanjc@google.com> wrote:
>
> Remove a bogus write to vcpu->arch.cr0 that immediately precedes
> vmx_set_cr0() during vCPU RESET/INIT.  For RESET, this is a nop since
> the "old" CR0 value is meaningless.  But for INIT, if the vCPU is coming
> from paging enabled mode, crushing vcpu->arch.cr0 will cause the various
> is_paging() checks in vmx_set_cr0() to get false negatives.
>
> For the exit_lmode() case, the false negative is benign as vmx_set_efer()
> is called immediately after vmx_set_cr0().
>
> For EPT without unrestricted guest, the false negative will cause KVM to
> unnecessarily run with CR3 load/store exiting.  But again, this is
> benign, albeit sub-optimal.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Reiji Watanabe <reijiw@google.com>
