Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F643B1F11
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 18:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhFWQ46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 12:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhFWQ44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 12:56:56 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E101FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 09:54:38 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 21so2804360pfp.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 09:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5KXLh/nNuoT2ip+063n2eXTSx2vwf4ghELGrq4CweBs=;
        b=bYJ9m9pbQXUrM2IqV1nrLjs6lJxm0fVWw+dFsqVA7AniCDGdowvlGS4CEx5gTLh9Tk
         SI91Bd5c7KzIymPTtKbif30Qih6kuvXD6vZ60Rmn3wdAyL5vX2KuuqCdFYu0BlY14eH4
         5TLVRb6ZpTlztQBPDPfMunK6xLB+5ubSahIqlasR9OfX+fTk1VNvP80/VMxN0SRmmlX3
         RC6AfwH2qMcavkijggcMqKF1JZ7s8B9dr5VAg3NjYjWFCh95Psx1WRtPClLh8eb7Siu4
         y9mS2I04geQKupZkwjiUv1+PjqRVz3AByO9NWas2BfOOSMrZohgaSoy2cbma0nTn05gK
         9Kvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5KXLh/nNuoT2ip+063n2eXTSx2vwf4ghELGrq4CweBs=;
        b=HtYWe8ii5dunPuGWFhkXwJVXJqXE79lI/v7+7u84b7ReKYxT7yXbDfQwgOxW6qf4F4
         cKqenyx7e9P+6p/tp1/yExI6y0iAeDMOwNNylAEHrjmRJzYjZpU0tgKII9GvUXYjxr66
         Pg3yA/j3hDOXlX9OmEKRTxBbj61gkL/Vh8rl4Z/ID8g4DxTv+WpFL3pVkhleffZNTM06
         3mv9NehH2w4jAou2dMCnSQJinZTnl0fjFRARYKmmFhWlG/OhsMED4bovDOk7PXhHoFUZ
         LUmt6+MK7YeSve+WAr5bOZ+z5koRplBF+qgc1JPMSX3rBeNOCnFE1dnX/l6ZAwgoJzdT
         bFWw==
X-Gm-Message-State: AOAM530Wu01dgUCyWPVEFVJgm1F23HqfvbiQ0Jm2nObByQIkG5r5Hp7q
        4o0P+3cabvrwygE87qCNXD7wLg==
X-Google-Smtp-Source: ABdhPJyE+6Ht+AMUZlWTAssMYAqrIi1ovU/mM3yZDUc92doUyVKyW4sA31zIU7uZt6jGoz9SCNY5Gw==
X-Received: by 2002:a63:f850:: with SMTP id v16mr392047pgj.181.1624467278200;
        Wed, 23 Jun 2021 09:54:38 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id b6sm385609pgw.67.2021.06.23.09.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 09:54:37 -0700 (PDT)
Date:   Wed, 23 Jun 2021 16:54:34 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH 10/54] KVM: x86/mmu: Replace EPT shadow page shenanigans
 with simpler check
Message-ID: <YNNnSgVUYUewP2qK@google.com>
References: <20210622175739.3610207-1-seanjc@google.com>
 <20210622175739.3610207-11-seanjc@google.com>
 <8ce36922-dba0-9b53-6f74-82f3f68b443c@redhat.com>
 <YNNegF8RcF3vX2Sh@google.com>
 <df77b8e9-b2bb-b085-0789-909a8b9d44c3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df77b8e9-b2bb-b085-0789-909a8b9d44c3@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021, Paolo Bonzini wrote:
> On 23/06/21 18:17, Sean Christopherson wrote:
> > > What the commit message doesn't say is, did we miss this
> > > opportunity all along, or has there been a change since commit
> > > 47c42e6b4192 ("KVM: x86: fix handling of role.cr4_pae and rename it
> > > to 'gpte_size'", 2019-03-28) that allows this?
> > 
> > The code was wrong from the initial "unsync" commit.  The 4-byte vs.
> > 8-byte check papered over the real bug, which was that the roles were
> > not checked for compabitility.  I suspect that the bug only
> > manisfested as an observable problem when the GPTE sizes mismatched,
> > thus the PAE check was added.
> 
> I meant that we really never needed is_ept_sp, and you could have used the
> simpler check already at the time you introduced gpte_is_8_bytes. But anyway
> I think we're in agreement.

Ah, yes, I was too clever :-/
