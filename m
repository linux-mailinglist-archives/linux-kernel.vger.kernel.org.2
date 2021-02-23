Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E000F322E13
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 16:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbhBWPz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 10:55:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59215 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233479AbhBWPzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 10:55:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614095625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TgJGcqcFSPJ5vSkmpHDztihIciEdSayUVtjWq3dkQvU=;
        b=dvdzSx+lwszcAsSjSKhKkDq/zzhQbIkTLFnnD6gdQwWLadgHsW7l0haNa7o33AIBtV1msS
        0+zkqhzxiQ7urlsYtjwBw+NUfrX1CSZzvjQgMkM04BJZh1ofvMtpk6BWvWa5qKSlhI6y3f
        xJRjj9wq5h/yi4fS+kXNF7k1GzYq+T8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-jr3OrprTM7e1d1u5tw1ppw-1; Tue, 23 Feb 2021 10:53:07 -0500
X-MC-Unique: jr3OrprTM7e1d1u5tw1ppw-1
Received: by mail-wr1-f70.google.com with SMTP id g5so3263862wrd.22
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 07:53:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=TgJGcqcFSPJ5vSkmpHDztihIciEdSayUVtjWq3dkQvU=;
        b=p+wzVmBPU0vkdSYnl1FWsWenXsJ4JmcqCQuY9QSA4yPuh5HTkDcx5htNvQQeKqOqkr
         rTihAX3mhWf2FDLlVeWEZPa+PAxDMCpeaAsvxf7pMYWXioaNNADBXxGL0Oijb7UJIhnv
         Ep+MxcUZflntrigpIbiv9fGcVIMHOsvhBL3oug2Ysd/WAZmcEZU/VGFxh37FOxKlXWe5
         q4Vsw2q3XCPfhpVDEQpIz0fCJokAjcF4uYR/b4GrImBIzOTFj/RDkoqsBjOTCd2UV5mG
         kUcflMhvOP9oODoZqyKbypEH3wyslloS6XqzM7Y1UrmD9zb0Eauo3hqx2vRKq647QFpx
         qwCA==
X-Gm-Message-State: AOAM531hHy1s6rHyOcLLR/NwG0Wq6wi+ADnXXtzH/eoSrhN4WYI3Y+M9
        tKxTiv2TA5xSTdx7r0ErYKEafjcUPJ5TbaTf83EVwEXdb4XUykEtEzNXAhcI2a76G5ne3psfiqo
        BQd2ZFM9ewVxjg5N+uGLwsMWD
X-Received: by 2002:a1c:4603:: with SMTP id t3mr26096856wma.135.1614095586688;
        Tue, 23 Feb 2021 07:53:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJydM5phjkLB5zeQ0CabZfvHx0EcHMjVL6rvsg+VYExkMFngHWiwDIFnl51krSfVPzO/nS3Cgw==
X-Received: by 2002:a1c:4603:: with SMTP id t3mr26096842wma.135.1614095586566;
        Tue, 23 Feb 2021 07:53:06 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
        by smtp.gmail.com with ESMTPSA id g18sm3217030wmh.17.2021.02.23.07.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 07:53:05 -0800 (PST)
Date:   Tue, 23 Feb 2021 10:53:01 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        open list <linux-kernel@vger.kernel.org>, shahafs@mellanox.com,
        sgarzare@redhat.com, Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH V4 1/3] virtio: don't prompt CONFIG_VIRTIO_PCI_MODERN
Message-ID: <20210223105232-mutt-send-email-mst@kernel.org>
References: <20210223061905.422659-1-jasowang@redhat.com>
 <20210223061905.422659-2-jasowang@redhat.com>
 <533886b3-9979-7a51-5b44-eeefad242cdf@roeck-us.net>
 <CAEUSe7-g=O_=G1fzjLwjQH1taj0YZYKt=874mUxcM-qGv51+9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEUSe7-g=O_=G1fzjLwjQH1taj0YZYKt=874mUxcM-qGv51+9g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 09:50:35AM -0600, Daniel Díaz wrote:
> Hello!
> 
> If I may add to the nit-picking...
> 
> On Tue, 23 Feb 2021 at 09:23, Guenter Roeck <linux@roeck-us.net> wrote:
> > On 2/22/21 10:19 PM, Jason Wang wrote:
> > > We used to prompt CONFIG_VIRTIO_PCI_MODERN to user which may bring a
> > > lot of confusion. E.g it may break various default configs which want
> > > virtio devices.
> > >
> > > So this patch fixes this by hiding the prompot and documenting the
> 
> *prompt
> 
> Greetings!
> 
> Daniel Díaz
> daniel.diaz@linaro.org

I have just folded this patch into the one it's fixing,
so the commit log doesn't matter. Thanks everyone!

-- 
MST

