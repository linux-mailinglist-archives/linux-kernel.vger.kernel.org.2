Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F053F6BAE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 00:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237104AbhHXWWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 18:22:21 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:34680 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235429AbhHXWWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 18:22:20 -0400
Received: by mail-ed1-f44.google.com with SMTP id i6so33948763edu.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 15:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FLwSD+gDmLT1RphYbTsuKoaMUozofhn069mfJRCz5Xs=;
        b=G16s96oL45n2iBHnrUctqcsx2N5yjPakOqa19dTnb7KA00pdh+xLgWFVOZncHl97LO
         wkwjbYMkr3ThJ3Qzd2fQ+d0WSlssqdEx4n7fGO3dKglMJSLS0ZDDXixUrfOHoh06nn8h
         yFghrLbqI9vL5BzSVZpwA0e0RdC/vSJmoZJTJDK3jw3OI+1WWx+PoE3ytWX8fbsdc2au
         WD5BKzIEklLYWlzzqt489O7fIE93gv2MwLEepEaIiGfNOx8L9rE+u9o2JhccLDoe/zmS
         5htGjzHFYm64GiCrAJwQDrM8nEMKZm7isQk51RKClMvaAQ5T1FsfPGAhdRYPbwMEFFhD
         yyXQ==
X-Gm-Message-State: AOAM533IZcawjN1fnlm2ciBoK9qLxnW0AnledWsZOyWtNdMzvZjmBbHn
        QBayu5Hm+NbFjtOxQTCgjUshHMK5inrbHwz73HL62JKa45k=
X-Google-Smtp-Source: ABdhPJxrPeDOIXMIcDR6MXSFL4BV4V58OMGyz/+6rcgwUwKhzqvQIe2GNoamOnQpjF8wDkWGHRwmKvYTpMoXkeM2HV8=
X-Received: by 2002:a05:6402:27c6:: with SMTP id c6mr14872830ede.111.1629843694867;
 Tue, 24 Aug 2021 15:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <20210730145957.7927-13-chang.seok.bae@intel.com> <YR00U19168BGoRB9@zn.tnic>
In-Reply-To: <YR00U19168BGoRB9@zn.tnic>
From:   Len Brown <lenb@kernel.org>
Date:   Tue, 24 Aug 2021 18:21:23 -0400
Message-ID: <CAJvTdKk6kh3yT==FFRJ0RXDSrpnWecOo06EAEgHctnWbwTg50Q@mail.gmail.com>
Subject: Re: [PATCH v9 12/26] x86/fpu/xstate: Use feature disable (XFD) to
 protect dynamic user state
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, thiago.macieira@intel.com,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 12:24 PM Borislav Petkov <bp@alien8.de> wrote:

> > diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> > index a7c413432b33..eac0cfd9210b 100644
> > --- a/arch/x86/include/asm/msr-index.h
> > +++ b/arch/x86/include/asm/msr-index.h
> > @@ -626,6 +626,8 @@
> >  #define MSR_IA32_BNDCFGS_RSVD                0x00000ffc
> >
> >  #define MSR_IA32_XSS                 0x00000da0
> > +#define MSR_IA32_XFD                 0x000001c4
> > +#define MSR_IA32_XFD_ERR             0x000001c5
>
> At least try to keep those numerically sorted, at least among the
> architectural MSR_IA32_ ones.

agreed

> That is, provided those XFD things are architectural...

Yes.
MSR_IA32_XFD and MSR_IA32_XFD_ERR are architectural.

(which is why they follow the convention of having an "IA32" in their name)

https://software.intel.com/content/www/us/en/develop/download/intel-architecture-instruction-set-extensions-programming-reference.html

Len Brown, Intel Open Source Technology Center
