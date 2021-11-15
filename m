Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA4A4523BC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 02:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243463AbhKPB3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 20:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239981AbhKOTAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 14:00:07 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A060C04646F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 09:56:04 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id r11so11815997edd.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 09:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t0OUGI1k+NoCaWNd0ewGVN0FMA6CALGUV3el2LJ06us=;
        b=LFum/qab30nWQarJgC8HTDKj/7PEoEdFPtyHcTHO5FUUKxSwXiuMzn3XqIYYClt4w8
         cVqVXobCm61Rlt+J2C325PDyHUFf7erycpTR4GqvoEyM9+ADtno58vqfNJ5ymqoeze4e
         zTr0fFvpuavN1xBgh3dHvmKNQWN8jOZ/VJ0cI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t0OUGI1k+NoCaWNd0ewGVN0FMA6CALGUV3el2LJ06us=;
        b=sbnWsikoEmvVkDYkj6yI9JpHy2vBxAhcng6JacFPhE7VEidGLvf7TPzEXT6vbyDNA0
         f3pUeuaNdsQDyPt5vrRvAdCZv0kdH+AFFNTBAB89n8zhlxMk4qswLKplXtL0hpxR0PWj
         AZkclxG6aC+zv8RZxrW0dRG9QG0VUBGBEU8gdn2bY+3W8M+rWWdrG3ilT03nX0l0rL5C
         Nrtv1dBRERqAH5mkgLBBujCzGxzENO/OHbubMk17eg+TpMNTot+a+mJFYmxH1gj2waB9
         zNdPeSZoqt/gsdjmZM6kznPo/WcGgybJRjttXoV9s+ldkTzPq422wCnYQ58t1eCsF0bZ
         /AfQ==
X-Gm-Message-State: AOAM5322BYJrar19AKXmvCeUUhoUG5n6Ho9FwNpAe2fT9+Hi46dQBokc
        CByqDQzxVVPCS5qNTlMxgKIRViaWZYRK8N9G
X-Google-Smtp-Source: ABdhPJxeIcgnlG97lLIbbr7Tx3Y6spVoqXWPrHQZtpx1aCz33VJZByy7ospwBNT/7r4Oy7b0rwtQxg==
X-Received: by 2002:a05:6402:4401:: with SMTP id y1mr723679eda.225.1636998962481;
        Mon, 15 Nov 2021 09:56:02 -0800 (PST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id ne33sm7026280ejc.6.2021.11.15.09.56.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 09:56:02 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id d27so32386189wrb.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 09:56:01 -0800 (PST)
X-Received: by 2002:a5d:50c6:: with SMTP id f6mr1063026wrt.131.1636998961630;
 Mon, 15 Nov 2021 09:56:01 -0800 (PST)
MIME-Version: 1.0
References: <163689642456.3249160.13397023971040961440.tglx@xen13>
 <163689642744.3249160.6971106813056927807.tglx@xen13> <CAHk-=wjQxHwdC61ore062Hc5PAF2o6CJnDG_NsQe+e599RovJw@mail.gmail.com>
 <YZKCBqmb1gfKvFcR@hirez.programming.kicks-ass.net> <YZKFuE0gpdlTiBOv@hirez.programming.kicks-ass.net>
In-Reply-To: <YZKFuE0gpdlTiBOv@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 Nov 2021 09:55:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=whmGsVzPkHSErAGxRCrxwTFXoxjULrdbYeYKEq-sc7MJg@mail.gmail.com>
Message-ID: <CAHk-=whmGsVzPkHSErAGxRCrxwTFXoxjULrdbYeYKEq-sc7MJg@mail.gmail.com>
Subject: Re: [GIT pull] timers/urgent for v5.16-rc1
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 8:07 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Also, clearly that comments needs to go..

Yeah, with that your patch looks good to me.

Thanks,
          Linus
