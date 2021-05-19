Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A10FA388699
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 07:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbhESFf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 01:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239274AbhESFew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 01:34:52 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B82FC061348
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 22:33:10 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id 69so6369686plc.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 22:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ArOATr+a0hXgg0J/jDFFZIaPxMAnGoAVL6O4IK6IU5Q=;
        b=PA5YOTA74ZqK4ihTbqvYrO6pwXRBFTcGA+K8i1355p/H2iLpC5IVs6RWKWmEK9hNr4
         MMoc7u6cNDNhMU90PHJtcMwv0OXFRITfQt2V/tARKcNKdN+SVhTce09sc/HC6YWJEvzW
         IMsZC/cKydRDZ+G23T3Ht7TkYV7vB8h0OHjQuaUuEsg5jpbMtEJPo0phnwLg8C8m+5hu
         BFDWqPxcF8bysY5K5aCCPUkYnNHB9gbqr/l2YUruyQ/udBaBNJGuVORCP7m9UW14uFSB
         SNmD2kkEejOExEFCj8qCoHFVMbmRwxCmtZWqv4GMRA/dUZqFnTfuMRHvqe6YMqq12qbO
         Zwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ArOATr+a0hXgg0J/jDFFZIaPxMAnGoAVL6O4IK6IU5Q=;
        b=BUAmWnz3WRtBT6miaG3/1BmL9X7ZGdGh9rbivDT9k3r3VDqffmMgmz0cpNty8X4XRn
         9w452E74HHShKXfZXKn7NmugW7Ac0e1x76n7W67v8KkRgaw6nFJUAKoCmAY4KQj9eSPV
         IcEvLlzQnDRyK5JWn1X8awpKJhIis45eUvLPi0YcdxCod9FDDuRJhnsBYdrKTAO3w21U
         M34fAayco7YRWr58T1MwhVli3aNgwe6Ro0z+n3MJ1gl5u/YXxIjV1cfBGnFGc0JF0VhK
         zsRfBTEmSKS6a3tSa542eRg0a1LwzmlyCIga5K3kTBlapoJSXzgZl0hUieAxQtwzJPCY
         Abug==
X-Gm-Message-State: AOAM531r4fonmb+bkOfBVW3/pkC22g6Ud+3crcQ83j7n4v/iMwBaI+pC
        9FtMu/iTqjO6x+xGv+bi4btRIHnrUl+lnT95liZvtg==
X-Google-Smtp-Source: ABdhPJwgB/PikSymdwEqi0NsFKS6ad6C5UPBpSBjvW7I4YRC2SriqOp2m3HIhoEvlTgLuxjqp+CO+8H/9EX5oh8nCjQ=
X-Received: by 2002:a17:90a:6f06:: with SMTP id d6mr9671757pjk.216.1621402389903;
 Tue, 18 May 2021 22:33:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210424004645.3950558-1-seanjc@google.com> <20210424004645.3950558-10-seanjc@google.com>
In-Reply-To: <20210424004645.3950558-10-seanjc@google.com>
From:   Reiji Watanabe <reijiw@google.com>
Date:   Tue, 18 May 2021 22:32:54 -0700
Message-ID: <CAAeT=FzKr2s60gh8ejqLwk92WySwEv_Ooa1se3g0WDP=qu7yiA@mail.gmail.com>
Subject: Re: [PATCH 09/43] KVM: SVM: Drop a redundant init_vmcb() from svm_create_vcpu()
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

On Fri, Apr 23, 2021 at 5:48 PM Sean Christopherson <seanjc@google.com> wrote:
>
> Drop an extra init_vmcb() from svm_create_vcpu(), svm_vcpu_reset() is
> guaranteed to call init_vmcb() and there are no consumers of the VMCB
> data between ->vcpu_create() and ->vcpu_reset().  Keep the call to
> svm_switch_vmcb() as sev_es_create_vcpu() touches the current VMCB, but
> hoist it up a few lines to associate the switch with the allocation of
> vmcb01.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Reiji Watanabe <reijiw@google.com>
