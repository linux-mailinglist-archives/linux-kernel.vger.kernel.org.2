Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8727314A74
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 09:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhBIIha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 03:37:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26205 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229853AbhBIIgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 03:36:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612859691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fe4ZuBAI8UR2Grpm24wf3/ZXc6K9G/enuqlpW1OLE/I=;
        b=TcnhKw+ZQ2WM3CR0zjqHChrC/tJ0IYcIzVgttsTNSFh90NsOJ9BNv/MuNOw/xbWBKJ/aEk
        /f14Gm/LkGDydu502i0HlMYi0aaPuqqDj+L7MJRELa4bPins1J71CchYPM/LlAak5qopH4
        p4qJYls+RmQwp8ZX62bd5uqGQI+6YiI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-yHP3zjVZMfuVwAZF47x7bA-1; Tue, 09 Feb 2021 03:34:49 -0500
X-MC-Unique: yHP3zjVZMfuVwAZF47x7bA-1
Received: by mail-ed1-f70.google.com with SMTP id z8so5990160edr.18
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 00:34:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fe4ZuBAI8UR2Grpm24wf3/ZXc6K9G/enuqlpW1OLE/I=;
        b=FuGGNm5Az/pDGTDbJ/x94hY80uFH8IvNKO9nE8Dgaugyhfrl00UhakywZIhwdznB7H
         blstah3dP70z8B5nRrom4EumL1nyJDX2GTf0wjTVOn1yLxB5y/8Zvl76CC4EXa0tPVR5
         Bw3E8lRvbdyYFO4tFg26WwbPMa363A+SH03mObrMhGKih1Za78GF331rZVdm5+uOr/uv
         V8w4NTxZSuzTXrUJs3WF2Kj4ILrrHXMQofksidrRiECsx6C9nS5AB3dEgDuIF/sceXnh
         5Nhu+WLhnCVD5rkp4Aad4K+jB8PYx2W18+Vh1/5DBp5Uj0jZ/6fsg+S6lSM5UOq6iAQ0
         2P7g==
X-Gm-Message-State: AOAM531p7/3U4U6JZRTTDJ39h4PmUnjMrd3rOhIa/uZUhOYFDCn5zTlj
        1TWnYXuijc1rSMxvUTpsZ+FWs1VIiqegZDcElDSa5rn4M4tcj8q0l7CY8tfzTgLgA4bMcwhRZKf
        1bTUBCdLuepilzupDGMEARsSf
X-Received: by 2002:a05:6402:3514:: with SMTP id b20mr21125066edd.100.1612859688148;
        Tue, 09 Feb 2021 00:34:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyCocNc5d8+bB5h5tf5dga0/EVJinBR9/sgmnfDLrauffuqpHPMZ1Ax7y+H18jBiWecZ3qFfw==
X-Received: by 2002:a05:6402:3514:: with SMTP id b20mr21125052edd.100.1612859687959;
        Tue, 09 Feb 2021 00:34:47 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id r11sm11077625edt.58.2021.02.09.00.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 00:34:47 -0800 (PST)
Date:   Tue, 9 Feb 2021 09:34:44 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        Jorgen Hansen <jhansen@vmware.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Andy King <acking@vmware.com>, Wei Liu <wei.liu@kernel.org>,
        Dmitry Torokhov <dtor@vmware.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        George Zhang <georgezhang@vmware.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH net] vsock: fix locking in vsock_shutdown()
Message-ID: <20210209083444.nmi73z2zcunqvche@steredhat>
References: <20210208144307.83628-1-sgarzare@redhat.com>
 <20210208150431.jtgeyyf5qackl62b@steredhat>
 <20210208111200.467241da@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210208111200.467241da@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 11:12:00AM -0800, Jakub Kicinski wrote:
>On Mon, 8 Feb 2021 16:04:31 +0100 Stefano Garzarella wrote:
>> What do you suggest?
>>
>> I did it this way because by modifying only the caller, we would have a
>> nested lock.
>>
>> This way instead we are sure that if we backport this patch, we don't
>> forget to touch hvs_shutdown() as well.
>
>I'm not a socket expert but the approach seems reasonable to me.
>

Thanks, I'll send v2 fixing the warning.

Stefano

