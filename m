Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D173305E85
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 15:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbhA0Omc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 09:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbhA0Olb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 09:41:31 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B46C06178C;
        Wed, 27 Jan 2021 06:40:51 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id v19so1692038pgj.12;
        Wed, 27 Jan 2021 06:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=WtvFLrTUDDZSQU8DQdUtxH/Jsc8mFdlHHcBvGUXAMiU=;
        b=PRFM28i75GL4RCeAD1T0mKW8QQBwgTrE7H3QeOOY5AZkpVKocdhgs+gxTwVKsjE/qj
         VDw5/IA3LJswd9GE4jz8fsl2YoHaOTnujNbqT501mTryj9W06cJLk8ph38KJvK4AlnS6
         EbCURMkHqY3fbEwVPSUNahUisghDmjb+eZNEBDEYrDguGsBUvIrA0PEban17K7NcrDra
         5I+MJw5AqoBowpEb8kWOHcxdZp4Qdeu6cgrc7mtA5ncX/GPQvzVf0LIhmBb/Orh8p1oR
         ERFdLE9sCrKPLbI76NdIpfH076MC5/qaJoWuUwL32VcgWgZ1lAaNt8RF6QCfVrbyH8R0
         ijbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=WtvFLrTUDDZSQU8DQdUtxH/Jsc8mFdlHHcBvGUXAMiU=;
        b=iTdeGkST5OR14BRlXKKJID7yDFbFmRNBmQofF+AZ0L/Qs/bWh7g8a4scIJoh8ND+Eb
         9/QDwJptYALd+ZTxV2Di0pNdHRxQSJ08Qg5fSPTeA9A5yDgo/b21Mc1SPF4GZRMED+dg
         8zuNWUWfQh1qoVna3g5Qil72/673eE1W8tP5n3/D767BQYHqucKFcKBII2zKDV190hBw
         YN7CEyaDnY31i1wFYdsmSuqIRBf2tWe2hcmzSp6+N+ZH6m4QR5OyavqBTm9H1wZ+rcA4
         Ge2tkjzSfk1ovhpBBz7biyoFhiNq9xn3nmemgAN1tDNoFovgqWoVaJJhwJx+0nZFMUau
         0q0w==
X-Gm-Message-State: AOAM532phG02po6PdVgjYjZoBWxU9A9atzQAhWjYGgh5HPed3YkA+AnD
        MIXU9R7hra0cTDfzdGKjrgfSo7Ua7uyovWr6oYU=
X-Google-Smtp-Source: ABdhPJyRR5geFEqX/wlAu41kzMtW9RZS1sv7mgqpCn8/pfXT9kw3MfB+mxIkOCicOE9YTDbc38eLow==
X-Received: by 2002:a65:4201:: with SMTP id c1mr9473879pgq.10.1611758450151;
        Wed, 27 Jan 2021 06:40:50 -0800 (PST)
Received: from [192.168.0.104] ([49.207.195.86])
        by smtp.gmail.com with ESMTPSA id x63sm2951384pfc.145.2021.01.27.06.40.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 06:40:48 -0800 (PST)
Subject: Re: [PATCH v3 02/12] usb: misc: cypress_cy7c63: update to use
 usb_control_msg_recv()
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210126183403.911653-1-anant.thazhemadam@gmail.com>
 <20210126183403.911653-3-anant.thazhemadam@gmail.com>
 <YBF0B50Q9gi/Ezpz@hovoldconsulting.com>
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
Message-ID: <2347687a-d92e-d06e-a8b5-a67a45d5040b@gmail.com>
Date:   Wed, 27 Jan 2021 20:10:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YBF0B50Q9gi/Ezpz@hovoldconsulting.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27/01/21 7:39 pm, Johan Hovold wrote:
> On Wed, Jan 27, 2021 at 12:03:53AM +0530, Anant Thazhemadam wrote:
>> The newer usb_control_msg_{send|recv}() API are an improvement on the
>> existing usb_control_msg() as it ensures that a short read/write is treated
> Short write has always been an error (I won't repeat for the remaining
> patches).
>
>> as an error, data can be used off the stack, and raw usb pipes need not be
>> created in the calling functions.
>> For this reason, the instance of usb_control_msg() has been replaced with
>> usb_control_msg_recv().
>>
>> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
>> ---
>>  drivers/usb/misc/cypress_cy7c63.c | 21 +++++----------------
>>  1 file changed, 5 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/usb/misc/cypress_cy7c63.c b/drivers/usb/misc/cypress_cy7c63.c
>> index 14faec51d7a5..76a320ef17a7 100644
>> --- a/drivers/usb/misc/cypress_cy7c63.c
>> +++ b/drivers/usb/misc/cypress_cy7c63.c
>> @@ -70,24 +70,15 @@ static int vendor_command(struct cypress *dev, unsigned char request,
>>  			  unsigned char address, unsigned char data)
>>  {
>>  	int retval = 0;
>> -	unsigned int pipe;
>> -	unsigned char *iobuf;
>> -
>> -	/* allocate some memory for the i/o buffer*/
>> -	iobuf = kzalloc(CYPRESS_MAX_REQSIZE, GFP_KERNEL);
>> -	if (!iobuf) {
>> -		retval = -ENOMEM;
>> -		goto error;
>> -	}
>> +	u8 iobuf[CYPRESS_MAX_REQSIZE] = {0};
>>  
>>  	dev_dbg(&dev->udev->dev, "Sending usb_control_msg (data: %d)\n", data);
>>  
>>  	/* prepare usb control message and send it upstream */
>> -	pipe = usb_rcvctrlpipe(dev->udev, 0);
>> -	retval = usb_control_msg(dev->udev, pipe, request,
>> -				 USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_OTHER,
>> -				 address, data, iobuf, CYPRESS_MAX_REQSIZE,
>> -				 USB_CTRL_GET_TIMEOUT);
>> +	retval = usb_control_msg_recv(dev->udev, 0, request,
>> +				      USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_OTHER,
>> +				      address, data, &iobuf, CYPRESS_MAX_REQSIZE,
>> +				      USB_CTRL_GET_TIMEOUT, GFP_KERNEL);
> Are you sure that the device always returns CYPRESS_MAX_REQSIZE here?
> Otherwise, this change may break the driver as it currently only uses
> the first two bytes of the received message, and only for some requests.
>
> Note that the driver appears uses the same helper function for
> CYPRESS_WRITE_PORT commands, which probably doesn't return 8 bytes in a
> reply.
>
> You could possibly add the missing short read check for the
> CYPRESS_READ_PORT case, but I'm afraid that the new helper are not a
> good fit here either.
>

Understood, but I think that change might be better proposed (for this, and cytherm, both)
separately from this series, so I'll just drop it from this series for now.

Thanks,
Anant

