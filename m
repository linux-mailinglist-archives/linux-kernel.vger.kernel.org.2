Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5777939EE10
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 07:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhFHFZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 01:25:20 -0400
Received: from verein.lst.de ([213.95.11.211]:49127 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230281AbhFHFZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 01:25:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E443E67373; Tue,  8 Jun 2021 07:23:20 +0200 (CEST)
Date:   Tue, 8 Jun 2021 07:23:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Wu Bo <wubo40@huawei.com>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linfeilong@huawei.com
Subject: Re: [PATCH] nvme-multipath: combine grpid and ANA state checks in
 nvme_parse_ana_log()
Message-ID: <20210608052320.GA13828@lst.de>
References: <1623125616-629270-1-git-send-email-wubo40@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623125616-629270-1-git-send-email-wubo40@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 12:13:36PM +0800, Wu Bo wrote:
> -		if (WARN_ON_ONCE(desc->grpid == 0))
> +		if (WARN_ON_ONCE(desc->grpid == 0 ||
> +			le32_to_cpu(desc->grpid) > ctrl->anagrpmax))
>  			return -EINVAL;
> -		if (WARN_ON_ONCE(le32_to_cpu(desc->grpid) > ctrl->anagrpmax))
> -			return -EINVAL;
> -		if (WARN_ON_ONCE(desc->state == 0))
> -			return -EINVAL;
> -		if (WARN_ON_ONCE(desc->state > NVME_ANA_CHANGE))
> +		if (WARN_ON_ONCE(desc->state == 0 ||
> +			desc->state > NVME_ANA_CHANGE))

So besides making the code impossibl to read due to the incorrect
indentation this also makes each WARN_ON_ONCE cover multiple conditions.
Not very useful for debugging.
