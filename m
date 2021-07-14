Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D063C8375
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 13:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239234AbhGNLOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 07:14:15 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:53176 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhGNLOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 07:14:14 -0400
Date:   Wed, 14 Jul 2021 11:11:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1626261080;
        bh=XZpIQ24WJhcrbC5qIW722WTB+k6I0u/yeXC/Ecagims=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=r+VblyeeS7Evgs7zAmut3hAwwnWG18EkVHoorYfnB/Z2vi6G+AIXQqjBiag5q+N/a
         nfp/heoD/P22LfDQu06qTnAG1HSfUbU7fXzuxx9uRYeWUJAmkkjMbP/jUVnzotnfmr
         NChP3WteelhM1+Tjx0zIT4l+TuxCbSBlgs9BKgAY=
To:     Kees Cook <keescook@chromium.org>
From:   bowsingbetee <bowsingbetee@protonmail.com>
Cc:     Sergei Trofimovich <slyfox@gentoo.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>
Reply-To: bowsingbetee <bowsingbetee@protonmail.com>
Subject: Re: [PATCH] mm: page_alloc: fix page_poison=1 / INIT_ON_ALLOC_DEFAULT_ON interaction
Message-ID: <Uw6pNgiHmif9MJPCW3QYgIzcFUoL5wATgnqN4rNUrbpzsGtNvEg0CjiUnqu_LVpuf2Zs8uHUQ8Jz6fpdf30VZdAKpSH0we8NN2iNZVY2YVY=@protonmail.com>
In-Reply-To: <202107131953.BB3627156@keescook>
References: <20210712005732.4f9bfa78@zn3> <20210712215816.1512739-1-slyfox@gentoo.org> <202107131953.BB3627156@keescook>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="---------------------8055d049a38c66e040db4588eef9b23f"; charset=utf-8
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
-----------------------8055d049a38c66e040db4588eef9b23f
Content-Type: multipart/mixed;boundary=---------------------7e03e968f424d4101c25004754ff0d9d

-----------------------7e03e968f424d4101c25004754ff0d9d
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8


=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original M=
essage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90

On Wednesday, July 14th, 2021 at 5:10 AM, Kees Cook <keescook@chromium.org=
> wrote:

> On Mon, Jul 12, 2021 at 10:58:16PM +0100, Sergei Trofimovich wrote:
> =


> > To reproduce the failure we need the following system:
> > =


> > -   kernel command: page_poison=3D1 init_on_free=3D0 init_on_alloc=3D0
> >     =


> > -   kernel config:
> >     =


> >     -   CONFIG_INIT_ON_ALLOC_DEFAULT_ON=3Dy
> >     -   CONFIG_INIT_ON_FREE_DEFAULT_ON=3Dy
> >     -   CONFIG_PAGE_POISONING=3Dy
> >     =


> >     0000000085629bdd: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
................
> >     =


> >     0000000022861832: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
................
> >     =


> >     00000000c597f5b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
................
> >     =


> >     CPU: 11 PID: 15195 Comm: bash Kdump: loaded Tainted: G U O 5.13.1-=
gentoo-x86_64 #1
> >     =


> >     Hardware name: System manufacturer System Product Name/PRIME Z370-=
A, BIOS 2801 01/13/2021
> >     =


> >     Call Trace:
> >     =


> >     dump_stack+0x64/0x7c
> >     =


> >     __kernel_unpoison_pages.cold+0x48/0x84
> >     =


> >     post_alloc_hook+0x60/0xa0
> >     =


> >     get_page_from_freelist+0xdb8/0x1000
> >     =


> >     __alloc_pages+0x163/0x2b0
> >     =


> >     __get_free_pages+0xc/0x30
> >     =


> >     pgd_alloc+0x2e/0x1a0
> >     =


> >     ? dup_mm+0x37/0x4f0
> >     =


> >     mm_init+0x185/0x270
> >     =


> >     dup_mm+0x6b/0x4f0
> >     =


> >     ? __lock_task_sighand+0x35/0x70
> >     =


> >     copy_process+0x190d/0x1b10
> >     =


> >     kernel_clone+0xba/0x3b0
> >     =


> >     __do_sys_clone+0x8f/0xb0
> >     =


> >     do_syscall_64+0x68/0x80
> >     =


> >     ? do_syscall_64+0x11/0x80
> >     =


> >     entry_SYSCALL_64_after_hwframe+0x44/0xae
> >     =


> > =


> > Before the 51cba1eb ("init_on_alloc: Optimize static branches")
> > =


> > init_on_alloc never enabled static branch by default. It could
> > =


> > only be enabed explicitly by init_mem_debugging_and_hardening().
> =


> But init_mem_debugging_and_hardening() is always called (by mm_init()).
> =


