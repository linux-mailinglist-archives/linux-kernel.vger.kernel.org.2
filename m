Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1852934FD8F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbhCaJ5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbhCaJ5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:57:33 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7486C061574;
        Wed, 31 Mar 2021 02:57:32 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e18so19023717wrt.6;
        Wed, 31 Mar 2021 02:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=HhzP497JwzE7qBvkLi1PWy+Oq7YyictUjri7Hz/xGfs=;
        b=L5dNcFuSepOYJgqrnPW7GToj4Rnlj7T/Vtn4sgMAZcbX2LVi9snLxsUQxLaFzljbAD
         +K9E9/ecIB8wXz1iHX1AY9yhDPyl1Mc6+3EFhIuifBb99xkPd7bewGlk21s4fS0SE7BL
         4WKA98Wg54SXDgAHfUD+raOvPy91W/Hk7cw1RT7xNi9TS6RWbft2oVJjVQ3zeKZDRloC
         AGk2mY9XFiJMEv00wl9oIXKNT2ryAy47sQuAuxd6QaVQtLX3VU+Gl4vB0gLkErE3jg39
         W1+iYILcmSlgUkc8yfjNW3vAEkv3AoiTvS+cK2S8pCI8LebS57mOWQk84nAUBuiQCmB4
         1JHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=HhzP497JwzE7qBvkLi1PWy+Oq7YyictUjri7Hz/xGfs=;
        b=QFPebW6hTbb+Fgdt6PKnDulYQtbG8TV/Jx8KKPzDCSDsmYd0GVAFRtT3A6jRHD8Cvh
         TqqSE7xjedDEsLaUSO2canUsh36hPHAvOSYIpjuUEFymBaAVKAa0bE94UoQaa2vav9b0
         GF+2A6SKR0L4a9rla0gnLdd/PaN4wiiIwD1lwAS8fwaJN4o2Z6I6pdSRS3c+eE+0YyHi
         76EsQLbhmwAiKXbkCngDGC5urEI5tORWmEzgsQ/szCgjPd/+zVFt1zAhnxrLVV4gqrmg
         P0UocmULTKtO3avnDY6J581Frd490aBGobMztUmhOREsCgqR3tkb6xR/2sXnQax9fNry
         VhUA==
X-Gm-Message-State: AOAM532G5uxJIi+vTq5ZFRz1fVklpd7vxAsmzR3W0Fccnn2FQJ3ywVa3
        Ab/vkZLtu3IhIp+DM/obkEHURKyOXAiFTQ==
X-Google-Smtp-Source: ABdhPJyCf3FgfMWHQ1jN0VCnK4Rern3F7ble6Fyqori+YpHKxyOA9VTpXs7GWKHJHDZ7uxrNLEG8Vg==
X-Received: by 2002:adf:d851:: with SMTP id k17mr2752514wrl.254.1617184651468;
        Wed, 31 Mar 2021 02:57:31 -0700 (PDT)
Received: from 192.168.10.5 ([39.46.7.73])
        by smtp.gmail.com with ESMTPSA id c2sm3232775wme.15.2021.03.31.02.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 02:57:30 -0700 (PDT)
Message-ID: <d58921603fb8adf3bb335a9986c8c89348ab0985.camel@gmail.com>
Subject: Re: [PATCH] io_uring: Initialize variable before use
From:   Muhammad Usama Anjum <musamaanjum@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        colin.king@canonical.com
Date:   Wed, 31 Mar 2021 14:57:25 +0500
In-Reply-To: <20210331084817.GH2088@kadam>
References: <20210322184158.GA2095479@LEGION> <20210331084817.GH2088@kadam>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-03-31 at 11:48 +0300, Dan Carpenter wrote:
> On Mon, Mar 22, 2021 at 11:41:58PM +0500, Muhammad Usama Anjum wrote:
> > 1) Initialize the struct msghdr msg in the start of the function
> > 2) Uninitialized variable msg.msg_flags can get used if branch happens to
> > out_free before initialization.
> > 
> > So initialize variable in question in the start of the function for
> > simplicity in logic and use.
> > 
> > Addresses-Coverity: ("Uninitialized variable")
> > Addresses-Coverity: ("Uninitialized variable read")
> 
> This bug is a false positive.
> 
> When msg.msg_flags is uninitialized then ret is negative and min_ret is
> zero.
> 
> fs/io_uring.c
>   4666                  ret = -EINTR;
>   4667  out_free:
>   4668          if (req->flags & REQ_F_BUFFER_SELECTED)
>   4669                  cflags = io_put_recv_kbuf(req);
>   4670          if (ret < min_ret || ((flags & MSG_WAITALL) && (msg.msg_flags & (MSG_TRUNC | MSG_CTRUNC))))
>                     ^^^^^^^^^^^^^                               ^^^^^^^^^^^^^
> The first part of the condition is true so the second part is not used.
> 
>   4671                  req_set_fail_links(req);
>   4672          __io_req_complete(req, issue_flags, ret, cflags);
>   4673          return 0;
>   4674  }
> 
Understood. Thank you so much!

Thanks,
Usama

> regards,
> dan carpenter
> 

