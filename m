Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F9131F135
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 21:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhBRUmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 15:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbhBRUkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 15:40:25 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECD0C061788
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 12:39:45 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id t18so1605831qvn.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 12:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=izMGeH6dYVvvRYrg+SR4dkbWf4tBjA1jwd/PyFi3k5E=;
        b=wvbQo9QE9Wp3Chgcgpv7CYoqwp7kuaqfdQiTlgUq1h2J0aIotvMIuP5ipnZFwbxCik
         8+fQDHd+5vQn9VJ9W7BEr6EmbrgE6VqkqCNPBdmPmWEIUk60ccqRFE1k7UM3MXNmEgDA
         b05+G2h4KJBlkqJQq9vMrgGM9SoyfU9dQzuhXajoxI2uvdnURdWWsa6wm08CK5jYHofJ
         yfhVgjvI4gye1JSSsSR8UHHdUyNq1LYs2H+H5JzmMRcxr+CNIUXUaNcNkbCNBvI7+Q93
         hBouq+CbswlkAnbHkan+su0ONtwzeDED5Vc0O4tZ5i22dBVOlbxXIbSagal8+HQyYlIM
         5RUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=izMGeH6dYVvvRYrg+SR4dkbWf4tBjA1jwd/PyFi3k5E=;
        b=qDkgvolbV/JV6lQZt0H2B+ydMilIgzUo02WGi4hAtW+EScPsNVFUwV/HgsD3trACw2
         21AW5Iw+6WejUhxcxbSOruKLoIxC0qHX13TnaXYpW+ItpCrody/AdRTVeX6Guhy6Sjvk
         RC83jbaKolsNp4Sewyqg/SF4rhENpVbxeoy/1/LtXU102BoiypNc4wQXm2ASSLjl2Jcq
         bFQuqLwvo5p0tTMXAx51vuF3TRCqQk7eEPFyrcsmoDXF8HDFLplVsPHm/zy8gSgOEZYA
         4F1souVKuH71x/VlA2ji/W3el0eSMGc7Y5cP5v5ny0qDtw7LQjZhKtoBgTMJ98sXxbXb
         cBgw==
X-Gm-Message-State: AOAM531MwfxS6D5azl5vZlEEHU6SgpNmaENAD2cjknyEB5a2ugA990oa
        kqclvzCYPL6leipHDoaYwkSrdATydVz3d1F4
X-Google-Smtp-Source: ABdhPJxztKx9mX1HlP26QR3/cQf+f3xOlIqt2zgVBzeiQy++BDSTSrLA4mV45L/nyeRanv+vk9XGhw==
X-Received: by 2002:a0c:fc44:: with SMTP id w4mr5848013qvp.55.1613680783943;
        Thu, 18 Feb 2021 12:39:43 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:11d9::1105? ([2620:10d:c091:480::1:bcfb])
        by smtp.gmail.com with ESMTPSA id s14sm4068292qtq.97.2021.02.18.12.39.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Feb 2021 12:39:42 -0800 (PST)
Subject: Re: [PATCH v6 0/2] fix a NULL pointer bug and simplify the code
To:     Sun Ke <sunke32@huawei.com>, axboe@kernel.dk, Markus.Elfring@web.de
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
References: <20210218122620.228375-1-sunke32@huawei.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <4f9d9983-2409-301d-73da-94f0f58c8782@toxicpanda.com>
Date:   Thu, 18 Feb 2021 15:39:41 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210218122620.228375-1-sunke32@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/21 7:26 AM, Sun Ke wrote:
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
>    nbd: Fix NULL pointer in flush_workqueue
>    nbd: share nbd_put and return by goto put_nbd
> 
>   drivers/block/nbd.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 

You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to both of these, thanks,

Josef
