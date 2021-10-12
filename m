Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A055A42B088
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 01:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235981AbhJLXrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 19:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbhJLXru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 19:47:50 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B92C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 16:45:48 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id q19so862986pfl.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 16:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kGrCFEvmDwzmMCFgiwQK2Fu/Htd7FjL447jdDDlA3/0=;
        b=KSPHpqdLMpzDQOY8+TY0dkrBtUaf7uS02AGot38TY0BJqCHLC1XkxJX7J2LkrJ+WRe
         ZK1ezihSRVNGnDhSyp30td1Wj2V4u8g2kIutXUbs6RQY9QHsHgCn2lp+CoYh28fHMeae
         2bVjdhzCz59VM39ax2whCMBBl/o1RWCYQHLCymCGUfwNHUnWXG+C/IBUy011W6Jo2xpA
         QNto5Lvj8De9K8kPfPv6nG7ejfdNPlua884xdttC+kpC4pcKfemifvL9cTp/M4rpqhaC
         QJ9j91XdjAK8JItjcw4VPL9F+BMFem+cirhYF3b84BZ951rNB8+NH9EYWFKzpYPI+U9t
         Nt7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kGrCFEvmDwzmMCFgiwQK2Fu/Htd7FjL447jdDDlA3/0=;
        b=gQeeJc58LdmZykY/fLToKG4l/VzL6WpA7saNvc1/blRY2FafePF4mFOMD2fyDw8C8F
         +mtrEu2HEtvLwwwDyWqoYzEZ2jc/edGtlhZIezdPu6Gb1jiceB4rwUW8dHlapFtbgPn2
         dkINh/kcCvVDqHlp4SM6QzctmlT1BNhJEW3W9puwHIvOV/gP6rdjNYo9TWaBrJ9bqyuE
         nAl+p1YcdKOmr5FrP88T74z6Dp3WMJWTWgZcFHm4WxtdWAcEDlQPDY7Kj+oN/HD1vd/O
         VOz+HwFc6edVNMSmMNt7i0GnpIuGWcbabvt6svadfCgwoXXdqd+wMD61IMpDVrkFwBr+
         FZwg==
X-Gm-Message-State: AOAM532UBd/1daAFVSPnfm6bClCHiYtl+g9vloOVpv7DmuKuBYcaNOYm
        ECTwJ3IGQtk3Zqb4BCV3XHLiXwucy7falA==
X-Google-Smtp-Source: ABdhPJy9XVNlxqT24XBgDLt+ANRPYg+iewIRXIW9CV3HPS/Hqj1EudpYV64XXM1AfIs1UytDttgtPA==
X-Received: by 2002:a05:6a00:8c7:b0:44c:a7f9:d8d1 with SMTP id s7-20020a056a0008c700b0044ca7f9d8d1mr34491782pfu.49.1634082347748;
        Tue, 12 Oct 2021 16:45:47 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id x9sm3929411pjp.50.2021.10.12.16.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 16:45:47 -0700 (PDT)
Date:   Tue, 12 Oct 2021 23:45:43 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     David Edmondson <david.edmondson@oracle.com>
Cc:     linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wanpeng Li <wanpengli@tencent.com>,
        David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v6 1/4] KVM: x86: Clarify the kvm_run.emulation_failure
 structure layout
Message-ID: <YWYeJ9TtfRwBk/5D@google.com>
References: <20210920103737.2696756-1-david.edmondson@oracle.com>
 <20210920103737.2696756-2-david.edmondson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920103737.2696756-2-david.edmondson@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021, David Edmondson wrote:
> Until more flags for kvm_run.emulation_failure flags are defined, it
> is undetermined whether new payload elements corresponding to those
> flags will be additive or alternative. As a hint to userspace that an
> alternative is possible, wrap the current payload elements in a union.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: David Edmondson <david.edmondson@oracle.com>
> ---

To complete the set... :-)

Reviewed-by: Sean Christopherson <seanjc@google.com>
