Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC2538F0FA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 18:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237395AbhEXQHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 12:07:49 -0400
Received: from m32-153.88.com ([43.250.32.153]:60956 "EHLO email.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235702AbhEXQAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 12:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=Date:From:To; bh=eTi1+Ts+2Eo57YYXEQfPHusA2s3E5JfUy53ss
        sDiL7A=; b=lawxqCx5Oz/PZTRgGYJSV3O5fWUGiJDnVY8z6z2ePoJZ/c/1GRBl6
        FZuqpKvg0/EM8t7vi6apjH+u5g+X3Xa8kcrUa+ZIm14KMtoMge9Gs+ptPv4hzka4
        o3k3UwIQdQnyZkZX1Qbed/mkUFxAw2S7UjJ8U+8F64b2pDZJhgecrE=
Received: from bobwxc.top (unknown [120.238.248.9])
        by v_coremail2-frontend-2 (Coremail) with SMTP id GiKnCgDXJlkgzatgBVFGAA--.41751S2;
        Mon, 24 May 2021 23:58:26 +0800 (CST)
Date:   Mon, 24 May 2021 23:58:24 +0800
From:   "Wu X.C." <bobwxc@email.cn>
To:     Hu Haowen <src.res@email.cn>
Cc:     alexs@kernel.org, corbet@lwn.net, maskray@google.com,
        bernard@vivo.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] docs/zh_CN: create new translations for
 zh_CN/dev-tools/testing-overview
Message-ID: <20210524155823.GA28790@bobwxc.top>
References: <20210523140332.GA1097@bobwxc.top>
 <c5f5ee6a-46f8-ff72-059d-baeba42d234f@email.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <c5f5ee6a-46f8-ff72-059d-baeba42d234f@email.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CM-TRANSID: GiKnCgDXJlkgzatgBVFGAA--.41751S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUU5d7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcV
        AFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv
        67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wASzI0EjI02j7AqF2xKxwAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        74AGY7Cv6cx26F4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5V
        A0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VWxJr1U
        JwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
        vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
        x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
        xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
        wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VU0mhF7UUUUU==
X-Originating-IP: [120.238.248.9]
X-CM-SenderInfo: pere453f6hztlloou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 24, 2021 at 08:13:50PM +0800, Hu Haowen wrote:
>=20
> OK, I'll correct them.
>=20
>=20
> Because this is my first time to kernel translation work, there might
> be something wrong, after all thanks for pointing them out.
>=20

Welcome to join us! <http://fars.ee/3TKR.gif>

The points which I given are just suggestions. If you have any ideas or
questions, just ask/say.

Thanks,
         Wu X.C.


--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEERbo3U5kJpaCtFl1PtlsoEiKCsIUFAmCrzRsACgkQtlsoEiKC
sIWA3gv9FX1AiiM5eHPPqkPAK9HTqqjE/U89WpSgnfdx5hyxO3AQxdmLWj+MudOc
rWE3bBj1Sy4K1AKmeUliKl94Z/8l2cAGREASbpHGIVR7WevS8sdTiry7Wm18yOjT
GZoLYDomq1JBfsT1Emnfvpu58RrOHEw+9+1hShaA6yWCsR08BPiYmaMwm4o7NgxW
ClXgbo2rT+MqEyybfDkKf+WodZq9CPcoG5gr6JVuVBPhhvAs7JeiLwrb6EhOi70c
yr/gJrQZc0tmoazTC+HcSdrgDqto5EfRbPwftUDfdj69FPdutviPg2qRaipfiZT1
TOwFzWy87+aS+p0Vdu2OUrmusLSjWdvoDu/FtiHUZ2ojnw+fHLctu+d9LYcXtc0D
WO0w0qkSS40TJ3U0moWFrxuT1HQZXK6+yiZzllUzKoeuMY2FNsVgudcX3MM8vLpf
F/pqzvUXJdweAk9wv/XHQep4XXqcUv8nQaE7rcKoBLhvZ07JhrL6U1Z1Z7QHss3v
L5yc3F7T
=wHUy
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--

