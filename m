Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E24793B3593
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 20:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbhFXSZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 14:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbhFXSZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 14:25:20 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6832C061756
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 11:22:59 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id w15so876750pgk.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 11:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TJhHdtnxjj/1lVcprn43QULb+ZY45Gr2FgD9/P84aBY=;
        b=P5/Ko+gJ8MDRmc9LFwnOF/4ehpMbP5HoDQi+FRXbTm/Lvh53L19UftCK5oNvnV1yXO
         IxgKRQDU3AHhwmJ0GIskAlWBYCHjYVLEJcVvDSkjNMjxFLSZ7FQZg+fc1Iz2yJ2pqG5e
         6aYOZevKik5DoDZLLwKqcKse/lOLUDx6I0aAVriwC7zTIL2Qff1Iw5yBa4ucq0WjOb5s
         MUxVjFINmO6M6wQJmfWnSkOq7ojYCgQhPzMuK0FLruX1ckYkZiXzbZPBspd7fAU3fFFF
         xZoVwy/ejcrez0V0Kqw2oYuA8AOADzHEPFzuJIAK234KwgrYh7Ri302hEmdOKNQirI66
         HPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TJhHdtnxjj/1lVcprn43QULb+ZY45Gr2FgD9/P84aBY=;
        b=k5xHYxqGkkP7XgwPeDcPdGK18qZm+NwUNZsXk2ZspIg31OdMlRMN2A3yR/QQkP+SEg
         Kdw2I7ImmEXOCOQgwBpQBaQLlnn6yWiPohcqJ9uf+ocaisr2/YdRE5aZ7crEDpLUjpV4
         OBIg/0kT/LyzCO/MoCMdjQ6UM3gz05rkhGCFm3p/zc7p5ZFDiRgOf+0r+k31J0Ob/ieF
         Rm1T1/JlRmgvVcnmDmr3saTYqoIExbPbrdSkmEMs4/WC7kFdmf+793uJW74SXLMs3EGN
         TxhM1hzOeUuPCH6+5KRLnNhPMtK1nheGEIZaXD27XcxWKFJjZMANh0MIPtgi8nCqSEgC
         ckXQ==
X-Gm-Message-State: AOAM5311URRTRaKMrcCeRhuayqE6xKri+kPOJC4mhJWMSuzBdI8dAF8B
        ZAGmpUbQgyFuhSMn2CcvWxax/g==
X-Google-Smtp-Source: ABdhPJw3vlLyaJMIS/4zHGZVNguvlAujelhx4/lUcgZS6VaIVdkQwxduwh2vHy0A67/SEVxGFWqLpg==
X-Received: by 2002:a05:6a00:be4:b029:300:effd:431f with SMTP id x36-20020a056a000be4b0290300effd431fmr6203290pfu.69.1624558979065;
        Thu, 24 Jun 2021 11:22:59 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id g38sm2948626pgg.63.2021.06.24.11.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 11:22:58 -0700 (PDT)
Date:   Thu, 24 Jun 2021 18:22:54 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: Fix uninitialized return value bug in
 EXIT_HYPERCALL enabling
Message-ID: <YNTNfouvheAyCSdK@google.com>
References: <20210624180625.159495-1-seanjc@google.com>
 <6146d62f-3c96-1def-a537-1eace63368f3@redhat.com>
 <CAKwvOdnVUpsiaHAi6DaV7zc4tbi7t6=BcYv85pDXiHQDQUY_0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnVUpsiaHAi6DaV7zc4tbi7t6=BcYv85pDXiHQDQUY_0A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021, Nick Desaulniers wrote:
> On Thu, Jun 24, 2021 at 11:19 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > I have already fixed this locally, though I haven't pushed it to kvm.git
> > yet; my tests should finish running in about an hour, and then I'll push
> > everything to kvm/next, except for the C bit fixes.
> 
> Ah, I was looking at this case in linux-next, and
> 0dbb11230437895f7cd6fc55da61cef011e997d8 wondering what was going on!

Doh, I obviously didn't look too closely at the blame.
