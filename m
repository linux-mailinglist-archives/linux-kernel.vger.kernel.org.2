Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCD5436460
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 16:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhJUOh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 10:37:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43252 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230283AbhJUOhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 10:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634826908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VugW9XKQqql+D4jW/MwnSaiqD5NSjAuo7rb/rILE+vA=;
        b=cFz+b8GpgUJ8L3LhXQRA9WnqE7Jvqg5jM7sz9r+C+ytGV1Hvfopeao2XOL5gKQSxTUf+cD
        wrKu497PVobeWv8kdTC1WxJmhVDo7YUuvJEWmIOmvAewluXlNutdJPZ4KWbrg06ThUh19t
        wcaSjhs9Ko2Iaim7r1/xDgHbDMAnpNo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-AcWUkQ0bOXWQMGAyKhMZcw-1; Thu, 21 Oct 2021 10:35:06 -0400
X-MC-Unique: AcWUkQ0bOXWQMGAyKhMZcw-1
Received: by mail-ed1-f71.google.com with SMTP id u17-20020a50d511000000b003daa3828c13so543419edi.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 07:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VugW9XKQqql+D4jW/MwnSaiqD5NSjAuo7rb/rILE+vA=;
        b=UEkdSZ2XWhwR/Mps4wpTl15GOPIZznc0/lt6RNw2Wi3yLqRyxNhDF35OhOAIUIS2Gt
         87X3Wr3yzybz/q+9K/D6djXIyxOcW2CYsHUvmIAJNMdBQXi/r7cTAHu6bUDDg/xjFBuh
         tXFFon0/l0dazzzexfSDiEI850sXXWIcmAFt/6WxIVSLCRSBdYrn7Ve6xFaeZ0fbcVPU
         ukg62VBUUpNCB+sXE7nxu4ZEJWHJ4kcm4oL0v3UPCPybiIREmqRXyJjuX82mL+eSAeoV
         RL6bYJSSYrn9MVa7qcO0PYHWBXJ8ECdYWpQiZ12oK8RI2QGZ6miFzrglBTmXHHM9Cdkm
         DEwA==
X-Gm-Message-State: AOAM530KCmYnWMIUp5YhwdZH0zKJs4+ZUBWMR4k8PWd3HxNWYyKKzKgy
        yhSTgNT/tlFY49TN8Nnx170ugQtzwAzn6txO3+tVbOoc/FzxTKwhrsd26HdYWYYFeNXN/5mSCL4
        FpXvBoBS20p8QZJrphBlH1xr3
X-Received: by 2002:a17:907:961e:: with SMTP id gb30mr7883131ejc.484.1634826905599;
        Thu, 21 Oct 2021 07:35:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSRO0xBoE29HcFaVDTP+mg9VveZQjRkYIv8YWZhFjn3jIIO8pGIPgUQcl4cBQPn6cnJIg4Xw==
X-Received: by 2002:a17:907:961e:: with SMTP id gb30mr7883111ejc.484.1634826905435;
        Thu, 21 Oct 2021 07:35:05 -0700 (PDT)
Received: from steredhat (host-79-30-88-77.retail.telecomitalia.it. [79.30.88.77])
        by smtp.gmail.com with ESMTPSA id u18sm2900999eds.86.2021.10.21.07.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 07:35:05 -0700 (PDT)
Date:   Thu, 21 Oct 2021 16:35:03 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     cgel.zte@gmail.com
Cc:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, axboe@kernel.dk,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ye Guojin <ye.guojin@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] virtio-blk: fixup coccinelle warnings
Message-ID: <20211021143503.xp7u6qmypvhbl5th@steredhat>
References: <20211021065111.1047824-1-ye.guojin@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20211021065111.1047824-1-ye.guojin@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 06:51:11AM +0000, cgel.zte@gmail.com wrote:
>From: Ye Guojin <ye.guojin@zte.com.cn>
>
>coccicheck complains about the use of snprintf() in sysfs show
>functions:
>WARNING  use scnprintf or sprintf
>
>Use sysfs_emit instead of scnprintf or sprintf makes more sense.
>
>Reported-by: Zeal Robot <zealci@zte.com.cn>
>Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>
>---
> drivers/block/virtio_blk.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

