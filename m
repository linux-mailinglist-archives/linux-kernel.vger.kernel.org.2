Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A9C41FB0E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 13:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbhJBLO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 07:14:27 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:34030 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbhJBLOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 07:14:24 -0400
Date:   Sat, 02 Oct 2021 11:12:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1633173156;
        bh=lgKYE1UiXuqTBPdG3LxCk9lKMfDD0+fFAGQZZoEkMbo=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=mjCJHoAimPW9nMZizBL0WRXceUbhh11sNYJIep1ZKuS2ZTWaXsfnZkK8pjfnACbyE
         kjOeMQwNPA5ttApgbgHKhs9XORQj87Mo+hv40E4wGKS1XoBb3CBRubT7YlE2j/LP/C
         +ZrG9A7c7Cng0Y1ipBVi8mYGUjPaWVGgY/ucSk6M=
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
From:   Orlando Chamberlain <redecorating@protonmail.com>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Reply-To: Orlando Chamberlain <redecorating@protonmail.com>
Subject: Re: [PATCHv3] mfd: intel-lpss: Add support for MacBookPro16,2 ICL-N UART
Message-ID: <20211002111221.1c3076f3@localhost>
In-Reply-To: <YVg8vsdU89wjC9/7@smile.fi.intel.com>
References: <20211001084905.4133-1-redecorating@protonmail.com> <YVbf9J3jgAmBY+ch@smile.fi.intel.com> <YVdP9PwNrjmKxKac@google.com> <YVdR4bdpr9/E+GNf@smile.fi.intel.com> <20211002032810.3729-1-redecorating@protonmail.com> <YVg8vsdU89wjC9/7@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 02 Oct 2021 21:04:30 +1000
"Andy Shevchenko" <andriy.shevchenko@linux.intel.com> wrote:

> You ignoring my Reviewed-by tag. Any reason why?

Sorry, I'm new to this and assumed it needed to be reviewed again after
any changes (including to the commit message).

> Besides that you are posting patches as continuation of the thread.
> It may be problematic for some tools, like `b4`, although I dunno if
> Lee is using such tools.

I'll make a v4 with the reviewed-by line. I'll make it a reply to the
first version of the patch, and hopefully that'll be the first place
tools like `b4` look.

> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> > Signed-off-by: Orlando Chamberlain <redecorating@protonmail.com>
> > ---
> > v2->v3: Mention "ICL-N" in commit message.
> >  drivers/mfd/intel-lpss-pci.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/mfd/intel-lpss-pci.c
> > b/drivers/mfd/intel-lpss-pci.c index c54d19fb184c..a872b4485eac
> > 100644 --- a/drivers/mfd/intel-lpss-pci.c
> > +++ b/drivers/mfd/intel-lpss-pci.c
> > @@ -253,6 +253,8 @@ static const struct pci_device_id
> > intel_lpss_pci_ids[] =3D { { PCI_VDEVICE(INTEL, 0x34ea),
> > (kernel_ulong_t)&bxt_i2c_info }, { PCI_VDEVICE(INTEL, 0x34eb),
> > (kernel_ulong_t)&bxt_i2c_info }, { PCI_VDEVICE(INTEL, 0x34fb),
> > (kernel_ulong_t)&spt_info },
> > +=09/* ICL-N */
> > +=09{ PCI_VDEVICE(INTEL, 0x38a8),
> > (kernel_ulong_t)&bxt_uart_info }, /* TGL-H */
> >  =09{ PCI_VDEVICE(INTEL, 0x43a7),
> > (kernel_ulong_t)&bxt_uart_info }, { PCI_VDEVICE(INTEL, 0x43a8),
> > (kernel_ulong_t)&bxt_uart_info }, --
> > 2.33.0
> >
> > =20
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20
>=20



--=20

