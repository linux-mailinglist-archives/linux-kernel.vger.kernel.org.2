Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3756341504E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 21:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237164AbhIVTDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 15:03:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59036 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237137AbhIVTDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 15:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632337336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YkGM074Sqzm2cnA7q+tjffVmS5yQ7D3vt1VWpyzRhSw=;
        b=QW+4WLKUCfc6bs5o2X33mOSeRtA0Mx8Pttr3DLinbjCQtmIIrtV7dUhJX/zMuyWppctRE5
        yWIJUVU7OQ19+6saV9zSeQP9AnFDdbvfQfaa97wyJQtJVhJQFNxFS+mnX6ics8ooi+/+tj
        UZTMyjfiRgoPhY5ucfGMj9nhR2MnLgk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552-nirR5w2rPnmZbwxYYGduzQ-1; Wed, 22 Sep 2021 15:02:15 -0400
X-MC-Unique: nirR5w2rPnmZbwxYYGduzQ-1
Received: by mail-wr1-f69.google.com with SMTP id c15-20020a5d4ccf000000b0015dff622f39so3003038wrt.21
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 12:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YkGM074Sqzm2cnA7q+tjffVmS5yQ7D3vt1VWpyzRhSw=;
        b=GgmKsYkVRjLH3WPKJVLolyE8dQEgy4H3Q/QV2BB1BEE1nepC3rdsER9HkMrBQELM0I
         GJ4VuqW5a7hDsDK65EuydZfzyMh93iiPccQeRCWC/pS78Dp8L4SfLSBFPAMJaQtluElu
         C0d3AGgcvekcucPGwirfBB11b5lKh8Z45AjJc+sPqNsONWBQDNz6oQGN0RDerKdEw7De
         /9e4VzuHsBLHVujrI4NxIKhwr/eKKQU4dXYQcJV1yjGigjlWbHX1gXw+yNlxzlWVMzUD
         lcEQGK8HqH9rtOItXBwRLSlAJvIZTuU/u5njYfGNv7SDWPDLNrXdwQv7OwuDJ+vwjwNR
         UdrA==
X-Gm-Message-State: AOAM532YmKlcsbWmqjLtIsDwdA5LeoYfHW5cwoTtpfvkQntCLZ6fYy+0
        xNU4gxumt0j0plYOo2O4OS4I8sH82yjxmI6zGzLEHgR9bcD/woB8KZhF9kVvoM/mXvxo1TuqUHO
        wGu3MExbFUkxI9E6f3BnLKb7q
X-Received: by 2002:a5d:688a:: with SMTP id h10mr566219wru.331.1632337333591;
        Wed, 22 Sep 2021 12:02:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1QZokQycw03rSq+x5aZ0qJCIjw+WMM0ILYk/1Fa7uZgHUbxN1UVcifVfv8Bu6EbjHNVe80A==
X-Received: by 2002:a5d:688a:: with SMTP id h10mr566190wru.331.1632337333363;
        Wed, 22 Sep 2021 12:02:13 -0700 (PDT)
Received: from redhat.com ([2.55.11.56])
        by smtp.gmail.com with ESMTPSA id y8sm2972877wrh.44.2021.09.22.12.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 12:02:10 -0700 (PDT)
Date:   Wed, 22 Sep 2021 15:02:06 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Laurent Vivier <lvivier@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        linux-crypto@vger.kernel.org, Dmitriy Vyukov <dvyukov@google.com>,
        rusty@rustcorp.com.au, amit@kernel.org, akong@redhat.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Matt Mackall <mpm@selenic.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 1/4] hwrng: virtio - add an internal buffer
Message-ID: <20210922145651-mutt-send-email-mst@kernel.org>
References: <20210922170903.577801-1-lvivier@redhat.com>
 <20210922170903.577801-2-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922170903.577801-2-lvivier@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 07:09:00PM +0200, Laurent Vivier wrote:
