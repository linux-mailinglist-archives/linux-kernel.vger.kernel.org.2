Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 525A435E028
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 15:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240576AbhDMNfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 09:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237619AbhDMNff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 09:35:35 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A95C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 06:35:14 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id d15so4818843qkc.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 06:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Zfbw9gRsTtELynvxyNAEvq2nBbfpo0wqll31vRo4UIY=;
        b=b0oYKHlwg3DVnNlrX19vgF08ocSUeXKRplR4zI9kNg/+QFmHOkEaQ45C+Bka4BGtRU
         nS6j+oD0IZR2wNBP5Kl7ZbNf5ysHGe2Om74gIlnFlifoW+qNgf4GirF1CX0gdKirRE15
         F07N2G043zt6/RHcPv1YPdrDadvJyv6gZwTA71WTCbNfZwRxTP8TjGIcyFSlrhux2d8w
         q08ekYVYdLjq0TZkpUpZksRMyFWmwNI7GKQ0P6tgb0RCx0ZGkB0kBniSZOd1Yu3udTjW
         Je5SAn0sjRPf+DWtZ5BPChvwVUo0SQWOVNdOlzDTIG458DJhG8wqQ+nm85VmTR3Lwwna
         793Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zfbw9gRsTtELynvxyNAEvq2nBbfpo0wqll31vRo4UIY=;
        b=DkKTSJa2pBQlHDctAW7pY6oMMPXnj0PFkiLgOOvA9ifV17i3ds4hRH/d62yJmU6z2d
         0vtRGI2fJCYvfOzDd81T5kx42S20r6sRucgcST9oqvfoz3+IoEePd8OCIfDRDRA6dYeb
         KkhOXjVQKXOOyjmkOddPDJld8JteZVdz24HQIbz2b0mQ/hSkaRcGjE6aSnMVHnZQ+yj2
         vyBhfIQ5bcpStnDBXpJFxjsh/YxD278CPw3ibaBneJatJJ3gW9FnEZe5Ii20qvCjoNv4
         gEgcjkU9koSP4JDA6n0f3pKHrnMGRCfPq0Fvp1KZHZFDqje+193sDvWotB92JERvC+Ve
         YhAA==
X-Gm-Message-State: AOAM532LqHfpUpEEhyxKzSBOHUsXUczeVS9LjIXY3kjI/aajv7Wat3iN
        HiotlmGgiV2etHBPCJJFkcTn0Q==
X-Google-Smtp-Source: ABdhPJzDi2mBhgIzlclzCM/9ug0hJZy9iB8qu8lhsne5b1NzQuskLTgGU2S9RKNz3qvq4jdQwxWauw==
X-Received: by 2002:a05:620a:1650:: with SMTP id c16mr32116871qko.477.1618320913824;
        Tue, 13 Apr 2021 06:35:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id 14sm10064746qkf.119.2021.04.13.06.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 06:35:12 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lWJCC-005HJi-1A; Tue, 13 Apr 2021 10:35:12 -0300
Date:   Tue, 13 Apr 2021 10:35:12 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Steve Wise <swise@opengridcomputing.com>,
        Leon Romanovsky <leon@kernel.org>,
        Potnuri Bharat Teja <bharat@chelsio.com>
Subject: Re: [PATCH] nvme: Drop WQ_MEM_RECLAIM flag from core workqueues
Message-ID: <20210413133512.GH227011@ziepe.ca>
References: <20210412122330.5166-1-dwagner@suse.de>
 <20210412123149.GE227011@ziepe.ca>
 <20210412124909.olui5hfhceakt4u4@beryllium.lan>
 <20210412130402.GF227011@ziepe.ca>
 <20210413085404.tzam5lprtspwcek4@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413085404.tzam5lprtspwcek4@beryllium.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 10:54:04AM +0200, Daniel Wagner wrote:

> Hmm, I am struggling with your last statement. If a worker does an
> allocation it might block. I understand this is something which a worker
> in a WQ_MEM_RECLAIM context is not allowed to do.
> 
> My aim is still to get rid of the warning triggered by the rdma
> code.

The WQ_MEM_RECLAIM is placed on a workqueue not because of what is
*inside* the work, but because of what is *waiting* on the work.

Jason
