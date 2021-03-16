Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A431333DD10
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 20:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240240AbhCPTEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 15:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbhCPTET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 15:04:19 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F00BC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 12:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=i3w44vElpqaOzl4pzxUXr5h81d686QR3cDbvFGGMtiY=; b=ybBjJn2uJC1snrk5Yk/S56oaQq
        eqTCgaDuWbteqGmDfAvQG8PSNSERYYUfDR3q92+OAcnRy8cLu4ixzOOudBZRKDi+1KQlGBv00XD3v
        uxh1S16Q8e6MPX1Mze2wU6nus5sCV1OJ095aUlmeuuZBMWGmsuByjIuPCFluBQrDRzDm5Doo/F6FJ
        6N7OOaepiGhEi6wePzMLd0bo+vH3k+AlBG0lb+zrPBOAzuPD03v6aYWZwLonvAQo1CSmI5cIwGdLC
        9ZpXWjqmZiMSrHynaqlwylruy8W6RFTVw9WCW1Jj1Coix+NMN0ShzVaOlS+bGH1YY+c2R6NioZomi
        TnL7U8SA==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMEzG-001VzF-Fk; Tue, 16 Mar 2021 19:04:14 +0000
Subject: Re: [PATCH] kernel:sys: Fix typo issue
To:     Xiaofeng Cao <cxfcosmos@gmail.com>, christian.brauner@ubuntu.com,
        akpm@linux-foundation.org
Cc:     walken@google.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Xiaofeng Cao <caoxiaofeng@yulong.com>
References: <20210316112904.10661-1-cxfcosmos@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fb826420-dcf4-9c98-90ec-cec604cb307b@infradead.org>
Date:   Tue, 16 Mar 2021 12:04:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210316112904.10661-1-cxfcosmos@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/21 4:29 AM, Xiaofeng Cao wrote:
> From: Xiaofeng Cao <caoxiaofeng@yulong.com>
> 
> change 'infite'     to 'infinite'
> change 'concurent'  to 'concurrent'
> change 'memvers'    to 'members'
> change 'decendants' to 'descendants'
> change 'argumets'   to 'arguments'
> 
> Signed-off-by: Xiaofeng Cao <caoxiaofeng@yulong.com>
> ---
>  kernel/sys.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 2e2e3f378d97..ecc2f2efc31b 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -1584,7 +1584,7 @@ int do_prlimit(struct task_struct *tsk, unsigned int resource,
>  
>  	/*
>  	 * RLIMIT_CPU handling. Arm the posix CPU timer if the limit is not
> -	 * infite. In case of RLIM_INFINITY the posix CPU timer code
> +	 * infinite. In case of RLIM_INFINITY the posix CPU timer code
>  	 * ignores the rlimit.
>  	 */
>  	 if (!retval && new_rlim && resource == RLIMIT_CPU &&

It would be better to change "posix" to "POSIX" also.

Anyway:
Acked-by: Randy Dunlap <rdunlap@infradead.org>


thanks.
-- 
~Randy

