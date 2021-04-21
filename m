Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F463670A2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 18:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244451AbhDUQwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 12:52:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59480 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236337AbhDUQwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 12:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619023892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gjQXrH4xeYrIB2ORoikJWsh5LNazWseLuD6nZZi/C1I=;
        b=dBGYwTqltyNdVhotQ/BuIslLzBhXbKwshZhbLU5j4zXnyBAAIl8BhmrLPGp8EwYnTElf6u
        il6ABKTjOtcsbo8eTa/wzTw+jRyGSrxIANGEFd2uq2c+KWtV7mRo4g3I3MyYafa5yAb1me
        cHp5x+wp45Rt7x4C3gzLcajALSB91mg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-T0M4KLG3OhGv3CWO9triXg-1; Wed, 21 Apr 2021 12:51:28 -0400
X-MC-Unique: T0M4KLG3OhGv3CWO9triXg-1
Received: by mail-ed1-f70.google.com with SMTP id y10-20020a50f1ca0000b0290382d654f75eso15348822edl.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 09:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gjQXrH4xeYrIB2ORoikJWsh5LNazWseLuD6nZZi/C1I=;
        b=tbgVwwUHAEtJXHf0K+WzIpvdxsZsCoQBgAuBRG10UpXWi2Xj4ILCtCQsGKYOz/+Pb0
         A/+0c56WB/pwYU3d6czyUyo7vKbdWn70p6mGdAHHYlXkuX9YdpINvjK+3iNWyG8pQA9O
         yQqXlP98M4R+RHD8c5BCE1aeuKddybTqQ7n5rZW91M2nrd7xOgytgq0mtVSqMPBgv8p3
         5ZxrumiVGpu7pFwXC5ioOA81+ZxjqwoDXeyPlO+KuankcAE8ysAt1lZOIhmozPNH/JLG
         s4+MIHK7ybCzN1eIB9H8I84gDGNN0P8/ahMLA4A6lGBcAFICf2Yq/2qVP8hr1pVVY1jp
         Raag==
X-Gm-Message-State: AOAM532EP6rtrwiupdmQjQu1zQfi+ls8YbPsBORUWC0Ypgx/9CyD15Ea
        Qu7g0oJSKqUGHm618OXC6hjK6wpZ7ewERE7R5sUVUjqVSasSK1mza53oWv69nm13n3Ctw2BI9GQ
        oCHscZBqLHZvlFImdAvHpW99o
X-Received: by 2002:aa7:ca0f:: with SMTP id y15mr37849849eds.384.1619023885980;
        Wed, 21 Apr 2021 09:51:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqW7Azbf5F1ylPKe7siKINVBCl7sWZ+mUGWj7pdZphS3ywhBU9wnzZ/97mUdsSbPAHSB3k1A==
X-Received: by 2002:aa7:ca0f:: with SMTP id y15mr37849837eds.384.1619023885859;
        Wed, 21 Apr 2021 09:51:25 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id i2sm38288ejv.99.2021.04.21.09.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 09:51:25 -0700 (PDT)
Subject: Re: [PATCH 186/190] Revert "virt: vbox: Only copy_from_user the
 request-header once"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Wenwen Wang <wang6495@umn.edu>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-187-gregkh@linuxfoundation.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <68067532-56e5-c135-7a7e-0743c8e7b2a0@redhat.com>
Date:   Wed, 21 Apr 2021 18:51:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210421130105.1226686-187-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 4/21/21 3:01 PM, Greg Kroah-Hartman wrote:
> This reverts commit bd23a7269834dc7c1f93e83535d16ebc44b75eba.
> 
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
> 
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
> 
> Cc: Wenwen Wang <wang6495@umn.edu>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Ugh what a mess (the whole umn.edu thing).

I still remember reviewing this patch during its original submission
and I've reviewed it again this morning when you just send it out.

And now after letting it sit for a bit I've reviewed it a third time
and it seems to do what it says on the label / in the original commit
msg; and if fixes a real, potentially security, issue.

I'm not sure what the process is for "good" patches in the set
which you are reverting. I would prefer for this patch to be dropped
from the set of reveert. But I can also submit a revert of the revert(?)
once this set of reverts has been merged.

Regards,

Hans



> ---
>  drivers/virt/vboxguest/vboxguest_linux.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/virt/vboxguest/vboxguest_linux.c b/drivers/virt/vboxguest/vboxguest_linux.c
> index 73eb34849eab..f5cd9cfa1ef6 100644
> --- a/drivers/virt/vboxguest/vboxguest_linux.c
> +++ b/drivers/virt/vboxguest/vboxguest_linux.c
> @@ -142,9 +142,7 @@ static long vbg_misc_device_ioctl(struct file *filp, unsigned int req,
>  	if (!buf)
>  		return -ENOMEM;
>  
> -	*((struct vbg_ioctl_hdr *)buf) = hdr;
> -	if (copy_from_user(buf + sizeof(hdr), (void *)arg + sizeof(hdr),
> -			   hdr.size_in - sizeof(hdr))) {
> +	if (copy_from_user(buf, (void *)arg, hdr.size_in)) {
>  		ret = -EFAULT;
>  		goto out;
>  	}
> 

