Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648EB33F6C0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 18:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhCQR1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 13:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbhCQR0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 13:26:54 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF6EC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 10:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=vDj5QLKIY3+m6sVOEX2/jPJ7XcnGNcq6gqehl799e4E=; b=G6KhVHbQM3vbUK+ZBzGCp55hmc
        BnZihHW468IxB3IqHulkTPnoU6ZSbePHcPe4BovE3fcWm1oDTvJWXw6jkr4VS6FGuNZxcbGMjvWxV
        5qC+BUNHXHOGHyPbjrSTiLdb4ic4r44T9fYeWXjRQfmzinkOzFKRsywbWfSXPkthXlztNYyg4I9ku
        Is/Efy12OaPvKk66k6L/xsUpFTP+c5T2eC8wivoHonuxl1f64Fof4DUoOb4EDfjNjB6l1H9c1eCe8
        Va9j+dS1Zr7q2LkitVoLhUKn6c04UI4NNc283SEU8ISGYi4/aHb67pcpeJxFDx1G+DITWz9/KnMuo
        JElq35MQ==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMZwY-001fQE-Is; Wed, 17 Mar 2021 17:26:50 +0000
Subject: Re: [PATCH V2] kernel: debug: Ordinary typo fixes in the file
 gdbstub.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        jason.wessel@windriver.com, daniel.thompson@linaro.org,
        dianders@chromium.org, kgdb-bugreport@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20210317104658.4053473-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f7f9fc7f-3e6d-b9a8-b854-620d928b1f24@infradead.org>
Date:   Wed, 17 Mar 2021 10:26:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210317104658.4053473-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/21 3:46 AM, Bhaskar Chowdhury wrote:
> s/overwitten/overwritten/
> s/procesing/processing/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
> Changes from V1:
>  As Daniel pointed out, I was misdoing a check,so corrected
> 
>  kernel/debug/gdbstub.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
> index e149a0ac9e9e..8372897402f4 100644
> --- a/kernel/debug/gdbstub.c
> +++ b/kernel/debug/gdbstub.c
> @@ -321,7 +321,7 @@ int kgdb_hex2long(char **ptr, unsigned long *long_val)
>  /*
>   * Copy the binary array pointed to by buf into mem.  Fix $, #, and
>   * 0x7d escaped with 0x7d. Return -EFAULT on failure or 0 on success.
> - * The input buf is overwitten with the result to write to mem.
> + * The input buf is overwritten with the result to write to mem.
>   */
>  static int kgdb_ebin2mem(char *buf, char *mem, int count)
>  {
> @@ -952,7 +952,7 @@ static int gdb_cmd_exception_pass(struct kgdb_state *ks)
>  }
> 
>  /*
> - * This function performs all gdbserial command procesing
> + * This function performs all gdbserial command processing
>   */
>  int gdb_serial_stub(struct kgdb_state *ks)
>  {
> --


-- 
~Randy

