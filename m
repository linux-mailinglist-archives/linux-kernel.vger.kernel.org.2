Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4908735074E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 21:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbhCaTS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 15:18:57 -0400
Received: from ms.lwn.net ([45.79.88.28]:47136 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235869AbhCaTSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 15:18:49 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A83D8867;
        Wed, 31 Mar 2021 19:18:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A83D8867
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1617218328; bh=uUdYN1HYmQG9GBnU+mLM9YIUYYzSXPB93zGZVl/NjLE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=fIkXgpG4WzcfmE1YaIGP2731AVrvb7IiXur4KQrAzxWmKZbj0m6n8EghQiOhC35KZ
         0LimCzphYHMwoMOpovcCUKzrnoMpyWcnjGqzK9oaFMZvvwTNoQ+HY5lzTI3FM7YjiT
         2Ak6OEq/EQPf24ThtHUsC/N7RbCz6yZQ1wV4frT+L9Zts/jHpZvyjSXbOqIGjIIs0i
         gx3quIRbxKmIIWwTVXR48a9DOg+m+F+B5QfBXNI/tJOxSOKy8SGsq2EDX2GtgU7TCx
         9E/sk5MPc1hedfUzdM6Vofmr6QyiizAXx61xGYAnhdMKe3/XpTJKshFMnJqmoebkm7
         D+j2hV2VzeQrg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Harry Wei <harryxiyou@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] docs: Remove make headers_check from checklist in
 translations
In-Reply-To: <CAK7LNAQUHbBgJdAtfqzn=X5f_+Nram00VtMQfZwOQdYLCygChA@mail.gmail.com>
References: <20210302141822.504773-1-masahiroy@kernel.org>
 <CAK7LNAQUHbBgJdAtfqzn=X5f_+Nram00VtMQfZwOQdYLCygChA@mail.gmail.com>
Date:   Wed, 31 Mar 2021 13:18:38 -0600
Message-ID: <87o8ezku7l.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada <masahiroy@kernel.org> writes:

> Hi Jon,
>
>
> On Tue, Mar 2, 2021 at 11:19 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>>
>> Commit 1a63f9cce7b7 ("docs: Remove make headers_check from checklist")
>> fixed only the English version.
>>
>> Let's fix the translated variants too.
>>
>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> ping?

Hmm...somehow that went through the cracks..perhaps I thought it looked
like one of the patches you tend to apply yourself.

Anyway, applied now, apologies for the delay.

Thanks,

jon
