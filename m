Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A4033F791
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 18:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbhCQRxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 13:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbhCQRxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 13:53:33 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA54C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 10:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=aYVFV5gKlK9NrM1udQPkXFtW/W+FQTYLEDDxN+fuR3Y=; b=qtuOwgjpkJ5q4+lvCodUggX/Ga
        8zqvReH+IJi3dzklaqflIPrl1IiiRa06AUOIhftzD3I6Sn4NiYB/SvtyiYYoIxVqYGD3fOKjrIsaq
        QMSLT9p9v8VZSH0xNtHxvPCwwdqT5eYN7a+3aaQThZDCryJgZMGt2R6GdpG/JFVERT0cv2DvfWHXw
        bak5Y7kgKEMceLi4c9tJlfgV8KnnfSMGr10L/8BXn92EoNZoAVKgiRFp9gXANxPSs69PO1eqJxrl0
        Imx7kUwUFj3dTmVMcgBl5Z3uMLay47n6bWeSg25Zl3TsZfe7qB5tDoF91OEmaPEkrgiv0y8GgqG7/
        x4AoQ8Yw==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMaMM-001feu-CA; Wed, 17 Mar 2021 17:53:31 +0000
Subject: Re: [PATCH] char: Fix a typo in the file random.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, tytso@mit.edu,
        linux-kernel@vger.kernel.org
References: <20210317094822.1630276-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e24ca67e-26d7-0293-53ad-98f0d4021ed6@infradead.org>
Date:   Wed, 17 Mar 2021 10:53:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210317094822.1630276-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/21 2:48 AM, Bhaskar Chowdhury wrote:
> 
> s/progams/programs/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  drivers/char/random.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 0fe9e200e4c8..afb0195e06f3 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -763,7 +763,7 @@ static DECLARE_WAIT_QUEUE_HEAD(crng_init_wait);
> 
>  #ifdef CONFIG_NUMA
>  /*
> - * Hack to deal with crazy userspace progams when they are all trying
> + * Hack to deal with crazy userspace programs when they are all trying
>   * to access /dev/urandom in parallel.  The programs are almost
>   * certainly doing something terribly wrong, but we'll work around
>   * their brain damage.
> --


-- 
~Randy

