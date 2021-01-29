Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC232308243
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 01:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhA2ANH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 19:13:07 -0500
Received: from mail.micronovasrl.com ([212.103.203.10]:39520 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbhA2ANF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 19:13:05 -0500
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id 07440B04740
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 01:12:22 +0100 (CET)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=x-mailer:to:date:date:message-id:subject:subject:mime-version
        :from:from:content-transfer-encoding:content-type:content-type;
         s=dkim; t=1611879141; x=1612743142; bh=Wr6MLSMlyPXVN/vYt5Eb7iob
        yfPMoz/1ggaiwP4YGds=; b=b+pEq5b6+HYmN+QAIvljw/pkqpqhrzYXsJAzkzV8
        JD9tZM4oX9dDMXb0iZH8gG+vGTEjGVT0289O29TFHeIpk2qEM8b9mS9FlSyoz1pA
        LIbo3utyGgjJ8QX4mE5arqqF4NHt9u50ECM9DFJOW76jR8zsvY79OhvtLTQqV03Z
        EwQ=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-10 required=4.5
        tests=[ALL_TRUSTED=-1, BAYES_00=-1.9]
        autolearn=unavailable autolearn_force=no
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EfvVmfHhPwuj for <linux-kernel@vger.kernel.org>;
        Fri, 29 Jan 2021 01:12:21 +0100 (CET)
Received: from [192.168.50.29] (146-241-182-37.dyn.eolo.it [146.241.182.37])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id A4237B04493;
        Fri, 29 Jan 2021 01:12:20 +0100 (CET)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 0/3] Handle UART without interrupt on TEMT using em485
Message-Id: <5FC36FF8-8F09-4B82-92C0-BE5E0AA2C117@micronovasrl.com>
Date:   Fri, 29 Jan 2021 01:12:20 +0100
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        andriy.shevchenko@linux.intel.com, matwey.kornilov@gmail.com,
        lukas@wunner.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com, heiko@sntech.de,
        heiko.stuebner@theobroma-systems.com
To:     Eric Tremblay <etremblay@distech-controls.com>
X-Mailer: iPhone Mail (18C66)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=EF=BB=BFHi Eric,

> Il giorno 29 gen 2021, alle ore 00:37, Eric Tremblay <etremblay@distech-co=
ntrols.com> ha scritto:
>=20
> =EF=BB=BFThe series is mainly about the support of 8250 UART without TEMT
> interrupt. I saw that there was some development in the past but
> it was never merged. Since the last discussion were quite some
> time ago, I was not sure if I should post a v4 over the
> last v3 or start from scratch so I decided to post a new patch. Please
> advice if I should have done the reverse.

Please keep my and Heiko=E2=80=99s SoB and add your SoB too describing betwe=
en [ ] what Heiko has done and what you=E2=80=99ve done.=20
For example:
SoB: Giulio
SoB: Heiko
[Heiko: ...]
SoB Eric
[Eric: improved timeout etc.]

>=20
> The approach is a little different from the last proposed patch which was
> doing using a polling at 100us. I tought that it could be really long on=20=

> some fast baudrate and really not that long on slow baudrate. The current
> approach is to calculate the time of a bytes when the settings are changed=
.
> When we get the interrupt for the empty FIFO, it's the longer it can take
> to empty the shift register.

Good idea.

>=20
> The other two patches are to use that features with the PORT_16550A_FSL64
> found on some chip like the LS1043A.

Do you mind to add my 8250_dw patch that was originally part of this patchse=
t? I had to send it
soon, you=E2=80=99ve preceded me :-)

Thank you
Best regards
Giulio

>=20
> Thanks
>=20
> Eric Tremblay (3):
> serial: 8250: Handle UART without interrupt on TEMT using em485
> serial: 8250: add compatible for fsl,16550-FIFO64
> serial: 8250: remove UART_CAP_TEMT on PORT_16550A_FSL64
>=20
> drivers/tty/serial/8250/8250.h            |  1 +
> drivers/tty/serial/8250/8250_bcm2835aux.c |  2 +-
> drivers/tty/serial/8250/8250_of.c         |  5 ++
> drivers/tty/serial/8250/8250_omap.c       |  2 +-
> drivers/tty/serial/8250/8250_port.c       | 89 ++++++++++++++++++++++-
> include/linux/serial_8250.h               |  2 +
> 6 files changed, 98 insertions(+), 3 deletions(-)
>=20
> --=20
> 2.17.1

