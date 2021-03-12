Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 752E833992C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 22:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235320AbhCLViv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 16:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234033AbhCLVi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 16:38:28 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22985C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 13:38:28 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id mj10so56062518ejb.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 13:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y3pYXASAbKQPGfOGK/rF6fxCbBJHbX2zTttQzvRaW7o=;
        b=DxHwURVjMvIKGIzI7DuUu3AAv/d55DK5ezab/O4hToYEQ7cpwXk8ssuqLcoQkI9AlK
         2TggVCCbPUPeW2DPbY131Ens+aO5IfmgjTWhh/EjIaJKENNteCaqV1ZF+bA88ibt3xf6
         pMB12KW8BEuw3TlSIs1y3T2TZUY8zbxe5/FbQQr1U4xmVRlFhbgDb0B8PxTRqUxBLerq
         IuzOao/xdpnkV5XZZxRETokrb4GprEamPlTycqOPmPo1jofkgYy2TvevqMbe2gUJxClA
         b4V3kGF+mTbkY60cIC8E+298k3vjj9C83h56/ijFAPglOL7j8Ahvjo3RzrRJeZaC1MPd
         7CYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y3pYXASAbKQPGfOGK/rF6fxCbBJHbX2zTttQzvRaW7o=;
        b=CVutMEJmdWViB6jjazyAyNFrcglpXXhpuM9j5+tcnnhnESGkfc3nWI8knLStKbJY0Q
         Qdm7rBcD0hGer0xmbe3h1TuZgzQyqZEtpzQjlE+VkM4zmNT5RFqre/c7jx7b+Znovkpg
         upOZQMCfvpnFV6+tt6wKDO7OFRqYyUR1C/nMJ8QnuLyhi9oNTKm7abRkowET/rKDuNsX
         8g863TVSYVZPFa//o/E/VR5b1nAg4KCOw3vnGuAu8nAo+nxSjTjfitg7ZLMNHTf+Msjg
         qe5YZn4g6v0mVWLuVLF/ciGr9vYVtI+cVi1hZBURKwC39qNzwByZ9TC7abY3Y3VRP4uX
         CO6A==
X-Gm-Message-State: AOAM533VDbf23bMAnNKreNeEJL6ubrhxgzVJdBGVm22W57nbr4HyoiGD
        ZqvqqJN7WbV6MKTCabtr/4voAatRkWjMs45vW5u7
X-Google-Smtp-Source: ABdhPJyLP33I2LSd9dQd7uKTXF6aeDn9KsESwMZUv3BVbHWm1b4RGjFZzU86b61GmzbQBJGiq2YNM8GNMMsu4+gJaok=
X-Received: by 2002:a17:906:3b84:: with SMTP id u4mr10606402ejf.431.1615585106342;
 Fri, 12 Mar 2021 13:38:26 -0800 (PST)
MIME-Version: 1.0
References: <69f51dfe3ad24840ea1ef1f38cfe033f0fc62080.1615411783.git.rgb@redhat.com>
In-Reply-To: <69f51dfe3ad24840ea1ef1f38cfe033f0fc62080.1615411783.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 12 Mar 2021 16:38:15 -0500
Message-ID: <CAHC9VhTdD4FVHKDygOZPjvNeHPNGjyoTQ-TzrFHP5xpd9UtSKw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update audit files
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 11:41 AM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Add files maintaned by the audit subsystem.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  MAINTAINERS | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6eff4f720c72..a17532559665 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3015,9 +3015,13 @@ L:       linux-audit@redhat.com (moderated for non-subscribers)
>  S:     Supported
>  W:     https://github.com/linux-audit
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
> +F:     arch/*/*/*audit*.[ch]

That looks like it has about two too many wildcards to hold up over time :)

I understand what you're trying to do here, and while I don't disagree
in principle, I worry that the arch specific paths vary enough that
trying to handle it here is going to be a bit of a mess.

> +F:     arch/x86/include/asm/audit.h

The fact that we need a special entry for the single header under x86
tends to reinforce that.  The other additions make sense, but I think
it may be best to leave the arch specific areas alone for now.

> +F:     include/asm-generic/audit_*.h
>  F:     include/linux/audit.h
>  F:     include/uapi/linux/audit.h
>  F:     kernel/audit*
> +F:     lib/*audit.c
>
>  AUXILIARY DISPLAY DRIVERS
>  M:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
> --
> 2.27.0

-- 
paul moore
www.paul-moore.com
