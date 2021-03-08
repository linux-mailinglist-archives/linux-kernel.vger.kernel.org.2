Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B0533170D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 20:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbhCHTPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 14:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbhCHTO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 14:14:57 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1D2C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 11:14:57 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id i26so5895681ljn.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 11:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=umVFORWEQyOCOOUpGFtQZb3uIQ3iqqbf1h/dKj08OzU=;
        b=oBRhTP4LTl/zksCI2CyY9IxHXuPxnr1Zc0z00W1FrIBfDuMUpi2SokFVV/3223H2kP
         fgsudXqoo65SCgs4G94MD29BRRugm/VK7H21ahwHlX6hKhlilNqeRxaZfAQ5iYijmEqc
         zoJKen0IlLS5VvVnhPVh7Z+0RXjyDOt8cNspEcjrdPL9HgIjUw2GV1QXSwMkjni0P5DS
         E9HbQs3HuH+TzCnRbi426v5MYvs9nlvSvCyr6yEA5Hszi39CZsZhaKLZp9izXWCsZ9wL
         icDtKPSjfXuqHquhpZVfKJ65SJ4gDm+5lK8dEoC0AXRgoFaCloBUjKYhzP5FCTzaeXV8
         rbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=umVFORWEQyOCOOUpGFtQZb3uIQ3iqqbf1h/dKj08OzU=;
        b=bdgobabqW+L7RJGfnXQmMSgeSjr271DEqSFlsVfgLUmhlzFiCJdsSGcAN9qgqJHmr+
         nm/pYscd/HJQCrOhBmc0VaBYy8IKjqN9jB7LWu3QAo8EIjlFBtsTq07m3YXE029vQAEE
         wOUJx99KDNuiDGxgJ3EagE5JQ/P8mxqbQLyds3g/Ps7yC/nbr9+exvhQRfnJ5JlHUlfA
         VgmLl++ebysQ+w/p7ox1SnPUEywnOpmHO8QJjTGy809j8r16OMnL0nxgyHptYfsACGJU
         0Sj1AcTM/CbxGLjSEz45RRgBZ8MxduUSWdcdmGWA5wCKHxv11Q5s07HGHK7CnzRnULKU
         2sKQ==
X-Gm-Message-State: AOAM532j/THpzVZOZDqVD0FAQk1o822vjKs2oJj5wmJJm88bzQCMJkMB
        MfmCpUf5ZoLn4XHLy0kcnpLPLsbog9D80C2n43UJ4Q==
X-Google-Smtp-Source: ABdhPJwr1msDoDl4ZTsNo1SYxB2YD6jaHfM/e5GY/tasTh4DoslLLphtgDBDIGqWdqu8IpSkHc5M4qgl+gD1cfDHEaA=
X-Received: by 2002:a2e:7d03:: with SMTP id y3mr15084711ljc.0.1615230895481;
 Mon, 08 Mar 2021 11:14:55 -0800 (PST)
MIME-Version: 1.0
References: <20210217001322.2226796-1-shy828301@gmail.com> <20210217001322.2226796-11-shy828301@gmail.com>
In-Reply-To: <20210217001322.2226796-11-shy828301@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 8 Mar 2021 11:14:41 -0800
Message-ID: <CALvZod63nBn_-SsSQA445xPjyZf+_J5oy_gF4TtrPZJf7Le-NQ@mail.gmail.com>
Subject: Re: [v8 PATCH 10/13] mm: vmscan: use per memcg nr_deferred of shrinker
To:     Yang Shi <shy828301@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 4:13 PM Yang Shi <shy828301@gmail.com> wrote:
>
> Use per memcg's nr_deferred for memcg aware shrinkers.  The shrinker's nr_deferred
> will be used in the following cases:
>     1. Non memcg aware shrinkers
>     2. !CONFIG_MEMCG
>     3. memcg is disabled by boot parameter
>
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
