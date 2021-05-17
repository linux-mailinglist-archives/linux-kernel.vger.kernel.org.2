Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E493839DC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 18:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344321AbhEQQbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 12:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239486AbhEQQaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 12:30:25 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F181C08EB0D
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 08:13:32 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id c16so6412130ilo.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 08:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lg1VKJckwYnokm5uoiiQMDXX9d4zV2ix7g7zD16xyec=;
        b=frpvvXYHM7/OMQjYL7goR3XKDMiY0WagKkC2wpJF66ObfJo5+LGtBPllazKfPJrTFj
         cSHrU0HPsx6rHy2kYBk1nHvaZH0LYdgM886FWVsFD+zsk8olHXM3UgBfLoorC6hc8+Qk
         Rh9HVXX5+ZxGbr6Tx1TJ9XiJohE9RZHqMpYEHDsRIRZPald0abWAL2tKnF9L0kYb8AJM
         mOYyARij30lb2SejvnNrw+SP/CNtOpjaHrAcHPX1MSa34v42dBCBLGqn5D6BjeVo0jMw
         5ny0ueYH/gLsllQiOyBgheuYX2nd+3NWwTXfaRkTdPBm68WmBlswbFFaVWaqdln5sGYB
         r0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lg1VKJckwYnokm5uoiiQMDXX9d4zV2ix7g7zD16xyec=;
        b=ln+Rx7OnWIZZ1VcncC6Vdxg4sC7V3wdY+EL+0ImBT1OykyeteLdkkFQ/qXpCdmQyy8
         KLx6Tp5Db8wNTCjfZI8CwP0SBU9bsSQkzQz2lwXluyzrioOz5xueUmFZGIr+h6pUchR/
         DdWaHDKRtOjYqP6YqfY6h09BIf7RH9gkljAu0mloj/RpmsTGhHGuvm3l7Vb9zbr+mLPZ
         pCB1zVK6gWMnFG03nzC4tztysdGkrm8mW1iP9IA7GLpFerRrJnRzokmVU1qmtkxpivYe
         0lOJh28YwYakl8qDZ33Mc0QqyhRNimBO0g7f36ICpnwqOvq/bJ3rvW4oXwAR/ycXEB4U
         AwNA==
X-Gm-Message-State: AOAM530p0CRd45SH93nxaVkp2VovFYFdsQypulE+Y2UWHAO8ilriBmdV
        ePRlOfOP4G03nnJFlrauL6eOLEFKh1O8zw==
X-Google-Smtp-Source: ABdhPJzt+Db1SD1ADYZuAd4Hifm/km+ol+JersJ4gCQ2NzQfI5o2RCG0VPN4K8TDun4TL6nvziAA+A==
X-Received: by 2002:a05:6e02:13e1:: with SMTP id w1mr151867ilj.181.1621264411815;
        Mon, 17 May 2021 08:13:31 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v16sm8447723ilq.45.2021.05.17.08.13.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 08:13:31 -0700 (PDT)
Subject: Re: [PATCH] sata: nv: fix debug format string mismatch
To:     Arnd Bergmann <arnd@kernel.org>, Tejun Heo <tj@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210514140105.3080580-1-arnd@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f76e73e5-841e-fe3d-1e84-a259eff2e009@kernel.dk>
Date:   Mon, 17 May 2021 09:13:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210514140105.3080580-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/21 8:01 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Turning on debugging in this this driver reveals a type mismatch:
> 
> In file included from include/linux/kernel.h:17,
>                  from drivers/ata/sata_nv.c:23:
> drivers/ata/sata_nv.c: In function 'nv_swncq_sdbfis':
> drivers/ata/sata_nv.c:2121:10: error: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'u64' {aka 'long long unsigned int'} [-Werror=format=]
>  2121 |  DPRINTK("id 0x%x QC: qc_active 0x%x,"
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ......
>  2124 |   ap->print_id, ap->qc_active, pp->qc_active,
>       |                 ~~~~~~~~~~~~~
>       |                   |
>       |                   u64 {aka long long unsigned int}
> include/linux/printk.h:142:10: note: in definition of macro 'no_printk'
>   142 |   printk(fmt, ##__VA_ARGS__);  \
>       |          ^~~
> drivers/ata/sata_nv.c:2121:2: note: in expansion of macro 'DPRINTK'
>  2121 |  DPRINTK("id 0x%x QC: qc_active 0x%x,"
>       |  ^~~~~~~
> drivers/ata/sata_nv.c:2121:36: note: format string is defined here
>  2121 |  DPRINTK("id 0x%x QC: qc_active 0x%x,"
>       |                                   ~^
>       |                                    |
>       |                                    unsigned int
>       |                                   %llx
> 
> Use the correct format string for the u64 type.

Applied, thanks.

-- 
Jens Axboe

