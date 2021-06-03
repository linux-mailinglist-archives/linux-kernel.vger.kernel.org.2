Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C85F3399ABA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 08:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhFCGcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 02:32:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229721AbhFCGb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 02:31:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95EBA613DC;
        Thu,  3 Jun 2021 06:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622701814;
        bh=BhRyFNwHomU/dgrgKjNQe8jrhD4v9wOAEslsgHY7ZeU=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=Py9YcBv+u0uCsG2nOJR607Fa5h54fwuUL/WFnYgXLt6pYlhLAlwjP4BXC29/sxqFq
         CQFpMQy/Kp8YlthfcEJaUXzSCYzE8QDYuXjPIkcnOhzXPWEPc4MWmykA/5QR2551Q1
         uKLwzScoEvEo+RwM9HSIEUD38Fo2L0VYHU453tLIfGY83Cdi3QGPMaixq8/7H/buO0
         BAaqJ0HuRPQi7Nqk6RYdAuBku6hzCxNHQQEW4+TeBPcMxZk9I15X3XwVo60TBpkPlt
         JsyCx6hOxEU5Zpked0HJe5tY0yYdTfN4b+iGrt0kfBomHKP82y3tkMHXlovnKGp1kn
         63zZzR9wxALpg==
From:   Felipe Balbi <balbi@kernel.org>
To:     Alexandru Elisei <alexandru.elisei@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        p.zabel@pengutronix.de, linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        sanm@codeaurora.org
Subject: Re: [BUG] usb: dwc3: Kernel NULL pointer dereference in dwc3_remove()
In-Reply-To: <c3c75895-313a-5be7-6421-b32bac741a88@arm.com>
References: <c3c75895-313a-5be7-6421-b32bac741a88@arm.com>
Date:   Thu, 03 Jun 2021 09:30:05 +0300
Message-ID: <87r1hjcvf6.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi,

Alexandru Elisei <alexandru.elisei@arm.com> writes:
> I've been seeing the following panic when shutting down my rockpro64:
>
> [=C2=A0=C2=A0 21.459064] xhci-hcd xhci-hcd.0.auto: USB bus 5 deregistered
> [=C2=A0=C2=A0 21.683077] Unable to handle kernel NULL pointer dereference=
 at virtual address
