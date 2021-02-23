Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC15B3226EB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 09:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbhBWIKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 03:10:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45306 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232190AbhBWII5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 03:08:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614067651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QJQaZPz8BU5jNxqGBbzYmwqQYEQoV6UYoqOet8cn2TE=;
        b=cvViqWf7niinqURt6B8EqjmluOQvEAGs622tq+ovfnB5rO/8KX+ozIh/jtJXkPI4GOUR0S
        V24Aghaw5BA6+Cy9Ge3B6lpKXVwMcyMDz4dwvT4TMjJ0fyHpdUwKCO9aqzz68jFgsCeQze
        gPwYgctm+U2bsA9/i7qC7C6aWDf9bXk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-JqqCyiTPNyCRz58xa_dN8A-1; Tue, 23 Feb 2021 03:06:59 -0500
X-MC-Unique: JqqCyiTPNyCRz58xa_dN8A-1
Received: by mail-wr1-f69.google.com with SMTP id j12so1428008wrt.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 00:06:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QJQaZPz8BU5jNxqGBbzYmwqQYEQoV6UYoqOet8cn2TE=;
        b=t+5OuuSnl2NFNkShM1qo2YfMosJlMDaTpYDaSVLh8AAnUGoDf8RHQHd+33UEAzEy+P
         llyjkTHamQQokgLH/w39kcxTdPPqZSitFR5yZN8JGoUKJVShgFm59hoRpKs/cYFovK06
         35QbjtXXaGDQg1Hb9WygrHbWZTBdOdAC17fbr4GxC3zmv3WTiVx+epmy8EXZ0ZB+vXVM
         OxpnT6Fo6kd9FQ8IlEdhiCo+N1fDWQPuyp8jKorrBhfy9mmHhG+Ij0pzFIAiG46mhDCs
         4qY+uyTqNlHMVsQbbzZwo2cj2IhNMq5ONMi8fiE11oNjhNTznaumKsn+fpxeuk30FwL3
         ykdA==
X-Gm-Message-State: AOAM533U93oxat5PUx+usuNRmOOJyr9ftpsDzZbv4oBc5wUV609fFn4D
        pT1tZyz1ImB5PjRfX89cGmvIpsQFu+DRhzPtlWvLiCOOHZ/x4iH8HOpeTaClfjLXNPOFEHq1HX5
        mWzOo+hV2SgI5+EnULmlJjs1B
X-Received: by 2002:a05:6000:2aa:: with SMTP id l10mr25427489wry.368.1614067618437;
        Tue, 23 Feb 2021 00:06:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxMIH1kwz2CQY7I9V1/kNJmJOFjB038suRPfBB8YuLFHXVn1XserOYC9TniXTjzHgbqy7vqMQ==
X-Received: by 2002:a05:6000:2aa:: with SMTP id l10mr25427472wry.368.1614067618257;
        Tue, 23 Feb 2021 00:06:58 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id v188sm302614wme.1.2021.02.23.00.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 00:06:57 -0800 (PST)
Date:   Tue, 23 Feb 2021 09:06:55 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 5.10 03/29] vdpa_sim: store parsed MAC address in a buffer
Message-ID: <20210223080655.ps7ujvgvs6wtlszf@steredhat>
References: <20210222121019.444399883@linuxfoundation.org>
 <20210222121020.153222666@linuxfoundation.org>
 <20210222195414.GA24405@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210222195414.GA24405@amd>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 08:54:15PM +0100, Pavel Machek wrote:
>Hi!
>
>> From: Stefano Garzarella <sgarzare@redhat.com>
>>
>> commit cf1a3b35382c10ce315c32bd2b3d7789897fbe13 upstream.
>>
>> As preparation for the next patches, we store the MAC address,
>> parsed during the vdpasim_create(), in a buffer that will be used
>> to fill 'config' together with other configurations.
>
>I'm not sure why this series is in stable. It is not documented to fix
>anything bad.
>
>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> @@ -42,6 +42,8 @@ static char *macaddr;
>>  module_param(macaddr, charp, 0);
>>  MODULE_PARM_DESC(macaddr, "Ethernet MAC address");
>>
>> +u8 macaddr_buf[ETH_ALEN];
>> +
>
>Should this be static?

Yes, there is already a patch [1] queued by Michael but not yet 
upstream. When it will be merged upstream I will make sure it will be 
backported.

Thanks,
Stefano

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/commit/?h=linux-next&id=8c0bea4adac9f1f9ac827210fa8862be4bde6290

