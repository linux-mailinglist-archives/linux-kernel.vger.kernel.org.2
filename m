Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816D03D140D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 18:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbhGUPoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 11:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234504AbhGUPnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 11:43:12 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B399C0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 09:23:39 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id p9so1964813pjl.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 09:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Kjj8+BH+iUI89w/Sp2sMFJ5Avc7T3JxTFrtEGyjxaBQ=;
        b=XXNG8+7HGwsUlnbqf8ot4dPVWPtCkTgNVpc6SdD8Z6243I+AAwPeuM/4e8DFu0Ymuh
         7mM0JIoTEzMZhOhgrbRTqQU4InFQJZ6OD5YkXSAp91wa0pJdL/7UQ74UN0xSRhu5PlKP
         DF5haisPbTop21XhxVvV05N7efTm6TIFPaQ3GeVLRnqV+BDqo6OEXL+lLjeoVZKJib4o
         ciF7VJtDesOdE9vODJeu/2I6V282VsCoyiAQsIRVYD98zt6SAm1SCOcFklwxWfs5Tiwz
         G1T1o4AAqw//GrUi7t/Xost+6+6jmjVspJ+N8HkoEuqiQjA3ANqylYu7CK2Ymm7SyCnM
         b+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Kjj8+BH+iUI89w/Sp2sMFJ5Avc7T3JxTFrtEGyjxaBQ=;
        b=cvmfKQXsiAt7h5ep1gBR3sty6lIVXfYCc4K+k9eFwX4WFo+Tvlqi5WvHhZ02rTLoxu
         kAC7tSx4Mlda/cjLZToBXe3V0NpVENGezRXYmMLe2nX5IkCm4QvFndnAOhmk/BBx/p7s
         aBFYqevfZouEZMnz/9ELH0zFJz4rM2Cw4xqdXVrWhTpON+rSisxSZic4Qp/fiTpgz22L
         +JkA6btMoeKV65ssW3GYqRadgyR9WOjQ8xxdG6QpkLdcWFDsgif/17VpYA8vw1zaD9K4
         IjAcEwKJMDeC+VvIGHMj90MvoB+w8HewbVDMTQREOjnWgCe7AFdgsyNcRoGAuQSnmTF3
         ICgg==
X-Gm-Message-State: AOAM531sTsgEjeTJuuyzajP6KfcDsNP4uiCwxcNTsii7UgaWxo4Am96l
        9qVp8lfbMVRKDKAAhoWap2U=
X-Google-Smtp-Source: ABdhPJzavn8LoNNZYmxpFB8ggvHg4463++MMw2UNZJgauIsy7a1eTUsgWl1x8zvR9EtUAJIMVcQtJA==
X-Received: by 2002:a17:90a:fe93:: with SMTP id co19mr33913094pjb.206.1626884618413;
        Wed, 21 Jul 2021 09:23:38 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e9f1])
        by smtp.gmail.com with ESMTPSA id v69sm28426072pfc.118.2021.07.21.09.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 09:23:37 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 21 Jul 2021 06:23:33 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] workqueue: Fix possible memory leaks in wq_numa_init()
Message-ID: <YPhKBdW2mvttWAB8@mtj.duckdns.org>
References: <20210719065914.3801-1-thunder.leizhen@huawei.com>
 <CAJhGHyC-PzzjSmtEnvOkXNJkn5p2oejk8ctyan3r5AxP-G+O-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyC-PzzjSmtEnvOkXNJkn5p2oejk8ctyan3r5AxP-G+O-A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 04:49:05PM +0800, Lai Jiangshan wrote:
> Hello, Tejun
> 
> I think it would be better to fix it.
> There have been several tries, sorted by date:
> 
> https://lore.kernel.org/lkml/1418379595-6281-2-git-send-email-laijs@cn.fujitsu.com/
> https://lore.kernel.org/lkml/1442457835-24238-1-git-send-email-xlpang@126.com/
> https://lore.kernel.org/lkml/1452170339-26748-3-git-send-email-wanghaibin.wang@huawei.com/
> https://lore.kernel.org/lkml/1533518439-3982-1-git-send-email-wang.yi59@zte.com.cn/
> 
> And this one.

Yeah, idk. It's not an actual bug tho. Maybe we should just add a comment.
Which version do you like the best?

Thanks.

-- 
tejun
