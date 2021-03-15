Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E74933C94F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 23:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbhCOWYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 18:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbhCOWXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 18:23:30 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2250C061763
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 15:23:30 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id r16so6170745pfh.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 15:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=76pLO4ynd5ZWyHNZ5ZDnbUyusicrWJvIzQ5SsEfOQDk=;
        b=airqsXzB/pgup9ugIMokOYOuKc7ZnQPtpIwDXFzpRbFsDaCkP1G8y4Exe06QF6l+hd
         k7GGyjxmpCS+N8LxgaxVkErbGTuglwMmT442b3UL14DvdSXAE0DQQG4bEJzaEUWyEqMU
         /48gWqX0Y9tvWyQ7fMkNcuOwMqwk7aDAy/wCP2Wp0lhKACYfP+dNRuwzwc9pVCXlIG3L
         Pcwi0I8n/Br+aUTJP3BM1796/zCy2pUhwBtFQffBrFz0k8LVLxC/FmQk4nDbrGL4SzZH
         W5tsoTvgZRxpSeqxRDY2m6gXmjcrNVishHe56MgyoPTWALrd1ClF+ylfl0Oo5XCaaVZo
         t74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=76pLO4ynd5ZWyHNZ5ZDnbUyusicrWJvIzQ5SsEfOQDk=;
        b=ltpw8UC/firI9zz7G28b+GYmpkgc5tyKzYZajXUrboQ/CYZmycImvvA83YFn9jqhm4
         CYR72O8aKlBpE7AZ3BuNKe6v9XFJWyGSAn2T5IfNFCop+uBXD37TVeTZvmzraum/rVHN
         ssB4rdgunGtBlPXzCmkeLQeVlJdzDIMTcWajzHXURKZpyV7iTfU221uRYp+75qo3Ig93
         ilBbb9yXsVdO8aU67BIqr/pwA3MSFTMZs6CsgrCKuNduuJtzjFW9giPnZANAMHTMoTV3
         bAYWNdI8IAqxJ0y8DtKJidQw8esGwPpuPfXx0VHwRxK53IyyjcIVuxmdjBJPq38YHbB7
         W4oA==
X-Gm-Message-State: AOAM5308h/NCXDzy9uc+KSGg7vXY7uZq7UNmOHwbq/c3DzHzzXdj0u/m
        6RGIOjAuAZiAlgY7MqtjH1RGxYtLhw+jOQ==
X-Google-Smtp-Source: ABdhPJzErUir6olHz3A1ngb1qVLxTGkxO4C5zuXPoJPawtyx7X02V/kHW2KtzInAJJ84hCgOH6wwSw==
X-Received: by 2002:a62:37c6:0:b029:1f0:abe0:8d1c with SMTP id e189-20020a6237c60000b02901f0abe08d1cmr12130769pfa.23.1615847010099;
        Mon, 15 Mar 2021 15:23:30 -0700 (PDT)
Received: from google.com ([2620:15c:f:10:3d60:4c70:d756:da57])
        by smtp.gmail.com with ESMTPSA id s76sm14738422pfc.110.2021.03.15.15.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 15:23:29 -0700 (PDT)
Date:   Mon, 15 Mar 2021 15:23:24 -0700
From:   Sean Christopherson <seanjc@google.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Shier <pshier@google.com>,
        Jim Mattson <jmattson@google.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 4/4] KVM: x86/mmu: Store the address space ID in the
 TDP iterator
Message-ID: <YE/eXP60IVki7csd@google.com>
References: <20210315182643.2437374-1-bgardon@google.com>
 <20210315182643.2437374-5-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315182643.2437374-5-bgardon@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021, Ben Gardon wrote:

Missing "From: Sean Christopherson <seanjc@google.com>", i.e. the commit in your
local tree needs "git commit --amend --author="Sean Christopherson <seanjc@google.com>".
Alternatively, you could just erase my SOB ;-)

> Store the address space ID in the TDP iterator so that it can be
> retrieved without having to bounce through the root shadow page.  This
> streamlines the code and fixes a Sparse warning about not properly using
> rcu_dereference() when grabbing the ID from the root on the fly.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Ben Gardon <bgardon@google.com>
> ---
