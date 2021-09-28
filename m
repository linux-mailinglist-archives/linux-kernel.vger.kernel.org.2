Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1CB41AC34
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 11:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240037AbhI1JsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 05:48:25 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:50822
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239724AbhI1JsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 05:48:24 -0400
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 68DFD3F4B9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 09:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632822404;
        bh=c/kdz4JOc+vTZk2jmBBR72tYLHMciGkwpbaQXlAaTBY=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=hPuPtFX0q8kKO5giJHTZ/uoHfmcxzFaZGyvYJHKrUURT864w7WRneqqNK6Vl9w+if
         7FzK2CDWocft2fZdai2VnuFTGIOY9q448MB/J0ybb8vd6JGa3+sOtNxPTMyBty9G74
         UhEp19m2l1PlXBt+hsC+fUiFNnLiGueUx+hWLjgpmUGJBmaBapdQGv+pVucheBgIZM
         WO7qlCF0L0lDMH9fIfifCWwm6yOwBDDl84KCSxlu5T2SZvkUK7LZBfAjkQnuGHOdZN
         Q3kM6u67Lj7p1F7QUi1gpOG2Sr3qjmmnw0wcz+6Ls3k1JKTijR0t8otL0duPfocbC+
         GJJ88PTo1TEiw==
Received: by mail-lf1-f70.google.com with SMTP id r14-20020ac25c0e000000b003fc149ed50eso18801838lfp.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 02:46:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c/kdz4JOc+vTZk2jmBBR72tYLHMciGkwpbaQXlAaTBY=;
        b=JqjxE0oqEaG4i08Yvldr8jS3RJ+Se/pGwuE9VX/pmjEmOWdI6tR3kVN/s3BXmFJrXa
         W3iQEb3/O9qWjsqrhTDTNq2DrFy1GvTVxQ5Go/XggVl+FkM9OZOEgfypL+OLtYHMoH30
         gJ5M5lWg2VTlQbd/g9E9eYaauw5sYDOu1aTMe2S80iUfp8/b0BYulvEL/iIlAoTkRrqm
         lh7RvQerB+Uu7xmdgrppuzL0TCc0xNwjOBSRC/dpJMBhI+voYrjRWdpCk9dlY4pUxrC5
         WZDjDsiPcUBPUC/z9C2NuCby1QMp89O09YyaoCaP2cHlJtKkQKLgYMFiBDF3c8aeK/86
         vOLw==
X-Gm-Message-State: AOAM532e/hHtwmoeiKpU7e51Io+1SBOsIFdmJsuW5iNr8VUsqrKC9w03
        +1G8FH3ZOxpcW6jXoHHAonSpHQ4doH3YHFrJ9a18M+vBd0e9+Rpa+o0I7XnutO1xrzVcLUm5koY
        fbJAi5g54or05a0zL+DIcD4cNCL4OK6Ms6ro0VaYvfQ==
X-Received: by 2002:a2e:750e:: with SMTP id q14mr4813888ljc.338.1632822403562;
        Tue, 28 Sep 2021 02:46:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywyIBRxayUsKU8rKEgexS1XRTqJlh4WooSBl0aayVAKMWS9MuQZTGk4t/MmKmIRt44FI84Qw==
X-Received: by 2002:a2e:750e:: with SMTP id q14mr4813877ljc.338.1632822403387;
        Tue, 28 Sep 2021 02:46:43 -0700 (PDT)
Received: from [192.168.0.20] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y20sm2302275ljn.88.2021.09.28.02.46.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 02:46:42 -0700 (PDT)
Subject: Re: [RFC PATCH] memory: renesas-rpc-if: Correct QSPI data transfer in
 Manual mode
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Duc Nguyen <duc.nguyen.ub@renesas.com>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <20210922091007.5516-1-wsa+renesas@sang-engineering.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <beb6c373-e9d8-b0f1-78c5-cf21d01a5a9b@canonical.com>
Date:   Tue, 28 Sep 2021 11:46:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210922091007.5516-1-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2021 11:10, Wolfram Sang wrote:
> This patch fixes 2 problems:
> [1] The output warning logs and data loss when performing
> mount/umount then remount the device with jffs2 format.
> [2] The access width of SMWDR[0:1]/SMRDR[0:1] register is wrong.
> 
> This is the sample warning logs when performing mount/umount then
> remount the device with jffs2 format:
> jffs2: jffs2_scan_inode_node(): CRC failed on node at 0x031c51d4:
> Read 0x00034e00, calculated 0xadb272a7
> 
> The reason for issue [1] is that the writing data seems to
> get messed up.
> Data is only completed when the number of bytes is divisible by 4.
> If you only have 3 bytes of data left to write, 1 garbage byte
> is inserted after the end of the write stream.
> If you only have 2 bytes of data left to write, 2 bytes of '00'
> are added into the write stream.
> If you only have 1 byte of data left to write, 2 bytes of '00'
> are added into the write stream. 1 garbage byte is inserted after
> the end of the write stream.
> 
> To solve problem [1], data must be written continuously in serial
> and the write stream ends when data is out.
> 
> Following HW manual 62.2.15, access to SMWDR0 register should be
> in the same size as the transfer size specified in the SPIDE[3:0]
> bits in the manual mode enable setting register (SMENR).
> Be sure to access from address 0.
> 
> So, in 16-bit transfer (SPIDE[3:0]=b'1100), SMWDR0 should be
> accessed by 16-bit width.
> Similar to SMWDR1, SMDDR0/1 registers.
> In current code, SMWDR0 register is accessed by regmap_write()
> that only set up to do 32-bit width.
> 
> To solve problem [2], data must be written 16-bit or 8-bit when
> transferring 1-byte or 2-byte.
> 
> Signed-off-by: Duc Nguyen <duc.nguyen.ub@renesas.com>
> [wsa: refactored to use regmap only via reg_read/reg_write]
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Hi,
> 
> I could reproduce the issue by a simple:
> 
>   $ echo "Hello" > /dev/mtd10
> 
> The original BSP patch fixed the issue but mixed regmap-acces with
> ioread/iowrite accesses. So, I refactored it to use custom regmap
> accessors. This keeps the code more readable IMO. With this patch, my
> custom test cases work as well as the JFFS2 remount mentioned in the
> commit message. Tested on a Renesas Condor board (R-Car V3M) and a
> Falcon board (R-Car V3U). I send this as RFC because this is my first
> patch for the RPC code and hope for feedback. The BSP team has been
> contacted as well for comments and testing. Nonetheless, this addresses
> a serious issue which has caused broken boards because of writing to
> unintended locations. So, I'd like to see this discussed and applied
> soon if possible.
> 
> Thanks everyone,
> 
>    Wolfram
> 

Thanks for testing and comments. Any Fixes tag for it?

Best regards,
Krzysztof
