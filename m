Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E2E3874D0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 11:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242567AbhERJK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 05:10:56 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:44968 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240960AbhERJKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 05:10:55 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AgRcJdau78I1GjhvwJj1IVqpy7skDY9V00zEX?=
 =?us-ascii?q?/kB9WHVpmwKj9/xG/c536faaslgssR0b8uxofZPgfZqjz/RICPgqUYtKNTOO0F?=
 =?us-ascii?q?dAbrsSj7cKqAeOJ8SRzJ8/6U4ZSdkaNOHN?=
X-IronPort-AV: E=Sophos;i="5.82,309,1613430000"; 
   d="scan'208";a="508676330"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 May 2021 11:09:36 +0200
Date:   Tue, 18 May 2021 11:09:36 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Gilles Muller <Gilles.Muller@inria.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts: coccicheck: fix troubles on non-English
 builds
In-Reply-To: <1d3320d81fd7db23beaaea78888c389ab5f85ab8.1621328716.git.mchehab+huawei@kernel.org>
Message-ID: <alpine.DEB.2.22.394.2105181109220.6885@hadrien>
References: <1d3320d81fd7db23beaaea78888c389ab5f85ab8.1621328716.git.mchehab+huawei@kernel.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-397356270-1621328977=:6885"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-397356270-1621328977=:6885
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 18 May 2021, Mauro Carvalho Chehab wrote:

> When LANG is not set to English, the logic which checks the
> number of CPUs fail, as the messages can be localized, and
> the logic at:
>
>     THREADS_PER_CORE=$(lscpu | grep "Thread(s) per core: " | tr -cd "[:digit:]")
>
> will not get the number of threads per core.
>
> This causes the script to not run properly, as it will produce
> a warning:
>
> 	$ make coccicheck COCCI=$PWD/scripts/coccinelle/misc/add_namespace.cocci MODE=report drivers/media/
> 	./scripts/coccicheck: linha 93: [: número excessivo de argumentos
>
> Fix it by forcing LANG=C when calling lscpu.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Applied, thanks.

julia

> ---
>  scripts/coccicheck | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index 65fee63aeadb..caba0bff6da7 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -87,7 +87,7 @@ else
>      fi
>
>      # Use only one thread per core by default if hyperthreading is enabled
> -    THREADS_PER_CORE=$(lscpu | grep "Thread(s) per core: " | tr -cd "[:digit:]")
> +    THREADS_PER_CORE=$(LANG=C lscpu | grep "Thread(s) per core: " | tr -cd "[:digit:]")
>      if [ -z "$J" ]; then
>          NPROC=$(getconf _NPROCESSORS_ONLN)
>  	if [ $THREADS_PER_CORE -gt 1 -a $NPROC -gt 4 ] ; then
> --
> 2.31.1
>
>
--8323329-397356270-1621328977=:6885--
