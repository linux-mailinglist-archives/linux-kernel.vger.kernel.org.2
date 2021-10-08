Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9121E427362
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 00:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243544AbhJHWHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 18:07:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:53500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231774AbhJHWHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 18:07:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F0FB60FC1;
        Fri,  8 Oct 2021 22:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633730719;
        bh=n293mMyacwXGRir18U0iXhtIXFN5a2t9ZMDrVeqgMKo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=uliAzaexfXE7N3oVzLssqW3d0M+Et1m28YwF5jmEst60Lk2thlaGWYYbwz5GJvr0F
         kaFZZyIIRdAnDLp49AQ3Xi+KpVq4g9C4bS17jDxWfAmMzFeVElDB8ZCSbPn+Quv2fv
         KEap/9OZRMS6WZb3RPfQzJVQL24BcSS+5VDlCO7b/a9AZEuz8t2e30S+EznCtCAYnG
         CQJfKGvKedp8DvC5NBTCleI7qqd51umn6rIkc1YrjM9bfEukHohyQ00TA7Hz0m7WG7
         lGeJNfzTNTE/0hCewXGUmAlx4ZCN470irhXHIuaNOHvuq3qPqREwbH2df5s85lQ4Cp
         Iww0KQoQ8yGYw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3ac4d209-58a7-60f3-a3c1-7a44407bac03@microchip.com>
References: <20210923132046.1860549-1-claudiu.beznea@microchip.com> <20210923132046.1860549-3-claudiu.beznea@microchip.com> <163366509609.2041162.16407625879723979586@swboyd.mtv.corp.google.com> <3ac4d209-58a7-60f3-a3c1-7a44407bac03@microchip.com>
Subject: Re: [PATCH v4 02/17] clk: at91: pmc: execute suspend/resume only for backup mode
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
To:     Claudiu.Beznea@microchip.com, Ludovic.Desroches@microchip.com,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        mturquette@baylibre.com
Date:   Fri, 08 Oct 2021 15:05:17 -0700
Message-ID: <163373071796.2041162.6436046910579417724@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu.Beznea@microchip.com (2021-10-07 23:47:14)
> On 08.10.2021 06:51, Stephen Boyd wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the content is safe
> >=20
> > Quoting Claudiu Beznea (2021-09-23 06:20:31)
> >> Before going to backup mode architecture specific PM code sets the fir=
st
> >> word in securam (file arch/arm/mach-at91/pm.c, function at91_pm_begin(=
)).
> >> Thus take this into account when suspending/resuming clocks. This will
> >> avoid executing unnecessary instructions when suspending to non backup
> >> modes. Also this commit changed the postcore_initcall() with
> >> subsys_initcall() to be able to execute of_find_compatible_node() since
> >> this was not available at the moment of postcore_initcall(). This shou=
ld
> >> not alter the tcb_clksrc since the changes are related to clocks
> >> suspend/resume procedure that will be executed at the user space reque=
st,
> >> thus long ago after subsys_initcall().
> >=20
> > Is the comment still relevant though?
>=20
> For architecture PM code yes, the securam is set in [1].
>=20
> Related to replacing postcore_init() with subsys_initcall() to be able to
> have the proper result of of_find_compatible_node() I have to re-check
> (don't know if something has been changed in this area since January). If
> you know something please let me know.

I mostly don't want to lose the comment if it is still useful.

>=20
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/a=
rch/arm/mach-at91/pm.c#n290
>=20
> >=20
> >>
> >> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> >> ---
> >> diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
> >> index b2806946a77a..58e9c088cb22 100644
> >> --- a/drivers/clk/at91/pmc.c
> >> +++ b/drivers/clk/at91/pmc.c
> >> @@ -110,13 +112,35 @@ struct pmc_data *pmc_data_allocate(unsigned int =
ncore, unsigned int nsystem,
> >>  }
> >>
> >>  #ifdef CONFIG_PM
> >> +
> >> +/* Address in SECURAM that say if we suspend to backup mode. */
> >> +static void __iomem *at91_pmc_backup_suspend;
> >> +
> >>  static int at91_pmc_suspend(void)
> >>  {
> >> +       unsigned int backup;
> >> +
> >> +       if (!at91_pmc_backup_suspend)
> >> +               return 0;
> >> +
> >> +       backup =3D *(unsigned int *)at91_pmc_backup_suspend;
> >=20
> > This will fail sparse. Why are we reading iomem without using iomem
> > reading wrapper?
>=20
> By mistake. I'll switch to iomem reading wrapper.
>=20
> Is it OK to send soon a new version with these adjustments or do you have
> other patches in this series to review?
>=20

Feel free to resend.
