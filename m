Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0822535D740
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 07:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344666AbhDMF30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 01:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245569AbhDMF3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 01:29:15 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541E7C06138D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 22:28:56 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x13so15175615lfr.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 22:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AvM1ldJd1PKthEmfQSYxE8KSNEBVhrFycB3fykwgq2c=;
        b=UK3JH759G5m7p0pnsTXSHGCiELHJAr54O5vcX1IB6nRyAoAETABf7dCAHSlGY/lPhU
         WUXj/erFHsdspCxelTHH6uL8NGXau+QJ3AaAEGL/i8aX1ON2ysWli9CSVKKCPW320tPv
         06lJbsmE+UsWs6YIPzVQikof8W+h9yCRAqa9+2Z13jlUT6BdGNZ06LMW79Tw6QDi8B0S
         McA2kNbpz/P22FYKFoOm4oDwrNbCh+zAJs0QHQ410EXbBr2BZ0hmnefPGl6xdBgPqtHV
         4XCjcpjsCBNvoKGm4ZTU+0B/AL2zpyvfV1S0G9gGfLkhIYS/poU85AqHGMQGVabPY9zO
         FHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AvM1ldJd1PKthEmfQSYxE8KSNEBVhrFycB3fykwgq2c=;
        b=KIfTSq7EgFzOaJUZ0QY+OdNGK62EWQf6n8d2FqrQpWygG3lTryddFzUDjT2fkXUzzb
         5w0bF4/xeSTEmS5FunhlHaQtE+Ca+q0JpADCqyGScBEs7n5jYj1ZE9itot8xEZ3uErAM
         tVhJLYwuWt/XJZcgWf3GKrZHj5wJkCfxlK/qk6DZaiDXyXkTzGubh+4t+J2L6iK0R+j0
         PkKDQTJfwcVV+MHu2H+52Pky3ufzNEaWcU9enuteH/SS/oNqCTuSXCCRHzvzx7bR8379
         SmyqK393ZW/CFwKPbyOlUySOQiEsXG4fQStEdf1Qnc66PAaaAYcjLUxBGlaaGWcXMbjJ
         p2ig==
X-Gm-Message-State: AOAM530XFzr8g738KPOLgQORbP17XY1lZehpfkXtoH0uf6wN+4GQCWos
        xhsFn6FvDyAezxf7ihlTHAB8c1Xyk2HXG5u9yS4tOA==
X-Google-Smtp-Source: ABdhPJx9ng30E0BX/dlKP+vG2PKF/myAqIZYQjX8xoWOhcGfWAFEM7eX3+jRMIpdP8gqwgxzRTls3J+2Xp/efIqxLfE=
X-Received: by 2002:ac2:4db9:: with SMTP id h25mr8011757lfe.108.1618291734612;
 Mon, 12 Apr 2021 22:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210412160101.1627882-1-colin.king@canonical.com>
In-Reply-To: <20210412160101.1627882-1-colin.king@canonical.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 13 Apr 2021 10:58:43 +0530
Message-ID: <CAFA6WYM65kjt0rbheAorX9uwWnhd5z7Gqed7a3YxjXMdHai1pw@mail.gmail.com>
Subject: Re: [PATCH][next] KEYS: trusted: Fix missing null return from kzalloc call
To:     Colin King <colin.king@canonical.com>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Apr 2021 at 21:31, Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The kzalloc call can return null with the GFP_KERNEL flag so
> add a null check and exit via a new error exit label. Use the
> same exit error label for another error path too.
>
> Addresses-Coverity: ("Dereference null return value")
> Fixes: 830027e2cb55 ("KEYS: trusted: Add generic trusted keys framework")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  security/keys/trusted-keys/trusted_core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>

Ah, it's my bad. Thanks for fixing this issue.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
> index ec3a066a4b42..90774793f0b1 100644
> --- a/security/keys/trusted-keys/trusted_core.c
> +++ b/security/keys/trusted-keys/trusted_core.c
> @@ -116,11 +116,13 @@ static struct trusted_key_payload *trusted_payload_alloc(struct key *key)
>
>         ret = key_payload_reserve(key, sizeof(*p));
>         if (ret < 0)
> -               return p;
> +               goto err;
>         p = kzalloc(sizeof(*p), GFP_KERNEL);
> +       if (!p)
> +               goto err;
>
>         p->migratable = migratable;
> -
> +err:
>         return p;
>  }
>
> --
> 2.30.2
>
