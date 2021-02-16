Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A57331D181
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 21:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhBPUXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 15:23:11 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:36095 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhBPUXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 15:23:09 -0500
Received: from [192.168.1.155] ([95.117.73.76]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N6srH-1lwDaQ3HO3-018Ib5; Tue, 16 Feb 2021 21:20:09 +0100
Subject: Re: [PATCH] of: property: fw_devlink: Ignore interrupts property for
 some configs
To:     Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <treding@nvidia.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, kernel-team@android.com,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210215224258.1231449-1-saravanak@google.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <255a5fba-d5a1-0c40-c26c-2f6ae0e91d56@metux.net>
Date:   Tue, 16 Feb 2021 21:20:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210215224258.1231449-1-saravanak@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:qSif6iokHfmrVqUaq8FGJ2A2coJVPNemx11Xv76FissQOagS2WA
 l1gPeHX69KiJL/8ZvfSOKdl4E11KywiViuH/0O799JHggHHkjWXWwPp75A1u58mcMBjxG1e
 HEfux9E/3gOB53YOK18jUpHz8lIaOhj/8ZKlN2Ug7zoY8o2WvkLEMQdvho7kU2xAS6trNCo
 GKDRHQexuKGAa1gzDTkhQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wIWFmaJlMk8=:EzI+ODY37JvuBoECQcGuF4
 fjfSVUCjtMJrOhvFqHtCzhes2USBlM1Ac6oCxoxMKZfwDfwEQQvyVyM+zjVdg/gRPBurz1Xqi
 15ELHBnqt1A7V7QBdyobBcNX3whuxkFtPmTwN+06sVxSuUcVtJPRTXSNl+wDihYX+A0MmsXf2
 fuXkOwrAoGCCevZgwCY0F4vxFPNtqJlmXzn4A2wkZ4fhLcrd6snAJ26K9qsqYEK3kjTFVVw2G
 nlZt7k8YY5Js4W4rxxPZR0/neWnNwgeg2ITxknsV03h0YTVQ2SQjc+0ryARjyxxeVdsF5KlG9
 9e0BCs8kt3vxzaY4y5JmDsvYhGEF1725yR2zIDOWukJ/uglQXXMDQweIgcIxuDwXkD2KvWUso
 ZaArI+leA96eIAisBUoGbmmULRry6eDfhzam9zAZ59ls06gGAzccJ0N1xEtUk
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.02.21 23:42, Saravana Kannan wrote:

Hi,

> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 79b68519fe30..5036a362f52e 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1300,6 +1300,9 @@ static struct device_node *parse_interrupts(struct device_node *np,
>   {
>   	struct of_phandle_args sup_args;
>   
> +	if (!IS_ENABLED(CONFIG_OF_IRQ) || IS_ENABLED(CONFIG_PPC))
> +		return NULL;
> +
>   	if (strcmp(prop_name, "interrupts") &&
>   	    strcmp(prop_name, "interrupts-extended"))
>   		return NULL;

wouldn't it be better to #ifdef-out the whole code in this case ?


--mtx


-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
