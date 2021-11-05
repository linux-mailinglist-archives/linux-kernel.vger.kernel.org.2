Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E9E445D24
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 02:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhKEBDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 21:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbhKEBDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 21:03:15 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F141FC061203
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 18:00:36 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id g18so2652513pfk.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 18:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5AsWWG+WUfnRqvVdyPwSZBhohM0u6yD1mbjUY07UvQQ=;
        b=Wj40ttb1/f0Ni3Dpwwh7PGzp2tLlAieYFhg2e0JliymKZdTTkMOcSEFRRoj+Ib0ovO
         53a8oGpagVSYUJ2EDzfDDMIP9dWw7v7B6SHv6tNJRlIK2c2wAsMmoveDumSYQQWtrm0y
         fINgTFun54Lvd9P5jVSwIoRUGiJb0PDOsFmY5eYpvPq+1A5s3xnewtCOeh602K0Ix6OY
         LCTuOpJR0j4R+24aoLXoAJkaZx76qgAUcjqhhIUgUk3vx4s8LYpJi/jc4v9cwC5PJ7Rx
         twcjNa8a3sVZtUSwK+fqkt9ljf5nSGpfX14uoZXp6nNjdc4ZEuLWQUeADLbXImDG0gPK
         1lcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5AsWWG+WUfnRqvVdyPwSZBhohM0u6yD1mbjUY07UvQQ=;
        b=PmYhbmuLFD4r/LSvo4D+mA+e+cSFH0/3s8CJD3FEDAPqf+MRhxxrJ78FAUMzXn4TZC
         uNEk94z8hi5KxzWu7cqqZvrtd16UCy8l3gSglUgsh/YJxy1/5i6TNDp9bAmtefykkGAM
         X3FWH9iCSbXyi3c5n+A4ePLWTrePmPqOc+lmQf+MZ4bnReI2gUzj+8yRYwYJ7xWb9gdf
         7pA1NRwyxbTiY8yTAnpQgZYNqh/SYcD5KcJcgDzige+qFk5AwlleGj5onDh5qkvbZJ2a
         /rBiT0fqXGYc3z1Mx2wvyZEbcvTq8vq6bOYlC1iqArr7bpB+z6mrpeozUBvf3+W6ERHO
         nXXg==
X-Gm-Message-State: AOAM530s5k/0PePXK/Wso7szFrX0F3gBdMCsgD9ERWTwBjasxctmrlMz
        E5wIZ4wteac8oQE+/sPVEF5LOA==
X-Google-Smtp-Source: ABdhPJyExLrTk4AQNxZbAzjzFbNCCrY3MFN/MzFs3b2RpbUmtepP+C6fRZhxyvs07zJxE6TSksmFCg==
X-Received: by 2002:a63:1d53:: with SMTP id d19mr41014133pgm.85.1636074036255;
        Thu, 04 Nov 2021 18:00:36 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id m10sm5124833pfk.152.2021.11.04.18.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 18:00:35 -0700 (PDT)
Date:   Fri, 5 Nov 2021 01:00:31 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] KVM: VMX: Introduce vmx_msr_bitmap_l01_changed()
 helper
Message-ID: <YYSCL2dum2be1rei@google.com>
References: <20211013142258.1738415-1-vkuznets@redhat.com>
 <20211013142258.1738415-3-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013142258.1738415-3-vkuznets@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021, Vitaly Kuznetsov wrote:
> In preparation to enabling 'Enlightened MSR Bitmap' feature for Hyper-V
> guests move MSR bitmap update tracking to a dedicated helper.
> 
> Note: vmx_msr_bitmap_l01_changed() is called when MSR bitmap might be
> updated. KVM doesn't check if the bit we're trying to set is already set
> (or the bit it's trying to clear is already cleared). Such situations
> should not be common and a few false positives should not be a problem.
> 
> No functional change intended.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
