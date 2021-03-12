Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF3133996D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 23:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbhCLWEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 17:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235300AbhCLWEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 17:04:09 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079C1C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 14:04:09 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id t37so5937789pga.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 14:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A4VBsrBTExFTzIIWcPXbIbC/3bW0Rh8AXlm1Zd+kSVM=;
        b=NjH4RVnGKMIxKJmjG8GJYkllQ1jn5WinSXrj5QQRa9jO0Xde2Ix/dTfn+DGEgHo/+J
         e0AnLosaiKgvaYM4ekP9CXZF3svmwXDuzQFYggDL+Ia0bzzGNI9XWw767L0PyW5SdzFY
         AbLfmN3IgXG0tx+lK1z5UYKGYDDCHfa1lYjKyGaED/g9lgURliXZVPqWqGduEPxPSNq0
         MMH7EPiYVB2atFo59ii+Oix5uuvXOfQfvWuPo2eG3hdcApTsYAZPCBbBay6zHq+4TV/d
         NeKYqm6cF1nshehYoz+OGOSBt+Gwtut0ADAcVX9WPyp/b9NTw7VkOcrYyGTqeP0BbV6T
         T8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A4VBsrBTExFTzIIWcPXbIbC/3bW0Rh8AXlm1Zd+kSVM=;
        b=L0eb5HFTickLOCvrBMkRXHRS6VHaGvL3dq+ObsER9QKIexqbRWqtb+3DbdBEyAaz8j
         xRIJfHg6vmSbsuUH9W3kooBDYjBF6DDMbAcdOCIT1F3k/ugRHBdSoivx0VTgGA85r3+K
         MDrYQqQlChuqEOdyecv2JWHSF2F0LCk0l9T0Ip5Ea1Pl6ospMIRi32PgdwxXkanln2Be
         E0s6BwTwtw50DyQ4IAFMk2sKV52j1lg/t5LOabqln/agTRvt8Cmt8b446+RDMEKFrhph
         mkQeMhMBU12EFEIIluZ2b0w+u7SJHeo0naUmniBxYbbMUfD3umh6yUjDzl+IaWSXfYdV
         CNig==
X-Gm-Message-State: AOAM533n2V9d67RVlmsitMPOChTTF+xm2qouddzfkma/Bh3p7gPsD6lF
        LKo9M/a4CzpnKIfOisIPizf5+w==
X-Google-Smtp-Source: ABdhPJzlKX+1AMolFVpoKeUDirUHQ8igoQVFpdlwloDkDpmWVWtEkvEWq9iSY7yLrXxykyepl8xQIw==
X-Received: by 2002:a63:fd50:: with SMTP id m16mr13671152pgj.256.1615586648426;
        Fri, 12 Mar 2021 14:04:08 -0800 (PST)
Received: from google.com ([2620:15c:f:10:e1a6:2eeb:4e45:756])
        by smtp.gmail.com with ESMTPSA id i22sm3032705pjz.56.2021.03.12.14.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 14:04:07 -0800 (PST)
Date:   Fri, 12 Mar 2021 14:04:00 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>, Kai Huang <kai.huang@intel.com>,
        kvm@vger.kernel.org, x86@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org, jarkko@kernel.org, luto@kernel.org,
        dave.hansen@intel.com, rick.p.edgecombe@intel.com,
        haitao.huang@intel.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, jethro@fortanix.com, b.thiel@posteo.de,
        jmattson@google.com, joro@8bytes.org, vkuznets@redhat.com,
        wanpengli@tencent.com, corbet@lwn.net
Subject: Re: [PATCH v2 00/25] KVM SGX virtualization support
Message-ID: <YEvlUIOWGstrgh7H@google.com>
References: <cover.1615250634.git.kai.huang@intel.com>
 <20210309093037.GA699@zn.tnic>
 <51ebf191-e83a-657a-1030-4ccdc32f0f33@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51ebf191-e83a-657a-1030-4ccdc32f0f33@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021, Paolo Bonzini wrote:
> On 09/03/21 10:30, Borislav Petkov wrote:
> > On Tue, Mar 09, 2021 at 02:38:49PM +1300, Kai Huang wrote:
> > > This series adds KVM SGX virtualization support. The first 14 patches starting
> > > with x86/sgx or x86/cpu.. are necessary changes to x86 and SGX core/driver to
> > > support KVM SGX virtualization, while the rest are patches to KVM subsystem.
> > 
> > Ok, I guess I'll queue 1-14 once Sean doesn't find anything
> > objectionable then give Paolo an immutable commit to base the KVM stuff
> > ontop.
> 
> Sounds great.

Patches 1-14 look good, just a few minor nits, nothing functional.  I'll look at
the KVM patches next week.

Thanks for picking this up Kai!
