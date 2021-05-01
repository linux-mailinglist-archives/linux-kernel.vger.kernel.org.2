Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDFD370499
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 03:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhEABCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 21:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhEABCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 21:02:15 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6ABC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 18:01:25 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gj14so5427361pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 18:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vItyFH07h7JJWWVL+iQal2DPbJ6ejOVKWutNF9KlRFw=;
        b=FWiYy3zaUkm9HZE4nz+VMR4ZPhu7VAE+JILWbkJsCZuWcjEiis3FVuxTd9OrsFaXrM
         COXzC7+P4hVU6OxBSnKHsNNYbBJ0XZ2Dj0lV9tt505C7wAJ1Ac2h7h/p38k0cQkRpgE3
         zS3qUv4ZFdsOCx7JVmkdrhAjQiBQEP+Hfh3bcp7NEsVu4lx5nzpfYyyQZH9JQH9m04U8
         rTId6aSZ1pnmHJnnJ6dm3xzTXSt1dfChBMU3mKk0q2pP8HXJTSjqhiZP15g+MmPPc9pI
         0e2khVrv/yLxwe1akI5CZUKhgrT0ZbfXUvsJhQOf+QqaD8ZwGwMATYkgXiod0n9WsqBQ
         y4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vItyFH07h7JJWWVL+iQal2DPbJ6ejOVKWutNF9KlRFw=;
        b=sLd5yy5izPj4M3CI4u8Q3DHmNYHDqT/v7T47H/kOP4YeaMTtEtaMw8AzB32vjYlTx2
         rJmmgEdQcYE6mtLlOVGuiN/cYEjzbRt3RjjBU/TgGAwGW99vmQaaCdD4rzNp5/hjahXc
         q4KFgwJtY6/RaF//2HMJzf2MN0oNNRXVaxXcc5FqJMAUUAWaekvRLUMhRmh9j0Ms2NiA
         gDogGznaM0H8iwxBUw7h3+eq1yYMBDqogFBwK9/GPMMXWgRGUsnwYMdZ0MipJDeCP2ri
         K6Gix70Bn/APhxKAReegwR7xFtR2+63/nS2aYw9mlUD6QPAcMzr+ZGSUnRuDa2jMYloc
         htcA==
X-Gm-Message-State: AOAM533e7IA+AGV+hiBO9RbkQeHvdiiPJbYvKlKjCxjXszaYWqrUMc+6
        Rk2u74fp3dXpIPITcxlMSx9BFploZ80XqYz+ef35zA==
X-Google-Smtp-Source: ABdhPJypjzaJupfHe3u2FDhxiCs2hXqxzUCVxPGLunvwjBV042XMM6aZFW/UM3Vf94fJq7CjLRI1TVPNxbFTctM+wLc=
X-Received: by 2002:a17:90a:fa8f:: with SMTP id cu15mr8289994pjb.216.1619830884707;
 Fri, 30 Apr 2021 18:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210430131733.192414-1-rsaripal@amd.com> <20210430131733.192414-2-rsaripal@amd.com>
 <CAAeT=Fw-nt5h3DhRCQr8Ma71NiP7dHB+WD2hie_55SpCHR=mDQ@mail.gmail.com>
 <YIxhCSt6t5U/Eldb@zn.tnic> <CAAeT=FxqM5P+6U8vBywuvnaJ0s4sWdRHK2fvn4b1zf5mMLKReg@mail.gmail.com>
 <YIxyeZodkm3KpRYK@zn.tnic>
In-Reply-To: <YIxyeZodkm3KpRYK@zn.tnic>
From:   Reiji Watanabe <reijiw@google.com>
Date:   Fri, 30 Apr 2021 18:01:08 -0700
Message-ID: <CAAeT=Fxk2U_13=03ZhFumT5c3k+F3UGExp6WZ+TK4VgJdt=RkQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] x86/cpufeatures: Implement Predictive Store
 Forwarding control.
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ramakrishna Saripalli <rsaripal@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, Jonathan Corbet <corbet@lwn.net>,
        bsd@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Could you please clarify ?
>
> Clarify what?

I'm sorry, I overlooked the response from Ramakrishna today.
So, Never mind...


> I asked you whether you have a VM use case. Since you're talking/asking
> about virt support, you likely have some use case in mind...

When PSFD is available on the host (and the feature is exposed to
its guest), basically, we would like to let the guest enable or
disable PSFD on any vCPUs as it likes.

Thanks,
Reiji
