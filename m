Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED8DA43240E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 18:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbhJRQqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 12:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbhJRQqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 12:46:46 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDE8C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 09:44:35 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id r19so985277lfe.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 09:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QNd4qe7r1pVfeWleJwQ+iasgIvyYWjDm0X9Ho/W1Fgw=;
        b=RT2X8qC9E3920XoZnPvC5GUZyDlxzACvbcoZVXt/eNYIw2VoBlzCKY9BrjmqfoC/t8
         Ien32e7+noX2RRl5WMuMyL3Bn4fZaroRiXFjuxUtw0yQhxq+sd+mwzfb8XnNlBu1hX85
         jQuaRIlLiiklJA5PaCDrxN6mW/SkN/ijJeXVdZi0SyvTTuQnn08pLQqNNlRmHNKLHABh
         5oGs7npud0yR7ItgXhOn2C3zcsOTLFEiuiwIeHTbvo67Ac5bKzuyR/vSm7b8lCp0mYax
         C68mR5WdilUocg/XyvoYRZD1w1HaCEgEXribke5fyV467qnSBrcsGhkS18+zX387VdWa
         Pzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QNd4qe7r1pVfeWleJwQ+iasgIvyYWjDm0X9Ho/W1Fgw=;
        b=3yDAT7M7l548+/Kzu3qi9wk+pQE6AI8/Acir3eII5bvPlT/w34VRH9LuDRuzJXL1Fm
         Qxc3518VzeSCjYlRJJ630Nu/5JaEWPwnj4Rr1r1P7jlyYO4YRlqPMU2LJGjmaVZ54jc/
         pftnES5gM+NL09LzRkNO3Bq2QHAyucNCeczPDGTuXl1W1l3F+NlODjOPNSHFTNxF0Yyq
         jTQcGWeQLNVF/mgMXZq367pm9e0XPHoH8P9q9KjFzX1RQQKYvYvbEx/OtSfFHnlSyGPG
         S6tHb3yGqtUBdzNjmbLX8xiXIARNZKjazI8tfIUFp1xXBK7ExmcHJvPL/UPR9ZjUHxdG
         vXmw==
X-Gm-Message-State: AOAM533LIcoq44zjCUlO/kJyTX+p0KVEFaaDp2YUomg1F3isBvCE4k1/
        e9SLuJT4e6eaaJ9tXXe3Uq7dJA==
X-Google-Smtp-Source: ABdhPJz9wPyhUC9Qb8Q5ATOphjl0AgkGa+yiqsV/3V1Qv9MRlosFHrg2lA0pcrPi1Zo43zMEa3118Q==
X-Received: by 2002:a05:6512:36ce:: with SMTP id e14mr782235lfs.328.1634575473480;
        Mon, 18 Oct 2021 09:44:33 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id d14sm1544340lfb.210.2021.10.18.09.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 09:44:32 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 7D54D10309A; Mon, 18 Oct 2021 19:44:36 +0300 (+03)
Date:   Mon, 18 Oct 2021 19:44:36 +0300
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
Subject: Re: [PATCH 1/3] x86/insn-eval: Introduce insn_get_modrm_reg_ptr()
Message-ID: <20211018164436.saj47igl53bnd3r3@box.shutemov.name>
References: <20211018153333.8261-1-kirill.shutemov@linux.intel.com>
 <20211018153333.8261-2-kirill.shutemov@linux.intel.com>
 <YW2XBV2uHHDI2vq0@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW2XBV2uHHDI2vq0@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 05:47:17PM +0200, Peter Zijlstra wrote:
> On Mon, Oct 18, 2021 at 06:33:31PM +0300, Kirill A. Shutemov wrote:
> > +/**
> > + * insn_get_modrm_reg_ptr() - Obtain register pointer based on ModRM byte
> > + * @insn:	Instruction containing the ModRM byte
> > + * @regs:	Register values as seen when entering kernel mode
> > + *
> > + * Returns:
> > + *
> > + * The register indicated by the reg part of the ModRM byte.
> > + * The register is obtained as a pointer within pt_regs.
> > + */
> > +void *insn_get_modrm_reg_ptr(struct insn *insn, struct pt_regs *regs)
> 
> Doesn't that return type want to be 'unsigned long *'?

Right, will fix.

-- 
 Kirill A. Shutemov
