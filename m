Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32901449886
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 16:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240977AbhKHPiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 10:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238707AbhKHPiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 10:38:00 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E399C061714
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 07:35:16 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 188so3103129pgb.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 07:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g+TozlKCVWdcHVzGWzpBk1sUQFToW4UpLiB6BmuVVDs=;
        b=I2tfnJ6LdUvapJ4sB79+ELNSXj7rrt0P5HulOe9k+SF2LYtAn9mrYcSHgDdU37/dxj
         Z2r7kXy+qb3sd0IZepoRvaGpF6bO0VAC0XwXClDM95sP4ZABB0lX9z+8sri0HCW/YPJO
         Sto/iaS/GHDKX7j15sDA4uY1kttrFfC9ZBc4GTg/T2YXCcvAiOU/Wi26VfccSOqPHVcw
         VM2l66O/4GXhR1rzsWaM6kFhRWfaExtCOKNn3YAoXc8kcYF+TLlQAbc9fOclmnhsJVZX
         XyvW9XUNjPH02Keaydvd7XBTUf/NcBjKL+Ryie7PJaXvG8iOz4UTMtqJWebViItKzbme
         Prtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g+TozlKCVWdcHVzGWzpBk1sUQFToW4UpLiB6BmuVVDs=;
        b=pWiv3fOqYd9kNurk+qfl2WrqRX+aBRAZOHAxr25uqi5K72jwjOeLRXL36rnjkPPWhi
         x67JaXvFbgMujD7Axum2bXEQndXlX0RwytTrCIKuWt7oBwz01xMdIn+uk6SQ6Gj+YCpQ
         2uFitAI0AABYWjr44XP0R3TRSvqt6iHOwv2rkHSXi3uqgRUObl9498pF/348Q63w/PDs
         FHNlJIwlKZ24MRRi5mYa4KVSsGDfxiFG7WLdULPW043ZRKmja0De7yoX5zwLnpU9slgj
         dqeNL2MDJhViMv8yia0yE0rccpHBBviOJ3Z+HCqWRM/G1X6aA8wdIUyIdi1wybQEVz7+
         +EYg==
X-Gm-Message-State: AOAM533CIStsWD6w32XgE+rGJWJTowaia6cCpRYX920HKY4F1GlNn+h5
        PRxcKBuAnkjzE1K5unpr8Dp1Kw==
X-Google-Smtp-Source: ABdhPJz/N2PKU0Wh+IpEZ/3JJyow3AdbpQWj07aBzUnRqbvMRZh153dSt+8IcFyWXGhPeZfTIBFr4g==
X-Received: by 2002:a63:8448:: with SMTP id k69mr244166pgd.298.1636385715575;
        Mon, 08 Nov 2021 07:35:15 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id b15sm16939315pfm.203.2021.11.08.07.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 07:35:14 -0800 (PST)
Date:   Mon, 8 Nov 2021 15:35:11 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Juergen Gross <jgross@suse.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: move struct kvm_vcpu * array to the bottom of
 struct kvm
Message-ID: <YYlDr2HLI/eULoDy@google.com>
References: <20211105034949.1397997-1-npiggin@gmail.com>
 <YYVElU6u22qxgQIz@google.com>
 <1636158401.g3t5cp0jke.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1636158401.g3t5cp0jke.astroid@bobo.none>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 06, 2021, Nicholas Piggin wrote:
> Excerpts from Sean Christopherson's message of November 6, 2021 12:49 am:
> >> It would next be possible to now make this a dynamically sized array,
> >> and make the KVM_MAX_VCPUS more dynamic
> > 
> > Marc has a mostly-baked series to use an xarray[1][2] that AFAICT would be well
> > received.  That has my vote, assuming it can get into 5.16.  Marc or Juergen,
> > are either of you actively working on that?
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=kvm-arm64/vcpu-xarray
> > [2] https://lkml.kernel.org/r/871r65wwk7.wl-maz@kernel.org
> 
> Seems like a good idea if it can allow vcpu structs to be allocated to 
> preferred nodes.
> 
> >> however x86 kvm_svm uses its own scheme rather than kvm_arch for some reason.
> > 
> > What's the problem in kvm_svm?
> 
> It embeds a struct kvm so it couldn't be variable sized.

Oooh, when you said "dynamically sized" I thought you meant

	struct kvm_vcpu *vcpus;

...

	kvm->vcpus = kcalloc(...);

Anyways, SVM and VMX are quite different despited both being x86, to keep them
separated without requiring an extra allocation, kvm_svm and kvm_vmx embed kvm.
Ditto for vcpu_vmx and vmx_svm.  Obviously not a hard requirement, but there also
hasn't been a reason not to do embed kvm/kvm_vcpu.
