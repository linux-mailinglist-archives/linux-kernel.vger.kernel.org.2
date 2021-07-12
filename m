Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9B43C638B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 21:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236365AbhGLTVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 15:21:25 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:42322 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236357AbhGLTVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 15:21:24 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:33676)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m31Rp-008l2D-CI; Mon, 12 Jul 2021 13:18:33 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:58936 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m31Ro-002ckq-4T; Mon, 12 Jul 2021 13:18:32 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexander Mihalicyn <alexander@mihalicyn.com>
Cc:     Manfred Spraul <manfred@colorfullife.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Milton Miller <miltonm@bga.com>,
        Jack Miller <millerjo@us.ibm.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Christian Brauner <christian@brauner.io>
References: <20210706132259.71740-1-alexander.mikhalitsyn@virtuozzo.com>
        <20210709181241.cca57cf83c52964b2cd0dcf0@linux-foundation.org>
        <CAJqdLrpx+xEMGQLZo7jS5BTAw-k2sWPrv9fCt0x8t=6Nbn7u+w@mail.gmail.com>
        <CALgW_8VUk0us_umLncUv2DUMkOi3qixmT+YkHV4Dhpt_nNMZHw@mail.gmail.com>
        <CAJqdLrofd76x_hziq7F3wY3jqZfE1LNZbQ8sD6MUFXbPHVcdVw@mail.gmail.com>
        <CALgW_8WHq051ifcYPta5reoVZ10=fA5Rb1EZuyaievK+OUw99Q@mail.gmail.com>
        <CAJqdLrpxnMThqersqiVsTNr1Y25V8jmDcW_sKWi0ziJXCsi2gw@mail.gmail.com>
Date:   Mon, 12 Jul 2021 14:18:25 -0500
In-Reply-To: <CAJqdLrpxnMThqersqiVsTNr1Y25V8jmDcW_sKWi0ziJXCsi2gw@mail.gmail.com>
        (Alexander Mihalicyn's message of "Mon, 12 Jul 2021 12:54:58 +0300")
Message-ID: <87y2ab9w8u.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1m31Ro-002ckq-4T;;;mid=<87y2ab9w8u.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+TkMjm6pjtrnTpKimaI11kJrwLXlvbJMM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=8.0 tests=ALL_TRUSTED,BAYES_20,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.1521]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Alexander Mihalicyn <alexander@mihalicyn.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 667 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (1.5%), b_tie_ro: 9 (1.3%), parse: 0.87 (0.1%),
         extract_message_metadata: 15 (2.2%), get_uri_detail_list: 2.5 (0.4%),
        tests_pri_-1000: 6 (1.0%), tests_pri_-950: 1.13 (0.2%),
        tests_pri_-900: 0.95 (0.1%), tests_pri_-90: 86 (12.9%), check_bayes:
        85 (12.7%), b_tokenize: 11 (1.6%), b_tok_get_all: 11 (1.7%),
        b_comp_prob: 3.7 (0.5%), b_tok_touch_all: 55 (8.3%), b_finish: 0.97
        (0.1%), tests_pri_0: 410 (61.4%), check_dkim_signature: 0.84 (0.1%),
        check_dkim_adsp: 2.5 (0.4%), poll_dns_idle: 120 (18.0%), tests_pri_10:
        2.9 (0.4%), tests_pri_500: 131 (19.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/2] shm: omit forced shm destroy if task IPC namespace was changed
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Mihalicyn <alexander@mihalicyn.com> writes:

> Hello Manfred,
>
> On Sun, Jul 11, 2021 at 2:47 PM Manfred Spraul <manfred@colorfullife.com> wrote:
>>
>> Hi Alex,
>>
>>
>> Am Sonntag, 11. Juli 2021 schrieb Alexander Mihalicyn <alexander@mihalicyn.com>:
>> >
>> > Hi, Manfred,
>> >
>> > On Sun, Jul 11, 2021 at 12:13 PM Manfred Spraul
>> > <manfred@colorfullife.com> wrote:
>> > >
>> > > Hi,
>> > >
>> > >
>> > > Am Samstag, 10. Juli 2021 schrieb Alexander Mihalicyn <alexander@mihalicyn.com>:
>> > >>
>> > >>
>> > >> Now, using setns() syscall, we can construct situation when on
>> > >> task->sysvshm.shm_clist list
>> > >> we have shm items from several (!) IPC namespaces.
>> > >>
>> > >>
>> > > Does this imply that locking ist affected as well? According to the initial patch, accesses to shm_clist are protected by "the" IPC shm namespace rwsem. This can't work if the list contains objects from several namespaces.
>> >
>> > Of course, you are right. I've to rework this part -> I can add check into
>> > static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
>> > function and before adding new shm into task list check that list is empty OR
>> > an item which is present on the list from the same namespace as
>> > current->nsproxy->ipc_ns.
>> >
>> Ok. (Sorry, I have only smartphone internet, thus I could not check
>> the patch fully)
>>
>> > >> I've proposed a change which keeps the old behaviour of setns() but
>> > >> fixes double free.
>> > >>
>> > > Assuming that locking works, I would consider this as a namespace design question: Do we want to support that a task contains shm objects from several ipc namespaces?
>> >
>> > This depends on what we mean by "task contains shm objects from
>> > several ipc namespaces". There are two meanings:
>> >
>> > 1. Task has attached shm object from different ipc namespaces
>> >
>> > We already support that by design. When we doing a change of namespace
>> > using unshare(CLONE_NEWIPC) even with
>> > sysctl shm_rmid_forced=1 we not detach all ipc's from task!
>>
>> OK. Thus shm and sem have different behavior anyways.
>>
>> >
>> > 2. Task task->sysvshm.shm_clist list has items from different IPC namespaces.
>> >
>> > I'm not sure, do we need that or not. But I'm ready to prepare a patch
>> > for any of the options which we choose:
>> > a) just add exit_shm(current)+shm_init_task(current);
>> > b) prepare PATCHv2 with appropriate check in the newseg() to prevent
>> > adding new items from different namespace to the list
>> > c) rework algorithm so we can safely have items from different
>> > namespaces in task->sysvshm.shm_clist
>> >
>> Before you write something, let's wait what the others say. I don't
>> qualify AS shm expert
>>
>> a) is user space visible, without any good excuse
>
> yes, but maybe we decide that this is not so critical?
> We need more people here :)

It is barely visible.  You have to do something very silly
to see this happening.  It is probably ok, but the work to
verify that nothing cares so that we can safely backport
the change is probably much more work than just updating
the list to handle shmid's for multiple namespaces.


>> c) is probably highest amount of Changes
>
> yep. but ok, I will prepare patches fast.

Given that this is a bug I think c) is the safest option.

A couple of suggestions.
1) We can replace the test "shm_creator != NULL" with
   "list_empty(&shp->shm_clist)" and remove shm_creator.

   Along with replacing "shm_creator = NULL" with
   "list_del_init(&shp->shm_clist)".

2) We can update shmat to do "list_del_init(&shp->shm_clist)"
   upon shmat.  The last unmap will still shm_destroy the
   shm segment as ns->shm_rmid_forced is set.

   For a multi-threaded process I think this will nicely clean up
   the clist, and make it clear that the clist only cares about
   those segments that have been created but never attached.

3) Put a non-reference counted struct ipc_namespace in struct
   shmid_kernel, and use it to remove the namespace parameter
   from shm_destroy.

I think that is enough to fix this bug with no changes in semantics,
no additional memory consumed, and an implementation that is easier
to read and perhaps a little faster.

Eric
