Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8B9380C7A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 17:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhENPCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 11:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhENPCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 11:02:10 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96866C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 08:00:58 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id p8so28272713iol.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 08:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vFbowzzPmTj3jyLGuQbNYzZiGpBZhRFAidVoo1PXCOE=;
        b=nSnM4FdnqKKZdRnCZ5mAj/2SIZby4F1z7eH5tCDrlx6dPi5pcoxOk6W1CsSyFERCNm
         fm2HWWqzIesnxZiIGrqaxzzjXEs1/wxJ9ZEH6+mXKBYt6y9lddtgQfB0jXRKQ3iXIL/R
         3mLlWLZfdLqQJbySkI5E7/Z7aJo8QxfY9M4MUCgYy1ESSmFqxzmzgcUCGrSeWkOmBx5N
         2SMMtuCy5hmvDXFMF6OwUbC3NScGKGU+GWYYftWR5x/rSU0p4hlXOlwS3slnN5umkeiC
         B6NUqgDXl/gA3iztIXIvlurZJyzwbcanoFLKtS+ZOv+WlpqZD3sgQmLQMCBBWW/e3oeB
         Agqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vFbowzzPmTj3jyLGuQbNYzZiGpBZhRFAidVoo1PXCOE=;
        b=rzjlZ7Mvuf/iVpQUP1vVt1vJJtzY3YD9yvpH2c3lPCXPCr1IGLfOP90IHSmJvtA0yL
         kb2dCLxo+yx2Dwyst+4tzsEp55ly8sTfSZEHcfC2cQ8nWZqkSK26rtsYkSApSlKoDhmJ
         Jp1STo3T6WdmqI2uQh9eu1kiNWsI+6Bext6+FU1tXXJ3e6dFBTkQk2u5Hi2agqgn/+eA
         BBBMt2F205QLBVFsxPiC/cC/PJ68+UgsKjgftK5ttQpe60w7i2WJLS31tW9mca/2dT+r
         rdDxgyHKB38hRjGqeL7Dmts5jem5R1+avJP3x7Q3qzgDpvoU2CwJhoqp5AuI8O1olwBN
         y7yw==
X-Gm-Message-State: AOAM531rmNAR3pDbqC8h99P36pkVjtqtiPShZ5svoLzemdp9xWeZ40zx
        yeX1f2OUE7sDz1lwxISVKdyRvA==
X-Google-Smtp-Source: ABdhPJyVcxAGjFolEtTidhP1667r0C4uVQOhyfuQG7f35Pu3QxM+iofTvJpr034kTL57GEgNZk/B3w==
X-Received: by 2002:a02:380d:: with SMTP id b13mr42709885jaa.77.1621004458045;
        Fri, 14 May 2021 08:00:58 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id n16sm3117493ilq.44.2021.05.14.08.00.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 08:00:57 -0700 (PDT)
Subject: Re: [PATCH][next] rsxx: Use struct_size() in vmalloc()
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20210513203730.GA212128@embeddedor>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fb567b7b-5ea4-fe8b-52cc-f148ff6a61b7@kernel.dk>
Date:   Fri, 14 May 2021 09:00:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210513203730.GA212128@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/21 2:37 PM, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version,
> in order to avoid any potential type mistakes or integer overflows
> that, in the worst scenario, could lead to heap overflows.
> 
> This code was detected with the help of Coccinelle and, audited and
> fixed manually.

Applied, thanks.

-- 
Jens Axboe

