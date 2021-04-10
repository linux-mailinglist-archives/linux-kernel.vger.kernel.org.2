Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDAEC35AD8C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 15:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbhDJNXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 09:23:52 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:60875
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234091AbhDJNXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 09:23:51 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ADBKhgKOpgYxShcBcTiCjsMiAIKoaSvp033AA?=
 =?us-ascii?q?0UdtRRtJNvGJjszGpoV+6TbYgCscMUtKpfmuI6+FKEm3ybdU5s0rMa6mTE3avg?=
 =?us-ascii?q?KTTb1KyavH73neFzbl9uhbvJ0QFpRWLNHrF1B1gYLbzWCDc+oI+9WM/KC2ieq2?=
 =?us-ascii?q?9R4EcShQZ65t9At/AAqAe3cGJzVuP4YzF5aX+6N8yQaIRHJ/VKiGL0UeU/OGj9?=
 =?us-ascii?q?PGk4+OW29lOzcXrDjLtz+u5bLgeiL04j4VWVp0rosfzQ=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.82,210,1613430000"; 
   d="scan'208";a="378286927"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2021 15:23:35 +0200
Date:   Sat, 10 Apr 2021 15:23:35 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Mitali Borkar <mitaliborkar810@gmail.com>
cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        mitali_s@me.iitr.ac.in
Subject: Re: [Outreachy kernel] [PATCH v2] staging: rtl8192e: fixed pointer
 error by adding '*'
In-Reply-To: <YHGhdtldqAlRsPHT@kali>
Message-ID: <alpine.DEB.2.22.394.2104101523140.2975@hadrien>
References: <YHGhdtldqAlRsPHT@kali>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 10 Apr 2021, Mitali Borkar wrote:

> Fixed Comparison to NULL can be written as '!...' by replacing it with
> simpler form i.e. boolean expression. This makes code more readable
> alternative.
> Reported by checkpatch.
>
> Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
> ---
> Changes from v1:- added pointer to the function, which was missed during
> fixing v1.
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

This looks like a patch against your previous patch, and not against the
original code.

julia

>  		return true;
>
>  	if (!bAddNewTs) {
> --
> 2.30.2
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/YHGhdtldqAlRsPHT%40kali.
>
