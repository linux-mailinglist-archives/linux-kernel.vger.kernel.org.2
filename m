Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB3823DD480
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 13:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbhHBLQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 07:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbhHBLQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 07:16:54 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7D6C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 04:16:44 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id k4-20020a17090a5144b02901731c776526so31065562pjm.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 04:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R6GXUz7kzvPzppSdt3z4/dwHpwHS0zM/rSsMW9Edp1o=;
        b=IB3AOEneq/zsq6WG+K9Dx+tGjfWRzwSos4X1zR4PK+YOdHjaXNYL+0d057isGuH2bp
         U1W2OX/daOjme+rPee8zQnzgqRJAaGgxNrWL0BzDRHlIRLSoBhqcfSAbhSGu9/V/5ZGX
         pNXt5U9rcLjZaMOLU5H4hquh/+M0URu80NcCEFuDGcn/C6XhLUpotKnW6HWdgmRsr7i5
         YdLHgFQcEcMvs9YG3QjLXQwRP3jCFCoIewoczCg5c3CpsUT9AGa5ZJqy/aDQdLiVANFk
         iS3wKFtJaCr2GGVr7SSUY99Te33U+xpiBOFLChL37z3CgkwBq+XxxT0cm3YNiAnUGEps
         nhcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R6GXUz7kzvPzppSdt3z4/dwHpwHS0zM/rSsMW9Edp1o=;
        b=CxbJQxlkbzdCcKKVz/HG6UchpaCmzeidg1SZHJqgOpeIK0M4fJKmbum0hzL18KrgDv
         kYN2QPlWBC+7LxQoD+tGwEivc6t8oQm08Uh6X0B5a42XmZrbSWY2Iv8AE2Ia89pcWJRx
         RY7Sf7utgw1B4Uxkp9L+8aGxru7hBUTcH2wg22vQiROZhfym+mnrN9pRFCUaRdcOWnfb
         CpLdNfsT5RIwb2kqf0b4aTvicvT0xyElZeUUWinu2yRh7tINP0s44MFQnRV+61AZk9H7
         GKJ3keuV5hp3Fj9U3VL2zY8/EaMx71N10klnYGxBlbn1qoabe8Kz/7FtzpgZWsERyNUo
         6PVw==
X-Gm-Message-State: AOAM531Belzjs/i2rSNQteXiKtB6Mi4XXGqce7p6v0hZAPkT9bZ1T4ko
        +lOAQYo3EdTouP4XwzSSqtc=
X-Google-Smtp-Source: ABdhPJwfTXmmpUNkLpa4I7JfKlBw46SS76hdMpnno6UD5NxuaRk4EFtZTA3ZOXumH8zJRoqx6KSJCw==
X-Received: by 2002:a17:90a:e2c8:: with SMTP id fr8mr16316205pjb.131.1627903004035;
        Mon, 02 Aug 2021 04:16:44 -0700 (PDT)
Received: from [192.168.1.237] ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id p11sm10231087pju.20.2021.08.02.04.16.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 04:16:43 -0700 (PDT)
Subject: Re: [PATCH] mtd: fix lock hierarchy in deregister_mtd_blktrans
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Hillf Danton <hdanton@sina.com>
References: <20210717100719.728829-1-desmondcheongzx@gmail.com>
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Message-ID: <999b1450-949e-fd90-6bf2-7fd4452158bb@gmail.com>
Date:   Mon, 2 Aug 2021 19:16:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210717100719.728829-1-desmondcheongzx@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/7/21 6:07 pm, Desmond Cheong Zhi Xi wrote:
> There is a lock hierarchy of major_names_lock --> mtd_table_mutex. One
> existing chain is as follows:
> 
> 1. major_names_lock --> loop_ctl_mutex (when blk_request_module calls
> loop_probe)
> 
> 2. loop_ctl_mutex --> bdev->bd_mutex (when loop_control_ioctl calls
> loop_remove, which then calls del_gendisk)
> 
> 3. bdev->bd_mutex --> mtd_table_mutex (when blkdev_get_by_dev calls
> __blkdev_get, which then calls blktrans_open)
> 
> Since unregister_blkdev grabs the major_names_lock, we need to call it
> outside the critical section for mtd_table_mutex, otherwise we invert
> the lock hierarchy.
> 
> Reported-by: Hillf Danton <hdanton@sina.com>
> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
> ---
>   drivers/mtd/mtd_blkdevs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
> index 7d26cfe24d05..87e26788ef60 100644
> --- a/drivers/mtd/mtd_blkdevs.c
> +++ b/drivers/mtd/mtd_blkdevs.c
> @@ -563,8 +563,8 @@ int deregister_mtd_blktrans(struct mtd_blktrans_ops *tr)
>   	list_for_each_entry_safe(dev, next, &tr->devs, list)
>   		tr->remove_dev(dev);
>   
> -	unregister_blkdev(tr->major, tr->name);
>   	mutex_unlock(&mtd_table_mutex);
> +	unregister_blkdev(tr->major, tr->name);
>   
>   	BUG_ON(!list_empty(&tr->devs));
>   	return 0;
> 

Hi Miquèl,

Just a friendly ping, this patch is part 2 of fixing the lock hierarchy 
inversion between major_names_lock and mtd_table_mutex that was 
identified by Hillf Danton.

Best wishes,
Desmond
