Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B459449A9E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 18:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbhKHRSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 12:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbhKHRSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 12:18:08 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE45C061714
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 09:15:23 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id i26so30850439ljg.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 09:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rbpdyFuvgnoYbw1vZgGRR04p1YqU09F597l56zKmF5w=;
        b=FdCbgZN5IkZRTACGx4tQGD9MUZfbCwA5BvyKga8l1/thVsThgJm6EHhUaGhiLre9b8
         VZqn5LxxZNoX8nRPRMtTCXeT0KGbklOBxHqTo0FHM8VpeG/2skIx/R+GTTYKp1Vgm57h
         12Orvhq0BPMVrQzkqorerKNGwUAS3ZkCBn1+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rbpdyFuvgnoYbw1vZgGRR04p1YqU09F597l56zKmF5w=;
        b=2domiwAJ5hpqK3fMZAA4fEE5T/WtWGY+t/WQTlJG5hhbefKesKFZS/8nUA9TilXnMG
         2XHyI8UmNAlteP49yLSUH5d/ASYiHxwnB8TEMWXIoInjev5d4JeKQzmXyVuDBZEeAf2e
         SNAndH8uumAgu46T49MtwLNCdd7CevBb+APpaYIDFvZjuIsi3WfXkGypLuDZYmSjwdru
         peINpwA7PRTkEByJ3WLE0/YMlOhUiAl06CVAg3X/xQx1XWcT1kl0vJd/SoGVsIZ3HEzo
         mmrHZP4T9+0QFeRUyhKGVi56UogbYspfO9lwC9qm11T7iuclgaJESluxuYYKTl9YnZ7I
         /yyg==
X-Gm-Message-State: AOAM530HUeZFwmkAcnf0L4ShG/+4w3MPOXlsKJRLop3klTIuF3p9Effs
        uGPTSOvP3sh5Ou18Hbw8mILCQtT0/9bZJbUb
X-Google-Smtp-Source: ABdhPJzNSqqd+Jjxcqmfi/jINtIYoGxCtRpOKSAYQ5DyA4OvGqSCixUE8LHBxFXfe/icvzBbjc8RFA==
X-Received: by 2002:a2e:9915:: with SMTP id v21mr565368lji.155.1636391722036;
        Mon, 08 Nov 2021 09:15:22 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id s17sm2082674lfe.10.2021.11.08.09.15.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Nov 2021 09:15:21 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id j10so12331351lfu.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 09:15:20 -0800 (PST)
X-Received: by 2002:ac2:57d3:: with SMTP id k19mr843202lfo.150.1636391719818;
 Mon, 08 Nov 2021 09:15:19 -0800 (PST)
MIME-Version: 1.0
References: <20211105133408.cccbb98b71a77d5e8430aba1@linux-foundation.org>
 <20211105203950.AJ1Cnteeh%akpm@linux-foundation.org> <YYjs7UT15WIF23DJ@dhcp22.suse.cz>
In-Reply-To: <YYjs7UT15WIF23DJ@dhcp22.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 8 Nov 2021 09:15:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjov5-baOgf+r7bOh=P_YCHuxBcyf_b=or990RTxz5QAw@mail.gmail.com>
Message-ID: <CAHk-=wjov5-baOgf+r7bOh=P_YCHuxBcyf_b=or990RTxz5QAw@mail.gmail.com>
Subject: Re: [patch 099/262] mm/vmalloc: be more explicit about supported gfp flags
To:     Michal Hocko <mhocko@suse.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux-MM <linux-mm@kvack.org>, mm-commits@vger.kernel.org,
        Neil Brown <neilb@suse.de>, Uladzislau Rezki <urezki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 8, 2021 at 1:25 AM Michal Hocko <mhocko@suse.com> wrote:
>
> As already pointed out
> http://lkml.kernel.org/r/YXE+hcodJ7zxeYA7@dhcp22.suse.cz this patch
> cannot be applied without other patches from the same series.

Hmm. I've taken it already.

Not a huge deal, since it's a comment change - and the code will
presumably eventually match the updated comment.

I guess it's a new thing that instead of stale comments, we have
future-proof ones ;)

              Linus
