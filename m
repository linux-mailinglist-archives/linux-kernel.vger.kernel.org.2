Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 130A237C3CD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 17:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbhELPWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 11:22:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:37062 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232509AbhELPKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 11:10:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AF563B172;
        Wed, 12 May 2021 15:09:03 +0000 (UTC)
Subject: Re: [PATCH v1 3/8] block: move disk invalidation from del_gendisk()
 into a helper
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk
Cc:     bvanassche@acm.org, ming.lei@redhat.com, hch@infradead.org,
        jack@suse.cz, osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210512064629.13899-1-mcgrof@kernel.org>
 <20210512064629.13899-4-mcgrof@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <fdc93947-a1e1-c0ba-f9b4-1bcf9145f08c@suse.de>
Date:   Wed, 12 May 2021 17:09:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210512064629.13899-4-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/21 8:46 AM, Luis Chamberlain wrote:
> Move the disk / partition invalidation into a helper. This will make
> reading del_gendisk easier to read, in preparation for adding support
> to add error handling later on register_disk() and to later share more
> code with del_gendisk.
> 
> This change has no functional changes.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   block/genhd.c | 48 ++++++++++++++++++++++++++----------------------
>   1 file changed, 26 insertions(+), 22 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
