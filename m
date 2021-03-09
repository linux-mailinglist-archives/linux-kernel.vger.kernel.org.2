Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F68332F48
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 20:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhCITq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 14:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbhCITq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 14:46:26 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EF3C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 11:46:26 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id t85so4855403pfc.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 11:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ulHEFS0WTjr5/aHH5c5+5bv6zMRwJNOuuyKVe1EaduU=;
        b=tDCwz+0VAHUWFW8ENdoYvwCgB+PYV8SZx1symQ5stezY2HKO9bhjTb9is7Do0Rmyrz
         RKwPLyYnSl04hTUWb+W/puDN2woRhrGNiDr/lkrXFKTgTIalcMFdNeAwQqG+6eizJbvq
         YPwNe32v9Zi16DZf5EWTcqJGrRh5QjBxcOHr/AVOfJtL2bAiLUPF226M1nJO7uDVKb3q
         v2Cx+aSAk4qegAHMZ18LAEuEqVVLCkAnHnXGo0pKf+5ko5KET2Ah+cKgosInrny4Yxt5
         07Bg8cjHjOFqXB0pn/YDutiqlhkxwHnpiHperOAFw15MhS/tax2G35tE1Lrp6mnjEZ5P
         S7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ulHEFS0WTjr5/aHH5c5+5bv6zMRwJNOuuyKVe1EaduU=;
        b=qZ4iFuc0iQ2QslsDB6PvwoTmx11GLdfSv1/QBf4fGA52+KSMDn/jh912JwjWx0Sl9H
         AZe+GtD0KKr2sV6y/XzZmtZrAwousyPzUnQl+VUzjMNy091eSSQm4VtDxoDI76+wQ8nx
         RZVYoUzibn7wB7KeGsrhfDMhNLnH++npZyxMmcoEjrj08hp9oCU0IAabGzRkrEF1bwkH
         qPnTXqmsiLa2PSz+F47rcG+vgHad4cwLLSuJtQFQBb9doSFpBniMGUDukUSvpe29ltQd
         Ty/d6j9u+ZL3g2gHgfOkXl2jQELwKjwwyNNEZ/jS2jtiB18nmeTmIGLHgXM17gcyZgBM
         n5cQ==
X-Gm-Message-State: AOAM533PVwnGgyPHvR2egCGCdphF33AmYJrinibNN5dhCo7tbqrcRSQW
        U/yI9PeW+Z2XUUQlSEodhb0jPQ==
X-Google-Smtp-Source: ABdhPJybHTP3N7F5degWWSVA3xCblaZEqgKqapj1rEhqdWEkirSEOr0Ufvmn/BzU4CJTGAWgpJgQQg==
X-Received: by 2002:a62:7a09:0:b029:1f1:5cf4:3fd7 with SMTP id v9-20020a627a090000b02901f15cf43fd7mr4818201pfc.66.1615319185563;
        Tue, 09 Mar 2021 11:46:25 -0800 (PST)
Received: from google.com ([2620:15c:f:10:e4dd:6c31:9463:f8da])
        by smtp.gmail.com with ESMTPSA id e63sm5677664pfe.208.2021.03.09.11.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 11:46:24 -0800 (PST)
Date:   Tue, 9 Mar 2021 11:46:18 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Like Xu <like.xu@linux.intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot+cce9ef2dd25246f815ee@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] x86/perf: Use RET0 as default for guest_get_msrs to
 handle "no PMU" case
Message-ID: <YEfQir8rv8/j2hgn@google.com>
References: <20210309171019.1125243-1-seanjc@google.com>
 <CALMp9eRL4QRq4-DKEveNsJ8b2XSYEhZ-zKGFWsCcoZMnDeRtxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALMp9eRL4QRq4-DKEveNsJ8b2XSYEhZ-zKGFWsCcoZMnDeRtxg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021, Jim Mattson wrote:
> On Tue, Mar 9, 2021 at 9:10 AM Sean Christopherson <seanjc@google.com>
> wrote:
> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > index 50810d471462..32cf8287d4a7 100644
> > --- a/arch/x86/kvm/vmx/vmx.c
> > +++ b/arch/x86/kvm/vmx/vmx.c
> > @@ -6580,8 +6580,8 @@ static void atomic_switch_perf_msrs(struct vcpu_vmx
> > *vmx)
> >         int i, nr_msrs;
> >         struct perf_guest_switch_msr *msrs;
> >
> > +       /* Note, nr_msrs may be garbage if perf_guest_get_msrs() returns
> > NULL. */
> >
> 
> You could drop the scary comment with a profligate initialization of
> nr_msrs to 0.

Yeah, I considered that as well.  I opted for the scary comment because I
wanted to dissuade future patches from modifying this code without taking into
account the non-obvious behavior.
