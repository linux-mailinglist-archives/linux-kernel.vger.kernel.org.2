Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A25D316508
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 12:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhBJLUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 06:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbhBJLOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 06:14:02 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72A8C061756
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 03:13:21 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id q8so1961115wru.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 03:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ylXnAL5nrH5hqi9xQ5ruoY6NoTAGtDS//0pow3R9ejA=;
        b=cOaVoTLjKniO1+RCwXhpMGs84QivJKe+H6b5qbRUsbbX2ZvlfKzH0m0ML7u2JjRcYR
         ZHrnJ1esZKsOovCoHlv1tghQ0ZsHX4VZ+iuiLoBXuBUb6hghtq0VTJKn98ZIssC3bWI7
         PM2DBOmL30Jk18AQ5Dh774BnWXBKrnInWULmYdscr9XsxPeXGfh1tUOF2GampKCHk6vj
         CCwmNu4X25uhE8POOnS9c9LAepl+aPE+Of0qTBN2ZjXoDU/Zniv6JbnLdfTrNtN6J7NQ
         JqAD/uuvhnwAWpMPqk0ipYAVOgkJnHgWuEFp2OMKJ1YuGwB6fndynO28dRJ/eUGGmxye
         z7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ylXnAL5nrH5hqi9xQ5ruoY6NoTAGtDS//0pow3R9ejA=;
        b=YhTIdaJqHNnhLFKTURXgXnLr9obnFh4s8qks6nhvaNEmXXEIVSv8Kr40UXYu8IMX0v
         iWMLY+59yP+yupQukk1GXCyZDUj4ffAAwEK038+V7pyUFINNZSCwmJ7FQ0Z4KX1Ih0cu
         nnetei8GqhzKZXM+uvVY2Y2WdtvwCd338+tH9mopvBVeUYqgDYbkEKlNyMLhDPSC9smY
         DzpoHQnnic/Oz3hxjT4JghbBxxItdJWSupjyVDTMwhT3tfB3VRE8kBJZFK+av+Y8VkmS
         nrsad0Sl2ouqMpTcRgQgKumW27xws3MSUl4GzWxUWKjcKHjQeEuf+RoM+0EbhKf5Yqsk
         PlFg==
X-Gm-Message-State: AOAM5308N6Oa3uMQWr8yu+RIbM3ePH7/sl04bC5VbiH6JrFp64SEQDSN
        qYzEIs4igC8blSISxyo9b7ffmw==
X-Google-Smtp-Source: ABdhPJyVVSnriCmXHzlRk6cnZ/zh6Yhl8PjsKY+iqzqXmo6MMtWlIAbLci0odQfdo7kn5d7h56p2ig==
X-Received: by 2002:adf:92a6:: with SMTP id 35mr3050131wrn.193.1612955600544;
        Wed, 10 Feb 2021 03:13:20 -0800 (PST)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id t6sm1976264wmj.22.2021.02.10.03.13.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Feb 2021 03:13:19 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 1/2] bfq: remove some useless logic of
 bfq_update_next_in_service()
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1611917485-584-1-git-send-email-brookxu@tencent.com>
Date:   Wed, 10 Feb 2021 12:13:29 +0100
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B4751549-78D9-4A84-8FB2-5DAA86ED39C8@linaro.org>
References: <1611917485-584-1-git-send-email-brookxu@tencent.com>
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
> The if statement at the end of the function is obviously useless,
> maybe we can delete it.
>=20

Thanks for spotting this mistake.

Acked-by: Paolo Valente <paolo.valente@linaro.org>

> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
> ---
> block/bfq-wf2q.c | 3 ---
> 1 file changed, 3 deletions(-)
>=20
> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> index 26776bd..070e34a 100644
> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -137,9 +137,6 @@ static bool bfq_update_next_in_service(struct =
bfq_sched_data *sd,
>=20
> 	sd->next_in_service =3D next_in_service;
>=20
> -	if (!next_in_service)
> -		return parent_sched_may_change;
> -
> 	return parent_sched_may_change;
> }
>=20
> --=20
> 1.8.3.1
>=20

