Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D9F37AA2B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 17:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbhEKPE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 11:04:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60070 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231740AbhEKPE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 11:04:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620745430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Eby9jchOkc7O2SHfeUzBJFDqFmjRNT81QVOCo8h4KA=;
        b=fy8/6y7wzMcQvJHT4hOsZ15Ai9ivn+gvIQcT2tleLIioa7pSLO4vvRmXgip2o1aO0HTJhx
        d2pEh7Vi489IZCsgOemz0MLC1QpKzDnqO1tSwqBrXcHT8WYuFJy8Z+rXEn0GnDMESAX0Zd
        tqmCd7gl6qOObNQawlfbz5z8jLHHas8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-_bpi5LYGP16IsGE-ESAAFw-1; Tue, 11 May 2021 11:03:26 -0400
X-MC-Unique: _bpi5LYGP16IsGE-ESAAFw-1
Received: by mail-qk1-f197.google.com with SMTP id p133-20020a37428b0000b02902de31dd8da3so14612464qka.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 08:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3Eby9jchOkc7O2SHfeUzBJFDqFmjRNT81QVOCo8h4KA=;
        b=cj8mejqACJmSZLcYyfmwoMy43HYxAHyftfM9M0VRNjFZZkkHgxRHBugI4kvSh8qCLf
         288yATxX4jN4fIgvlBQHT3rwNspUlhABtaLW6frYOjbK2Kw5gAvzJcZCueYjHQ1Gn3/8
         /fijxUGN2qh013mT1ajyX7rSuC+fFSfnT4FD2oFc+U3U9RnZt7OtNY4qdiiKa4Eq/bVn
         uPTDqDluKeE4QmPpoPImWMzeSw6nVOwTlhGP59jN1QzIs4ZOF8/wF/oG8KifKFRu9ynS
         z+6uGUAUAV+8Lwd0rFpXdB0V3wOOQOMmMcaJqBAMxhek6epUYek1n/ogc866JYa2ABcQ
         SfNQ==
X-Gm-Message-State: AOAM530yJXiMjmAxwYeURdDZYEsx3+l5jgPCGJ0E6otb0RSTsiRIJaFC
        EqdZOf67at/CwYhlTt1B4jugQZZNkVMe6xWnYE9YCtNI/LfFI1YA0cYO0HdMxZ9h1Vxn18VWld0
        fYgxHQ18Zp3v1YI6/RMvKIj8R/TqHDzZLNhexkpz/Uv/gin8KIIz+nLdyaLW77DHlVfJHxbE=
X-Received: by 2002:a37:6c01:: with SMTP id h1mr29574775qkc.182.1620745405674;
        Tue, 11 May 2021 08:03:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylZ7KPLdnfiglpsvqgi8JdZPsTDTBvjBPmGvU/xeXlAorDSj5RQdQmQmiHOGfQlzm57HjAKw==
X-Received: by 2002:a37:6c01:: with SMTP id h1mr29574721qkc.182.1620745405156;
        Tue, 11 May 2021 08:03:25 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id a195sm13796674qkg.101.2021.05.11.08.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 08:03:24 -0700 (PDT)
Subject: Re: [PATCH v4] HID: ft260: improve error handling of
 ft260_hid_feature_report_get()
To:     Michael Zaidman <michael.zaidman@gmail.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-i2c@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210511101208.16401-1-michael.zaidman@gmail.com>
 <30c2857d-5094-402e-25a8-48f5be83fa3f@redhat.com>
 <20210511143427.GA1572@michael-VirtualBox>
From:   Tom Rix <trix@redhat.com>
Message-ID: <cf4b5b43-8e48-15ab-565a-38c748b469d4@redhat.com>
Date:   Tue, 11 May 2021 08:03:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210511143427.GA1572@michael-VirtualBox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/11/21 7:34 AM, Michael Zaidman wrote:
> On Tue, May 11, 2021 at 06:10:36AM -0700, Tom Rix wrote:
>> Generally change is fine.
>>
>> a nit below.
>>
>> On 5/11/21 3:12 AM, Michael Zaidman wrote:
>>> Fixes: 6a82582d9fa4 ("HID: ft260: add usb hid to i2c host bridge driver")
>>>
>>> The ft260_hid_feature_report_get() checks if the return size matches
>>> the requested size. But the function can also fail with at least -ENOMEM.
>>> Add the < 0 checks.
>>>
>>> In ft260_hid_feature_report_get(), do not do the memcpy to the caller's
>>> buffer if there is an error.
>>>
>>> ---
>>> v4   Fixed commit message
>>> ---
>>> v3   Simplify and optimize the changes
>>> ---
>>> v2:  add unlikely()'s for error conditions
>>> ---
>>>
>>> Signed-off-by: Tom Rix <trix@redhat.com>
>>> Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
>>> ---
>>>    drivers/hid/hid-ft260.c | 24 ++++++++++++------------
>>>    1 file changed, 12 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
>>> index 047aa85a7c83..7f4cb823129e 100644
>>> --- a/drivers/hid/hid-ft260.c
>>> +++ b/drivers/hid/hid-ft260.c
>>> @@ -249,7 +249,10 @@ static int ft260_hid_feature_report_get(struct hid_device *hdev,
>>>    	ret = hid_hw_raw_request(hdev, report_id, buf, len, HID_FEATURE_REPORT,
>>>    				 HID_REQ_GET_REPORT);
>>> -	memcpy(data, buf, len);
>>> +	if (likely(ret == len))
>>> +		memcpy(data, buf, len);
>>> +	else if (ret >= 0)
>>> +		ret = -EIO;
>>>    	kfree(buf);
>>>    	return ret;
>>>    }
>>> @@ -298,7 +301,7 @@ static int ft260_xfer_status(struct ft260_device *dev)
>>>    	ret = ft260_hid_feature_report_get(hdev, FT260_I2C_STATUS,
>>>    					   (u8 *)&report, sizeof(report));
>>> -	if (ret < 0) {
>>> +	if (unlikely(ret < 0)) {
>>>    		hid_err(hdev, "failed to retrieve status: %d\n", ret);
>>>    		return ret;
>>>    	}
>>> @@ -720,10 +723,9 @@ static int ft260_get_system_config(struct hid_device *hdev,
>>>    	ret = ft260_hid_feature_report_get(hdev, FT260_SYSTEM_SETTINGS,
>>>    					   (u8 *)cfg, len);
>>> -	if (ret != len) {
>>> +	if (ret < 0) {
>> nit: should be consistent and use unlikely(ret < 0) for this and other
>> similar checks.
>>
>> Tom
> I preserved the likely/unlikely hints in the critical path where the
> performance matters. And for the sake of consistency, I removed them from
> the rest of the places that are called rarely and are not performance-critical
> to be aligned to the other "if" statements in the code.

This is fine.

Thanks,

Tom

>
> Michael
>

