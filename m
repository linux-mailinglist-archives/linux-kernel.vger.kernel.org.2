Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAE2317225
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 22:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbhBJVPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 16:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbhBJVNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 16:13:55 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE06BC061756
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 13:13:14 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id o21so2055102pgn.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 13:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d2q16jUlTFF+PgCEeQltVe2F+f6bF9tkUCQkjupb9s0=;
        b=rPvutsHIjPqDhDGHVJxc/wM5v7CXDtz6AAMW3V7N0WFLbcXp6VlPvu2+MuYojMLpu6
         GIM+7Cy5mjsqo+ICRC7VnG2x51YmptvQXPyPrl7hhAwbs8+Syc01kUyEuKHQy2xODowj
         4uNefQtC8cqbHjMEd99RGKqCK9x0frcN2G1H2KCct+NI2QxkRqKoeblxVWK4wnmFXuH9
         lR34nHkyF7KBoxhgHidVyqe4QOqy6qH/76EIM3dmZdaepccL+TUKbvmHW94HM9zZrz3w
         Z/EcBwAAiQgkZmdkpX5PUz5rw4h75HtAtgIpd+/TF+5MespBcPmDjg1ipd6NASc1bmFv
         JWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d2q16jUlTFF+PgCEeQltVe2F+f6bF9tkUCQkjupb9s0=;
        b=Xkle6D7DwbBTtBdpfwH9pSAxgrpacekNn2CbgZvtebVY0SlVbPCY4Yj9mNF1/6XZrW
         NhLI70LsTLbgytXX5XVT/MSp5v7A9HDW6M4jDQMyf1BxY/sxxClYdQSSGhxhfShm1lsN
         wc8N5eX8NCr7An2zomr7oTXyoaq0cNqgTWJbJPc+hrynngsuEI6HUMyEMuZARpIb/8Bn
         6LmA/aVT+G7vQh5p9ASBpZ9eGvPOu/6gwIcq0ILOypfKBiIWJEsil1YSZPS8cQB0v3Ar
         GkTgBEE2e0920u2v2c6iI6MpO5/UhAwpuesW9RdG5F8eOVye5N0fVtu2MuVlbUJHsG67
         HuQA==
X-Gm-Message-State: AOAM533oHZo/z6tf6/s6o8EPZ4xPt4SEiXnj0FoJhpJJNrBety/C9wn2
        8/idbvWfeR/myOKFLLLa2+Tukg==
X-Google-Smtp-Source: ABdhPJzCMbl2wASW0GAEU7dIZgfYB/lg8BCOSGP4JPjM9/s0k9fP4z8jGrPdqeSRqTlzzhtNgn5ZWw==
X-Received: by 2002:a63:5d59:: with SMTP id o25mr4757081pgm.322.1612991594307;
        Wed, 10 Feb 2021 13:13:14 -0800 (PST)
Received: from google.com ([2620:15c:f:10:11fc:33d:bf1:4cb8])
        by smtp.gmail.com with ESMTPSA id y67sm3278585pfb.71.2021.02.10.13.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 13:13:13 -0800 (PST)
Date:   Wed, 10 Feb 2021 13:13:07 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     "Woodhouse, David" <dwmw@amazon.co.uk>
Cc:     "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>
Subject: Re: [PATCH 5/5] KVM: x86/xen: Explicitly pad struct compat_vcpu_info
 to 64 bytes
Message-ID: <YCRMY17WEdpJYd3C@google.com>
References: <20210210182609.435200-1-seanjc@google.com>
 <20210210182609.435200-6-seanjc@google.com>
 <8752a59b694671d25308d644cba661c4ec128094.camel@amazon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8752a59b694671d25308d644cba661c4ec128094.camel@amazon.co.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021, Woodhouse, David wrote:
> On Wed, 2021-02-10 at 10:26 -0800, Sean Christopherson wrote:
> So it isn't clear the additionally padding really buys us anything; if
> we play this game without knowing the ABI we'd be screwed anyway. But
> it doesn't hurt.

Ya, this is purely for folks reading the code and wondering how 62==64.
