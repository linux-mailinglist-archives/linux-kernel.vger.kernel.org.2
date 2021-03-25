Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D7D349A8A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 20:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhCYTjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 15:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbhCYTjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 15:39:16 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9A0C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 12:39:13 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id g8so4195953lfv.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 12:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gzmi+VlURgVOiIckHYDGx4tksnLtuqPhZg704eyPPzc=;
        b=axAO0RrZyNnOLPeJBC+lqlIBSFCA0+T5m0c+QTvjiesvzRhrSrhNAJGNBpPYO2w5yg
         C8XEXbVJk+oVcSmsslcoGILcX1bst/8WI3rxAEQOD5N5m35uB129JOQ4p6zl6gjYV0hr
         N9zXUzK0n6LOTT7Lnko6AXU/5hsgnyUwAG1QQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gzmi+VlURgVOiIckHYDGx4tksnLtuqPhZg704eyPPzc=;
        b=b90wNJcmv4RqADur0sWI8oAF63vBuJwCOjP2Y/JH0Gn6yRnAOPzsNtNzVOl5lMi0rF
         TA8r+jCNJzBiT5jc5JAbUHq82F5iYPBPd0B/z1dIMOx9VtwJ1z147pN/eKE55ozlx69r
         tXZgYYklrk7qLL5FsQqOekUfnJ17iTvJqrOz7Yct5ZUkbyCXelKrKM2JZfe3tKM2fc2a
         PqN3h4bRxRIc3Os6TcxOrtBHF7/Om+5zdduo1d8wGMXGI9iglNNv8SBj+pkMhc3ur3fN
         OREqzG0pcdMu2V46LYH8T2VzUlaVOFdiO2tx6yD9yaCPAkLIpYWT5w9QkxqsH0DwKbfl
         SLCQ==
X-Gm-Message-State: AOAM530V+IqOL18VozcGeW2n5cM1Dnjq+OJ+uoUKUG+83WNq3Bvkdt5I
        MMmv8M9AHpWcsg0OJ8BK4ZWpvv/jqOYzfg==
X-Google-Smtp-Source: ABdhPJzpkJ0rjjugCQmhykMg3oWBuNt8cNBI3WGX7401Vc7e9UJIweqW0O5UJE5LR2iqFIAcnv875A==
X-Received: by 2002:ac2:5ca7:: with SMTP id e7mr5911375lfq.646.1616701152168;
        Thu, 25 Mar 2021 12:39:12 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id p13sm871027ljg.116.2021.03.25.12.39.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Mar 2021 12:39:11 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id n138so4246997lfa.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 12:39:10 -0700 (PDT)
X-Received: by 2002:a05:6512:308b:: with SMTP id z11mr5719715lfd.487.1616701150641;
 Thu, 25 Mar 2021 12:39:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210325164343.807498-1-axboe@kernel.dk> <m1ft0j3u5k.fsf@fess.ebiederm.org>
In-Reply-To: <m1ft0j3u5k.fsf@fess.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Mar 2021 12:38:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjOXiEAjGLbn2mWRsxqpAYUPcwCj2x5WgEAh=gj+o0t4Q@mail.gmail.com>
Message-ID: <CAHk-=wjOXiEAjGLbn2mWRsxqpAYUPcwCj2x5WgEAh=gj+o0t4Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] Don't show PF_IO_WORKER in /proc/<pid>/task/
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Jens Axboe <axboe@kernel.dk>, io-uring <io-uring@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Stefan Metzmacher <metze@samba.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 12:34 PM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> A quick skim shows that these threads are not showing up anywhere in
> proc which appears to be a problem, as it hides them from top.
>
> Sysadmins need the ability to dig into a system and find out where all
> their cpu usage or io's have gone when there is a problem.  I general I
> think this argues that these threads should show up as threads of the
> process so I am not even certain this is the right fix to deal with gdb.

Yeah, I do think that hiding them is the wrong model, because it also
hides them from "ps" etc, which is very wrong.

I don't know what the gdb logic is, but maybe there's some other
option that makes gdb not react to them?

          Linus
