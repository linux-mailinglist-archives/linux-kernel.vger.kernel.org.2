Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9641436CB62
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 20:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236942AbhD0S7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 14:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235974AbhD0S7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 14:59:33 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6ACC061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 11:58:50 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id c3so23252169pfo.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 11:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tMWM9I3Cqm0UbXLUuFE6H4LTCjDc7K1QIsPCzwEpt5s=;
        b=Be+txuaRCQeqEAio5roWaNQghxHAgkuzwtUdNbRP5FHhQhryxSiGmth1NVN11QD9MW
         3itWzJbZSfxU7zlSMEMIQX2q9MBaU6GHDeMyYZVKU1tS+8JxthzMp0yapogpsPNdvnDb
         E9OsIQHhAKuV6X6D9rSJyWeeyvhetkTtvbz7smHMQWf3Vf3gIQDUcq6Zaojqfivko7JT
         7tIVHH4YtoUi7d0WNhCC7z5TsVSmKALYZfGFfGbMLlKtiUkm30pfPgWDacb0woxiKfm1
         xWzKAwklKZq4FaMBCEWYDSZVbkyF8ocwI8PnrzZCi5aMhKuxCLX9ZvcdeZOt1pCgwSM/
         584A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tMWM9I3Cqm0UbXLUuFE6H4LTCjDc7K1QIsPCzwEpt5s=;
        b=SbKeIgrq0r/sQ2iAWsc4sM7SCKdf5Vp761IBn33vSnVot7KoC+z2cjkyZd8bdQruNB
         78j/LNmIL/sA5PYOQFKxmSTBUwcVczWvyjqkW4M6M/gn5RwCWoOhaALPxIN+ApRAu4eI
         +ot5TSZv92HWjH+W6qEk45sLz0bU5NAf39VH16e3ZVxlAjTcw5SJU4BRR9MZHLsR+LLa
         yBZa3ByA1Vny+bJdZQrACBO9ayVOHxy7eV3fxBC2X8B0sqHMU4KHlY0FNsXSEKbkAJJx
         Nf1AgzhsHK0Bhn5TS9ydKHpPibAUmKtsYKU4aJGCT2pdTz/c1wkdu/9mIxszzGnimUAI
         uj5A==
X-Gm-Message-State: AOAM530pTCTf6oaDgHPyWJT+DvWZAOyVx6re/K6GbupvnSAS1qdtl2LF
        dlWa6328gkcX9ozZoN1TBAIrOD5K+w2VvBla
X-Google-Smtp-Source: ABdhPJy7bHFDkFDynD/WKdI5uugcpU5ERH/XnIaRcCZz3PRt/YczzXrzPcf3ZKirKnB3D8Kgm8BDSg==
X-Received: by 2002:a63:4c63:: with SMTP id m35mr22732185pgl.105.1619549929517;
        Tue, 27 Apr 2021 11:58:49 -0700 (PDT)
Received: from gmail.com ([103.52.209.34])
        by smtp.gmail.com with ESMTPSA id n203sm2242343pfd.31.2021.04.27.11.58.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Apr 2021 11:58:48 -0700 (PDT)
Date:   Wed, 28 Apr 2021 00:28:44 +0530
From:   Jitendra <jkhasdev@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: fix array of flexible structures
Message-ID: <20210427185844.GA1030@gmail.com>
References: <20210427174945.1323-1-jkhasdev@gmail.com>
 <YIhTjGpmLSYKuCi3@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YIhTjGpmLSYKuCi3@kroah.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 08:10:20PM +0200, Greg KH wrote:
>On Tue, Apr 27, 2021 at 11:19:45PM +0530, Jitendra Khasdev wrote:
>> This patch fixes sparse warning "array of flexible structures"
>> for rtllib.h.
>>
>> eg. drivers/staging/rtl8192e/rtllib.h:832:48: warning: array of
>> flexible structures
>>
>> Signed-off-by: Jitendra Khasdev <jkhasdev@gmail.com>
>> ---
>>  drivers/staging/rtl8192e/rtllib.h | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
>> index 4cabaf2..c7cb318 100644
>> --- a/drivers/staging/rtl8192e/rtllib.h
>> +++ b/drivers/staging/rtl8192e/rtllib.h
>> @@ -802,7 +802,7 @@ struct rtllib_authentication {
>>  	__le16 transaction;
>>  	__le16 status;
>>  	/*challenge*/
>> -	struct rtllib_info_element info_element[];
>> +	struct rtllib_info_element *info_element;
>
>You just changed the definition of this structure, and the other
>structures here.  Are you sure this is working properly?
>

I have compiled the driver and install it on my vm, but I don't this specific
hardware, so couldn't test it.

I fixed in context of sparse.

---
Jitendra
