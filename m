Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66EE314BDA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 10:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhBIJjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 04:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbhBIJfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 04:35:07 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC81C061788
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 01:34:26 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v15so20756755wrx.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 01:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=I6lla9xyajA+7i1DpUMCMQmJsAv3iw+P4AVVETxCxU8=;
        b=JS5ZXG0NdNNenwAwYRGP56fdafT6qTxU/F4W7NjKrxOcA2F0FjgOjo3xjifg9tUaXI
         ++44AAc1RPOlXQNxfkrmy4XLEy4h9fk3D0uznSGg4nT1M2q8enEIYIAnd14OeiP6HDmi
         dfql1ArBt0ZWqOGNgeVXnCRskI8CUFkyJKHbE97vmhC1NkDn/dCVliDQErG7L4XovGPr
         G/RgQJPOOfdKTxXueKlaoz+DN0EJ8YTklOvyN7a2Jym9lyP9fFYAFbrGgBKlsjdk+t+4
         Kw9gRLSwNP9KU9qBtxFf1uzSMA1Cg1pVRv7AfMxI2h6d/x/1he54VeVkTnNli24oKwxt
         SbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=I6lla9xyajA+7i1DpUMCMQmJsAv3iw+P4AVVETxCxU8=;
        b=UCQheT1twthEoccEJL6y7p7EPT58IliDAog+S6VyLfy/aO3VZ3fennvcVN6ptMZvxr
         aOahSX0jtGeGb6zHjRBBL4MltWLi3uaIPSAff2pQRqyv9E+Km1Gmi1ro3LxZFQSOEQ1J
         B+7CsV/rh3lAO35OLdPI2PbBCoByoET521AgaezgxGuZZT3j4zsbd5HG4tAsdJ8UEk1v
         iW9TEq8tCqGlU6LcLsdBuU190uVGYomR1PpUsxyPf7CzsY+j2cH6DO+ePhOAwLjwrPV6
         VLoQlytMgkfsu7aH0vyy8rRtk7cXtnZJZRXSSZVOvkpVpI666Pv7PXwcsrp9SD370Epf
         ZAeg==
X-Gm-Message-State: AOAM5316GxuvqjT+FWxl3RR5j3gbYKEW1eVCMQEDq+Hpv5G4N8vyW7eP
        uZT3OFpH1xh/tgTj4O5QFPY=
X-Google-Smtp-Source: ABdhPJzQiR8shG1HcjBfGmhbP4hEsyfXAKjAUtuMJV/fksQjo9aCMBDKfpuJZb7uwiiLh/Jnbi6Epg==
X-Received: by 2002:adf:f8c1:: with SMTP id f1mr24318260wrq.76.1612863264871;
        Tue, 09 Feb 2021 01:34:24 -0800 (PST)
Received: from [192.168.0.66] (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id v5sm15281402wro.71.2021.02.09.01.34.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 01:34:24 -0800 (PST)
Subject: Re: [PATCH v2] drivers/misc/vmw_vmci: restrict too big queue size in
To:     Sabyrzhan Tasbolatov <snovitoll@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        syzbot+15ec7391f3d6a1a7cc7d@syzkaller.appspotmail.com
References: <YCJKIVhNS4N4glUa@kroah.com>
 <20210209093101.2097627-1-snovitoll@gmail.com>
From:   Alex Dewar <alex.dewar90@gmail.com>
Message-ID: <a10296cf-4545-c7f3-1d3c-31fbd05c3f6c@gmail.com>
Date:   Tue, 9 Feb 2021 09:32:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210209093101.2097627-1-snovitoll@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2021 09:31, Sabyrzhan Tasbolatov wrote:
> syzbot found WARNING in qp_broker_alloc[1] in qp_host_alloc_queue()
> when num_pages is 0x100001, giving queue_size + queue_page_size
> bigger than KMALLOC_MAX_SIZE for kzalloc(), resulting order >= MAX_ORDER
> condition.
>
> queue_size + queue_page_size=0x8000d8, where KMALLOC_MAX_SIZE=0x400000.
>
> Reported-by: syzbot+15ec7391f3d6a1a7cc7d@syzkaller.appspotmail.com
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> ---
>> As this is controllable by userspace, you just provided a way to flood
>> the kernel logs.
>>
>> Please make this a dev_dbg() call instead, if you really want to see it.
>> Otherwise just return NULL, no need to report anything, right?
> Thanks, removed pr_warn().
Looks like you forgot to take out the opening brace.

>
> v2: Removed pr_warn() to avoid flood from user-space
> ---
>   drivers/misc/vmw_vmci/vmci_queue_pair.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/misc/vmw_vmci/vmci_queue_pair.c b/drivers/misc/vmw_vmci/vmci_queue_pair.c
> index f6af406fda80..ea16df73cde0 100644
> --- a/drivers/misc/vmw_vmci/vmci_queue_pair.c
> +++ b/drivers/misc/vmw_vmci/vmci_queue_pair.c
> @@ -538,9 +538,7 @@ static struct vmci_queue *qp_host_alloc_queue(u64 size)
>   	queue_page_size = num_pages * sizeof(*queue->kernel_if->u.h.page);
>   
>   	if (queue_size + queue_page_size > KMALLOC_MAX_SIZE) {
> -		pr_warn("too big queue to allocate\n");
>   		return NULL;
> -	}
>   
>   	queue = kzalloc(queue_size + queue_page_size, GFP_KERNEL);
>   	if (queue) {

