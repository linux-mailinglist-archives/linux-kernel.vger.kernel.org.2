Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31070382E18
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 16:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237564AbhEQOCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 10:02:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:38878 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232924AbhEQOCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 10:02:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621260061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+NdK/avQ8FBevNdzVt7abclY7ENC4Xp3kwu3bH3BXGU=;
        b=hYPsv114snNpTzRdG0F8FjOixxA+SuYB69/5PExQu2q6jetyOORhTmI33XUIRFQoSsuumH
        wm8zR2YajUMDfNKrOTJZip22sEn+XReUuQtivi9aVHWVXxe3Q/Ne8zCb43HBKhQol9uRzg
        SbZcgBXtsfJDlrDU97x5cATUj+CAjT4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 67309AC8F;
        Mon, 17 May 2021 14:01:01 +0000 (UTC)
Subject: Re: [PATCH 3/8] xen/blkfront: don't take local copy of a request from
 the ring page
To:     Juergen Gross <jgross@suse.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20210513100302.22027-1-jgross@suse.com>
 <20210513100302.22027-4-jgross@suse.com>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <4cbf7b7f-5f00-4aba-4d54-06aa73d1bc32@suse.com>
Date:   Mon, 17 May 2021 16:01:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210513100302.22027-4-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.05.2021 12:02, Juergen Gross wrote:
> In order to avoid a malicious backend being able to influence the local
> copy of a request build the request locally first and then copy it to
> the ring page instead of doing it the other way round as today.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Jan Beulich <jbeulich@suse.com>
with one remark/question:

> @@ -703,6 +704,7 @@ static int blkif_queue_rw_req(struct request *req, struct blkfront_ring_info *ri
>  {
>  	struct blkfront_info *info = rinfo->dev_info;
>  	struct blkif_request *ring_req, *extra_ring_req = NULL;
> +	struct blkif_request *final_ring_req, *final_extra_ring_req;

Without setting final_extra_ring_req to NULL just like is done for
extra_ring_req, ...

> @@ -840,10 +845,10 @@ static int blkif_queue_rw_req(struct request *req, struct blkfront_ring_info *ri
>  	if (setup.segments)
>  		kunmap_atomic(setup.segments);
>  
> -	/* Keep a private copy so we can reissue requests when recovering. */
> -	rinfo->shadow[id].req = *ring_req;
> +	/* Copy request(s) to the ring page. */
> +	*final_ring_req = *ring_req;
>  	if (unlikely(require_extra_req))
> -		rinfo->shadow[extra_id].req = *extra_ring_req;
> +		*final_extra_ring_req = *extra_ring_req;

... are you sure all supported compilers will recognize the
conditional use and not warn about use of a possibly uninitialized
variable?

Jan
