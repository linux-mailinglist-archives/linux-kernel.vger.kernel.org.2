Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3785447BD6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 09:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238008AbhKHIdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 03:33:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51212 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238010AbhKHIdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 03:33:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636360219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dZ2Q+DY5lRLHrC4/deim612KwtYNG+pVAfJvd8a6ths=;
        b=QQHAk2Lahq6U9v7kueBp9hTOBjfN2IC4xoI08oop29gPgOdA3ck7ySXBJw4mRybZlZUyWc
        5sBIvs1zeTSka2Ers/9wAvZp98MFnHvgO08b9H6gpG3ogw/TWib370OvDFJxeGV394T81K
        9ARVprIj2gbA/iSCILU8cZcBCehXb2Y=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-NFdkTeo_MXak_LjJno3rUQ-1; Mon, 08 Nov 2021 03:30:18 -0500
X-MC-Unique: NFdkTeo_MXak_LjJno3rUQ-1
Received: by mail-ed1-f69.google.com with SMTP id y12-20020a056402270c00b003e28de6e995so14162333edd.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 00:30:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dZ2Q+DY5lRLHrC4/deim612KwtYNG+pVAfJvd8a6ths=;
        b=16XHE9TfemvECN7mnyR/hqMW60xxxYa6f5Uo59Fbl7oyCjiFkVmCwYtNXwiOHpdd3R
         67CxTy4bwCAZNzmbzDOjpl2uiOx6nWvIBZLxFaSjkhohZCHFSFewExwQPyvgySIaQlXc
         8jSMkLUPG4RGvZ1IR+hgtkAVk/xm8jx5XcRvGprn81NMNugK+mQEdnL8c/Ag4G6EMDR2
         a4mKC2pjDER7yjM++8JTmQV00pisbCRMNKEwQSjNPitcZuzDNahKv7USf/3Y2WU4UfHz
         SHp/tAl2nKjXhesz6amZe6OhKU5rI5p/9JZb0xG80T0E3GDdTFO63fTYc9NqQPzd94uJ
         W6Og==
X-Gm-Message-State: AOAM533QkKZAAlkuyYmGCmSac7Z/pSyjMGc76CZIQ9ogP2RmWTz6LAwC
        G4VQFfdL4qmZFuYB5+Aa/ijTx9NlyGvNuGe4ngY1Nyf57ffK05JN36fDfWGpcUJ8eLBf4wAUbDQ
        Mg5HD56YMRWVIpNOK14W7BEcU
X-Received: by 2002:a17:906:11c5:: with SMTP id o5mr91025530eja.42.1636360216945;
        Mon, 08 Nov 2021 00:30:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx55rmukR33/BtWzxQ4veIc0curLmXRJTSzYxLwdm7CCry7Yxjy1ZS8/OpXpMRCM02Ir5v9qQ==
X-Received: by 2002:a17:906:11c5:: with SMTP id o5mr91025508eja.42.1636360216758;
        Mon, 08 Nov 2021 00:30:16 -0800 (PST)
Received: from steredhat (host-87-10-72-39.retail.telecomitalia.it. [87.10.72.39])
        by smtp.gmail.com with ESMTPSA id s26sm9112853edq.6.2021.11.08.00.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 00:30:16 -0800 (PST)
Date:   Mon, 8 Nov 2021 09:30:13 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Cc:     davem@davemloft.net, kuba@kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vsock: prevent unnecessary refcnt inc for
 nonblocking connect
Message-ID: <20211108083013.svl77coopyryngfl@steredhat>
References: <20211107120304.38224-1-eiichi.tsukata@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20211107120304.38224-1-eiichi.tsukata@nutanix.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 07, 2021 at 12:03:04PM +0000, Eiichi Tsukata wrote:
>Currently vosck_connect() increments sock refcount for nonblocking
>socket each time it's called, which can lead to memory leak if
>it's called multiple times because connect timeout function decrements
>sock refcount only once.
>
>Fixes it by making vsock_connect() return -EALREADY immediately when
>sock state is already SS_CONNECTING.
>
>Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
>---
> net/vmw_vsock/af_vsock.c | 2 ++
> 1 file changed, 2 insertions(+)

Make sense to me, thanks for fixing this issue!
I think would be better to add the Fixes ref in the commit message:

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")

With that:
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

