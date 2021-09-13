Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F254096CF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 17:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345260AbhIMPNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 11:13:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56784 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245320AbhIMPNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 11:13:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631545943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y8vuImHpLHsUuz/CiYzXbPCx1krBVQwZHILgxE2iSiQ=;
        b=bwy0tx+WepUmlkVI95tsd3VZRR/4nL3mMotI7D1+C1GDVEjZsNddlnLlq2/PA2v/hPVP+A
        vrSmZQ7ZPZ8qI/75VbCrl27LYl/NG4cK/mfLahYUyAWj0kCr9TOVXUTCKL7v57MAbhJcBt
        QjTaZGqSSljOIPuHsjJBQzYSxy/+qpE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-YZbslUNWMwKdheTVUAW_nA-1; Mon, 13 Sep 2021 11:12:21 -0400
X-MC-Unique: YZbslUNWMwKdheTVUAW_nA-1
Received: by mail-ej1-f69.google.com with SMTP id f10-20020a170906390a00b005eeb8ca19f7so2260702eje.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 08:12:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y8vuImHpLHsUuz/CiYzXbPCx1krBVQwZHILgxE2iSiQ=;
        b=yYZW7eRWIu9R6UxPQccE4uvo4oL3fm3TKEptxvNxuTAlMeOcUhHZtz/bb/g4hDNM+T
         xnksmQ5Al5jpW4/khWNxqCYnAmLtRv4B4OYHg3Xw6U+jQf4CJCsLkbt6B9bWi//6Klwp
         YOzv17nzrsKGxOzt1rjbVdk3hXONSwNPaWbr5e1r8wkVo1LYWUyPbL1tSqbBLGp5T8Fm
         IKJj9ESdLHkJLDZkRddP9ySjSgMU0++0TbSKKhcwP7jobdaxCr/YRJQzTp02IYykWtIn
         sK8QMbZEAaNCb21AJNI2w55jaXz26vx5jyzMB3bzJNT9atsoI0bS8jCbLXDSPzXVy+yg
         P3OA==
X-Gm-Message-State: AOAM530VgmtB8e7cREU7v885CbEuraL7JUUCj/fb3E8lzOtpIJNt6jgP
        Hvd6zgMAf1d9OtPuc9ztUrhDXdOXUOCX/IDk0rfmlG+O6v5JBSkFICYIbxOKwkvpP4x3z0CDI7Z
        +XnOJi9M1Ep+F1u+kG5s90N8zkAk/12acB6Ip0ehQqV6heYzEFIEYoRJ+aDNf+A2u5bshvaGAcN
        MB
X-Received: by 2002:a17:906:cc57:: with SMTP id mm23mr13277967ejb.540.1631545940569;
        Mon, 13 Sep 2021 08:12:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmC7zS+f8GRA8zaPm3asjDVXcYgExJu946U7Ki08njDOojCPAnl4NWRv/aT/KOCQ9XRGMOmw==
X-Received: by 2002:a17:906:cc57:: with SMTP id mm23mr13277943ejb.540.1631545940364;
        Mon, 13 Sep 2021 08:12:20 -0700 (PDT)
Received: from x1.localdomain ([81.30.35.201])
        by smtp.gmail.com with ESMTPSA id b8sm4058631edv.96.2021.09.13.08.12.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 08:12:20 -0700 (PDT)
Subject: Re: [PATCH] staging: rtl8723bs: protect sleepq_len access by
 sleep_q.lock
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210913130346.2390-1-fabioaiuto83@gmail.com>
 <d6d6c6bf-b787-aac9-4767-4bf54c5437ac@redhat.com>
 <20210913133915.GA1414@agape.jhs>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <30e138d5-fc51-bbcd-4dfc-3264c258c0bc@redhat.com>
Date:   Mon, 13 Sep 2021 17:12:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210913133915.GA1414@agape.jhs>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

On 9/13/21 3:39 PM, Fabio Aiuto wrote:
> Hello Hans,
> 
> On Mon, Sep 13, 2021 at 03:24:44PM +0200, Hans de Goede wrote:
>> Hi Fabio,
>>
>  
>>> Note that sleep_q.lock is already taken inside
>>> rtw_free_xmitframe_queue so we just wrap sleepq_len
>>> access.
>>>
>>> Moved pxmitpriv->lock after sleep_q.lock release to
>>> avoid locks nesting.
> 
>>>  	rtw_free_xmitframe_queue(pxmitpriv, &psta->sleep_q);
>>> +	spin_lock_bh(&psta->sleep_q.lock);
>>
>> AFAICT this needs to be above the rtw_free_xmitframe_queue() ?
> 
> as I wrote on the changelog, the sleep_q.lock is already
> taken inside rtw_free_xmitframe_queue. If I put the
> sleep_q.lock above that function a soft lock occurs when
> I disconnect.
> 
> So I put it just below rtw_free_xmitframe_queue.
> 
> Things works fine this way.
> 
> Please tell me if there's a best way to do it.

Hmm I see, this may work, but the sleepq_len access
really should be protected by the same lock as the freeing
of the queue is without dropping it in between.

That rtw_free_xmitframe_queue() takes the sleep_q.lock
then to me that signals that other (higher-level) functions should
not take sleep_q.lock at all, since this is then private to the
functions operating on the sleep_q.

I've an idea how we we can possibly tackle this, but I'm not sure
yet I will try to make some time to look into this tomorrow or
the day after.

Regards,

Hans

