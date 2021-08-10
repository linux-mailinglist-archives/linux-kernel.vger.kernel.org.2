Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF83C3E3BA7
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 18:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbhHHQpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 12:45:04 -0400
Received: from mail-pj1-f47.google.com ([209.85.216.47]:41491 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbhHHQpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 12:45:03 -0400
Received: by mail-pj1-f47.google.com with SMTP id u5-20020a17090ae005b029017842fe8f82so16833649pjy.0;
        Sun, 08 Aug 2021 09:44:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x86zqrZwK8I05NlyS2GLyhKTx+s5Y6a+1HCAxehwg2w=;
        b=huAsC1oiHmE6PxLdChA/kf/K3bRUENftR34/n//t04J9nag+XicVpZHAh/pZCtB8Qu
         mMyzXlFHjiYqHKf3C4qtM6kB9g0tyEPxSL4tIiI8caWH+RmfnMJVT3RiyiZRFR1G//hN
         x4qAOtwgr8+Fwam99BWkvD4tSwaHMEc8OrC4auqhyDsab2V+yeOqQz6rD9ffGjG26eCu
         CexoiSpUJhjJ7eaFGgulFnECHmZh/No2Onl4YJQfiwZeMdSu2Mg+6Y0zLafpVjL5ybTM
         kh2yzYYpzSjRW7nHMRLmEJeb+p5bTqrTrtjVgmJsBiaQwq3+4uAk6cmDIY1dFKNeQ/0+
         ATdA==
X-Gm-Message-State: AOAM532JRcb3oOtRkmVVtPC3TCbmnrXLag1uCrJgnY8crZS0RKY3wWZG
        zTLoaT8AESSSOAPzvX9xiRQ=
X-Google-Smtp-Source: ABdhPJwvbbi5JS3KyD8WVO0nXH9edgpsA9afRMG70uzrlKFAWrm/QmKeLtxu9UFauTgeoXXDJW1gpw==
X-Received: by 2002:aa7:9828:0:b029:3bd:dc3d:de5f with SMTP id q8-20020aa798280000b02903bddc3dde5fmr20227411pfl.47.1628441083293;
        Sun, 08 Aug 2021 09:44:43 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:b494:57cd:2ed2:765? ([2601:647:4000:d7:b494:57cd:2ed2:765])
        by smtp.gmail.com with ESMTPSA id v10sm4105622pfu.100.2021.08.08.09.44.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Aug 2021 09:44:42 -0700 (PDT)
Subject: Re: [PATCH 1/2] blk-mq: add two interfaces to lock/unlock
 blk_mq_tags->lock
To:     Yu Kuai <yukuai3@huawei.com>, axboe@kernel.dk,
        josef@toxicpanda.com, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        nbd@other.debian.org, yi.zhang@huawei.com
References: <20210808031752.579882-1-yukuai3@huawei.com>
 <20210808031752.579882-2-yukuai3@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <1e6b1a1e-eb45-f6c7-a8ce-e534b8cda710@acm.org>
Date:   Sun, 8 Aug 2021 09:44:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210808031752.579882-2-yukuai3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/21 8:17 PM, Yu Kuai wrote:
> +void blk_mq_tags_lock(struct blk_mq_tags *tags, unsigned long *flags)
> +{
> +	spin_lock_irqsave(&tags->lock, *flags);
> +}
> +EXPORT_SYMBOL(blk_mq_tags_lock);
> +
> +void blk_mq_tags_unlock(struct blk_mq_tags *tags, unsigned long *flags)
> +{
> +	spin_unlock_irqrestore(&tags->lock, *flags);
> +}
> +EXPORT_SYMBOL(blk_mq_tags_unlock);

The tag map lock is an implementation detail and hence this lock must
not be used directly by block drivers. I propose to introduce and export
a new function to block drivers that does the following:
* Lock tags->lock.
* Call blk_mq_tag_to_rq().
* Check whether the request is in the started state. If so, increment
its reference count.
* Unlock tags->lock.

Thanks,

Bart.
