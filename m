Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4B535F872
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 18:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbhDNPxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 11:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352535AbhDNPv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 11:51:57 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCE3C061346
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 08:51:30 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso12742050pji.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 08:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fWTfBwhTBFykGiu2dJZUXA73h5DF2jNYyWILelcjCss=;
        b=CFA/7opwET+k+CkWLRylF35NIqQ0lptLoj4zlqd4GJRMkCn1aBrIxS+E0C63Mt2RRX
         prqoK+tBeeWTPQrLN+ZPAbfrGPPu3LWMGB+sXDWw0yfsul03W1fH+z4bVRl5xdAZscJ1
         V3koDyPyoBAZcNcSeiuzu0pja/ZMDCyhJbLdzFUMEXX90TxZo4bUVB3HfFF1GqEDR5hc
         rv6PlBv2K9/Si94ULnlv/CU3Iw+3NpmGy3QXIEejtkw5R5rK168loJIu2bxTbqTyyhNx
         NHOd4+D7g4CwXMWtYevoBXRY68QSPEaF1cxR4eBk2ouewUNRzvhUAvJIiaHDN/AE1XT6
         NnBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fWTfBwhTBFykGiu2dJZUXA73h5DF2jNYyWILelcjCss=;
        b=pcXnKYoS4/AOIVMnxCkPtMQn4k1cpDZ1vFl+KFJffaMidDYTXWF6meYnsMeRo4fktv
         v2sF9CgciUBT1PsBpunWQScwLFqn3YlrEYnrIl9BVakQFDFKZIHcqZNmP8w3PG/mXLBV
         8NIfPMPuf3NKCeZB8AlFz+Wa54tJl5XIbGgYUuaH5zzSbdwTQ7tcl3ZasHf3o/DZp7Xd
         cO8VDbIOaholDGYmLzFlv0u4jPmkJnk9xY9GcGV0noU6xmycNiZBqYWk32XJ8Bw4UVvO
         R/DqF2+hMY/12ChoqkCdnW0UnXqXJpIykVHwMnhZxtizPP1PseqkHsQgnbsVfikL010P
         OYsQ==
X-Gm-Message-State: AOAM532AD1iTJuv/Xb0O8QPyYkyNMShD+BPhIXBOCE+134K+UQbeixXV
        7ys93AubZYIEoOmtc/SyRxoT+A==
X-Google-Smtp-Source: ABdhPJxN8qkEtKV5OE7Nm+uT6kF+BbXMmPzqy99b5bxZ9iI9qlaGB4po76jLI9QjL4beUR/E7Xiugw==
X-Received: by 2002:a17:902:bb91:b029:e6:bc94:4899 with SMTP id m17-20020a170902bb91b02900e6bc944899mr38307640pls.25.1618415489902;
        Wed, 14 Apr 2021 08:51:29 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id w3sm5064306pjg.7.2021.04.14.08.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 08:51:28 -0700 (PDT)
Date:   Wed, 14 Apr 2021 15:51:25 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Haitao Huang <haitao.huang@linux.intel.com>
Cc:     linux-sgx@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        dave.hansen@intel.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Jethro Beekman <jethro@fortanix.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8] x86/sgx: Maintain encl->refcount for each
 encl->mm_list entry
Message-ID: <YHcPfRqKCx+KXwoJ@google.com>
References: <20210207221401.29933-1-jarkko@kernel.org>
 <op.01te3jzwwjvjmi@mqcpg7oapc828.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <op.01te3jzwwjvjmi@mqcpg7oapc828.gar.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021, Haitao Huang wrote:
> On Sun, 07 Feb 2021 16:14:01 -0600, Jarkko Sakkinen <jarkko@kernel.org>
> wrote:
> 
> > This has been shown in tests:
> > 
> > [  +0.000008] WARNING: CPU: 3 PID: 7620 at kernel/rcu/srcutree.c:374
> > cleanup_srcu_struct+0xed/0x100
> > 
> > This is essentially a use-after free, although SRCU notices it as
> > an SRCU cleanup in an invalid context.
> > 
> The comments in code around this warning indicate a potential memory leak.
> Not sure how use-after-free come into play. Anyway, this fix seems to work
> for the warning above.
> 
> However, I still have doubts on another potential race. See below.
> 
> 
> > diff --git a/arch/x86/kernel/cpu/sgx/driver.c
> > b/arch/x86/kernel/cpu/sgx/driver.c
> > index f2eac41bb4ff..8ce6d8371cfb 100644
> > --- a/arch/x86/kernel/cpu/sgx/driver.c
> > +++ b/arch/x86/kernel/cpu/sgx/driver.c
> > @@ -72,6 +72,9 @@ static int sgx_release(struct inode *inode, struct
> > file *file)
> >  		synchronize_srcu(&encl->srcu);
> >  		mmu_notifier_unregister(&encl_mm->mmu_notifier, encl_mm->mm);
> >  		kfree(encl_mm);
> 
> Note here you are freeing the encl_mm, outside protection of encl->refcount.
> 
> > +
> > +		/* 'encl_mm' is gone, put encl_mm->encl reference: */
> > +		kref_put(&encl->refcount, sgx_encl_release);
> >  	}
> > 	kref_put(&encl->refcount, sgx_encl_release);
> > diff --git a/arch/x86/kernel/cpu/sgx/encl.c
> > b/arch/x86/kernel/cpu/sgx/encl.c
> > index 20a2dd5ba2b4..7449ef33f081 100644
> > --- a/arch/x86/kernel/cpu/sgx/encl.c
> > +++ b/arch/x86/kernel/cpu/sgx/encl.c
> > @@ -473,6 +473,9 @@ static void sgx_mmu_notifier_free(struct
> > mmu_notifier *mn)
> >  {
> >  	struct sgx_encl_mm *encl_mm = container_of(mn, struct sgx_encl_mm,
> > mmu_notifier);
> > +	/* 'encl_mm' is going away, put encl_mm->encl reference: */
> > +	kref_put(&encl_mm->encl->refcount, sgx_encl_release);
> > +
> >  	kfree(encl_mm);
> 
> Could this access to and kfree of encl_mm possibly be after the
> kfree(encl_mm) noted above?

No, the mmu_notifier_unregister() ensures that all in-progress notifiers complete
before it returns, i.e. SGX's notifier call back is not reachable after it's
unregistered.

> Also is there a reason we do kfree(encl_mm) in notifier_free not directly in
> notifier_release?

Because encl_mm is the anchor to the enclave reference

	/* 'encl_mm' is going away, put encl_mm->encl reference: */
	kref_put(&encl_mm->encl->refcount, sgx_encl_release);

as well as the mmu notifier reference (the mmu_notifier_put(mn) call chain).
Freeing encl_mm immediately would prevent sgx_mmu_notifier_free() from dropping
the enclave reference.  And the mmu notifier reference need to be dropped in
sgx_mmu_notifier_release() because the encl_mm has been taken off encl->mm_list.
