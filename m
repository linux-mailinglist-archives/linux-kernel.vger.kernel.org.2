Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5F033F72D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 18:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhCQRfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 13:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbhCQRfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 13:35:38 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C79C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 10:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=e1aFEf0jTKxTqtUnzApuTgt89lxp2sYlb3+/AG+krOQ=; b=AIwl+zpdAmRyINLbrAL3NLiZh6
        NBSupKWdmRTFqGybhiA5sUdSBiumWZeXoXF//bG4ccvUifZOH1a9V5/KBuWSCXblr7ebAjz9eMHs0
        1yEX4EtGzlnmI04TfXe+oTHnmRyOHdOjq/dgXXDhcn+c3AbAIVPbW980UCdjsdy0hhJ+TxS8qRA6c
        OR0Kf0ybnN/5SCnl5xRvddPGbRtZWTVTaveIFK8Ww2yzPQ7Xm0H8nx/GZVF3JuDdbDmVkZOcrUL3I
        agFU3kgmbnPxnBJGAnw5q6r5pLsA9wuVx6iGHJj4eD9LvNf9Sxrg5FJnTSBCLfCKXXoDLFPEgBziF
        KgMJ9+yw==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMa50-001fWf-4I; Wed, 17 Mar 2021 17:35:35 +0000
Subject: Re: [PATCH] staging: wimax: i2400m: Mundane typo fix in the file
 driver.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        gregkh@linuxfoundation.org, colin.king@canonical.com,
        davem@davemloft.net, johannes@sipsolutions.net, arnd@arndb.de,
        lee.jones@linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20210317092624.1138207-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <971c14bd-e755-d1cf-b518-c889e5348f11@infradead.org>
Date:   Wed, 17 Mar 2021 10:35:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210317092624.1138207-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/21 2:26 AM, Bhaskar Chowdhury wrote:
> 
> s/procesing/processing/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  drivers/staging/wimax/i2400m/driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/wimax/i2400m/driver.c b/drivers/staging/wimax/i2400m/driver.c
> index f5186458bb3d..8091106212f9 100644
> --- a/drivers/staging/wimax/i2400m/driver.c
> +++ b/drivers/staging/wimax/i2400m/driver.c
> @@ -96,7 +96,7 @@ MODULE_PARM_DESC(barkers,
>   *
>   * This function just verifies that the header declaration and the
>   * payload are consistent and then deals with it, either forwarding it
> - * to the device or procesing it locally.
> + * to the device or processing it locally.
>   *
>   * In the i2400m, messages are basically commands that will carry an
>   * ack, so we use i2400m_msg_to_dev() and then deliver the ack back to
> --


-- 
~Randy

