Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E98B316A03
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 16:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbhBJPVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 10:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbhBJPV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 10:21:27 -0500
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB455C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 07:20:44 -0800 (PST)
Received: from localhost (kaktus.kanapka.ml [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id BC2759831BB;
        Wed, 10 Feb 2021 16:20:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1612970434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q7ojA/KR388M4BV02zdLByuP79wkh35otkGQ4vyB7ZU=;
        b=lK9/GiRGp/fcBjlVdIqebCIqSnbX5jE4cQSwlBYXEAzJS5N0erF23SmD4O6EWsxKn5pNlN
        VxJBMrmzISL2qjtKbdiHIqPQjWvztoH7hMjVot4OEssXAlz703DtS2R9qZO41xFEtJagTA
        BXC1jTzGBmP+ORweuhO0bfkysVzKKjA=
Date:   Wed, 10 Feb 2021 16:20:34 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Chunguang Xu <brookxu.cn@gmail.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] bfq: remove some useless logic of
 bfq_update_next_in_service()
Message-ID: <20210210152034.puimoewzgtnnp2zl@spock.localdomain>
References: <1611917485-584-1-git-send-email-brookxu@tencent.com>
 <B4751549-78D9-4A84-8FB2-5DAA86ED39C8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B4751549-78D9-4A84-8FB2-5DAA86ED39C8@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 12:13:29PM +0100, Paolo Valente wrote:
> 
> 
> > Il giorno 29 gen 2021, alle ore 11:51, Chunguang Xu <brookxu.cn@gmail.com> ha scritto:
> > 
> > From: Chunguang Xu <brookxu@tencent.com>
> > 
> > The if statement at the end of the function is obviously useless,
> > maybe we can delete it.
> > 
> 
> Thanks for spotting this mistake.
> 
> Acked-by: Paolo Valente <paolo.valente@linaro.org>
> 
> > Signed-off-by: Chunguang Xu <brookxu@tencent.com>
> > ---
> > block/bfq-wf2q.c | 3 ---
> > 1 file changed, 3 deletions(-)
> > 
> > diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> > index 26776bd..070e34a 100644
> > --- a/block/bfq-wf2q.c
> > +++ b/block/bfq-wf2q.c
> > @@ -137,9 +137,6 @@ static bool bfq_update_next_in_service(struct bfq_sched_data *sd,
> > 
> > 	sd->next_in_service = next_in_service;
> > 
> > -	if (!next_in_service)
> > -		return parent_sched_may_change;
> > -

Unless I'm missing something, this has already been fixed here:

https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.12/block&id=1a23e06cdab2be07cbda460c6417d7de564c48e6

> > 	return parent_sched_may_change;
> > }
> > 
> > -- 
> > 1.8.3.1
> > 
> 

-- 
  Oleksandr Natalenko (post-factum)
