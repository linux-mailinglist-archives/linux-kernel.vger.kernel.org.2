Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB3031EA5F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 14:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbhBRNSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 08:18:14 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:9822 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229769AbhBRLm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 06:42:29 -0500
X-IronPort-AV: E=Sophos;i="5.81,187,1610406000"; 
   d="scan'208";a="493656325"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 12:29:02 +0100
Date:   Thu, 18 Feb 2021 12:29:02 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coccinelle: misc: add swap script
In-Reply-To: <4e913cc4-cb86-4552-bced-a89cbecca3b2@linux.com>
Message-ID: <alpine.DEB.2.22.394.2102181227230.2748@hadrien>
References: <20210216080133.455456-1-efremov@linux.com> <alpine.DEB.2.22.394.2102172224570.3081@hadrien> <c2b60288-3e46-14e3-9be2-3f75366a4b47@linux.com> <alpine.DEB.2.22.394.2102181114380.2748@hadrien> <4e913cc4-cb86-4552-bced-a89cbecca3b2@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 18 Feb 2021, Denis Efremov wrote:

>
>
> On 2/18/21 1:17 PM, Julia Lawall wrote:
> >
> >
> > On Thu, 18 Feb 2021, Denis Efremov wrote:
> >
> >>
> >>
> >> On 2/18/21 12:31 AM, Julia Lawall wrote:
> >>>> +@depends on patch@
> >>>> +identifier tmp;
> >>>> +expression a, b;
> >>>> +type T;
> >>>> +@@
> >>>> +
> >>>> +(
> >>>> +- T tmp;
> >>>> +|
> >>>> +- T tmp = 0;
> >>>> +|
> >>>> +- T *tmp = NULL;
> >>>> +)
> >>>> +... when != tmp
> >>>> +- tmp = a;
> >>>> +- a = b;
> >>>> +- b = tmp;
> >>>> ++ swap(a, b);
> >>>> +... when != tmp
> >>>
> >>> In this rule and the next one, if you remove the final ; from the b = tmp
> >>> line and from the swap line, and put it into context code afterwards, them
> >>> the generated code looks better on cases like fs/xfs/xfs_inode.c in the
> >>> function xfs_lock_two_inodes where two successive swap calls are
> >>> generated.
> >>>
> >>> There are also some cases such as drivers/net/wireless/ath/ath5k/phy.c in
> >>> the function ath5k_hw_get_median_noise_floor where the swap code makes up
> >>> a whole if branch.
> >>
> >>> In this cases it would be good to remove the {}.
> >>
> >> How this can be handled?
> >>
> >> If I use this pattern:
> >> @depends on patch@
> >> identifier tmp;
> >> expression a, b;
> >> @@
> >>
> >> (
> >>   if (...)
> >> - {
> >> -       tmp = a;
> >> -       a = b;
> >> -       b = tmp
> >> +       swap(a, b)
> >>         ;
> >> - }
> >> |
> >> -       tmp = a;
> >> -       a = b;
> >> -       b = tmp
> >> +       swap(a, b)
> >>         ;
> >> )
> >>
> >> The tool fails with error:
> >>
> >> EXN: Failure("rule starting on line 58: already tagged token:\nC code
> >> context\nFile \"drivers/net/wireless/ath/ath5k/phy.c\", line 1574,
> >> column 4, charpos = 41650\n around = 'sort',\n whole content =
> >> \t\t\t\tsort[j - 1] = tmp;") in drivers/net/wireless/ath/ath5k/phy.c
> >
> > A disjunction basically says "at this node in the cfg, can I match the
> > first patter, or can I match the second pattern, etc."  Unfortunately in
> > this case the two branches start matching at different nodes, so the short
> > circuit aspect of a disjunction isn't used, and it matches both patterns.
> >
> > The solution is to just make two rules.  The first for the if case and the
> > second for everything else.
> >
>
>   if (...)
> - {
> -       tmp = a;
> -       a = b;
> -       b = tmp
> +       swap(a, b)
>         ;
> - }
>
>
> This produces "single-line ifs".
> Maybe generated patches can be improved somehow?
> Moving -+; doesn't help in this case.

There is clearly some problem with the management of newlines...

The other alternative is to just have one rule for introducing swap and
another for removing the braces around a swap, ie

if (...)
- {
  swap(...);
- }

I don't think it would be motivated to remove the newline in that case.

julia

>
> diff -u -p a/drivers/net/wireless/ath/ath9k/calib.c b/drivers/net/wireless/ath/ath9k/calib.c
> --- a/drivers/net/wireless/ath/ath9k/calib.c
> +++ b/drivers/net/wireless/ath/ath9k/calib.c
> @@ -32,11 +32,7 @@ static int16_t ath9k_hw_get_nf_hist_mid(
>
>         for (i = 0; i < ATH9K_NF_CAL_HIST_MAX - 1; i++) {
>                 for (j = 1; j < ATH9K_NF_CAL_HIST_MAX - i; j++) {
> -                       if (sort[j] > sort[j - 1]) {
> -                               nfval = sort[j];
> -                               sort[j] = sort[j - 1];
> -                               sort[j - 1] = nfval;
> -                       }
> +                       if (sort[j] > sort[j - 1]) swap(sort[j], sort[j - 1]);
>                 }
>         }
>         nfval = sort[(ATH9K_NF_CAL_HIST_MAX - 1) >> 1];
> diff -u -p a/drivers/net/wireless/ath/ath9k/ar9003_calib.c b/drivers/net/wireless/ath/ath9k/ar9003_calib.c
> --- a/drivers/net/wireless/ath/ath9k/ar9003_calib.c
> +++ b/drivers/net/wireless/ath/ath9k/ar9003_calib.c
> @@ -1011,19 +1011,11 @@ static void __ar955x_tx_iq_cal_sort(stru
>                 for (ix = 0; ix < MAXIQCAL - 1; ix++) {
>                         for (iy = ix + 1; iy <= MAXIQCAL - 1; iy++) {
>                                 if (coeff->mag_coeff[i][im][iy] <
> -                                   coeff->mag_coeff[i][im][ix]) {
> -                                       temp = coeff->mag_coeff[i][im][ix];
> -                                       coeff->mag_coeff[i][im][ix] =
> -                                               coeff->mag_coeff[i][im][iy];
> -                                       coeff->mag_coeff[i][im][iy] = temp;
> -                               }
> +                                   coeff->mag_coeff[i][im][ix]) swap(coeff->mag_coeff[i][im][ix],
> +                                                                     coeff->mag_coeff[i][im][iy]);
>                                 if (coeff->phs_coeff[i][im][iy] <
> -                                   coeff->phs_coeff[i][im][ix]) {
> -                                       temp = coeff->phs_coeff[i][im][ix];
> -                                       coeff->phs_coeff[i][im][ix] =
> -                                               coeff->phs_coeff[i][im][iy];
> -                                       coeff->phs_coeff[i][im][iy] = temp;
> -                               }
> +                                   coeff->phs_coeff[i][im][ix]) swap(coeff->phs_coeff[i][im][ix],
> +                                                                     coeff->phs_coeff[i][im][iy]);
>
> Thanks,
> Denis
>
