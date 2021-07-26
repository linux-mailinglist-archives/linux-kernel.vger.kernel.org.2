Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2EC13D612C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 18:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhGZPaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 11:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235893AbhGZPRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 11:17:06 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31EFC061764
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 08:57:33 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id t4so5354171qvj.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 08:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=No1idDzjoDsMmvN3xuwWOow2oVTtEvU8MGBu5PU6/sM=;
        b=ssT65GvNumoWqL6ydnEmW5Lcm8Zg8hEIXfManz/C9Atw1meiX/2aaUaNlU6EQhHE4W
         /WhjABLzVj9ld0JjUq+XnLGJ+OueQFMRKxl3IRDGxikC5jPgsKPszOPDMqOhumZFESMe
         fHpvENQmaGQlOBGsJmSFsqO9lkQJ+EmVvlIRrG4TnDaeiXhiWk0DlnayBwCwH/gFQqrp
         cgXzpRT+pyhTVowbS6CIkNwuojsq2Gg/Hmiytvggd6Wn6eWeYhqinewDjLlttfECXT4O
         fZKcGg6mOviwvxBtB985ox7LCzyU1EzuMtJVhhIWWwNi01P/zy9dNgcPe71j/d96ALaX
         +q5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=No1idDzjoDsMmvN3xuwWOow2oVTtEvU8MGBu5PU6/sM=;
        b=SyPIre7oLgIwmEkV0L7VzOO0dGpfFkPk9CLeHEgsaGXfk2KkOg8YnbH6fz3acPwyeD
         tR1cry+oGK/rjYEjnvtocsuK4GGM0VNHbnLxO+0PdJx84iJRD/hu0TLxJsSJ67FJ7vu5
         tn0QGzclWDuEiL5Rp3cGSed8SZfHtvGRgcW2JLuuUZdb89VbnsyE6tgIvKpRF6zsabwT
         yeQ8M2+fnA+s0QtyEUNNmWS7a64Ru3crda3MYx1W0bAx5M55lHykGE9kK3zN23AaOK3o
         Ef4aMu53dIbMerPMHAdHe7ajzd56w73qFVlUkQ0CRPbBq0bXpvEJ99bSqCmWgKhPXh8y
         d6Rg==
X-Gm-Message-State: AOAM532ZdljCjjliqWcwJodJSCfW3BC0QrBZvxj6pqTqIFFQM5oI3qbO
        vPGWbPiecU9qlRkiA/kyAoN9fulFX0yMiuFgD252aA==
X-Google-Smtp-Source: ABdhPJw6uFTdt9Q6d69+oxxRgZenuF9SRtyMwB9oNBD1/2H1OclxjYSTBFaYzAiNV+iibs75SaZ6BLSB7154joJYymo=
X-Received: by 2002:a05:6214:c29:: with SMTP id a9mr18649044qvd.0.1627315052531;
 Mon, 26 Jul 2021 08:57:32 -0700 (PDT)
MIME-Version: 1.0
References: <PH0PR11MB51748333769D9002912FF63C84E89@PH0PR11MB5174.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB51748333769D9002912FF63C84E89@PH0PR11MB5174.namprd11.prod.outlook.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Mon, 26 Jul 2021 11:57:21 -0400
Message-ID: <CAJWu+oq98Yh4kknze7u6SOYZNw6hR5aFkj61aXbTV3JPq=7RNg@mail.gmail.com>
Subject: Re: Core Scheduling - Concurrent VMs
To:     "Rajendran, Jaishankar" <jaishankar.rajendran@intel.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Vineeth Pillai <vineethrp@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Mallikarjun Chegaraddi, Raju" 
        <raju.mallikarjun.chegaraddi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
+Dario Faggioli and +Vineeth Pillai as well.

On Mon, Jul 26, 2021 at 1:41 AM Rajendran, Jaishankar
<jaishankar.rajendran@intel.com> wrote:
>
> Refer to the below experiments performed using Core Scheduling for Concurrent VMs and we found the benchmark scores executed in different VMs are
> degrading after enablement of Core Scheduling. Both the host and guest are enabled with Core Scheduler

Why are you running core scheduling within the guest? Only the host
needs it and you tag vCPU threads in the host. Within the guest you
don't need it (and it probably doesn't make sense unless you pin the
vCPU threads to individual physical hardware threads).

>
> Environment:
> ++++++++++
> Platform - CML-NUC - i5-10600 @ 3.3 Ghz
> Core Assignment for Host OS : No .of Cores     : 4   No .of Threads : 4 ( i.e. 8 Logical Cores)
> Host OS - Ubuntu 20.1 with Chromium Kernel 5.4
> Guest OS - Android OS running as VM using qemu/kvm with Chromium Kernel 5.4
> VM's are assigned with 4 cores and 4 Threads (i.e. 8 Logical Cores)
>
> Kernel Config:
> +++++++++++
> Host and Guest OS Kernel is enabled with CONFIG_SCHED_CORE=y
>
> CGROUP Mapping:
> ++++++++++++++++
> We did follow the CGroup approach for Core Scheduling based on the below document
> https://lkml.org/lkml/2021/1/22/1469
>  and configured the CGroup. But not able to find cpu.core_tag file in CGroups?
>
> VM1 (Android OS running using qemu/KVM) is executed and its default cgroup is changed to caas1
> VM2 (Android OS running using qemu/KVM) is executed and its default cgroup is changed to caas2

It is not clear to me how the individual vCPU threads are tagged so it
is hard to say much.

> The changes are validated using htop command.
>
> WorkLoad:
> +++++++++
> GeekBench 5.3.1 - Multi core Test executed on both the VMs
>
> Observations:
> ++++++++++++
> As per core CORE_SCHEDULER documentation, (vCPU) Threads of VM1 & VM2 (belonging to two different cgroups ) should not be scheduled on the same core at a given time.
> But we observe that vCPU Threads of different VMs are scheduled in the same core ( Used HTOP and ps commands)

I don't think these commands can really tell you that core scheduler
is working or not. They are too coarse grained. You would need to look
at it through ftrace scheduling events. Core scheduling will still
allow differently tagged threads to use a core, it is just that it
wont allow it simultaneously.

Also just to note, in ChromeOS, we are working on some changes to tag
the whole Android VM with same tag (all vCPU threads in a single VM
can share a core) which should improve performance. Previously we were
putting different tags for each vCPU thread of the Android VM which
seemed overkill.
