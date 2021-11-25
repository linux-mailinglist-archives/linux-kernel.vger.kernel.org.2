Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613F145DEC7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 17:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356648AbhKYQwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 11:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239939AbhKYQuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 11:50:08 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD268C06139C
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 08:36:46 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id w22so8257828ioa.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 08:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O1ZDNgn834WbCkz4HbANyUMJbAE8lQOkVdODgu49duE=;
        b=lpBtjs5FChdGoxM3f15NbuZmNklhn03BhbUEubWPMNmwedM/+bTWqXmWthWmxZ4eFy
         cx3gsFVeZru24lHPWxX1gHP0780oaBUx1yhZPAk5q7N1difFx+8v9iz2SNd2KJ21rpmo
         aYCCefR9+DyIrZ6agFO1gpHnrTIJ00/cfdqRTexetffiJyTbXJ8hfTtU+fvKKrdwCvWG
         B+7N1NkMhsKLl2RqweSAhuJJWs0yzf7sZekHRycWvAMFX1fiAKehPmovrpNSfCCs7kf5
         6tHjd3QtJ5IVd2iSuzBCeqNon2M90x/7aARh+/SB5fnlV9K8SbjgkqL16cfrjo7PZh4D
         paCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O1ZDNgn834WbCkz4HbANyUMJbAE8lQOkVdODgu49duE=;
        b=WE8R/1uGMrQH82TiAk228Qau9blUfBoiIbL7l92jBqo+h/wR4msY1JIBm7V2hTK/S3
         pHpW2GWQpj56PhuCkkt0575Z3AW4fETE/1phZBMf0JgHlxQCzdBuPmkkKWS2DjxO03mG
         mbKeUlrTaohO/0jUvKh7CLuI1gh63hNpwdQh4gNtLAuzJsa0r+Sc2SxIPjYexRTak4J2
         cQXb8XBl/MogmBMjwVxW/53rGh5LwEg+BjpTbQwhSj/Q+426HfAJmPbpHk+NGD+PFR/D
         JQtBNm+3N3//ag40USrdd/6j/zwuMx9M/YVb2dTYW5iPH7F/hlGze7LtAJIv3KFV0xZO
         5p7g==
X-Gm-Message-State: AOAM533anWYSd4JlWIWUoBS8++mrDuCD3FyK8Aqq/lHupOgFFlIeKOQr
        sM76EHi4zkClzmpXgTHgvYJW6w==
X-Google-Smtp-Source: ABdhPJywbE+wGzJAR6pUFsTE7EziAsQyLRWt+geVKbMSftt+6s5knBMhPsAdy474yBpSGE+51wfrOg==
X-Received: by 2002:a05:6602:14cd:: with SMTP id b13mr26816851iow.203.1637858206013;
        Thu, 25 Nov 2021 08:36:46 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id i1sm1871909ilm.5.2021.11.25.08.36.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Nov 2021 08:36:45 -0800 (PST)
Subject: Re: [PATCH v2] block: fix parameter not described warning
To:     davidcomponentone@gmail.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <acf6fdca867ff78a13099ea6615ac39d69bbfc9b.1637825871.git.yang.guang5@zte.com.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6b11ce2f-fdea-1cfa-10f1-44e5664d64ed@kernel.dk>
Date:   Thu, 25 Nov 2021 09:36:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <acf6fdca867ff78a13099ea6615ac39d69bbfc9b.1637825871.git.yang.guang5@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/21 9:20 AM, davidcomponentone@gmail.com wrote:
> From: Yang Guang <yang.guang5@zte.com.cn>
> 
> The build warning:
> block/blk-core.c:968: warning: Function parameter or member 'iob'
> not described in 'bio_poll'.

Applied, thanks.

-- 
Jens Axboe

