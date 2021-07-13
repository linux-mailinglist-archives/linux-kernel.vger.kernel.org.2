Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D922C3C77F9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 22:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235060AbhGMUbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 16:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhGMUbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 16:31:24 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42E9C0613E9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 13:28:34 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id c15so23343pls.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 13:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LxJNrLcxo+1XG3xReG2GznPJ80Kx/41M8LyFkMVe9nw=;
        b=LVyHap2ItF10BDhXeoGpLsMsy+Kpnq9zg/VQMqQpe+4mMVxsfeZi19ErCqjwPe5z8q
         HQKrMF+TJEetLHunq9crVxN3cFqO1Vh3hVt9uMxSyRt1oCmdGtQmEYiaPNtMFG1dOLhS
         0PKdV6y+2xXlS371/sZsYdffhk5gU3LcuI8g1Ew7QtwKPbNT0t6ERuHwMATY7aMc44Ah
         +qPzcshSyQD404qt0kkXjBvA+3TvfjlwyceRHG+x/Ys3h6E1VlDvQry4y3lJPZGMrQ2n
         Ura6G70OULrhe4kwCL1L2LDG8QToCyDlW791EVIza0Ew0evTCVTlTbdJYlnyCCpXw2bs
         RTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LxJNrLcxo+1XG3xReG2GznPJ80Kx/41M8LyFkMVe9nw=;
        b=bkK74wQhw1lENQFaCfyj1ixVLMxUAhPUy9KjW1vAhTKgOHD+WLfU3lmjNE5Ro0vFQ5
         eLftImthejoLXeE/t9j9eV3i6hc2wEnE+2fGcxNtaG36SDe+m2lNEpiqwMfYmAQXYshS
         vxE9V3SFjrsrK3t3WJqux4I6TN7Xfa34VhJW/ZZlRyaLHl2C0342q9dMAv+ewpUALgFv
         m3cgckf8IK6RbIpbBxlC0cKeVwZrvxJTuZ0DUN1tLQOMb0vwzOIM5/8MUexRYymZmrZA
         YqdtMz6P0cJm7zs0H7hu9rfQ/VRdva+QBNxkZht+aEn5q94rnVM4M+VH552zBIrjljF5
         vO6A==
X-Gm-Message-State: AOAM5332FqqOE8f5faCRo652BR1ix0MCRGXOKZ5nBDdKeaEtJpizVT2M
        9lGoSdhHzUSgU/w+JzQttB9yGA==
X-Google-Smtp-Source: ABdhPJyX+I+K9qk9PMf8bCXNz0VTk1pIktY4RsEHVeMVTqDe/l6s4cyo0FaDlkFoCm8rvOHptNsbJQ==
X-Received: by 2002:a17:902:bcc7:b029:12b:32c5:3d31 with SMTP id o7-20020a170902bcc7b029012b32c53d31mr3245556pls.55.1626208113905;
        Tue, 13 Jul 2021 13:28:33 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id u24sm32501pfm.141.2021.07.13.13.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 13:28:33 -0700 (PDT)
Date:   Tue, 13 Jul 2021 20:28:29 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     isaku.yamahata@intel.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, erdemaktas@google.com,
        Connor Kuehl <ckuehl@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        isaku.yamahata@gmail.com,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [RFC PATCH v2 20/69] KVM: x86/mmu: Mark VM as bugged if page
 fault returns RET_PF_INVALID
Message-ID: <YO33bT2q3AfTspcO@google.com>
References: <cover.1625186503.git.isaku.yamahata@intel.com>
 <298980aa5fc5707184ac082287d13a800cd9c25f.1625186503.git.isaku.yamahata@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <298980aa5fc5707184ac082287d13a800cd9c25f.1625186503.git.isaku.yamahata@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2021, isaku.yamahata@intel.com wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>

For a changelog:

  Mark a VM as bugged instead of simply warning if the core page fault
  handler unexpectedly returns RET_PF_INVALID.  KVM's (undocumented) API
  for the page fault path does not allow returning RET_PF_INVALID, e.g. a
  fatal condition should be morphed to -errno.

> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> ---
