Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F63E33FA66
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 22:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhCQVTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 17:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbhCQVTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 17:19:35 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F681C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 14:19:35 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id g10so203000plt.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 14:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZCl7wm+rg+7YdxDRvddMtggI/CCto6o7F3c4jWSDx1s=;
        b=K991Jlgq3FuxzlY2VOYfCRhMGNagbKqPw1F818Bqfjk9Lf1hCAlStw1xaDZV8H9/aS
         BA7JScOMgoxv/B9y6pbQ6ixojP0HkhRuf/wyCrCUnYaQI8+saOu9sSKGIC68JG/0CB3K
         HJO+mhSj/6uey96LussfTTk68eT8Iv+8rkq4D57Q8/Pa6UaweTc+GsbzLJWrrlmKuI2o
         1zQyiv0jz9hobn2/8MiYK7xiG6GvpOCI7i+8zTajdzTzEX1UxFCwkGdlDtSx+9nFdstM
         iug3BNi1hMfc5EjJSp3+jGIc+RMK87AGPodEPpm0EFz0yYD+/z3ctzkzQ3MnddB+yryw
         Dotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZCl7wm+rg+7YdxDRvddMtggI/CCto6o7F3c4jWSDx1s=;
        b=B+sz3Aw85p7gL4oM74v0409AoDBdY/Ppbra0s13xEJW+HrF2WfS3Y+kwiXs9OBdUL0
         sMR4p/Z8L2slCQw0yjpqRjZy7lKeSZkg95MHUkpG+ObPnvyvvHapqu+uILcv9nxxgI6B
         b22ksfK32/byrCWJD3oipqZtTZgWnXq3wOTdX4l9GFI0RDXpk4LrQeCXXgH54ab8amD0
         A1PU8ioJPscOdcROXJbDBDQmU3Ra4LyjA2VQkP47AIUdc9jUCdjnUcdlE3LKupZS8tH0
         Lck6S13tyo1vnZAlQMPXar1ugIHd72RqMr9YHGIDSBS+lFvjRm9WIwciqvNcx/tH8Y7X
         c05A==
X-Gm-Message-State: AOAM530+DUBq4o8BMIRFe+5iJ25qq/Idk10+2J55tKhpH7ciMlEjg7w2
        C+YLIimr1CyURym+GCTr/DOJ0Q==
X-Google-Smtp-Source: ABdhPJyujNquT6pOn2lBA3SU/ja5oES6AA9+IQBQdZCbEmuJ8JH7+Y+2X0MY/+6PYQs893ANp2QqOQ==
X-Received: by 2002:a17:90a:db51:: with SMTP id u17mr788836pjx.194.1616015974590;
        Wed, 17 Mar 2021 14:19:34 -0700 (PDT)
Received: from google.com ([2620:15c:f:10:e113:95c2:2d1:e304])
        by smtp.gmail.com with ESMTPSA id iq6sm59012pjb.31.2021.03.17.14.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 14:19:33 -0700 (PDT)
Date:   Wed, 17 Mar 2021 14:19:27 -0700
From:   Sean Christopherson <seanjc@google.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Peter Gonda <pgonda@google.com>
Subject: Re: [PATCH] x86/cpu/AMD: Adjust x86_phys_bits to account for reduced
 PA in SEV-* guests
Message-ID: <YFJyX/MludiiS+dN@google.com>
References: <20210317183243.2904919-1-seanjc@google.com>
 <20210317191132.GD25069@zn.tnic>
 <YFJbzIrGLXu2UsFv@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFJbzIrGLXu2UsFv@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021, Sean Christopherson wrote:
> On Wed, Mar 17, 2021, Borislav Petkov wrote:
> > IOW, you have c_bit so your valid address space is [0 .. c_bit-1] no?
> 
> I haven't found anything in the GHCB that dictates that MAXPHYADDR == C_BIT-1,
> or more specifically that MAXPHYADDR == C_BIT - PhysAddrReduction.  E.g. AFAICT,
> a VMM could do C_BIT=47, MAXPHYADDR=36, PhysAddrReduction=0, and that would be
> allowed by the GHCB.
> 
> Forcing "c->x86_phys_bits = c_bit - 1" doesn't seem like it would break anything,
> but it's also technically wrong.

On the other hand, "C_BIT=47, MAXPHYADDR=36, PhysAddrReduction=0" would mean the
C-bit is an illegal PA bit from the guest's perspective.  That's rather
nonsensical, but also not technically disallowed by the APM or GHCB specs.
