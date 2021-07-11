Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2C83C3BFC
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 13:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbhGKLuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 07:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbhGKLuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 07:50:13 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E178DC0613DD
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 04:47:26 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id e14so14838914qkl.9
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 04:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CBrsDqkq69rAkGnQw9ciaTonWDlFwcC46W319ljmNk8=;
        b=dt+BBfMnPw925saz6owXUJgZlIvmw2GoPAO9S5263p9qfyg0N5kfHscsLBqcCvIGlr
         TQnYuYrABRUuhFiM6kP3Ch8wZd324h1G+r5I8NqjBIs2kCwUrQMQWlXt+sKbJ5+0jMVU
         EvPwGf4/AAhTV3o1ZTcCbVsP9/Fw8lEe1GAO1THQMrVvig/U44qRw+UhrvjT9eyW0qgf
         t0MGwXb7tV+2VoY73VQxupbK3iiJN+xzdMglDoSgi+DTLJedHcDMiozx26tHfTF6L/hU
         /v4F7v0HvARfBDYCfHX+4gUA6WqwOMVij1yLibgj7hoaNfLzzw8lAEQLAAjoIv7oBQh5
         3F6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CBrsDqkq69rAkGnQw9ciaTonWDlFwcC46W319ljmNk8=;
        b=JidhlKCeSCV/8PbTZ4fM6RqaImV3zykSRh1zCPb3Dqf9Y3wsqkfuepnZdquSoZPMl8
         gVG59VanMsqRWHCOs1tGX+xtYLgbDIFdO1W3Hkv2ai2tn64Mtt/crKi9nvdAPWkxcAED
         6puTYVh+Qk+eEbWqb5LdZwsFlwtZF9IuvK8VZBeH2RmmqMsi6LTTOFPGyOH7LzxLpdEM
         iAu7CZUpejlH9U23DlSuS3Up7MeC9t0Pq+7cT0RuKLrFczpufcxpOHEi2wYnbjNys324
         seBNGeFV6az6dUTWCtPXzctS8O0jrVz1Yta2C+y0y/WG0liDqI8WMLCk6Dwmuz2q6dtn
         svQg==
X-Gm-Message-State: AOAM530EgxSp1iNoMlF+RQGC1JBG7M2XwO6MAK3oFhKRnCRi7XVXnpGm
        2/KvRbjOf9CVJMdXfvqSHNYoW1BNnmmXALH+28gTDA==
X-Google-Smtp-Source: ABdhPJyU+LafUpqLY79qvyPUombGeIFpD9TCg2AKkMOkQWWrGJkI/x2Dh7NtV11VV3NiCg4uaq7BvZLk8EEauGyUiIc=
X-Received: by 2002:a05:620a:7d3:: with SMTP id 19mr343404qkb.351.1626004046097;
 Sun, 11 Jul 2021 04:47:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210706132259.71740-1-alexander.mikhalitsyn@virtuozzo.com>
 <20210709181241.cca57cf83c52964b2cd0dcf0@linux-foundation.org>
 <CAJqdLrpx+xEMGQLZo7jS5BTAw-k2sWPrv9fCt0x8t=6Nbn7u+w@mail.gmail.com>
 <CALgW_8VUk0us_umLncUv2DUMkOi3qixmT+YkHV4Dhpt_nNMZHw@mail.gmail.com> <CAJqdLrofd76x_hziq7F3wY3jqZfE1LNZbQ8sD6MUFXbPHVcdVw@mail.gmail.com>
In-Reply-To: <CAJqdLrofd76x_hziq7F3wY3jqZfE1LNZbQ8sD6MUFXbPHVcdVw@mail.gmail.com>
From:   Manfred Spraul <manfred@colorfullife.com>
Date:   Sun, 11 Jul 2021 13:46:58 +0200
Message-ID: <CALgW_8WHq051ifcYPta5reoVZ10=fA5Rb1EZuyaievK+OUw99Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] shm: omit forced shm destroy if task IPC namespace
 was changed
To:     Alexander Mihalicyn <alexander@mihalicyn.com>
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

Hi Alex,


Am Sonntag, 11. Juli 2021 schrieb Alexander Mihalicyn <alexander@mihalicyn.com>:
>
> Hi, Manfred,
>
> On Sun, Jul 11, 2021 at 12:13 PM Manfred Spraul
> <manfred@colorfullife.com> wrote:
> >
> > Hi,
> >
> >
> > Am Samstag, 10. Juli 2021 schrieb Alexander Mihalicyn <alexander@mihalicyn.com>:
> >>
> >>
> >> Now, using setns() syscall, we can construct situation when on
> >> task->sysvshm.shm_clist list
> >> we have shm items from several (!) IPC namespaces.
> >>
> >>
> > Does this imply that locking ist affected as well? According to the initial patch, accesses to shm_clist are protected by "the" IPC shm namespace rwsem. This can't work if the list contains objects from several namespaces.
>
> Of course, you are right. I've to rework this part -> I can add check into
> static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
> function and before adding new shm into task list check that list is empty OR
> an item which is present on the list from the same namespace as
> current->nsproxy->ipc_ns.
>
Ok. (Sorry, I have only smartphone internet, thus I could not check
the patch fully)

> >> I've proposed a change which keeps the old behaviour of setns() but
> >> fixes double free.
> >>
> > Assuming that locking works, I would consider this as a namespace design question: Do we want to support that a task contains shm objects from several ipc namespaces?
>
> This depends on what we mean by "task contains shm objects from
> several ipc namespaces". There are two meanings:
>
> 1. Task has attached shm object from different ipc namespaces
>
> We already support that by design. When we doing a change of namespace
> using unshare(CLONE_NEWIPC) even with
> sysctl shm_rmid_forced=1 we not detach all ipc's from task!

OK. Thus shm and sem have different behavior anyways.

>
> 2. Task task->sysvshm.shm_clist list has items from different IPC namespaces.
>
> I'm not sure, do we need that or not. But I'm ready to prepare a patch
> for any of the options which we choose:
> a) just add exit_shm(current)+shm_init_task(current);
> b) prepare PATCHv2 with appropriate check in the newseg() to prevent
> adding new items from different namespace to the list
> c) rework algorithm so we can safely have items from different
> namespaces in task->sysvshm.shm_clist
>
Before you write something, let's wait what the others say. I don't
qualify AS shm expert

a) is user space visible, without any good excuse
c) is probably highest amount of Changes
b) Impact for me not clear. Would it mean that shm_rmid_forced would
stop to work after setns()

Correct?

--
   Manfred
