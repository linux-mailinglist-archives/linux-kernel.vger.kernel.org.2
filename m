Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E0C3448F6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 16:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhCVPNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 11:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbhCVPNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 11:13:34 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE6FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 08:13:33 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id c8so4564119wrq.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 08:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=VysOd7JGH9gT3/LRqqRm69PWvwIDxPS1K6pogNzHJGI=;
        b=ujwpfc235jQygxl1afQfSvgbeiyQCq7xew1f0IdmjzRIizEF5pX8+MFuLQsNzaVFbu
         RnATlE6myxiWyKZRjX4/MPo1hKFSm4Y8Kj2mM41NpR8CEzQ6UlS3WvXdGm8TmBfaMM3s
         K5yTHS8yLetw44JmMRKy2T7p2LV0vXpmxP+AKAAPywGHflw50GiwiRpBGkdhdies9K+1
         KnE/fALxlFKZMQXXiBUUuZWU+NED0kj58lbPjtdMj3t3MFV6JzsTjiqTGg2s+Qbaof0H
         r+vbnyagbNBYHddfBUesjwU7hIbNqHtnfHSXMr2iGFkkf50LrsQgnHkwHmcs1v8XpqHz
         chdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=VysOd7JGH9gT3/LRqqRm69PWvwIDxPS1K6pogNzHJGI=;
        b=om++rmP2sLHV07qR09wk3Xn2EV9+hl/B6fWWdDOBUrtH4x43EEOOMTIzxUFYwqj5pK
         u9XD3qV+dtXkcRXn01OgWKuLAJYwa69mKf7Adk7jD+ZZIOGZhgMD8478n8xcQm7YXvB4
         xsD+upbY7eWuvhF6rHTF7LhMYzbuv5sEGJFy5CktycjURIvfcpzWa8/WsHBW5UMLgw+B
         pUfgCowSbz8NtOBVmIN4mnfCSDMAtudRC1SfMaeGKIm2FO8742ytb4JogCptFUAr5pKY
         ofkRZMMOAYFKYloHo5nRMOfQZjF87fus/fNGbE3pX1gQzIDDaTQRNSfZJ2Ec3ckb+HCj
         wlvw==
X-Gm-Message-State: AOAM531MB/lEBNhLTokXZ1li68Ablu0GCi/8WfezaacBdSKO35TNw7aa
        gEW4rkn9gP+lTWu6OaXmWx50agIrpEou9w==
X-Google-Smtp-Source: ABdhPJye0gWgAG14XY6N0FMgflw27w619B5cRSFfQrBJN4jzyfBz3l7IVg1JoQgV3uGAw+nek+nZvQ==
X-Received: by 2002:adf:e74a:: with SMTP id c10mr19475136wrn.409.1616426012462;
        Mon, 22 Mar 2021 08:13:32 -0700 (PDT)
Received: from LEGION ([111.119.187.56])
        by smtp.gmail.com with ESMTPSA id u3sm20258525wrt.82.2021.03.22.08.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 08:13:32 -0700 (PDT)
Message-ID: <440f562a5e3f56b5954f9bf3b9c155b3e173ae66.camel@gmail.com>
Subject: Re: [PATCH] media: em28xx: fix memory leak
From:   Muhammad Usama Anjum <musamaanjum@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        dvyukov@google.com
Cc:     syzkaller-bugs@googlegroups.com, musamaanjum@gmail.com
Date:   Mon, 22 Mar 2021 20:13:24 +0500
In-Reply-To: <20210322145420.GA2063636@LEGION>
References: <20210322145420.GA2063636@LEGION>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-03-22 at 19:54 +0500, Muhammad Usama Anjum wrote:
> If some error occurs, URB buffers should also be freed. If they aren't
> freed with the dvb here, the em28xx_dvb_fini call doesn't frees the URB
> buffers as dvb is set to NULL. The function in which error occurs should
> do all the cleanup for the allocations it had done.
> 
> Tested the patch with the reproducer provided by syzbot. This patch
> fixes the memleak.
> 
> Reported-by: syzbot+889397c820fa56adf25d@syzkaller.appspotmail.com
> Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
> ---
>  drivers/media/usb/em28xx/em28xx-dvb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/usb/em28xx/em28xx-dvb.c b/drivers/media/usb/em28xx/em28xx-dvb.c
> index 526424279637..471bd74667e3 100644
> --- a/drivers/media/usb/em28xx/em28xx-dvb.c
> +++ b/drivers/media/usb/em28xx/em28xx-dvb.c
> @@ -2010,6 +2010,7 @@ static int em28xx_dvb_init(struct em28xx *dev)
>  	return result;
>  
>  out_free:
> +	em28xx_uninit_usb_xfer(dev, EM28XX_DIGITAL_MODE);
>  	kfree(dvb);
>  	dev->dvb = NULL;
>  	goto ret;
I should have replied to email originated by the syzbot. Anyhow here are some
details from that email:

syzbot found the following issue on:

HEAD commit:    1a4431a5 Merge tag 'afs-fixes-20210315' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11013a7cd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff6b8b2e9d5a1227
dashboard link: https://syzkaller.appspot.com/bug?extid=889397c820fa56adf25d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1559ae3ad00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=176985c6d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+889397c820fa56adf25d@syzkaller.appspotmail.com

Thanks,
Usama

