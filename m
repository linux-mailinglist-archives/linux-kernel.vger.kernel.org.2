Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B368B34D5B1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 19:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhC2RGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 13:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhC2RGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 13:06:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72DCC061574;
        Mon, 29 Mar 2021 10:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=PxZXZBxp3h9YV07j5jT8xkaQQh1GNk0fRvGYAARFTZg=; b=msfLzo1EA6eVVLNB0DfedVY89l
        IkhDlmw3csXKyISCQFTCCzB0eZB1i2Bn48A3y4H4DyGI/2TFw9uAaaQHSO3EEps+5tuMx5lv9xnrF
        hw8nYGH2iYdCNoRxu0fF3mZlRPCUpdRgdGFw6ktY94hcIPgt+A49P+jSkM3tB6IefInTozSCvFMiE
        mTY7iMFJJ/mG2XA2drP0raaK3czluoQLkrvBpXgYa6b7PpDkS1THUiDjLSYXp3Jp9L2RNLlFDcpFz
        kc/eLfuHLq+cXMw/KPyOnOiBkqINA7Q2HIdlfuKDdLbGgrxozyuoaDtuQfJHQUhAZUI7vYNHyOE4L
        QnfMp7qw==;
Received: from [2601:1c0:6280:3f0::4557]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lQvLL-000qmA-Mo; Mon, 29 Mar 2021 17:06:28 +0000
Subject: Re: [PATCH] crypto: chelsio: fix incorrect kernel-doc comment syntax
 in file
To:     Aditya Srivastava <yashsri421@gmail.com>,
        herbert@gondor.apana.org.au
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, ayush.sawal@chelsio.com,
        vinay.yadav@chelsio.com, rohitm@chelsio.com, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210329104514.16950-1-yashsri421@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <be5cdac5-5522-2204-41a7-e9a1ad717826@infradead.org>
Date:   Mon, 29 Mar 2021 10:06:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210329104514.16950-1-yashsri421@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/21 3:45 AM, Aditya Srivastava wrote:
> The opening comment mark '/**' is used for highlighting the beginning of
> kernel-doc comments.
> The header for drivers/crypto/chelsio/chcr_core.c follows this syntax, but
> the content inside does not comply with kernel-doc.
> 
> This line was probably not meant for kernel-doc parsing, but is parsed
> due to the presence of kernel-doc like comment syntax(i.e, '/**'), which
> causes unexpected warning from kernel-doc:
> "warning: wrong kernel-doc identifier on line:
>  * This file is part of the Chelsio T4/T5/T6 Ethernet driver for Linux."
> 
> Provide a simple fix by replacing this occurrence with general comment
> format, i.e. '/*', to prevent kernel-doc from parsing it.
> 
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/crypto/chelsio/chcr_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/chelsio/chcr_core.c b/drivers/crypto/chelsio/chcr_core.c
> index f91f9d762a45..f03ef4a23f96 100644
> --- a/drivers/crypto/chelsio/chcr_core.c
> +++ b/drivers/crypto/chelsio/chcr_core.c
> @@ -1,4 +1,4 @@
> -/**
> +/*
>   * This file is part of the Chelsio T4/T5/T6 Ethernet driver for Linux.
>   *
>   * Copyright (C) 2011-2016 Chelsio Communications.  All rights reserved.
> 


-- 
~Randy

