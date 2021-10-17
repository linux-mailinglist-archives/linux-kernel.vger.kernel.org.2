Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29827430BBB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 21:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344519AbhJQT3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 15:29:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33884 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344515AbhJQT3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 15:29:14 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634498823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ikovorioz8gMBGU+W9S1DqGvKVHkmoozZpCXJ/7SMaI=;
        b=DtDXrNM48X1P21mUbkHaIIJVPfN6mSJSBvEAk7IbRNXwwAui7OVZYSpvtf412mwID+Uz2t
        IEFnrVThEE3ru84hAz+uUiMwSZmQ2tDTbrYaO8Qvsf5YjB/1IKepkwgRrnktvU56GK8249
        axUSDpydma0XzTJWt/ijho7VK/yGaGgwc8GoJ5Ig8owNoh31ntvUEU+R2G+x/3mjR9DP97
        /YbJV/wyFXJ0pt341VPDOkrfwbEhmYDiSw8yGP6fFunU9anu7D+aoRNkOlxjIBiwoAZXHH
        KPJaycv8N3QyOPl+J4d4Dc4IMHphgR4AHJCeOpROv9RqVNaODI8riuOSNXqthA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634498823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ikovorioz8gMBGU+W9S1DqGvKVHkmoozZpCXJ/7SMaI=;
        b=vkSfz2IdgstDleB7Vfhew1FOxT+FF2Gjrfe+XTcL4Gjh+3IvdwYZ+tlS5MyUv3utD4M8VJ
        IgxZoU+YYMA1lgDw==
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 01/10] x86/io: Allow to override inX() and outX()
 implementation
In-Reply-To: <20211005204136.1812078-2-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20211005204136.1812078-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005204136.1812078-2-sathyanarayanan.kuppuswamy@linux.intel.com>
Date:   Sun, 17 Oct 2021 21:27:02 +0200
Message-ID: <874k9f4fll.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05 2021 at 13:41, Kuppuswamy Sathyanarayanan wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>
> The patch allows to override the implementation of the port IO

git grep 'This patch' Documentation/process

> helpers. TDX code will provide an implementation that redirect the
> helpers to paravirt calls.

Thanks,

        tglx
