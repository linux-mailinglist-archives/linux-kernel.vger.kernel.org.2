Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C6D3A1E61
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 22:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhFIU6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 16:58:38 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:46899 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhFIU6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 16:58:35 -0400
Received: by mail-lj1-f178.google.com with SMTP id e11so1563385ljn.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 13:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Ti/GPYedshBkKNipdnY5GrhF2dqxzDVtiSSzRhLNtI=;
        b=fM3/ODYVa9wR1hn9nb8YfgPISH77MdgxAUdLzKr7W2e3Sr96ga6sYy1IUgVhfy8HbG
         mdCa640pJmKm5DwoFKNcgsTdX7NuOiKkWvi8/ekGVtCCMyzFvrX4ZVRTFSlNwFLRZrNU
         IxbmSwfgKrqUgHefveb3h1xo0hr4FLtngRpQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Ti/GPYedshBkKNipdnY5GrhF2dqxzDVtiSSzRhLNtI=;
        b=qJozhYv1uyTcDiJLzz5y6zo2+XS1FTcGSYtt/af9Zaqgjjxlf/OIu7siBk0UBNHBOh
         0yz2eQ/bU1V7eL6a5gBctA205bl29UFpFJ85L21YretLJV7PGiREcLYxRiotoCejtyfb
         2XtbhxnXqps/ReBTmSJnPl8yVP3AGWdOscmKeiiPXp7RfYu1HBkhj+1vJZxsZymxim7z
         aLfh0KUlprqudWOPr5wPjafe9zftAwxnHMEFRaOMC4YB2YiO+XRvaxSq32oz1bopRteI
         s6uB2UepowiPNtS/kfd1Z8MrTDyC3oCsUwHn/QdYfEXq3Q50KvERQRq/1GvV0iA7zLvT
         C8IQ==
X-Gm-Message-State: AOAM530ymdtDpwh1mS2EJRUSUFGRwfEZeB2aJR3CB31oybytd+Jzh0oz
        qWKgOn/XnCbs8bqydi0cZrUmn5s22ktIrEGdxKA=
X-Google-Smtp-Source: ABdhPJz0C/ZANjN26zISEbGEQC2IKKWS8j7Xh7XV445Iu47CjFW3+NGbK0YfWTHVglR+v3y9plqjZQ==
X-Received: by 2002:a2e:5718:: with SMTP id l24mr1229242ljb.500.1623272123359;
        Wed, 09 Jun 2021 13:55:23 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id b12sm91686lfc.44.2021.06.09.13.55.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 13:55:20 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id bn21so1651139ljb.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 13:55:20 -0700 (PDT)
X-Received: by 2002:a2e:2ac6:: with SMTP id q189mr1226604ljq.61.1623272120266;
 Wed, 09 Jun 2021 13:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210607125734.1770447-1-liangyan.peng@linux.alibaba.com>
 <71fa2e69-a60b-0795-5fef-31658f89591a@linux.alibaba.com> <CAHk-=whKbJkuVmzb0hD3N6q7veprUrSpiBHRxVY=AffWZPtxmg@mail.gmail.com>
 <20210609165154.3eab1749@oasis.local.home>
In-Reply-To: <20210609165154.3eab1749@oasis.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Jun 2021 13:55:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=win1FaZQga_XYSkRLx0-mF6dSm-HhP2RQ9ZZ3S380SeOg@mail.gmail.com>
Message-ID: <CAHk-=win1FaZQga_XYSkRLx0-mF6dSm-HhP2RQ9ZZ3S380SeOg@mail.gmail.com>
Subject: Re: [PATCH] tracing: Correct the length check which causes memory corruption
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     James Wang <jnwang@linux.alibaba.com>,
        Liangyan <liangyan.peng@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Xunlei Pang <xlpang@linux.alibaba.com>,
        yinbinbin@alibabacloud.com, wetp <wetp.zy@linux.alibaba.com>,
        stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 9, 2021 at 1:52 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> That said, even though I'm almost done with my tests on this patch, and
> was going to send you a pull request later today, I can hold off and
> have Liangyan send a v2 using struct_size and with the clean ups you
> suggested.

I think the cleanups could be separate. I in no way _hate_ Liangyan's
patch, it's just that when looking at it I just went "that code is
very confusing".

So I'm certainly also ok with just getting that ugly fix, and then
hope for a cleanup later. Maybe with a comment or two.

Thanks,
            Linus
