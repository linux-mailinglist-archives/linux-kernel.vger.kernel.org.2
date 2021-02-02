Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D675530B3EF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 01:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbhBBAMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 19:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbhBBAMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 19:12:45 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F26C061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 16:12:04 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id g69so20867503oib.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 16:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SmHGIngOZeUrAahfaDVfuGgpv8akL47E4u3p5WZDk+g=;
        b=KJtnAjfMbcGKZFbSMkp1YoKXl9iMva59/FyWHVIEl9Z8KX8Iz7xdb75uCP33gQYoKZ
         er/Myc8K5a6WEO/mezJyCKYoD4McAuJvBm58D8xNzVXDyjfgV54IGyXoVF7+IHe6clif
         80wa/Uxns/cG2MRhNbRJyX2c2EBkCDgfsTIIoKttY8gQLa57F8qKPDfEhupAUIN+Wvco
         ILKTK3A6Ed/cAYPT4ffC0+gBjQiCnOC6h3FZ4HScaUi/oivtZvYKe2WNcJwXfSLnNNg2
         wlNW3aWHdxpOLdXCm6xPpruP2e5LNNC0SznAJUVP2bgP0TkmFxfs1h4shgu+O1/21BD7
         6mMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SmHGIngOZeUrAahfaDVfuGgpv8akL47E4u3p5WZDk+g=;
        b=sUPnBPWbT0C5fPN54l1OX1BTerdykNxg9w2LgfY/xauxp5tX64fvRR/VK8lRIWoiku
         SrXnQXG48ClL2qeUD0e1nCWsjoHoI/f52Vi34SlLpYEThnwfNITg+GczC2KXneeepJ0U
         kIfQZ2hHVz2ZG65v4DV96ncNLzN0spJ8gUt539mUCU8+4rPVMF7bQT9w2Dv08Kw06yaS
         p6ZgLypHcDtxfHHu4wxciofxxvtJkX+ZQmI/2FLp5xq40oH7voQJwnhIIXagYG22m1ii
         oIVZUmgROxGrbTlqCCYrXrFbrSzM4cL95O1HHpPNkcOx51cKAIM9gYFCmkvhuq6dqfbm
         bdwg==
X-Gm-Message-State: AOAM531zETJq5/ScO05Uj4J7KVXAA+psyQEfsZhi2EqRM/HP4lkbhtHv
        jRc1l+nHm2wyV7b9WYL/UJaMA6UvR9LaW4Qso40=
X-Google-Smtp-Source: ABdhPJxfxs1NEyuIPF9UR74LLphSz4gkfD89XA59Q+ST5ee7ZtkGYczaJ+U9zNhH+ELPPYnwFWE/rpEYZmLzg2DkrRM=
X-Received: by 2002:aca:d5c5:: with SMTP id m188mr975289oig.114.1612224724260;
 Mon, 01 Feb 2021 16:12:04 -0800 (PST)
MIME-Version: 1.0
References: <20210201210822.6501-1-claus.stovgaard@gmail.com>
In-Reply-To: <20210201210822.6501-1-claus.stovgaard@gmail.com>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Mon, 1 Feb 2021 16:11:52 -0800
Message-ID: <CAE1WUT7vHzzVXpx5vKbEKb+63G6RmM0s39EtmUgYDdANkveRYQ@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Mark Phison E16 (Corsair MP600) as IGNORE_DEV_SUBNQN
To:     Claus Stovgaard <claus.stovgaard@gmail.com>
Cc:     linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 1, 2021 at 1:11 PM Claus Stovgaard
<claus.stovgaard@gmail.com> wrote:
>
> Tested both with Corsairs firmware 11.3 and 13.0 for the MP600 and both
> have the issue as reported by the kernel.
>
> nvme nvme0: missing or invalid SUBNQN field.
>
> Signed-off-by: Claus Stovgaard <claus.stovgaard@gmail.com>
> ---
>  drivers/nvme/host/pci.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 81e6389b2042..41b1b0731cbd 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3242,6 +3242,8 @@ static const struct pci_device_id nvme_id_table[] = {
>         { PCI_DEVICE(0x144d, 0xa822),   /* Samsung PM1725a */
>                 .driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY |
>                                 NVME_QUIRK_IGNORE_DEV_SUBNQN, },
> +       { PCI_DEVICE(0x1987, 0x5016),   /* Phison E16 (Corsair MP600) */
> +               .driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
>         { PCI_DEVICE(0x1d1d, 0x1f1f),   /* LighNVM qemu device */
>                 .driver_data = NVME_QUIRK_LIGHTNVM, },
>         { PCI_DEVICE(0x1d1d, 0x2807),   /* CNEX WL */
> --
> 2.26.2
>

Can't test this - don't have an MP600 of my own to test with - but it
should work just fine. If anyone else has an MP600 to throw at this
that'd be great.

Acked-by: Amy Parker <enbyamy@gmail.com>

Best regards,
Amy Parker
(she/her/hers)
