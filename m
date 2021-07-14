Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3346A3C8B87
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 21:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbhGNTWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 15:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240041AbhGNTWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 15:22:03 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDF3C061760
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 12:19:11 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id w13so2737904qtc.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 12:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1431emLU+9DMQjaf58AgKkMaZ89NMJDdYZGveaRyZc8=;
        b=ewaNd0vX4GRhu9Jkwg/MBikwijSm35AFEno566Wi+QKDEPuEaLiGKAMQfWuJAavZD6
         HvOOAY/PxJFY1C/o/W5IRjNDCxGdv/itLYVg+602BpB2pL8K2jyCG7hgsBkUTU+7Uao4
         EXqD0QdpD4XmvsmbGY9hiZ/XRdklJlUGg9tqOpIu0sDwxnb2wTM8eJyInHZX8afCM/qU
         hxphfjSctPqdg47TuuvMpzBw7hQQpvsNWkaaeb4gptkN8obUCcaRAx5+X27L5maDHIjS
         +VSMJ7AMfKsaDnSniW1iTc5J/gsxWqYdOlZuOVp/zNJUHGvde9llVem3ByKW8v87KLjT
         +stw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1431emLU+9DMQjaf58AgKkMaZ89NMJDdYZGveaRyZc8=;
        b=f9xXw/LS76dDN2RBSvpG7XxD1I2wNR5ohflIsQppcaBEg9C6Xo25CczfoZlYLg1Tva
         uK3QUNzQnJ5p7nZD3OvgX+oN0QrLCG0U1E9S6AIEzjDrSy7NRv/EdoPOfanWhy2Z161Z
         gmj10ML/zbJ4Fi2kel4aO1Ke1QXAeAAbJ2dSTJAIAFphTwEk5qZpGM8Zl1ftxIkwKjmc
         Uy9O+uDzRlWc7ex8dRFQ1WpfMILsucqbDm0jGmkQZNEhVg8acU5kRYNCi00rl1VhzeHp
         u/V1n8FBBYQe6/6Idm4S0CL0hW/0gK71PuwIbVyEWJ1xpVqhzeq2OSSo9wP33goht/TP
         paQQ==
X-Gm-Message-State: AOAM530nbEjVN2vGGbkwNtZcZU/Ffhz8rp4wnspHWk5XYHIn40V8iP+f
        +XmneK8SBpZKYjCdS+m/h4dABM/rMasMY/Y24ikTyQ==
X-Google-Smtp-Source: ABdhPJwJmJ6jcIPrmD/x4dHd+QLYr3DFDLSNWAPv/hxPJ/x5mb6Lq0R9AIrq3EJtWg2eVw5NzpZM8SKKCiszzExjSuQ=
X-Received: by 2002:aed:2064:: with SMTP id 91mr10637866qta.318.1626290350135;
 Wed, 14 Jul 2021 12:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210621200459.3558199-1-mw@semihalf.com> <CAJZ5v0jegOF85Zvo8Oyio9cSvb_WfUCG0oNsXzWHSCTi151u0A@mail.gmail.com>
In-Reply-To: <CAJZ5v0jegOF85Zvo8Oyio9cSvb_WfUCG0oNsXzWHSCTi151u0A@mail.gmail.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Wed, 14 Jul 2021 21:18:59 +0200
Message-ID: <CAPv3WKehvHfrbK8r0LhgbXvDVnzB=PSZQX7WihhNR+Y2+wKTrA@mail.gmail.com>
Subject: Re: [net-next: PATCH v3 1/1] ACPI: SPCR: Add new 16550-compatible
 Serial Port Subtype
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Grzegorz Bernacki <gjb@semihalf.com>, upstream@semihalf.com,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        Jon <jon@solid-run.com>, Tomasz Nowicki <tn@semihalf.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Robert Moore <robert.moore@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,


=C5=9Br., 14 lip 2021 o 14:27 Rafael J. Wysocki <rafael@kernel.org> napisa=
=C5=82(a):
>
> Sorry for the delay.
>
> On Mon, Jun 21, 2021 at 10:05 PM Marcin Wojtas <mw@semihalf.com> wrote:
> >
> > The Microsoft Debug Port Table 2 (DBG2) specification revision
> > May 31, 2017 adds support for 16550-compatible Serial Port
> > Subtype with parameters defined in Generic Address Structure (GAS) [1]
> >
> > Add its support in SPCR parsing routine.
> >
> > [1] https://docs.microsoft.com/en-us/windows-hardware/drivers/bringup/a=
cpi-debug-port-table
> >
> > Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> > ---
> >  include/acpi/actbl1.h | 1 +
> >  drivers/acpi/spcr.c   | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> > index ce59903c2695..f746012eba8d 100644
> > --- a/include/acpi/actbl1.h
> > +++ b/include/acpi/actbl1.h
>
> This is an ACPICA header, so the first part of the patch should go in
> via the ACPICA upstream repository.
>
> Can you please resend this as two patches to make it easier to process it=
?
>

I created a pull request to the ACPICA upstream with adding all the
missing DBG2 subtypes:
https://github.com/acpica/acpica/pull/705

Once that is accepted and lands, I will import the header update to
Linux along with the driver modification.

Best regards,
Marcin
