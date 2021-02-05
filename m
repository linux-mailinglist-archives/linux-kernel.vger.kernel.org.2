Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533BC3101EA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 02:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbhBEA6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 19:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbhBEA55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 19:57:57 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA53C06178A
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 16:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=taptAJZGVKhfjl8ozXfnK9asETcneiqziSs3CSxtFhA=; b=g8iPGKLlFaBXUCALRtfaF9+wZD
        h52jb08lSpIqM2riFRo9zpg6IQAbiUok5OI6xVtNHxjoUgIluzA5j5lORtyeLplRNJhpkqEgpg18T
        /McpJ6otH7Ygr2cl8SVWcwI0k+fa416JxiYEK6GmaLyMkpaMEJh4Td2GvvaSziGHhjbDd7W5gNZcb
        LC+XNg6sGFRBxjgZ5VCJB6V1RyyYFaJi6gOXWopfjdjK+O5Q2Rj9PFGH1Fh1CAqBXXx6ELBu5FaSw
        tQcneTYbATb+l7VeWWb4ihQQxqUm0e9a0BH2qf9WsHkUH/FcyzJjAxy2EvDqgDmdvWb4TGgIj1gxK
        c5Y/J5CA==;
Received: from [2601:1c0:6280:3f0::aec2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7pQv-0002t1-Q9; Fri, 05 Feb 2021 00:57:14 +0000
Subject: Re: [PATCH] lib: crc-itu-t: Fix comment in typo
To:     David Mosberger-Tang <davidm@egauge.net>,
        Jiri Kosina <trivial@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <20210205004636.477935-1-davidm@egauge.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0e0976ef-42a1-880d-2ec0-d22632004ff9@infradead.org>
Date:   Thu, 4 Feb 2021 16:57:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210205004636.477935-1-davidm@egauge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/21 4:47 PM, David Mosberger-Tang wrote:
> Signed-off-by: David Mosberger-Tang <davidm@egauge.net>
> ---
>  lib/crc-itu-t.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/crc-itu-t.c b/lib/crc-itu-t.c
> index 1974b355c148..56e6e0d63d1e 100644
> --- a/lib/crc-itu-t.c
> +++ b/lib/crc-itu-t.c
> @@ -7,7 +7,7 @@
>  #include <linux/module.h>
>  #include <linux/crc-itu-t.h>
>  
> -/** CRC table for the CRC ITU-T V.41 0x1021 (x^16 + x^12 + x^15 + 1) */
> +/** CRC table for the CRC ITU-T V.41 0x1021 (x^16 + x^12 + x^5 + 1) */

This comment should not be indicated as kernel-doc:
please use /* instead of /**.

>  const u16 crc_itu_t_table[256] = {
>  	0x0000, 0x1021, 0x2042, 0x3063, 0x4084, 0x50a5, 0x60c6, 0x70e7,
>  	0x8108, 0x9129, 0xa14a, 0xb16b, 0xc18c, 0xd1ad, 0xe1ce, 0xf1ef,
> 

thanks.
-- 
~Randy

