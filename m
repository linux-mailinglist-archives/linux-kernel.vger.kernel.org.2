Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C78439A164
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 14:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhFCMts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 08:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhFCMtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 08:49:47 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C0EC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 05:48:02 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id p20so6944431ljj.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 05:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rjZiLzgztTwrDnTRRzZLDNIH/uFFhQzORDSKq4SuBVs=;
        b=FWa2GVRa7jz98e5j8NZTE8n1xNZ7ULalaBadTxfAOldakJQkKaq6OD7kbbAIHllw1s
         1M+5HEakJvXynvUE3WBknc7GuaUBsj4iSOCb2INpZptZv0gkIN43YN5s+dLPbZpkIHXs
         WvJqh5Q11KKUBEqlKzOhZhafwisEhbPmrmVttrG0WaKonWZnCQHJWT+U/FTx30Rx9q6b
         vYcxkEsPQw5sE8380mzrXeAlAnVsXKy4DNVEAXMHjlOl7jXGMfhfQO9u/IEOroi52Ncm
         rgvUmFVcM2q5c6n/WCpNd4uLpzRNAK5PUJtoPW6RxBU/zWBBQPx7Z+tdrD774OSQEdTH
         Y3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rjZiLzgztTwrDnTRRzZLDNIH/uFFhQzORDSKq4SuBVs=;
        b=MwWYLkydaSFzFAIMn4fNzwK0xhXqVJGHfAr76O//uKeQEK6SDDSYqLOqVOi+naHnZ+
         SFTk35MJqHZot29iEe7R27LyO3djd482LgbFORNTyTz1o11DJx8HYkPGeXIY/16Y8BO0
         X6lUB1pYbZle45x1DSqfO9qO1if2GWm5Lzp9UoaWjp+ke3bJ8VtSLFPVsVs0HnrsHfJC
         U/l1pX65AFXg+bCb5OaMqQ8cgYZzw88D/OcaUyf+QXXlCw/+7CfapzZ4x443EeaedFog
         SsVDImKcJe0+nJk3Q2ZWqwOfCFjg0vOCGG8BOD7mtw1QOzYj9seedrtDCmtkdU9WJsXg
         KGJQ==
X-Gm-Message-State: AOAM53163F+j9+h5DTgCXW+VhprWtkfNr3Uv1xIWXYwSWjOddlwqgrwF
        Nb/AZvwrzsSu8I0YwyTlV7pU+NdKygkr+8n0G7vU6Q==
X-Google-Smtp-Source: ABdhPJx/MrZfhwhuIgZuctOOFMSy2+yDRAMB5xv2YKkEp7An2r0yiM/w1EOcxmkivCFYebvlPlLQ/zL1BnPcAPrHUKk=
X-Received: by 2002:a05:651c:4cf:: with SMTP id e15mr2017988lji.401.1622724480250;
 Thu, 03 Jun 2021 05:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210601155328.19487-1-vincent.guittot@linaro.org> <CAFpoUr0NUVqxCtRefu+MUv=SSA+7ie5OxtPqYZ=AT=JNc+0t=Q@mail.gmail.com>
In-Reply-To: <CAFpoUr0NUVqxCtRefu+MUv=SSA+7ie5OxtPqYZ=AT=JNc+0t=Q@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 3 Jun 2021 14:47:48 +0200
Message-ID: <CAKfTPtCDPGJW=J6JmZ+Gs5kcptfWUwAsFs=xyCcoJ_hF--EkAA@mail.gmail.com>
Subject: Re: [PATCH] sched/pelt: check that *_avg are null when *_sum are
To:     Odin Ugedal <odin@uged.al>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2021 at 13:06, Odin Ugedal <odin@uged.al> wrote:
>
> Hi,
>
> Is there an idea to add tg_load_avg_contrib as well, to avoid
> regressions where that is not set to zero?

TBH I wondered while preparing this patch if tg_load_avg_contrib
should be checked as well but I came to the conclusion that we should
keep this looking at PELT metrics only. If tg_load_avg_contrib != 0
but load_avg ==0, it means that we failed to update
tg_load_avg_contrib somewhere else

>
> Otherwise:
>
> Acked-by: Odin Ugedal <odin@uged.al>
