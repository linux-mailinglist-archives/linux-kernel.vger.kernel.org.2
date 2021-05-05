Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3763748CF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 21:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbhEETmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 15:42:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36674 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbhEETmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 15:42:37 -0400
Received: from mail-qv1-f69.google.com ([209.85.219.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1leNOt-000398-GS
        for linux-kernel@vger.kernel.org; Wed, 05 May 2021 19:41:39 +0000
Received: by mail-qv1-f69.google.com with SMTP id a18-20020a0cca920000b02901d3c6996bb7so2479407qvk.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 12:41:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KMfcNsjXlZ+tgGRkWqvnbenP9g4xeEBy1YBavjn3OpA=;
        b=bQICEYx4NIEAnneCf0nzhzmWSNzdb6S1IcrYKHp+sEenjXBfRDLQGNI3La7DUmGp64
         OPRQO28Dh2A4mwZ11ehbI7En64o/PcLufnGeXsbMwZ85Mr4tGNRV2WRFLmg381V0NzKc
         3qZdo3NRZje0zMt9Lmd9xkkLQvzVR/j/lQ9sm/KNN9T219RnoCZkrUi2/fqbPKEKgtTh
         IFR6pRpweZHawtVyZPKbjOxBBo83tiqXcAVrqqVHkwDC0rkfVwdmO2MS0humiT4SSP83
         96Ock5C//48aSDvjaj7p7W+Z9ksvlkYETSuIFnld8W/3UBWv3+0m2GyXilmDBmCPZ5+X
         wc9w==
X-Gm-Message-State: AOAM532vlcqVlS+HxKYfkqeSTLW1GeAEiShxlISbxRWsmL6jZ0IF0F0R
        rNXzs24LLErbMXhDpaGo5/GYDoqOwob5DAtxGR/jUfxymk5RD9Yhj1fCt36h41WZqmu8fn4CV2P
        8Csq8bP98/joVn+w9OwlHDX3wfg13D71+trqlaRkPAg==
X-Received: by 2002:a05:620a:118a:: with SMTP id b10mr381192qkk.263.1620243698213;
        Wed, 05 May 2021 12:41:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjB1fkQLdzlaXKjnl6zTIgJDOAyEuudFSA92e4UuJZVegXPWitGuVebLofp0UL7pHqzFoZZg==
X-Received: by 2002:a05:620a:118a:: with SMTP id b10mr381174qkk.263.1620243698062;
        Wed, 05 May 2021 12:41:38 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.49.2])
        by smtp.gmail.com with ESMTPSA id e5sm172640qtg.96.2021.05.05.12.41.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 12:41:37 -0700 (PDT)
Subject: Re: [PATCH] scsi: ufs: ufs-exynos: make a const array static, makes
 object smaller
To:     Colin King <colin.king@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210505190104.70112-1-colin.king@canonical.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <0e90b057-3a87-bec5-c0b2-46c49b191651@canonical.com>
Date:   Wed, 5 May 2021 15:41:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210505190104.70112-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2021 15:01, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the const array granularity_tbl on the stack but instead it
> static. Makes the object code smaller by 190 bytes:
> 
> Before:
>    text    data     bss     dec     hex filename
>   25563    6908       0   32471    7ed7 ./drivers/scsi/ufs/ufs-exynos.o
> 
> After:
>    text    data     bss     dec     hex filename
>   25213    7068       0   32281    7e19 ./drivers/scsi/ufs/ufs-exynos.o
> 
> (gcc version 10.3.0)

I am not sure what's the benefit here - you moved the code from text to
data. In total you decreased the size for this compilation settings
(e.g. compiler + optimizations) but that might not be always true, right?

This has effect on the code readability - line is longer and reader
would think "why this was made static since it is simple one-time const?".


Best regards,
Krzysztof
