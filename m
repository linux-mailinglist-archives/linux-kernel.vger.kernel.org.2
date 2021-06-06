Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219E139CE26
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 10:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhFFIfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 04:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhFFIf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 04:35:28 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED75C061766;
        Sun,  6 Jun 2021 01:33:23 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id a21so14785820oiw.3;
        Sun, 06 Jun 2021 01:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bbNhDWpus7Vqy++elTFF2iEsGgzPW8ROqotG54obcuI=;
        b=i96N6QWGWm7zvjN3WPpotNGq1GXRkmpKiocix4iI6kyfpJL8oK9v+MeXCZEcDTMVgO
         Pnv2K3oWkrp+jrr9PglH6OtrZTRc1gB3OjlzoA38ZmnY9d967ic3ObSAMDv2J0qn99I/
         tU6NkP0sQRLXi/+XkZL+wTAPkH/K7qtCACx1mh+bP9x7phUpjBsBXBmbFXScqGOLKaNQ
         VHlxIPvoiklXKB+VAxeYBZzgLUWEbgOCy3+cLtrg25iJ7aEnspQRBaiv9O71Vrp11yHB
         K7QyzIfdYCC7h1ztuOHDyET4ZDVvREqxsU5bZN5ciDKKCK/BA+W4qFVjfTie5Dp6xAbC
         ntlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bbNhDWpus7Vqy++elTFF2iEsGgzPW8ROqotG54obcuI=;
        b=jNNYlGzvCzcTbYGm64VCt9FcU5M+O+U17m0Yl8bx/rDR0WCOO4t1floeMf92O477iL
         BRghaYm8ZuKnfRYJ/v22AjM2PQ/3RAxZDMxSw4gz9GGV2mCNZq6EsiS1enofZLSBjBSe
         CofL3+o7O2HIftjZ5U9WlfWRXoWUHqpGBoP1v2x6GRRRy/8sKDyUUrP0g8uNwWR8yKWC
         FymUDZMKSIQAqnK7PtQz00uptAYstVLPUqyadEVPRdmpb6rQjW465lVCzbDFpXDobNiZ
         MuCioPdzfXfATj9ysMrl4/4JftcAlLtNwC71UKKTGXFHr4dAjsOtCnMakRMQaFL5irEs
         mjFw==
X-Gm-Message-State: AOAM531o28fU1CAnPpW43+u22mjlkW8vbopBhIULPxX1F7XtXuC3WSQf
        2OsJsWytXwEwyj50LCj3DAQFBjynY+vAHOXp2hU=
X-Google-Smtp-Source: ABdhPJzWUfyh4kFq0ITpR7cEBSO4EzXxXLb47VWIRpLOYiHIbKpHVXyPca9qa6dldU+mPHPado1BGSEP01v5c97xwRo=
X-Received: by 2002:a05:6808:1146:: with SMTP id u6mr16081901oiu.130.1622968402789;
 Sun, 06 Jun 2021 01:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210603131210.84763-1-colin.king@canonical.com> <20210604080503.GJ1955@kadam>
In-Reply-To: <20210604080503.GJ1955@kadam>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Sun, 6 Jun 2021 11:32:56 +0300
Message-ID: <CAFCwf10jJ1Kea8J9xwYgAbxW3P0L2ryPu5xBTN0cN_Zuxu49Pw@mail.gmail.com>
Subject: Re: [PATCH] habanalabs/gaudi: remove redundant assignment to variable err
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Colin King <colin.king@canonical.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-janitors@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 4, 2021 at 11:05 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Thu, Jun 03, 2021 at 02:12:10PM +0100, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > The variable err is being assigned a value that is never read, the
> > assignment is redundant and can be removed. Also remove some empty
> > lines.
> >
> > Addresses-Coverity: ("Unused value")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/misc/habanalabs/gaudi/gaudi.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
> > index 9e4a6bb3acd1..22f220859b46 100644
> > --- a/drivers/misc/habanalabs/gaudi/gaudi.c
> > +++ b/drivers/misc/habanalabs/gaudi/gaudi.c
> > @@ -7379,9 +7379,6 @@ static int gaudi_hbm_read_interrupts(struct hl_device *hdev, int device,
> >                       device, ch, hbm_ecc_data->first_addr, type,
> >                       hbm_ecc_data->sec_cont_cnt, hbm_ecc_data->sec_cnt,
> >                       hbm_ecc_data->dec_cnt);
> > -
> > -             err = 1;
> > -
> >               return 0;
> >       }
>
> Not related to your patch (which seems fine), but I always feel like
> there should be a rule that function which return a mix of negative
> error codes and either zero or one on success should have to have
> documentation explaining why.
>
> It's impossible to tell from the context here and neither of the callers
> check the return.  :P
>
> regards,
> dan carpenter
>
I agree and I will change the function to return only 0 on success, or
standard error value on error.

Anyway, this patch is:
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
