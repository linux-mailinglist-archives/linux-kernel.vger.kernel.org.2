Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E0239A516
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 17:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhFCP4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 11:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhFCP4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 11:56:47 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895D2C06175F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 08:54:47 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id d9so6844768ioo.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 08:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OQ8/izGugLT2mg1DaIwELKOTXax/WeIQBPj5/sAmtrM=;
        b=sWRObvHAN4uM8PnmujHncknfBPxl21ZOniXu3Dux67+WGcu23NMh3W6RrJOkoxB8QA
         2OU+0KkLfMZIVPk1kNPOPv7swr00MTbUX6ZKkP/YEFnc/WK+mf58qnArZuxOspM88n0y
         LpTS5ZXOO2bJ7nVweslbdch4xpF6+GL+r+TVUGMoXsRIw7N1rJM0wvnJabdSSjXtkRnc
         g4LnDYFI35vBVCcwun/cXvfB+zOKM9jMUBIZnA2+uZFzKEZzUn2jJ/EdPb4vo6PjTHw9
         N9HUkRZU6hA2vXjjzTFurjLEkd6gbsPzExUJazanOQoj3bVj3VlB/VnM3okLFx+MtMq1
         /Lbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OQ8/izGugLT2mg1DaIwELKOTXax/WeIQBPj5/sAmtrM=;
        b=aOs7bDArSrwXVg3AAOsAt0G8JLkV5S1GCn42FoIlHvhLa3HwLXlkvdSyK+xVzwpKs0
         2rvXJfYmshcha0Yse0EK65xaHRHfw9tXjfl3SdRyVZAoIxdU5duPuS39EKRLRRytDA5O
         DMx/98HlGs0D4FkwOjqzfiA+vE91G+y5k2mYaTPtgr/QDi0d1wtwtYn9UzITTy/DLC9X
         VLmPt0rR4ZhCS6Pfd7bDYd0kZULFT5UpqV68FcSY36mO2IYJ19oBZ5mtVDARkNLU5g6u
         VN2XEgi7DUhP/jmLEWqlAVmCJuH2BDla+VxPKi8cHyF1Y61PWkX5uTV5m8yfgILGFKS3
         VfIw==
X-Gm-Message-State: AOAM531ZbljyahV9sjxoPImAf6kGr9yJOlkfFLrKxTSkUZ+sYlgEfdhe
        BYthl/uoVaCdHiK71h2gQxsfNrHmMqiuC4Q1
X-Google-Smtp-Source: ABdhPJzaVvt+H2s1I25emL3iM4LnUpQGECU4+1p6n6DiGlCBOlOcFHd7oP51g1mmEsRRfRUYZSP7rA==
X-Received: by 2002:a6b:7b0a:: with SMTP id l10mr6024iop.120.1622735686716;
        Thu, 03 Jun 2021 08:54:46 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id x6sm2002769ilg.87.2021.06.03.08.54.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 08:54:46 -0700 (PDT)
Subject: Re: [PATCH][next] null_blk: Fix null pointer dereference on
 nullb->disk on blk_cleanup_disk call
To:     Colin King <colin.king@canonical.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210602100659.11058-1-colin.king@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ce16729c-01c6-7ce8-6c06-c43439186683@kernel.dk>
Date:   Thu, 3 Jun 2021 09:54:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210602100659.11058-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/21 4:06 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The error handling on a nullb->disk allocation currently jumps to
> out_cleanup_disk that calls blk_cleanup_disk with a null pointer causing
> a null pointer dereference issue. Fix this by jumping to out_cleanup_tags
> instead.

Applied, thanks.

-- 
Jens Axboe

