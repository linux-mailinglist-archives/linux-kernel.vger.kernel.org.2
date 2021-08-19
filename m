Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155FB3F23A2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 01:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236282AbhHSXZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 19:25:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24226 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229808AbhHSXZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 19:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629415482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4O0EEnwBjO9aKA48AzUw1COP4tH/rotYIctT/xZgJEU=;
        b=bZRJDEnFK0ig2xx19ZNrTu2NB4MElFG4k+7oPM9PqmARvfijub0RckoRRt38Ww2SuIMeWx
        Hz7kD/WPnk18BayQ8ab0AF0k1VANx9G1SAA0V18KmeVKfXVVPRT+KPZtLitr4rn15xUmnd
        TquzCx/Ybq/FXgn2Q9gTSB3mGWh2AjU=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-9n8IPk2ePKOO4r-Q5vtMQA-1; Thu, 19 Aug 2021 19:24:41 -0400
X-MC-Unique: 9n8IPk2ePKOO4r-Q5vtMQA-1
Received: by mail-oi1-f200.google.com with SMTP id t42-20020a05680815aab0290267a116f6b3so2878789oiw.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 16:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4O0EEnwBjO9aKA48AzUw1COP4tH/rotYIctT/xZgJEU=;
        b=PaFGatC6rNH5s60sFC/3nsvTIn9suSGRiCFglXUQvJql2iMoL+9MArwoA1Si6cLDra
         UglpwxXW9pTriTAzmSkxzq1PeXcc+Zzf6PACFyhS8855lQ8agpd0FXIO7darLtFIIckE
         LV911CzIUmPlLecAc9jPyXMbtfJg4PC1dqZ3TTihEu/ok2fK9skCCbszNVAo586gPREt
         6oEVXSpSxbPvZm3guO0Svt+vghPe9gOZfMlsg/zyJxQR3ieuWwlPv1V7nnF7r9LmJ5tR
         VZZodc3IMIg9qCKxpE3+ONSdunAN8qFNHLiZjsWwFwdUTtFimD3b/5zNyRSqNJGCOsK9
         92pg==
X-Gm-Message-State: AOAM53099y3pepCcFumvKpAOPsMo/oGmBiIqiEWzZeiWvGgm+IbTi0Tn
        6kBQNCVRARxIfMEkRFvGudnE3c0/8eZecsPwb+rAiTx9w9VtOkmbi9i0ymc/DURRPjVaH7emr59
        GY+E8QeoqPtld+F3c0K63KXa/
X-Received: by 2002:a9d:6f10:: with SMTP id n16mr6209380otq.150.1629415480340;
        Thu, 19 Aug 2021 16:24:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNbp2DOjnTJ88IXfFOBXuInffzlODXwPiA8ixQM7EUp2hFznIgyiHscVKVBoZeUlXAhmORQw==
X-Received: by 2002:a9d:6f10:: with SMTP id n16mr6209366otq.150.1629415480140;
        Thu, 19 Aug 2021 16:24:40 -0700 (PDT)
Received: from treble ([68.74.140.199])
        by smtp.gmail.com with ESMTPSA id r2sm1007414oig.1.2021.08.19.16.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 16:24:39 -0700 (PDT)
Date:   Thu, 19 Aug 2021 16:24:37 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH] objtool: x86: .altinstructions doesn't need section
 entry size
Message-ID: <20210819232437.3g6dpalylgn7fgrx@treble>
References: <20210817014958.1108400-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210817014958.1108400-1-joe.lawrence@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 09:49:58PM -0400, Joe Lawrence wrote:
> commit e31694e0a7a7 ("objtool: Don't make .altinstructions writable")
> aligned objtool-created and kernel-created .altinstructions section
> flags, but there remains a minor discrepency in their use of a section
> entry size: objtool sets one while the kernel build does not.

I'd recommend more of an "active voice" subject like:

  objtool: Make .altinstructions section entry size consistent

> 
> While sh_entsize of sizeof(struct alt_instr) seems intuitive, this small
> deviation can cause failures with external tooling like kpatch-build.
> 
> Fix this by creating new .altinstructions sections with sh_entsize of 0
> and then later updating sec->len as alternatives are added to the
> section.  An added benefit is avoiding the data descriptor and buffer
> created by elf_create_section(), but previously unused by
> elf_add_alternative().
> 
> Fixes: 9bc0bb50727c ("objtool/x86: Rewrite retpoline thunk calls")
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> ---
> 
> Hi Josh, this is a follow up for
> https://github.com/dynup/kpatch/issues/1194 where I'll add some more
> comments on the kpatch-side of this.  We could probably work around it
> over there, but this objtool tweak looks small enough to maintain closer
> kernel-built .altinstructions section properties.
> 
>  tools/objtool/arch/x86/decode.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
> index bc821056aba9..e7087aa473f8 100644
> --- a/tools/objtool/arch/x86/decode.c
> +++ b/tools/objtool/arch/x86/decode.c
> @@ -684,7 +684,7 @@ static int elf_add_alternative(struct elf *elf,
>  	sec = find_section_by_name(elf, ".altinstructions");
>  	if (!sec) {
>  		sec = elf_create_section(elf, ".altinstructions",
> -					 SHF_ALLOC, size, 0);
> +					 SHF_ALLOC, 0, 0);

Looks good.

>  
>  		if (!sec) {
>  			WARN_ELF("elf_create_section");
> @@ -692,6 +692,8 @@ static int elf_add_alternative(struct elf *elf,
>  		}
>  	}
>  
> +	sec->len += size;
> +

This latter change makes sense, but I'm not sure it belongs in this
patch.  Wasn't sec->len wrongly set to zero (and never incremented) even
before this patch?

From what I can tell sec->len isn't ever read for this section, so it
seems to be more of a previously existing theoretical bug, independent
of the entsize mismatch bug.  In which case it's still worth fixing,
just probably in a separate patch.

Also the sec->len update should probably be moved down to the bottom of
the function alongside the update to sec->sh.sh_size, as sec->len is a
"convenient" more readable mirror copy of sec->sh.sh_size.

Actually, mirroring sec->sh.sh_size was a bad idea.  It's guaranteed to
introduce dumb bugs like this.  Maybe we should just kill sec->len
altogether in favor of using sec->sh.sh_size everywhere.

-- 
Josh

