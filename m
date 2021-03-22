Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C82344CA9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 18:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbhCVREA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 13:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhCVRDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 13:03:34 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DB1C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 10:03:33 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id bx7so20230714edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 10:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=R5cbTSsJlxps/dQe1Y4urXBDfbL33xhSKZh9rusDAKk=;
        b=ROJomO9lUPupat7Qd4lgEtJk8l0XOwcJXoArp1PjhTUKLEsFIAfYC5pTjSOccFSsB5
         T5W5RMKl7EJ17sEmQRIT7m+3yK9A3sMqValC0LidXCpsXCb6pOZoga61GBV952ylUxSV
         HIUB4j7/qaPLMUyRpo+R5KbRwHmtu2kNTCcsorP3bK+vpNQRYckQC2GXJVzfobRnhNXU
         FIpdUkfIH54f1+hWeHsniFpFIy7B4J6mdEAY7YvKC1PG9MrgpJVYQZTwLBu8ZHR+GB9f
         G66+NdVrvX/X7oThfFf5s49TjBV38cL6quUE+x3lv6fhhy9B9NaDQewW9AG5hDzodcPp
         8kwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=R5cbTSsJlxps/dQe1Y4urXBDfbL33xhSKZh9rusDAKk=;
        b=i+FXnV9a6Dw00/9YbN+/NfVqAmWAUGHzCN9MLp5nSJGAABvJ87A9dnVvjaCzN4g5WA
         XhleqDNYYnRR75ojvOdXVn9caOrRThMvqJALnqhQ2ibfayQRVgyrRnhl53mvCWvRNJme
         F3x78UQCpBs5O72oNmntNnzeAWBvXOxNqUDaFqfeQqm3F+IyFyQdV7CvqSb4FOxhQINA
         sjPBTM9dhZT62YOPDnDH3gBv1pA1x9cZ124viAQxNe8nkusa8m2HLESQuXhdlSLXZ56p
         DIx1VoWsQe3f289VLylUN2+jZBzDAKo+QQrWN+wdS81Nak3eoZoWPiX9ArSF7Rz5KaJR
         9bzA==
X-Gm-Message-State: AOAM532BuBPTwpib6s2n9HMu544KWW95g0LT6f6YAM1kNQOzmXSwClWb
        0x+pUQls1ZaPl3+rrHpaAJPIrg==
X-Google-Smtp-Source: ABdhPJxRy+uZT0LE9fyXddnHba4vvzr2UB6Q7r8FqUZixusDFnBaCfGOeaHFYLOF/emFKw367dhuXQ==
X-Received: by 2002:a50:fe81:: with SMTP id d1mr604857edt.308.1616432612493;
        Mon, 22 Mar 2021 10:03:32 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id c15sm9864438ejm.52.2021.03.22.10.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 10:03:31 -0700 (PDT)
Date:   Mon, 22 Mar 2021 17:03:30 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@elte.hu>,
        Douglas Anderson <dianders@chromium.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kgdb: fix gcc-11 warning on indentation
Message-ID: <20210322170330.wil52d2geopfnfka@maple.lan>
References: <20210322164308.827846-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210322164308.827846-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 05:43:03PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc-11 starts warning about misleading indentation inside of macros:
> 
> drivers/misc/kgdbts.c: In function ‘kgdbts_break_test’:
> drivers/misc/kgdbts.c:103:9: error: this ‘if’ clause does not guard... [-Werror=misleading-indentation]
>   103 |         if (verbose > 1) \
>       |         ^~
> drivers/misc/kgdbts.c:200:9: note: in expansion of macro ‘v2printk’
>   200 |         v2printk("kgdbts: breakpoint complete\n");
>       |         ^~~~~~~~
> drivers/misc/kgdbts.c:105:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the ‘if’
>   105 |                 touch_nmi_watchdog();   \
>       |                 ^~~~~~~~~~~~~~~~~~
> 
> The code looks correct to me, so just reindent it for readability.
> 
> Fixes: e8d31c204e36 ("kgdb: add kgdb internal test suite")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

Which tree do you want to merge this one though? I've got nothing else
pending for this file so I am very relaxed about the route...


Daniel.


> ---
>  drivers/misc/kgdbts.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/misc/kgdbts.c b/drivers/misc/kgdbts.c
> index 945701bce553..2e081a58da6c 100644
> --- a/drivers/misc/kgdbts.c
> +++ b/drivers/misc/kgdbts.c
> @@ -95,19 +95,19 @@
>  
>  #include <asm/sections.h>
>  
> -#define v1printk(a...) do { \
> -	if (verbose) \
> -		printk(KERN_INFO a); \
> -	} while (0)
> -#define v2printk(a...) do { \
> -	if (verbose > 1) \
> -		printk(KERN_INFO a); \
> -		touch_nmi_watchdog();	\
> -	} while (0)
> -#define eprintk(a...) do { \
> -		printk(KERN_ERR a); \
> -		WARN_ON(1); \
> -	} while (0)
> +#define v1printk(a...) do {		\
> +	if (verbose)			\
> +		printk(KERN_INFO a);	\
> +} while (0)
> +#define v2printk(a...) do {		\
> +	if (verbose > 1)		\
> +		printk(KERN_INFO a);	\
> +	touch_nmi_watchdog();		\
> +} while (0)
> +#define eprintk(a...) do {		\
> +	printk(KERN_ERR a);		\
> +	WARN_ON(1);			\
> +} while (0)
>  #define MAX_CONFIG_LEN		40
>  
>  static struct kgdb_io kgdbts_io_ops;
> -- 
> 2.29.2
> 
