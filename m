Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED5034B0FA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 22:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhCZU7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 16:59:19 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:42648 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhCZU7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 16:59:05 -0400
Received: by mail-pf1-f172.google.com with SMTP id 11so5664537pfn.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 13:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=IxAxj/OH8Qm+KntT/l2kLPI6zFDDnFU+gwdrHz973IaR6Ts1LAmMyuddG31PojEFdb
         IQ+T0qLcpnJwH5UdWO3EyCpvMQOs3Cx2otwDJSDb0ebSB6G7r1erj7b1flC9qdAoL7yx
         qx9BoXNi5GWui6KNCydXzRsWyqU5e/q3GKXtfvAfynDnTUOnGzQUPaFQcysEBG26rHqr
         nut46Wfiym/V0BGc3h4cwWk+XZPD02tGHmIbmrXv6uOfRJ6UXpElpJS4XMCA58ADTOCZ
         du5GHdn5M8VyqTjGyysZGhAxErdNBJL87hpEAfLfaWa1svZdHHHQzgj+YZg1gGRNHvhM
         0Aaw==
X-Gm-Message-State: AOAM530dIEwGW8X/z73vGIQbRJOiWofoXT8qr7bMBGxs5B6k5y7iiIAj
        l4Ard4qjfQY3+xUAP0QogyCXaSxpPew=
X-Google-Smtp-Source: ABdhPJy0Azf7WLtn75JPuvIQUr2HbMIzpSlpcVK5hi4LsE+ZuTFkzvXgcUVs524pg+wXlcmL2M5GxA==
X-Received: by 2002:a65:6107:: with SMTP id z7mr14243684pgu.435.1616792345172;
        Fri, 26 Mar 2021 13:59:05 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5512:a799:a5d1:66a3? ([2601:647:4802:9070:5512:a799:a5d1:66a3])
        by smtp.gmail.com with ESMTPSA id d20sm9108893pjv.47.2021.03.26.13.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 13:59:04 -0700 (PDT)
Subject: Re: [PATCH v2] nvme: disallow passthru cmd from targeting a nsid !=
 nsid of the block dev
To:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     "minwoo.im.dev@gmail.com" <minwoo.im.dev@gmail.com>,
        "javier@javigon.com" <javier@javigon.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210326194749.396599-1-Niklas.Cassel@wdc.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0c67bd30-9718-0830-db46-cd36e8d5dca5@grimberg.me>
Date:   Fri, 26 Mar 2021 13:59:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210326194749.396599-1-Niklas.Cassel@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
