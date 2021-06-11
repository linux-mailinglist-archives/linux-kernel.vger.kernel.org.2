Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A6E3A391F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 03:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhFKBIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 21:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbhFKBIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 21:08:42 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42761C0617A6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 18:06:30 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id og14so1928985ejc.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 18:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H2IbE0UDqkplcoBwYyFLTzh0YSSXPcpK0pIRNcznpsk=;
        b=1eGkRAu1mECX3+QYmR6Ax3ULxHRk79Pq25bI74ffIR34iYh3LeO+i/dGwJD8BFDQdX
         cnJSZEB6fJGYpggDS9Nq5hoau6y+je5XFcaw4/lwxQyLCiLpXnPWI7n8X0xHLRtZl+zT
         os32e2S+mSlAH3xZ6Ux1CEJ9JtabY3hK3zQMbdjwyZ9cZAsXjzYO2HA7fEQh7WDVYyZX
         nlinu6YBYfBi2jr+9yzGDUlIE3TWNoB/eDvZJMEjxYrHmwChFAWiVX3c/8wzakJpJiTJ
         kICFm4qG4cruDcECs9sSbJjn9KFzK9xvCEelMWRLucoGJ0d/4e6X/BKktJqMhl/EyiFi
         XMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H2IbE0UDqkplcoBwYyFLTzh0YSSXPcpK0pIRNcznpsk=;
        b=P+nCHDXy8XC22xu/KFT5eHwguFZgdwdBwKl/liMYocpbJrp+/D+dRUsTkKVbY+jYTp
         NuDmxARTtA6+y6HNO2tNq3IAxqQ+XTl/+dPx9Y5E2sMj5YLn7U9D2f5ZRVUiAp3xVE4G
         h7dGA3hS1y6kl9VCUP4+hdCWMleZDbJAYQTtmddsEJYNiK6KildXfh88gc5D13wOFEvK
         M/dGHbHhdLgUdo+a/ATfTRlHXsdjx6V++dmOMpEVzEF4GwPGwrWTkLtk5IUh40xGHZTq
         kE+SktWDKOWANxL4w3CQLch7fPNdNKMtzEAIzpnMG8GBlDOn/T44dMcHIyr85J/yA4nj
         i5oQ==
X-Gm-Message-State: AOAM531v6yzwF2MK7rXuK9xGxfDgZivEAYClnic0SUNc18N2/83KTmdm
        MUs8D47h3CvDucn/9riQtqjF19vJ0el6MY3bH9wr
X-Google-Smtp-Source: ABdhPJx0TKHfTUKKbwofo48lOHqY6bpNs5Fp96fPiNYMnxeGs/QUBiv+pKoyaYieeFTyVC9y9U95lqqCoiocDB1iEQA=
X-Received: by 2002:a17:906:4111:: with SMTP id j17mr1050234ejk.488.1623373586316;
 Thu, 10 Jun 2021 18:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <1623317883-54209-1-git-send-email-yang.lee@linux.alibaba.com>
In-Reply-To: <1623317883-54209-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 10 Jun 2021 21:06:15 -0400
Message-ID: <CAHC9VhQ_XkZ=ADhe5=PqV-zNuEGOHDZfsBnSErW3j+zz5b4Qrg@mail.gmail.com>
Subject: Re: [PATCH -next] selinux: Fix kernel-doc
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, nathan@kernel.org,
        ndesaulniers@google.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 5:38 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Fix function name in ss/services.c kernel-doc comment
> to remove a warning found by running make W=1 LLVM=1.
>
> security/selinux/ss/services.c:2437: warning: expecting prototype for
> security_pkey_sid(). Prototype was for security_ib_pkey_sid() instead.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  security/selinux/ss/services.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 3658488..bb043bf 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2423,7 +2423,7 @@ int security_port_sid(struct selinux_state *state,
>  }
>
>  /**
> - * security_pkey_sid - Obtain the SID for a pkey.
> + * security_ib_pkey_sid - Obtain the SID for a pkey.
>   * @subnet_prefix: Subnet Prefix
>   * @pkey_num: pkey number
>   * @out_sid: security identifier

This kdoc function header block is also missing the selinux_state
description.  Would you mind adding something like the following and
resubmitting your patch?

  * @state: SELinux state

... I suspect there are a number of function header comments with
similar problems in the SELinux code.

-- 
paul moore
www.paul-moore.com
