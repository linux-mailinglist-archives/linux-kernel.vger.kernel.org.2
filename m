Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B593D591A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 14:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbhGZLXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 07:23:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38094 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233633AbhGZLXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 07:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627301010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=46YjFiGSOu3vFvPZA/rXtYR2f/Xj94q6y2DUkIi17h8=;
        b=glpdzUKXd+uyvhn9T9tQGHNrrsKHlPqRSRXrLFWnyNCj39pjlGuRrZVBN/G4wZbCF9FN7J
        1BDUB9swA+fG1A8UrftgusAK8R+Gnxl2DAcEHhTRnbBvFSc5Orzw687H+Uv2fzGZeehbQb
        Sz+o5lGon7GC3JTM+AJMF9gsVNMYrgg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-amjCWw31MF2McMCwk0emZg-1; Mon, 26 Jul 2021 08:03:29 -0400
X-MC-Unique: amjCWw31MF2McMCwk0emZg-1
Received: by mail-ej1-f72.google.com with SMTP id a19-20020a1709063e93b0290551ea218ea2so2020992ejj.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 05:03:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=46YjFiGSOu3vFvPZA/rXtYR2f/Xj94q6y2DUkIi17h8=;
        b=SN2FDZeQ001CasrI7hF1KtP6FRO5iShWV0pDudemVO7+5nQxBrVNAqJUM5TGAliTnM
         EFoPy/GXbjs4plXnMTSqxr4F9XVioALZ1UrniJruzJm/McgpxZ1Iau3/Cvjne4N5Rtcg
         XKI/tVy1O1RNelxNDb++uRdFMYNdd1Jmxh2GiTfJnEpci9RhbATh8M252b0lVEpW/X9b
         r4Pwzrp9V2Vb9456ZNXloSKl50A6S2rbk0z9c1szFbdTH/pvqsgmP+Z2N1+huVVRG2vE
         cVP0CMpXtN7cBaIBomh/6VVhfG52IFBZ5sKeW4FmINRCNLnl1MgjO4L1kcjqqyEhKdrH
         zr4g==
X-Gm-Message-State: AOAM53330W6v54n/kQmemXLeMyJXie7sMnWIQoWTQpNxXMFZlE0CGUNS
        IZsA5UuwMwtfTTCAg4hKfGKjRrrK4fq4w52afjbHEmp1ZvBW4yxG+AHfAGXoX/Xz4YIzb2/8n9I
        fRyPgMpNv5bXZ1eRUPp4cN7s4
X-Received: by 2002:a17:906:3b47:: with SMTP id h7mr9619110ejf.399.1627301007746;
        Mon, 26 Jul 2021 05:03:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFUlWlMBtOeCXgz63WJ0nRRQfYhSLqdqCRtMJX2iTA/Lw19OEJxkslezgUdDRT+k//1SW2pA==
X-Received: by 2002:a17:906:3b47:: with SMTP id h7mr9619081ejf.399.1627301007481;
        Mon, 26 Jul 2021 05:03:27 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id e27sm3803750ejc.41.2021.07.26.05.03.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 05:03:26 -0700 (PDT)
Subject: Re: [PATCH] watchdog: iTCO_wdt: Fix detection of SMI-off case
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Storm <christian.storm@siemens.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?Q?Mantas_Mikul=c4=97nas?= <grawity@gmail.com>,
        stable <stable@vger.kernel.org>
References: <d84f8e06-f646-8b43-d063-fb11f4827044@siemens.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b3b75b72-33d4-ce21-a8f4-77a37156aa9e@redhat.com>
Date:   Mon, 26 Jul 2021 14:03:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <d84f8e06-f646-8b43-d063-fb11f4827044@siemens.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/21 13:46, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Obviously, the test needs to run against the register content, not its
> address.
> 
> Fixes: cb011044e34c ("watchdog: iTCO_wdt: Account for rebooting on second timeout")
> Reported-by: Mantas Mikulėnas <grawity@gmail.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   drivers/watchdog/iTCO_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
> index b3f604669e2c..643c6c2d0b72 100644
> --- a/drivers/watchdog/iTCO_wdt.c
> +++ b/drivers/watchdog/iTCO_wdt.c
> @@ -362,7 +362,7 @@ static int iTCO_wdt_set_timeout(struct watchdog_device *wd_dev, unsigned int t)
>   	 * Otherwise, the BIOS generally reboots when the SMI triggers.
>   	 */
>   	if (p->smi_res &&
> -	    (SMI_EN(p) & (TCO_EN | GBL_SMI_EN)) != (TCO_EN | GBL_SMI_EN))
> +	    (inl(SMI_EN(p)) & (TCO_EN | GBL_SMI_EN)) != (TCO_EN | GBL_SMI_EN))
>   		tmrval /= 2;
>   
>   	/* from the specs: */
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: stable@vger.kernel.org

(the latter because cb011044e34c has been picked up by stable kernels 
already).

Paolo

