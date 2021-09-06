Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3CE4020A8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 22:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbhIFUQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 16:16:42 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:41010
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229717AbhIFUQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 16:16:40 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3A83F4077C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 20:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1630959326;
        bh=xfpOENm13IZPfK5eL4qdojLOsZiL9zMkxik1nzsyZe4=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=rdJBBPVHN96aGsn6DwB13qkj9VF9Uy96VYXaDAjlerwRaFUr+lWed99OdpSKiuTsw
         ZEMUa2MrTbjLlJJs7ll7D0dPGOM1+iaEGJPHYACaMrXWJZ1gz3QfYNzLzzU8VqkTl8
         AqaJR7oFtp0knmZfGaRl4ZA2fhlBZ8OicX8oCYDxDrUja0SgC+AcDY2ySD/njGM+a1
         j+pn37TUrHTyE+wPhXdf0KBPe0gTOGgMQPN32gXuYV1snoLb+ROW7suWM85pENa+0e
         Tkpb3eUpjULmPkMkCB5LRqtN09kIUOx9HUZo4KHryNCiXop+Xa3L1Mfo/ZD0RqyIWN
         JAVNJ0QjQdc/g==
Received: by mail-wm1-f71.google.com with SMTP id y188-20020a1c7dc5000000b002e80e0b2f87so169969wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 13:15:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xfpOENm13IZPfK5eL4qdojLOsZiL9zMkxik1nzsyZe4=;
        b=BmmQ59v2XjRU9ARnj+KbRVdUtmHg7w6Xvg+knlqTtMrasnJ+4qRKjyasxayxsdR+Ps
         Kez8aDRieNn/dpdSwRh+vEgnsdfBDS03fYEaxOZ7oSmCCkGGI47etZJSyjIPQ+s/yhus
         8XKZFrfmeXY2+NyvIxA5LKManVTctaDx2snfaSFrUU/gKIe/R4/Dg017nIzvDuPxMdP4
         iiE43SQj6MSnvHlU4XFVI1QIJnaz5oZFfaL7GjupzPKpHP7iID6DirZXM69/YDbACQbA
         DbNJD6T4fGeHJlJ8/NSyH863UU4xAAu/n4otHGNogF8ClS/BpqKvGMfQ6ilp+S/6+k9b
         GbXA==
X-Gm-Message-State: AOAM530lpIhUr63UNZTdoFShbXMJS8sSs87J/tfeTSirZzsHdUMiQQOV
        8rbfh6ui9BgmwwXIsjP9cwtkhVYlzDXarO/lvjgpww/ehIi8Renli9bwvrVoODEkh/AS9/uF1HQ
        fl5V8YBuHus0I7JXhjLZX2F+hh9lqCy2gkiVGQPCO9g==
X-Received: by 2002:adf:d191:: with SMTP id v17mr15231321wrc.345.1630959322923;
        Mon, 06 Sep 2021 13:15:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzYRLeZ+VVnYmI62WXsfxqDyDWZIa1WOOt8E12A2xh6RunNBaDOJieMOnhIDWMQHKv6bDN2A==
X-Received: by 2002:adf:d191:: with SMTP id v17mr15231300wrc.345.1630959322670;
        Mon, 06 Sep 2021 13:15:22 -0700 (PDT)
Received: from localhost ([2001:470:6973:2:50cd:c589:b543:6ef9])
        by smtp.gmail.com with ESMTPSA id g1sm9225447wrc.65.2021.09.06.13.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 13:15:22 -0700 (PDT)
Date:   Mon, 6 Sep 2021 21:15:20 +0100
From:   Andy Whitcroft <apw@canonical.com>
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     joe@perches.com, dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel@vger.kernel.org, a.sahrawat@samsung.com,
        Vaneet Narang <v.narang@samsung.com>
Subject: Re: [PATCH 1/1] scripts/checkpatch.pl: remove warning for
 pritk_deferred also
Message-ID: <YTZ22IfeYanMEMpH@brain>
References: <CGME20210824063513epcas5p46ba8b375c3e32fab210640a28041efb6@epcas5p4.samsung.com>
 <1629786900-4644-1-git-send-email-maninder1.s@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629786900-4644-1-git-send-email-maninder1.s@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 12:05:00PM +0530, Maninder Singh wrote:
> printk_deferred also supossed to get loglevel, but checkpatch.pl
> returns warning for same.
> 
> WARNING: Possible unnecessary KERN_ALERT
> +printk_deferred(KERN_ALERT "checking deferred\n");
> 
> total: 0 errors, 1 warnings, 20 lines checked
> 
> Thus removing warning for printk_deferred also.
> 
> Signed-off-by: Vaneet Narang <v.narang@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> ---
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 161ce7fe5d1e..e3bea0d36c10 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -6252,7 +6252,7 @@ sub process {
>  		}
>  
>  # check for logging functions with KERN_<LEVEL>
> -		if ($line !~ /printk(?:_ratelimited|_once)?\s*\(/ &&
> +		if ($line !~ /printk(?:_ratelimited|_once|_deferred)?\s*\(/ &&
>  		    $line =~ /\b$logFunctions\s*\(.*\b(KERN_[A-Z]+)\b/) {
>  			my $level = $1;
>  			if (WARN("UNNECESSARY_KERN_LEVEL",
> -- 
> 2.17.1
> 

It looks sensible to add `_deferred`, there also looks to be an
`_deferred_once` variant which should also be added.  See the first
stanza of `$logFunctions`.  We might also consider splitting up
`$logFunctions` so that we can consume the reset without that first
stanza?  Something like this (completly untested):

    our $logFunctionsCore = qr{(?x:
        (?:[a-z0-9]+_){1,2}(?:printk|emerg|alert|crit|err|warning|warn|notice|info|debug|dbg|vdbg|devel|cont|WARN)(?:_ratelimited|_once|)|
        TP_printk|
        WARN(?:_RATELIMIT|_ONCE|)|
        panic|
        MODULE_[A-Z_]+|
        seq_vprintf|seq_printf|seq_puts
    )};
    our $logFunctions = qr{(?x:
        printk(?:_ratelimited|_once|_deferred_once|_deferred|)|
	$logFunctionsCore
    )};


-apw
