Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E916E3EEE56
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 16:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236913AbhHQOTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 10:19:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230412AbhHQOTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 10:19:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6722A60FD8;
        Tue, 17 Aug 2021 14:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629209946;
        bh=xV7Ud6jsNiaHGJDoSOkd+YvwcxtdNFwRiqSZbKNtVU0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sqmlYP+rVNjCRKI7xaSCRPtF7R2hpft0oF8P+6DMLiaKElfqc1gtv8P7vrK6wMseF
         E0Eu5dO/FDkOen4J3cVvdgb94pEtfIa9dWwx4wEyQADFkGI+cMPVZymrjAUD9JIkxZ
         4Vbxacc4yfR8UTkfximSzdkL0c9HT0eTwkT5qzX4sPjExdPNDrTT1t9GF/3lQCD+/s
         793MYXW/Sbg8IgDwLK6uJesi798+XQjC9Gm2JZMjEOea70qQ2vm/1jFb9XNPnxcHNr
         TSefW4XY0BeQqiVJ0iITgzsRA2mu4QkY9+qBHGkKT9offvXtUR/cL2Os9nUG3tnQZ2
         Swghz8Act6Ktw==
Received: by mail-oo1-f49.google.com with SMTP id l12-20020a4a94cc0000b02902618ad2ea55so5965225ooi.4;
        Tue, 17 Aug 2021 07:19:06 -0700 (PDT)
X-Gm-Message-State: AOAM531422myRk4aXHG+Bmla2xFbkh279YzrWyULHzouJjx0R/BPlBZO
        zwtdlyg8TUb3hYgPdznKPKGVWjvhTcVl4wXwTeU=
X-Google-Smtp-Source: ABdhPJwURPDIQOnNVkl4YBRE5wPJwMQixABKLUk8EX5AHVUdCsAFHaLyfV5HhY/KSgbFCKG5xGJddksDgAO6GMHncdA=
X-Received: by 2002:a4a:d752:: with SMTP id h18mr2826178oot.13.1629209944714;
 Tue, 17 Aug 2021 07:19:04 -0700 (PDT)
MIME-Version: 1.0
References: <YQ0Qm+Xs1g/7Eant@fedora> <20210809141027.860850-1-chouhan.shreyansh630@gmail.com>
In-Reply-To: <20210809141027.860850-1-chouhan.shreyansh630@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 17 Aug 2021 16:18:53 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGjY-EfaLc47HKvFz8AKeT=+XTXNRR5kVbQV7s3Hi9C2g@mail.gmail.com>
Message-ID: <CAMj1kXGjY-EfaLc47HKvFz8AKeT=+XTXNRR5kVbQV7s3Hi9C2g@mail.gmail.com>
Subject: Re: [PATCH] crypto: xts_crypt() return if walk.nbytes is 0
To:     Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzbot+20191dc583eff8602d2d@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Aug 2021 at 16:10, Shreyansh Chouhan
<chouhan.shreyansh630@gmail.com> wrote:
>
> xts_crypt() code doesn't call kernel_fpu_end() after calling
> kernel_fpu_begin() if walk.nbytes is 0. The correct behavior should be
> not calling kernel_fpu_begin() if walk.nbytes is 0.
>
> Reported-by: syzbot+20191dc583eff8602d2d@syzkaller.appspotmail.com
> Signed-off-by: Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/x86/crypto/aesni-intel_glue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
> index 388643ca2177..ec6eac57c493 100644
> --- a/arch/x86/crypto/aesni-intel_glue.c
> +++ b/arch/x86/crypto/aesni-intel_glue.c
> @@ -849,7 +849,7 @@ static int xts_crypt(struct skcipher_request *req, bool encrypt)
>                 return -EINVAL;
>
>         err = skcipher_walk_virt(&walk, req, false);
> -       if (err)
> +       if (err || !walk.nbytes)
>                 return err;
>
>         if (unlikely(tail > 0 && walk.nbytes < walk.total)) {
> --
> 2.31.1
>
