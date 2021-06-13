Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C143A5A78
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 22:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbhFMU4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 16:56:53 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]:33631 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbhFMU4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 16:56:51 -0400
Received: by mail-qk1-f170.google.com with SMTP id c9so10288333qkm.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 13:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=b2LNyJMlgo8nDWFIv/WryPH8LW1Bp7NMp73+XOWzCFs=;
        b=N3gO7o3p2ddc7C1GeTTDI+NXvU8mDLB4HhnqlB5oqxYT0JhGPWieQ+7D7qDTleRW2x
         i/FIi/NCug3H2zzS0ZVNjpEhK5RET6b0Nbf99uVzYsM8bZhKkNmZUKo1d0itD4hX8KhZ
         xT5W5ZFOBGYpe90Qhp5tguEb7ctxaJni1xJHthcLT536d4AGTBv1pfnxZZ2pK3KoCYD+
         4ce8N0DQJqUfGNRX/KLATfX2wYbss4G8piwvtaFMCzHiHFBL0BXAP8QwN7mGs2/wmqWm
         171xhGcURuXcn2YC74GjdgGpL8WebxFY4FtmMVYxaZNZZVAOgVkJhCWPZ8BXCNoA4cRM
         ovlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=b2LNyJMlgo8nDWFIv/WryPH8LW1Bp7NMp73+XOWzCFs=;
        b=jOGTpPZdyN7t3NzUspA6kWtg1yHhFW+UOyTFORzC5AmrUUB1vtbIPRuBdeAx710Vh7
         kD/QhPYXEfszxhg+7NmaXxiBfz58uIP4dBqYNx4f9qi5YcAAIsQ1/4bhAbP6h5RPnn0h
         zEX5Wd3eJiAPFCJWJVEhnxL88P3YVjPg7jm9Sk27tXC3+0ELfywDMf0pwc2nYqPN6DSP
         sdxkamRJTRvV9zNKtXDVUezbqDih7/xMbClTDHTozDzno1lmoCNFKHTwDrO8oAz72KSf
         i1W8apGuYGce9Nv905ypvjPA8VIFZNidk5Ljuf8+Bs/RawRj8ZZcjsL0H6EvEFt+CsXs
         ZE4Q==
X-Gm-Message-State: AOAM533ypFXhIQCL45g5g/9Swl7xUvbDizrLfmEM6maaeBHe9WGUTekY
        ADqObnwCLFVfmyFLplCw6tO60t1Yrxhr6P4T4mh8eg==
X-Google-Smtp-Source: ABdhPJw2kCkDI6JEYN7MXTnB+/YKV4EIu/R+EOtJbKKXvfm7wCepn3Zo5golfiF4nYXhGaEtQ4kuK4mzBAlMskw170U=
X-Received: by 2002:a37:a041:: with SMTP id j62mr13477533qke.155.1623617616017;
 Sun, 13 Jun 2021 13:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210613183520.2247415-1-mw@semihalf.com> <20210613183520.2247415-3-mw@semihalf.com>
 <20210613184409.GQ22278@shell.armlinux.org.uk>
In-Reply-To: <20210613184409.GQ22278@shell.armlinux.org.uk>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Sun, 13 Jun 2021 22:53:23 +0200
Message-ID: <CAPv3WKf=ufQYS+yRNwkhU9RQiSc_sNxW_+GgSJEhLGtrqUWzPQ@mail.gmail.com>
Subject: Re: [net-next: PATCH 2/3] net: mvpp2: enable using phylink with ACPI
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Grzegorz Bernacki <gjb@semihalf.com>, upstream@semihalf.com,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        Jon Nettleton <jon@solid-run.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


niedz., 13 cze 2021 o 20:44 Russell King (Oracle)
<linux@armlinux.org.uk> napisa=C5=82(a):
>
> On Sun, Jun 13, 2021 at 08:35:19PM +0200, Marcin Wojtas wrote:
> >
> >       /* Phylink isn't used w/ ACPI as of now */
> > -     if (port_node) {
> > +     if (!mvpp2_use_acpi_compat_mode(port_fwnode)) {
>
> Does this comment need to be updated?
>

It does. I'll update in v2.

Thanks,
Marcin
