Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F04031AA8B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 09:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhBMInb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 03:43:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:60436 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbhBMIn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 03:43:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5F7D1AC32;
        Sat, 13 Feb 2021 08:42:47 +0000 (UTC)
Subject: Re: [PATCH] nvme-tcp: Check if request has started before processing
 it
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Keith Busch <kbusch@kernel.org>
References: <20210212181738.79274-1-dwagner@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <3f183393-cc1e-3d03-3074-40c18f3cb9cc@suse.de>
Date:   Sat, 13 Feb 2021 09:42:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210212181738.79274-1-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/21 7:17 PM, Daniel Wagner wrote:
> blk_mq_tag_to_rq() will always return a request if the command_id is
> in the valid range. Check if the request has been started. If we
> blindly process the request we might double complete a request which
> can be fatal.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> 
> This patch is against nvme-5.12.
> 
> There is one blk_mq_tag_to_rq() in nvme_tcp_recv_ddgst() which I
> didn't update as I am not sure if it's also needed.
> 
I guess it is; this patch is essentially a protection against invalid 
frames, and as such affects all places.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
