Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D468333785F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 16:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234254AbhCKPpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 10:45:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57941 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234291AbhCKPo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 10:44:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615477495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EDixfRUXhwwO3Hr27sZpPActljciPMjEXVNBDCJPQ2g=;
        b=foBNDMTCNesOZFo9/N9sF91GAwtJTotpg+heNBrqJ23YaJDA+qKNY8xJo4YxEnEqEySQGT
        dA0qyT0oY+uRnwr+6ZPQnU5VQrpfWByIXY70EmaYnzzcMNDIY9hDf8IZOUBhMf8NHSQyXI
        lrYxV9cu6Rlb8qKSOf19I5ECf5s4r0Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-FrzkFOIXPBmL_ojbiFcVgA-1; Thu, 11 Mar 2021 10:44:54 -0500
X-MC-Unique: FrzkFOIXPBmL_ojbiFcVgA-1
Received: by mail-wr1-f69.google.com with SMTP id h30so9715139wrh.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 07:44:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EDixfRUXhwwO3Hr27sZpPActljciPMjEXVNBDCJPQ2g=;
        b=umxEhMZdo4lGnYE/0PaFyqK03Vle1cw9XNdCiZKNBlGiUT8OlSOIkT4Gf2WCip4vzI
         YZt7mT+hTLjIobZ8g4WM9NLg8Sq2Tl3+hJaZrG391g/vmFw8ysVIH9eBq0DRjVIp0Sda
         7fbjctktJZKfJGbBWJ+xEB6/d+PMrH3Dbfw53df1Rlg8xYexYnov/9xsyUsVyJKWVnBU
         j5wFnNvbT0QRKo9CYYjbNMyJrnXsrl+GhES+/k6SaxMSZtqJPpgCtm7WDgOXlmIRe7pa
         IjpondYNxVzyjb1kA6Tl0RGYjLfWebbr3+9skXTp9uNgauflwfpjgxF0L7CLDtJc55K6
         rj+Q==
X-Gm-Message-State: AOAM531BjmZl4rSPX9sciNnglHT49KoI8TgvDH8jtY6D01My/OdKErDM
        BdagbWdpt4GcoIIyKHbhyHtYm6JcERgsNVIez1QzKCggA0Js41ooyztV77eUxfH7x5acnHF7i0N
        YVj4/kNPcDYOl4Aj8sNhyNnQz
X-Received: by 2002:a1c:1d14:: with SMTP id d20mr8970944wmd.36.1615477492629;
        Thu, 11 Mar 2021 07:44:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwHjr8644cgD/IAgZiJcIftxezr5XDgbDQ2Ot4F+wCFbcHXofdu4R60zaHjqtJPY8mYxFUyag==
X-Received: by 2002:a1c:1d14:: with SMTP id d20mr8970931wmd.36.1615477492444;
        Thu, 11 Mar 2021 07:44:52 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
        by smtp.gmail.com with ESMTPSA id i11sm4590680wro.53.2021.03.11.07.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 07:44:50 -0800 (PST)
Date:   Thu, 11 Mar 2021 10:44:47 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio-mmio: read[wl]()/write[wl] are already
 little-endian
Message-ID: <20210311104414-mutt-send-email-mst@kernel.org>
References: <20210309224313.956065-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309224313.956065-1-laurent@vivier.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 11:43:13PM +0100, Laurent Vivier wrote:
> read[wl]()/write[wl] already access memory in little-endian mode.

But then they convert it to CPU right? We just convert it back ...

> No need to convert the value with cpu_to_leXX()/leXX_to_cpu()
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  drivers/virtio/virtio_mmio.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index a286d22b6551..3f6a5588f77d 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -168,17 +168,17 @@ static void vm_get(struct virtio_device *vdev, unsigned offset,
>  		memcpy(buf, &b, sizeof b);
>  		break;
>  	case 2:
> -		w = cpu_to_le16(readw(base + offset));
> +		w = readw(base + offset);
>  		memcpy(buf, &w, sizeof w);
>  		break;
>  	case 4:
> -		l = cpu_to_le32(readl(base + offset));
> +		l = readl(base + offset);
>  		memcpy(buf, &l, sizeof l);
>  		break;
>  	case 8:
> -		l = cpu_to_le32(readl(base + offset));
> +		l = readl(base + offset);
>  		memcpy(buf, &l, sizeof l);
> -		l = cpu_to_le32(ioread32(base + offset + sizeof l));
> +		l = ioread32(base + offset + sizeof l);
>  		memcpy(buf + sizeof l, &l, sizeof l);
>  		break;
>  	default:
> @@ -212,17 +212,17 @@ static void vm_set(struct virtio_device *vdev, unsigned offset,
>  		break;
>  	case 2:
>  		memcpy(&w, buf, sizeof w);
> -		writew(le16_to_cpu(w), base + offset);
> +		writew(w, base + offset);
>  		break;
>  	case 4:
>  		memcpy(&l, buf, sizeof l);
> -		writel(le32_to_cpu(l), base + offset);
> +		writel(l, base + offset);
>  		break;
>  	case 8:
>  		memcpy(&l, buf, sizeof l);
> -		writel(le32_to_cpu(l), base + offset);
> +		writel(l, base + offset);
>  		memcpy(&l, buf + sizeof l, sizeof l);
> -		writel(le32_to_cpu(l), base + offset + sizeof l);
> +		writel(l, base + offset + sizeof l);
>  		break;
>  	default:
>  		BUG();
> -- 
> 2.29.2

