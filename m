Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8521C4286DC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 08:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbhJKGeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 02:34:12 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:42144
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231425AbhJKGeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 02:34:10 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8F8A23FFD9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 06:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633933928;
        bh=lwPipFh22ocDNcUOEMMzIfuiqy6HWce+IYzbCS/BeoI=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=nxEy/w5rIvrdRUi7ndV/Za9X7t0GqOASEwWzu0aKNlcm5kJW2IVyTUdi3xui0PHim
         QJWdfnpLWu1I0WzoGi7m/NhVPlVZkXpDyvA6+YYREuNli4GxpfqeHCwZAEMVs+w0dD
         VjnNGA3rHNCB6vajf6Hu83MslwVYaoD0RLka8HIgaONMjtllYKvbt3CDbjxXP7mfPz
         zVHB6fC0blGV7KgBLwd1h9q7lRkeEtkKF53dAcPHkp1FZ6wFHYMC2fNp7R99iUXwIr
         5R9dhl9WgSoqUo2FzJEkGHuB81g8RGL9bJ7rGlFmAWYPsFIpKLDJ8nvEwH6kEZS881
         S6purO0WyoUqQ==
Received: by mail-ed1-f72.google.com with SMTP id u23-20020a50a417000000b003db23c7e5e2so14936283edb.8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 23:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lwPipFh22ocDNcUOEMMzIfuiqy6HWce+IYzbCS/BeoI=;
        b=Ss1emeCKJvGr+Akk+YtprRU8ESKikywK1tEUSN2F8WOx8xH9je44mbv5jqFjueQ3TE
         oMukezVbbxhkgRIqxrbhLp0+NlStsCpvVA76haN/IORAAJ4nblZV7mLNxd7PPy7id5JZ
         I0yFOnWMLBKtzIL24IxgmgWWlmvppVQ1AI12H1beuO88JiHsZi7tJQWy+SKXfYkXULYm
         LK9ezFguAqxXiL3VA/uiCGhaYncY3HF66dUptl6N1u7l1lkljowMGStuKkb0jZwewHAL
         LHeySU6I+Ihm/MQunANImfqYgOThsJ022PxoGU207ks3lF8bVPXK20bzVa6rIXy60BgL
         1pyw==
X-Gm-Message-State: AOAM531Qd8Fn//jB4fX2ZZk8SfoYEICGAx969uwgwVdbNRfEjrkPu/YQ
        bhvWjRRTcsqPnEmzJdR3Eutc+OwKesU32AZwKjmmD9IBcV5PEps+J+C7fJ/yUFQHt1A6UVRuJaj
        YCd4xD01bZp9h+qPoJ9Agcjqgpm/InQgJX/dNXKprQw==
X-Received: by 2002:a17:907:334f:: with SMTP id yr15mr7244665ejb.8.1633933928111;
        Sun, 10 Oct 2021 23:32:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyiQVas22w3YLNrLfxsQfnioldXrMyoqDjEYmIYtoIDG9IU242B0gbfD03+5OA9YzDxoQlL+Q==
X-Received: by 2002:a17:907:334f:: with SMTP id yr15mr7244636ejb.8.1633933927912;
        Sun, 10 Oct 2021 23:32:07 -0700 (PDT)
Received: from localhost ([2001:67c:1560:8007::aac:c1b6])
        by smtp.gmail.com with ESMTPSA id o15sm2945745ejj.10.2021.10.10.23.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 23:32:07 -0700 (PDT)
Date:   Mon, 11 Oct 2021 08:32:05 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Marco Elver <elver@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: BUG: soft lockup in __kmalloc_node() with KFENCE enabled
Message-ID: <YWPaZSX4WyOwilW+@arighi-desktop>
References: <YWLwUUNuRrO7AxtM@arighi-desktop>
 <CANpmjNOw--ZNyhmn-GjuqU+aH5T98HMmBoCM4z=JFvajC913Qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOw--ZNyhmn-GjuqU+aH5T98HMmBoCM4z=JFvajC913Qg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 08:00:00AM +0200, Marco Elver wrote:
> On Sun, 10 Oct 2021 at 15:53, Andrea Righi <andrea.righi@canonical.com> wrote:
> > I can systematically reproduce the following soft lockup w/ the latest
> > 5.15-rc4 kernel (and all the 5.14, 5.13 and 5.12 kernels that I've
> > tested so far).
> >
> > I've found this issue by running systemd autopkgtest (I'm using the
> > latest systemd in Ubuntu - 248.3-1ubuntu7 - but it should happen with
> > any recent version of systemd).
> >
> > I'm running this test inside a local KVM instance and apparently systemd
> > is starting up its own KVM instances to run its tests, so the context is
> > a nested KVM scenario (even if I don't think the nested KVM part really
> > matters).
> >
> > Here's the oops:
> >
> > [   36.466565] watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [udevadm:333]
> > [   36.466565] Modules linked in: btrfs blake2b_generic zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear psmouse floppy
> > [   36.466565] CPU: 0 PID: 333 Comm: udevadm Not tainted 5.15-rc4
> > [   36.466565] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
> [...]
> >
> > If I disable CONFIG_KFENCE the soft lockup doesn't happen and systemd
> > autotest completes just fine.
> >
> > We've decided to disable KFENCE in the latest Ubuntu Impish kernel
> > (5.13) for now, because of this issue, but I'm still investigating
> > trying to better understand the problem.
> >
> > Any hint / suggestion?
> 
> Can you confirm this is not a QEMU TCG instance? There's been a known
> issue with it: https://bugs.launchpad.net/qemu/+bug/1920934

It looks like systemd is running qemu-system-x86 without any "accel"
options, so IIUC the instance shouldn't use TCG. Is this a correct
assumption or is there a better way to check?

> 
> One thing that I've been wondering is, if we can make
> CONFIG_KFENCE_STATIC_KEYS=n the default, because the static keys
> approach is becoming more trouble than it's worth. It requires us to
> re-benchmark the defaults. If you're thinking of turning KFENCE on by
> default (i.e. CONFIG_KFENCE_SAMPLE_INTERVAL non-zero), you could make
> this decision for Ubuntu with whatever sample interval you choose.
> We've found that for large deployments 500ms or above is more than
> adequate.

Another thing that I forgot to mention is that with
CONFIG_KFENCE_STATIC_KEYS=n the soft lockup doesn't seem to happen.

Thanks,
-Andrea
