Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097DB43A82B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 01:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbhJYXc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 19:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbhJYXcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 19:32:25 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58121C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 16:30:02 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id t184so12462178pfd.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 16:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OikzpJy+ulJ/iMPwSBk+Y4Qdnv1zoI4G2kzh3S5KjZM=;
        b=niw1O1xOaY9hFPDD8aUNNrjsW9u7HwlbmG6x6SNsYU3yjleoefJrZVsAm6SP8NuMjP
         o23nxHuB9LRuLkmRK2UiQTUmVNUMeI2aUdskZVzE3kgHOaWyfAnzcjpSnjQ9GFvYWsdG
         ZgdU7ewZjtu9Zxi9AwvEcfdEr5jiZmlfmbioVfyDYsHUnJ3k+v19ddXVwQV+2dzjsbm1
         rd/Foo/V5GZ7FcPhAG8S9s8VIgf78dUk+e2NSAsg0qG+bevmGflOwurxALQD2vhb0uGz
         NGYqiGIGbibAYCwIWp6EhQJ4nOKzZQZAlKnxlFMEaL9H3kiE9egr8ez2CYR1OxZeO16A
         znTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OikzpJy+ulJ/iMPwSBk+Y4Qdnv1zoI4G2kzh3S5KjZM=;
        b=3G0Co+FEJkYF1Ucy332CZfknZPyrntZwoPrYmc2iMgv9cwm6VQ2kq/La/Y33fQik5O
         mokyQjTtW8CPypBMBygSwsF/8YK72pRaMCuK7f1A8TxYPN7Pp3BFDoI72gM+X6PIOx0+
         lzYmh85jekapnoOhwQl5EIvmpvyHJzBPBKGDXUS18VHbWD4wDULx2n/jQ73wTzGbvfMd
         XbjfnZBRQDTSNJRr5QjazhS3P2MFClJtETUI64YK8/2IKaDVE4TasCB+GvdHla33sP7G
         GCygzsPvPzoKnq9jD5ZrXC8fhfxe8tDZx23gDBKBaeHNi3X9AIE4mMBb252T1FrMzJzD
         zPJg==
X-Gm-Message-State: AOAM531Ilbi2bXI10ou6FCRNrA3Ri6UJZqiHWEVAJmFxMCkdNWCVixnO
        KX2a6pA3858RDk5qxCE7LtY=
X-Google-Smtp-Source: ABdhPJxaIKGEf2USmRDZLHOcP+kwnUC5n6wwg3jX/sVXLhqW+xa5nJ1+8RyfSCoGTxRcq20hfuuFAg==
X-Received: by 2002:a63:ab02:: with SMTP id p2mr15989657pgf.209.1635204601641;
        Mon, 25 Oct 2021 16:30:01 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 17sm18371534pgr.10.2021.10.25.16.30.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 16:30:01 -0700 (PDT)
Subject: Re: [RESEND 0/5] ARM/arm64: arm_pm_restart removal
To:     Lee Jones <lee.jones@linaro.org>, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, sstabellini@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        wsa+renesas@sang-engineering.com, linux@roeck-us.net,
        treding@nvidia.com, arnd@arndb.de, xen-devel@lists.xenproject.org,
        patches@armlinux.org.uk
References: <20210604140357.2602028-1-lee.jones@linaro.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <526fe66f-df08-c873-2a20-f1295e30a855@gmail.com>
Date:   Mon, 25 Oct 2021 16:29:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210604140357.2602028-1-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/21 7:03 AM, Lee Jones wrote:
> This is a rebase/refresh of a set sent out, reviewed,
> then forgotten about.  It's still considered useful.
> 
> Here is an excerpt from the previous attempt:
> 
>  "Hi Russell, ARM SoC maintainers,
> 
>  here's the full set of patches that remove arm_pm_restart as discussed
>  earlier. There's some background on the series in this thread:
> 
> 	https://lore.kernel.org/linux-arm-kernel/20170130110512.6943-1-thierry.reding@gmail.com/
> 
>  I also have a set of patches that build on top of this and try to add
>  something slightly more formal by adding a power/reset framework that
>  driver can register with. If we can get this series merged, I'll find
>  some time to refresh those patches and send out for review again.

What happened to this patch series? Is there any chance we will get it
included at some point? It is included in the Android13-5.10 tree AFAICT
-- 
Florian
