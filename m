Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65BEA42EFF5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 13:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238545AbhJOLxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 07:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235134AbhJOLxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 07:53:53 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6FEC061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 04:51:47 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id d131so22115144ybd.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 04:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ISTv0g6D9fhNjnXuPb8elc1/Pv66oLGmzG/MkG3iCpw=;
        b=W6BsCALVsxLKKqkF0hEWmcJazhFtnvXIErEpzuHukxRn9a/x80Qugunr7IYg3nWjTJ
         0UL+qrvcpRYtbKjm+QKrbgoPJ9ua6RSgUYGB/m7T5cI4R8dzydh3UO14NjIQeOuRXsuy
         eQ5zkK9nEYO0b/zPzW2RskDg6EytKHuyC7/B59xzCkb97bmVv5JlTJnCLXUUnDmPStsj
         xGOTbhVPg6GGFZRo7pl1UvfD4zg/SaHIEx6ZLY7EEyQYvK/W5z9pjIfPWii7PX4RUzqS
         UjiVTprd42y+8xDvY/ZdCIKNCGBN2qqkFdcx/lqXEhj4nt6b8IfLdmRrLZLF1QczmlkA
         yKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ISTv0g6D9fhNjnXuPb8elc1/Pv66oLGmzG/MkG3iCpw=;
        b=gFUGAB4C4t7C/eQtV4hcDVCpd0TwhfbXvJ0mqXFQs9mjiAb3VaUPWLiLJDWT84khGQ
         gArZR1EWP+zIeTf7bdESKGO+heinzJsvj37H7iMIbWO6WgY1RcdpMX/PmvK/rN1zqNIn
         YCdJpjhNc1I3aWRubn0MD0amzKsWtG5tmsxZxH+5bJ1jOC0Mt5c/p4y5dOV8C0vW/k9r
         CYgvZZH+nsgUFv8npSLD2Sq4GDifMQVJ0lJhlgeYfmmEsK+a9niyfR8UEuEQUV7Euk4I
         CtY90sJKudLQi6EyDfutS1GZIKiiTgJEdTsVCPShaF96NMkaYXim8GRIZowoxU1QKL4v
         xa1A==
X-Gm-Message-State: AOAM533ZJjzlEODAGokmv18jXlOqrxtu4hNf0JKGoOrSFCqYWSAYlflD
        1U/h4OASxC7NgCgo1d4h2U+hxVxF9pi3QUBfYBR4fw==
X-Google-Smtp-Source: ABdhPJzyeCnTWEstgInEzx52Q3iEp69ITrU/C0pMmlxFQhZIbVVhr1wNECUo9H6zY1J/9gAZ1fzNzRKb2Ow8FodpsYE=
X-Received: by 2002:a25:7415:: with SMTP id p21mr12550537ybc.78.1634298706161;
 Fri, 15 Oct 2021 04:51:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210928121040.2547407-1-chenwandun@huawei.com>
 <CALvZod4G3SzP3kWxQYn0fj+VgG-G3yWXz=gz17+3N57ru1iajw@mail.gmail.com>
 <8fc5e1ae-a356-6225-2e50-cf0e5ee26208@huawei.com> <1634261360.fed2opbgxw.astroid@bobo.none>
 <d1f7249d-ffc2-7038-ed4c-f7fbb3e68eda@huawei.com> <1634281763.ecsq6l88ia.astroid@bobo.none>
In-Reply-To: <1634281763.ecsq6l88ia.astroid@bobo.none>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 15 Oct 2021 04:51:34 -0700
Message-ID: <CANn89i+RoCSBB=st4yDoWCHDkPCw2OTgbKUeXKRC8ixFLjx4TQ@mail.gmail.com>
Subject: Re: [PATCH] mm/vmalloc: fix numa spreading for large hash tables
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Chen Wandun <chenwandun@huawei.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        guohanjun@huawei.com, LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 12:11 AM Nicholas Piggin <npiggin@gmail.com> wrote:

> Okay. It would be better to do it as two patches. First the minimal fix
> so it can be backported easily and have the Fixes: tag pointed at my
> commit. Then the performance optimization.
>

+2, we need a small fix for stable branches.

Thanks

> Thanks,
> Nick
