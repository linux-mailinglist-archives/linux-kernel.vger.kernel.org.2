Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA923DE07B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 22:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhHBUMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 16:12:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23227 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230095AbhHBUMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 16:12:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627935125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q52w6Q4YtuhtQOV0oJmgEUraWN88/oaIpPIXQ4cq1HY=;
        b=LE0/8pkSOZcet6YCYBENzHDVMIQNfhM6lL7mYED5VZpbWc/H8slVirXD3rhjcKyI92EgD6
        yN/RyDTZS5WQdGMT6ZG6V3DpEte1/YuyCgdLXHeNgJzuS0Fi4feQ5VqvbCKsr/oaqZBzgZ
        sCwnvaNRb5VuCIlJWDoGqikhrSuGTOc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-M-5y0w_DMv-pv833eeJMPg-1; Mon, 02 Aug 2021 16:12:03 -0400
X-MC-Unique: M-5y0w_DMv-pv833eeJMPg-1
Received: by mail-ej1-f72.google.com with SMTP id k22-20020a1709061596b02905a370b2f477so115606ejd.17
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 13:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q52w6Q4YtuhtQOV0oJmgEUraWN88/oaIpPIXQ4cq1HY=;
        b=M9BqCPn7AlHonYvmvwx4jXvH8ieKNuVQUrp5ondmFdLJi4EX8ir0pWZMNkuGqQKG/R
         Um1TY55V7d7efp8l09ZCpqA2KAoD4d+JWQnKwHA2jQRZM3dvQknoEglFNBlEMnqorp6m
         YX9RPlKLHlbUBA1aF+4C5+u0JgGcNmcqIP+lREsyUOrF0dFCfXQjUmJ4A1S+xKzkOmoG
         tYlnadf711yD2CfbXHYIKcsFMDMQWf+P/naFVQw/wgq1+dUtutKiY4fU3wzqgzU6LCXM
         sX/gu7W+JE5dEGhKiQjMzJ5Ea0bZKQif1CYzJmHJsv5KJXUItiVKT293Ig1kMML7bvWF
         y1EA==
X-Gm-Message-State: AOAM533nCOrSAx9ddwoSlOZMJga5nsjW6QLy/SW7EqiQBP23YWeNY9Qy
        1PSgZc9xF86+yllenfFPkuWFP6VqMJ0xwlB8snuuciNswwYCA65tWIUih65lmYPc5nq0ZKSE/T+
        BK/0KG7Cg6N3L/YVJ1h9WSU8y
X-Received: by 2002:aa7:c0d1:: with SMTP id j17mr21235856edp.217.1627935122739;
        Mon, 02 Aug 2021 13:12:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfr39sns4u7IHD+697IXe7EyNtPI7YycI0ox/3uN10j7vd/YANYQrljcKZhj+LRbcxif46Ug==
X-Received: by 2002:aa7:c0d1:: with SMTP id j17mr21235843edp.217.1627935122638;
        Mon, 02 Aug 2021 13:12:02 -0700 (PDT)
Received: from redhat.com ([2.55.140.205])
        by smtp.gmail.com with ESMTPSA id o7sm4957679ejy.48.2021.08.02.13.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 13:12:02 -0700 (PDT)
Date:   Mon, 2 Aug 2021 16:11:57 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     fuguancheng <fuguancheng@bytedance.com>
Cc:     jasowang@redhat.com, stefanha@redhat.com, sgarzare@redhat.com,
        davem@davemloft.net, kuba@kernel.org, arseny.krasnov@kaspersky.com,
        andraprs@amazon.com, colin.king@canonical.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] VSOCK DRIVER: Add multi-cid support for guest
Message-ID: <20210802161055-mutt-send-email-mst@kernel.org>
References: <20210802120720.547894-1-fuguancheng@bytedance.com>
 <20210802120720.547894-2-fuguancheng@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802120720.547894-2-fuguancheng@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 08:07:17PM +0800, fuguancheng wrote:
> diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
> index 3dd3555b2740..0afc14446b01 100644
> --- a/include/uapi/linux/virtio_vsock.h
> +++ b/include/uapi/linux/virtio_vsock.h
> @@ -42,7 +42,8 @@
>  #define VIRTIO_VSOCK_F_SEQPACKET	1	/* SOCK_SEQPACKET supported */
>  
>  struct virtio_vsock_config {
> -	__le64 guest_cid;
> +	__le32 number_cid;
> +	__le64 cids[];
>  } __attribute__((packed));

any host/guest interface change needs to copy the virtio TC.
packing here is a bad idea imho, just add explicit padding.

-- 
MST

