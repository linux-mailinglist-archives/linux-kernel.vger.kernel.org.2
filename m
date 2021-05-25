Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C40CA38F74A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 03:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhEYBE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 21:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhEYBE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 21:04:28 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C927C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 18:02:58 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id m124so21377518pgm.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 18:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z58QfC5D6YeFAbzSgFuFnv7cuq5vhjfp0Kxje8RxtIo=;
        b=W+B3bpONTpGdLIhDuxN26qGvLBjiytIUAf4B7oENMOFgCrlz6Q+Ybrm9jrsflLeJm5
         rcCnaEuGr2lC/mn11sX0oH5IM73f2dlBowVs1UXKTXeGqM+g3JP9ps0l8SIwWTB8ihDq
         aUEU4szrh2FCBAHV6gQWxAakJjUgdIuzHxCC7QRwlgvlistXUVTZTITy4F3+EH1fWF5m
         4ET9qis/9K3bAFK43k9U7SHr73rE6SY6bebeTKb2ipuWfCC9EIh/l+NDu30IsorkZXfK
         5zJlE137c6UTrUx0t9w+xZBb80U3N6HmUN4liigml7SDZUY1yxuAdqWhaIjISooGS5g/
         4a1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z58QfC5D6YeFAbzSgFuFnv7cuq5vhjfp0Kxje8RxtIo=;
        b=GA3YIoqRxcDpi+hixLrJfG8/PRwGV0Z6wMddJe38qFB0fEaZvVYLwrs8+PnsnXVl/C
         unXYdLiCvVhy8Nx63UO3Y1Wq8marlGEwyErKZ8Dx7DN9Bt83Rx3FkVfd6Yuot5aUQ2/D
         qLnDSjjXoBJm0Bjdhy0qdp46sqVT1kT5wCdRN8iK9QVi6gR7aWrdCTbeSvdb/P9wtD9Z
         IBYYbVlGrkd4EHh+EOeRzFKFkngmesf8ZjufWHGFdpOcTRvhShckpjjwSP0Q9GgpoCjf
         RUT3PvZkAVpMygDDvpT1Up3fZ54NlDJ4HYF8pn7CtbfF7uDf80NOibA7IJ5tETWukFpl
         puIQ==
X-Gm-Message-State: AOAM533q+zpt+hW92x02yhFBDFT5/T9mEkV1uKfC2yrBS0ZhVY/54k74
        1oQLkQWBBtcCHhI9cEEr4qHnDA==
X-Google-Smtp-Source: ABdhPJyY878/s4A/o8aiG0cDhKDvPtIrkjtz94B+7lT2MUtgJ4XDTGei4+Ezb+bDvWjuG/rNERawxg==
X-Received: by 2002:a05:6a00:84f:b029:2be:3b80:e9eb with SMTP id q15-20020a056a00084fb02902be3b80e9ebmr27677157pfk.39.1621904577837;
        Mon, 24 May 2021 18:02:57 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id s5sm6567319pjo.10.2021.05.24.18.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 18:02:57 -0700 (PDT)
Date:   Tue, 25 May 2021 01:02:53 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 42/43] KVM: VMX: Drop VMWRITEs to zero fields at vCPU
 RESET
Message-ID: <YKxMvVCqOvGSQa2U@google.com>
References: <20210424004645.3950558-1-seanjc@google.com>
 <20210424004645.3950558-43-seanjc@google.com>
 <e2974b79-a6e5-81be-2adb-456f114391da@redhat.com>
 <YKwomNuTEwgf4Xt0@google.com>
 <CALMp9eSsOw0=n4-rn5B1A_T9nYBB0UkXWQ+oOJNx6ammfJ6Q-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALMp9eSsOw0=n4-rn5B1A_T9nYBB0UkXWQ+oOJNx6ammfJ6Q-A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021, Jim Mattson wrote:
> On Mon, May 24, 2021 at 3:28 PM Sean Christopherson <seanjc@google.com> wrote:
> > That said, I'm not against switching to VMWRITE for everything, but regardless
> > of which route we choose, we should commit to one or the other.  I.e. double down
> > on memset() and bet that Intel won't break KVM, or replace the memset() in
> > alloc_vmcs_cpu() with a sequence that writes all known (possible?) fields.  The
> > current approach of zeroing the memory in software but initializing _some_ fields
> > is the worst option, e.g. I highly doubt vmcs01 and vmcs02 do VMWRITE(..., 0) on
> > the same fields.
> 
> The memset should probably be dropped, unless it is there to prevent
> information leakage. However, it is not necessary to VMWRITE all known
> (or possible) fields--just those that aren't guarded by an enable bit.

Yeah, I was thinking of defense-in-depth, e.g. better to have VM-Enter consume
'0' than random garbage because KVM botched an enabling sequence.  We essentially
get that today via the memset().  I'll fiddle with the sequence and see how much
overhead a paranoid and/or really paranoid approach would incur.
