Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B63C407647
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 13:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235728AbhIKLfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 07:35:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36284 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231749AbhIKLfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 07:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631360043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yEm7cnF19/AqBzk1RSgs+u9mlG8J/Qh8RgOEQT+2Udg=;
        b=J86MTC9Litnw6NqJSJ5uf3Y2M7rucyewqkQOQuTHeeLNzg4JIqYx5H/+SJP+OunEFjzC+s
        w8sqkrZKuLOgezvZCggyOThlZAFfQ3ABEmHLlvwF1jK6aiaPmwHFG7EJG8QKE5wY76V1aO
        XnxR5JlLiSQmwLLJ4dZpf5J9e+p5Kxw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-fqrIuiqUMoub1wjdUch99Q-1; Sat, 11 Sep 2021 07:34:02 -0400
X-MC-Unique: fqrIuiqUMoub1wjdUch99Q-1
Received: by mail-ed1-f71.google.com with SMTP id y17-20020a50e611000000b003d051004603so1815373edm.8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 04:34:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yEm7cnF19/AqBzk1RSgs+u9mlG8J/Qh8RgOEQT+2Udg=;
        b=g5NP26KfGw8fjLngzpEZTkCSM+CD5l7GZYvrp3rFMzZip1fqFqwjZVra9kOcF0KzoH
         5f/S0VWsYl9O0NLS2eKpQbBr06SszAITMcdrlpfx2Aub8GRl2LhJbEfzhpJohsOU8lO0
         P3+LtLDypXr6KggEKrTzWYIovq0Vg9Avo1kZCecozQRTtIi5KGi3va4qfkZM2P52Gwku
         Ho54mTWCRzDhY+xer9KifcTrwLBWevNPTLtyIAqgRUYb4zu9Aa5UCscM0y5neWZnZJZD
         0cqLolwe9N40MNpcIqoGRqpaLvtHSVbAD/5Y9KMDTW8iporrGtBRhRBYOERDoUIWAif8
         XDNg==
X-Gm-Message-State: AOAM533ep/1qLJffCyoUzWNw0wXlJbaTeCwwMhm4Cy9CQXH9uzitxZvD
        m27boRV4yxypH4WhFZrcojTi1mMwtsDxqxBBRyESR6klte0fo5hkVruNHTMrf5GjDcA8ooZ33ap
        sSQVU8BcOeLfpjd2EDGV7ALzX
X-Received: by 2002:a17:906:7053:: with SMTP id r19mr840262ejj.476.1631360040708;
        Sat, 11 Sep 2021 04:34:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlCGg+Mu2jOiN1DZ6zbibuzaqaPwGGLYxveFlQGzwcliJ7Yoone2wNv43oCN41yGqfkZxR4A==
X-Received: by 2002:a17:906:7053:: with SMTP id r19mr840246ejj.476.1631360040543;
        Sat, 11 Sep 2021 04:34:00 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id e11sm794540edq.30.2021.09.11.04.33.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Sep 2021 04:34:00 -0700 (PDT)
Subject: Re: [PATCH v2] staging: rtl8723bs: remove possible deadlock when
 disconnect
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>
References: <20210902093559.9779-1-fabioaiuto83@gmail.com>
 <c730848c-3c8d-1e49-fa74-b956400a5d3d@redhat.com>
 <20210911105307.GB1407@agape.jhs>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <bc640665-2768-6add-d523-6ee80849eb98@redhat.com>
Date:   Sat, 11 Sep 2021 13:33:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210911105307.GB1407@agape.jhs>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 9/11/21 12:53 PM, Fabio Aiuto wrote:
> Hello Hans,
> 
> On Fri, Sep 10, 2021 at 11:06:58PM +0200, Hans de Goede wrote:
>> Hi,
> 
> <snip>
> 
>>
>> Thank you for your work on this. Overall this looks good.
>>
>> I have one remark, since now you are relying on the
>> sta->sleep_q.lock to protect the sleep_q data, you also
>> need to update the sleep_q accesses in rtw_free_stainfo()
>> specifically you need to add a spin_{lock,unlock}_bh(psta->sleep_q.lock)
>> around these lines:
>>
>>
>>         rtw_free_xmitframe_queue(pxmitpriv, &psta->sleep_q);
>>         psta->sleepq_len = 0;
>>
>>
>> Note there also is a:
>>
>>         spin_lock_bh(&pxmitpriv->lock);
>>
>> Just above this which needs to be pushed down to below the
>> block which takes the psta->sleep_q.lock, so that the entire
>> thing ends up looking like this:
>>
>> 	spin_lock_bh(&psta->sleep_q.lock);
>>         rtw_free_xmitframe_queue(pxmitpriv, &psta->sleep_q);
>>         psta->sleepq_len = 0;
>> 	spin_unlock_bh(&psta->sleep_q.lock);
>>
>>         spin_lock_bh(&pxmitpriv->lock);
>>
>> Other then that this patch looks good, thanks.
>>
>> Regards,
>>
>> Hans
>>
> 
> good catch, thanks a lot for review.
> 
> Greg, I see that this one is not in staging-next,
> would you drop it so I can send a new one?
> Or shall I send a Fixes: patch?

Ah I missed that this was already merged. Since this is already merged
the issue which I noticed should be fixed with a separate follow-up
patch (with a Fixes: tag, thanks.

Regards,

Hans