> hwrng core uses two buffers that can be mixed in the
> virtio-rng queue.
> 
> If the buffer is provided with wait=0 it is enqueued in the
> virtio-rng queue but unused by the caller.
> On the next call, core provides another buffer but the
> first one is filled instead and the new one queued.
> And the caller reads the data from the new one that is not
> updated, and the data in the first one are lost.
> 
> To avoid this mix, virtio-rng needs to use its own unique
> internal buffer at a cost of a data copy to the caller buffer.
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  drivers/char/hw_random/virtio-rng.c | 43 ++++++++++++++++++++++-------
>  1 file changed, 33 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
> index a90001e02bf7..208c547dcac1 100644
> --- a/drivers/char/hw_random/virtio-rng.c
> +++ b/drivers/char/hw_random/virtio-rng.c
> @@ -18,13 +18,20 @@ static DEFINE_IDA(rng_index_ida);
>  struct virtrng_info {
>  	struct hwrng hwrng;
>  	struct virtqueue *vq;
> -	struct completion have_data;
>  	char name[25];
> -	unsigned int data_avail;
>  	int index;
>  	bool busy;
>  	bool hwrng_register_done;
>  	bool hwrng_removed;
> +	/* data transfer */
> +	struct completion have_data;
> +	unsigned int data_avail;
> +	/* minimal size returned by rng_buffer_size() */
> +#if SMP_CACHE_BYTES < 32
> +	u8 data[32];
> +#else
> +	u8 data[SMP_CACHE_BYTES];
> +#endif

Let's move this logic to a macro in hw_random.h ?

>  };
>  
>  static void random_recv_done(struct virtqueue *vq)
> @@ -39,14 +46,14 @@ static void random_recv_done(struct virtqueue *vq)
>  }
>  
>  /* The host will fill any buffer we give it with sweet, sweet randomness. */
> -static void register_buffer(struct virtrng_info *vi, u8 *buf, size_t size)
> +static void register_buffer(struct virtrng_info *vi)
>  {
>  	struct scatterlist sg;
>  
> -	sg_init_one(&sg, buf, size);
> +	sg_init_one(&sg, vi->data, sizeof(vi->data));

Note that add_early_randomness requests less:
        size_t size = min_t(size_t, 16, rng_buffer_size());

maybe track how much was requested and grow up to sizeof(data)?

>  
>  	/* There should always be room for one buffer. */
> -	virtqueue_add_inbuf(vi->vq, &sg, 1, buf, GFP_KERNEL);
> +	virtqueue_add_inbuf(vi->vq, &sg, 1, vi->data, GFP_KERNEL);


BTW no longer true if DMA API is in use ... not easy to fix,
I think some changes to virtio API to allow pre-mapping
s/g for DMA might be needed ...

>  
>  	virtqueue_kick(vi->vq);
>  }
> @@ -55,6 +62,8 @@ static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
>  {
>  	int ret;
>  	struct virtrng_info *vi = (struct virtrng_info *)rng->priv;
> +	unsigned int chunk;
> +	size_t read;
>  
>  	if (vi->hwrng_removed)
>  		return -ENODEV;
> @@ -62,19 +71,33 @@ static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
>  	if (!vi->busy) {
>  		vi->busy = true;
>  		reinit_completion(&vi->have_data);
> -		register_buffer(vi, buf, size);
> +		register_buffer(vi);
>  	}
>  
>  	if (!wait)
>  		return 0;
>  
> -	ret = wait_for_completion_killable(&vi->have_data);
> -	if (ret < 0)
> -		return ret;
> +	read = 0;
> +	while (size != 0) {
> +		ret = wait_for_completion_killable(&vi->have_data);
> +		if (ret < 0)
> +			return ret;
> +
> +		chunk = min_t(unsigned int, size, vi->data_avail);
> +		memcpy(buf + read, vi->data, chunk);
> +		read += chunk;
> +		size -= chunk;
> +		vi->data_avail = 0;
> +
> +		if (size != 0) {
> +			reinit_completion(&vi->have_data);
> +			register_buffer(vi);
> +		}
> +	}
>  
>  	vi->busy = false;
>  
> -	return vi->data_avail;
> +	return read;
>  }
>  
>  static void virtio_cleanup(struct hwrng *rng)
> -- 
> 2.31.1

