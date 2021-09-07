Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A22402424
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 09:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhIGHXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 03:23:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56835 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237285AbhIGHWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 03:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630999302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oaKB7upFfFLl+Pp6dLBHJb3Ed1n4Piy1w3dtvzMllDk=;
        b=TLp6Rvbx10wmYks3IvIg9a9wvXFXgEV9GIqUFWNsdu2uBAR2Wun6JVQwtg4MCFLt3CFOkC
        g9sWjiLbPavqH+Bl70TrO+WZ9Cm+2lzdEd0lW0S0BraeGV0aj3V5ffqIzC1vNOb4ugJhDE
        rlfJVuyAiTbN2Quj+1j7HSjcwQUlmbs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-doB03kvbM3Wp9rhs8lol-A-1; Tue, 07 Sep 2021 03:21:37 -0400
X-MC-Unique: doB03kvbM3Wp9rhs8lol-A-1
Received: by mail-ed1-f71.google.com with SMTP id b15-20020a05640202cf00b003cd5efcd633so4797007edx.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 00:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oaKB7upFfFLl+Pp6dLBHJb3Ed1n4Piy1w3dtvzMllDk=;
        b=crtG60ypDhAdAoMCJ07AMEFWnFpOWgh064NcZwsdNNBOj7qaQxTxiwyEAXchq+/iBB
         Euea1MNrnMnpvTHFXpIwu7ew/+8zqWbA84K92IPzcfv1NSURalUIDLBmAT8KsRdRTWWo
         HBuy/jAxuVu2Qtf/hamQMeapCIaKcw7SGPSY151Mw2ZtEgq+w/ODuGHYHL4onFgtfbY9
         XVxX8kyKoS98xG7byme2NUXox35mEJIKZWn7c9FbWBNQ3i9iZ/5y9PeRjtP6/hEx2eIL
         G7dmfXr5TF46TgibS38izZ9LXmGguMHUJbib2NWLH7sYKRy2sbG9R5F9LQu5sLfKIfT3
         2UDg==
X-Gm-Message-State: AOAM533wMdtsZs+n8JXu3EExUnsvkpl1dolmra3C9E/XjzHSU5iZpSic
        ZKE7wVqizpjtUiJmmVTlmYoLx6eV6H5oB/6Jce4X3+SNKNfmAICrekZufAK8/kIeT1VzMVw/bCC
        oOdpwZgE3OPUjx10vm6/BP+Pa
X-Received: by 2002:aa7:cd92:: with SMTP id x18mr16824599edv.325.1630999295980;
        Tue, 07 Sep 2021 00:21:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6Uc8T7kEgxWO5FQfq7yWolBxu7KgEZ38BIbUnYz9ZEWtsIPRwsqwwuW4waLHl5HXsZmNjuQ==
X-Received: by 2002:aa7:cd92:: with SMTP id x18mr16824591edv.325.1630999295860;
        Tue, 07 Sep 2021 00:21:35 -0700 (PDT)
Received: from steredhat (host-79-51-2-59.retail.telecomitalia.it. [79.51.2.59])
        by smtp.gmail.com with ESMTPSA id ee18sm5872580edb.62.2021.09.07.00.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 00:21:35 -0700 (PDT)
Date:   Tue, 7 Sep 2021 09:21:33 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jorgen Hansen <jhansen@vmware.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: add VM SOCKETS (AF_VSOCK) entry
Message-ID: <20210907072133.mzyqugkob3yqm2ek@steredhat>
References: <20210906091159.66181-1-sgarzare@redhat.com>
 <BYAPR21MB1270B80C872030CA534C667EBFD29@BYAPR21MB1270.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <BYAPR21MB1270B80C872030CA534C667EBFD29@BYAPR21MB1270.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 06, 2021 at 07:10:46PM +0000, Dexuan Cui wrote:
>> From: Stefano Garzarella <sgarzare@redhat.com>
>> Sent: Monday, September 6, 2021 2:12 AM
>>
>> Add a new entry for VM Sockets (AF_VSOCK) that covers vsock core,
>> tests, and headers. Move some general vsock stuff from virtio-vsock
>> entry into this new more general vsock entry.
>>
>> I've been reviewing and contributing for the last few years,
>> so I'm available to help maintain this code.
>>
>> Cc: Dexuan Cui <decui@microsoft.com>
>> Cc: Jorgen Hansen <jhansen@vmware.com>
>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>
>> Dexuan, Jorgen, Stefan, would you like to co-maintain or
>> be added as a reviewer?
>>
>> Thanks,
>> Stefano
>
>Please skip me (I still review the hv_sock related patches).

Yep, thanks for the help with hv_vsock!

Stefano

