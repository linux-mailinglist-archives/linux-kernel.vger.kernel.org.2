Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC899369532
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 16:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242657AbhDWO4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 10:56:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:38092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231169AbhDWO43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 10:56:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 433F661445;
        Fri, 23 Apr 2021 14:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619189753;
        bh=R62pLNjA9noFl2JNlwS4diwF3n2+vBGPxhkGlcLJqNU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OHb9hJ26La3xCDjCdmfC0+DTMmtSZqIETEbpFB4o43Tg/CTphiDmkdeR+WrZmRY8R
         Ufvva8FGnrC0dFC++suE5LUFdwceIbXSqdjwrlkfaKIFXP4WzUDu4CLz+8uJd78zUQ
         FnjER9fWRSWtX5UDAX/zukAGdAQUZUSAN3yoqYBZ6J50N+vJbWDnCcYfJOPBeXjQw+
         TTHM8E1HhfKfstD+QeiB+Nz8Zs1HxNzAqUeot1n/54Xeu8LPr9julfcFa1xzISbhXp
         gL5uGd23NSKjolrFBXEsZFFD+NewSw7jEh1PmdNbLc4HTdCJuRQCJ/cTNdatMUurOB
         NVBYxw/+ZvdZQ==
Received: by mail-ej1-f44.google.com with SMTP id w3so74364487ejc.4;
        Fri, 23 Apr 2021 07:55:53 -0700 (PDT)
X-Gm-Message-State: AOAM533fuqfh8bQoVTghxRCC+z2hvefbH7NyiDDXH9aYOK4D/AbvBDmx
        hk0X7p0UzMmd5NCOK2yd4HAs9wPPuARTI9QXog==
X-Google-Smtp-Source: ABdhPJyzSYoCrQUp8AZOe/VzsaOGQ7Ex2FewksH/32fJAahVFtRK2yHuqsRqIXD3LON0ZjaWUzCbhgXMiHLQGar8l38=
X-Received: by 2002:a17:906:1984:: with SMTP id g4mr4558298ejd.525.1619189751774;
 Fri, 23 Apr 2021 07:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <f2186955f310494f10990b5c402ada164d7834b8.1619188632.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <f2186955f310494f10990b5c402ada164d7834b8.1619188632.git.christophe.jaillet@wanadoo.fr>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 23 Apr 2021 09:55:40 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJkR94s107S0yiJpjNWKbi6yuqDcV7DaxbjBF-o80meaA@mail.gmail.com>
Message-ID: <CAL_JsqJkR94s107S0yiJpjNWKbi6yuqDcV7DaxbjBF-o80meaA@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc: Fix a memory leak in error handling paths
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>, gustavoars@kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 9:40 AM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> If we exit the for_each_of_cpu_node loop early, the reference on the
> current node must be decremented, otherwise there is a leak.
>
> Fixes: a94fe366340a ("powerpc: use for_each_of_cpu_node iterator")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Strangely, the commit above added the needed of_node_put in one place but
> missed 2 other places!

Well, maintained it in one place and forgot to add in the other two.

> This is strange, so maybe I misunderstand something. Review carefully
> ---
>  arch/powerpc/platforms/powermac/feature.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>

I don't really think patch 2 is worthwhile but that's up to the
powerpc maintainers.

Rob
