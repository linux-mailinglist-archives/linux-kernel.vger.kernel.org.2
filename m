Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8925A33F9B8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 21:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbhCQUFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 16:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbhCQUE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 16:04:58 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67276C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 13:04:57 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id h20so111216plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 13:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BYZNRlPQkZnMRBL4a+EpgO4ozvN4OwEfHCiHjo/X4no=;
        b=ArsiJrv3lMSRFF9w2hbQtRHO2p6QIL4v6hTHmS5990wpKcwbZFU3PjJ8gw/lSMCR8o
         Evh3us3rWOGBlWtl21ED5RkiXK3u/0lhXiCAnSx8p75DtbbROq+RdGIaxjj4JLp6vFY1
         vYFj41CzBTriZM1ZBuE3a4kcVh+MaKVvHlU6jWqjZHdyr68HFqjlj0jrfIf/5w0HdV+o
         MEnx/81FpMA7DD/h3XCRjZ0FNrv1mY3AOedY68nQhXRimuaB38htmP7XzmKkCzY0+gUc
         kiuD8UpPE7Vp+O7d77zwoUNutCiqqCo00UmGf3D7yTJdwmE+pzwmaFsHOe/PDBk+2arz
         0BjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BYZNRlPQkZnMRBL4a+EpgO4ozvN4OwEfHCiHjo/X4no=;
        b=MCMeT7XZfCu4ZieYxy0p6Ddi9FSyKO5VW6qhl7R0e9p/e7ireUdYZG+pad18I7iPvW
         jVgAPaT17Q/EuvHEDBuZDEQx6Kh0sjZ+If9ZaywW+E2udNQWrLNDFhRu6Jom+bO/JEl3
         eYzJyCP18AOIuweuKXYg/rYsJp1NmMofVyJONY+AZpd1Ql8u32RB0nQQ1hurqPjGTyqo
         0OMpzQoRQpsj3pB5hZdtxBaooHjzW5meex9zwSOSsaRvHRR63hbzJQuJOtRKqqB693BW
         Ii0pMMATVjyasIkr0ifDE5jCblCAiJ40RkF+3s2F4UGA26dmUCu7gPUl3uOo96v6FS1S
         QqLw==
X-Gm-Message-State: AOAM531kCm2ew3YjbrkbwTjLSQhmEhKEH9twTlh6BXdMo4w6kVXolbyw
        ANqtrbA9bo0L/6Ex/jap4pPN+g==
X-Google-Smtp-Source: ABdhPJya6VvchrfkLzaqvz1lzBesUntjlXZCteeCjukgygrX3dGib6g2gGR7BCTi+fjSWqHrqh3dew==
X-Received: by 2002:a17:90a:8908:: with SMTP id u8mr496624pjn.135.1616011497400;
        Wed, 17 Mar 2021 13:04:57 -0700 (PDT)
Received: from google.com ([2620:15c:f:10:e113:95c2:2d1:e304])
        by smtp.gmail.com with ESMTPSA id a70sm19908917pfa.202.2021.03.17.13.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 13:04:56 -0700 (PDT)
Date:   Wed, 17 Mar 2021 13:04:50 -0700
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
        Yuan Yao <yaoyuan0329os@gmail.com>
Subject: Re: [PATCH 2/4] KVM: nVMX: Handle dynamic MSR intercept toggling
Message-ID: <YFJg4vBj+/34SVgg@google.com>
References: <20210316184436.2544875-1-seanjc@google.com>
 <20210316184436.2544875-3-seanjc@google.com>
 <66bc75f6-58c5-c67f-f268-220d371022a2@redhat.com>
 <YFIzbz6S5/vyvBJz@google.com>
 <fe8329d4-3b80-7eda-a2ab-be282b4aa31b@redhat.com>
 <YFI7PTT5W7vzAK+i@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFI7PTT5W7vzAK+i@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021, Sean Christopherson wrote:
> On Wed, Mar 17, 2021, Paolo Bonzini wrote:
> > On 17/03/21 17:50, Sean Christopherson wrote:
> > > > Feel free to squash patch 3 in this one or reorder it before; it makes sense
> > > > to make them macros when you go from 4 to 6 functions.
> > > I put them in a separate patch so that backporting the fix for the older FS/GS
> > > nVMX bug was at least feasible.  Not worth it?
> > 
> > Going all the way back to 5.2 would almost certainly have other conflicts,
> > so probably not.
> 
> I'll do a dry run before posting v2; if it's clean I'll leave things as is, if
> it's a mess I'll move the macro patch earlier.

Backports to 5.4 (the olds relevant LTS) with a single trivial conflict on a
function prototype (the function itself isn't touched, it's just an unfortunate
false postive), and the MSR filtering selftest runs cleanly (in L1).  I'll keep
the original ordering unless you strongly prefer moving the macro patch earlier.
