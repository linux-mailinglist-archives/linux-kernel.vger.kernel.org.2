Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFDF539B930
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 14:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbhFDMuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 08:50:05 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:43611 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhFDMuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 08:50:04 -0400
Received: by mail-wr1-f45.google.com with SMTP id u7so3752008wrs.10;
        Fri, 04 Jun 2021 05:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IgT2hjzT67a/grp8lXWefvUFoh31D6xYPYfahelUbqo=;
        b=LIvxKU+CoNp+JZ7yeBIZHP5kVzdviY4nbimd1MIkyfowovIXFhCQUs8q+Y8mtb2OTS
         bYTHMKdDOZ65hx2Oab6Hy/CU8on4h2DfzfvaWzIgX5aFhKPr42e1ZzbovncXg3byG/ld
         YwUINMPQP25dDcovmXH6WLlxZWhQy3Ww0Pqv0chosoi0RRuJJpmRTmbK4m+N2MFM83Jm
         M7+Lxp7x9qevQNzREqHhwXQiDZ9NhYCOS+PVQtvdfyL1BhpaaQCK8vFGxML+GSfPjocj
         UMoFhQapnY2dUoeh5yr/xkJzLKTb+bL3IEQV6KYJYK00Ic13OUv1BuIJBdPYLTjcegGM
         sL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IgT2hjzT67a/grp8lXWefvUFoh31D6xYPYfahelUbqo=;
        b=J8BGGsLll2tbkvTPQnkbP66fF9q9wPRv+e9+09mwmUKatwH943LVJx1TS8QvcLZg7J
         gAwRt/Wj7fKLRsjRRlceSjggXGheI50w8tIWGnzd2OtkBkHsH4+TTOYWFdN6gA2JsDNG
         ZmdWJ4ahtBX427wYQ7cPir2ZWAr3J0wFIAP8iMHo0v8rwKyqcSc8/jqSx16TE5DQj+01
         5SnBN+VRXtgk55gZ45ym5VgRB9Lfia+v6eoBsL7FdEv+/OAD8fbzgttaaAxfhzvEa26E
         K1SBUTmwEgw+zBligY1sQtYnQ/04w85XZQ4wSWQdQryZMvZxPoemolyABr2k1M16UrjD
         aTgA==
X-Gm-Message-State: AOAM533yVPpuFxLOBzRYlr8hVD16/VAKMTWV3BOoKZ1XHw58/rHS9gJC
        9VkQ1gRccqjMaboRQCwKRjLX/mcRfN0=
X-Google-Smtp-Source: ABdhPJxInLCezAYo1Cc/DhkGMecshl7EOMWiKOoUom722C7Bp06UyUNkqlDkGsorjTeJ2X9qE4zn8w==
X-Received: by 2002:a05:6000:110b:: with SMTP id z11mr3686921wrw.278.1622810837109;
        Fri, 04 Jun 2021 05:47:17 -0700 (PDT)
Received: from [192.168.2.202] (pd9e5aba0.dip0.t-ipconnect.de. [217.229.171.160])
        by smtp.gmail.com with ESMTPSA id p12sm6516578wrt.20.2021.06.04.05.47.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 05:47:16 -0700 (PDT)
Subject: Re: [PATCH 4/7] platform/surface: aggregator_cdev: Add support for
 forwarding events to user-space
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210603234526.2503590-1-luzmaximilian@gmail.com>
 <20210603234526.2503590-5-luzmaximilian@gmail.com>
 <a1a43f55-378f-d5e7-c439-d5397abdf838@redhat.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <778047e2-2b1d-ef8b-4fe3-aafba8fa2dba@gmail.com>
Date:   Fri, 4 Jun 2021 14:47:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <a1a43f55-378f-d5e7-c439-d5397abdf838@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/21 1:32 PM, Hans de Goede wrote:
> Hi,
> 
> I've one review remark inline below.
> 
> On 6/4/21 1:45 AM, Maximilian Luz wrote:

[...]

>> +static int ssam_cdev_device_open(struct inode *inode, struct file *filp)
>> +{
>> +	struct miscdevice *mdev = filp->private_data;
>> +	struct ssam_cdev_client *client;
>> +	struct ssam_cdev *cdev = container_of(mdev, struct ssam_cdev, mdev);
>> +
>> +	/* Initialize client */
>> +	client = vzalloc(sizeof(*client));
>> +	if (!client)
>> +		return -ENOMEM;
>> +
>> +	client->cdev = ssam_cdev_get(cdev);
>> +
>> +	INIT_LIST_HEAD(&client->node);
>> +
>> +	mutex_init(&client->notifier_lock);
>> +
>> +	mutex_init(&client->read_lock);
>> +	mutex_init(&client->write_lock);
>> +	INIT_KFIFO(client->buffer);
>> +	init_waitqueue_head(&client->waitq);
>> +
>> +	filp->private_data = client;
>> +
>> +	/* Attach client. */
>> +	down_write(&cdev->client_lock);
>> +
>> +	if (test_bit(SSAM_CDEV_DEVICE_SHUTDOWN_BIT, &cdev->flags)) {
>> +		up_write(&cdev->client_lock);
>> +		ssam_cdev_put(client->cdev);
> 
> You are missing the mutex_destroy() calls here which you are
> doing in ssam_cdev_device_release().

Thank you for noticing this! This code is based on Surface DTX code
which has the same problem, I'll send in a fix for that shortly.

> Or maybe move the mutex_init calls below this check
> (before the up_write()) since I don't think the client can
> be accessed by any code until the up_write is done?

Yes, that would also be possible, but I'd prefer adding the
mutex_destroy() calls in the failure path. To me that seems a bit easier
to reason about.

Thanks,
Max
