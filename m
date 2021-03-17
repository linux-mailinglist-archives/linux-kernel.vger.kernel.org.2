Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C968933F6A3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 18:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbhCQRWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 13:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbhCQRVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 13:21:43 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9485C06174A;
        Wed, 17 Mar 2021 10:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=bXtH3POBG9ts1jOXokUaPXgQERIp/+u738KvYgy6+H4=; b=l4ILtQkJ3cZoo8mL5nPYoN81Dt
        htomJrreX64A6nziTEBmi4IciEQdSOvKoJ+/DKBqbpJw/PPHxx//HOp4s7QUtMu/MnQA+M0VeKXvm
        mbKEt4jrE2IowOhv6RUyRGtDaqHbpYlVO+Z+BgNIGiuc3NX9hvVm9MBg26LcRoWRWQx77kwZFb2Q7
        yLg+B9CZJhsgBAd7ut7vXjkUphx1DOWbQTTj9ICN5Z1VzJZbTinfe0QeLu8W2oUP8A+dvMJjj/Ifx
        iT8IWNWDPqMcChTUPnf1lr/bcl6i5E6aHuQYep+Dqg1GfKPsfPbD1Y2iGLV3ooAbuihOBB5jN93kz
        0/cUcCEw==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMZrY-001fNC-DP; Wed, 17 Mar 2021 17:21:40 +0000
Subject: Re: [PATCH] parisc: math-emu: Fix a typo in the file float.h
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        James.Bottomley@HansenPartnership.com, deller@gmx.de,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210317103917.3869933-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ec8744a7-66dc-b687-5471-7da4411084c8@infradead.org>
Date:   Wed, 17 Mar 2021 10:21:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210317103917.3869933-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/21 3:39 AM, Bhaskar Chowdhury wrote:
> 
> s/synopis/synopsis/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  arch/parisc/math-emu/float.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/parisc/math-emu/float.h b/arch/parisc/math-emu/float.h
> index 531bbda5e31f..77b1b5bf1a65 100644
> --- a/arch/parisc/math-emu/float.h
> +++ b/arch/parisc/math-emu/float.h
> @@ -12,7 +12,7 @@
>   *      @(#)	pa/spmath/float.h		$Revision: 1.1 $
>   *
>   *  Purpose:
> - *      <<please update with a synopis of the functionality provided by this file>>
> + *      <<please update with a synopsis of the functionality provided by this file>>
>   *
>   *  BE header:  no
>   *
> --


-- 
~Randy

