Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9CA4098F2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 18:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237249AbhIMQZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 12:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbhIMQZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:25:32 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A062C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 09:24:16 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id on12-20020a17090b1d0c00b001997c60aa29so266006pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 09:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q0CGByNGBLX5VAdHy/UUqDDhbh6zFNghWMoOnFHZGGw=;
        b=RKVTfzY0+sEOlHZwMw4vPz+GvPXyX750p2mC7wWOXKxWfCoapA8MjCsz6G9dj02/wG
         B3XA0COQxzdKlQnGZdkEIklM+WI1cCOz+NXBUmQAkuk6QYoRk2zuC5o5qdb+Waer+AG6
         OJfpQmWIx+uSLeokuBis+oQjVfX0ehooADGOWTQJL7kvEiY2whnhENiIBsCY1yS7miFs
         eIwDCSG3arqEXzSdyaQ8k4NCpo1gSL9V/1EeiI4I0/s0VJZhs1z0e/EcQVIbBvac32A4
         s/tiDk2BF9PVxJ1n8cTLxrdDzppZo/ZkmBIG/TmGcUI4PbafbQvkNhTqwB0iH4JdKWBE
         B1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q0CGByNGBLX5VAdHy/UUqDDhbh6zFNghWMoOnFHZGGw=;
        b=w8qIV5aWX98OPvJHV2UT06k9jvGThRnMcbzPeCZHKJZLOgm9gw18Bgkazd24XQktqm
         8eCo0sPLgqBxCZZ3jlTLrV0oewuhijbv3ZpxkcBYw46Mki0kfevAp7BgGMQwELC9pXpN
         FSRVRZJBQFInvkyMIJOWCheNlI20gqTahfOTQBhcjexb2b41aOqPyLxFyIvDBYEKgZny
         NT/bFLwdldCvGVoa4jQNvyGMvEpAzSZpqwCEDBIZ+i+HB5Vf4uJAoViYvwAWgWCJCPF/
         vCaCVEueyK8HFTqkp4E4k05O6Cp8yYbNxyqNa90lGy4wEgzXDyxEXtIzmmefpgnSEpU4
         iXWQ==
X-Gm-Message-State: AOAM531vXGoQ5AT1KNiMfgnyNvi9F4uaMh0Krai9/6oim4iM6NKwX4SV
        8xrHwn1i31V8PVLWaZTy/yjVBQ==
X-Google-Smtp-Source: ABdhPJxf1CW8M7Ti4tr+U9bXba0ZjdRcakxdnIlaD1AcyqYZi788mkJc1rFObUJoedvExK8OgSG5Tw==
X-Received: by 2002:a17:902:c94f:b0:13b:8359:9506 with SMTP id i15-20020a170902c94f00b0013b83599506mr9519028pla.33.1631550255767;
        Mon, 13 Sep 2021 09:24:15 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id b16sm7768188pfr.138.2021.09.13.09.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 09:24:15 -0700 (PDT)
Date:   Mon, 13 Sep 2021 16:24:11 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Juergen Gross <jgross@suse.com>
Cc:     kvm@vger.kernel.org, x86@kernel.org, linux-doc@vger.kernel.org,
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
        Shuah Khan <skhan@linuxfoundation.org>,
        Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 2/2] kvm: rename KVM_MAX_VCPU_ID to KVM_MAX_VCPU_IDS
Message-ID: <YT97K7yXyCrphyCt@google.com>
References: <20210913135745.13944-1-jgross@suse.com>
 <20210913135745.13944-3-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913135745.13944-3-jgross@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021, Juergen Gross wrote:
> KVM_MAX_VCPU_ID is not specifying the highest allowed vcpu-id, but the
> number of allowed vcpu-ids. This has already led to confusion, so
> rename KVM_MAX_VCPU_ID to KVM_MAX_VCPU_IDS to make its semantics more
> clear

My hesitation with this rename is that the max _number_ of IDs is not the same
thing as the max allowed ID.  E.g. on x86, given a capability that enumerates the
max number of IDs, I would expect to be able to create vCPUs with arbitrary 32-bit
x2APIC IDs so long as the total number of IDs is below the max.
