Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248013E1E81
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 00:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237556AbhHEWPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 18:15:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57417 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229729AbhHEWPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 18:15:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628201720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MCW6M0K+DPxrj754zH128zD3EsmKOhs+543ICnuoMcc=;
        b=TBibYXZraFrLl/DCmk0188gibAw+AebBKSU0ENkgmOU33gdxqbKmRjr8ZIzTDbGtcmLQk6
        cpDxpHdtlmmazl5wgvgse73nf458Xm0dM8iEwkvrt+EkoOqZWXlYDDYbdfl/9qfX3v8CvZ
        U2q1TMtSv6oC+4RZhM9+Cg6nSwHQ+bI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-6bchScy4PI6RPhYx8prZJw-1; Thu, 05 Aug 2021 18:15:19 -0400
X-MC-Unique: 6bchScy4PI6RPhYx8prZJw-1
Received: by mail-ed1-f71.google.com with SMTP id ee50-20020a0564022932b02903be1503f932so475714edb.15
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 15:15:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MCW6M0K+DPxrj754zH128zD3EsmKOhs+543ICnuoMcc=;
        b=qc9eW9t2seLdqWG/Ei2YstkmE7NIUf0EErVKAP6UXQvCln4cmldLw8D2G9dwYVP5LM
         s83ybq5s+B+5GdJy/6fFRDQM/QPciKNmDA5AuG5Bqp2DaAKqH43kVD/hk8uIoM2/S6qo
         mYyIdi2Z+EfFnDFH5CnFNI8E48sTt7ZDkTBl7DuNV0RVMR0/QAAzLZe4BvoxRbBlDJB7
         N4gJWvqY6SgDCPBF3AmIu0sbJLlxRlhNujmJhDnzr3nJc+elQEPtm55te68T2Krn0wuZ
         hxmbed6+CBLS1hRrEV3xiiBj8uMtb+KsGddYAPS9WHLmjX4RVCJdvRgx8J+Mb8HOXwn1
         NmRg==
X-Gm-Message-State: AOAM532LbLw1kyRYQ3Dce7PRpBLhK0Evz1I7KU4V2iQ8P1lfA254ei6b
        eFb5/xc0+oztfMqLfkVuYJy6A9kVgorlwwQ/e1bibWZnp1qtvxDwDk2mzW63IXVtLjwvNQjHOUZ
        pUR6yte84i1PP+onvO8sgCwhi
X-Received: by 2002:a17:906:2990:: with SMTP id x16mr6795227eje.554.1628201718279;
        Thu, 05 Aug 2021 15:15:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIbQyYnx447QQy9o6qJM2wlkRIYr/HT4vvEFz63y63gHdgtaTBNV04YkPjLGwS1izVND2L5Q==
X-Received: by 2002:a17:906:2990:: with SMTP id x16mr6795220eje.554.1628201718163;
        Thu, 05 Aug 2021 15:15:18 -0700 (PDT)
Received: from redhat.com ([2.55.141.248])
        by smtp.gmail.com with ESMTPSA id bm1sm2152353ejb.38.2021.08.05.15.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 15:15:16 -0700 (PDT)
Date:   Thu, 5 Aug 2021 18:15:13 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/virtio: use 'unsigned int' instead of bare
 'unsigned'
Message-ID: <20210805181436-mutt-send-email-mst@kernel.org>
References: <20210729000402.45690-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729000402.45690-1-wangborong@cdjrlc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 08:04:02AM +0800, Jason Wang wrote:
> Replace the lazy way 'unsigned' with 'unsigned int' which is more
> accurate.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>

I don't see why this is more accurate. AFAIK it's exactly the same.

> ---
>  tools/virtio/vringh_test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
> index fa87b58bd5fa..3e85f4ec210d 100644
> --- a/tools/virtio/vringh_test.c
> +++ b/tools/virtio/vringh_test.c
> @@ -447,7 +447,7 @@ int main(int argc, char *argv[])
>  	char buf[28];
>  	u16 head;
>  	int err;
> -	unsigned i;
> +	unsigned int i;
>  	void *ret;
>  	bool (*getrange)(struct vringh *vrh, u64 addr, struct vringh_range *r);
>  	bool fast_vringh = false, parallel = false;
> @@ -654,7 +654,7 @@ int main(int argc, char *argv[])
>  
>  	/* Free those buffers. */
>  	for (i = 0; i < RINGSIZE; i++) {
> -		unsigned len;
> +		unsigned int len;
>  		assert(virtqueue_get_buf(vq, &len) != NULL);
>  	}
>  
> -- 
> 2.32.0

