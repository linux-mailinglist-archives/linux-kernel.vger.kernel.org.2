Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0993460E1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 15:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbhCWOCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 10:02:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47165 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232160AbhCWOCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 10:02:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616508127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h9t+B72idifaoxcXCo+oMvX5GZKbGC3CJn59xHhYgqM=;
        b=NnoVYC7MOt3eqEMeyxcY7vTOgBnXZRG6HMHZlTK30iqoU7AdN5znwaqMEHlWWuh/RvZL6e
        FiPnaCMJpLw5BaVD8rFrlkbGhCTPjpSNnG95ey2OdLL3SB3TXgtJ7S73fp+gXB8LVDVWsS
        aFSvRaUo6DR/zZiwi9MoC2fttbcc7R4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-X9DtPB35MW-WWwGDc-XuyQ-1; Tue, 23 Mar 2021 10:02:05 -0400
X-MC-Unique: X9DtPB35MW-WWwGDc-XuyQ-1
Received: by mail-ej1-f71.google.com with SMTP id a22so1095325ejx.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 07:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h9t+B72idifaoxcXCo+oMvX5GZKbGC3CJn59xHhYgqM=;
        b=j1Iy24qUvPsA2ozqR2pn+1GVr0HcbHZSAN6OpYcjvZtZcPevufNepAL3i2jaU2gMjU
         vyQmUBL/DAlI6oIfe3XuY6wiIbNhRfKuOHdg99/bFeW/pdeaPlkABUyJhuQlGaYt+aSU
         Ag2neOTLqInt/sjQm5FLhy73mcys+eIJ5JzYmiz6txBVeUR7O6RDGXvYoAiTRVxhZ/LV
         SzRkiZicr1BTelCR3jKolbeW38Ms5k7KbXe8FQ30sziClGC1uacwilvofiwboHW5aJxr
         BQi6XmiZOTxRdktFh+EHA6IBcPeiCnk3eyMvcDASmUu+d1FVmpbxXdzg4Wv51/nuRTu8
         d/Tg==
X-Gm-Message-State: AOAM533/eI+su5I/QBm6TsF5gjGO28rM2IWuwtEDwKg6FAfdli75eMBw
        VauIB8apxRUjRLdgDExboQo89+i7jOb8N9ku/fBbQK5Z6gs8T4W4CbaStXgISveegkyzP+Privo
        Awh9zA1JUl+NPkGNT4pPXq5V6abPwQ/q7SVWxKhbTqU+TcE6GKLcSfqRrxGGVE5H6PvteZEsLUV
        Aa
X-Received: by 2002:aa7:d347:: with SMTP id m7mr4645720edr.260.1616508123527;
        Tue, 23 Mar 2021 07:02:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/jft58be+yd3ok4y/L/nD5g6FSNmyDUPbETZNr8e9+wQE9nCWmFOaK5jHOD25g4xPWGD9ig==
X-Received: by 2002:aa7:d347:: with SMTP id m7mr4645687edr.260.1616508123288;
        Tue, 23 Mar 2021 07:02:03 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id y24sm13081882eds.23.2021.03.23.07.02.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 07:02:02 -0700 (PDT)
Subject: Re: [PATCH] Input: i8042 - fix Pegatron C15B ID entry
To:     Arnd Bergmann <arnd@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Po-Hsu Lin <po-hsu.lin@canonical.com>,
        Kevin Locke <kevin@kevinlocke.name>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        David Pedersen <limero1337@gmail.com>,
        Rajat Jain <rajatja@google.com>,
        Chris Chiu <chiu@endlessos.org>, Jiri Kosina <jkosina@suse.cz>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210323130623.2302402-1-arnd@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <2187f843-f475-6d95-819a-ebb875b25d44@redhat.com>
Date:   Tue, 23 Mar 2021 15:02:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210323130623.2302402-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/23/21 2:06 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The Zenbook Flip entry that was added overwrites a previous one
> because of a typo:
> 
> In file included from drivers/input/serio/i8042.h:23,
>                  from drivers/input/serio/i8042.c:131:
> drivers/input/serio/i8042-x86ia64io.h:591:28: error: initialized field overwritten [-Werror=override-init]
>   591 |                 .matches = {
>       |                            ^
> drivers/input/serio/i8042-x86ia64io.h:591:28: note: (near initialization for 'i8042_dmi_noselftest_table[0].matches')
> 
> Add the missing separator between the two.
> 
> Fixes: b5d6e7ab7fe7 ("Input: i8042 - add ASUS Zenbook Flip to noselftest list")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/input/serio/i8042-x86ia64io.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
> index 9119e12a5778..a5a003553646 100644
> --- a/drivers/input/serio/i8042-x86ia64io.h
> +++ b/drivers/input/serio/i8042-x86ia64io.h
> @@ -588,6 +588,7 @@ static const struct dmi_system_id i8042_dmi_noselftest_table[] = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
>  			DMI_MATCH(DMI_CHASSIS_TYPE, "10"), /* Notebook */
>  		},
> +	}, {
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
>  			DMI_MATCH(DMI_CHASSIS_TYPE, "31"), /* Convertible Notebook */
> 

