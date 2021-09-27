Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 737CA41980C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 17:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbhI0PlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 11:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235100AbhI0PlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 11:41:09 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0198C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 08:39:31 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id i13so19749645ilm.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 08:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WAHfMK/wO4fMYiKU9LDZg4Jep2aIYsjvtqPdpQXlzlA=;
        b=cPjtNTXQ7jG9UfkpYtR2bmP66u78khVHJvzbhsxQQJgZ5a2+sm920mccP1Ajw4BEE/
         M00myu3fFRyGNfuBUt3x2u/mkvY1anT1oPvlyuEfjwf0+fie/IkPhdd3ykc7rRw/CaU4
         18i4iVanMkGeETLGRVKfZHYC9TyqAOFvrDWcTMMebpTtdW21bAhc7LZcFke5GFwzLUtp
         lIfyRxrBAhQSPoAMrYHnJk6xqdZ1y3/7J5F3M8dK9rtSm15v4loZQMBxganzf1toiTla
         MEhlOLvt0bE5BVvQeea2yjbR5hyffDQQ5EuqvTjHv6wjg1Ye0yrBa8LL4fVKgx7T8ifs
         w4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WAHfMK/wO4fMYiKU9LDZg4Jep2aIYsjvtqPdpQXlzlA=;
        b=cDL8x+uJV21Qf/TxZBOMCH2y9lUNTqRJteSDd7+MGc92yKOwp0Cle0qhXX6SKplXVE
         YU1o2PTJKk8nMD+VOEfUPMKruVCo8snhV5g/kYw71uGfGRVTg/ELfWT53zyE26A74MXI
         f+Lfscap1WdaqOm92YINdvB/xEEHiTqreKs9TpnHnuR3NdkssAMHyLsg26h+xQx6/ZdS
         oxUErnIdJmgctNaWIWf5XB0bx1qDcg4hxXFHvp7YKvWYoG0/+7U6uthIc3bsI1iNMw6u
         yKp+uB4ACN45UISUYIzShz+XHmW++APGMtDhsmAtLMQctzZL1tSXTHm+q6puh21GGNNd
         BNEQ==
X-Gm-Message-State: AOAM531mAeG15QvP+dyrLCj5awEA+KhkKD0IsgSoxjqek0Bn2fbbbE9X
        fvibByxnDbE42Q87sZKNyYPxgQ==
X-Google-Smtp-Source: ABdhPJx2TtlVVewQaJWgDWOOqZP1A+fXDpcp9XoWi3kMMOS2ORttrMKa3Ms241TMQrRrEKHGmWSD8Q==
X-Received: by 2002:a05:6e02:664:: with SMTP id l4mr508080ilt.153.1632757171044;
        Mon, 27 Sep 2021 08:39:31 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id z20sm9377591ill.2.2021.09.27.08.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 08:39:30 -0700 (PDT)
Subject: Re: [PATCH] nvme: add command id quirk for apple controllers
To:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        sagi@grimberg.me, hch@lst.de
Cc:     linux-kernel@vger.kernel.org, Sven Peter <sven@svenpeter.dev>,
        Orlando Chamberlain <redecorating@protonmail.com>,
        Aditya Garg <gargaditya08@live.com>
References: <20210927153539.372986-1-kbusch@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <aea8dabd-4c5f-3183-89a3-b2019d004ded@kernel.dk>
Date:   Mon, 27 Sep 2021 09:39:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210927153539.372986-1-kbusch@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/21 9:35 AM, Keith Busch wrote:
> @@ -1026,7 +1027,8 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
>  		return BLK_STS_IOERR;
>  	}
>  
> -	nvme_req(req)->genctr++;
> +	if (!ctrl->quirks & NVME_QUIRK_SKIP_CID_GEN)
> +		nvme_req(req)->genctr++;

This doesn't look right, as it'll never be true...

-- 
Jens Axboe

