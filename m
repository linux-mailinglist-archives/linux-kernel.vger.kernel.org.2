Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9154296D4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 20:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbhJKS2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 14:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhJKS2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 14:28:16 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B86C061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 11:26:15 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id f21so3123450plb.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 11:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VmcSECGnOUaWoR76+4+A/fQOEUXFG/jxjXv7Pvp4BiA=;
        b=nVosvBiAkKPDcjo/BdERl5hIJzb/pFgIZroGL3upHmftU7cFF93U8CvKhC65sYwtXQ
         ZbhZtvoPLZYVgmB55D2uBFufCIxiT4S3SWjAe89FDTFHRItgNlJ8vqBbnpYAjM7ywPiW
         pGlY7z73P4KlK8eok1R3GvT0z9W6zy9ro18EOpQKoW/wHOf5YE+ElBai1mZkQ93vPIJv
         hRH/SVPJe419ObCmhQKukQsxiW0aPvMOH3cpgLlt9j8fN9DXFEZE3K6Un7Kp8lllECDX
         u91hB1bEJhFMOL/AEAEmlFwm/3V9UeK5QKNwXZqtYI+q4x0X0qm7NBGREWrgFtctUuVr
         Iy0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VmcSECGnOUaWoR76+4+A/fQOEUXFG/jxjXv7Pvp4BiA=;
        b=xq4kio2l+aAKCA/NAyDFROvD7pz7q+B4BBhXMjczmxyR+eoiUsty3ODjJyDWnsqCgw
         KAU22kwP9v/IMCzP23F8cw1Rkv6M2Eg6vvYVZ15MQEBRrFSKtlm8YH16vZGMU8fU4dDU
         +2ael6CPpu2UwcKAsL/bBMSbbDU96jRO/x29G7JH52FQKuOrxkURUZvyrbbLRFsEcPrK
         drVyporqbIdQrWC+lIWCKvnNhpAIQpeNRGCgP8Q4oHaIwitu2TPq7s6w/yfDQPU0Y7PD
         YGXOHIwvFBgyPNn+qlmjsdaRdcdvXRnGzYSeSRLEIsyAE1Z7mDPjBjNzkeR8Jcegt82X
         F4XA==
X-Gm-Message-State: AOAM530t3FsxsXyRN9SvQW8TDkAkajv+F06eiriSBJJQcU1AdcjCUS7W
        LCBfaLYqk+q1dJAMlKjXm00=
X-Google-Smtp-Source: ABdhPJzJw/xG9013yI7BdK9Wf3d+oC5YwBN8CMkzv2Jd6/Ln0iTIITBHmCYg+jKlGMmia6BJDFDOhw==
X-Received: by 2002:a17:90b:4b07:: with SMTP id lx7mr592046pjb.195.1633976775221;
        Mon, 11 Oct 2021 11:26:15 -0700 (PDT)
Received: from [192.168.1.14] ([223.230.99.151])
        by smtp.gmail.com with ESMTPSA id a30sm8189651pfr.64.2021.10.11.11.26.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 11:26:14 -0700 (PDT)
Message-ID: <05689c1a-546b-7d5d-0196-59f1a2caaba4@gmail.com>
Date:   Mon, 11 Oct 2021 23:56:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH] staging: rtl8723bs: os_dep: simplify the return
 statement.
Content-Language: en-GB
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, marcocesati@gmail.com,
        insafonov@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, saurav.girepunje@hotmail.com
References: <YWG3oIchovDZnPl8@user> <20211011122631.GA8429@kadam>
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
In-Reply-To: <20211011122631.GA8429@kadam>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/10/21 5:56 pm, Dan Carpenter wrote:
> This introduces a use after free on the sucess path.  You need to be a
> lot more careful.
> 
> On Sat, Oct 09, 2021 at 09:09:12PM +0530, Saurav Girepunje wrote:
>> Remove the unneeded and redundant check of variable on goto out.
>> Simplify the return using multiple goto label to avoid
>> unneeded check.
>>
>> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
>> ---
>>  .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 29 ++++++++++---------
>>  1 file changed, 15 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
>> index 0868f56e2979..574fdb6adce7 100644
>> --- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
>> +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
>> @@ -2282,18 +2282,18 @@ static int rtw_cfg80211_add_monitor_if(struct adapter *padapter, char *name, str
>>
>>  	if (!name) {
>>  		ret = -EINVAL;
>> -		goto out;
>> +		goto err_out;
> 
> Just return directly.  "return -EINVAL;" but what does "goto err_out;"
> do?  No one knows without scrolling down to the very bottom of the
> function, then scrolling all the way up again.  At this point you have
> lost your place in the code and your train of thought is de-railed.
> 
> Plus it introduces "forgot to set the error code" bugs.
> 
>> @@ -2312,7 +2312,7 @@ static int rtw_cfg80211_add_monitor_if(struct adapter *padapter, char *name, str
>>  	mon_wdev = rtw_zmalloc(sizeof(struct wireless_dev));
>>  	if (!mon_wdev) {
>>  		ret = -ENOMEM;
>> -		goto out;
>> +		goto err_zmalloc;
> 
> 
> This is a Come From style naming.  Imagine if instead of naming functions
> after what they do we instead named them after the first caller which
> was introduced.  kmalloc() would be named called_from_boot_510().  It's
> a usless naming scheme.  We have to scroll down to the bottom to see
> what it does.
>
I will send another patch to remove goto and simply return ret value.
>>  	}
>>
>>  	mon_wdev->wiphy = padapter->rtw_wdev->wiphy;
>> @@ -2322,22 +2322,23 @@ static int rtw_cfg80211_add_monitor_if(struct adapter *padapter, char *name, str
>>
>>  	ret = cfg80211_register_netdevice(mon_ndev);
>>  	if (ret) {
>> -		goto out;
>> +		goto err_register;
>>  	}
>>
>>  	*ndev = pwdev_priv->pmon_ndev = mon_ndev;
>>  	memcpy(pwdev_priv->ifname_mon, name, IFNAMSIZ+1);
>>
>> -out:
>> -	if (ret && mon_wdev) {
>> -		kfree(mon_wdev);
>> -		mon_wdev = NULL;
>> -	}
>> +err_register:
>>
>> -	if (ret && mon_ndev) {
>> -		free_netdev(mon_ndev);
>> -		*ndev = mon_ndev = NULL;
>> -	}
>> +	kfree(mon_wdev);
>> +	mon_wdev = NULL;
> 
> This is an on stack variable.  Think about what you are doing.  You're
> not writing carefully at all.
> 
I didn't removed local variable assignment to NULL on this patch. 
However I agree this is another improvement possible on this function and can be done along with other changes. 
Please let me know you opinion whether I should send one patch or multiple patch in a single series.
 
>> +
>> +err_zmalloc:
>> +
>> +	free_netdev(mon_ndev);
>> +	*ndev = mon_ndev = NULL;
> 
> mon_ndev is local too.
> 
> regards,
> dan carpenter
> 
> 
Regards,
Saurav
