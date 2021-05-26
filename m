Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BADD3919FE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 16:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbhEZOXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 10:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234591AbhEZOW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 10:22:59 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36B0C061574;
        Wed, 26 May 2021 07:21:25 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id b26so2805202lfq.4;
        Wed, 26 May 2021 07:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PlH6e0RLANPN4C0rhH8q8pjH5iIcPQTNlpL2Syq/QQk=;
        b=A0v2QFrC80dq4lVWyNcodXJSoqneMe/xOXe2cjcAXmUhe8FbPVCg7t4m4YQ/xjQgWl
         5YQ17KGwsxBw82MXESua6U9fJ+uvyH/kWlAeoioYzb3LPyXI6xP+D4Yf+30sSM2AHF0I
         VwwOq1a1P91/jdl3TNSKtYEmUR+MCPyMIbL3M1HWFmqsghYTqHwdlTllMyYZmi6PR50t
         TiM8QECWS9wKmMdhRe4D4kowDI9KGzsYM9IxKejVFWGAJFm8BXFv6AmSDZ4x/yOxia3Z
         K05uOjXi1pB2NfEmVMc6EBuych+fFT6s0T5ulaVSLFmWHYzY1EmDQz3XcJR+Izn63Cwz
         wepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PlH6e0RLANPN4C0rhH8q8pjH5iIcPQTNlpL2Syq/QQk=;
        b=Vj1rFqLXMWu2HbgJYVfOM643vzfL3Stv4q3PKNpAxY2KBgZQvvGqLLGHbPuplF4dEt
         rFkQ+SOMow+XBu5p6ydM2bomxFClEe5cYUPfVOil5zr9IRjjexdr5J4uu7NURSJYRydw
         v6mX6+Ei3hoIXxv9tva0nGVM+3HMQC7iU7KvE3Y4gOoMsv6tVhuTN1T/SJi06DN2z0Qq
         aK25krrnufXD+ZOoDJR9BDy1IZLF6eLVEt+AylBS564f2zA5Otl8A9nYR6SxzMX4ByD3
         W7U9SFqjoQbL6YDDbJOnl1db6rK931+hQcUzx1aMKm6aRbnYo0CJBc5ckYKCxGDIUDl+
         2DHg==
X-Gm-Message-State: AOAM531IzgTpTt0oSmxttE+mhIvx88RPUA/tADsqlcHl0rGWrk2G5gld
        JplBSeGnUKcuReDhzrtG/bUolPbJexY=
X-Google-Smtp-Source: ABdhPJyGi6Fw5pyBtrTkTkfySEiTcCIMwo1NMnuZBwEr/w0OsnLGXvu+90DsEPgprwBNaOgf+3nnYA==
X-Received: by 2002:a05:6512:b17:: with SMTP id w23mr2241433lfu.133.1622038883841;
        Wed, 26 May 2021 07:21:23 -0700 (PDT)
Received: from [192.168.1.102] ([178.176.73.49])
        by smtp.gmail.com with ESMTPSA id d15sm2040840lfa.137.2021.05.26.07.21.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 07:21:23 -0700 (PDT)
Subject: Re: [PATCH 21/24] usb: host: xhci: Move array of structs from the
 stack onto the heap
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
References: <20210526130037.856068-1-lee.jones@linaro.org>
 <20210526130037.856068-22-lee.jones@linaro.org>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <8551978f-27b0-767e-f92b-e96ab3064b33@gmail.com>
Date:   Wed, 26 May 2021 17:21:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210526130037.856068-22-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/21 4:00 PM, Lee Jones wrote:

> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/usb/host/xhci.c: In function ‘xhci_reserve_bandwidth’:
>  drivers/usb/host/xhci.c:2859:1: warning: the frame size of 1032 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> Cc: Mathias Nyman <mathias.nyman@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/usb/host/xhci.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index ac2a7d4288883..40ce4b4eb12ad 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
[...]
> @@ -2788,6 +2788,10 @@ static int xhci_reserve_bandwidth(struct xhci_hcd *xhci,
>  		return -ENOMEM;
>  	}
>  
> +	ep_bw_info = kzalloc(sizeof(*ep_bw_info) * 31, GFP_KERNEL);

   Why not kcalloc()?

[...]

MBR, Sergei
