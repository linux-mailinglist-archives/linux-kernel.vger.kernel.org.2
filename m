Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B9B437BA1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 19:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbhJVRRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 13:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbhJVRRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 13:17:04 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E2DC061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 10:14:46 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d9so4237348pfl.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 10:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7U9+zJYjAf+Rhfg180f5nzP1XSF1WIVuMlxaLJYkKQ8=;
        b=bah7/3Vqtn8tHlBNiyLef+utZeGdc1FiGtalUuj6q7FBZn7RqrtAaU6kNX3WSLlpff
         vRcNuNtlVbEb2Fctyy/2Elg1PuSIx5UQO6kvYTVN56VICGwa9h6RY822lGIoiYSjOLfU
         9tX38fOhDXweBN0MaF5USDTe3UiqkTlTw9mOTlU2ilsmruPggZIMuAE4WrV1b6jKLFnr
         lXakS0ZAHowe5/1+XpINF/4idUAQGJlc17LAw3l4+qJdMrptjw1p3fiyRT3lelqdKeRG
         R3R9BVujnqkjw924AfQpmS8v7eGfWuapfA+T+3pR/R651Px4vcQIxDznnH3z2Q+w1Qt8
         aKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7U9+zJYjAf+Rhfg180f5nzP1XSF1WIVuMlxaLJYkKQ8=;
        b=um3+QAbW/2wuPLZhjKyF5IB2paGNC7Qf9OEePREPYKy6w+JmKwZ3cH7FBbOJuP7y1/
         K8zIxnsLk5MGVzmkwgo4fzYSRR0gq9CKd7/MQ3bKltf/TPDXzoJ6WnIe6ACXvTWCuGSw
         D4z2QM+xbprmfTnazPVDXEb72swxfHbqUYA7iNqVYNdN8JJuBsf0+6HoGsFXdCX+Kkll
         C763smUbHGNqi04llPgQxXR5gF4uzvojnBeNY6o5G6IKA+j7PIm3xSvMmSs7zonfIPRG
         HzfKWUIGi1CYfw0qELb0jIJ6kdMPktjPL5ahenqrISvnG4jqYwJr4JmepFbfW26g+a7J
         vs6w==
X-Gm-Message-State: AOAM532Ot6rpc0iCIGfEuSsUccykltiCrOeG/yyfuo9A03/O5rhZhMVq
        H/SOev1lMGvS86NVpDN/4rs9CHkGyMY=
X-Google-Smtp-Source: ABdhPJxyIK92vOn4UulzUeIuCTEBsdHf2zZaD8KaezPhEwCpRxnkk0B202jvUC5p0h3wGv4u8ZqDDQ==
X-Received: by 2002:aa7:9250:0:b0:44c:27d1:7f0f with SMTP id 16-20020aa79250000000b0044c27d17f0fmr823778pfp.41.1634922884417;
        Fri, 22 Oct 2021 10:14:44 -0700 (PDT)
Received: from [192.168.1.4] ([59.95.89.188])
        by smtp.gmail.com with ESMTPSA id 21sm13095088pjg.57.2021.10.22.10.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 10:14:43 -0700 (PDT)
Message-ID: <1dfe5681-adf7-bb24-c68f-97c7d2748ba1@gmail.com>
Date:   Fri, 22 Oct 2021 22:44:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH v3] staging: rtl8723bs: os_dep: simplify the return
 statement
Content-Language: en-GB
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, marcocesati@gmail.com,
        insafonov@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, saurav.girepunje@hotmail.com
References: <YWhBQF4yUH0/r53A@Sauravs-MacBook-Air.local>
 <20211014145726.GO8429@kadam>
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
In-Reply-To: <20211014145726.GO8429@kadam>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/10/21 8:27 pm, Dan Carpenter wrote:
> On Thu, Oct 14, 2021 at 08:10:00PM +0530, Saurav Girepunje wrote:
>>  .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 29 ++++++++-----------
>>  1 file changed, 12 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
>> index 0868f56e2979..217b86bfb722 100644
>> --- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
>> +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
>> @@ -2281,19 +2281,16 @@ static int rtw_cfg80211_add_monitor_if(struct adapter *padapter, char *name, str
>>  	struct rtw_wdev_priv *pwdev_priv = adapter_wdev_data(padapter);
>>
>>  	if (!name) {
>> -		ret = -EINVAL;
>> -		goto out;
>> +		return -EINVAL;
>>  	}
> 
> You need to delete the curly braces, otherwise your patch will introduce
> a checkpatch warning.  Same below as well.
> 
> regards,
> dan carpenter
> 

Ok, I will update patch for this and will send another version.
Thanks Dan for reviewing the patch.

Regards,
Saurav  
