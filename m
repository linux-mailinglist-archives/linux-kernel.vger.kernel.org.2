Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80978441E23
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 17:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbhKAQbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 12:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbhKAQbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 12:31:08 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F24C061764
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 09:28:35 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id t7-20020a4aadc7000000b002b8733ab498so6449937oon.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 09:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pRSGvWwbmkorypXjIr/1Ir1j2xAMlHXbfH63oWX7RAw=;
        b=k5F2Nv73mWZ3sur0rBli/9IAPQeUS9EJy8tHteXZkvL1KVLm2sM2wOqCrNVrYK9phz
         M0gA9rCF6a1U43ed4iB/drSwTLwoqgsQF24hDnr3pJT1N+wXM2iA4a47KU6VqzXWJwEI
         QKJcKcCY3mcdq3aOMlg4ZOMBeXrWot3x9Z/2VI79h3x5yioT1mrUksMdInbZcKCGz005
         ZJdi0Zc5fIagKDjgPRuk+erZgYhAQ/SIySEtlVbFlyMQRf2uO1eGT9pnX8V6AgaOW7b7
         NRY5w0p+IlmGvel2SBXfKUMNyf5NNpRiV0yB50v1wsV0guYJmtsq/YccW+zLPFdXcf1S
         tYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pRSGvWwbmkorypXjIr/1Ir1j2xAMlHXbfH63oWX7RAw=;
        b=z/pcFznoP3o5M3yDdVjqujjZBzPwhz8XXV/BsMUURbweyWQY6ZxT8CguH2aWCbDjZW
         1qahAxlDRGPEWyv89tZeGPbQ3SoM8OD+W/lxqJXm3f0qBkX8hbK5c8J+V2nbJ4GXgoXJ
         fm4rP3Nw18SBBqtkqMisIa7DBjDzzPSsvl1E7hOxsiIshrmATS3mT87xVxNTbSKvrdTo
         F8FH8OxD5CNJGvpcZwkM8Z8rz4tEzQWUsGJh5KMRsZJ1wvRFG5lrZIx/dXXBm2h9ceV3
         D3AdeOWAAXWZg02NqOwxqt/7ghptelr8krPjGWvMJ465X5+su7jCXKlAxiTdg+s3rvW9
         qXgg==
X-Gm-Message-State: AOAM530tillc2TrYOmEiZCJ24SfgqzALk+CT1WRMyD+PtC0EN1MJ1olY
        s2jgdNY8F3/2yCG2O1MmJfD33L0gtCwLMQt/wCsYnQ==
X-Google-Smtp-Source: ABdhPJyAyhM3W7OP8NxtT/7y7xdrtQwC4Zu4D13/rUvHkHKfSM4grOLPVbYDBa1cMlOEo6xrjVYjQLdToMW3oAYFv68=
X-Received: by 2002:a4a:b501:: with SMTP id r1mr19682330ooo.20.1635784114171;
 Mon, 01 Nov 2021 09:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20211028175749.1219188-1-pgonda@google.com> <20211028175749.1219188-2-pgonda@google.com>
In-Reply-To: <20211028175749.1219188-2-pgonda@google.com>
From:   Marc Orr <marcorr@google.com>
Date:   Mon, 1 Nov 2021 09:28:23 -0700
Message-ID: <CAA03e5FgzHp-PHfi+v_R3hwxhbr2Z7O6hZuZQ8sDr-ryGVhxRQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] crypto: ccp - Fix SEV_INIT error logging on init
To:     Peter Gonda <pgonda@google.com>
Cc:     Thomas.Lendacky@amd.com, David Rientjes <rientjes@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        John Allen <john.allen@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 10:57 AM Peter Gonda <pgonda@google.com> wrote:
>
> Currently only the firmware error code is printed. This is incomplete
> and also incorrect as error cases exists where the firmware is never
> called and therefore does not set an error code. This change zeros the
> firmware error code in case the call does not get that far and prints
> the return code for non firmware errors.
>
> Signed-off-by: Peter Gonda <pgonda@google.com>
> Acked-by: David Rientjes <rientjes@google.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Brijesh Singh <brijesh.singh@amd.com>
> Cc: Marc Orr <marcorr@google.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: David Rientjes <rientjes@google.com>
> Cc: John Allen <john.allen@amd.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Paolo Bonzini <pbonzini@redhat.com> (
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/crypto/ccp/sev-dev.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> index 2ecb0e1f65d8..ec89a82ba267 100644
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c
> @@ -1065,7 +1065,7 @@ void sev_pci_init(void)
>  {
>         struct sev_device *sev = psp_master->sev_data;
>         struct page *tmr_page;
> -       int error, rc;
> +       int error = 0, rc;
>
>         if (!sev)
>                 return;
> @@ -1104,7 +1104,8 @@ void sev_pci_init(void)
>         }
>
>         if (rc) {
> -               dev_err(sev->dev, "SEV: failed to INIT error %#x\n", error);
> +               dev_err(sev->dev, "SEV: failed to INIT error %#x, rc %d\n",
> +                       error, rc);
>                 return;
>         }
>
> --
> 2.33.1.1089.g2158813163f-goog
>

Reviewed-by: Marc Orr <marcorr@google.com>
