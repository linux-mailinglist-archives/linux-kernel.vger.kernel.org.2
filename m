Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB393393D4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 17:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbhCLQnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 11:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbhCLQnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:43:01 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B1AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 08:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=DdN12y8wew+vZHpjKJtDD1enNtaDHjC1Mg2RbmuJ80M=; b=lWS3dw4aHMJnZqoZ3fkNkSwd66
        vUX0mszaoHHZ4s+57TcHvsYFPCEXBilwlMlBoEXZ1KBFc9+Ff92W+tiHavdWcdT/b1PLN4MB4ME9F
        YKXIkEu51hIECOiuAJY5fJzVjQC6IeAj1v35MYAk38+GYdEsAJYyjcRN1YeRhjunlCWbgK1/gU8E0
        pC7Bsh3ddMCzrUVKg4srxF3vkOsZhrghElhGfKc4PknKYSlyVsfrLV9X+sshKehnt7XEnzLqSrpZK
        wp6hbNqiTJvcKDUZxGHHaaUwxL2CY2mPe8d79jALo7JdS9twXiY7WI88bZEbaBBsGmm/fAQYVkkFU
        1GUPduAg==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKksM-0014Jd-5G; Fri, 12 Mar 2021 16:42:58 +0000
Subject: Re: [PATCH] staging: wimax: i2400m: Mundane typos fix in the file
 tx.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        gregkh@linuxfoundation.org, arnd@arndb.de, lee.jones@linaro.org,
        kuba@kernel.org, johannes@sipsolutions.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20210312114207.3624-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a6d52732-917c-c679-d7be-6454b316ea40@infradead.org>
Date:   Fri, 12 Mar 2021 08:42:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210312114207.3624-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/21 3:42 AM, Bhaskar Chowdhury wrote:
> 
> s/exahusted/exhausted/
> s/caleed/called/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  drivers/staging/wimax/i2400m/tx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/wimax/i2400m/tx.c b/drivers/staging/wimax/i2400m/tx.c
> index e9436212fe54..2d15de653951 100644
> --- a/drivers/staging/wimax/i2400m/tx.c
> +++ b/drivers/staging/wimax/i2400m/tx.c
> @@ -85,7 +85,7 @@
>   *       can keep adding payloads to it.
>   *
>   *     Closed: we are not appending more payloads to this TX message
> - *       (exahusted space in the queue, too many payloads or
> + *       (exhausted space in the queue, too many payloads or
>   *       whichever).  We have appended padding so the whole message
>   *       length is aligned to i2400m->bus_tx_block_size (as set by the
>   *       bus/transport layer).
> @@ -295,7 +295,7 @@ enum {
>  /*
>   * Calculate how much tail room is available
>   *
> - * Note the trick here. This path is ONLY caleed for Case A (see
> + * Note the trick here. This path is ONLY called for Case A (see
>   * i2400m_tx_fifo_push() below), where we have:
>   *
>   *       Case A
> --


-- 
~Randy

