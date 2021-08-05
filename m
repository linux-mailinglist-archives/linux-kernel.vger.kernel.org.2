Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385B03E1F03
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 00:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241454AbhHEWpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 18:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241416AbhHEWpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 18:45:18 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8C4C061798
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 15:45:03 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id dw2-20020a17090b0942b0290177cb475142so18540748pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 15:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4BfhlnmFVBH/5WZ+qdtlmbrJsorAcYIvFXwLK0XohYE=;
        b=dv98SU3dX8RvvgAVciCvnnGdC9GdQBT286CvsF4rU/Akmb+g2mgUeL6+xZTH19oea+
         PnZBh41abYDMAqjnI9FTwv3orGtpr5ZlF6Oz4r/RkL+jkAalhQf8XE20g/a3UJUf4gLY
         hfyzyBdWheKYTHb9xX/jYAyv8xfKYxfl9z7yQuPHFBtm5In6vHlXrcgEGy/lFJxQq9VB
         oDspbK92DQPxh4tua6tBF6eu5oPbIZep2J9Nr2QYPTmTXwQ6vUFd+VzQb2c71QQYU3PU
         A30umMTNbWF3Fbp/2BRmhGpW/vzx9JMFjtQGysO9xL0mM6utCdWnsnhuiEOw1OjNOYjw
         HbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4BfhlnmFVBH/5WZ+qdtlmbrJsorAcYIvFXwLK0XohYE=;
        b=YGPu2Cn666+PA4ifWjjtCQvjnHv3HZwYgDFYgTx0FLGJiT9k0oGWDC5M1woxUtvhq3
         cLB2Cm9Q51CJUscAFYONzDK5JSmPGAkP0Smp09pd9zpkEhVXWFSeEjRUK2baUvDjbPF1
         IKFPiTbQHA4UYrJzeuSYXZUTsHPwYH1gmTs11rG1ZBSlqFdB9zux6jpVAmk62KRBNy+0
         z9JWgyKmMEavF2c7gHUAXBr7ATUuqbcjnZJQKYsCUdGIs1wK4dqKyv3ii5VaOIEqBDEw
         X0+ZzU/W2o42Yz+WRR7AdGik2GljrLWGouP99X2C/F+xmeDAUCIK0MeaQrzb54zhTR06
         Gqzg==
X-Gm-Message-State: AOAM5317qJHQK+MlBv1cyPlDnDWHzyFv08CiKsFQcNHW8kzWiaqM5wfi
        hp4dhIh+PgqJd2mVpjioOWWjWLzKuqQMVA==
X-Google-Smtp-Source: ABdhPJw4q5DAgxtnqJyDPEsfxXtC/QMaCaEKKBZ1CNwiagIlAz0LXZl+nmurr1SxbQ1y+AedALE82Q==
X-Received: by 2002:a17:902:bf01:b029:12c:d762:96c with SMTP id bi1-20020a170902bf01b029012cd762096cmr5872304plb.15.1628203503162;
        Thu, 05 Aug 2021 15:45:03 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id d2sm9146309pgv.87.2021.08.05.15.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 15:45:02 -0700 (PDT)
Date:   Thu, 5 Aug 2021 22:44:58 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     Wei Huang <wei.huang2@amd.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        vkuznets@redhat.com, wanpengli@tencent.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com
Subject: Re: [PATCH v1 1/3] KVM: x86: Convert TDP level calculation to
 vendor's specific code
Message-ID: <YQxp6gg4W/pZsGuW@google.com>
References: <20210805205504.2647362-1-wei.huang2@amd.com>
 <20210805205504.2647362-2-wei.huang2@amd.com>
 <CALMp9eQ_SHmFn0ahTyOnyk+JDs_D0qxN9Hc9VFMGDDixc13jUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALMp9eQ_SHmFn0ahTyOnyk+JDs_D0qxN9Hc9VFMGDDixc13jUA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021, Jim Mattson wrote:
> On Thu, Aug 5, 2021 at 1:55 PM Wei Huang <wei.huang2@amd.com> wrote:
> >
> > This design assumes that all x86 CPUs have the flexibility of changing the
> > nested page table level different from host CPU.
> 
> I can't even parse this sentence. What are you trying to say here?

NPT inherits the host's CR4, and thus CR4.LA57.  So KVM NPT is stuck using whatever
N-level paging the host kernel is using.
