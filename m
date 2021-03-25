Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F1B3493BB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 15:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhCYOJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 10:09:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33973 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231395AbhCYOJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 10:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616681373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iaDke1NgQpj10lzGIPu+G9iEQAtRNGG6aKLxoB2aQKQ=;
        b=Z7/E6IGJnGgqaPKBx1/UgELB2GmUeq4tfCCF9h/Ea/O9AIXyVYeHb0irKFQ7jFn5f93y5K
        1xMY+Z5V/bCkCsbKzX1UlA9kGPB350c2AP6Vqbn+3IPPuf/DyPjaj/ZoKJ9s2jvyNqOOza
        hvnBv85DhVt/yXHeXlzMAlp2YtA6+Ig=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-zdAVWK5VPESRmX3nIfpWRQ-1; Thu, 25 Mar 2021 10:09:32 -0400
X-MC-Unique: zdAVWK5VPESRmX3nIfpWRQ-1
Received: by mail-wr1-f71.google.com with SMTP id o11so2699877wrc.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 07:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iaDke1NgQpj10lzGIPu+G9iEQAtRNGG6aKLxoB2aQKQ=;
        b=BHnq9C2i3QSixh12eyIEwqedULTug0qZe4PEdpKdq7eDrro6pJHuLT9rddfeFu4+c6
         7W1rKobfaG5lmX13+uHIJd6qV5e8SwWkDDY3/Kybmy8I2TSbO6oCEWpifF4aLbBhmUYH
         TF2y934Z186k82UQ+zhwLhXJy5lL+ssGOORsTDIQl/lrMflsYpdZuJ3fEnjjiF4icQ9a
         ULc0fI+egsPXWBxlOSCT7Hemg+QCL32UJ2RCUg4aScpZOcX2wEBPMWGxwNt+NleNCJuQ
         GQt7bgyxgpOrfNR8/NA8g9r06bEVo7SeYOY3eXfD+hHroGBcA7BoRkJYeSfRgCol5iSi
         qcBA==
X-Gm-Message-State: AOAM5329nEbdmvrAt20mzvR9Cje0QmBvt5OB1GD+lbaNw19gncwbVYNQ
        GDYLDz7RzYgnL39OGXeWyOOII5zudl8St3k1f68/T/lb5/aNbB3WOjhObuqoK7DXF6hOhCcvkdB
        boSEGNWpp2EbYTWV5uKKPVky+
X-Received: by 2002:a05:600c:290a:: with SMTP id i10mr8272479wmd.91.1616681370908;
        Thu, 25 Mar 2021 07:09:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMy3i2A1hdSFW1ZkN1C1u1NvHTtrAalRIM+aRukLMYU90MuvjYASV0lEQmFAfYwRtdc9GnNg==
X-Received: by 2002:a05:600c:290a:: with SMTP id i10mr8272448wmd.91.1616681370673;
        Thu, 25 Mar 2021 07:09:30 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id y1sm6355140wmq.29.2021.03.25.07.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 07:09:30 -0700 (PDT)
Date:   Thu, 25 Mar 2021 15:09:28 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Are CAP_SYS_ADMIN and CAP_SYS_NICE still needed for SQPOLL?
Message-ID: <20210325140928.fuu2iap54ysevssz@steredhat>
References: <20210325113322.ecnji3xejozqdpwt@steredhat>
 <842e6993-8cde-bc00-4de1-7b8689a397a8@gmail.com>
 <46016d10-7b87-c0f6-ed0f-18f89a2572d0@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <46016d10-7b87-c0f6-ed0f-18f89a2572d0@kernel.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 08:02:45AM -0600, Jens Axboe wrote:
>On 3/25/21 7:44 AM, Pavel Begunkov wrote:
>> On 25/03/2021 11:33, Stefano Garzarella wrote:
>>> Hi Jens, Hi Pavel,
>>> I was taking a look at the new SQPOLL handling with io_thread instead of kthread. Great job! Really nice feature that maybe can be reused also in other scenarios (e.g. vhost).
>>>
>>> Regarding SQPOLL, IIUC these new threads are much closer to user threads, so is there still a need to require CAP_SYS_ADMIN and CAP_SYS_NICE to enable SQPOLL?
>>
>> Hmm, good question. If there are under same cgroup (should be in
>> theory), and if we add more scheduling points (i.e. need_resched()), and
>> don't see a reason why not. Jens?
>>
>> Better not right away though. IMHO it's safer to let the change settle
>> down for some time.
>
>Yes, agree on both counts - we are not going to need elevated privileges
>going forward, but I'd also rather defer making that change until 5.13
>so we have a bit more time on the current (new) base first.

Yeah, that makes sense to me!

Thank you both for the quick clarification,
Stefano

