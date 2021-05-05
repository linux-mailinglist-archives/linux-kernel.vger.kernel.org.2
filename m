Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F90B3733D4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 05:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbhEEDFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 23:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbhEEDFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 23:05:49 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17714C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 20:04:54 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id h11so1215163pfn.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 20:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dnt665vgiL2qf1EJoHUsRCoeU5QOH0HDsCXvJJOoGE0=;
        b=P9TMJuT38F74L0PYovB9Xl2c3QeVAyOfq7OAAVkUg04WJIX5pgFE8c6RP1aly3OTqz
         njltVvhnKWyGlyoSo7n1Am0dOVn5JYUwM+JyLEgsY6eWCXpW2qoITx0xngAvYSYSXSy5
         s2Wfm/xwToL+YTusxDF97EwARR+utxhmfKrz2C8kEkgsxqCtHwLAutF6DEQ5LvLp/Hei
         sLBe395Xtjd+lyiaUJRfmhjj/g0iUKceJLMrqO76DY5+fqwVNxmqCeIHlmh+RfxgVM5c
         GkdPck4fNTvXRU5K1ZB6rpsfs7D1qb+VKqfrHNJZcPfiiwNmU0ni+KOjw0+3ersjprKR
         LsiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dnt665vgiL2qf1EJoHUsRCoeU5QOH0HDsCXvJJOoGE0=;
        b=rtDCHEsVz2RtGwLCYZ4CD+dIfUSXHXTKQRcd449G0944i7rDmwuRaElnehTICZhR5o
         Wc0eKJUD+pDYWvJnD5wyodmJBPZB+oBqbaT3/TS084Ho5k1jMbBOtZsxYnNP7xjK3xrs
         Zw4z3U0B2zA9I1d+8rF6gMEzZHD0byBXwPA860L7dqFO60LDBcR+EBXFyAhZ1YwO4jU+
         8dkOAgJksLbMELlMcmwHeXzX3rnqzTY8wqOsOB+kEF/PRM+0juvcFxbAL8D8Z20YRej1
         gr/ycNnJNZA1DgXNPz2fDIuZJJJtKM3Gi7iko85A0Yu0OhCPI6nsqEY7ACFqF243QkYJ
         u23A==
X-Gm-Message-State: AOAM532l5KEPavtotWwQObpsaYSnkOyw8kO9V0J/2HRIYgUEy4zLQ8AU
        3HuiSTzD7Im2wa99Ao6BP01iX6glAbZ7cUZzl+wCOQ==
X-Google-Smtp-Source: ABdhPJxbe749qrF5GVXDVwxQvqccIdvbA+blsXEK19Zn0Gdrvd/zoYR5q2XrJUAcd3rzGoCB05VdS+W34/lD8JCSPws=
X-Received: by 2002:aa7:8c59:0:b029:28e:9093:cd4d with SMTP id
 e25-20020aa78c590000b029028e9093cd4dmr13659040pfd.25.1620183893345; Tue, 04
 May 2021 20:04:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210504171734.1434054-1-seanjc@google.com> <20210504171734.1434054-2-seanjc@google.com>
In-Reply-To: <20210504171734.1434054-2-seanjc@google.com>
From:   Reiji Watanabe <reijiw@google.com>
Date:   Tue, 4 May 2021 20:04:36 -0700
Message-ID: <CAAeT=FzLn_RJuVSqEVPeFQg1VYHS4N7715XZbUA4MTUXSS5EvA@mail.gmail.com>
Subject: Re: [PATCH 01/15] KVM: VMX: Do not adverise RDPID if ENABLE_RDTSCP
 control is unsupported
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 4, 2021 at 10:17 AM Sean Christopherson <seanjc@google.com> wrote:
>
> Clear KVM's RDPID capability if the ENABLE_RDTSCP secondary exec control is
> unsupported.  Despite being enumerated in a separate CPUID flag, RDPID is
> bundled under the same VMCS control as RDTSCP and will #UD in VMX non-root
> if ENABLE_RDTSCP is not enabled.
>
> Fixes: 41cd02c6f7f6 ("kvm: x86: Expose RDPID in KVM_GET_SUPPORTED_CPUID")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Reiji Watanabe <reijiw@google.com>
