Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A51343D07
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 10:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhCVJjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 05:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbhCVJjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 05:39:18 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89707C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 02:39:17 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id kr3-20020a17090b4903b02900c096fc01deso8195649pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 02:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cpOWRN/4tL9oLaXq9iknOFh2ybCUMd8z1EKrJlSz62o=;
        b=DQ5GI3qdfmcvLNSLSWXpKEmxmGmX50tIccaoBdVV9uPs1IUnMYPzV3LULg2dBAtxbF
         jKaB5VSkYd+IWtEu8bIkq3iKMexodzanq5uZQzrNPFPXCfRjuwNkdGP/9Bm3OAtrxmOu
         5611l83YTBZoFlgRtKvk64mPW3dpXXKZcs6t8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cpOWRN/4tL9oLaXq9iknOFh2ybCUMd8z1EKrJlSz62o=;
        b=XK9a2VLb48J5w0WR1q2/zOp2SxcsyKJt/X7er1x57Ssz+6Hr+cColdh/ZdMoAdXzDC
         VfKOO/m9jBYZwjsMS8QfxxT7OrnKXGsUIaZ/PITUUgpdm6B75yDWhHdCIT1Rcsl97Rbl
         I7NbTJz3iLzglaAv4ygi4Z1sbaWnkwojGSFfS8Eflg5WAx8IqklFBmuxjYOTn8HO8MMx
         IDO1TDvGZABvWN3RZreqRwil++2+hegKILzNLXCFrBFUcRYpnK6+42Y9SmEX3PP9nqlI
         dfff/2Qf1xcaw1fOGI48njEqc9dBwWotCePpM4h+SKlnaszbDoiqY3J64uXOJP1P1NJI
         vXGQ==
X-Gm-Message-State: AOAM530jU4iv3wLvF6oaA/ahWvQPdLQV4HtEVIR8+haI92fh9s3qd6Rm
        YMtR9kG2ETQwiTLC4RC8p0dGyQ==
X-Google-Smtp-Source: ABdhPJyRSmdZMU065hZ+r4l3nuxkNSmeaXQDMmFCComRK/Tao9GNyhyEdLVprQNtI8wj0vMq9WLZRQ==
X-Received: by 2002:a17:90a:cb8c:: with SMTP id a12mr12706266pju.35.1616405957184;
        Mon, 22 Mar 2021 02:39:17 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:b1b5:270:5df6:6d6e])
        by smtp.gmail.com with ESMTPSA id y19sm14253219pfo.0.2021.03.22.02.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 02:39:16 -0700 (PDT)
Date:   Mon, 22 Mar 2021 18:39:09 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org,
        linux-cifsd-devel@lists.sourceforge.net, smfrench@gmail.com,
        senozhatsky@chromium.org, hyc.lee@gmail.com,
        viro@zeniv.linux.org.uk, hch@lst.de, hch@infradead.org,
        ronniesahlberg@gmail.com, aurelien.aptel@gmail.com,
        aaptel@suse.com, sandeen@sandeen.net, colin.king@canonical.com,
        rdunlap@infradead.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steve French <stfrench@microsoft.com>
Subject: Re: [PATCH 3/5] cifsd: add file operations
Message-ID: <YFhlvedSTrxT3ogj@google.com>
References: <20210322051344.1706-1-namjae.jeon@samsung.com>
 <CGME20210322052207epcas1p3f0a5bdfd2c994a849a67b465479d0721@epcas1p3.samsung.com>
 <20210322051344.1706-4-namjae.jeon@samsung.com>
 <20210322070447.GE1667@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322070447.GE1667@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/03/22 10:04), Dan Carpenter wrote:
> 
> On Mon, Mar 22, 2021 at 02:13:42PM +0900, Namjae Jeon wrote:
> > +void *ksmbd_alloc(size_t size)
> > +{
> > +	return kvmalloc(size, GFP_KERNEL | __GFP_ZERO);
> 
> 
> This patch adds a bunch of wrappers around kvmalloc().  Don't do that.

Agreed. This was not cleaned up properly. The initial implementation
of that function (IIRC... it was sometime in 2018) basically contained
kvmalloc() implementation, because back in the days Samsung used kernel
version that simply didn't have kvmalloc() ( < KERNEL_VERSION(5, 0, 0))
