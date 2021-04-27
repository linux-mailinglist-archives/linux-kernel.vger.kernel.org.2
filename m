Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6109836CAAD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 19:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236684AbhD0R42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 13:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhD0R41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 13:56:27 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611F3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 10:55:42 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id i26so5170736oii.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 10:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z2Q/8gmoCmD7vH0wfhQaChr0vts1hhFRsOkvHAH8Hog=;
        b=NfbWOcv1fu2GcaGe2N/8AmFqmw/m2sf8Ni9F5gcEu/GEl2jLYSS3CMDrPjtQJyGNWG
         b/Dc+6bSDRWmBYzmojotCKkGuamXplidFWqPE/7TeYyskNgRQuV93T+q4lwTWvqMm14s
         8FGGWWhF1ngcb3V/tGxPKTzlZP7/Wl/4CGc2tI7szf/64ab6Tp8/s+ypN31RVJRbV/3k
         wTOSjjTB6T/lZoWwtfZro6A1UCIFkZmp+C6snYvCdcHlDKUW6Wi2/DEg56HVXcksWugE
         XQFAd8V6tg0WcXIWFMeTzZx4U8icIB8yXBO6bZAbiT8ZwkAgpNKRrnhvnWnBOMtoPjOx
         KZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z2Q/8gmoCmD7vH0wfhQaChr0vts1hhFRsOkvHAH8Hog=;
        b=OeGP2S4rLrt06s+x2R4P8bN9AwmkvS2VJ8ivfUT9ITlV+NEreTfrBaLJRP/uz3fGzk
         6UL25vYY1zhfvHNkckTK0LamiA/ks5Bup9T1FM/bRyNyFcXZiqszSSiIN44tgRlqeziz
         BeBv4GZ44pYYWfZhByN9MpBdgJl1TY1v76BObDLZEiEhM0kBvmP2efDdk7hO8Wh2nYTq
         5weG3Csb6sAxDF+LjC8+kVlE+84Zt9jR3lSsLssgAjQwrVPBHVfkdBulaHHFfdD/G3+k
         my0ZQSA/XvKhqtmdj3eegHv1vg7r6pOKzcP0E7lhozMa+94wIMsV2rSJmVndFTWDaWh8
         G55A==
X-Gm-Message-State: AOAM5328awyJYtvfukWsWdG47F5LKvc8787gbWSc0O+hbD8FmMx+Gngq
        V1SXKtsBiuK8ty9GkuiAg4Y9QR6seRAFWQsOM7ZeN3a3lR/D6g==
X-Google-Smtp-Source: ABdhPJw1i7ij/hMDyEHbRwYoGwLuBgXyPTsVPVA+DOb6v02lZdFHPseywNtdWGAExHm99gx3A+bPDpm4obEixNA6UNc=
X-Received: by 2002:a05:6808:1393:: with SMTP id c19mr4673637oiw.149.1619546141714;
 Tue, 27 Apr 2021 10:55:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210427174719.GA14124@ubuntu>
In-Reply-To: <20210427174719.GA14124@ubuntu>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 27 Apr 2021 19:55:30 +0200
Message-ID: <CAMhs-H_jfdTV4JYD+_Xy+1w452AjjAut-jjFhEt+GmLjTw8+8A@mail.gmail.com>
Subject: Re: [PATCH] staging: mt7621-pci: fix a multiple assignment code style issue
To:     Iain Craig <coldcity@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-staging@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Iain.

On Tue, Apr 27, 2021 at 7:47 PM Iain Craig <coldcity@gmail.com> wrote:
>
> avoid multiple assignments while setting pcie->io members to NULL.
>
> Signed-off-by: Iain Craig <coldcity@gmail.com>
> ---
>  drivers/staging/mt7621-pci/pci-mt7621.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
> index 115250115f10..f3b5b8ac03b5 100644
> --- a/drivers/staging/mt7621-pci/pci-mt7621.c
> +++ b/drivers/staging/mt7621-pci/pci-mt7621.c
> @@ -306,7 +306,9 @@ static int mt7621_pci_parse_request_of_pci_ranges(struct pci_host_bridge *host)
>          * resource manually instead.
>          */
>         pcie->io.name = node->full_name;
> -       pcie->io.parent = pcie->io.child = pcie->io.sibling = NULL;
> +       pcie->io.parent = NULL;
> +       pcie->io.child = NULL;
> +       pcie->io.sibling = NULL;

In this particular case I think the original code is correct as it is.
Also this is the style used around different kernel places to assign
these fields.

>         for_each_of_pci_range(&parser, &range) {
>                 switch (range.flags & IORESOURCE_TYPE_BITS) {
>                 case IORESOURCE_IO:
> --
> 2.25.1
>

Best regards,
    Sergio Paracuellos

>
