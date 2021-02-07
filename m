Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16137312371
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 11:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhBGKU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 05:20:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24596 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229445AbhBGKU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 05:20:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612693140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zL5FYVBIrPDyBxmkAYbHjP/K5+sn2g8g2V56WtdMp/Q=;
        b=LPgQQgJUOsT47URv0827B94Ql2xaLhe6bl7549i6J99gJXEnoui+LPI5Omr+KJGzjDl7Ni
        8cdsW4gl9IsXBq4gNF/UKcF4EaQOgMCh08CLFvgC0NzrDwBw+3SoIgVl/vFMVkIKnpmJL8
        mFpBg4s3XvzcCk1hWcCUqD1Olq4zxdc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-4GvOjk1QPziFTXju5tP-Mw-1; Sun, 07 Feb 2021 05:18:58 -0500
X-MC-Unique: 4GvOjk1QPziFTXju5tP-Mw-1
Received: by mail-ed1-f72.google.com with SMTP id u19so11492715edr.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 02:18:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zL5FYVBIrPDyBxmkAYbHjP/K5+sn2g8g2V56WtdMp/Q=;
        b=jJWEnLGPe0egv0/3UOYKr3WsU1EQbVZm9PXmun6SBcYNP/LIebC+3AaCXz5/sQU+8s
         QBi7egZeF1VwChlhaV12VOMeWrDpQfadn9z/odELaFPX6a9972fe7yZA/NTitmf8wXew
         NPW5RCSUVg9YC3LhfZwqbKNm6QJZM5Kdtalt3MK5HCCV3b2g/Tjxvs4Z/NPkWH3N/u0F
         kRKTOhEIOo/nw70lyiSx3WBgTKEnXGFgV7Qg1KdkbbYfeUDZFX7SrupePm07mHpA/k+x
         qHFibK7WkShbTzyG0e7Ycy1prBFigk1nRYBTBhiEMfxgasrcs/4YQBSpvAMxcAReu03I
         nLBg==
X-Gm-Message-State: AOAM5300TNoZhfYHimlgSR174lsIvUjZH7OHuQUbQuQ7pMWkhVFeeMgm
        CpqbPkVef58VjFzr7ORCf+fP8t0GaYy9CsVUzM/p2cdTkuUXivi8+rsSWQfK9z2yCtwWQ0qyU/N
        kUd9PsvLPY2054Z1jw36S6koX+lNc1BZthg9IrOZ2sDxnZAdZublIQfXGw9VWNayJxsIrvjFLX5
        Rm
X-Received: by 2002:a17:906:f0d0:: with SMTP id dk16mr12071886ejb.533.1612693137343;
        Sun, 07 Feb 2021 02:18:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwidbPwVedPoZNXADdDu0eG2jGCAgcjzqmEgdqVmQIDkNnAe0OErjEZcPoEv6Ut1+TD7l6S0w==
X-Received: by 2002:a17:906:f0d0:: with SMTP id dk16mr12071859ejb.533.1612693137143;
        Sun, 07 Feb 2021 02:18:57 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id di27sm5234115edb.21.2021.02.07.02.18.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Feb 2021 02:18:56 -0800 (PST)
Subject: Re: [PATCH] Input: synaptic - reverting
 dcb00fc799dc03fd320e123e4c81b3278c763ea5 because it breaks the touchpad for
 one guy on Reddit.
To:     Colton Booth <colton@boothsoftware.ca>, dmitry.torokhov@gmail.com
Cc:     colton@boothlinux.ca, Lyude Paul <lyude@redhat.com>,
        Lee Jones <lee.jones@linaro.org>,
        Vincent Huang <vincent.huang@tw.synaptics.com>,
        Dennis Kadioglu <denk@eclipso.email>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Yussuf Khalil <dev@pp3345.net>, Ilya Katsnelson <me@0upti.me>,
        Gaurav Agrawal <agrawalgaurav@gnome.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210207035024.69095-1-colton@boothsoftware.ca>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <08362ef4-c407-9cd0-20fa-354cd8e73fcb@redhat.com>
Date:   Sun, 7 Feb 2021 11:18:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210207035024.69095-1-colton@boothsoftware.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/7/21 4:50 AM, Colton Booth wrote:
> I can't test myself since I don't have the correct hardware, BUT this change seems to work for him. I'm thinking he has an early version of the X1E which may use slightly different trackpad revision.

Who is "him"? Do you have a bug-report link or some such ?

With which kernel version is this ?  Could it be that the commit you are reverting was
backported to a stable-series release while that stable series is missing the rmi4
updates necessary to make things work on newer models ?

What are the symptoms / problems "him" is seeing when not reverting this?

On case it is not clear: NACK due to insufficient information why this is
necessary / missing description and root cause analysis of the actual problem.

Regards,

Hans


> 
> Signed-off-by: Colton Booth <colton@boothsoftware.ca>
> ---
>  drivers/input/mouse/synaptics.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index ffad142801b3..2d3f03921dbc 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -179,9 +179,7 @@ static const char * const smbus_pnp_ids[] = {
>  	"LEN0093", /* T480 */
>  	"LEN0096", /* X280 */
>  	"LEN0097", /* X280 -> ALPS trackpoint */
> -	"LEN0099", /* X1 Extreme Gen 1 / P1 Gen 1 */
>  	"LEN009b", /* T580 */
> -	"LEN0402", /* X1 Extreme Gen 2 / P1 Gen 2 */
>  	"LEN200f", /* T450s */
>  	"LEN2044", /* L470  */
>  	"LEN2054", /* E480 */
> 

