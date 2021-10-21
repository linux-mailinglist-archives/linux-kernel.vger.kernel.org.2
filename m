Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60EA743631F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 15:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhJUNgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 09:36:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41514 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231401AbhJUNgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 09:36:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634823270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hHZMSTz6eML2+E9JkvtukKVjxlVK42u/5TgPQ/XIGcw=;
        b=DVPpOMH5jF8Lv6fP1HvcIAwRSDklGNnzr9JFT/iC9VDg71dhGyZraWI8f4oH8LiYJFDht/
        cLv+gslrOW6Lm1Q+LYp69yhhcT+fzDxehNoJyhXPGkTedvAJMRTdxrxdCiFaXNFCCYLxUR
        pgB35y22e8enI4ls2SJtuSeAnKXBPsc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-od_DwWLHPS6lhMy7LcESnw-1; Thu, 21 Oct 2021 09:34:28 -0400
X-MC-Unique: od_DwWLHPS6lhMy7LcESnw-1
Received: by mail-ed1-f71.google.com with SMTP id v2-20020a50f082000000b003db24e28d59so366216edl.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 06:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hHZMSTz6eML2+E9JkvtukKVjxlVK42u/5TgPQ/XIGcw=;
        b=MU42u/nkWGfH86q1+ub7uecow8GIHNFBdeSNjGwwGZqCkvkH0R8F7GZkz+c5l1pTZM
         HiId4DYMgHpYG1NUQTZyq/W0DPLBxjhcBteobhyk5nmFBA7W/ysz9mtN+o01sVtNybcC
         cqU5BvScs62J1w8pl5hBDvBrHVSHZCjcYpfFEAe+zwEiOrPcVVghHkbzU3OoAQ3BK1FT
         ov7A32MdOmA1izHBrq4dvtip3fTxxkpm6DAiKHzWObdVfr/9WfOQlF4eXYWWGTB6z7xF
         1+HsHJaYtD+BmVZqLoI05Q0wVMqMpE0B4Hskv8ZpD5m6YRreHD0PTHrP4ROsTX4bh5H5
         cLQA==
X-Gm-Message-State: AOAM5335VxedTV/v1EiNDCN/V0EDjx0LTzIOxSTCCnaVGJZYHoY8UmKT
        kTBjG8SGoCRwXyKlVh2ciNs2He6g9NraRLQVKVnfRLUJdc6mzj0/mFlcjwkktHwcw88MarTQ/Sw
        3iIGtElzEE84HOG2xb/2QBn1x
X-Received: by 2002:a05:6402:2553:: with SMTP id l19mr7669602edb.321.1634823267545;
        Thu, 21 Oct 2021 06:34:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzr8iBU2vHeRmTajZRd4sREXPn+BDTVd+wjRgZC9wmWlyyBUc6qHTTx5nfcjBc2uQ2zIiV2uw==
X-Received: by 2002:a05:6402:2553:: with SMTP id l19mr7669581edb.321.1634823267359;
        Thu, 21 Oct 2021 06:34:27 -0700 (PDT)
Received: from steredhat (host-79-30-88-77.retail.telecomitalia.it. [79.30.88.77])
        by smtp.gmail.com with ESMTPSA id f12sm2518135ejl.5.2021.10.21.06.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 06:34:27 -0700 (PDT)
Date:   Thu, 21 Oct 2021 15:34:25 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, kuba@kernel.org
Subject: Re: [PATCH 00/10] RFC: SO_PEERCRED for AF_VSOCK
Message-ID: <20211021133425.tfgntfq6tq6em6up@steredhat>
References: <20211021123714.1125384-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211021123714.1125384-1-marcandre.lureau@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 21, 2021 at 04:37:04PM +0400, Marc-André Lureau wrote:
>Hi,
>
>This RFC aims to implement some support for SO_PEERCRED with AF_VSOCK,
>so vsock servers & clients can lookup the basic peer credentials.
>(further support for SO_PEERSEC could also be useful)

Thanks for this RFC! Just had a quick look, Monday I hope to give you 
better feedback :-)

>
>This is pretty straightforward for loopback transport, where both ends
>are on the same host.
>
>For vhost transport, the host will set the peer credentials associated with
>the process who called VHOST_SET_OWNER (ex QEMU).
>
>For virtio transport, the credentials are cleared upon connect, as
>providing foreign credentials wouldn't make much sense.
>
>I haven't looked at other transports. What do you think of this 
>approach?

So IIUC, SO_PEERCRED will make sense only in the host and will return 
the credentials of the VMM (e.g. QEMU) that manages the VM of the peer 
to which we are connected.

So the features should be supported by the following type of transports:
- VSOCK_TRANSPORT_F_LOCAL (vsock_loopback)
- VSOCK_TRANSPORT_F_H2G (vhost-vsock, vmci)

>
>Note: I think it would be a better to set the peer credentials when we
>actually can provide them, rather than at creation time, but I haven't
>found a way yet. Help welcome!

Yep, I agree, cleaning credentials after connecting in the guest seems a 
bit strange.
As you also said, would be better to set them only after a successful 
connect(), which should be similar to what AF_UNIX does.

Maybe we can add an helper in af_vsock.c that will be called from the 
transports that support this feature at the end the connection setup.

I'll think better of it and get back to you.

Thanks,
Stefano