> 00000000000000a0
> [=C2=A0=C2=A0 21.683858] Mem abort info:
> [=C2=A0=C2=A0 21.684104]=C2=A0=C2=A0 ESR =3D 0x96000004
> [=C2=A0=C2=A0 21.684375]=C2=A0=C2=A0 EC =3D 0x25: DABT (current EL), IL =
=3D 32 bits
> [=C2=A0=C2=A0 21.684841]=C2=A0=C2=A0 SET =3D 0, FnV =3D 0
> [=C2=A0=C2=A0 21.685111]=C2=A0=C2=A0 EA =3D 0, S1PTW =3D 0
> [=C2=A0=C2=A0 21.685389] Data abort info:
> [=C2=A0=C2=A0 21.685644]=C2=A0=C2=A0 ISV =3D 0, ISS =3D 0x00000004
> [=C2=A0=C2=A0 21.686024]=C2=A0=C2=A0 CM =3D 0, WnR =3D 0
> [=C2=A0=C2=A0 21.686288] user pgtable: 4k pages, 48-bit VAs, pgdp=3D00000=
0000757a000
> [=C2=A0=C2=A0 21.686853] [00000000000000a0] pgd=3D0000000000000000, p4d=
=3D0000000000000000
> [=C2=A0=C2=A0 21.687452] Internal error: Oops: 96000004EEMPT SMP
> [=C2=A0=C2=A0 21.687941] Modules linked in:
> [=C2=A0=C2=A0 21.688214] CPU: 4 PID: 1 Comm: shutdown Not tainted
> 5.12.0-rc7-00262-g568262bf5492 #33
> [=C2=A0=C2=A0 21.688915] Hardware name: Pine64 RockPro64 v2.0 (DT)
> [=C2=A0=C2=A0 21.689357] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=
=3D--)
> [=C2=A0=C2=A0 21.689884] pc : down_read_interruptible+0xec/0x200
> [=C2=A0=C2=A0 21.690321] lr : simple_recursive_removal+0x48/0x280
> [=C2=A0=C2=A0 21.690761] sp : ffff800011f4b940
> [=C2=A0=C2=A0 21.691053] x29: ffff800011f4b940 x28: ffff000000809b40
> [=C2=A0=C2=A0 21.691522] x27: ffff000000809b98 x26: ffff8000114f5170
> [=C2=A0=C2=A0 21.691990] x25: 00000000000000a0 x24: ffff800011e84030
> [=C2=A0=C2=A0 21.692459] x23: 0000000000000080 x22: 0000000000000000
> [=C2=A0=C2=A0 21.692927] x21: ffff800011ecaa5c x20: ffff800011ecaa60
> [=C2=A0=C2=A0 21.693395] x19: ffff000000809b40 x18: ffffffffffffffff
> [=C2=A0=C2=A0 21.693863] x17: 0000000000000000 x16: 0000000000000000
> [=C2=A0=C2=A0 21.694331] x15: ffff800091f4ba6d x14: 0000000000000004
> [=C2=A0=C2=A0 21.694799] x13: 0000000000000000 x12: 0000000000000020
> [=C2=A0=C2=A0 21.695267] x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f
> [=C2=A0=C2=A0 21.695735] x9 : 6f6c746364716e62 x8 : 7f7f7f7f7f7f7f7f
> [=C2=A0=C2=A0 21.696203] x7 : fefefeff6364626d x6 : 0000000000001bd8
> [=C2=A0=C2=A0 21.696671] x5 : 0000000000000000 x4 : 0000000000000000
> [=C2=A0=C2=A0 21.697138] x3 : 00000000000000a0 x2 : 0000000000000001
> [=C2=A0=C2=A0 21.697606] x1 : 0000000000000000 x0 : 00000000000000a0
> [=C2=A0=C2=A0 21.698075] Call trace:
> [=C2=A0=C2=A0 21.698291]=C2=A0 down_read_interruptible+0xec/0x200
> [=C2=A0=C2=A0 21.698690]=C2=A0 debugfs_remove+0x60/0x84
> [=C2=A0=C2=A0 21.699016]=C2=A0 dwc3_debugfs_exit+0x1c/0x6c
> [=C2=A0=C2=A0 21.699363]=C2=A0 dwc3_remove+0x34/0x1a0
> [=C2=A0=C2=A0 21.699672]=C2=A0 platform_remove+0x28/0x60
> [=C2=A0=C2=A0 21.700005]=C2=A0 __device_release_driver+0x188/0x230
> [=C2=A0=C2=A0 21.700414]=C2=A0 device_release_driver+0x2c/0x44
> [=C2=A0=C2=A0 21.700791]=C2=A0 bus_remove_device+0x124/0x130
> [=C2=A0=C2=A0 21.701154]=C2=A0 device_del+0x168/0x420
> [=C2=A0=C2=A0 21.701462]=C2=A0 platform_device_del.part.0+0x1c/0x90
> [=C2=A0=C2=A0 21.701877]=C2=A0 platform_device_unregister+0x28/0x44
> [=C2=A0=C2=A0 21.702291]=C2=A0 of_platform_device_destroy+0xe8/0x100
> [=C2=A0=C2=A0 21.702716]=C2=A0 device_for_each_child_reverse+0x64/0xb4
> [=C2=A0=C2=A0 21.703153]=C2=A0 of_platform_depopulate+0x40/0x84
> [=C2=A0=C2=A0 21.703538]=C2=A0 __dwc3_of_simple_teardown+0x20/0xd4
> [=C2=A0=C2=A0 21.703945]=C2=A0 dwc3_of_simple_shutdown+0x14/0x20
> [=C2=A0=C2=A0 21.704337]=C2=A0 platform_shutdown+0x28/0x40
> [=C2=A0=C2=A0 21.704683]=C2=A0 device_shutdown+0x158/0x330
> [=C2=A0=C2=A0 21.705029]=C2=A0 kernel_power_off+0x38/0x7c
> [=C2=A0=C2=A0 21.705372]=C2=A0 __do_sys_reboot+0x16c/0x2a0
> [=C2=A0=C2=A0 21.705719]=C2=A0 __arm64_sys_reboot+0x28/0x34
> [=C2=A0=C2=A0 21.706074]=C2=A0 el0_svc_common.constprop.0+0x60/0x120
> [=C2=A0=C2=A0 21.706499]=C2=A0 do_el0_svc+0x28/0x94
> [=C2=A0=C2=A0 21.706794]=C2=A0 el0_svc+0x2c/0x54
> [=C2=A0=C2=A0 21.707067]=C2=A0 el0_sync_handler+0xa4/0x130
> [=C2=A0=C2=A0 21.707414]=C2=A0 el0_sync+0x170/0x180
> [=C2=A0=C2=A0 21.707711] Code: c8047c62 35ffff84 17fffe5f f9800071 (c85ff=
c60)
> [=C2=A0=C2=A0 21.708250] ---[ end trace 5ae08147542eb468 ]---
> [=C2=A0=C2=A0 21.708667] Kernel panic - not syncing: Attempted to kill in=
it! exitcode=3D0x0000000b
> [=C2=A0=C2=A0 21.709456] Kernel Offset: disabled
> [=C2=A0=C2=A0 21.709762] CPU features: 0x00240022,2100600c
> [=C2=A0=C2=A0 21.710146] Memory Limit: 2048 MB
> [=C2=A0=C2=A0 21.710443] ---[ end Kernel panic - not syncing: Attempted t=
o kill init!
> exitcode=3D0x0000000b ]---
>
> I've been able to bisect the panic and the offending commit is 568262bf54=
92 ("usb:
> dwc3: core: Add shutdown callback for dwc3"). I can provide more diagnost=
ic
> information if needed and I can help test the fix.

if you simply revert that commit in HEAD, does the problem really go
away?

Oh wait, it should go away, yes. dwc3_shutdown() is just called
dwc3_remove() directly, then we end up calling
debugfs_remove_recursive() twice.

Sandeep, can you fix this one?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCAAvFiEE9DumQ60WEZ09LIErzlfNM9wDzUgFAmC4du0RHGJhbGJpQGtl
cm5lbC5vcmcACgkQzlfNM9wDzUjU2QgAsuhKv9NpOBoAVEzL72vhlr96CjubDz+d
wGrD13kHiDcgFe/qfcHML9i8CLr5/vPCLkX7SlhEOmIB6V67JztbkTDAEtVbryrE
HWtny6SqO/ix9NK6KSSMBz1GhpQ3U0jMGlSVPd57FUeAMjjT610o27rfi0NUFL43
KlEf4psU6vldBEZMM4uFxONURSpyUH7zjIiT4+zH5FlappJRjJAVzRtU58aYLkpQ
M7AfS9SG2ncEU0Vw1hdG9m4aXndiserCigf7GVgOO1dgDGvkglKFDrzKAsyTcjB4
jd7hzkjB7GgX3QVsAjBAY93b4Tm21GHlD+mP1tCdXI/PNa5U+CwNsA==
=IwbW
-----END PGP SIGNATURE-----
--=-=-=--
