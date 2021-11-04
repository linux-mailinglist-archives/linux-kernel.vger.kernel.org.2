Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C09445C81
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 00:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbhKDXDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 19:03:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52948 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231467AbhKDXDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 19:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636066855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kz5D2XrHzkGR6eEE3P3Wd4HduoWd/VhEom0C06kpEaU=;
        b=GYha42M0jsZs/IFp6W6ClSeqWP2U3wdP3vtjysZUgAiSnL+HI4xXZtc82cniZmvFxTEALM
        2FG8CHl2NUxExCeEE7/gQbuDqkW7cUpC4hGN5Mo1qT/6r5dfCxVnEDQutmdVuB2zYGvZ4b
        quTHrey7BrXo2DUmFhXZs+IcFgesH+4=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-ewMRqjUwMn-6CyTiTifcJg-1; Thu, 04 Nov 2021 19:00:54 -0400
X-MC-Unique: ewMRqjUwMn-6CyTiTifcJg-1
Received: by mail-oi1-f200.google.com with SMTP id t68-20020acaaa47000000b002a7a66ef1a2so4294535oie.15
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 16:00:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kz5D2XrHzkGR6eEE3P3Wd4HduoWd/VhEom0C06kpEaU=;
        b=wgU7eZqcJjVitXCtsaCdn5Mu7+JaGh5VrxFbRO48/gvMCOqypObpuf1hfnHvlJ52AU
         cZKikWncwt0PsW/SinL4/8hPwljsfDdrdd818s227ZCWVB6bgaDwebMXCq9rkUshLhxC
         tIYOmRyFZ+IABypvynb2iRB6OpDLQ68GGnrpQy3melHtMfYnpS+j/g8XyRSwcUr3Q6DN
         PxKO7vXqr0fMXmoaYYaIOCAR8HvYUytJR8zSdiHe322ojOkwEj6+IA+MNyjehkEnG1x8
         ThYqjnxdmLCSP2WYOnnVphbrdUbSfURNwOuuZJ/ekL6VkHU2ooUv2rrfOkiBGa+3Cypc
         cwcg==
X-Gm-Message-State: AOAM5329eejHruebOuZBAlfLkXZmU15OO8yWiiUVYY5OdNFvPd26zgfZ
        YgQtIBuEUrq7gWk/ONK5kfjxAnJTfuk8l5iRqm8T8yl9ttFNkyYJ0MjCAcskPtz39AgypMtdXdh
        p73K24+jCpHOmTCcyhqKi+OWb
X-Received: by 2002:a05:6808:2017:: with SMTP id q23mr19157875oiw.122.1636066853643;
        Thu, 04 Nov 2021 16:00:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwb4NVKVJlrZ8V/TzBQLSKVmPq1vB0KWvsDxX35DYZ/1IbzNqCAJPkUoA4YPrf+Gnd3I+cLeg==
X-Received: by 2002:a05:6808:2017:: with SMTP id q23mr19157851oiw.122.1636066853384;
        Thu, 04 Nov 2021 16:00:53 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id bb39sm1965018oib.28.2021.11.04.16.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 16:00:53 -0700 (PDT)
Date:   Thu, 4 Nov 2021 16:00:50 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, seanjc@google.com, pbonzini@redhat.com,
        mbenes@suse.cz
Subject: Re: [RFC][PATCH 22/22] x86: Remove .fixup section
Message-ID: <20211104230050.nltxx3vjje72hc2c@treble>
References: <20211104164729.226550532@infradead.org>
 <20211104165525.827837876@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211104165525.827837876@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 05:47:51PM +0100, Peter Zijlstra wrote:
> No moar user, kill it dead.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/entry/vdso/vdso-layout.lds.S |    1 -
>  arch/x86/kernel/vmlinux.lds.S         |    1 -
>  2 files changed, 2 deletions(-)
> 
> --- a/arch/x86/entry/vdso/vdso-layout.lds.S
> +++ b/arch/x86/entry/vdso/vdso-layout.lds.S
> @@ -77,7 +77,6 @@ SECTIONS
>  
>  	.text		: {
>  		*(.text*)
> -		*(.fixup)
>  	}						:text	=0x90909090,
>  
>  
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -137,7 +137,6 @@ SECTIONS
>  		ALIGN_ENTRY_TEXT_END
>  		SOFTIRQENTRY_TEXT
>  		STATIC_CALL_TEXT
> -		*(.fixup)
>  		*(.gnu.warning)
>  
>  #ifdef CONFIG_RETPOLINE

Objtool also has a reference to .fixup.

-- 
Josh

