Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6FE38C5A1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 13:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbhEUL0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 07:26:11 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:34851 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbhEUL0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 07:26:07 -0400
Received: from leknes.fjasle.eu ([92.116.73.138]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M58OQ-1lixLC2AGC-001Dee for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021
 13:24:42 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id 977303C4CC; Fri, 21 May 2021 13:24:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1621596281; bh=GsepezfK7SCDw4QRe3az2jXkhTITx9Jxd1jiPnHi2vo=;
        h=Resent-From:Resent-Date:Resent-To:Date:From:To:Cc:Subject:
         References:In-Reply-To:From;
        b=JcUUrWWKEnJrTJpAZmVwvcMS9PXXqqqOX1/jZrupaKJxJ4xoRV45rj+kFacMhZPUP
         9qaB1Tf+M0QkLTJMXWbfBzWNwp/UYo9ArsI0LFgwSPGLjbBYyAQHeceSHx1TxY0rXx
         +ZNjiemRyOFU980nvqwv6YNMyMGcfPs5woVMX828=
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on leknes
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.5-pre1
X-Original-To: nicolas@fjasle.eu
Received: from lillesand.fjasle.eu (unknown [IPv6:fd00::ba:f4ff:fe3b:a745])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "lillesand.fjasle.eu", Issuer "Fake LE Intermediate X1" (not verified))
        by leknes.fjasle.eu (Postfix) with ESMTPS id 83B3C3C071;
        Fri, 21 May 2021 12:29:53 +0200 (CEST)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by lillesand.fjasle.eu (Postfix, from userid 1000)
        id 17497101F68; Fri, 21 May 2021 12:29:53 +0200 (CEST)
Date:   Fri, 21 May 2021 12:29:52 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, Brian Cain <bcain@codeaurora.org>,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] hexagon: move core-y in arch/hexagon/Makefile to
 arch/hexagon/Kbuild
Message-ID: <YKeLoDy3QddLd6jb@lillesand.fjasle.eu>
Mail-Followup-To: Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, Brian Cain <bcain@codeaurora.org>,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210512075729.60291-1-masahiroy@kernel.org>
 <20210512075729.60291-4-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20210512075729.60291-4-masahiroy@kernel.org>
X-Operating-System: Debian GNU/Linux 11.0
Jabber-ID: nicolas@jabber.no
X-Provags-ID: V03:K1:XfqiVchYZOZzYQuwHSnGItFoReXqZtDd5YtHRF0U2wuzLqNdQ3W
 jIP9S59I8+JPWp5b2x8XzRVjzF6hkNfrFwnsOvGBFnHhRMnvJO/XetczpUPlp3xbkzHV7vu
 8l7Qg07oJwrEcXXjKX1mY2Tgqi/HiiHTIPz86aQ/Dad1zRXSW/ft4dVjaLGu3E0yqEL1GiK
 Xbf7J+7Vn1TPfK6HylJGw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:filEX1FQHa4=:HfPKx+T4U0cImjaATJk55Z
 b3N9VPJHNF0LrZburZ5W9bJSuCdNCqcsHwgB6uOy7dH6XiMtv/g2a9ECJ47zxHS4jBXDjYqvV
 ygfu1pPmHIIgbn1hbdraOo+ELitJeF7OEhWhtKr+L3WlcSob3KxXcMFgZC6wqXwkkoHBEZtw2
 tVHa6QauwRcM4sRWmGzYiPIkjxulKeHf/Q9zX9IhfSpGnFDwdOJyslDQKUOzlDo5F9tdSQgvD
 MjCGQsWStSbbgz6jElZni6oxrvfyfI/T5OPbM4dzb0t/ltntscTCsBvv6/TNW6F6msPfT/GSV
 0EbygUgwIbp5XPZCQizG8oL8/bo54sE+L6UfHFKfzMsXW8gNwXrXpm6Ey4DKWGjeXUcaK1ymW
 6YKOgwEYNvv5eoSWGGeHQmjwihMe5oHOPDq98M06iIHKb4MM0L3Wqp1J47OnATCW8S1q2tw4P
 b1832CSKH34isl+7UIl2ONd5tn0vO0dDSi0glnOcm3vtt9nDvAghKrpoyfQakE+cXEcpc6L4F
 twt+Bi3fU3hNsAacrLWLC0=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On Wed 12 May 2021 16:57:28 GMT, Masahiro Yamada wrote:
> Use obj-y to clean up Makefile.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  arch/hexagon/Kbuild   | 1 +
>  arch/hexagon/Makefile | 4 ----
>  2 files changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/hexagon/Kbuild b/arch/hexagon/Kbuild
> index a4e40e534e6a..d930c2f954d5 100644
> --- a/arch/hexagon/Kbuild
> +++ b/arch/hexagon/Kbuild
> @@ -1 +1,2 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +obj += kernel/ mm/ lib/

This should probably be 'obj-y' instead of 'obj'?

Kind regards,
Nicolas
