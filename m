Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43E1F43D3B1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 23:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244257AbhJ0VSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 17:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244278AbhJ0VST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 17:18:19 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6D0C061745
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 14:15:51 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id l7so4465559iln.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 14:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lm0+nNU7+O9MfXmzPflhpy32QYmyc8kaxNev2lDAAEs=;
        b=QkZG2K8bVwvVE7egaAt2KoM2ozNWqnXnRYCDiO58eC/yTXl8qb52o9wIZwiEo5g82G
         bccuMjBMX6s2/H00mP+Fr4qT57h9Uvc53WJXiMmwn/o5rOlpjbPpRCkoq6lDMvFiLf5M
         Mn5WuZvMESLsr+yShl4950U8mxzBbei0DvPwtD4+tGwSShXC7YBnfa4bwCxG8yzvVmD9
         ZWQzhlnZgrRF38+as+UM1Z5B3CgzFBucx490mDEgN/LQQOr5EPSwcVKAwJjxaors8Y2R
         Rw7IGFcGLS8D7eew/S4U2b8sGZ7yETg9YaMlTaGrL0Kw4t4XBNIT+7a4JOw/7ThIseQ4
         4gIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lm0+nNU7+O9MfXmzPflhpy32QYmyc8kaxNev2lDAAEs=;
        b=wyK2Fsc9ah3uS78jec/ryZWmnHh7BmBVDUxrB5l3k4MJM+/f8JdBNy4QNLOCMAN7lw
         U88yg0RBsrKCW7KXLb0L94keX02fPMzSsM7nrXpHq2EYuMggrvlof4bHlzOs+yK4YxLQ
         tvS6N9stZfBefLvlVumQfsCuzU70ru0BvPX+JTiH3kwLhLAYRCdly4jJSNWlM77uwnzU
         5BktFwRFowj92zv3fWzTsHC/bBPybDoO0f121cvaWzklVrfLH1OGMZ8DmWVgOKeBE6sV
         OIdNlW43fl25c35z5zMFQ9expUdh15qupL3/rzNiPAqcipjarg5JLI85ZbNWvdcNllp6
         vEwg==
X-Gm-Message-State: AOAM532MSxYaxxbHzCD/zthhzYCvXe5rLt+qu6KNBNeuTPRhR4gBVRjC
        0uEAvW5dBlh+HsDZiCKojr/HeSZdfo+k2vpcZg9zow==
X-Google-Smtp-Source: ABdhPJwFlVdGBs6/ghTfnA4EXQvfoHz1gslNeIB/tO5KGqaiLemu7UQV0bF5r1t7c+peB8KbFaYyT1obO1kHcSnGPSg=
X-Received: by 2002:a92:2812:: with SMTP id l18mr181346ilf.239.1635369350499;
 Wed, 27 Oct 2021 14:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210930212309.4001967-1-axelrasmussen@google.com>
 <20210930212309.4001967-3-axelrasmussen@google.com> <CAJHvVcj9FpJgC5EsB1_6yfgDA8p5-=Oakccg+TUrGUWZB5nHzA@mail.gmail.com>
 <YXDCagVgh2O2YdIW@xz-m1.local>
In-Reply-To: <YXDCagVgh2O2YdIW@xz-m1.local>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Wed, 27 Oct 2021 14:15:13 -0700
Message-ID: <CAJHvVchb1XyQiu6=0d+viG04Qe4LV3Z6dmCLRxGNqKPxriULFQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] userfaultfd/selftests: fix feature support detection
To:     Peter Xu <peterx@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Linux MM <linux-mm@kvack.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 6:29 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Oct 20, 2021 at 11:28:49AM -0700, Axel Rasmussen wrote:
> > Just a friendly bump for review. :) Peter, any objections to this
> > version? I think it fairly closely matches your suggestions from v1.
>
> Isn't the whole patchset already queued by Andrew? :)

Ah, true, but I was worried he might hold it there until it got a R-B?
The process is still a bit fuzzy to me. :) Thanks for taking a look in
any case!


>
> Anyway,
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>
> Thanks for the change!
>
> --
> Peter Xu
>
