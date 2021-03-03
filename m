Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA85332C0EA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1837161AbhCCSsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbhCCSGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 13:06:34 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2612C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 10:05:48 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id s16so14470074plr.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 10:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fi0uubBVxUB+GuaJG69hF0VmSki/WHsri58nDTTvB9Y=;
        b=OFBbBC/qbuy5DVoTDWKAbIz+evhGUmngQud/1bqxDNXQEMNT1ErJvyZdetAQssoB8V
         w90jHsRqLy9ZJSBFSa+8YaMR4VBwhokSubrPfwfc6sNsr8FJIuLYDZpySkq1zP41xDnZ
         ip2zGb6V2byY+jXHnsndQTTEFE8/Tkpl2L9qre4GYYRNyqAoy5BBZyRl4O92ksTIFGBJ
         G9FEdYtOgCzXoKEhJDyaxoVLZFt1ZeBUbxYTl3ZBLJcV4/nsZDEFUuz3mPNBmUAFxpI+
         vSVXnOT4C6hp/vgs84OQhAzwiCVq02aEmot3yZxZPF0CB9xYwNEi4d53jTJXAPBnRwg6
         ws4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fi0uubBVxUB+GuaJG69hF0VmSki/WHsri58nDTTvB9Y=;
        b=Px98NKCKXWvvvoHyDiahRZaGg0kVfNpiySjM1NC4gVjZE3o2Z7DOQSraY0BgepM6El
         t+XMf2+PInQCHdxokDvGB7K2WGlHx2r3x1Kw2o4RoG03Jhjt/YcvXzZMwDo3/2+anV3+
         FljuFu18VyqXq4/1GHbE8lfbgRO07hpPdjmugoJBmT3MR+aMMx3uPAeaLoZ2ikTjwjWU
         K262qpTAU1n8+Uw3Tk4Xzk631f1PE5kAOS5aqau9ektIbWLOvagaf0ICCtsf8Oztq2PH
         YiSYSS89r1YMkrICqjyZyKdnGGwNu1AYTRLYBrrsDxVm7m7G8VBdcPBZ3BF0C+HT5JIG
         J1ig==
X-Gm-Message-State: AOAM530587rBVnVTnIVVKeB7t2n8/rsxhrQqQWnMQ0zIBeztc7pfQLlp
        5gkKM0xYCFPDdb4yCftIE6sKkA==
X-Google-Smtp-Source: ABdhPJxbC8wsZPd378cO0hva1cNnbCyc3RT9K0geIiwmjepkvWVRMfJGjacgj5mU/jhfb3+1+7+USw==
X-Received: by 2002:a17:902:108:b029:e4:9e1b:b976 with SMTP id 8-20020a1709020108b02900e49e1bb976mr191625plb.67.1614794748200;
        Wed, 03 Mar 2021 10:05:48 -0800 (PST)
Received: from google.com ([2620:15c:f:10:805d:6324:3372:6183])
        by smtp.gmail.com with ESMTPSA id z12sm7329506pjz.16.2021.03.03.10.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 10:05:47 -0800 (PST)
Date:   Wed, 3 Mar 2021 10:05:40 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>, wei.w.wang@intel.com,
        Borislav Petkov <bp@alien8.de>, kvm@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [kvm-unit-tests PATCH] x86: Update guest LBR tests for
 Architectural LBR
Message-ID: <YD/P9EkihjNHqrLb@google.com>
References: <20210303135756.1546253-1-like.xu@linux.intel.com>
 <20210303135756.1546253-11-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303135756.1546253-11-like.xu@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021, Like Xu wrote:
> This unit-test is intended to test the KVM's support for the
> Architectural LBRs which is a Architectural performance monitor
> unit (PMU) feature on Intel processors.

These really need negative testing, especially on the MSR values.  IMO, negative
tests should be mandatory for merging arch LBR support in KVM, it shouldn't be
too much additional effort.
