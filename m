Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7D43A754D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 05:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbhFODka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 23:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbhFODk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 23:40:27 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CF0C061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 20:38:18 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id p15so3290782ybe.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 20:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/XUOfUqfTAfZKjkDbz8URCssQM6wFC15YP6MEdCsnEs=;
        b=V4AhZHiGDcSAoKGd4li1VrGqwa0atky1ZWjy4PK8GFIfFPHtirrJIubkGA47nU5ngf
         FT3KHoby1zmeLQ0m5TnuP0N6Loa8o5p/9CINYfaNY4ZcowUpkG9XPYYHVSRU9dBR64IF
         WTgFAWAEZyyJ3xBf2hOlC+Q5kvPVN4kzIDkQX9ACe8SuZ0GS7SjLUE2Q0f3iRRWklCAd
         41fmORPId7SGei4NTXqqe0LPWdvyfEpJaJ7ChsQjP3rEu2naKL4cssByUFoVrFKCdfza
         h/peepqZ8l6cBDS2dkyLcjpeeTtFWcGdYLDQwffy95gO0gFVxfaYDjo0YnvDbMN9290b
         9aUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/XUOfUqfTAfZKjkDbz8URCssQM6wFC15YP6MEdCsnEs=;
        b=Ss0whzMQ1FeZcpwQIF3thSH9PCyconQ+WMm4r2VnQ4eeR3PMAA8xBkJdTb1aIJWde3
         J93jiwUqtq+dJaNAxvJPI/d/xYCoXN+t6uowYnwRg9uGPeai7AXkzdektJrp7yBxzcyG
         xG/zl0MMh8uDgOcZ8Wd3juJrEBlio0bKd1EdOCzyZVQrO9uI/EFxNyoA8DpUD1s119ed
         rpq9YTh8VtbSTePF+4QVP1GMrh9YoE849ymKhiwqH6LapmaElubOnbmH/IL7gmQBSmX1
         6SoGTR+noCEWvBGm5GBwkOw2FJSnmHCUv+BaE3sSspyIrnSkq4WDBTUG6uSpBdTax5ph
         KQSQ==
X-Gm-Message-State: AOAM5325l2E6v4Z+Es1a7859a1iI0OS0n+QCAMdM+yP87+YphQBqIGPJ
        YfHlJ0ya1U5LGrZz179D2n6yDxK8CPrvHjN95bw=
X-Google-Smtp-Source: ABdhPJyQSb9L5NmkZfVMh3Mhm4D7uk1nKnR93vM0a2IUycPGFER5W0DAW1c4sqf7g8PhjXQim3AEFZfCivg8cWkONBo=
X-Received: by 2002:a25:694d:: with SMTP id e74mr4712799ybc.377.1623728297445;
 Mon, 14 Jun 2021 20:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1621516826.git.christophe.leroy@csgroup.eu> <d8b155e930b7a9708ca110e8ff0ace6713a7af75.1621516826.git.christophe.leroy@csgroup.eu>
In-Reply-To: <d8b155e930b7a9708ca110e8ff0ace6713a7af75.1621516826.git.christophe.leroy@csgroup.eu>
From:   Jordan Niethe <jniethe5@gmail.com>
Date:   Tue, 15 Jun 2021 13:38:06 +1000
Message-ID: <CACzsE9pYG2=FWnxb=gkd2WAFjfy3sLXN8mxsEP26zc7OHgX0Nw@mail.gmail.com>
Subject: Re: [PATCH v2 04/12] powerpc/inst: Avoid pointer dereferencing in ppc_inst_equal()
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 11:50 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> Avoid casting/dereferencing ppc_inst() as u64* , check each member
> of the struct when relevant.
>
> And remove the 0xff initialisation of the suffix for non
> prefixed instruction. An instruction with 0xff as a suffix
> might be invalid, but still is a prefixed instruction and
> has to be considered as this.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/include/asm/inst.h | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/inst.h b/arch/powerpc/include/asm/inst.h
> index fc6adef528a5..5a0740ebf132 100644
> --- a/arch/powerpc/include/asm/inst.h
> +++ b/arch/powerpc/include/asm/inst.h
> @@ -61,7 +61,7 @@ static inline int ppc_inst_primary_opcode(struct ppc_inst x)
>  }
>
>  #ifdef CONFIG_PPC64
> -#define ppc_inst(x) ((struct ppc_inst){ .val = (x), .suffix = 0xff })
> +#define ppc_inst(x) ((struct ppc_inst){ .val = (x) })
>
>  #define ppc_inst_prefix(x, y) ((struct ppc_inst){ .val = (x), .suffix = (y) })
>
> @@ -72,7 +72,7 @@ static inline u32 ppc_inst_suffix(struct ppc_inst x)
>
>  static inline bool ppc_inst_prefixed(struct ppc_inst x)
>  {
> -       return ppc_inst_primary_opcode(x) == OP_PREFIX && ppc_inst_suffix(x) != 0xff;
> +       return ppc_inst_primary_opcode(x) == OP_PREFIX;
>  }
>
>  static inline struct ppc_inst ppc_inst_swab(struct ppc_inst x)
> @@ -93,11 +93,6 @@ static inline struct ppc_inst ppc_inst_read(const struct ppc_inst *ptr)
>         }
>  }
>
> -static inline bool ppc_inst_equal(struct ppc_inst x, struct ppc_inst y)
> -{
> -       return *(u64 *)&x == *(u64 *)&y;
> -}
> -
>  #else
>
>  #define ppc_inst(x) ((struct ppc_inst){ .val = x })
> @@ -124,13 +119,17 @@ static inline struct ppc_inst ppc_inst_read(const struct ppc_inst *ptr)
>         return *ptr;
>  }
>
> +#endif /* CONFIG_PPC64 */
> +
>  static inline bool ppc_inst_equal(struct ppc_inst x, struct ppc_inst y)
>  {
> -       return ppc_inst_val(x) == ppc_inst_val(y);
> +       if (ppc_inst_val(x) != ppc_inst_val(y))
> +               return false;
> +       if (!ppc_inst_prefixed(x))
> +               return true;
> +       return ppc_inst_suffix(x) == ppc_inst_suffix(y);
>  }
>
> -#endif /* CONFIG_PPC64 */
> -
>  static inline int ppc_inst_len(struct ppc_inst x)
>  {
>         return ppc_inst_prefixed(x) ? 8 : 4;
> --
> 2.25.0
>
Reviewed by: Jordan Niethe <jniethe5@gmail.com>
