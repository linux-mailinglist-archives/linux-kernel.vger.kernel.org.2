Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B46449A4C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 17:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239012AbhKHQxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 11:53:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20434 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231330AbhKHQxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 11:53:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636390225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Cp1Rx79HPRFWEhhZgz1bOKGe1/Vy9sbxJgrvV4cvSc=;
        b=BGwCgGEBoPUPKOBAbbAvRM42G+ZOxZp26HIAK7GfXSw0YWsS3yGLJHJkbJe+yZiZpvjgP3
        RluSXE4bagDn3YH4PCjmn/OAW3RlrG49S8r6lCyfku2mipgRBbNuNRiGR4AIg8hay8+ALq
        x8ajz3rg5YCWpVO2TzY+BTDG+LklPo4=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-1B6bXcEiOA6zkRgcx4wkew-1; Mon, 08 Nov 2021 11:50:24 -0500
X-MC-Unique: 1B6bXcEiOA6zkRgcx4wkew-1
Received: by mail-ot1-f69.google.com with SMTP id s38-20020a05683043a600b0055a6f3f8c26so9299445otv.21
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 08:50:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7Cp1Rx79HPRFWEhhZgz1bOKGe1/Vy9sbxJgrvV4cvSc=;
        b=mcmJ7wuIe6xmQW3PAck5ofEQ4ATUZysfayk5vocDbvXYG1LobMgLlzsCZ2UK5IyPqV
         XaqY8TV6fRFk7hqCgdMB5bKsgpg9nX2zdxeqWicGXbzs6uhOnxe02ne7WJ5/wv7nBHsN
         e0G8hORMCGfVaetv/R6Yk1fSpWBMxYqm4JOo/+W9G0YKkmIz86tAvZjTy1jpRwUjarpD
         ZWUbWZY02Thc7acFgcsmy672EuJuBEdzlIAmdl+ng25LdrfAjac94FEtgwV37rudrrGP
         rj0lkuWuMuBJbUsDGK4oL6edtw4lWezr6nrI02apMhbSSNbjC919nkQ6Sjkmlf+WWQNZ
         DM2w==
X-Gm-Message-State: AOAM532lU5n1iVrHCO7b0Rsxbse1DvORvxQHMU9tOZH+2s7qv3tNPmZe
        l954ArtYPaG4dBBSacn0Ie2OFBpVGG6qELajOdU1k+mN5PuYOXLAOhRyD9AarRsmBtHTqSRndPF
        lH+Ls+JTuVclD+EhOHm9fHsKb
X-Received: by 2002:a05:6808:13c6:: with SMTP id d6mr440836oiw.177.1636390223244;
        Mon, 08 Nov 2021 08:50:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwehjvW/iUaC2D+ZGiqB6AKiqAmRnGS6IRfpiMond0g3BBfFtTJxARakU1FNtFDw5WbMXDxGg==
X-Received: by 2002:a05:6808:13c6:: with SMTP id d6mr440805oiw.177.1636390223013;
        Mon, 08 Nov 2021 08:50:23 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id r26sm2025944otn.15.2021.11.08.08.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 08:50:22 -0800 (PST)
Date:   Mon, 8 Nov 2021 08:50:16 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Miroslav Benes <mbenes@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] compiler.h: Avoid using inline asm operand modifiers
Message-ID: <20211108165016.kdehec32k3dw4334@treble>
References: <cover.thread-1a26be.your-ad-here.call-01621428935-ext-2104@work.hours>
 <patch-1.thread-1a26be.git-930d1b44844a.your-ad-here.call-01621428935-ext-2104@work.hours>
 <20211105165418.ucsrpk53dv5kgu6k@treble>
 <your-ad-here.call-01636386038-ext-6578@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <your-ad-here.call-01636386038-ext-6578@work.hours>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021 at 04:40:38PM +0100, Vasily Gorbik wrote:
> > Does this work on s390?
> > 
> > diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> > index 3d5af56337bd..42935500a712 100644
> > --- a/include/linux/compiler.h
> > +++ b/include/linux/compiler.h
> > @@ -115,24 +115,18 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
> >   * The __COUNTER__ based labels are a hack to make each instance of the macros
> >   * unique, to convince GCC not to merge duplicate inline asm statements.
> >   */
> > -#define __stringify_label(n) #n
> > -
> > -#define __annotate_reachable(c) ({					\
> > -	asm volatile(__stringify_label(c) ":\n\t"			\
> > +#define annotate_reachable() ({						\
> > +	asm volatile("%c0:\n\t"						\
> >  		     ".pushsection .discard.reachable\n\t"		\
> > -		     ".long " __stringify_label(c) "b - .\n\t"		\
> > -		     ".popsection\n\t");				\
> > +		     ".long %c0b - .\n\t"				\
> > +		     ".popsection\n\t" : : "i" (__COUNTER__ & 0x7f));	\
> >  })
> 
> hm, could we just add asm input back and not use it? and keep
> __stringify_label(c) as is? would that work as well?

Yeah, that seems to work:

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 3d5af56337bd..429dcebe2b99 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -121,7 +121,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 	asm volatile(__stringify_label(c) ":\n\t"			\
 		     ".pushsection .discard.reachable\n\t"		\
 		     ".long " __stringify_label(c) "b - .\n\t"		\
-		     ".popsection\n\t");				\
+		     ".popsection\n\t" : : "i" (c));			\
 })
 #define annotate_reachable() __annotate_reachable(__COUNTER__)
 
@@ -129,7 +129,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 	asm volatile(__stringify_label(c) ":\n\t"			\
 		     ".pushsection .discard.unreachable\n\t"		\
 		     ".long " __stringify_label(c) "b - .\n\t"		\
-		     ".popsection\n\t");				\
+		     ".popsection\n\t" : : "i" (c));			\
 })
 #define annotate_unreachable() __annotate_unreachable(__COUNTER__)
 
diff --git a/include/linux/instrumentation.h b/include/linux/instrumentation.h
index fa2cd8c63dcc..24359b4a9605 100644
--- a/include/linux/instrumentation.h
+++ b/include/linux/instrumentation.h
@@ -11,7 +11,7 @@
 	asm volatile(__stringify(c) ": nop\n\t"				\
 		     ".pushsection .discard.instr_begin\n\t"		\
 		     ".long " __stringify(c) "b - .\n\t"		\
-		     ".popsection\n\t");				\
+		     ".popsection\n\t" : : "i" (c));			\
 })
 #define instrumentation_begin() __instrumentation_begin(__COUNTER__)
 
@@ -50,7 +50,7 @@
 	asm volatile(__stringify(c) ": nop\n\t"				\
 		     ".pushsection .discard.instr_end\n\t"		\
 		     ".long " __stringify(c) "b - .\n\t"		\
-		     ".popsection\n\t");				\
+		     ".popsection\n\t" : : "i" (c));			\
 })
 #define instrumentation_end() __instrumentation_end(__COUNTER__)
 #else

