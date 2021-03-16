Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A11133DC3B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 19:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239893AbhCPSJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 14:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239907AbhCPSIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 14:08:41 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2C4C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 11:08:41 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id lr1-20020a17090b4b81b02900ea0a3f38c1so3999777pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 11:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tZy3IUpWZ7t7bh+2zyTwr3sKql3tBpCeQ+1BYTDB4w4=;
        b=NC/9oMaY8Rm9otFHqcm+jKoqM1GFXaA57RIG4D7TGgW0Ynol3+8lZ1Cz/YPTNl4cn3
         dR/GEOex4IJjjQRY3RNtZvhvCphxtHn7mf6HKKUmRNbkc6fUYrpiIhbpet4PaMVEzO0D
         uXcU+BxuI6FL+rQmCSAuks1hs726ONtkvPWmNdHJTTa3xlO+tvERAh0m8t/e+/AZE5xU
         Keq53AMaBAqnmLJGDMVWRTfBApKjjLuBtFjTxEJhjC9Njqw7fKZV0d4lnxr0juNjWQW4
         UlNX1J56TTSeoS2PLI/sv7TpdmRtNm/SOFdqPVY6o67cnU6F1ycD+5R8nADZHeUY7S3C
         kLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tZy3IUpWZ7t7bh+2zyTwr3sKql3tBpCeQ+1BYTDB4w4=;
        b=LSNLVnp2/euAtN0R9FBg4u4CNyFT3mPSmYK7bYogr0IbcZK6N4VbHl/19RhG0qg6Q0
         8xmqxV0VWwFZLG5dWcrPm3H3H9DExMUQb2BbCbXRO6+Y4hTn1zAzkLjJSCSryLhKQcrO
         TCzdOjwtd++huH++iejhGO8EJPP40936W4rkBisjzlQH7XAKsn+lKHvCwcxmmkKDg9Lc
         o04fiWZvNjgHwqkh2j3xGZbdzOly2MYUWjUqpu2y4qMK4Gdo593HFWmixnaM5RuxJK6N
         CYQfqqXbQf57E8GIz2Bg2n/yEHScu46kdao5VO9Sg0jklcjGDjYzuMih/2PfGsXUjsc2
         3PVg==
X-Gm-Message-State: AOAM532iXAnxoXVmSqQSo++zQSl6e4VWGLKljqSucC9STkAITHYZnhMu
        NhVCNSEWeU9YCb8wM0usctC6DQ==
X-Google-Smtp-Source: ABdhPJzp/t6b5YlCZLrR8WKN0/mxohDZtV728KX/QgOYC7i3LcivZg84bV6/Bihm8sRwIDS6odBvAA==
X-Received: by 2002:a17:903:18a:b029:e6:7fc1:1c2a with SMTP id z10-20020a170903018ab02900e67fc11c2amr705916plg.5.1615918121046;
        Tue, 16 Mar 2021 11:08:41 -0700 (PDT)
Received: from google.com ([2620:15c:f:10:e113:95c2:2d1:e304])
        by smtp.gmail.com with ESMTPSA id 205sm12606570pfc.201.2021.03.16.11.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 11:08:40 -0700 (PDT)
Date:   Tue, 16 Mar 2021 11:08:34 -0700
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Nathan Tempelman <natet@google.com>,
        Thomas Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steve Rutherford <srutherford@google.com>,
        David Rientjes <rientjes@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Ashish Kalra <Ashish.Kalra@amd.com>
Subject: Re: [RFC] KVM: x86: Support KVM VMs sharing SEV context
Message-ID: <YFD0IuaMACWZyGtG@google.com>
References: <20210224085915.28751-1-natet@google.com>
 <YDaOw48Ug7Tgr+M6@google.com>
 <CAKiEG5qtTbm8dtE3pZDy_rfSfTfvhCYhDCh2DD-uh2w6xZnvcQ@mail.gmail.com>
 <YFDwU3CC/DgRo6Vk@google.com>
 <df2e2cd9-18d5-f35e-6c05-5ba0c399ccbe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df2e2cd9-18d5-f35e-6c05-5ba0c399ccbe@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021, Paolo Bonzini wrote:
> On 16/03/21 18:52, Sean Christopherson wrote:
> > > I don't
> > > know that holding the fd instead of the kvm makes that much better though,
> > > are there advantages to that I'm not seeing?
> > If there's no kvm pointer, it's much more difficult for someone to do the wrong
> > thing, and any such shenanigans stick out like a sore thumb in patches, which
> > makes reviewing future changes easier.
> 
> On the other hand holding the fd open complicates the code, reference
> counting rules are already hard enough.

How so?  KVM already has to do "fget(source_kvm)", can't we just hold onto to
that instead of doing an additional kvm_get_kvm()?
