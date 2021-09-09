Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933AB405DFD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 22:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344809AbhIIUZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 16:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235619AbhIIUZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 16:25:38 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC63C061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 13:24:28 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id a15so3994965iot.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 13:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=OybFG9pUPwR/fnE8znH9FLHXr+scTSP+Qko723tBqWY=;
        b=RdLu3kA2N6cIsL7LokCA8kwbXm2d1ORznndCRwLnw7N3uFStJdodVlSWkejTvmZEzU
         HQ+wcaMGY227c4Q5aa1CGWQYxKyqh1P0ENiiq4olWFUvF7SGC5POtD5iH9G0Y1G7CkKc
         mwXfNrpqRbGqKQEyeXlLr5owL8dS7V9oYZY864cxiHIvdxRPDqLHa8N00PX/UYoGVtZJ
         vael8Gi3VJ4EmJFthcl25mbBcie04J/RFotzfN67S0e7SwM21W/DcUhSOpghS/gVuVI2
         hyVahjEBbmhUJb7nzynr555C+5m5JWrliJXwkRw2m7+DLaqyoxXQ3jwBV9uIDUAMOJT2
         +4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OybFG9pUPwR/fnE8znH9FLHXr+scTSP+Qko723tBqWY=;
        b=LCvBeosmixLmLLrutkJYajlODrbtDNTWvSLrVeCZ39YbyX+sI0zDB3dlINpoLWCK1a
         ev10Gsk2Xv36DcBm+2brMT3ixVNZKwfe0xh/A4oHjCzwpFM0lce0qr/8e97sTWUMTGZF
         gRHVyOfBnxIHDXB/R9zYCQlX7dVj3xH/JrMXqtHrpViscnlGMDNXPEw+BgSuKcUzLYWi
         jHkW9uIe/DS/bPkkssReXKf/iB7xKHNjAskT2KnimT95M2mqAVw7q4ZbMIfq3n41BL/7
         rKwO2sftiZircPHIafU3i1JitUGh7qQLdJcmB2qSTAefUSiOhIQbDstoF7mek4bMMa3h
         PPzA==
X-Gm-Message-State: AOAM532QKxi8i7lG4Fk9W+jOtlWnK4bzKMDiGAT+YXFqv+ACiuEyTAnp
        9IB3znVyahLoxu4awNGPMh9FP0+m9QyImj5RlW4=
X-Google-Smtp-Source: ABdhPJzd3eqYyitt7qw63VxVF0Cf8uY3onxrLNIIoV6n3HQYqKZt2OVGb+seh3eAkhthzRQrkHYPBg==
X-Received: by 2002:a02:9542:: with SMTP id y60mr1451689jah.87.1631219067801;
        Thu, 09 Sep 2021 13:24:27 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id m5sm1442765ila.10.2021.09.09.13.24.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 13:24:27 -0700 (PDT)
Subject: Re: [PATCH] n64cart: fix return value check in n64cart_probe()
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20210909090608.2989716-1-yangyingliang@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f1bbf463-2b1d-0ec2-8e51-155dd6565f78@kernel.dk>
Date:   Thu, 9 Sep 2021 14:24:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210909090608.2989716-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/21 3:06 AM, Yang Yingliang wrote:
> In case of error, the function devm_platform_ioremap_resource()
> returns ERR_PTR() and never returns NULL. The NULL test in the
> return value check should be replaced with IS_ERR().

Applied, thanks.

-- 
Jens Axboe

