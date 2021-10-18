Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A37F0432428
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 18:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbhJRQwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 12:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbhJRQvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 12:51:51 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AB7C06176A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 09:49:39 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id u5so876309ljo.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 09:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4I627uhnu0l6CsStrUQD0qcPLTbLuImK7GQR0xuARyU=;
        b=bTQ/l7thnpCf+3XBgeoEy99+Jx2eLNTMHHdxyU+rsYPh2pW7uu493y7bPBt14/kk/b
         DhEEwrEMGfKDCBxjxIpShnDBFNcPbZe1tOuQSPn3M4sFPVDM1Nq53q91FUVH4wTKrzhL
         qYMdVyh/BQV1HDinfwjl+bMdWiNDmA7jJc3xNiPOBPvuBLXoSqByBqeVaW/YIAEUbUY6
         tOr462D/X315Y4lTKK/EogdCaZm/jHh9EVmzgPDypOQ/eJgJ96zPyDqmO5B0NBI73f3T
         xvGxjI7sCURnneEJDvLU9yMdEbSxXTpDyVYSGNlcI04D0a0Y96sDE0KcjVzA6Gn8CGVj
         h7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4I627uhnu0l6CsStrUQD0qcPLTbLuImK7GQR0xuARyU=;
        b=D2lcLKEycafJbUEQ3Z4WiCqYoU18soMzMoW+47bOD32kbC5yGTbVbpyBcmBFFxbcvE
         4ogYo6bwGSGM0p5kwkyJt01feAD7jt65esXydIjlrwDFWbO/XvwLXCCzclqPEhaNLoyu
         xpSdMuJcvvdGyFEqIsmwPvIEzNfDEsKupvYxOr7Ywardwj+TcVWmv8fg/sDYYA5frEv4
         tgzg6ornhXxvK0UQ5TIF32DEICxqBNy75CNtzzsQw6ZCZeGFq1UX3BlrB/EGlV4ZkOBG
         et6FohaHBN9xYouq6pz8ZqdkCSCuIJn9nj2NthzI2des+K4CGwKBASDs8BN5IUpnWlm7
         cmPg==
X-Gm-Message-State: AOAM5310OxUnFdgZ5l95GqdvJgwA9Y1rUPLXwtc3GD1z7JX+qFVaDTgG
        egRQk7f5yFo8LxzlnHLIfV1bag==
X-Google-Smtp-Source: ABdhPJyZvzR+2gRy/MnL+m5DOR+4Pa2s1F7QlitWLb8SxqUcdB7FQgrk2LqLvv4xciEtoihOaF6JJg==
X-Received: by 2002:a2e:9dc2:: with SMTP id x2mr869286ljj.253.1634575778198;
        Mon, 18 Oct 2021 09:49:38 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id r1sm1437231lff.73.2021.10.18.09.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 09:49:37 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id B412210309A; Mon, 18 Oct 2021 19:49:41 +0300 (+03)
Date:   Mon, 18 Oct 2021 19:49:41 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 2/3] x86/insn-eval: Introduce insn_decode_mmio()
Message-ID: <20211018164941.3nqq73pupep3cejz@box.shutemov.name>
References: <20211018153333.8261-1-kirill.shutemov@linux.intel.com>
 <20211018153333.8261-3-kirill.shutemov@linux.intel.com>
 <YW2YjRjUg8MzV0rJ@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW2YjRjUg8MzV0rJ@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 05:53:49PM +0200, Peter Zijlstra wrote:
> On Mon, Oct 18, 2021 at 06:33:32PM +0300, Kirill A. Shutemov wrote:
> 
> > diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
> > index fbaa3fa24bde..2ab29d8d6731 100644
> > --- a/arch/x86/lib/insn-eval.c
> > +++ b/arch/x86/lib/insn-eval.c
> > @@ -1559,3 +1559,85 @@ bool insn_decode_from_regs(struct insn *insn, struct pt_regs *regs,
> >  
> >  	return true;
> >  }
> > +
> > +/**
> > + * insn_decode_mmio() - Decode a MMIO instruction
> > + * @insn:	Structure to store decoded instruction
> > + * @bytes:	Returns size of memory operand
> > + *
> > + * Decodes instruction that used for Memory-mapped I/O.
> > + *
> > + * Returns:
> > + *
> > + * Type of the instruction. Size of the memory operand is stored in
> > + * @bytes. If decode failed, MMIO_DECODE_FAILED returned.
> > + */
> > +enum mmio_type insn_decode_mmio(struct insn *insn, int *bytes)
> > +{
> > +	int type = MMIO_DECODE_FAILED;
> > +
> > +	*bytes = 0;
> > +
> > +	insn_get_opcode(insn);
> 
> insn_get_opcode() can fail. Either you assume it's already called and
> don't call it, or you can't assume anything and get to do error
> handling.

Fair enough. I will return MMIO_DECODE_FAILED if insn_get_opcode() fails.

BTW, looks like is_string_insn() suffers from the same issue. Not sure how
to fix it though.

-- 
 Kirill A. Shutemov
