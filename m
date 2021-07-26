Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB003D6969
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 00:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbhGZVlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 17:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbhGZVlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 17:41:20 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17306C061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 15:21:48 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d1so6153241pll.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 15:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3ODcicexHURy+S/oaAgcJ5/PC6scXaOeWpaZLuQrIGg=;
        b=IAzkdNqPCe3UCa/Ivef3h6QOhsZcQ4xoUEUHk8FeitquYy68VmMEBlXDZhPoyNW2wC
         WKPCGzyk2t55n2cRxI7CvdMQCOrxKVTnx2le8z0LIAYPSdKQiqbyMjNijMulDmTM3+Hy
         aVhddjr1X9gKKoBMcPjGBdkbxYVs3s9ZIlRt2jI5yew+ENV1wzHYblng9navUwxi3w0s
         MnMXl6vr0Ja+qPp7HxIW7e99dDDWl2FYv8lHi4OK0KwPl8+9ZJAE4o1XMw1B+dG7a0W+
         bpAK73jUPDg8BqYnadcxMCmztL/T8dMw6BvIkzlDxUQigUtolFwEZHvzzwZqPMdEcrlR
         hhWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3ODcicexHURy+S/oaAgcJ5/PC6scXaOeWpaZLuQrIGg=;
        b=XBZtOz4JNgoJare7pZ0IF/uQQVdsKi9Nz/uhCfqXkw7BkWemRuxi/YzKejStWdho4h
         OcDR++isUEaB7i59jm0Awd/8h8t4GGY/USivZsNz88CSCfxetFQfc1e/tcF5T88coBYf
         gWZlxL8ViUFlEGLWVli/JSPtd9sCYihJY91nHgXU6cTgIZdj8P0gAOk8HfkCt7sHnlR6
         JbsV0cstiGTOAR+ucMW8yoCaU3RE0ndUmTfzOL+wOl+XIXFQ9vKeXdSpXIdrs+zXeCms
         KyzZXCQvLBqPlyCKGxXollMGlf99/UulT1Zl5PJv0ZwubFsY9/3+vBJwYBmMbw243Pp5
         wt7Q==
X-Gm-Message-State: AOAM5319k94h/JVYyMDxxEieLmQc7XUfQfJjo+VEe65OruKWPJGnRUZq
        8IpMfhlpWpZPNbkiG1+eRKVh0RuF0CjpAQ==
X-Google-Smtp-Source: ABdhPJyHjwnafAVBd3m1vItXPruoOWhlMHo9hLIAry+D18DIh0irNV1yEz7PtzB5CxwsQZzRhQJwjw==
X-Received: by 2002:a63:2355:: with SMTP id u21mr2182989pgm.94.1627338107450;
        Mon, 26 Jul 2021 15:21:47 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id g20sm1051906pfj.69.2021.07.26.15.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 15:21:46 -0700 (PDT)
Date:   Mon, 26 Jul 2021 22:21:43 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Reiji Watanabe <reijiw@google.com>
Subject: Re: [PATCH v2 41/46] KVM: VMX: Smush x2APIC MSR bitmap adjustments
 into single function
Message-ID: <YP81dzqaD//iNr5L@google.com>
References: <20210713163324.627647-1-seanjc@google.com>
 <20210713163324.627647-42-seanjc@google.com>
 <7ddb5bfb-f274-9867-3efb-0b6ba5224aa2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ddb5bfb-f274-9867-3efb-0b6ba5224aa2@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021, Paolo Bonzini wrote:
> On 13/07/21 18:33, Sean Christopherson wrote:
> > +	if (!(mode ^ vmx->x2apic_msr_bitmap_mode))
> > +		return;
> 
> Just !=, I guess?

Ha, yeah.  Forgot to do a bit of critical thinking after refactoring.
