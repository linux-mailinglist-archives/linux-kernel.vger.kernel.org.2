Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBD8408730
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 10:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237966AbhIMIlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 04:41:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52786 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237831AbhIMIlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 04:41:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631522394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qkh8UgFVl9fcTGcCRJyDzip+nuo9SQ5NmsQm19TA6E0=;
        b=XIMQSl/MfgLVRgvJsBX43Q/3uih5Kkx7VI7Mq6Rb437OEho2zxRYVclm/rZ7gY27zN2JTH
        y2jJ8XyT6YZDiu/AxuF0hEXAjg2ECKwwyl0UvvlFSLKiFiONHrj7QyKvFDHg68YSl6vU8H
        fBy3+wbrV+y9zKxQdsaq+dNMpvWKzuE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-L9DItHDPMmeUi5S7msJzqg-1; Mon, 13 Sep 2021 04:39:53 -0400
X-MC-Unique: L9DItHDPMmeUi5S7msJzqg-1
Received: by mail-wr1-f69.google.com with SMTP id i4-20020a5d5224000000b0015b14db14deso2385251wra.23
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 01:39:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Qkh8UgFVl9fcTGcCRJyDzip+nuo9SQ5NmsQm19TA6E0=;
        b=6f6HdYqdfDYxBwEPmk3KFClyXUi+JO5m6kikp/8Vdi8TZpO5UCPQbMPoWhaMSoqNMj
         TXMgaTGzndxiWj9N6QXGFykFaFbMFWtcGV668g6hpiVSFAI+uTEVCwwnlJ26bHVDFOsy
         Dud2QANd2F9EkkesbWOIh0zUMtWFB/mM5ezr3/zG2WwnZutlIWSzGPSd/tlyqpyHW2rs
         5Qw8im3zcCdAMQ4DimhNh5c752CuGrPiUxM5FB17lv4+ZP/X8Ov1vxKRojWYkMIiK/2f
         tw4Eca2RthpSbuf+dR9MkSSY08+B7FSh2xtaV+ITuBef/1/D2wiAH53QvQDKIB5uOX7C
         4f5Q==
X-Gm-Message-State: AOAM5332ePMEO2pkEnC0u/iQh0yR5yPrptxrEhL2/wxGL4geF+vH8xFm
        X4S5HG1Z2o5rhyVb+YJZaiGf5ZPhN8noIpPKNyiOuN549PglkRu7HZtcfTX/ifPeF5MrLeR9BDl
        aKW1vlQxZEcnct2cF1SbSbEStw5SjhaqNMhryWcEH5bCr4G61fDVG8ZWFCF0TH9q17fruUDto
X-Received: by 2002:a7b:ca4b:: with SMTP id m11mr7083464wml.175.1631522392220;
        Mon, 13 Sep 2021 01:39:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/D3Y7lVlgBNtmvGh9HKIR+hqZc3s5012NHyOrvf9JQKKmSvXm6gO4l8dgoM9l1SWWLRB5Kg==
X-Received: by 2002:a7b:ca4b:: with SMTP id m11mr7083437wml.175.1631522392013;
        Mon, 13 Sep 2021 01:39:52 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6576.dip0.t-ipconnect.de. [91.12.101.118])
        by smtp.gmail.com with ESMTPSA id b16sm6854977wrp.82.2021.09.13.01.39.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 01:39:51 -0700 (PDT)
Subject: Re: [PATCH] mm/memory_hotplug: Add static qualifier for
 online_policy_to_str
To:     Tang Yizhou <tangyizhou@huawei.com>
Cc:     osalvador@suse.de, mhocko@kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210913024534.26161-1-tangyizhou@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <db765394-e893-c93d-a54a-52d36a17afd8@redhat.com>
Date:   Mon, 13 Sep 2021 10:39:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210913024534.26161-1-tangyizhou@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.09.21 04:45, Tang Yizhou wrote:
> online_policy_to_str is only used in memory_hotplug.c and should be
> defined as static.
> 
> Signed-off-by: Tang Yizhou <tangyizhou@huawei.com>
> ---
>   mm/memory_hotplug.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 0488eed3327c..4ea91c3ff768 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -57,7 +57,7 @@ enum {
>   	ONLINE_POLICY_AUTO_MOVABLE,
>   };
>   
> -const char *online_policy_to_str[] = {
> +static const char * const online_policy_to_str[] = {
>   	[ONLINE_POLICY_CONTIG_ZONES] = "contig-zones",
>   	[ONLINE_POLICY_AUTO_MOVABLE] = "auto-movable",
>   };
> 

Indeed, thanks

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

