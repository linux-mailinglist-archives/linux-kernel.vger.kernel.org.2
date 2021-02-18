Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7FD31EFB3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhBRTVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbhBRSNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 13:13:34 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC15C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 10:12:49 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id fa16so1826531pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 10:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hheNEp5dx5AnWKR3IP8g8xUPkPU2XBDlp3985GUBpBc=;
        b=NNHyYZzmQH4PjkIOq4/kMBbz9miG8ulGHMIUqyJ2BdC4gjJgnU/pJ/+wiorwUHtZ8K
         f4xJ7K1DG/4HY67O1C3rGwRdEamD31HJwJsvhU4bQqCM2pDRr7AI8vOCbQfoiqyLU7RL
         MX8TVeqrRULZv/UCU3UgEdFe/r2g/x4dVu5nEs8BFx+9IZK6F1q6WdbFY9zDc3poKltQ
         PpO1cNWiNoxuzhhKy8t+hmmml+CF7Fbnbnt1YND8PYi93yL81YBcDOx+JDxqCWxflzX3
         NtPfLDDeqdsPBz3QcSw6iuaXy7/+GEbUhG2P2pSu6T4/XYQa0uSAHdGCCxavo3DeVUXs
         90tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hheNEp5dx5AnWKR3IP8g8xUPkPU2XBDlp3985GUBpBc=;
        b=W8gDMXkLhN1QhoVkdRW1i2VJticr3X8j9eP9cibHnMetfNh3GO+0Mx5RJiJQsLrofa
         ndVrdvC8BgQCxQyBIyVpUM5fqldb4u6RRvjYAfjNSgfd4CNIlbSSN+09QSVOkZeqwuJp
         BIMGU1FZU7aRnH7SeTDgjh2k6mn0vPfOh1aRLW4DEKXG84JDFZ/PNeQsheSZYCuPsyC8
         Evai1jTEWAxJ5RXkAa0gBES0nFVzIKZp2eyBADaMxTCLZieU6lUwCwSrCnEml429X7A6
         NT7iph19ZH4IvSoWlHd6Pmz91vRE5ttwTKG5Q9vRmj1S9OP99W6+YGQoVUyhn4GmpJAy
         rVwg==
X-Gm-Message-State: AOAM533bZtPYA4IVntr72biQkRDq8N2v9n69ns3tQ1k0SwSzs3kXyfN4
        j1U/pM+vOlg6ynax7Psv8VO8dQ==
X-Google-Smtp-Source: ABdhPJzTEwLswcqc4aUhyCQTEkFGiMOkDcsmGhm57tzG5EYMblcyp/h7MugVgyRQI+tTO0zRlG5Tiw==
X-Received: by 2002:a17:90b:e83:: with SMTP id fv3mr5187147pjb.204.1613671969122;
        Thu, 18 Feb 2021 10:12:49 -0800 (PST)
Received: from google.com ([2620:15c:f:10:dc76:757f:9e9e:647c])
        by smtp.gmail.com with ESMTPSA id c18sm1298598pfd.0.2021.02.18.10.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 10:12:48 -0800 (PST)
Date:   Thu, 18 Feb 2021 10:12:42 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org, jroedel@suse.de,
        mlevitsk@redhat.com
Subject: Re: [PATCH] KVM: nSVM: prepare guest save area while is_guest_mode
 is true
Message-ID: <YC6uGgKgImRnuhTA@google.com>
References: <20210218162831.1407616-1-pbonzini@redhat.com>
 <YC6m8xoRUDtn3V+y@google.com>
 <cf1b338c-68bc-6e7e-1a10-98bc653d34ce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf1b338c-68bc-6e7e-1a10-98bc653d34ce@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021, Paolo Bonzini wrote:
> On 18/02/21 18:42, Sean Christopherson wrote:
> > > The bug is present since commit 06fc7772690d ("KVM: SVM: Activate nested
> > > state only when guest state is complete", 2010-04-25).  Unfortunately,
> > > it is not clear from the commit message what issue exactly led to the
> > > change back then.  It was probably related to svm_set_cr0 however because
> > > the patch series cover letter[1] mentioned lazy FPU switching.
> > 
> > Aha!  It was indeed related to svm_set_cr0().  Specifically, the next patch,
> > commit 66a562f7e257 ("KVM: SVM: Make lazy FPU switching work with nested svm"),
> > added is_nested() checks in update_cr0_intercept() to merge L1's intercepts with
> > L0's intercepts.
> 
> Yeah, the problem is I don't understand why 06fc7772690d fixed things in 11
> year old KVM instead of breaking them, because effectively this patch is
> reverting it.

11 year old KVM didn't grab a different VMCB when updating the intercepts, it
had already copied/merged L1's stuff to L0's VMCB, and then updated L0's VMCB
regardless of is_nested().

> I don't care _that_ much because so much has changed since then; the world
> switch logic is abstracted better nowadays, and it is easier to review the
> change.  But it is weird, nevertheless.
> 
> Paolo
> 
