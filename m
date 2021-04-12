Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD65635C645
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 14:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240737AbhDLMcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 08:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238780AbhDLMcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 08:32:09 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315E7C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 05:31:51 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id i9so13025399qka.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 05:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yhl8pbOdaalAMsJe7hpEsxkpuZCX76ZLSoNM9EjUzXg=;
        b=ZeE8zb6t0XIFVZLLoUGRpWjAop1DK+ouuw91eGaUzcyLjqA9UncZmpBEhi5dwGWnRR
         ny8yXVOpcMQqK7RzvTNtQkPmkSxN+C4KRja+6nQioGBMTpazgxga8abAHpp+0qjm+/D0
         o9CUweHOcoFl1q1kzxxfr+ja5byOhx8AS/h4ppM05JPMxyuEPANFfUgNPmQHBq2d8O5/
         jZPxdIs6BJ4sgEx0yCovkDn5jKxl1lxe/et0Am+M9q1Djn0nOjXy8yGi/RFLfkn/TCeD
         6bD7cvt9gbmrXELHEXf10YqaWllg4HXT6GFIiilLXIXW9SQmN/4ulNtqO3EqYmyeDas/
         VCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yhl8pbOdaalAMsJe7hpEsxkpuZCX76ZLSoNM9EjUzXg=;
        b=dsPCU1t+c+3aiTfO4aW9tGUX4FTbmYJX7/GcBvjLtuSlpn7eVJ5B5vMpBbCuB+WUOD
         Cb/O7IReCZbjtx+a4asg0ftkA6J0FgXBeUPv/YD6rwdHoZqfsiF4jtfoj+WdmHlSgJpy
         GmAPHLxZmNpxPuSNQMlR87Ous9U6MXhlftviFXDIVGQBZoHvlJ3LySlsikCY3Ox4FnsA
         5FvXg1eEcpaFglDfog425TmdoyIKs7mvR8TRnD5rFx4oM6GlXw5NJSAVaVBat8pSXygz
         w2peP0TGoPN5gtRVUj/J78qehHU1Oyau+WGZkyymYC35nBjkEiOAIPoKcA7tdCwn2Wpe
         WVrg==
X-Gm-Message-State: AOAM533oetqGupGeeGHW62tKTBBBL1Ie2RjWAMWzPoyhm5P8AlnFricE
        be69oEd8uX7L08LpvqKg10zM5w==
X-Google-Smtp-Source: ABdhPJx8PSGB6O3Wlv2NeBxl5ItnZN806vmd3MCvmCqjX1oQRVk1sPDCEH4F7g5hHz96mXOEqRCdkQ==
X-Received: by 2002:a37:7147:: with SMTP id m68mr26181180qkc.286.1618230710480;
        Mon, 12 Apr 2021 05:31:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id h62sm7728650qkf.116.2021.04.12.05.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 05:31:49 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lVvjJ-004Qej-5p; Mon, 12 Apr 2021 09:31:49 -0300
Date:   Mon, 12 Apr 2021 09:31:49 -0300
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
Message-ID: <20210412123149.GE227011@ziepe.ca>
References: <20210412122330.5166-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412122330.5166-1-dwagner@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 02:23:30PM +0200, Daniel Wagner wrote:
> Drop the WQ_MEM_RECLAIM flag as it is not needed and introduces
> warnings.
> 
> The documentation says "all wq which might be used in the memory
> reclaim paths MUST have this flag set. The wq is guaranteed to have at
> least one execution context regardless of memory pressure."
> 
> By setting WQ_MEM_RECLAIM the threads are ready be running during
> early init. The claim it guarantees at least one execution context
> regardless of memory pressure is not supported by the implementation.
> 
> As the nvme core does not depend on early init we can remove the
> WQ_MEM_RECLAIM flag. This resolves a warning in the rdma path:

What does early init have to do with WQ_MEM_RECLAIM?

WQ_MEM_RECLIAM is required when any thread in a reclaim context goes
to sleep waiting for a WQ to complete. For instance by calling
flush_workqueue() or many other things.

The sleeping reclaim context must be guarenteed that the work can be
completed without the work, work queue machinery, or anything the work
has become interconnected with, recursing back into a reclaim.

IIRC the issue here was some destroy or flush work in some error
condition that happened to be under a reclaim context?

I don't see the kind of analysis I'd expect in this commit message to
justify this change.

Jason
