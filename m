Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32953490E1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 12:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbhCYLko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 07:40:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31040 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231180AbhCYLd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 07:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616672008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=WzowP+sLkDfedW5lZC+DZjAa2iepM0HqhQ8ixqDL3Ws=;
        b=NHpsNXcXwwkkDMC88GAr7Rb1LmpCS2dwscpNkqiCPix4kuRaCLFk+bFRWzom5NH83d+4U3
        Kr3OHUWKjfGaWFYZqfwVpwfMLwSRwWMur/DTLH+ToFa7hE4MEL/itEzL0ddWpfhcI7wNhU
        01MfI/nBqEmyGQ3EBw4OAY86TB9ZSEM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-5XYFYg32Nsm0ar7qpmX5pw-1; Thu, 25 Mar 2021 07:33:26 -0400
X-MC-Unique: 5XYFYg32Nsm0ar7qpmX5pw-1
Received: by mail-wm1-f72.google.com with SMTP id j8so1137864wmq.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 04:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=WzowP+sLkDfedW5lZC+DZjAa2iepM0HqhQ8ixqDL3Ws=;
        b=QcRwLxlQ0kHaaEozVnmV8OoiROtSK+SOSW+N9sHYoaQ1dW6hnDisMrBmVthJe0uB5l
         0uEr0z9au+70CoxJzons3dBod4GjswU8tkWu9QxdgcsmOwgpbPBZNT97Kn4bh7s4v49i
         XFOn00ZJYMELYHLsTAmZzZ510R+IpvT3ZGenoVjFYobvLKSgPRwzn2xYIKUQgadmh4pP
         hkEjY4MIgERGVJ1tyW/E8ZMWPA3fsHMyPfTsImnUFyP6QJxjHPq839Gl5F03KnPvBzU3
         jgSuSR7xh3YGjiZhj8VSxaz8clRwGRYx4lKAqcK/clLfHaI2GWsHFeYS2lYt3lMyy+Yh
         irnA==
X-Gm-Message-State: AOAM532cCI4+MmZPE5aSzf9c+qBoIx2SG56az9DFKoM8qEhqhhb+OMm1
        ayJs799zBFHcWdZxz97p7x/JlYBndVDwVflPY1vcOjdiXn+NMiEXTSHcWPmGwtKz+icLR9HTBio
        WLWte92S8/sTU8Ms48k/Agbk6
X-Received: by 2002:a05:600c:4f89:: with SMTP id n9mr7614717wmq.133.1616672005209;
        Thu, 25 Mar 2021 04:33:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeb+RXeOXpc4pbgT9ly41sA9xcWuuvPd6YRWfU5Ap/hhUSDfGV3R125XtSc3HB9Ye+rOnpVQ==
X-Received: by 2002:a05:600c:4f89:: with SMTP id n9mr7614700wmq.133.1616672005034;
        Thu, 25 Mar 2021 04:33:25 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id 1sm11022599wmj.0.2021.03.25.04.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 04:33:24 -0700 (PDT)
Date:   Thu, 25 Mar 2021 12:33:22 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Are CAP_SYS_ADMIN and CAP_SYS_NICE still needed for SQPOLL?
Message-ID: <20210325113322.ecnji3xejozqdpwt@steredhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens, Hi Pavel,
I was taking a look at the new SQPOLL handling with io_thread instead of 
kthread. Great job! Really nice feature that maybe can be reused also in 
other scenarios (e.g. vhost).

Regarding SQPOLL, IIUC these new threads are much closer to user 
threads, so is there still a need to require CAP_SYS_ADMIN and 
CAP_SYS_NICE to enable SQPOLL?

Thanks,
Stefano

