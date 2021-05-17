Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC283839D7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 18:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243253AbhEQQam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 12:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344086AbhEQQaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 12:30:14 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C39C06F8FF
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 08:12:52 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id z24so6145914ioj.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 08:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BZ+LvNcX8+Or88RW/0Dfplt7pikZ1wCTDEjghzqPEZ8=;
        b=K2J2W3C4HbMLjxlvPzM1QiNsJLahHuJe8YdR2mF7GL0nWi8UHdBv0RiYmdfsqO/VO6
         KLhaYi+hDPMrMrN263aMpp2H+GCUA3/QLoKJKwYsdft1bd38WoIDVxCbnoN3yX8j8WRn
         6z8o/el1jO9vE+8ulBjUF06nD8rM0sbtJCywVoieStO+9gwr1aoOoTD1jtFwFM887U3v
         MCtQ8F4xK9mszYoYf/1KtkH2/FuC/qw9uaoxQD6AcPubiYIwk6/R+rU3g4zIrIX1V7w2
         wHwzsJpEOVhqTTh6xXOgkmJPjnyIQzAdz6t3uW5WXFGPpMI/8lEe4SJFJ5fTC9M1zS0B
         wkfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BZ+LvNcX8+Or88RW/0Dfplt7pikZ1wCTDEjghzqPEZ8=;
        b=mTQl9t3rqwCZ2lo0rmLcrabRr9njSM5HdbkKtJDO8rRu7CgX0uXVyoW2yVsZy9aUPR
         nW6dz1Gun6B0jJSViI+Pk+PsqjBPKzifRUnUD8vb7hkfGjWpAvP03fW4An2azF3qp+8T
         E89NHuot+H+NxXIXGyHNG8w5bqOaRRCC8bgMwR+jIvvE6tXnaZvR8nBvDn87iTCmWC4u
         p+0BH7svx9skKhuefbtmj81Rd6qpbELIDmcbDaUW4IaYGvWzVPX4q/TsYYTibv5vK5bk
         sSFFbXuCdfkE0n4qXS8Xbbmcuong+8AGzaZ5qEIuouBJ9p7fTNax2drgK+FkZQsGVFKK
         KBtw==
X-Gm-Message-State: AOAM530UYNrXdMfu+KaU0hKpf47BTQtKgG9Dt8j4Uo3QG+Rsr9/B79GT
        pk9Ka56nbXbmbrKnyq35cdhH2DKe5L0MkQ==
X-Google-Smtp-Source: ABdhPJz/Zw0XvQ4/YBBjvLCDDiorNsUt9dwWLfLU2FAoH2fChUvY2NPH5ZwhXsBv9PvaoogNoEn/5Q==
X-Received: by 2002:a5e:8c11:: with SMTP id n17mr374041ioj.53.1621264371797;
        Mon, 17 May 2021 08:12:51 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r5sm2921807ilb.1.2021.05.17.08.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 08:12:51 -0700 (PDT)
Subject: Re: [PATCH] sata: fsl: fix DPRINTK format string
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210514213402.691436-1-arnd@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <309095e5-6b12-6517-2370-737aae33f012@kernel.dk>
Date:   Mon, 17 May 2021 09:12:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210514213402.691436-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/21 3:33 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Printing an __iomem pointer as %x produces a warning:
> 
> drivers/ata/sata_fsl.c: In function 'fsl_sata_set_irq_coalescing':
> drivers/ata/sata_fsl.c:316:17: error: format '%x' expects argument of type 'unsigned int', but argument 2 has type 'void *' [-Werror=format=]
>   316 |         DPRINTK("ICC register status: (hcr base: 0x%x) = 0x%x\n",
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   317 |                         hcr_base, ioread32(hcr_base + ICC));
>       |                         ~~~~~~~~
>       |                         |
>       |                         void *
> 
> It's not clear why that pointer should be printed here, but if we do,
> then using %p is the way to avoid the warnings.

Applied, thanks.

-- 
Jens Axboe

