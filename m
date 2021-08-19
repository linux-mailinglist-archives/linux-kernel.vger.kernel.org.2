Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4BC33F202B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 20:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbhHSSuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 14:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbhHSSuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 14:50:22 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85715C061756
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 11:49:45 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id m7-20020a9d4c87000000b0051875f56b95so9936194otf.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 11:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wZO4IQUBhF+zViy7c/z72TEVhnsnazrJSkCDX3RnSfk=;
        b=XpvoNNqO5fpuLndPvyQDsbEKlf2t6TEbmSz5IGx0TKWxhXZRUYokx4QLVTmy79isMR
         AYkGMmjxwPxTX2I24mKJy+ji+7uZcQe7FKdIUFB/lAcu5YhQ6jlW0g04fIWxsWcnJuRd
         EJcKLz+fiEeVZ3uzKkVTyhn3pBEy4EdTeoB7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wZO4IQUBhF+zViy7c/z72TEVhnsnazrJSkCDX3RnSfk=;
        b=NFM7FEvMMWzpZt0Dq9wr5iwDTZvWRNPmYrbXGKUmctIpOuR27X88OlhcG/ZfegRbSS
         8opGW8OoTk1kxjSAp+c3cwV78zmZkDbQ00F7fYTbMPY/jWRfkw8ENiZwqUMElREPCU4/
         dw3RfcHcI6KwcNIZ3vhyu59AEDqQxWCHmMsyvvl107CHZCL04VMctkT3dSmaFUyc+n3L
         GF4AGsEmpBgUtVVd602E6B7mwtLmXrx4wnDyq2ZVaUdkG/2p7asjzJ2FSMlWGWC0XIoB
         DNHEHrMmnlsRzoqrnyag0wm8A08vUrssOOIOejhLXAzCIiU+1YdLo9wZKQ/YDL2e4xvJ
         hOvw==
X-Gm-Message-State: AOAM532WMKKSZx1YrhUT6cWBVaTwqbB7F1tYRnqKzost7JE6+LSd2W2f
        SemeA7g4RTQbTTyO4NJr4x8S8w==
X-Google-Smtp-Source: ABdhPJwGWMs9CmtUV/fPZRUmX0o0GPrIgHbgo+fXSJ6pj+cipfWWEk/8/hpw0qy/D12H3XqGTR47pw==
X-Received: by 2002:a05:6830:40b4:: with SMTP id x52mr13230648ott.163.1629398984755;
        Thu, 19 Aug 2021 11:49:44 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h14sm888563otm.5.2021.08.19.11.49.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 11:49:44 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] usbip: give back URBs for unsent unlink requests
 during cleanup
To:     Anirudh Rayabharam <mail@anirudhrb.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, valentina.manea.m@gmail.com,
        shuah@kernel.org,
        syzbot+74d6ef051d3d2eacf428@syzkaller.appspotmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210813182508.28127-1-mail@anirudhrb.com>
 <20210813182508.28127-2-mail@anirudhrb.com>
 <13450a85-bbfe-09c5-d614-1a944c2600c2@linuxfoundation.org>
 <YRydGRdPmOaiMWaY@kroah.com>
 <cb36604b-37f1-c12e-3ebb-cdafd7798dc1@linuxfoundation.org>
 <YR6eQUpoe9cORXGu@anirudhrb.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <78a30ac4-8e18-50cd-cd18-02d8f9868383@linuxfoundation.org>
Date:   Thu, 19 Aug 2021 12:49:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YR6eQUpoe9cORXGu@anirudhrb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/21 12:09 PM, Anirudh Rayabharam wrote:
> On Wed, Aug 18, 2021 at 12:36:11PM -0600, Shuah Khan wrote:
>> On 8/17/21 11:39 PM, Greg KH wrote:
>>> On Tue, Aug 17, 2021 at 05:16:51PM -0600, Shuah Khan wrote:
>>>> On 8/13/21 12:25 PM, Anirudh Rayabharam wrote:
>>>>> In vhci_device_unlink_cleanup(), the URBs for unsent unlink requests are
>>>>> not given back. This sometimes causes usb_kill_urb to wait indefinitely
>>>>> for that urb to be given back. syzbot has reported a hung task issue [1]
>>>>> for this.
>>>>>
>>>>> To fix this, give back the urbs corresponding to unsent unlink requests
>>>>> (unlink_tx list) similar to how urbs corresponding to unanswered unlink
>>>>> requests (unlink_rx list) are given back.
>>>>>
>>>>> [1]: https://syzkaller.appspot.com/bug?id=08f12df95ae7da69814e64eb5515d5a85ed06b76
>>>>>
>>>>> Reported-by: syzbot+74d6ef051d3d2eacf428@syzkaller.appspotmail.com
>>>>> Tested-by: syzbot+74d6ef051d3d2eacf428@syzkaller.appspotmail.com
>>>>> Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
>>>>> ---
>>>>>     drivers/usb/usbip/vhci_hcd.c | 26 ++++++++++++++++++++++++++
>>>>>     1 file changed, 26 insertions(+)
>>>>>
>>>>> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
>>>>> index 4ba6bcdaa8e9..6f3f374d4bbc 100644
>>>>> --- a/drivers/usb/usbip/vhci_hcd.c
>>>>> +++ b/drivers/usb/usbip/vhci_hcd.c
>>>>> @@ -957,8 +957,34 @@ static void vhci_device_unlink_cleanup(struct vhci_device *vdev)
>>>>>     	spin_lock(&vdev->priv_lock);
>>>>>     	list_for_each_entry_safe(unlink, tmp, &vdev->unlink_tx, list) {
>>>>> +		struct urb *urb;
>>>>> +
>>>>> +		/* give back URB of unsent unlink request */
>>>>>     		pr_info("unlink cleanup tx %lu\n", unlink->unlink_seqnum);
>>>>
>>>> I know this is an exiting one.
>>>> Let's make this pr_debug or remove it all together.
>>>>
>>>>> +
>>>>> +		urb = pickup_urb_and_free_priv(vdev, unlink->unlink_seqnum);
>>>>> +		if (!urb) {
>>>>> +			pr_info("the urb (seqnum %lu) was already given back\n",
>>>>> +				unlink->unlink_seqnum);
>>>>
>>>> Let's make this pr_debug or remove it all together.
>>>
>>> As you have a struct device for all of these, please use dev_dbg() and
>>> friends, not pr_*(), for all of these.
>>>
>>
>> Yes. Makes perfect sense.
> 
> Perhaps we should use usbip_dbg_vhci_hc() instead of dev_dbg()? It is
> one of the custom macros defined by the usbip driver for printing debug
> logs.
> 

Yes that macro could be used. However, let's just get rid of the messages.
I don't see much use for them.

thanks,
-- Shuah
