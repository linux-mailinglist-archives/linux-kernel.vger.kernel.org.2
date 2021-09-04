Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C035400A4C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 09:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbhIDHsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 03:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbhIDHsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 03:48:01 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452BDC061575;
        Sat,  4 Sep 2021 00:47:00 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id f15so2820625ybg.3;
        Sat, 04 Sep 2021 00:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O7pFDoTDG83sXYm3yFYU/ALPWpomicRzzImF0sKpKW0=;
        b=ccMUmEJZTMqvMiO4qDEJz9UIC9A7ZaCIp9jDhsXqJ5Ev75Fxx6tmimIki1gyPQUPXS
         WUq6vqhnlpebDLPREpSmGpTghCvaQ7I1t01NqKoILpqjhefYji3+KrmbyFtUkdfSEFMJ
         UNwklfNd5oZpXUbNtuS3Oq+g4hQudXjwXg1XEFeEAUaktgjFZB/kPlvDx7egLukEmhkQ
         KlsFkF03WrbLns7SWJ2p3vqZWsqreGnTfotAuElmmYxanXxACNPJgkmZ16+Syj62X9W+
         SAM5JaMcIrLBK/eVLU/0qgK95SGuyD2xbVFiDFCL54EJplm833L1/itj17ZCvI0BT/b6
         8S9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O7pFDoTDG83sXYm3yFYU/ALPWpomicRzzImF0sKpKW0=;
        b=VnOHcGZYGk4w3DggqIXVkchi2r0nDq0eBsww9d7S/50zP0SztsS94VAP2UesXlFlcU
         im2kq4CqT/8AO0NrfyRfWxB2exH8Xz+OizOYPJ06NxRQ9+W6j9uIsN53rgacEWVUoZCL
         fq/leZ57rqa6kENjbAQVGB64sSEApZqS/0cuPz/Pf65KcRNjzyH9zIqaIH/dUmDfzHPA
         qOAMyz88/7G5txxMqoBIqs7M7apeczbPWULTVWFszgMhLP+PpOR6lYybIW1tL0L1PFgC
         7+YIH0hm7Xiu/29oYTKfMWi3xUQqFNwOJJ/cTR2IHTTdLl3aZ3rF+bMtM7HuYfcwY0x6
         Uozw==
X-Gm-Message-State: AOAM532vhwO6zAwXZoHaTO5OOCxi0+NdV+N+2MQpC85rmRmiR2VvOasj
        +/ggPNjel/fJQBSlQ/p3t5tWWyYPvcdNCoXKXVHgUlmw/Zw=
X-Google-Smtp-Source: ABdhPJzKd12zJEaEmP4vMVbx87FxdriXYFR5EUre4fMKtstyxhr3RpJv2J0y5Wq4kmgxZlQsWGBvNl+pB3Rcq1FgLww=
X-Received: by 2002:a25:7ec4:: with SMTP id z187mr3949441ybc.35.1630741619439;
 Sat, 04 Sep 2021 00:46:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210904072951.12556-1-utkarshverma294@gmail.com>
In-Reply-To: <20210904072951.12556-1-utkarshverma294@gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Sat, 4 Sep 2021 09:46:48 +0200
Message-ID: <CAKXUXMyRKM9Ev_Yyyup-T=AZe2aYcN-ZneXsLmHtUC7as67zNQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: checkpatch: Add SYMBOLIC_PERMS message
To:     Utkarsh Verma <utkarshverma294@gmail.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 4, 2021 at 9:30 AM Utkarsh Verma <utkarshverma294@gmail.com> wrote:
>
> Add a new message type SYMBOLIC_PERMS under the 'Permissions'
> subsection. Octal permission bits are easier to read and understand
> instead of their symbolic macro names.
>
> Suggested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Signed-off-by: Utkarsh Verma <utkarshverma294@gmail.com>
> ---
>  Documentation/dev-tools/checkpatch.rst | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
> index f0956e9ea2d8..01105e9c89de 100644
> --- a/Documentation/dev-tools/checkpatch.rst
> +++ b/Documentation/dev-tools/checkpatch.rst
> @@ -957,6 +957,17 @@ Permissions
>      Permission bits should use 4 digit octal permissions (like 0700 or 0444).
>      Avoid using any other base like decimal.
>
> +  **SYMBOLIC_PERMS**
> +    Permission bits in the octal form are more readable and easier to
> +    understand than their symbolic counterparts because many command-line
> +    tools use this notation only. Experienced kernel developers have been using
> +    this traditional Unix permission bits for decades and so they find it
> +    easier to understand the octal notation than the symbolic macros.
> +    Also, it is harder to read S_IWUSR|S_IRUGO than 0644, which obscures the
> +    developer's intent rather than clarifying it.

Just a quick stylistic nit:

s/Also, it is harder to read /For example, it is harder to read/

Other than that:

Acked-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Reviewed-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Feel free to send a quick v2 for my nitpicking, and apply the tags
from this email.

Lukas

> +
> +    See: https://lore.kernel.org/lkml/CA+55aFw5v23T-zvDZp-MmD_EYxF8WbafwwB59934FV7g21uMGQ@mail.gmail.com/
> +
>
>  Spacing and Brackets
>  --------------------
> --
> 2.25.1
>
