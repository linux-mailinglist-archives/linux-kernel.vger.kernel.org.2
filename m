Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB30140FEB0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 19:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238623AbhIQRgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 13:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbhIQRgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 13:36:23 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953DEC061764
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 10:35:01 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id i19so7424746pjv.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 10:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e0hxS1eA5SlhYk+DVF+mEtmVrvpsQDkQJiWQ1Vtnubg=;
        b=sfJ7oAcPPNCOIpZ+NVb5trqZfpF5qCbn1z9GUSaoW+C4bkSHRHhY+kh5T1mZUEmYIR
         gWomWno1SuJJbGeKBEfIC96I34bb+SL066ueQHXTLcqYSL9/DZeLrGz+MwsLKTePIZbA
         Qb7Bwu5aUszUMXb7tBsCxO3DhLCbykgiPGWb6cCHl1q28ssDrds5YR1DNwhiHLU5r58a
         TuaFzxmeFs0gzZg5uxn0xJhxoQaUkRwfYLabcgogNph/4+PQdOV20lXVuXU8yafQ2pPJ
         nMLzfukKS8xtl0qj+8evJvI+ZUdjSQjZuCusRQ62QcCHLR4hddRAgDcbgy6wlnEdkPfM
         cJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e0hxS1eA5SlhYk+DVF+mEtmVrvpsQDkQJiWQ1Vtnubg=;
        b=HAAKMSRdY5wv5fMtmUGSFEwarAZ9oA5B+xNj/WwY2IliJcmxLXycQFTg08OoZX+U/N
         jka2u6dQrIoDkHYlBQxl7it7E6frLzfjfzLs2X+EtOBweVGffBeZ/xyBSYB9XhHHG3f0
         LnfW9a9pcqUY8+4s8GOX/lbMQ8V+0I1z67j4FXFg+5D7scii3WRja4zjoM9zHNReRIWR
         ckrGNapsrUoQsoLTb9+bg6WwqcPwzwdGLlAMiE1hwEMjwxY033IIz34W59PhkIY3CCIh
         NNVLxGgGCMPhTNwmDu26LY8Cx0WSfHzs9sdsA33Pqm/Tz1eJZwKtUZ6bADOeuILi+1qw
         8ebg==
X-Gm-Message-State: AOAM533psni7k9bYzWv1czYkHBNndMk0GdrDtgyCqe5OPVosfLZCN/WZ
        TB13KjJZnHv0w4ON0cLNU46ngF0WmyNkIQ==
X-Google-Smtp-Source: ABdhPJys65X648pqZciB9u5LcuOf0aQ81Kz254oKZko7YmkOnLX8KA1sk61/l9g707kyMtHlNTjS8Q==
X-Received: by 2002:a17:902:8d84:b0:13a:6690:8a08 with SMTP id v4-20020a1709028d8400b0013a66908a08mr10659715plo.25.1631900100818;
        Fri, 17 Sep 2021 10:35:00 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id k190sm6937624pfd.211.2021.09.17.10.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 10:35:00 -0700 (PDT)
Date:   Fri, 17 Sep 2021 17:34:56 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm <kvm@vger.kernel.org>,
        "Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>,
        Reiji Watanabe <reijiw@google.com>
Subject: Re: [PATCH 0/3] KVM: x86: Clean up RESET "emulation"
Message-ID: <YUTRwNT/O5Ny0MOQ@google.com>
References: <20210914230840.3030620-1-seanjc@google.com>
 <CABgObfYz1b3YO4a9tR02TourLmsnS48RWrOprrsEh=NpbQfjRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfYz1b3YO4a9tR02TourLmsnS48RWrOprrsEh=NpbQfjRA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021, Paolo Bonzini wrote:
> On Wed, Sep 15, 2021 at 1:08 AM Sean Christopherson <seanjc@google.com> wrote:
> > Add dedicated helpers to emulate RESET instead of having the relevant code
> > scattered through vcpu_create() and vcpu_reset().  Paolo, I think this is
> > what you meant by "have init_vmcb/svm_vcpu_reset look more like the VMX
> > code"[*].
> >
> > [*] https://lore.kernel.org/all/c3563870-62c3-897d-3148-e48bb755310c@redhat.com/
> 
> That assumes that I remember what I meant :)

Ha!  That's why I write changelogs with --verbose :-)

> but I do like it so yes, that was it. Especially the fact that init_vmcb now
> has a single caller. I would further consider moving save area initialization
> to *_vcpu_reset, and keeping the control fields in init_vmcb/vmcs. That would
> make it easier to relate the two functions to separate parts of the manuals.

I like the idea, but I think I'd prefer to tackle that at the same time as generic
support for handling MSRs at RESET/INIT.  E.g. instead of manually writing
vmcs.GUEST_SYSENTER_* at RESET, provide infrastruture to automagically run through
all emulated/virtualized at RESET and/or INIT as appropriate to initialize the
guest value.
