Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85761442184
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 21:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhKAUQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 16:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbhKAUQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 16:16:19 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50567C061766
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 13:13:46 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id n8so1783503plf.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 13:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/eQvCRlNxGrWds2C2YqKAPobaEPObAauem+bvzLd2TM=;
        b=EW4GBox0NIngN7p5cg6rq/hsrSQn+T5PSS+yjEO8GY7g+ju+BPZicvwlRmmm7UuqjI
         LMVWU7XJceuJ5xXfFrsZ/yECD02cRqbKMbwVmx7FKza3Y9CROYjIUObkkjIZe7N46HCq
         JZ8zT5HHxy6k+Gd2olLh8+MZ3KbbrZaXo1rBZXs0r4sV3OecK0ASwkQtesSH50yFHNnS
         7imIPitsoJcVa/hTyiSWznjHH5MX3aod1lgXZrj7aSm+19SRzzRQrV1jb5A9Fv98CntG
         Xrvga3/9AdnXapYhAoylXGXG9DKNoq44ibiNbtOIwmCcQgEamAtirvGGzzWqowhQ5UQx
         T30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/eQvCRlNxGrWds2C2YqKAPobaEPObAauem+bvzLd2TM=;
        b=HzLDBnRldf3P/+wqccZlPC3c2kYAtNtw01N5SNwLOiK9ROcvI52n4cVetPCbDjFWaS
         qGIHTLf+dyR/TeM+kas9ZFHiDU2fwM3G0O5gP3ROuVW8svW/TofJ/qbreEMgqoHS4EYq
         eQYK9OslbN07oL8j1ih5/bdvOiPMiknIWIPt4SXweKxOtMKlhy7OOwRHXISAORrBpEYA
         Kje6SePnhMI8h1SUIQxYw7hw26uMnnFaL7Jcu+wC3m6y2NtTXHqUuCj3KdLrTcC9R8VU
         JMXskgDWyXbhzY0acUfZ0Ms0MFg3p+fMKM2VV+EK4f5rvhMB6Sx4eCh6i+h4pBLEzuws
         dtHQ==
X-Gm-Message-State: AOAM531U6EfhdX7aXFTIOmLCUcGJsqwYbvvpWwP0+GU0CBgHC6Fy0lFt
        NSM+oq2EbXsHQbY/3M6E7nIrBg==
X-Google-Smtp-Source: ABdhPJxGXqglD4OorXdQW/hHzaJ1ksUvIg3GtK+9lcmMpq/z/U349gO+n4+INSkSpteZSQrHO9we9A==
X-Received: by 2002:a17:90a:71c5:: with SMTP id m5mr1241565pjs.105.1635797625809;
        Mon, 01 Nov 2021 13:13:45 -0700 (PDT)
Received: from [192.168.254.17] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id d20sm1097059pfd.89.2021.11.01.13.13.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 13:13:45 -0700 (PDT)
Message-ID: <0024e0e1-589c-e2cd-2468-f4af8ec1cb95@linaro.org>
Date:   Mon, 1 Nov 2021 13:13:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] scsi: core: initialize cmd->cmnd before it is used
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, linux-scsi@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        syzbot+5516b30f5401d4dcbcae@syzkaller.appspotmail.com
References: <20211101192417.324799-1-tadeusz.struk@linaro.org>
 <4cfa4049-aae5-51db-4ad2-b4c9db996525@acm.org>
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
In-Reply-To: <4cfa4049-aae5-51db-4ad2-b4c9db996525@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/21 13:06, Bart Van Assche wrote:
> This patch is a duplicate and has been posted before.
> 
> Please take a look at 
> https://lore.kernel.org/linux-scsi/20210904064534.1919476-1-qiulaibin@huawei.com/.
>  From the replies to that email:
> "> Thinking further about this: is there any code left that depends on
>  > scsi_setup_scsi_cmnd() setting cmd->cmd_len? Can the cmd->cmd_len
>  > assignment be removed from scsi_setup_scsi_cmnd()?
> 
> cmd_len should never be 0 now, so I think we can remove it."

Thanks for quick response, but I'm not sure if statement
"cmd_len should never be 0 now" is correct, because the cmd_len is
in fact equal to 0 here and this BUG can be triggered on mainline, 5.14,
and 5.10 stable kernels.

-- 
Thanks,
Tadeusz
