Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0A431651E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 12:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhBJLXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 06:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhBJLPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 06:15:16 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE412C06121E
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 03:13:51 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id l12so2044289wry.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 03:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rlVxGUSSPCJtH0H34sD4Kgdi20pfZGhuTsAdOvhOScI=;
        b=hvReQJDXBsrRJfdRH2bscBqaQXtTTFgZaPB7ropsz3LUu1SVLvTMDuml8DsTeuuc2F
         NZMT+V7+TPavglEtqu2+hkrzX1iM8HspbHuYsjgdwJ8r9qNWjlSaYdhvRVBxQW70ruxl
         1Rdfw8kjAqi61NDWfyYolBZ91sPgmAhg9QUaGQZqRUp7FgwcfdOnDQ0937PZ8SO0S0ad
         5oUC9QCD+93OZHz2tRixnkU/iLLQKOJjUdkTbEbuqkMKZHzcM81amSzzVoQ5hN63Whma
         HO4VefHoCB2vFtYjAcINEXvh70rh93hfspDAT4ZvAXuuj+yYP6gpTVfvZy74twNhHYtd
         b+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rlVxGUSSPCJtH0H34sD4Kgdi20pfZGhuTsAdOvhOScI=;
        b=q7XrWov49DUDQwxZxgGnu0CfjjlhYdo1vKaq8Z1rFRi5EnlFRZ553TEHdEVHtsGd0z
         XTvP064A6mQHGc8S7JXm+hVLoNAHvaAlyhg6Ieub2Jv5Ais/w21ON8mUvGEMjee2C4pX
         KJt17wPhdOxn3uMAw2akHdNW4xrFT+fFwPEnV18/l+e4mP7wvWY+w9obj7GZcfZi7S1U
         /Jon035Xf4ZsGMQ1O6I/wXNlpe4rxX+mrA5c/FadtwfH3CNN0MyMrjeZFbJavtpg8nQL
         Lhfm8X9Dw8bKz+rVsu73xq7zyC9Q22l4TFBr9pyyzNOIElV3VyPngokJsoqq49TCbSXf
         5+eA==
X-Gm-Message-State: AOAM53225yiKC86GN6MqukQ7VgieKB56hgX4625YD9ACKxHak/msg6JE
        ss2U37wysGDS2HDnZOtA1ftm5ZxLDu6Uwg==
X-Google-Smtp-Source: ABdhPJzifeUZriIOvo4cDKBY9VmccxjV3W7Obwczmt928UBOjqMcey5uOMdkRLCCerxXQx6AxaYKSA==
X-Received: by 2002:a5d:6b45:: with SMTP id x5mr2940604wrw.415.1612955630588;
        Wed, 10 Feb 2021 03:13:50 -0800 (PST)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id t6sm1976264wmj.22.2021.02.10.03.13.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Feb 2021 03:13:49 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 2/2] bfq: amend the function name of
 bfq_may_expire_for_budg_timeout()
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1611917485-584-2-git-send-email-brookxu@tencent.com>
Date:   Wed, 10 Feb 2021 12:13:59 +0100
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0A676DC9-E730-460A-8C39-9E1851343339@linaro.org>
References: <1611917485-584-1-git-send-email-brookxu@tencent.com>
 <1611917485-584-2-git-send-email-brookxu@tencent.com>
To:     Chunguang Xu <brookxu.cn@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 29 gen 2021, alle ore 11:51, Chunguang Xu =
<brookxu.cn@gmail.com> ha scritto:
>=20
> From: Chunguang Xu <brookxu@tencent.com>
>=20
> The function name bfq_may_expire_for_budg_timeout() may be misspelled,
> try to fix it.
>=20

Ok for me to make this name longer.

Thanks,
Paolo

> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
> ---
> block/bfq-iosched.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 9e4eb0f..4f40c61 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -4061,7 +4061,7 @@ static bool bfq_bfqq_budget_timeout(struct =
bfq_queue *bfqq)
>  * condition does not hold, or if the queue is slow enough to deserve
>  * only to be kicked off for preserving a high throughput.
>  */
> -static bool bfq_may_expire_for_budg_timeout(struct bfq_queue *bfqq)
> +static bool bfq_may_expire_for_budget_timeout(struct bfq_queue *bfqq)
> {
> 	bfq_log_bfqq(bfqq->bfqd, bfqq,
> 		"may_budget_timeout: wait_request %d left %d timeout =
%d",
> @@ -4350,7 +4350,7 @@ static struct bfq_queue *bfq_select_queue(struct =
bfq_data *bfqd)
> 	 * on the case where bfq_bfqq_must_idle() returns true, in
> 	 * bfq_completed_request().
> 	 */
> -	if (bfq_may_expire_for_budg_timeout(bfqq) &&
> +	if (bfq_may_expire_for_budget_timeout(bfqq) &&
> 	    !bfq_bfqq_must_idle(bfqq))
> 		goto expire;
>=20
> @@ -5706,7 +5706,7 @@ static void bfq_completed_request(struct =
bfq_queue *bfqq, struct bfq_data *bfqd)
> 			 * of its reserved service guarantees.
> 			 */
> 			return;
> -		} else if (bfq_may_expire_for_budg_timeout(bfqq))
> +		} else if (bfq_may_expire_for_budget_timeout(bfqq))
> 			bfq_bfqq_expire(bfqd, bfqq, false,
> 					BFQQE_BUDGET_TIMEOUT);
> 		else if (RB_EMPTY_ROOT(&bfqq->sort_list) &&
> --=20
> 1.8.3.1
>=20

