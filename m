Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40723310224
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 02:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbhBEBSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 20:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbhBEBSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 20:18:24 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAA8C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 17:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=aWbUPeW4e/YPHXmZhk0OHBC71MgWJmQib6HmtXgtUSI=; b=B57r30Sk2A4BI/uT4ufexN7BQz
        b079z/nyi0m84xGaEmKivDb7OowJcUGG+8hMZ0x7lX+9PYqdbRD9Q/iE8niHPihuOb2RKbsSU/Iae
        TS4DMlyYm7e0A6OoRExgS3A5brdHy4btuk0hHjdiMOq901JjD+sPuGn1pWoqNFirq5hnh9qZsr7eY
        qvSWC4aULQUFYwJI6yHJM5SuuJdP46/zqzRjqYE/U2o92UX+AHSI2ohjjn8NmynmLdykPbpl9mk/l
        NBnHl4ULYdoVSVJj+FeAyRhp4Q8hz9xu0lZ9sbg0Rmj6t8r2ZKBnzq7qVh3YGBfp6MXFaWyrNRdLQ
        YySsyufw==;
Received: from [2601:1c0:6280:3f0::aec2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7pkk-0003cT-23; Fri, 05 Feb 2021 01:17:42 +0000
Subject: Re: [PATCH] lib: crc-itu-t: Fix typo in comment
To:     David Mosberger-Tang <davidm@egauge.net>,
        Jiri Kosina <trivial@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <0e0976ef-42a1-880d-2ec0-d22632004ff9@infradead.org>
 <20210205010232.478567-1-davidm@egauge.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <503ed4ec-2386-4bf9-2614-fd0cce268ff9@infradead.org>
Date:   Thu, 4 Feb 2021 17:17:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210205010232.478567-1-davidm@egauge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/21 5:02 PM, David Mosberger-Tang wrote:
> Signed-off-by: David Mosberger-Tang <davidm@egauge.net>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  lib/crc-itu-t.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/crc-itu-t.c b/lib/crc-itu-t.c
> index 1974b355c148..1d26a1647da5 100644
> --- a/lib/crc-itu-t.c
> +++ b/lib/crc-itu-t.c
> @@ -7,7 +7,7 @@
>  #include <linux/module.h>
>  #include <linux/crc-itu-t.h>
>  
> -/** CRC table for the CRC ITU-T V.41 0x1021 (x^16 + x^12 + x^15 + 1) */
> +/* CRC table for the CRC ITU-T V.41 0x1021 (x^16 + x^12 + x^5 + 1) */
>  const u16 crc_itu_t_table[256] = {
>  	0x0000, 0x1021, 0x2042, 0x3063, 0x4084, 0x50a5, 0x60c6, 0x70e7,
>  	0x8108, 0x9129, 0xa14a, 0xb16b, 0xc18c, 0xd1ad, 0xe1ce, 0xf1ef,
> 


-- 
~Randy
