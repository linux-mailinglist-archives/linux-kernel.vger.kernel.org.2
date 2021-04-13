Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB7E35E1C1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 16:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344505AbhDMOmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 10:42:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36729 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231917AbhDMOmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 10:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618324905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TViGrSHXxRTqM3saQJnRZcxR43Mym++wZTJJ2EWtIto=;
        b=Tqj5t9VZPG0pXNNmJs6DAbha3uQlHX7ipYINfA8TeQgalJFPIhsAAJDlSFQK+o/kmurLB7
        kMzA29FcnV395jkr9EVNUtHL8T7rfFKlNZwhFrJg4I5r0GRUT8Udj4n1H4eR6IIDGFA5+C
        xhaKg/SPnOMY1jxghaUPNX5a5qBCy2Q=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-BLDcVDKwMje2MXA5r9ZKyw-1; Tue, 13 Apr 2021 10:41:38 -0400
X-MC-Unique: BLDcVDKwMje2MXA5r9ZKyw-1
Received: by mail-qv1-f69.google.com with SMTP id u7so10192539qvf.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=TViGrSHXxRTqM3saQJnRZcxR43Mym++wZTJJ2EWtIto=;
        b=HRqk+0xyMsLL9/sABV2sOM/nH1Mth98+3xcEFsdxY09iQAl9d8ZO4UQV8etlDfjFRw
         bs8HnuAuIh9BkB3BtPrw6HmsTgTnesDlP5nRIDWwEywuSiA6RtTngDivCzIL67LSb0qx
         E+5D7UbZbTqjKm33HJM1+F7iDz9y4x7Lg8fBhyIpPGshJYQh7+8BrCGJg8L5yNGeWIQz
         Zt2IFkImT1qLp7Gl83Vr5YUksWPq0AQ37SqfaL6pyy9qLe5FgSEkFir21Y8+9iQgpMmS
         6+ey9IyvSCoE+0RaWZml0XNLGlAAiiMH37wwdWn2WeVPF6tXOcEvLYAUXTb/f/Atnww9
         9ozg==
X-Gm-Message-State: AOAM530Ck9nQgIFJQ3hyZQo4sRJ2TPR1KZ9Oo+f+aiWRcJ1u9OdVzQiV
        h2dNVnvL3W4m0ufBpJXluDIYpKwvd7SSZ/BrHupfqiysYt7npMjV8e/Qhn6VPolfY2dmgp5USbZ
        tFHihjX1wHmJOZUhI59mdmSwCS06khbv7nFOzxYbWcyVXtXsyi5nZlzCVa3/8pDr6TuEYwbQ=
X-Received: by 2002:a37:ae86:: with SMTP id x128mr32631315qke.427.1618324898333;
        Tue, 13 Apr 2021 07:41:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxV2RTDXFsn/MqdWIiA0uOrBI4PKyyvlH52vYsv5jFW+FN5kErFac+ntPs/2hsIVEymw4vR/Q==
X-Received: by 2002:a37:ae86:: with SMTP id x128mr32631289qke.427.1618324898074;
        Tue, 13 Apr 2021 07:41:38 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id k17sm3577246qtp.26.2021.04.13.07.41.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Apr 2021 07:41:37 -0700 (PDT)
Subject: Re: [PATCH] fpga: xilinx-pr-decoupler: remove useless function
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, mdf@kernel.org
Cc:     michal.simek@xilinx.com, linux-fpga@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1618285894-111432-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <40a0449f-37c4-6b3a-5a34-d865db971f9f@redhat.com>
Date:   Tue, 13 Apr 2021 07:41:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1618285894-111432-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/12/21 8:51 PM, Jiapeng Chong wrote:
> Fix the following gcc warning:
>
> drivers/fpga/xilinx-pr-decoupler.c:32:19: warning: unused function
> 'xlnx_pr_decouple_read' [-Wunused-function].
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>   drivers/fpga/xilinx-pr-decoupler.c | 6 ------
>   1 file changed, 6 deletions(-)
>
> diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
> index 7d69af2..f407cb2 100644
> --- a/drivers/fpga/xilinx-pr-decoupler.c
> +++ b/drivers/fpga/xilinx-pr-decoupler.c
> @@ -29,12 +29,6 @@ static inline void xlnx_pr_decoupler_write(struct xlnx_pr_decoupler_data *d,
>   	writel(val, d->io_base + offset);
>   }
>   
> -static inline u32 xlnx_pr_decouple_read(const struct xlnx_pr_decoupler_data *d,
> -					u32 offset)
> -{
> -	return readl(d->io_base + offset);
> -}
> -

I am not in favor of removing this function.

It should have been used in xlnx_pr_decoupler_enable_show() instead of 
the bare readl().

So use it in this function, and for consistency rename to 
xlnx_pr_decoupler_read()

that is 'decouple' -> 'decoupler'

Tom

>   static int xlnx_pr_decoupler_enable_set(struct fpga_bridge *bridge, bool enable)
>   {
>   	int err;

