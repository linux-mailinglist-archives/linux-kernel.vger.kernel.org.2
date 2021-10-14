Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A85542DEEC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 18:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbhJNQML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 12:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhJNQMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 12:12:10 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099AAC061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 09:10:05 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id t184so5013876pfd.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 09:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ppmZW4ZBH5xyy2WzEBIiNrY44GTIIBkU1GIdH41IqRg=;
        b=J6OtKw9L4sMHuAxKL+wwQVLKoN9HEq4hJivPyTZa2JP9u+gGNnUt+hb4fnN9nTJkZT
         p28qqeFwHOuI3PioXtXyowPdlmJP8SDC6GZxlIFxRvPznW3ekiagTbc0LM6QGFbmHt2k
         +0YNevAiiUyZ6w2TlTby/W4k0FGUQEEaAVSyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ppmZW4ZBH5xyy2WzEBIiNrY44GTIIBkU1GIdH41IqRg=;
        b=ZQLCFS8Q/IfQSfCMzd9U7yo/2Rq0MqJDuG8NDHgLItqhFmvtzg24ZtP8Z/JtbD2ZM8
         A7Jg5ywjRgQtDZNWLVV+11TQKypLVR6OmcGAbCanJCw8GozwQxkDrJ2cZRwg2/t+6rT+
         zAljN5mJ9xD2a2FVeap8VNaI+Lm7n5STN6rul40hKcNnYZYUC2gJH3beir3sP1vuQsLX
         NVIE3p+oLE3Lnyx6lGfdMCBtfIt9VvXRKE1hipfVNIuRC8d3IG3yDM/h3eQyanlbb28Q
         YGkH3fmutoXFZktSnTtBK51ddkCNqWhYaiQE/MsZxnOree10DI3/LMML0DnJncgDXNH5
         1i+g==
X-Gm-Message-State: AOAM532ZJDFd+cGorX5Isbzm2YVNerh68bfNL+hQ5kGf98EPUB/cfUxr
        395P47QOTW1bJOJGVrfzJrbL8w==
X-Google-Smtp-Source: ABdhPJyo11EvJ3dwy/4dLdCqDkOZsjG69AuLyzjCNpccNGqOGSiShUSJS/+J+3OfZWQkcnFNobNpzQ==
X-Received: by 2002:a63:cd57:: with SMTP id a23mr4899961pgj.320.1634227804490;
        Thu, 14 Oct 2021 09:10:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b8sm3256350pfv.56.2021.10.14.09.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 09:10:04 -0700 (PDT)
Date:   Thu, 14 Oct 2021 09:10:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     sxwjean@me.com
Cc:     x86@kernel.org, Xiongwei Song <sxwjean@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] x86/elf: Fix incorrect STACK_RND_MASK for x86_64
Message-ID: <202110140909.8CFD5377@keescook>
References: <20211014132736.266553-1-sxwjean@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014132736.266553-1-sxwjean@me.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 09:27:36PM +0800, sxwjean@me.com wrote:
> From: Xiongwei Song <sxwjean@gmail.com>
> 
> According to the comment for stack randomization of x86, the range of
> randomization is 1GB, which occupies 30 valid bits in binary. And in
> x86_64, PAGE_SHIFT occupies 12 bits, then the STACK_RND_MASK should
> occupy 18 bits for 1GB.
> 
> The current range of randomization is :
> 	0x3fffff << PAGE_SHIFT
> , which occupies 34 bits.
> 
> This patch changed 0x3fffff to 0x3ffff, which makes the range of stack
> randomization is real 1GB.

Why do we want to _reduce_ entropy here? Perhaps adjust the comment
instead?

-Kees

