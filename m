Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078C33701AD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbhD3T57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbhD3T5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:57:49 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0A1C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 12:57:00 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0c5700c52031cc761b260f.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:5700:c520:31cc:761b:260f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 836C81EC02E6;
        Fri, 30 Apr 2021 21:56:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1619812618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5FxCqAP5C1yOwn+gHliLIDnLy1eAr9ZCmwbDPrcWXuE=;
        b=rLOVoONOjx7G+tt1vqFbq6KkQJQbGzf6G3em5qSdzcj0NzQqQnC0+kd/F7iYZIrh1ni1PH
        ROkmTLWJvRTSEatuvzLksGGqt79GZo3sJ+jR0kxAnRt/AzO8ZLoAhkEq6eAMgLYQks6J4M
        3T4PyC7Xvfh0Yv+1cetfHTpJGmwtL5c=
Date:   Fri, 30 Apr 2021 21:56:57 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Reiji Watanabe <reijiw@google.com>
Cc:     Ramakrishna Saripalli <rsaripal@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, Jonathan Corbet <corbet@lwn.net>,
        bsd@redhat.com
Subject: Re: [PATCH v4 1/1] x86/cpufeatures: Implement Predictive Store
 Forwarding control.
Message-ID: <YIxhCSt6t5U/Eldb@zn.tnic>
References: <20210430131733.192414-1-rsaripal@amd.com>
 <20210430131733.192414-2-rsaripal@amd.com>
 <CAAeT=Fw-nt5h3DhRCQr8Ma71NiP7dHB+WD2hie_55SpCHR=mDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAeT=Fw-nt5h3DhRCQr8Ma71NiP7dHB+WD2hie_55SpCHR=mDQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 12:42:46PM -0700, Reiji Watanabe wrote:
> Then, it would be a problem if its guests want to use PSFD looking at
> x86_virt_spec_ctrl().

Well, will they want to do that? If so, why? Use case?

We decided to do this lite version to give people the opportunity to
evaluate whether there's a need to make full-blown mitigation-like,
per-thread thing like the rest of the mitigations in bugs.c or leave it
to be a chicken-bit thing.

So do you have any particular use case in mind or are you simply poking
holes in this?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
