Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31CF6342427
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhCSSLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbhCSSKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:10:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E48BC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 11:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3yAKEu9+zOB6gCecpvpsLp0jSPuiJLy+Sa05WAEoe2c=; b=iyaqHOTOSDPTwOVnDTi3nNas8V
        otFS7wi0wbFvNbe15qW/76OnX1iVQUZniMtfSXho42f6oJdwJPojScFREHvF4MjoH949K6Pk/ii+8
        1ZzPEGNwYkevi3gDT+dILSqZnmwoIaDaT5ZS7Cxq/0/13vJnvxU2grX442ipOTF/GMkPmJxccGwMI
        Se8JtV12Et99pr6dDzJfWUZTPRurN6J1Q1gpig08J+uRwfqhwy7AXHAh10w2cypgdCcQyMtekNEsC
        0PGTrWxxC3KxLQ7GiGyZdkZBDuGgcpjhVGYY1aW56QFFeRKq2Rm8QZtaaym9kKFqy5mkjFNCNB6//
        nvOtR4Aw==;
Received: from rdunlap (helo=localhost)
        by bombadil.infradead.org with local-esmtp (Exim 4.94 #2 (Red Hat Linux))
        id 1lNJaA-001Rji-9f; Fri, 19 Mar 2021 18:10:47 +0000
Date:   Fri, 19 Mar 2021 11:10:46 -0700 (PDT)
From:   Randy Dunlap <rdunlap@bombadil.infradead.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
cc:     zbr@ioremap.net, gregkh@linuxfoundation.org,
        akira215corp@gmail.com, ivan.zaentsev@wirenboard.ru,
        rikard.falkeborn@gmail.com, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] w1: slaves: Typo fixes
In-Reply-To: <20210319052554.966-1-unixbhaskar@gmail.com>
Message-ID: <7f48f042-e2f6-dfb8-4636-b7f3644eee4@bombadil.infradead.org>
References: <20210319052554.966-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: Randy Dunlap <rdunlap@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210319_111046_353764_B47B5CA0 
X-CRM114-Status: GOOD (  10.96  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: Spam detection software, running on the system "bombadil.infradead.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  On Fri, 19 Mar 2021, Bhaskar Chowdhury wrote: > s/mesured/measured/
    .......twice > > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
    Acked-by: Randy Dunlap <rdunlap@infradead.org> 
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Mar 2021, Bhaskar Chowdhury wrote:

> s/mesured/measured/  .......twice
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
> drivers/w1/slaves/w1_therm.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
> index 976eea28f268..d3b4ceb07622 100644
> --- a/drivers/w1/slaves/w1_therm.c
> +++ b/drivers/w1/slaves/w1_therm.c
> @@ -63,8 +63,8 @@ static u16 bulk_read_device_counter; /* =0 as per C standard */
> #define EEPROM_CMD_READ     "restore"	/* cmd for read eeprom sysfs */
> #define BULK_TRIGGER_CMD    "trigger"	/* cmd to trigger a bulk read */
>
> -#define MIN_TEMP	-55	/* min temperature that can be mesured */
> -#define MAX_TEMP	125	/* max temperature that can be mesured */
> +#define MIN_TEMP	-55	/* min temperature that can be measured */
> +#define MAX_TEMP	125	/* max temperature that can be measured */
>
> /* Allowed values for sysfs conv_time attribute */
> #define CONV_TIME_DEFAULT 0
> --
> 2.26.2
>
>
