Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B91141B7A8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 21:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242534AbhI1Thd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 15:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242415AbhI1Thc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 15:37:32 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B756C061749
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 12:35:52 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id q6so218041ilm.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 12:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=64evIw52oRekIZbHwSiCOQxkuAatfjf85RCST3duN+k=;
        b=Y+whdzRKhZBi4F0e10aKGWY8V/H37d7/fT7EfJLwEzHf9sW/3ImWPZ9ET2U5Weu4yz
         ZBjRIgLcc3KjeErqmbig8bPdI+Ka8EUE0FIf5dIotawpBRnC5dom3MQafQisZ8LWVawZ
         r1pRp649QhA/oJDCUS6senPdUWmeY4p6YtiBUjiG6faSu5HSv5lEtbfP7y0ezWGarR4D
         pC1C6h2vjPZw+Rer1rFu40SivFJbautH9NtQFhC6bCu4Cmm1NNk6ZDeWvKI3J5H/YtB0
         q0/KXjB+kwRbKGl91HsUrqE0Z03rLt11AcxhXGBqB4TNHeHroEl+vdN1zscWzQQApUAZ
         M1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=64evIw52oRekIZbHwSiCOQxkuAatfjf85RCST3duN+k=;
        b=MWJHIHaSAihY0LXb9PSiYRl0IwwlNewRrOBghef0NzZ+6VkmxRaNZx+6QKzrDHTpc7
         pvpJpxQoTjLkzI5jQ8EAA7tRw/q3Noj4UPEdGvQrMqTheElKpYc+pjQjyRami8Bc5DJ0
         gtKG++azqVDCUVYXRGoQORG4n5l5aMvyUmlKiDbFiKv7P84mMP+/EafBtwD9g6udlFUi
         W81nbl9YOmZuzvHJ8aC/ww9yf0JsH3NNWfkRlZW5VO9cPSiGWxIXt//lM5M5UiKUzqYj
         w6x2FA6xLjQ15RC4L8tOGHoxyaQJl8TIlGBQ2fMLmiP6gkadkMq941F0o5D2KlpYJr4i
         WKDg==
X-Gm-Message-State: AOAM531Gio8nsb+NjsdIFcIf7vmMF8Ae0u869OPCwJGPoeoVA87vRRjj
        0WxtdnBzJini0AbSI23Z4g/G8g==
X-Google-Smtp-Source: ABdhPJzFSVZGvIenvKrDxicIDxRtjRj8KENPEhcmGHIrbBWFLg+wtwG6D65MA29+I55UEiSKkXhAsQ==
X-Received: by 2002:a05:6e02:1d1c:: with SMTP id i28mr5559430ila.33.1632857751863;
        Tue, 28 Sep 2021 12:35:51 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id d6sm11787173ile.51.2021.09.28.12.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 12:35:51 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mVItK-007GOs-GL; Tue, 28 Sep 2021 16:35:50 -0300
Date:   Tue, 28 Sep 2021 16:35:50 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Kirti Wankhede <kwankhede@nvidia.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH mlx5-next 2/7] vfio: Add an API to check migration state
 transition validity
Message-ID: <20210928193550.GR3544071@ziepe.ca>
References: <cover.1632305919.git.leonro@nvidia.com>
 <c87f55d6fec77a22b110d3c9611744e6b28bba46.1632305919.git.leonro@nvidia.com>
 <20210927164648.1e2d49ac.alex.williamson@redhat.com>
 <20210927231239.GE3544071@ziepe.ca>
 <20210928131958.61b3abec.alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928131958.61b3abec.alex.williamson@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 01:19:58PM -0600, Alex Williamson wrote:

> In defining the device state, we tried to steer away from defining it
> in terms of the QEMU migration API, but rather as a set of controls
> that could be used to support that API to leave us some degree of
> independence that QEMU implementation might evolve.

That is certainly a different perspective, it would have been
better to not express this idea as a FSM in that case...

So each state in mlx5vf_pci_set_device_state() should call the correct
combination of (un)freeze, (un)quiesce and so on so each state
reflects a defined operation of the device?

Jason