> > But after the 51cba1eb static branch could already be enabled
> > =


> > by default. There was no code to ever disable it. That caused
> > =


> > page_poison=3D1 / init_on_free=3D1 conflict.
> > =


> > This change extends init_mem_debugging_and_hardening() to also
> > =


> > disable static branch disabling.
> > =


> > CC: Andrew Morton akpm@linux-foundation.org
> > =


> > CC: Kees Cook keescook@chromium.org
> > =


> > CC: Alexander Potapenko glider@google.com
> > =


> > CC: Thomas Gleixner tglx@linutronix.de
> > =


> > CC: Vlastimil Babka vbabka@suse.cz
> > =


> > CC: linux-mm@kvack.org
> > =


> > Reported-by: bowsingbetee@pm.me
> > =


> > Reported-by: Mikhail Morfikov
> > =


> > Fixes: 51cba1eb ("init_on_alloc: Optimize static branches")
> > =


> > Signed-off-by: Sergei Trofimovich slyfox@gentoo.org
> > ----------------------------------------------------------------------=
--------------------------------------------------------------------------=
--------------------------------------------------------------------------=
--------------------------------------------------------------------------=
--------------------------------------------------------------------------=
-----------------------------------
> > =


> > mm/page_alloc.c | 16 ++++++++++------
> > =


> > 1 file changed, 10 insertions(+), 6 deletions(-)
> > =


> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > =


> > index 3b97e17806be..46cb4a9c2b50 100644
> > =


> > --- a/mm/page_alloc.c
> > =


> > +++ b/mm/page_alloc.c
> > =


> > @@ -840,18 +840,22 @@ void init_mem_debugging_and_hardening(void)
> > =


> > }
> > =


> > #endif
> > =


> > -   if (_init_on_alloc_enabled_early) {
> > -       if (page_poisoning_requested)
> >         =


> >     =


> > =


> > -   if (_init_on_alloc_enabled_early ||
> > -       IS_ENABLED(CONFIG_INIT_ON_ALLOC_DEFAULT_ON)) {
> >         =


> >     =


> =


> This doesn't look right. _init_on_alloc_enabled_early already has the
> =


> same value:
> =


> static bool _init_on_alloc_enabled_early __read_mostly
> =


> =3D IS_ENABLED(CONFIG_INIT_ON_ALLOC_DEFAULT_ON);
> =


> So checking this is just a side-effect of how static_branch_maybe()
> =


> happens to be behaving.
> =


> > -       if (page_poisoning_requested) {
> >         	pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
> >         		"will take precedence over init_on_alloc\\n");
> >         =


> >     =


> > =


> > -       else
> >         =


> >     =


> > =


> > -       	static_branch_disable(&init_on_alloc);
> >         =


> >     =


> > -       } else
> >         	static_branch_enable(&init_on_alloc);
> >         =


> >     =


> >     }
> > =


> > -   if (_init_on_free_enabled_early) {
> > -       if (page_poisoning_requested)
> >         =


> >     =


> > =


> > -   if (_init_on_free_enabled_early ||
> > -       IS_ENABLED(CONFIG_INIT_ON_FREE_DEFAULT_ON)) {
> >         =


> >     =


> > -       if (page_poisoning_requested) {
> >         	pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
> >         		"will take precedence over init_on_free\\n");
> >         =


> >     =


> > =


> > -       else
> >         =


> >     =


> > =


> > -       	static_branch_disable(&init_on_free);
> >         =


> >     =


> > -       } else
> >         	static_branch_enable(&init_on_free);
> >         =


> >     =


> >     }
> =


> I think it would be better to clean this up without additional
> =


> confusion involving the CONFIGs:
> =


> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> =


> index 3b97e17806be..1f19365bc158 100644
> =


> --- a/mm/page_alloc.c
> =


> +++ b/mm/page_alloc.c
> =


> @@ -840,21 +840,24 @@ void init_mem_debugging_and_hardening(void)
> =


> }
> =


> #endif
> =


> -   if (_init_on_alloc_enabled_early) {
> -         if (page_poisoning_requested)
>         =


>     =


> -         	pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
>         =


>     =


> -         		"will take precedence over init_on_alloc\\n");
>         =


>     =


> -         else
>         =


>     =


> -         	static_branch_enable(&init_on_alloc);
>         =


>     =


> -   }
> -   if (_init_on_free_enabled_early) {
> -         if (page_poisoning_requested)
>         =


>     =


> -         	pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
>         =


>     =


> -         		"will take precedence over init_on_free\\n");
>         =


>     =


> -         else
>         =


>     =


> -         	static_branch_enable(&init_on_free);
>         =


>     =


> =


