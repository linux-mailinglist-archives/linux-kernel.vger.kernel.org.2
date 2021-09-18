Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B984C41034E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 06:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbhIRED5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 00:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbhIREDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 00:03:48 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50E7C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 21:02:22 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id c7so18361007qka.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 21:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=hWsUCOud4Q8t7h/x7lnTa903JxEWcDrgPEjfM+/HAhY=;
        b=kq4gsa6yqJqlD4oUaNnIUt179P7IaGKJfTgwgoXShnkKtGrsrLUhjim/3hGBkK1bzs
         +pSNcbZ9ogV2ogf7GD8tFOMEOCHLIIDz/fVoIQcJEbAQMjrepqsLP60DykURoVqVzvXI
         7FJTXQnhE2DZKhDcg2UmZkgw1siwZsdpFfluvdbrNekgX6RseX+W/+IzfkDE6rgU7/SY
         vrAtEL0WvzMpmYLWxBYO21tTB+0py0PaITSdp8sc+5SFzgRAuZDzNe0ljN9lMmiQEd8k
         8XyEwOwuLguJQ8hnl5FWjlnII/MmIKF/L4WpLj22MuHQ4cCNIAlaS86k79uVd8Sc5tmf
         62vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=hWsUCOud4Q8t7h/x7lnTa903JxEWcDrgPEjfM+/HAhY=;
        b=J3ibW4PdB9ov9oKVPDaUmxZIm2oMr7gr7FILu9FdVWoNDELw8cjHePe67yAqTCE9aS
         NK9mPCehpqQBRLEYpRkaIYHi4ByLEySImugJwyBd3VkPKMO3Tmv50nSV9yOc0Oq4GMGe
         V5XSMIUyJAwR/QQe6FD8y95P1QEeYP9KzFPdakn4xIVAs9/JwwlB1qjbgP/3IY4F/Se3
         FCvxZJ9ZbXC3UZKErEPX4nnaNR5ZiZ92N+B6GKlQ5tb0r0BfBehWgaxLRZldfnHaVS77
         iahoF3pK1tzQcqZgEVAhs+X+CqvGkJ8wflMm/HmnUI0pXMcoOxK3f37eypgbqDebpzVy
         GaMA==
X-Gm-Message-State: AOAM533MD0EWwR0ZThMfu8K07Kr38Ydw1iKRU3kyZ8aJk+3uzHMO50zr
        EztUBusonxQ+iyviN4IdH5N/F+MINSQ=
X-Google-Smtp-Source: ABdhPJwzVwAuD/+rl6vNd7Z6Gv+q4CvYp1ibuI8gP3GB+3ftHvFyVOhq22oozPcJF7yZsBoMa+9Vqw==
X-Received: by 2002:a05:620a:916:: with SMTP id v22mr14000989qkv.338.1631937742135;
        Fri, 17 Sep 2021 21:02:22 -0700 (PDT)
Received: from Gentoo ([138.199.10.73])
        by smtp.gmail.com with ESMTPSA id r23sm5310611qtp.60.2021.09.17.21.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 21:02:21 -0700 (PDT)
Date:   Sat, 18 Sep 2021 09:37:30 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 30 years since the Linux 0.01 release
Message-ID: <YUVmAhDSX07pV4ru@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=whOsdfVrXHRJir0gu4Y3-K+nDkk7jAAWg15xu0jfQ9hpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6WgK9xsEpLYCfvqQ"
Content-Disposition: inline
In-Reply-To: <CAHk-=whOsdfVrXHRJir0gu4Y3-K+nDkk7jAAWg15xu0jfQ9hpg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6WgK9xsEpLYCfvqQ
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 13:02 Fri 17 Sep 2021, Linus Torvalds wrote:
>This is just a random note to let people know that today is actually
>one of the core 30-year anniversary dates: 0.01 was uploaded Sept 17,
>1991.
>
>Now, that 0.01 release was never publicly announced, and I only
>emailed a handful of people in private about the upload (and I don't
>have old emails from those days), so there's no real record of that.
>The only record of the date is in the Linux-0.01 tar-file itself, I
>suspect.
>
>Alas, the dates in that tar-file are for the last modification dates,
>not the actual creation of the tar-file, but it does seem to have
>happened around 7:30pm (Finnish time), so the exact anniversary was
>technically a couple of hours ago.
>
>Just thought I'd mention it, since while unannounced, in many ways
>this is the true 30th anniversary date of the actual code.
>
>                Linus

Cool ! Thanks a bunch!

Bhaskar

--6WgK9xsEpLYCfvqQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmFFZf4ACgkQsjqdtxFL
KRUXvgf/YcBfJDs1TMlUulnnGQPCjH+PmRxlFoHuHbAjzH53Iaok3IwF5DGQa2k4
6rPU3Bio9DkqMbi3/sM7nV7AaEtGXxyBSREeH+bfDnn1LP+aCDAu7of9cUYJS/s0
3m66Ty1MTRwdrPHJAHKtb3e5iIdf8ErfXZeBUIO7O7MnGxU1ztEjo0k3EqXwlhCz
aupFWNk+QUTCA/zRO0NYePbfWARtx3p0vY0PfkjBypB8PrMrRyTtX+n1dLCWSoYo
mu1xPTo/TU2RiJhksboaSCNtFwrpdlJ555/iOcOgjWmtuOeJg7ibbOC/Ytgod7zj
1AQWrTYk1Zqw3aEDhUvRpYvjqf959g==
=SpeU
-----END PGP SIGNATURE-----

--6WgK9xsEpLYCfvqQ--
