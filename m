Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A6A41929C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 12:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbhI0K5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 06:57:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26676 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233883AbhI0K5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 06:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632740145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2JE0HA2kjVRv/yC9BRKKuYAvNtJ6qvPfXlz+a7vWuQY=;
        b=EbVHnx/DHzDOrYj5zJuPyU8Gb7HeDySG6J+NJKoXWsQbnSpxVgtSsvAs/wnC0ClPzxKY1C
        UjquM9G+bOil/ryduEmTMeTueY9SNQpkzOIx9k4TSYyTSbF/y+j3a6lV/PmuwUQH30TgnU
        h0b8DwUtOQ9qaUKEwmiIwqElzXbaVlw=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527-dte1wCpqMiiHIWOqmAWtzQ-1; Mon, 27 Sep 2021 06:55:43 -0400
X-MC-Unique: dte1wCpqMiiHIWOqmAWtzQ-1
Received: by mail-lf1-f72.google.com with SMTP id c24-20020ac25318000000b003f257832dfdso15340985lfh.20
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 03:55:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:cc:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2JE0HA2kjVRv/yC9BRKKuYAvNtJ6qvPfXlz+a7vWuQY=;
        b=1oNw9KVdDj3pNT07TBThOtv0+iy8rw4JYXvC4PqulNl3RdY1v2KZXGUxepadLCIiyk
         3lb9zbO3yMvVJwCY0xcjGi/2/4fR9j/FxWa6X9vaHQLqfqxLC480vKuUL8q3LA5mFjgf
         9JD9UiSGJqolfJVqesIxuzltYRzGxv+7z1sBC1ELewIBvU6Q+q3jEmza0elaKvrursjT
         x2TAamQ8R4GUAFITEZpDmyMMaA2bJ1svn9XXUv22fxwAzQCXMyAI7qsicQh7bb/M7qxX
         aehfw9qw4W59bBsDyVD4KYj9BeBbXxr3FPGUB1OMKBs8+FPEkZ8wNpZE1fD8mRpNiOQl
         i6YA==
X-Gm-Message-State: AOAM533HYVdhaT3hN0wXWV4l6XeKr98jUujaOKCrvXsxrJDmL9X1bpj5
        3Zi5AfM7M/9n3ESOmy/q1iHt5KlHqQowwZBLOqQT1P40713mHKYFtl5aoE/qtKj8so5LfeyPH8n
        rwYi8PEoXojnAfEAwg6Ws8IAM
X-Received: by 2002:a05:6512:3f86:: with SMTP id x6mr23793064lfa.389.1632740142056;
        Mon, 27 Sep 2021 03:55:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx16ZHxl/Cg5h5Xa3Dn6dXvExbeycQ+N4mXUgoU052iMOkDO/9DkWxj/nPvIZrl4F3RmcU4IQ==
X-Received: by 2002:a05:6512:3f86:: with SMTP id x6mr23793051lfa.389.1632740141894;
        Mon, 27 Sep 2021 03:55:41 -0700 (PDT)
Received: from [192.168.42.238] (87-59-106-155-cable.dk.customer.tdc.net. [87.59.106.155])
        by smtp.gmail.com with ESMTPSA id f7sm1555462lfv.96.2021.09.27.03.55.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 03:55:41 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     brouer@redhat.com, linux-kernel@vger.kernel.org,
        Netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH] Trivial: docs: correct some English grammar and spelling
To:     Kev Jackson <foamdino@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
References: <YVF/Q5pA9h9S+wS9@kev-VirtualBox>
Message-ID: <71dea92b-e22b-9791-5755-df3a4f48f893@redhat.com>
Date:   Mon, 27 Sep 2021 12:55:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YVF/Q5pA9h9S+wS9@kev-VirtualBox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kev,

You should send this patch to the mailing list netdev@vger.kernel.org or 
bpf@vger.kernel.org ... else I don't think it will be picked up.

On 27/09/2021 10.22, Kev Jackson wrote:
> Header DOC on include/net/xdp.h contained a few English
>   grammer and spelling errors.
> 
> Signed-off-by: Kev Jackson<foamdino@gmail.com>
> ---
>   include/net/xdp.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

--Jesper

