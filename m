Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED2434F103
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 20:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbhC3Say (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 14:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbhC3Sa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 14:30:29 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EAAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 11:30:26 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id o16so17232178wrn.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 11:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7D0t7kKBUtNyEw7wPH5xr4MnNv8franh5ra+G0ifn8Y=;
        b=uymBmqVAuvj4Qc1pqUaBasAJTL6wtWdKO7YDd5Vdtxejwo3R2vYJm6UfnOa8nFH4i4
         5DXWRcIlnVOrJzetYhD+JDtaUddFcqG4W6JZjtvlE7HI2PtF5jd2VBsJ3rgeTTV0IuQ2
         xC0rSyUvcvyWrF9JgGMS7X5RtTxa14rLqdtsWMBBOzBjQ12uj5ouHGfBqXmrL80pHGee
         Ap16LpJUCg+7ZpjMspkLz4yV2MgGyPV+Mg3pTierWpphCd6u/Jb5vpuQc5OqzhETpLQO
         xe5Il9aWV/HIPV4rCVmPZhMUB+JXnjnFqhd0GOPhYMTy+h0UF2Jw/XsH4Xmwy4imncUw
         vPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7D0t7kKBUtNyEw7wPH5xr4MnNv8franh5ra+G0ifn8Y=;
        b=Sy56p8+q75pjjGngvHj1g+IGKHZMHNK2zvu9kaUXgLEz5hNIJ/ZkYPfiAYGpZG6LRh
         xXmP/LvC8Y4njABG8F2jCtdFJfkR2WTxtcGUQgRTelYNO9brwlRDbFWrORzz7/9NRjaf
         QeKDUpjcdRwtuVibisrmNDeLEhz4symdMCZ95+oBcMUV5cTaH0GNvsvu0pz5M9hPS1gF
         d/1ECtc54W7HPK9DystI+lkM080NyI6Ma9QEZSihkJq684NRns077rWGgK3H8UdZ4HAv
         zm4KPAqGKdikTHXlzQ3jdpRYZVZN5ohm5VPCSqh6NXusXJ3WDBWydCiTg/35kEW/Hl4t
         iXXA==
X-Gm-Message-State: AOAM530DRlDVhPrS8WUtMYH7gL4AXEUHpXqRFQGFcjZM5l5NaPMjE31L
        xiZRVXqU1DImz3wZgrMdlK7/+c0C/74eSxEV
X-Google-Smtp-Source: ABdhPJymomQExG2eLXNKLB31LudJ7J4baachDCHVBba/qfYV3t5+/wnKwIiXS2YwehuQQUdsJEL7NQ==
X-Received: by 2002:a5d:5904:: with SMTP id v4mr35634271wrd.261.1617129025361;
        Tue, 30 Mar 2021 11:30:25 -0700 (PDT)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
        by smtp.gmail.com with ESMTPSA id a15sm26149964wrr.53.2021.03.30.11.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 11:30:24 -0700 (PDT)
Date:   Tue, 30 Mar 2021 20:30:22 +0200
From:   "javier@javigon.com" <javier@javigon.com>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "minwoo.im.dev@gmail.com" <minwoo.im.dev@gmail.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] nvme: allow NVME_IOCTL_IO_CMD on controller char dev
 even when multiple ns
Message-ID: <20210330183022.arjiqiufiuqkrvwc@mpHalley.local>
References: <20210326205943.431185-1-Niklas.Cassel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20210326205943.431185-1-Niklas.Cassel@wdc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.03.2021 20:59, Niklas Cassel wrote:
>From: Niklas Cassel <niklas.cassel@wdc.com>
>
>Currently when doing NVME_IOCTL_IO_CMD on the controller character device,
>the command is rejected if there is more than one namespace in the
>ctrl->namespaces list.
>
>There is not really any reason for this restriction.
>Instead, check the nsid value specified in the passthru command, and try
>to find the matching namespace in ctrl->namespaces list.
>If found, call nvme_user_cmd() on the namespace.
>If not found, reject the command.
>
>While at it, remove the warning that says that NVME_IOCTL_IO_CMD is
>deprecated on the controller character device.
>There is no comment saying why it is deprecated.
>It might be very unsafe to send a passthru command, but if that is
>the issue with this IOCTL, then we should add a warning about that
>instead.
>
>Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>

I think the idea is OK, but I have 3 questions:

   1. Wouldn't this break user-space when nsid is not specified?
   2. What is the use case for this? As I understand it, this char device
   is primarily for admin commands sent to the controller. Do you see a
   use case for sending commands to the namespace using the controller
   char device?
   3. Following up on the above, if the use-case is I/O, don't you think
   it is cleaner to use the ongoing per-namespace char device effort? We
   would very much like to get your input there and eventually send a
   series together. When this is merged, we could wire that logic to the
   controller char device if there is an use-case for it.

Javier
