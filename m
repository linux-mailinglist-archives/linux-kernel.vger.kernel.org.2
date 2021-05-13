Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D6337F7CC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 14:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbhEMMYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 08:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhEMMYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 08:24:40 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF010C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 05:23:30 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id k10so8357992ejj.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 05:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PYH3WjdAu6b153D5yKGYZ/hDp4xmzmEeNJ/L+seX18E=;
        b=reogA0yBAwXAMfrNFKThPDt6KynxIgXdQPTi8v9kHIoYC2C8Tu3VxOM2EXlCUaXz7N
         ge+u6lVpULS44mnj7JHPeK61rZEfsQI78AeFduLuKfENsxIM8xh4MvgLynee2S/FBqlg
         99/bf3FfIca+tItu3nsGxvLPuF110IQoN6RwzSVE5KW2V3yN8T/lnlRq7vD2VFfGN6a7
         eYosG9FitukFS9JMbP7meauU+odlsf7tnRyRoNjnifHu/uvdQk141+pazMB0Zw3JMy+r
         JMPHtJqqyeDa0e+/VukQzFDyEKxvsbAlcvDjJKaEIV5pYJphmr+HBRIwpyqepowGaQ5N
         YpKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=PYH3WjdAu6b153D5yKGYZ/hDp4xmzmEeNJ/L+seX18E=;
        b=cDRxOSy2e8rw3cVWuVyp19pLnhwLyd1/63zOJ+wNHhfOrMcbrOluH+mmzPAkS+ODS2
         fmCjsJWxdO/yBwpkgcM2QtCZNobKg+q9LUYoA/dZJVSN+qjlbUWtGNEoljQmc63vmgi9
         E/WANDE0CmiapdTQ3WM1L+P6F2S/jd62db8C77VW8BQkUEjZuVDG6jeO0j9OtvEjzJky
         3d5/RqVmG8W6UWk+cusZfiWgo+4aehWs5l0DPtCP9SkKJoTlGMMDGeQU79jdqVaS3N7M
         ncmQyb8/tHmAIgoSZjQq4fexqNDv1nleuzl0lubZp6f1+XUHuecJSK+0Ty8MTs7N04YA
         KiZA==
X-Gm-Message-State: AOAM5304sU8lgwH8pgVXcjg7t4gs85Wed7OlC2aXYoDK/GTGJKTG90i8
        PeUtu8Glg+T8simn36Y5vJU=
X-Google-Smtp-Source: ABdhPJxuEKTTcOhNtGxyI/5n2n1i7+Pjfbc3NqYTtH2s1nrv7/YDe6cvym+h0keuCZTkq2jPMEI9Rw==
X-Received: by 2002:a17:907:3f08:: with SMTP id hq8mr43024316ejc.240.1620908609681;
        Thu, 13 May 2021 05:23:29 -0700 (PDT)
Received: from gmail.com (0526E777.dsl.pool.telekom.hu. [5.38.231.119])
        by smtp.gmail.com with ESMTPSA id nc42sm1621609ejc.103.2021.05.13.05.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 05:23:29 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 13 May 2021 14:23:27 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [GIT PULL] tick/nohz updates v3
Message-ID: <YJ0aP4POrYlxfC5Y@gmail.com>
References: <20210512232924.150322-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512232924.150322-1-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Frederic Weisbecker <frederic@kernel.org> wrote:

> Ingo, Thomas,
> 
> Please pull the timers/nohz-v3 branch that can be found at:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> 	timers/nohz-v3
> 
> Changes since v2:
> 
> * Add Acks from Peter Zijlstra
> 
> * Only bother to fetch task's CPU if the task is queued in
> 	"tick/nohz: Kick only _queued_ task whose tick dependency is updated"
>   (reported by Peter Zijlstra)
> 
> * Correctly indent comment in
>   "tick/nohz: Kick only _queued_ task whose tick dependency is updated"
>   (reported by Peter Zijlstra)
> 
> * Add Peter's SoB in "tick/nohz: Evaluate the CPU expression after the static key"
> 
> * Add "tick/nohz: Call tick_nohz_task_switch() with interrupts disabled"
>   (from Peter Zijlstra)

Thanks - I've applied your patches to tip:timers/nohz.

I did a few cosmetic touch-ups, so applied it from email. Will push it out 
after some testing.

> * Add "MAINTAINERS: Add myself as context tracking maintainer"

Ack. Thomas?

Thanks,

	Ingo
