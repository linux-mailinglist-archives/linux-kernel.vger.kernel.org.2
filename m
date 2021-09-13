Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B0D409A2B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 18:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241143AbhIMQ6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 12:58:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45618 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238966AbhIMQ6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631552219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g+3cqH6ifdVqKTPD8DSIcY8WRiPrRg0IjI4GufOGc8I=;
        b=Msp7aB1MnnFIoQcVFpmEF8x6z7ic0wfUmr4qs4z0RFBIj4yhykhXu/RdwJr08dsBy0TpQX
        2DykgNtMzUX6tJGZ2HXMiQKF4DuhWKmkS04urQ0Bye4G+/v3cyjdXMjfHHtzvtP0nM/xQA
        wXwok8/1aYJ17rjf2Brg7ktQZGMwWDE=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-QJKlBiQQPAqQ1gzSO2VJqA-1; Mon, 13 Sep 2021 12:56:58 -0400
X-MC-Unique: QJKlBiQQPAqQ1gzSO2VJqA-1
Received: by mail-lj1-f199.google.com with SMTP id w28-20020a2e161c000000b001ba14fc0cd4so4486544ljd.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 09:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g+3cqH6ifdVqKTPD8DSIcY8WRiPrRg0IjI4GufOGc8I=;
        b=EqIIvGzwWO/v4wjxAvb4Slyj7jDXH5IqFYffJX4maHmtgzTt3+BTOm5w6zepEZtggT
         iowc/ZPurNU53tryfEHkvDRosqQBvj8pFg7cLB+QIOt7qHB3tWPr5lnOXzBxHFYyCc2c
         QugD/SpDgJmKkxfn/gE+x4SKzcfM5A1KD5pl2lO+6bO3WOZirGdqn8oCXDUAo4TsyA5t
         nmLLMlEraqlWZajg6W12Nhqj9ZNemDaghF7qX8oOcE0wacoJHtClcr1DITlRaq+AFswc
         mEWTI0uC4S/ITrA9tC9BvkLy3Cq/hEqTUxOjt5ecKDJlFaVJO/re0ZfKQ1ddLPWx5yBT
         t1Cw==
X-Gm-Message-State: AOAM530mVTPEMk6sg71m1HG9/WIlpF3Afd6xG0mOXDyzk6NNWsommS5w
        Ug2dwMzf4yXsRhqBfOHyZC+GivEyIlCewofODHAhVg5hK4nSwrqGKNBHOGAoopQ6GZdqI/8c1E/
        IylepebY4dMCxeczB2v36w7zTurYaW8w7teNG4+w8
X-Received: by 2002:a2e:7304:: with SMTP id o4mr11659529ljc.51.1631552216993;
        Mon, 13 Sep 2021 09:56:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwEsueuL9hseX4+IMXePvu65lhG7CpxBDTW6sDERh7JVYGERNaG5Xeiw6ppL+jq20MLxOXsjghqm8q8r+/BSJY=
X-Received: by 2002:a2e:7304:: with SMTP id o4mr11659504ljc.51.1631552216735;
 Mon, 13 Sep 2021 09:56:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210913135745.13944-1-jgross@suse.com> <20210913135745.13944-3-jgross@suse.com>
 <YT97K7yXyCrphyCt@google.com>
In-Reply-To: <YT97K7yXyCrphyCt@google.com>
From:   Eduardo Habkost <ehabkost@redhat.com>
Date:   Mon, 13 Sep 2021 12:56:41 -0400
Message-ID: <CAOpTY_pyeOo2Kh-r1cEFk2XL4g8A1mxQpP1y62thWk2mh6XUUg@mail.gmail.com>
Subject: Re: [PATCH 2/2] kvm: rename KVM_MAX_VCPU_ID to KVM_MAX_VCPU_IDS
To:     Sean Christopherson <seanjc@google.com>
Cc:     Juergen Gross <jgross@suse.com>, kvm@vger.kernel.org,
        x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Mackerras <paulus@ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 12:24 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Mon, Sep 13, 2021, Juergen Gross wrote:
> > KVM_MAX_VCPU_ID is not specifying the highest allowed vcpu-id, but the
> > number of allowed vcpu-ids. This has already led to confusion, so
> > rename KVM_MAX_VCPU_ID to KVM_MAX_VCPU_IDS to make its semantics more
> > clear
>
> My hesitation with this rename is that the max _number_ of IDs is not the same
> thing as the max allowed ID.  E.g. on x86, given a capability that enumerates the
> max number of IDs, I would expect to be able to create vCPUs with arbitrary 32-bit
> x2APIC IDs so long as the total number of IDs is below the max.
>

What name would you suggest instead? KVM_VCPU_ID_LIMIT, maybe?

I'm assuming we are not going to redefine KVM_MAX_VCPU_ID to be an
inclusive limit.

--
Eduardo

