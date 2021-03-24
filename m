Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50922347FC3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 18:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237207AbhCXRsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 13:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237048AbhCXRrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 13:47:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347B1C061763;
        Wed, 24 Mar 2021 10:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=Fe2Ntedj1fEygPskrv8dOfCakXuESrZ2efaZ4udfr00=; b=Nz9W58huRMptcMqar1qWusPP8x
        WbBiSxSxCx7r3sRMO79QKM/JJ9tIdVyagEAoHazgqR+LVnZKbD7S5wbP+uxVNcEX5VzTL01rfBWB+
        5y31FiAhfLQK8yFBx3D2xRspfc1TIKkGEc58z1rLY7dfQkpF7XbsO+QyX8e5EgYj3zc295QDVNcxn
        SvZW6ZyhGstCjL88jh8fKrqqdATFODyGaKuoDmsDHMF/oesZJIIKRSPKeTehz+BZHdSUJl9Z8Qo5H
        Cz3HUPRMThpLUJko3I4+gokI3QcpyzPvXABQXDSd4mWdlYpjM/ajH5g47qA2E4QrYCadGsYGggWVu
        4Xjdy3Vw==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lP7aI-00BeGN-Jz; Wed, 24 Mar 2021 17:46:30 +0000
Subject: Re: [PATCH] docs: rbtree.rst: Fix a typo
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, corbet@lwn.net,
        walken@google.com, grandmaster@al2klimov.de, willy@infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210324080046.20709-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5ea2fe0d-1013-d526-b3d4-47fdcfa8f396@infradead.org>
Date:   Wed, 24 Mar 2021 10:46:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210324080046.20709-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/21 1:00 AM, Bhaskar Chowdhury wrote:
> 
> s/maintanence/maintenance/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  Documentation/core-api/rbtree.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/core-api/rbtree.rst b/Documentation/core-api/rbtree.rst
> index 6b88837fbf82..ed1a9fbc779e 100644
> --- a/Documentation/core-api/rbtree.rst
> +++ b/Documentation/core-api/rbtree.rst
> @@ -201,7 +201,7 @@ search trees, such as for traversals or users relying on a the particular
>  order for their own logic. To this end, users can use 'struct rb_root_cached'
>  to optimize O(logN) rb_first() calls to a simple pointer fetch avoiding
>  potentially expensive tree iterations. This is done at negligible runtime
> -overhead for maintanence; albeit larger memory footprint.
> +overhead for maintenance; albeit larger memory footprint.
> 
>  Similar to the rb_root structure, cached rbtrees are initialized to be
>  empty via::
> --


-- 
~Randy

