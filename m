Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2397033F813
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 19:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbhCQSZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 14:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbhCQSYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 14:24:49 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EC2C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 11:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=OFyI6+d5Ptggwy4AtXfCcuKvXAU8TbqKYJaYL9keQ40=; b=UEQc5ZFnqxr0zSaGf6UIoKzVPg
        BdbA3TlQifcaAq9b5g/F3ef4HNHFjAzFEE/yl9O62kGDBb6wA1f7GjhbdSZFmMCyqJm3fq+WP21nO
        Gze0BgN5+lWY5J5WpxwQbCp6vWVRaVaH1fnkNIHOVzPbCdQM/AY37yxM3/Ub343AtElafGI1cgj6V
        CMXcbm2pfQKjgMWarIm2O9hTT6BWVaqCSKFQ3kuGv79BMTIGtyvRt81gLaWiRBO/1VSfsbwKHgkZK
        jtb03C/X21KBlxX8Dg8pJjNtt5EMer9jaUjzCpiXcEKaFbfL693wMNfRL6aoGStOvAUlwnfInh3S4
        1wvnFkTQ==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMaqa-001frd-8W; Wed, 17 Mar 2021 18:24:45 +0000
Subject: Re: [PATCH] kernel: trace: Mundane typo fixes in the file
 trace_events_filter.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rostedt@goodmis.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org
References: <20210317095401.1854544-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <30884024-ea9f-f602-d86a-c2f9139b27c4@infradead.org>
Date:   Wed, 17 Mar 2021 11:24:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210317095401.1854544-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/21 2:54 AM, Bhaskar Chowdhury wrote:
> 
> s/callin/calling/
> s/progam/program/
> s/interperate/interpret/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  kernel/trace/trace_events_filter.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> index e91259f6a722..49de3e21e9bc 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -256,7 +256,7 @@ enum {
>   * is "&&" we don't call update_preds(). Instead continue to "c". As the
>   * next token after "c" is not "&&" but the end of input, we first process the
>   * "&&" by calling update_preds() for the "&&" then we process the "||" by
> - * callin updates_preds() with the values for processing "||".
> + * calling updates_preds() with the values for processing "||".
>   *
>   * What does that mean? What update_preds() does is to first save the "target"
>   * of the program entry indexed by the current program entry's "target"
> @@ -296,7 +296,7 @@ enum {
>   * and "FALSE" the program entry after that, we are now done with the first
>   * pass.
>   *
> - * Making the above "a || b && c" have a progam of:
> + * Making the above "a || b && c" have a program of:
>   *  prog[0] = { "a", 1, 2 }
>   *  prog[1] = { "b", 0, 2 }
>   *  prog[2] = { "c", 0, 3 }
> @@ -390,7 +390,7 @@ enum {
>   * F: return FALSE
>   *
>   * As "r = a; if (!r) goto n5;" is obviously the same as
> - * "if (!a) goto n5;" without doing anything we can interperate the
> + * "if (!a) goto n5;" without doing anything we can interpret the
>   * program as:
>   * n1: if (!a) goto n5;
>   * n2: if (!b) goto n5;
> --


-- 
~Randy

