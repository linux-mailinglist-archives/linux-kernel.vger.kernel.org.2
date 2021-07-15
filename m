Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B013C999C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 09:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240340AbhGOH3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 03:29:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229973AbhGOH3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 03:29:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E65B6128B;
        Thu, 15 Jul 2021 07:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626333998;
        bh=MX13di5LHd3D7Na23Fk3TKOgbM5nHbJhT3eiJPdsLTE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=V2888euA4ssGyF8u3AyHMeAqPi0aG/qo+WA8gLqa3qOiD/A17zXq0oBWYMrEIw2jN
         n4hLAOG8XzK2t+BQF5Vz+TLJnoKfyvAPwzpe2MxaSSmBKjVyIcjC84bjJ0LRIB52vt
         v1Iqaw03ng88nJdyhdnk4EQIBs751zMrB0X5SEc9MrPfz+ckbDD4RqidZ3SBoyo1DS
         gBjlwPc7lvhdTYz0aZS5ZMVHH7+TdSzVG91a/0hW+RxjYwj+06FhFL+yY7LZKEKp/s
         HVGjXhlvtWq3tCzqhL0UCpzcZQ9MvvgJOyytei9kZRWKJ1OyuKxKociaRA6fyx+k1H
         Z/gh/y6RXqMXA==
From:   Felipe Balbi <balbi@kernel.org>
To:     Jia He <justin.he@arm.com>, linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>, nd@arm.com,
        Jia He <justin.he@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Chen Lin <chen.lin5@zte.com.cn>, linux-usb@vger.kernel.org
Subject: Re: [PATCH RFC 10/13] usb: gadget: simplify the printing with '%pD'
 specifier
In-Reply-To: <20210715031533.9553-11-justin.he@arm.com>
References: <20210715031533.9553-1-justin.he@arm.com>
 <20210715031533.9553-11-justin.he@arm.com>
Date:   Thu, 15 Jul 2021 10:26:29 +0300
Message-ID: <874kcwyr4q.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Jia He <justin.he@arm.com> writes:

> After the behavior of '%pD' is changed to print the full path of file,
> the log printing in fsg_common_create_lun() can be simplified.
>
> Given the space with proper length would be allocated in vprintk_store(),
> it is worthy of dropping kmalloc()/kfree() to avoid additional space
> allocation. The error case is well handled in d_path_unsafe(), the error
> string would be copied in '%pD' buffer, no need to additionally handle
> IS_ERR().
>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Chen Lin <chen.lin5@zte.com.cn>
> Cc: linux-usb@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Jia He <justin.he@arm.com>

Acked-by: Felipe Balbi <balbi@kernel.org>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCAAvFiEE9DumQ60WEZ09LIErzlfNM9wDzUgFAmDv4yURHGJhbGJpQGtl
cm5lbC5vcmcACgkQzlfNM9wDzUjJKAgAiATl1ws5K/uJxFsWiLFkdu88ekG4GdT8
6UEm/gfpSpJL/co64jwkj+ZgLVlftmWR2rMhy3Z33nBqcHDac1P1Z01dzEz7pHq1
ObBhXD9Fa/Mcv9JlMT7nkuoThwGW8Z7Nk+s7YKKSoen0W8rOMGJ2jxDWOohHlu9y
d+I+GrUMJGYtk1pdrkVslr6f9TlPXg0p7/dzaQZonQLrBMoAliOZPK/Ahzqi/Mig
NPzBY/u1OIvo1XJw2xZRYKnhDOYSsyE79FjZJOhrxvfElQntsOUSNRhR5bwrenxN
Sg1FWu1+fJRXlZZVygHbfvvvvkl7jRgorkBOfKlzVWWeiQxDpXbbNQ==
=GqR6
-----END PGP SIGNATURE-----
--=-=-=--
