Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D8332438F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 19:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbhBXSIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 13:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbhBXSIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 13:08:41 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247A3C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 10:08:01 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id t29so1820866pfg.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 10:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tm7j2omSybNiiT8Csv1rxsiGhueuDiqHKYeICDRJGvk=;
        b=BXtD87R6wPqyE/17Z0OIrblukbmZY6FkHZPkucn8Jg0M37hYhwIGKd0D7XUX+qzhtt
         EG8xKa7/YlpUsnAQUFRlfUAglXql3VvGTUtlTrIPV2SDt8C53HJQTbTIuMIdGyzvGQgr
         eCzBon+W6CypQ+hvstnRkB5WVqy1KjXxa01Zm4bzvP32SN6ugbGKhh1PW7gh9SCZ6iAa
         3K+cmFVaVollNaPo90c7Z6IVWWmTaepR+/p6LPh3hvtbcRSusmhO1Em+TmM4+MlK1lo4
         8f6p6s3Tr5Ijm8RBmxR7wzd6XhWmtfqGopJ48a92Jm4eHiLBaZyZ/afaNZ/PS6rtCfLD
         d7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tm7j2omSybNiiT8Csv1rxsiGhueuDiqHKYeICDRJGvk=;
        b=cyv0/lpX+pIuenDDEhlOK5JJ/kHNBO4PKoyAcoM98i4YCP8whgat1S7dAIDleTg4t+
         x42mmqaIIxSgVZuH/efzavlhuurzjlxMtReZpn/Vv/I71Xzj0VfG2DnZn52pXf0skMfx
         QpGf+Uy4lu8zCWVAhe9bGznaye0f4s7NpsOXS+HiR6i/P8DYZ/YnuBpJ1qzfesfFwl8D
         fIeu1iij1FcwNgqaEtKPiPQO2fjFIq6NBy1nBdWGi9e4oORbsWbw+jUOhy6hefS3E5Xj
         D0qkkavNFmQci04DRBknvwpqUbOrYFFXXFXsuEMX8/lCH6CJG6sDRQdWguvQo/LI0ssk
         M7IA==
X-Gm-Message-State: AOAM530vzPbI6h0XZkArZ62T99CCvoJ8YCY08MvRWR42hv3vpxRu3hX+
        neqYscS3wmDmm8/Imag4JSqm+A==
X-Google-Smtp-Source: ABdhPJwnP8SclXDpGpjZzVqI/vtae4Z2PJ9dTLzKkzpDyC9Q5If7aIQKga+QnbliG4ce2R09tevDCg==
X-Received: by 2002:aa7:848b:0:b029:1ed:5cb9:9e61 with SMTP id u11-20020aa7848b0000b02901ed5cb99e61mr23553561pfn.41.1614190080532;
        Wed, 24 Feb 2021 10:08:00 -0800 (PST)
Received: from google.com ([2620:15c:f:10:385f:4012:d20f:26b5])
        by smtp.gmail.com with ESMTPSA id i13sm3427448pfe.46.2021.02.24.10.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 10:07:59 -0800 (PST)
Date:   Wed, 24 Feb 2021 10:07:53 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+42a71c84ef04577f1aef@syzkaller.appspotmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, wanpengli@tencent.com,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: general protection fault in vmx_vcpu_run (2)
Message-ID: <YDaV+ThL4c+vTo4e@google.com>
References: <0000000000007ff56205ba985b60@google.com>
 <00000000000004e7d105bc091e06@google.com>
 <20210224122710.GB20344@zn.tnic>
 <CACT4Y+ZaGOpJ1+dxfTVWhNuV5hFJmx=HgPqVf6bqWE==7PeFFQ@mail.gmail.com>
 <20210224174936.GG20344@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224174936.GG20344@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021, Borislav Petkov wrote:
> Hi Dmitry,
> 
> On Wed, Feb 24, 2021 at 06:12:57PM +0100, Dmitry Vyukov wrote:
> > Looking at the bisection log, the bisection was distracted by something else.
> 
> Meaning the bisection result:
> 
> 167dcfc08b0b ("x86/mm: Increase pgt_buf size for 5-level page tables")
> 
> is bogus?

Ya, looks 100% bogus.

> > You can always find the original reported issue over the dashboard link:
> > https://syzkaller.appspot.com/bug?extid=42a71c84ef04577f1aef
> > or on lore:
> > https://lore.kernel.org/lkml/0000000000007ff56205ba985b60@google.com/
> 
> Ok, so this looks like this is trying to run kvm ioctls *in* a guest,
> i.e., nested. Right?

Yep.  I tried to run the reproducer yesterday, but the kernel config wouldn't
boot my VM.  I haven't had time to dig in.  Anyways, I think you can safely
assume this is a KVM issue unless more data comes along that says otherwise.
