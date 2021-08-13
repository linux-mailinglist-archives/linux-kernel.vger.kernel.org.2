Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48DB3EBBAB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 19:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbhHMRrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 13:47:43 -0400
Received: from home.keithp.com ([63.227.221.253]:53698 "EHLO elaine.keithp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229919AbhHMRrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 13:47:42 -0400
X-Greylist: delayed 515 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Aug 2021 13:47:42 EDT
Received: from localhost (localhost [127.0.0.1])
        by elaine.keithp.com (Postfix) with ESMTP id 18CD23F305B7;
        Fri, 13 Aug 2021 10:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
        t=1628876297; bh=C899dx3Df3AlBcC6RWdM9Ct3+jWx0MfYIIh4qIowBy4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=XNpjLFqEaE+lVTXQIyoF7fyW7xynfMQrnC+oTY140zTc2Kv7Uja9mNxoEdf4MJRNZ
         QsNwrwIO4PTqo5g8CN0X1/Cb4AJ9lomKgaLkaVT5dRMQ8TMfbcuSne28+KbLVMk+DH
         8E6zELU5tRq+lrNB4hiGrsgxwmPAdPnlrAbXgAEskIVPVvKS1BF951kT9b7pYt7I4v
         GOupgWlQ6ShPfSaVSpaMOBggWnmtPW5Ys8+ScyIM96kpTpnTdwpsGtEwtQ6MesZ2u8
         hwo1129wooZyg9QjrPcP/5sfXMFHtiVvNItrkJQqiRRvILUw6HAz1O1dGF/mqFH4TX
         O//JxFCQONEnA==
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
        by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id Lh7T-VbpyHUU; Fri, 13 Aug 2021 10:38:12 -0700 (PDT)
Received: from keithp.com (koto.keithp.com [192.168.11.2])
        by elaine.keithp.com (Postfix) with ESMTPSA id 502D13F305B6;
        Fri, 13 Aug 2021 10:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
        t=1628876292; bh=C899dx3Df3AlBcC6RWdM9Ct3+jWx0MfYIIh4qIowBy4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=WMUxnb716BUu/6RWZggAojWV5Ms3XYq97jzlCiJPwldHoADb4VBLxcFjrRw2wVVuS
         6aMOXrLVGGuXkOf+H+kEykM1JdyIxzge+ZvExd5WiK0kcc9D79fY6MF4m7LNA4ae6V
         ibGkitZWlaAqEp3Z5BIrd6Bsojjedp2/ElwxAXbupEqeKqeuqnOiehJZ3wWs+KJIC7
         DKar7ZgOSLwVkxDicaUt7mwRzOx1RgIHFl7YdzHvc/t1Yj1S2ssMYjaPa4EkZGfB9d
         nuwz3UmHGrW352OX8jMp6FA8wcc9Yi22UBlWTsCy5oBiuTNJtaOm7wrzns/zol7T+R
         iWuCRRWnZuWsA==
Received: by keithp.com (Postfix, from userid 1000)
        id 62D8C1E60119; Fri, 13 Aug 2021 10:38:34 -0700 (PDT)
From:   Keith Packard <keithp@keithp.com>
To:     Salah Triki <salah.triki@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: misc: chaoskey: remove useless else
In-Reply-To: <20210813164049.GA2310720@pc>
References: <20210813164049.GA2310720@pc>
Date:   Fri, 13 Aug 2021 10:38:34 -0700
Message-ID: <87bl61utwl.fsf@keithp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Salah Triki <salah.triki@gmail.com> writes:

> Remove useless else in order to make the code cleaner.

> -	if (!dev->present) {
> -		if (dev->open =3D=3D 0) {
> -			mutex_unlock(&dev->lock);
> +	mutex_unlock(&dev->lock);
> +
> +	if (!dev->present)
> +		if (dev->open =3D=3D 0)
>  			chaoskey_free(dev);
> -		} else
> -			mutex_unlock(&dev->lock);
> -	} else
> -		mutex_unlock(&dev->lock);

This accesses dev->present outside of the lock region introducing a
potential race condition.

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAmEWrhoACgkQ2yIaaQAA
ABGrbQ/+O0U3SxZLR2Hizm26TbH06UsEA5Mx4futZ23knkILxyPzMwSDeR2HFOTM
ZrYOSgs+1aTKW5a3rHbQQMMB8btXuyORcZTLwJCRrbIXX4O7vQbzdT9+iuPUqbbd
tlOleHpZLCCQipK3MUV02tpN+UH7IQ4UxmONjpLvFQBBA0mqNichpZ1Q0P2px4W8
ecjz4rS+jES3iLZLbQHkhLx37wePDzavUJ++yxDKlJ798PHfN6Jhint8W25IpyQ6
iaJdagoC6Xxo1IGXp+XJepu0PcqVTox4akS15PGhMQ7Kgdn9N5s3Bmv8QQ5JgjL3
DMFEt3hSmxdnZtFGbq++L4NS6s0Fmds21Da9zj4yZ3XKZ3vVkOsF/lXDOrdnmiVD
KwhtYqz3zbf0mTd4vUbnym6wTCONYnOb/hEahu6DFJL3wbC/NxvIIn7L68DgOHzC
7WTyfdqOkAeFPRY4oIxOQLCdDf3Q5hD9k9VOj9ymkL1iKbx5bcw+0g+5e145e4yG
f/in1d6EormuSTWyEwgMGDGxXEUHXJyHEqMBuXXtoeySIeEKXl8fzQAezDqxnh0J
b4irU4usWAA2+BuNxZ/bfaKrrRqWBDsWJt8oKaNrRaTeaPSFvtBfG6iAjndqm4oq
erMg5gpd6r0jd+44IBKHoIVRjT76n8+3PxxqYPlVctAvUMLX3NQ=
=GgHp
-----END PGP SIGNATURE-----
--=-=-=--