> -   if ((_init_on_alloc_enabled_early || _init_on_free_enabled_early) &&
> -         page_poisoning_requested) {
>         =


>     =


> -         pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
>         =


>     =


> -         	"will take precedence over init_on_alloc and init_on_free\\n"=
);
>         =



B & C variants show this message and A does not, which is what I would exp=
ect to happen.

Tested variants:

A. "page_poison=3D1 init_on_free=3D0 init_on_alloc=3D0 slub_debug=3DP"
B. "page_poison=3D1 init_on_free=3D0 init_on_alloc=3D0 slub_debug=3DP init=
_on_free=3D1"
C. "page_poison=3D1 slub_debug=3DP"

in common:
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=3Dy
CONFIG_INIT_ON_FREE_DEFAULT_ON=3Dy
CONFIG_PAGE_POISONING=3Dy
CONFIG_SLUB_DEBUG=3Dy
CONFIG_SLUB=3Dy

(the slub parts don't matter, ignore them)

>     =


> -         _init_on_alloc_enabled_early =3D false;
>         =


>     =


> -         _init_on_free_enabled_early =3D false;
>         =


>     =


>     }
> -   if (_init_on_alloc_enabled_early)
> -         static_branch_enable(&init_on_alloc);
>         =


>     =


> -   else
> -         static_branch_disable(&init_on_alloc);
>         =


>     =


> =


> -   if (_init_on_free_enabled_early)
> -         static_branch_enable(&init_on_free);
>         =


>     =


> -   else
> -         static_branch_disable(&init_on_free);
>         =


>     =


> =


> #ifdef CONFIG_DEBUG_PAGEALLOC
> =


> if (!debug_pagealloc_enabled())
> =


> return;
> =


> ------------------------------------------------------------------------
> =


> Kees Cook

