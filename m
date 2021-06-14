Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8733A6E16
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 20:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbhFNSRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 14:17:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21693 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233455AbhFNSRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 14:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623694502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XoLLCXJLmHm9xP9JVi6L/4crsU3Bp6fWjhRZ5/p958Y=;
        b=CkskUsMIk553qW6qbyPXl/Umh+hwLe+4Fx2nEcAz0y3lwhemP+t6fs7J2bZrMfwHl1afzf
        jyX8DFj8GRaspwawtagFOWhgL3+ascA6gOOaCazFh1yy3MOT17U8HoipzD9gFRjd5Wf0q7
        N+SE6n6vzrUt5Kbga4OQyCfcf6zkfMU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-41_sERMPMwWEbaQ_SeVOVA-1; Mon, 14 Jun 2021 14:15:01 -0400
X-MC-Unique: 41_sERMPMwWEbaQ_SeVOVA-1
Received: by mail-lf1-f70.google.com with SMTP id u7-20020a0565120407b02902ff43b1e7f4so5544058lfk.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 11:15:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XoLLCXJLmHm9xP9JVi6L/4crsU3Bp6fWjhRZ5/p958Y=;
        b=YZV2X3iwU7LtSUJezd8wlAAkukzM9/P803O7d9+YfCBoMyTRN1CF/qBrUqflS6TVAM
         mGeCLfJCJSbYojvedKGAG3eFEi57j1ayjtiGyYU+en5MfxEWlSxjJn0E2gZZylfcYAfL
         9QLSkx+Ya8ZoVN7tVoWzkV8jRmJA9riLKuoW/JZkbBhAc7zgxz0vb7MWfy7pgdjfWXch
         p/UNuEya+hr3DlO6/AlOKPE5yNKSVndDqHGst1CJp+cE/qwfWbBlUj+hQBu/9uQqFf3o
         tGjrOaiTaSXwX1dHpR5m05D2sExBuM45Ln7gwyP2p5ecaH8ximub6XoxQWLHQHHG66fc
         8Gjg==
X-Gm-Message-State: AOAM532UEPGBrLkqBm/zfYHHq0zypBzobNyZh7QQ16q/Rqh0KYuHqGKD
        /tOd7Ba/L0ofhM87fzRMBG3yQH6Hd4RVLBB1joIViW1rMEOkR5Cg8jWLgvEBScaH9nqIWCyAEQ2
        FeIAOT0wMVmDaCkFs9BW2PfmXWFs308/EO9b/esWK
X-Received: by 2002:a05:651c:383:: with SMTP id e3mr14751183ljp.220.1623694499477;
        Mon, 14 Jun 2021 11:14:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzZpUwO131yESALYO7EwB89ztq7Jn+0azFobN4Jb1kH1ikJSy93T4qoJVCiH217Mn8G6kgyD4lpDRQotg36Oc=
X-Received: by 2002:a05:651c:383:: with SMTP id e3mr14751171ljp.220.1623694499323;
 Mon, 14 Jun 2021 11:14:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210317003616.2817418-1-aklimov@redhat.com> <87tuowcnv3.ffs@nanos.tec.linutronix.de>
 <CALW4P+L9_tYgfOPv0riWWnv54HPhKPDJ4EK4yYaWsz0MdDGqfw@mail.gmail.com> <CAFBcO+8NBZxNdXtVuTXt9_m9gWTq7kxrcDcdFntvVjR_0rM13A@mail.gmail.com>
In-Reply-To: <CAFBcO+8NBZxNdXtVuTXt9_m9gWTq7kxrcDcdFntvVjR_0rM13A@mail.gmail.com>
From:   Alexey Klimov <aklimov@redhat.com>
Date:   Mon, 14 Jun 2021 19:14:48 +0100
Message-ID: <CAFBcO+9wLjDW6n-ZSean_UQHSJ44Tpw9XBz-3UMoVCeUridj4Q@mail.gmail.com>
Subject: Re: [PATCH v3] cpu/hotplug: wait for cpuset_hotplug_work to finish on
 cpu onlining
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        cgroups@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Yury Norov <yury.norov@gmail.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Joshua Baker <jobaker@redhat.com>, audralmitchel@gmail.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael@kernel.org, tj@kernel.org,
        Qais Yousef <qais.yousef@arm.com>, hannes@cmpxchg.org,
        Alexey Klimov <klimov.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas,
Just gentle ping.

On Thu, Apr 15, 2021 at 2:30 AM Alexey Klimov <aklimov@redhat.com> wrote:
>
> On Sun, Apr 4, 2021 at 3:32 AM Alexey Klimov <klimov.linux@gmail.com> wrote:
> >
> > On Sat, Mar 27, 2021 at 9:01 PM Thomas Gleixner <tglx@linutronix.de> wrote:

[...]

> Are you going to submit the patch? Or I can do it on your behalf if you like.

Are you going to send out this to lkml as a separate patch or do you
want me to do this on your behalf?

Best regards,
Alexey

