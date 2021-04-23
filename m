Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D0B369007
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 12:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241919AbhDWKFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 06:05:48 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:20795 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241890AbhDWKFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 06:05:45 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AK3DrrKsT+mR5AvVNwaE/Hiko7skDy9V00zAX?=
 =?us-ascii?q?/kB9WHVpW+afkN2jm+le6A/shF8qKRYdsP2jGI3Fe3PT8pZp/ZIcVI3JYCDKsH?=
 =?us-ascii?q?alRbsSjrfK7CbnH0TFltJ18YdFX+xABMbrDV585Pya3CCdH8w7yNeKtICE7N2u?=
 =?us-ascii?q?rUtFdg1hZ6F+4woRMG/yeXFefhVMBpYyCfOnl696jgenEE5nCviTNz0qW6zmq8?=
 =?us-ascii?q?fQnJzrJSQaDwMqgTPjsRqYrJD9FRac0lMycRNqhY0j/2/MjhDj6syY3s2T+1vz?=
 =?us-ascii?q?0Wnc6pgTot/90594AtCWgMR9EFrRozftX4hqV72csD1dmo+S1Go=3D?=
X-IronPort-AV: E=Sophos;i="5.82,245,1613430000"; 
   d="scan'208";a="504668035"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 12:05:08 +0200
Date:   Fri, 23 Apr 2021 12:05:08 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
cc:     Gilles Muller <Gilles.Muller@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] coccinelle: irqf_oneshot: reduce the severity due to
 false positives
In-Reply-To: <20210423100033.78580-1-krzysztof.kozlowski@canonical.com>
Message-ID: <alpine.DEB.2.22.394.2104231204500.7983@hadrien>
References: <20210423100033.78580-1-krzysztof.kozlowski@canonical.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 23 Apr 2021, Krzysztof Kozlowski wrote:

> The IRQF_ONESHOT should be present for threaded IRQ using default
> primary handler.  However intetrupt of many child devices, e.g. children
> of MFD, is nested thus the IRQF_ONESHOT is not needed.  The coccinelle
> message about error misleads submitters and reviewers about the severity
> of the issue, so make it a warning and mention possible false positive.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Applied.  Thanks for the clarification.

julia

> ---
>  scripts/coccinelle/misc/irqf_oneshot.cocci | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/coccinelle/misc/irqf_oneshot.cocci b/scripts/coccinelle/misc/irqf_oneshot.cocci
> index 7b48287b3dc1..9b6f404d07f2 100644
> --- a/scripts/coccinelle/misc/irqf_oneshot.cocci
> +++ b/scripts/coccinelle/misc/irqf_oneshot.cocci
> @@ -103,11 +103,11 @@ devm_request_threaded_irq@p(dev, irq, NULL, ...)
>  @script:python depends on org@
>  p << match.p;
>  @@
> -msg = "ERROR: Threaded IRQ with no primary handler requested without IRQF_ONESHOT"
> +msg = "WARNING: Threaded IRQ with no primary handler requested without IRQF_ONESHOT (unless it is nested IRQ)"
>  coccilib.org.print_todo(p[0],msg)
>
>  @script:python depends on report@
>  p << match.p;
>  @@
> -msg = "ERROR: Threaded IRQ with no primary handler requested without IRQF_ONESHOT"
> +msg = "WARNING: Threaded IRQ with no primary handler requested without IRQF_ONESHOT (unless it is nested IRQ)"
>  coccilib.report.print_report(p[0],msg)
> --
> 2.25.1
>
>
