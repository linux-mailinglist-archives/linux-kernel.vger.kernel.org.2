Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B344D31F386
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 02:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbhBSBIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 20:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhBSBIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 20:08:42 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93999C061756
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 17:08:02 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id d2so3114972pjs.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 17:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gtRvuZllWLJvgWkeOsFOqRZkywemAhOtgZ0A+r5rKzo=;
        b=1rCm2Q6LKW2K4r62YbXikCf6EHSI+PRLfvD0EeO6aVgu0VWCMbnaswKJ1KxPknmeur
         eyMW2XR0k1h1e+NdfgndIBdoxZUjL9kF9TaH4X42BTdnit/KY/WuBYHfUK+UVdipQUGn
         oL2OkOMHz5t1KDX/ReKBX/8x99NdwJVSVr9A8Fi62rOeHAgyrLSNRJzXw+60h9Kw7bmm
         xFdfmJj6Q0IRkQSTH9c3SBz0AL6ZP8Y+VnaYE6w86XZkmsqNZtXzx+7iDpfsxvuxUlwH
         KhTXhyn2gPbsihEtDpAeg9hN82jsDzPcyemAl2c2Hw4RMCdER8Ox0GPzHOmxfAd+yNr8
         hsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gtRvuZllWLJvgWkeOsFOqRZkywemAhOtgZ0A+r5rKzo=;
        b=IBF2XnYhR+ITyRyDv9fWT9TOZRC1+avN6ZK6uX/vF64YP4nMmyYBILYWsuzIkirgi6
         92K1S2PieWwsrfmPBoyVLNFNqGlQoVEW27JdQ6GBmhfRGJdcTDGwWiVImpmLjY0KvR4i
         thYv0Jlc/M6/qdi5hvekTyiCXnQmyieEi9sAL0xgoxxzcwXC4eaBPJpFVx6InHJu+xau
         C5E85u0L7LRsCnoa7ZwFmenLRhOVH/7H4/m8WdxBupfpjkhdwmxKzyDDW/rHBWp9g1cL
         mNdJw/fiyHJDLO1p7PijbFDIJuMxiNUTPhy+Ne7n45MLc0/UCdCRghVZO2blKtCaNIyJ
         SrLA==
X-Gm-Message-State: AOAM531FMdJ6KH+EB3NOsOEhm0a6oIVBYUbUxGm/4r3OHze37O+OvN5T
        gnHVLScSgGmFAyKdwHjXFhYj03DiatxU8A==
X-Google-Smtp-Source: ABdhPJziquv0hmp3TbynLdn+U1SvAQttZ4o7yWpkhxeqGtYB4aKOtXYhWdB87Ue2cR3BnkJf+jXw5g==
X-Received: by 2002:a17:902:7887:b029:e3:8ef0:9a9d with SMTP id q7-20020a1709027887b02900e38ef09a9dmr6351472pll.2.1613696881718;
        Thu, 18 Feb 2021 17:08:01 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id h11sm6387043pjc.27.2021.02.18.17.08.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Feb 2021 17:08:01 -0800 (PST)
Subject: Re: [PATCH v6 0/2] fix a NULL pointer bug and simplify the code
To:     Sun Ke <sunke32@huawei.com>, josef@toxicpanda.com,
        Markus.Elfring@web.de
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
References: <20210218122620.228375-1-sunke32@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6df9a13d-b876-976f-ad48-884c88815269@kernel.dk>
Date:   Thu, 18 Feb 2021 18:07:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210218122620.228375-1-sunke32@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/21 5:26 AM, Sun Ke wrote:
> fix a NULL pointer bug and simplify the code
> 
> v6: Just add if (nbd->recv_workq) to nbd_disconnect_and_put().
> v5: Adjust the title and add “Suggested-by”.
> v4: Share exception handling code for if branches and 
> 	move put_nbd adjustment to a separate patch.
> v3: Do not use unlock and add put_nbd.
> v2: Use jump target unlock.
> 
> Sun Ke (2):
>   nbd: Fix NULL pointer in flush_workqueue
>   nbd: share nbd_put and return by goto put_nbd
> 
>  drivers/block/nbd.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Applied for 5.12, thanks.

-- 
Jens Axboe

