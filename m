Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8629312E43
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 11:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhBHKAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 05:00:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:34018 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232021AbhBHJte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 04:49:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612777728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3NhcpUvwMgEF2rRU4mx1o9wN8tYHo5OlqhAF8sWXq9M=;
        b=cumVrgkaunXuO6f9PY170PKriCorRoIVGi2zdDkYcDguu3RJ7sDt6XroUa4+2Bpkdhv2hs
        BieJgAhpprvHACzZ/tyu106MaAMLcLVdtFAhmKhkINjYZ1TqUQilo3ICF25vqpJR76GEHE
        u5I8/zp7ei0cTHCwYx+RXxe+5xOs1mY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D20D2AC6E;
        Mon,  8 Feb 2021 09:48:48 +0000 (UTC)
Subject: Re: [PATCH 7/7] xen/evtchn: read producer index only once
To:     Juergen Gross <jgross@suse.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
References: <20210206104932.29064-1-jgross@suse.com>
 <20210206104932.29064-8-jgross@suse.com>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <72334160-cffe-2d8a-23b7-2ea9ab1d803a@suse.com>
Date:   Mon, 8 Feb 2021 10:48:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210206104932.29064-8-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.02.2021 11:49, Juergen Gross wrote:
> In evtchn_read() use READ_ONCE() for reading the producer index in
> order to avoid the compiler generating multiple accesses.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  drivers/xen/evtchn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/xen/evtchn.c b/drivers/xen/evtchn.c
> index 421382c73d88..f6b199b597bf 100644
> --- a/drivers/xen/evtchn.c
> +++ b/drivers/xen/evtchn.c
> @@ -211,7 +211,7 @@ static ssize_t evtchn_read(struct file *file, char __user *buf,
>  			goto unlock_out;
>  
>  		c = u->ring_cons;
> -		p = u->ring_prod;
> +		p = READ_ONCE(u->ring_prod);
>  		if (c != p)
>  			break;

Why only here and not also in

		rc = wait_event_interruptible(u->evtchn_wait,
					      u->ring_cons != u->ring_prod);

or in evtchn_poll()? I understand it's not needed when
ring_prod_lock is held, but that's not the case in the two
afaics named places. Plus isn't the same then true for
ring_cons and ring_cons_mutex, i.e. aren't the two named
places plus evtchn_interrupt() also in need of READ_ONCE()
for ring_cons?

Jan
