Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85BE1311627
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 23:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhBEWyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 17:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbhBEOmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:42:54 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9232CC061756
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 08:20:17 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id q2so6299976eds.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 08:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AYwzbRa5m9CR2V97fKwgd6SE184J0tEf0fKut5hCaio=;
        b=EyKTyzJyAI27MO+T5sTWBERnkvFIc6IPenn/KaWQtRtXFBG/rO041a/UCR1Ex5VwIT
         3ytCUZ49tWW+raJDXBrWbQHEzu2p8+/I9m8viyg5cDqdNblIPpfheYcnOKfxrUga2WAu
         6ZpDOX/IOStaTNS7rcYt5S8902GXSv1sD3bFKL3L3YlhMoSQ6tFEaWSpMfhC07uG54Lz
         i12Hxzp67gH842Kgx6d2S55fjHYvO6JfRCOCFGgJXI4Rn3JnzJS6smDuZ5wpQRc5JuGh
         G56mKaLmOVm/nBgojCXESXUtV3+LyslDttNF7nTnn9RuSE4tw4DilwIGyQjlW/zdRRsk
         g6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AYwzbRa5m9CR2V97fKwgd6SE184J0tEf0fKut5hCaio=;
        b=k1lOM/BolcfNa9k3HdAK82hFQ+4bF+fATk5ao91MI06zmSZe9GwXnqmHllhStqNNXE
         kOI7GOHX0v9dWqaaGdgocVpEQrbtWj7bhf4Oodh+9kmQlksU0BADPrZfAetA5pkhAq/i
         ak7zl1xlV3jHquSUUYzKF2g2YpWZCZ9gCdyuU1DDQzecvVUtQ0y8qw+xxsyDilIxTkR/
         WtvP3CcnsnH5x2RjwQbSSftsp8G92ZBH7Nw/i4xffC57yvJ7M0wPihdYZylM5wRXsnTq
         sdnan8ZerO3VJfm/16IrRAhu/pQMVGDT7IwxDWq5+Rafgac3hqpWWuQOqs1cq++kRcZN
         TmFw==
X-Gm-Message-State: AOAM532rZJFvZcv3RAZ3iLFPKRwZbEIFYbHVSM1UFosRonH94zpWzMQG
        NSrXGopneTN8ncA3HVaDo3QUCnP6//UJ7g==
X-Google-Smtp-Source: ABdhPJz8hv3Ud1aRHT/p3WUU2NRog/gn/GZMtrUlhnToB+h37r4RAbY6EH/FBw1bXKvDPPMBAUZ34w==
X-Received: by 2002:adf:f303:: with SMTP id i3mr5330125wro.60.1612535812030;
        Fri, 05 Feb 2021 06:36:52 -0800 (PST)
Received: from p4 ([151.36.48.125])
        by smtp.gmail.com with ESMTPSA id c18sm23466763wmk.0.2021.02.05.06.36.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2021 06:36:51 -0800 (PST)
Date:   Fri, 5 Feb 2021 14:36:48 +0000
From:   Giancarlo Ferrari <giancarlo.ferrari89@gmail.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        penberg@kernel.org, geert@linux-m68k.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        rppt@kernel.org, giancarlo.ferrari@nokia.com
Subject: Re: [PATCH] ARM: kexec: Fix panic after TLB are invalidated
Message-ID: <20210205143647.GA7376@p4>
References: <20210201130344.GF1463@shell.armlinux.org.uk>
 <20210201135714.GB66060@C02TD0UTHF1T.local>
 <20210201160838.GH1463@shell.armlinux.org.uk>
 <20210201200734.GC15399@p4>
 <20210201201633.GJ1463@shell.armlinux.org.uk>
 <20210201202742.GA17243@p4>
 <20210204234841.GA19339@p4>
 <20210205001833.GE1463@shell.armlinux.org.uk>
 <20210205004050.GA3319@p4>
 <20210205094458.GF1463@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205094458.GF1463@shell.armlinux.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 09:44:59AM +0000, Russell King - ARM Linux admin wrote:
> On Fri, Feb 05, 2021 at 12:40:54AM +0000, Giancarlo Ferrari wrote:
> > Russell,
> > 
> > On Fri, Feb 05, 2021 at 12:18:33AM +0000, Russell King - ARM Linux admin wrote:
> > > On Thu, Feb 04, 2021 at 11:48:42PM +0000, Giancarlo Ferrari wrote:
> > > > Can I ask about having it integrated ?
> > > 
> > > Thanks for testing. Are you willing for me to add:
> > > 
> > > Tested-by: Giancarlo Ferrari <giancarlo.ferrari89@gmail.com>
> > > 
> > > to the commit log?
> > > 
> > 
> > Sure.
> > 
> > I have a question regarding the patch. I saw that the structure start at
> > the end of the relocation code:
> > 
> > data = reboot_code_buffer + relocate_new_kernel_size;
> > 
> > which means it overlap with the global symbol relocate_new_kernel_size.
> > I think is minor comment as the variable is only used in the fncpy()
> > then thrown away.
> 
> The same is true of the rest of the kernel image if that's how you'd
> like to look at it.
> 
> relocate_new_kernel_size is just there to tell the C code the size of
> the function, nothing more nothing less. It isn't there to be copied.
> The copied code doesn't use it.
> 

Yes, clear.

> > Something like:
> > 
> > data = reboot_code_buffer + relocate_new_kernel_size + sizeof(long);
> 
> No. That will place the structure after the size variable, which we
> don't want, and...
> 
> > and accordingly in the instruction (arch/arm/kernel/relocate_kernel.S):
> > 
> > adr	r7, relocate_new_kernel_end
> 
> ... we will then need to follow this with:
> 	add	r7, r7, #4
> 
> or replace it with:
> 	adr	r7, relocate_new_kernel_end + 4
> 
> so that r7 points at "data".
>

It was what I meant with "accordingly".

> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!

Regards,


GF
