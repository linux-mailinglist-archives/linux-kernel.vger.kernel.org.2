Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC98B36DABF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240353AbhD1PBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:01:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24043 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240764AbhD1Ozt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 10:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619621703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eyPgVLQ8QqSzdhm5Its6lpg7OSkmtmLOaMRnkKo5XDE=;
        b=ZcJpw/axa7LEn98SiS44gyBrTaFEnf0YbiVTGktFirKJHeg+1H1BBMzQdU4asPBLNR66Ro
        G1ZYU/3oXGNsNQQRpgD1dsiOJurrRxICU7Vtn0hfxKyzHK73TX+Fo8hIrCF9CmKwBffwNU
        Xmlu3CqI86Q8ec5Tx/tvUiWjK0gGolQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-G1Q3UC2PNPGpGwVZ5eEpUg-1; Wed, 28 Apr 2021 10:55:02 -0400
X-MC-Unique: G1Q3UC2PNPGpGwVZ5eEpUg-1
Received: by mail-wr1-f71.google.com with SMTP id 93-20020adf80e60000b0290106fab45006so17974134wrl.20
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 07:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=eyPgVLQ8QqSzdhm5Its6lpg7OSkmtmLOaMRnkKo5XDE=;
        b=MTjoYnmKH2JWh7pE3Pz3+YiAH1L9Juxr2ufgbLpChQtUWGYBNvJKbpsI0/bjp3aMvY
         u/3FhFLsIQ3TzORLtf3Rm8KOryz9LFfQjUS/HdA09L+hDwTREIDxyg+f13LXHiTLENX+
         Ykks68p5kSFwDoWD11gNQAtr3xe4WJB+z4khPhmVc27funBeyTOalIYrcBDtDK5U5S+Y
         T5aRRwGV6WQ9cPwLC2WtXlAfaWRJ47nLt1anNoDvO7Q2A7MSroMFm+IJOEv2A4yxhnLf
         P44gtYaAW1UcVm5iz4kq6s93hDHm3n2HPLMrmoRhmqWFWgx5uIksBjfD45wIX84rpxU2
         /9bg==
X-Gm-Message-State: AOAM531xsuyZ5k/XYWWSB/spFDmFPuMLhu6p7mFu00i80NCtMzpM8AF0
        T6Qfyk/mlIy3SQS6m6YeQKZ2mimriFjMCPrVGD7DCPHTeLbn4Rq/ZMjY/dogO9WbcD38wPPJDDc
        oaAFzhpCCbj/xZkOZyUwPtZmRxnLFbvUn4NRbc+aYR+ZtCrqKLeTIfbSv/IKzNhRey6VUhzoy
X-Received: by 2002:adf:f40f:: with SMTP id g15mr36782469wro.46.1619621700836;
        Wed, 28 Apr 2021 07:55:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2omIZFer/FLV7Ds0zWcKZ0aHnNOtSJaGZpfHLIOWrSUaC6cKswy50XYb9NxOeC4nsy7dAIw==
X-Received: by 2002:adf:f40f:: with SMTP id g15mr36782442wro.46.1619621700564;
        Wed, 28 Apr 2021 07:55:00 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f38:2400:62f4:c5fa:ba13:ac32? (p200300d82f38240062f4c5faba13ac32.dip0.t-ipconnect.de. [2003:d8:2f38:2400:62f4:c5fa:ba13:ac32])
        by smtp.gmail.com with ESMTPSA id m14sm4262344wmi.39.2021.04.28.07.55.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Apr 2021 07:55:00 -0700 (PDT)
Subject: Re: [RFC PATCH] mm/page_alloc: fix counting of free pages after take
 off from buddy
To:     Ding Hui <dinghui@sangfor.com.cn>, akpm@linux-foundation.org,
        naoya.horiguchi@nec.com, osalvador@suse.de
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210421020426.5914-1-dinghui@sangfor.com.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <dd242708-e3f5-ab9f-64d4-9efe3b7168ce@redhat.com>
Date:   Wed, 28 Apr 2021 16:54:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210421020426.5914-1-dinghui@sangfor.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.04.21 04:04, Ding Hui wrote:
> Recently we found there is a lot MemFree left in /proc/meminfo after
> do a lot of pages soft offline.
> 
> I think it's incorrect since NR_FREE_PAGES should not contain HWPoison pages.
> After take_page_off_buddy, the page is no longer belong to buddy
> allocator, and will not be used any more, but we maybe missed accounting
> NR_FREE_PAGES in this situation.
> 
> Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
> ---
>   mm/page_alloc.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index cfc72873961d..8d65b62784d8 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8947,6 +8947,7 @@ bool take_page_off_buddy(struct page *page)
>   			del_page_from_free_list(page_head, zone, page_order);
>   			break_down_buddy_pages(zone, page_head, page, 0,
>   						page_order, migratetype);
> +			__mod_zone_page_state(zone, NR_FREE_PAGES, -1);
>   			ret = true;
>   			break;
>   		}
> 

Should this use __mod_zone_freepage_state() instead?


-- 
Thanks,

David / dhildenb

