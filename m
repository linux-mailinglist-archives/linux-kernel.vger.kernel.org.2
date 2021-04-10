Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632DA35ADEB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 16:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbhDJOC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 10:02:57 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:56078
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234548AbhDJOCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 10:02:53 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AGQapg6yZeNxmG+w+aj6AKrPwzb1zdoIgy1kn?=
 =?us-ascii?q?xilNYDZSddGVkN3roeQD2XbP+VIscVwphNzoAsK9aFzG85od2+MsFJekGDLroW?=
 =?us-ascii?q?65aLxlhLGC/xTFOwnTstFQzr1hda8WMqyUMXFfgdzh6Ae1V/YMqePmzImSie3T?=
 =?us-ascii?q?z2hgQGhRAsldxjx0BQqBHkp9SBMuP+tbKLOn+sFFqzC8EE54Uu2HABA+M9Trm8?=
 =?us-ascii?q?fGj9bPbxIAGnccmWuzpALt2frBHx+U0gx2aV5y6L0pmFKrrzDE?=
X-IronPort-AV: E=Sophos;i="5.82,212,1613430000"; 
   d="scan'208";a="378288277"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2021 16:02:38 +0200
Date:   Sat, 10 Apr 2021 16:02:37 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Mitali Borkar <mitaliborkar810@gmail.com>
cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        mitali_s@me.iitr.ac.in
Subject: Re: [Outreachy kernel] [PATCH v3] staging: rtl8192e: fixed pointer
 error by adding '*'
In-Reply-To: <YHGvJxMhQ8nzHf6I@kali>
Message-ID: <alpine.DEB.2.22.394.2104101602080.2975@hadrien>
References: <YHGvJxMhQ8nzHf6I@kali>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 10 Apr 2021, Mitali Borkar wrote:

> Fixed pointer error by adding '*' to the function.
> Reported by Julia.

Actually, there is a proper tag for reported by, like Signed-off-by.  Look
through the git history to see what to do.

julia

>
> Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
> ---
> Changes from v2:- modified patch body but writing commit message
> clearly.
> Changes from v1:- added pointer to the function.
>
>  drivers/staging/rtl8192e/rtl819x_TSProc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
> index 4457c1acfbf6..78b5b4eaec5f 100644
> --- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
> +++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
> @@ -327,7 +327,7 @@ bool GetTs(struct rtllib_device *ieee, struct ts_common_info **ppTS,
>  	}
>
>  	*ppTS = SearchAdmitTRStream(ieee, Addr, UP, TxRxSelect);
> -	if (ppTS)
> +	if (*ppTS)
>  		return true;
>
>  	if (!bAddNewTs) {
> --
> 2.30.2
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/YHGvJxMhQ8nzHf6I%40kali.
>
