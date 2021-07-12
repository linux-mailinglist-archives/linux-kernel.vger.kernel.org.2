Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5152B3C5A74
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbhGLJ6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 05:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239338AbhGLJ6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 05:58:00 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8B5C0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 02:55:10 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id v1so27111535edt.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 02:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HSX1sBNAaLK7Zbgo2gu6wsmdyizmWwHFhYTRcpp9m6M=;
        b=JW0h/v3AfECEXpS5s4vs1K0lQPgrdLBaY7n2ZaXCDNVfluW/W3BhGazMDtSISF7j0b
         AO3qpx+SVpDVhiCk/FEq0nRRiq7Gn9uHrufJRNjrXG33m3DeoebKX8a/xnOFtE6aWOti
         MTcDw6t/EzZ6bRoxPu9iEtLymPOjiV8Ylzm/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HSX1sBNAaLK7Zbgo2gu6wsmdyizmWwHFhYTRcpp9m6M=;
        b=nnlqgI0h4qvebzyMI57e324fyJUCJtJlkvK/Hw9mB7yfgdaf78vQIUTtXhij5Oh2WY
         UPeWh8VKrMa3U29ibKW4vobwcBDjDZiJR6t0x1s6eGm3UDsHZtO+EWQCpE2ifilxwexk
         d9fZ1RrzRzCZXlaWkH7m2W4893zaWKahpdv91l5HF+WVDKNvsW1+TRwt6lbOdvkAcacE
         6ppwrtl+PnsoD9KHeGQ79lOP/+HAWeiKz/dRPnNNwe8d8kijGEhp7PgKWMDfHGiSfgy3
         WoS7Aa26SydaCkYWIKwbBNCQWaB7J3yii8V65mfX4rR+fN2RA5LbPJOjlKcS4AJjTvXd
         EbyA==
X-Gm-Message-State: AOAM531LcADTgnCyxvkZJmqPs9An5A+xBOekYKls/y+bo1SJCVC3f8X/
        ooBcXEgVM6LpDe7bZz63oa/eU277JmjkgeFp8mOUaw==
X-Google-Smtp-Source: ABdhPJwmkJ4mD3QUFTrqYXkhrrLXNnNFtH3iGIS+1fwkpFMqgJUg3Z4fCjGJva6btnTIPBF84Um8p7B24vYodh7ExsU=
X-Received: by 2002:aa7:c799:: with SMTP id n25mr61959734eds.16.1626083709449;
 Mon, 12 Jul 2021 02:55:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210706132259.71740-1-alexander.mikhalitsyn@virtuozzo.com>
 <20210709181241.cca57cf83c52964b2cd0dcf0@linux-foundation.org>
 <CAJqdLrpx+xEMGQLZo7jS5BTAw-k2sWPrv9fCt0x8t=6Nbn7u+w@mail.gmail.com>
 <CALgW_8VUk0us_umLncUv2DUMkOi3qixmT+YkHV4Dhpt_nNMZHw@mail.gmail.com>
 <CAJqdLrofd76x_hziq7F3wY3jqZfE1LNZbQ8sD6MUFXbPHVcdVw@mail.gmail.com> <CALgW_8WHq051ifcYPta5reoVZ10=fA5Rb1EZuyaievK+OUw99Q@mail.gmail.com>
In-Reply-To: <CALgW_8WHq051ifcYPta5reoVZ10=fA5Rb1EZuyaievK+OUw99Q@mail.gmail.com>
From:   Alexander Mihalicyn <alexander@mihalicyn.com>
Date:   Mon, 12 Jul 2021 12:54:58 +0300
Message-ID: <CAJqdLrpxnMThqersqiVsTNr1Y25V8jmDcW_sKWi0ziJXCsi2gw@mail.gmail.com>
Subject: Re: [PATCH 0/2] shm: omit forced shm destroy if task IPC namespace
 was changed
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Milton Miller <miltonm@bga.com>,
        Jack Miller <millerjo@us.ibm.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrei Vagin <avagin@gmail.com>,
        Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Manfred,

On Sun, Jul 11, 2021 at 2:47 PM Manfred Spraul <manfred@colorfullife.com> wrote:
>
> Hi Alex,
>
>
> Am Sonntag, 11. Juli 2021 schrieb Alexander Mihalicyn <alexander@mihalicyn.com>:
> >
> > Hi, Manfred,
> >
> > On Sun, Jul 11, 2021 at 12:13 PM Manfred Spraul
> > <manfred@colorfullife.com> wrote:
> > >
> > > Hi,
> > >
> > >
> > > Am Samstag, 10. Juli 2021 schrieb Alexander Mihalicyn <alexander@mihalicyn.com>:
> > >>
> > >>
> > >> Now, using setns() syscall, we can construct situation when on
> > >> task->sysvshm.shm_clist list
> > >> we have shm items from several (!) IPC namespaces.
> > >>
> > >>
> > > Does this imply that locking ist affected as well? According to the initial patch, accesses to shm_clist are protected by "the" IPC shm namespace rwsem. This can't work if the list contains objects from several namespaces.
> >
> > Of course, you are right. I've to rework this part -> I can add check into
> > static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
> > function and before adding new shm into task list check that list is empty OR
> > an item which is present on the list from the same namespace as
> > current->nsproxy->ipc_ns.
> >
> Ok. (Sorry, I have only smartphone internet, thus I could not check
> the patch fully)
>
> > >> I've proposed a change which keeps the old behaviour of setns() but
> > >> fixes double free.
> > >>
> > > Assuming that locking works, I would consider this as a namespace design question: Do we want to support that a task contains shm objects from several ipc namespaces?
> >
> > This depends on what we mean by "task contains shm objects from
> > several ipc namespaces". There are two meanings:
> >
> > 1. Task has attached shm object from different ipc namespaces
> >
> > We already support that by design. When we doing a change of namespace
> > using unshare(CLONE_NEWIPC) even with
> > sysctl shm_rmid_forced=1 we not detach all ipc's from task!
>
> OK. Thus shm and sem have different behavior anyways.
>
> >
> > 2. Task task->sysvshm.shm_clist list has items from different IPC namespaces.
> >
> > I'm not sure, do we need that or not. But I'm ready to prepare a patch
> > for any of the options which we choose:
> > a) just add exit_shm(current)+shm_init_task(current);
> > b) prepare PATCHv2 with appropriate check in the newseg() to prevent
> > adding new items from different namespace to the list
> > c) rework algorithm so we can safely have items from different
> > namespaces in task->sysvshm.shm_clist
> >
> Before you write something, let's wait what the others say. I don't
> qualify AS shm expert
>
> a) is user space visible, without any good excuse

yes, but maybe we decide that this is not so critical?
We need more people here :)

> c) is probably highest amount of Changes

yep. but ok, I will prepare patches fast.

> b) Impact for me not clear. Would it mean that shm_rmid_forced would
> stop to work after setns()

Yes, in this case this "forced" destroy will stop working on newly created shm's
in the new IPC namespace. But for old segments all will continue work as it was.
Not an elegant solution maybe...

>
> Correct?

Absolutely ;)

>
> --
>    Manfred

Regards,
Alex