While both patches(Sergei's, and yours) work for me, I'll be using this on=
e for now.

Thank you for your work!
Cheers!


-----------------------7e03e968f424d4101c25004754ff0d9d
Content-Type: application/pgp-keys; filename="publickey - bowsingbetee@protonmail.com - 0x65EDD6AE.asc"; name="publickey - bowsingbetee@protonmail.com - 0x65EDD6AE.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - bowsingbetee@protonmail.com - 0x65EDD6AE.asc"; name="publickey - bowsingbetee@protonmail.com - 0x65EDD6AE.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tDQpWZXJzaW9uOiBPcGVuUEdQLmpz
IHY0LjEwLjEwDQpDb21tZW50OiBodHRwczovL29wZW5wZ3Bqcy5vcmcNCg0KeHNCTkJHRHBwSk1C
Q0FESzFpOXA5MVEwZlRFRmd3MXN1YktuUXYzcVo1YmxXVjJBZzlvaUNNYk1waStqDQpXQVVJSU85
VDlsb2d0V3lZV0N4UUFaYzZ3NHpGUTZnL1REYUUzNU9Nc1dSUWt4YytMYkN6U0ozU1dCV1ENCk4z
ZmV3SW1iTkczZGVEazdqMFpyVzJ1OUQxZ3N6ZDFoMUZYM3d3d3lWem1zTU45V3oxSE9YR3Q0ellv
Sg0KRE45R2Nra3VwbUVVMFZWZ2QzRWthRDVsdXBEQWsvL3dpc0R5T2dRM1JSL2dPa2tXRUNuRnp2
TTNYNi91DQpyeUFkZVFZYXM5SFlRTjNIVHgyT1F4QWdaVGNsVTN3c2RVckpTRUtmUVBuWUVEWUVZ
eEpqZUJ5MzhuakINCmVSMCtrSlFCTHBMRG1CRnFjZ2tBbVRYT0kySjJyR0svY2hIUG1NcXJMN0Rk
Y3BuaVNhZEdrT1RKQUJFQg0KQUFITk9XSnZkM05wYm1kaVpYUmxaVUJ3Y205MGIyNXRZV2xzTG1O
dmJTQThZbTkzYzJsdVoySmxkR1ZsDQpRSEJ5YjNSdmJtMWhhV3d1WTI5dFBzTEFqUVFRQVFnQUlB
VUNZT21ra3dZTENRY0lBd0lFRlFnS0FnUVcNCkFnRUFBaGtCQWhzREFoNEJBQ0VKRUJoUE84QWNH
WXVFRmlFRVplM1dydmw2TUlOd3ZHbWdHRTg3d0J3Wg0KaTRUTjJBZjVBUjJ2T1hqQWZyMThzY0hr
bHkveTRJdUF1dDVqNUF6UDZsWkR1TUtER3kzRzQwc1lQRHFtDQpHWXFyT3ZROUQ3OWVlQzBkczhI
ZXpzcU11TGdCM2xxUnROeDV0S0JsMThxaDFwUHFBWFlFZkRsVGpDVTMNClJkUFdUSXI5U1JWQ08v
Y0kyNlNlenU2emx5WFdvQnIzbVB3MDRTcngvSTJtM205ZDdvSDBRbWg3N3FSbA0KUVc4RHFabXFM
TU9OYzJDakdZWmRTVEI3SWoyVGt3UmFHT1dzZHkrQnBUS0JHV2RhWnFWQW5PbjRMS0JwDQpSbmVa
VUZGTmQ2alpLejlocTZrcG90ZFNOZUFUbURadXNNaUN5ZWphZ1NYM1IvdlJDbGZnaUNBS3JnaXcN
CmZlSlhTQXhMZk5MV1hyd09xNlhrdUVWY2RZcElTcnNJLzNDQmlPdHpyb1IvcDQyUmVjN0FUUVJn
NmFTVA0KQVFnQXN2RzFpeUhuT0FBbjc2ZlNHaEgvN0pHL2VQQ3c4NlA3SUVuNytCUUw2N3JnYnYz
cDF6MHlFYldQDQpVRXhPUHRhMG5HN3F3VGFmekpIQTR0UkdrR3l1YklUMXQ3MldJWkhGQ0RKR3F0
bnd6dE1vVUhyR3NmdTYNCkxKRFhzZjB6bzYxZnJZNFJkTDVOOFVVZUs1RllnSWdFVExvaFZJNldt
SXVYWkNLZU5weVF3eFB0S05WcA0KYy9UVlBUNGRkK2JZZFduK3E2ak0zbmZET050RDBsYmNhSDBZ
RENwekQ5aUZTUzNKWExnb3lhZ0lnQXYrDQorNE1MT04rOFpIMGVvTVlPQWxtWlNpelJPcDdvK09j
YXkxZ0NCVUJvcS93eEpvU0NvVU9mRE8zMWViVUENCnpwTW0wakZiV3YybzVNbEY5RDNNdituRHQ2
bEx0Q3hldGovN01VRzZUUXlhdFFBUkFRQUJ3c0IyQkJnQg0KQ0FBSkJRSmc2YVNUQWhzTUFDRUpF
QmhQTzhBY0dZdUVGaUVFWmUzV3J2bDZNSU53dkdtZ0dFODd3QndaDQppNFQ4VEFnQWhXSHFocjRa
MGJDT0tnZU5PajVRT09KN2ZVRHdXdVAvbytLUUVtYmFJdXdIL3RJdVVWeWkNClVab0tWdFZhbEtn
NGtZL1U0cXJMRmpMdFlpYmJnTzRscy9sNzZwZkFPbVJzdXlNYm1Sc3dSaVp2c3FMTg0Kcng5SzZY
bzhCcUxINEMvcHhKeE0vTDhPQ0NSUDd5TUp3LzQ5RDVXUkh0dWh1Nkd0aHdSMjY0WHNTZys0DQpu
K2s3UjFPRktIcUpxY3hXdTJ1Sk1jYW5RY1B1U2lMUHhtcTNZeC93c2dmZlZRSm1CNmFXempOSjdu
Z0UNClNPMlJDQkJlSVRQR05Id2FHQnVrb1FzdzNDdlR3N1V4bGgwclM1ci9CaFEyUU9TRVduN2No
WU5SNUVQbA0KTGZ0VHBrRUxRdzl6aEIxbkt0MENMNTdrN1RPdWdkTmZMczFZdHpjT2RiaXliZkww
Qmc9PQ0KPTNPb0cNCi0tLS0tRU5EIFBHUCBQVUJMSUMgS0VZIEJMT0NLLS0tLS0NCg==
-----------------------7e03e968f424d4101c25004754ff0d9d--

-----------------------8055d049a38c66e040db4588eef9b23f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAGBQJg7sY6ACEJEBhPO8AcGYuEFiEEZe3Wrvl6MINwvGmgGE87
wBwZi4TRaQf/aSfcuhFwXQ3epeil1wgHIcgjWa4xPBFQZlaSNTVFgh6L9XFE
0BZakt0JlEZptqX612c/4sVOGXPv548z9cwEtLwPkchMcuZJ3fLHwr11F4pg
ZEoSOe0ABSy5sw4q5hIxuKS4GDVOJB/DmzhCLWVNTzZDJtFB0SxOvHAd8yI6
URJHRO3reVwF738yPYAOJDadT4lfZKemcn6kySDpQ7OmVJSbO/tfFHbSlcKV
3cmVJLG788FnRBy3j8DI+Fz0D4xF0rMlOuYNzhUygKZKvMAUiek5WlXMeTc8
1PkZETKdv9zHONgNz686lVdjICroWrxysg420d95styaZNxfDQwi3A==
=4kLn
-----END PGP SIGNATURE-----


-----------------------8055d049a38c66e040db4588eef9b23f--

