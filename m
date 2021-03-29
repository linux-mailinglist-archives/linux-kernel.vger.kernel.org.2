Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC2834D52F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 18:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhC2QdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 12:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhC2Qc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 12:32:59 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1A5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 09:32:58 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id c3so12987346qkc.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 09:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FOBL3ZFQ5b6OM63+WUNjAHGV83p89hgY2MMNXRflcDg=;
        b=O1KhHYEPWPUvw108Sw1XrkApxY+5E6YHGiseIrDfV/X/H8ZSAK9kg+zgfa2R0XWqXe
         cZHo70SreNq3VG6J/GD9iSawUckpfq2KwJ8QJ1jRA7SdgvPopWA57X4Vg32XOeKgI6z7
         a412BklN9GLRehohoHON0Nf/S+ufESo8lGloEfgAtE4bkNe7x13JSRSpHrYkmejy8/y+
         TkoFk7jYPKAJBFadpvfxhsyneIQSPqO7c5/NijtmWrhJupp3f++jAqutX5q4IKFbhyO2
         n/os6+LGU77GHSB0Jzzs3nlp71m9Y0eLh4QhkpeKQvzNCWiVTmYB3RXtfWM2ovCn7+XN
         u/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=FOBL3ZFQ5b6OM63+WUNjAHGV83p89hgY2MMNXRflcDg=;
        b=QQYlV9LjF8elT5EBF1bUY88SZxuJJggnRYrR3bDEahS9iUSviBI1CgNQkMYa/VWzub
         3UEvRFj4xbhdWPwzSNVm4btAHocxaYjec3WPmdsOu+bf1rzyhtpIvTxoy936pvhzlFjg
         2S/6Dr0hZSVFLF3GDJl45UBCLkZ8VKx4PBX/yOeOdhIjnE6HlKqeS7zKVrT0iCR042Lr
         MRrUuu1oXt9kHJD2bijQcEg8WBI6Mp0xRDgC8SK5r8olZ93pGPYkr5iBrnGESu9bBdS6
         gkaNutNWjdR6S8+BjKPeJE8nSXv8287DHWqVHjZRfJCEHF13+NuyJW6SlD0A9glUtuIq
         at1g==
X-Gm-Message-State: AOAM5301v2s8OgDxMbmOIfwunJgAhrjj39HkjKU+rar1+E5+wzgh/C+W
        LSTGdv28uxAuLMLylSu+xXMTlnbFuQ69uq1c
X-Google-Smtp-Source: ABdhPJy+xpPpC76/F19mJxHs27AzYDbrdsBPbSKSyY/9wpGdceXMW927kmwRgVdeU8epWMmKg/GcDw==
X-Received: by 2002:a05:620a:2095:: with SMTP id e21mr26138181qka.135.1617035577517;
        Mon, 29 Mar 2021 09:32:57 -0700 (PDT)
Received: from ubuntu-mate-laptop.localnet ([208.64.158.253])
        by smtp.gmail.com with ESMTPSA id k138sm13330185qke.60.2021.03.29.09.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 09:32:57 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     geert@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] lib: fix kconfig dependency on ARCH_WANT_FRAME_POINTERS
Date:   Mon, 29 Mar 2021 12:32:52 -0400
Message-ID: <4773905.PvQZvdar3e@ubuntu-mate-laptop>
In-Reply-To: <87lfa7ved3.fsf@linux-m68k.org>
References: <20210328041359.50149-1-julianbraha@gmail.com> <87lfa7ved3.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, March 28, 2021 5:04:08 AM EDT you wrote:
> On M=E4r 28 2021, Julian Braha wrote:
>=20
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 2779c29d9981..8d53ed423899 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -1665,7 +1665,7 @@ config LATENCYTOP
> >  	depends on DEBUG_KERNEL
> >  	depends on STACKTRACE_SUPPORT
> >  	depends on PROC_FS
> > -	select FRAME_POINTER if !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM=
 && !ARC && !X86
> > +	select FRAME_POINTER if MIPS || PPC || S390 || MICROBLAZE || ARM || A=
RC || X86
>=20
> That doesn't look correct.  It reverses the condition without reversing
> the result, which means the result is probably the opposite than intended.
>=20
> The same expression occurs two more times in this file.  Do those need
> to be changed as well?
>=20
> Andreas.
>=20
>=20

Hi all,

This was a mistake - I'll resubmit the proper patch.=20
Also: yes, the other usages of this select expression in this file
will cause more unmet dependency bugs.=20
I'll include those in the resubmission as well.

=2D Julian Braha



