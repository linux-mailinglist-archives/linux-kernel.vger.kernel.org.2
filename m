Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A7343B42C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235596AbhJZOcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbhJZOce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:32:34 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A95C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:30:10 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w15so14395540edc.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wJSGFytkkdPheB+wlk955znZt0m/KBc4qQJPUDxpyPw=;
        b=sANo+1Tne2i5Hv2mCCMeAhl0VxMgfF0YX0e60QWrmhXe7LzpBaTDBClGhYRoPML4ny
         8/JThRqJbNcFapRZxTpVFWFr1v1j5kG/XahTeep8+Z8b5dzqWGXzy/e0NlbjQsaK8G3N
         +t+Rkzg7Yec+g1gcMvi050G26Vy4x71gampIaLNpfrrzjNhSl3vjGAvCpP59o6CL7O8d
         CTxMaMYSwl/rLKRCRf7jPCpT/78zTXYeiRQ4G3AJfQ5CZJd/hGBHzTubFtHOCQHaIr2h
         548O9lotYZRkdLgU+SQsYZHEGA89qKQ/ontY01cGfo5wFOY+MSMI7bU5naRy5xvB609Z
         609w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wJSGFytkkdPheB+wlk955znZt0m/KBc4qQJPUDxpyPw=;
        b=mnpsqwTnYlbQbafAVW4f7r65i3ZXIUdIUs4zOVtt7pVhMEdk89ekusEJ1ft61TxXIz
         4HX279XQffDoS4IU7OErThk7ThSImWCt6UomrGgcGdc6/nTBd3V6IlYDRNgcstcGLM/R
         Y8gflm94/HqaXzbJApw17pMFLLSWb4HuYEQEwdYrA+83z9Xt/iEZAmk+RKA9vF4IUaxT
         WSvLaiSx1hZgCojXfibHPo//5wIjNhG95OdQPsj97tJjRzLvExJq9+Fmp8PcXbzOkkLN
         +gUBkyE+AJ9ScEqv9ear64UfLSriyG75ULE5rbWrkCzd13ByI4HmjGHMf2IbD8VYG33+
         vV9g==
X-Gm-Message-State: AOAM533dA53sjC3Uqqa4XMUJT4s3+QdXCLz4AUUELu+WuQxBFIaUSrR0
        eoeoZvUQITRfC7AfuS+N9FJEAnCqgWh/Ox06KKSA
X-Google-Smtp-Source: ABdhPJzAsQP0OAB+yYut6tHR+uRO8G4JL5eHkcZxmzYtC/7OerWPHYb1y9xLveuncd1s4fZzTrey1LV3hCwICiSozeI=
X-Received: by 2002:a17:907:7601:: with SMTP id jx1mr31210516ejc.69.1635258482206;
 Tue, 26 Oct 2021 07:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <20211026133147.35d19e00@canb.auug.org.au> <87k0i0awdl.fsf@mpe.ellerman.id.au>
In-Reply-To: <87k0i0awdl.fsf@mpe.ellerman.id.au>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 26 Oct 2021 10:27:51 -0400
Message-ID: <CAHC9VhTj7gn3iAOYctVRKvv_Bk1iQMrmkA8FVJtYzdvBjqFmvg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the audit tree with the powerpc tree
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Richard Guy Briggs <rgb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 6:55 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Stephen Rothwell <sfr@canb.auug.org.au> writes:
> > Hi all,
> >
> > Today's linux-next merge of the audit tree got conflicts in:
> >
> >   arch/powerpc/kernel/audit.c
> >   arch/powerpc/kernel/compat_audit.c
> >
> > between commit:
> >
> >   566af8cda399 ("powerpc/audit: Convert powerpc to AUDIT_ARCH_COMPAT_GENERIC")
> >
> > from the powerpc tree and commits:
> >
> >   42f355ef59a2 ("audit: replace magic audit syscall class numbers with macros")
> >   1c30e3af8a79 ("audit: add support for the openat2 syscall")
> >
> > from the audit tree.
>
> Thanks.
>
> I guess this is OK, unless the audit folks disagree. I could revert the
> powerpc commit and try it again later.
>
> If I don't hear anything I'll leave it as-is.

Hi Michael,

Last I recall from the powerpc/audit thread there were still some
issues with audit working properly in your testing, has that been
resolved?  If nothing else, -rc7 seems a bit late for this to hit
-next for me to feel comfortable about this.

-- 
paul moore
www.paul-moore.com
