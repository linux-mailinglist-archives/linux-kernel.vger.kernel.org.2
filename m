Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08ADF3FFFE1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 14:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349370AbhICMgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 08:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349451AbhICMgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 08:36:17 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B737C061757
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 05:35:17 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id x5so5059550ill.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 05:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=19ZonWhnZs25geJXFccYzETRyk9HF/SPK9+6RaQVORE=;
        b=VIMWPwNH7I8r6Pqe9bZrJQqz8qjP1KDNYW7UT8nKu8ueh5Ffdoj1KOp7fLp1CHrand
         TIzSfkWqvA9IQCYgu9kQf3e9X3ehx5eV35k7xAw2scriAxIuEwtR+CHAGCh50GFOiI4e
         zLsN9f77mNzQF0pkIH+AoZRVsHWAyZJZ1Ap3wh8vpLAKVZsTORd267B+mBTZQOBvSoDz
         lY6/U6G26RDH3Syyavp/IlwCaUsUVk4kgQ6eu6RfeeIq5qT8rKT6uk+nXJB4fR9Ea8Lk
         sJdvFqN8J6NgLPYk9vsE6VdRBTzDBOBfXxHq9cxmlWowyYyVak2a+e25Wkj7Di1QK7fF
         LKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=19ZonWhnZs25geJXFccYzETRyk9HF/SPK9+6RaQVORE=;
        b=AJE32ALavFBu9yaOVg8FKZ4bfJOr0DnZwO/JtFRB0Ebf6WZmetLxVYPtctZyvAFVzp
         xyr2mAcZbH+J2DE/WY+klyOeWULHDMLFygW0YGkmZ6Rzg2mE0Dk+iedyDQaJhEuZA2tA
         hkn42Tl+Stb2NpsUiH5t17IyxHqM9jqfgrxS2rk8ShAm0PexZo8C2jbvq+kcUxxiwzW6
         qRTRwor8gRm5CtTDRXN1UMnjnXOO8RKD3Bi1JjJi0vqqe1GMQRQXtet5elBVMiuulMON
         JmpOqGk8Nt1Kup+NebY+xxZk4swgCTXEwiV0XKq5modh4JCib/VIoESG3BLRAg1qd058
         yvyA==
X-Gm-Message-State: AOAM532JpTFvgOLkQk36gb+C8OeVKtkgf9M6wI3Aa13YqXF1rX9UXV8N
        33ThgPYANsF23dzCodQndMGAVfjmV/qpfg==
X-Google-Smtp-Source: ABdhPJzDfge/RwXAW4QEv0XENl9/u8T/rbNmbXTit5WcYtZVnPO0bizRWY7KLY5dYSH55MjMuGEwRw==
X-Received: by 2002:a92:c94d:: with SMTP id i13mr2457039ilq.292.1630672516482;
        Fri, 03 Sep 2021 05:35:16 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id 12sm2579066ilq.37.2021.09.03.05.35.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 05:35:15 -0700 (PDT)
Subject: Re: [PATCH v6] libata: Add ATA_HORKAGE_NO_NCQ_ON_ATI for Samsung 860
 and 870 SSD.
To:     Kate Hsuan <hpa@redhat.com>, Hans de Goede <hdegoede@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210903094411.58749-1-hpa@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d3488035-d269-2a63-f958-746f371cf490@kernel.dk>
Date:   Fri, 3 Sep 2021 06:35:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210903094411.58749-1-hpa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/21 3:44 AM, Kate Hsuan wrote:
> Many users are reporting that the Samsung 860 and 870 SSD are having
> various issues when combined with AMD/ATI (vendor ID 0x1002)  SATA
> controllers and only completely disabling NCQ helps to avoid these
> issues.
> 
> Always disabling NCQ for Samsung 860/870 SSDs regardless of the host
> SATA adapter vendor will cause I/O performance degradation with well
> behaved adapters. To limit the performance impact to ATI adapters,
> introduce the ATA_HORKAGE_NO_NCQ_ON_ATI flag to force disable NCQ
> only for these adapters.
> 
> Also, two libata.force parameters (noncqati and ncqati) are introduced
> to disable and enable the NCQ for the system which equipped with ATI
> SATA adapter and Samsung 860 and 870 SSDs. The user can determine NCQ
> function to be enabled or disabled according to the demand.
> 
> After verifying the chipset from the user reports, the issue appears
> on AMD/ATI SB7x0/SB8x0/SB9x0 SATA Controllers and does not appear on
> recent AMD SATA adapters. The vendor ID of ATI should be 0x1002.
> Therefore, ATA_HORKAGE_NO_NCQ_ON_AMD was modified to
> ATA_HORKAGE_NO_NCQ_ON_ATI.

What's this patch against?

-- 
Jens Axboe