> 
> Before this patch(bit0 ~ bit33 randomized):
> 	root@qemux86-64:~# for i in {1..20};do cat /proc/self/maps | grep stack;done
> 	7ffddf971000-7ffddf992000 rw-p 00000000 00:00 0                          [stack]
> 	7ffc4e0d4000-7ffc4e0f5000 rw-p 00000000 00:00 0                          [stack]
> 	7fff5898e000-7fff589af000 rw-p 00000000 00:00 0                          [stack]
> 	7ffcf910b000-7ffcf912c000 rw-p 00000000 00:00 0                          [stack]
> 	7ffce829d000-7ffce82be000 rw-p 00000000 00:00 0                          [stack]
> 	7ffec72d9000-7ffec72fa000 rw-p 00000000 00:00 0                          [stack]
> 	7ffd6e256000-7ffd6e277000 rw-p 00000000 00:00 0                          [stack]
> 	7ffe14120000-7ffe14141000 rw-p 00000000 00:00 0                          [stack]
> 	7ffe21549000-7ffe2156a000 rw-p 00000000 00:00 0                          [stack]
> 	7ffdc9d33000-7ffdc9d54000 rw-p 00000000 00:00 0                          [stack]
> 	7ffe1ced4000-7ffe1cef5000 rw-p 00000000 00:00 0                          [stack]
> 	7ffcb0440000-7ffcb0461000 rw-p 00000000 00:00 0                          [stack]
> 	7ffc84515000-7ffc84536000 rw-p 00000000 00:00 0                          [stack]
> 	7ffe557dd000-7ffe557fe000 rw-p 00000000 00:00 0                          [stack]
> 	7ffdcb7e4000-7ffdcb805000 rw-p 00000000 00:00 0                          [stack]
> 	7ffc6f989000-7ffc6f9aa000 rw-p 00000000 00:00 0                          [stack]
> 	7ffd9322a000-7ffd9324b000 rw-p 00000000 00:00 0                          [stack]
> 	7ffea8e34000-7ffea8e55000 rw-p 00000000 00:00 0                          [stack]
> 	7ffc594ff000-7ffc59520000 rw-p 00000000 00:00 0                          [stack]
> 	7ffe8db65000-7ffe8db86000 rw-p 00000000 00:00 0                          [stack]
> 
> After this patch(bit0 ~ bit29 randomized):
> 	root@qemux86-64:~# for i in {1..20};do cat /proc/self/maps | grep stack;done
> 	7fffd0ed2000-7fffd0ef3000 rw-p 00000000 00:00 0                          [stack]
> 	7fffdf555000-7fffdf576000 rw-p 00000000 00:00 0                          [stack]
> 	7ffffec0e000-7ffffec2f000 rw-p 00000000 00:00 0                          [stack]
> 	7fffcfa0f000-7fffcfa30000 rw-p 00000000 00:00 0                          [stack]
> 	7fffff75d000-7fffff77e000 rw-p 00000000 00:00 0                          [stack]
> 	7fffd1d11000-7fffd1d32000 rw-p 00000000 00:00 0                          [stack]
> 	7fffc7850000-7fffc7871000 rw-p 00000000 00:00 0                          [stack]
> 	7fffc956e000-7fffc958f000 rw-p 00000000 00:00 0                          [stack]
> 	7fffdf7be000-7fffdf7df000 rw-p 00000000 00:00 0                          [stack]
> 	7fffeffdf000-7ffff0000000 rw-p 00000000 00:00 0                          [stack]
> 	7fffd7d7f000-7fffd7da0000 rw-p 00000000 00:00 0                          [stack]
> 	7fffe3d23000-7fffe3d44000 rw-p 00000000 00:00 0                          [stack]
> 	7fffde4b7000-7fffde4d8000 rw-p 00000000 00:00 0                          [stack]
> 	7fffd477a000-7fffd479b000 rw-p 00000000 00:00 0                          [stack]
> 	7fffc0e95000-7fffc0eb6000 rw-p 00000000 00:00 0                          [stack]
> 	7fffdbdda000-7fffdbdfb000 rw-p 00000000 00:00 0                          [stack]
> 	7fffec737000-7fffec758000 rw-p 00000000 00:00 0                          [stack]
> 	7fffed163000-7fffed184000 rw-p 00000000 00:00 0                          [stack]
> 	7ffff9a9c000-7ffff9abd000 rw-p 00000000 00:00 0                          [stack]
> 	7fffff945000-7fffff966000 rw-p 00000000 00:00 0                          [stack]
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Gabriel Krisman Bertazi <krisman@collabora.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: "Chang S. Bae" <chang.seok.bae@intel.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> ---
>  arch/x86/include/asm/elf.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
> index 29fea180a665..0b7a5510ebd5 100644
> --- a/arch/x86/include/asm/elf.h
> +++ b/arch/x86/include/asm/elf.h
> @@ -343,7 +343,7 @@ extern unsigned long get_sigframe_size(void);
>  #else /* CONFIG_X86_32 */
>  
>  /* 1GB for 64bit, 8MB for 32bit */
> -#define __STACK_RND_MASK(is32bit) ((is32bit) ? 0x7ff : 0x3fffff)
> +#define __STACK_RND_MASK(is32bit) ((is32bit) ? 0x7ff : 0x3ffff)
>  #define STACK_RND_MASK __STACK_RND_MASK(mmap_is_ia32())
>  
>  #define ARCH_DLINFO							\
> -- 
> 2.30.2
> 

-- 
Kees Cook
