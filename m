Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A803731DE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 23:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbhEDVYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 17:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbhEDVYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 17:24:34 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAC1C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 14:23:39 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id h11so531103pfn.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 14:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=crQ/z90VynR9Nw4iMZbm/fJ+5jGazNEOnJsFBEBiLQA=;
        b=pUPNK9J9gLuhujWqex8hulXlwddBwJ06dqftvgLSVwT2qAFtUAqE9l14QRXVPH6AO8
         2/lKMSWge1ZHJzUWin/LaLdOp6QsCrsxhULscCPeHE+RfX698lUKfPRwDh/WYKxgTZm1
         DgDh3vnOh03o/5k4fLUEHtkbIM7gKsnHke48sFY96HdnjsEgUTduUXq20ySypDYu7MNc
         G2+eYi8jjO9xBa/oYO6w0cBxYy2OQN4Pk/uKEUZ83i7ffmnheDPAmUj9aprs7y4h1WEC
         3iT2c5IJJxseCD95AXQ9VRNcbXv4n1CWkVO6FeGLvmR2NGtu//WC67N1PnHma125QOjI
         4PJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=crQ/z90VynR9Nw4iMZbm/fJ+5jGazNEOnJsFBEBiLQA=;
        b=O1rpeZg1Y9TBUTNkmNKHkeBh8TOTNz5yKh6/Wp/QUVwOfUEVCsa5r8reBxAZXwdxsZ
         joG8lsnh0ljOIqJUHff9o3U+rzEw+I6s4S1GzIgrVpEYfeQ15bcAJXIodxr+z523CQC/
         veMPgpCZge5xARTpJ2X3lods5LmGHqrwByTBcGWBmd0Zq+2pLRlzd13y7UsQKNzxG3za
         piHmm1PAeBYdArE8u9ky6CgeJvD8nPWp77SdulSY8Dp1tgAIIFn5WMhFZqWydSSv7WQx
         MsvIK15tvAzznIi7BEgoFjpkIHBaTdoj47pqjq3F9z7+UqMr+OLVPzSpM9WRZpp4mAXI
         wOHA==
X-Gm-Message-State: AOAM530kVYi8lJNuokcxiN28jrdYUC/BRZYciKXPZu7TQgJ0yS+NYtw6
        vO/u8OJnfah/m/4w+17x+sPRog==
X-Google-Smtp-Source: ABdhPJwO132F5yTiBz93WWjlbHtkVHQBtSkqk8jgadL/u2cQbknBjMDRiajdnr0BYLVXLCS68YVqVw==
X-Received: by 2002:a17:90a:950c:: with SMTP id t12mr7437856pjo.135.1620163419085;
        Tue, 04 May 2021 14:23:39 -0700 (PDT)
Received: from smtpclient.apple ([2600:1012:b045:bfcd:1901:995b:42d3:ee59])
        by smtp.gmail.com with ESMTPSA id c16sm4217178pgl.79.2021.05.04.14.23.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 14:23:38 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] KVM/VMX: Invoke NMI non-IST entry instead of IST entry
Date:   Tue, 4 May 2021 14:23:37 -0700
Message-Id: <38B9D60F-F24F-4910-B2DF-2A57F1060452@amacapital.net>
References: <YJG6ztbGjtuctec4@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andi Kleen <ak@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Uros Bizjak <ubizjak@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Juergen Gross <JGross@suse.com>,
        Joerg Roedel <jroedel@suse.de>, Jian Cai <caij2003@gmail.com>
In-Reply-To: <YJG6ztbGjtuctec4@google.com>
To:     Sean Christopherson <seanjc@google.com>
X-Mailer: iPhone Mail (18E199)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On May 4, 2021, at 2:21 PM, Sean Christopherson <seanjc@google.com> wrote:=

>=20
> =EF=BB=BFOn Tue, May 04, 2021, Paolo Bonzini wrote:
>>> On 04/05/21 23:05, Maxim Levitsky wrote:
>>> Does this mean that we still rely on hardware NMI masking to be activate=
d?
>>=20
>> No, the NMI code already handles reentrancy at both the assembly and C
>> levels.
>>=20
>>> Or in other words, that is we still can't have an IRET between VM exit a=
nd
>>> the entry to the NMI handler?
>>=20
>> No, because NMIs are not masked on VM exit.  This in fact makes things
>> potentially messy; unlike with AMD's CLGI/STGI, only MSRs and other thing=
s
>> that Intel thought can be restored atomically with the VM exit.
>=20
> FWIW, NMIs are masked if the VM-Exit was due to an NMI.

Then this whole change is busted, since nothing will unmask NMIs. Revert it?=
