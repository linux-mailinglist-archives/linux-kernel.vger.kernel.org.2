Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944543B426E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 13:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhFYLYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 07:24:23 -0400
Received: from mout.gmx.net ([212.227.15.19]:37499 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229458AbhFYLYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 07:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624620116;
        bh=xiBdkAQS5W6nSZvOpWi4b/JamF6NrcqN871sbG/YZiM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=D3XljyM1hSXtdBaLRMRpv7qjpkvCtGeQd73NqbK6J3qNWepvlnVmku/hMVQWIdcs7
         7LB9EPHwPqMX6ajc8WjNBUqcznS8cffVJ5JfoiZwfZ53Xre+vUeVo5FR8aBFtAmY0g
         GPI/x1/zdsOx8CDyWaNtvOKR350NrDFaD3zI207o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [87.130.101.138] ([87.130.101.138]) by web-mail.gmx.net
 (3c-app-gmx-bs05.server.lan [172.19.170.54]) (via HTTP); Fri, 25 Jun 2021
 13:21:56 +0200
MIME-Version: 1.0
Message-ID: <trinity-163a08b4-6e39-4d15-bde2-815342f13fc4-1624620116191@3c-app-gmx-bs05>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux@armlinux.org.uk,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] serial: amba-pl011: add RS485 support
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 25 Jun 2021 13:21:56 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <db436292-4115-0755-57d8-d63986f84453@kernel.org>
References: <20210618145153.1906-1-LinoSanfilippo@gmx.de>
 <YNSA1H0cFKiPUn6N@kroah.com> <5d7a4351-2adc-ea31-3290-91d91bd5a5d4@gmx.de>
 <db436292-4115-0755-57d8-d63986f84453@kernel.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:t13vIl16khdstcPYHAPyke7bWV2T38BoLGJQ6MO3Y+sD5YMDA7zNe208y+GBCGh6Iqdih
 fdcpgn4J9jOxq3nQnVqn9KcQSx9WzAYpy0iP2IRLskCffzz4zfKMtHXRxG1/zvOG5Qcmz7BLumod
 nxawCM2cIzR/TLbrzR551Af+0EEnvq2e+913J+hRLn78aU0I/I+FHP/89OaXIjSZlMPqTYqZsDth
 5Mr3nIoQvQSyTWPRgQUopXTosMjlrBZinfl+groqjgL/HUWdwSllziFaBAGaM7hJV3ETolqRw2Mc
 8U=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:11NdH7Sil5g=:7LuhUINLhb5nAk8/8jwzyP
 W1JHaz1PGfm9rmQ8UETxxVYdDWgLmi7OSVpn2OiHw9/nGYUJn7B1eiZEN/i9U7e9sbFigb3HZ
 Ykw+EqbIsFF+cCKSVhfWgdBSIbCbiDp3N2cTOUj7nUHVcDntszinFKbnlF2gQu6QV1mtXDabI
 GaTWqV05gLf4x6V4LeeS1W7PvSRJ02GuVI8x8D/Ca9aZzc5CLzCfaKzfk7p35CFD19G2Y2fgb
 VTzim7A1vzq3XniDlWhkprgrB3LfFZ8WDEfCFaskEEa6XMuTMa4nSgWxQ68k/0pdJiOx7bDVp
 rtzaEvtZA81n8wepE46mw3U/aoPPPWu46BfLsFSYux7r98DAKBE3BlIZc8GFnUe5Sp9oKz/+r
 Oq59ZnpiCq2+lwAuYBRqCoA5laK1SzoQdWGDtllao8Dt75s9gSULCKC3c2RQ6dk8cbmUuzs4J
 ibVEFyGHj63VAG6B4HGix1SkaIg+3vyv/HMr1NpT34XcWmk33qZMimTt66fi0vXfUgsiPIrq9
 jaBvKIiYxUrmJ4NY6/K0DRX0N/vHIAN4RmhrB1ph8FTm5xfEzmCcd5MX2hfEQNDwtHmf5UDfG
 0P0xJ42S8tVA7h3PLmKokQw0XlQd67TlVlFtTA0RGnJauw8BWQIbrd2hdQrofhtmCjVTN/Z4G
 LrAUIBCHiw9G0syVo8o29K0rbhtY2y/pXGkwgCiicnC32slBhhnTzZj+QmmjAjBw4BkViVChu
 Lyf+HzSd20ko2AOANvcERK3YYHSWXZIkAz08kO3YhGbSfHoL7JTzI9oNexMHzzsY6oziDNBtC
 +KcL7Eh+s6hw/YkFU75aSknL2Zm/PEk4Y3e7eF3GECSK2SKXsg=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> On 25. 06. 21, 2:15, Lino Sanfilippo wrote:
> >>> +static int pl011_rs485_config(struct uart_port *port,
> >>> +			      struct serial_rs485 *rs485)
> >>> +{
> >>> +	struct uart_amba_port *uap =3D
> >>> +		container_of(port, struct uart_amba_port, port);
> >>> +
> >>> +	/* pick sane settings if the user hasn't */
> >>> +	if (!!(rs485->flags & SER_RS485_RTS_ON_SEND) =3D=3D
> >>
> >> Why the !! in an if statement?
> >>
> >>> +	    !!(rs485->flags & SER_RS485_RTS_AFTER_SEND)) {
> >>
> >> Same here, why?
> >>
> >
> > This was copied from serial8250_em485_config(). But I think we can sim=
ply use
> >
> > 	if (rs485->flags & SER_RS485_RTS_AFTER_SEND)
> > 		rs485->flags &=3D ~SER_RS485_RTS_ON_SEND;
> > 	else
> > 		rs485->flags |=3D SER_RS485_RTS_ON_SEND;
> >
> > instead. I will adjust the code accordingly.
>
> This is different. You want to set ON_SEND when none is set. And unset
> AFTER_SEND when both are set. In your code, when both are set, you leave
> AFTER_SEND.
>
> regards,
> --
> js
> suse labs
>

Thats right, the logic has slightly changed. I thought this does not matte=
r as long as
we make sure that exactly one of both ON_SEND or AFTER_SEND is set. We can=
 stick with the logic
in serial8250_em485_config() (i.e. always set ON_SEND and delete AFTER_SEN=
D in case
of an invalid setting), but I think this will require more than the four l=
ines that we
have now (especially if we want to avoid the !!).

Thanks,
Lino






