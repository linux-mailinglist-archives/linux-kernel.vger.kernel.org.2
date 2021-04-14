Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58DAF35EA09
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 02:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348892AbhDNAfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 20:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348287AbhDNAfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 20:35:03 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A24C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 17:34:41 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id u17so28744260ejk.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 17:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c5+O5EWDGELCD8DgeUp7bbX4iy5UvIKCg6uMDjassJE=;
        b=x8RMJ0uOn2YBsm1bLIWOl09dn1C8PHLGqc5Tv7zu0l2iTKDcgvT+OLH4gNQINA7UHZ
         YIhHEfh+W+X/MWH97NfLDWX4IlPRzNFjGAkSYj1TPluQng5PKoxNG0somoU2acrXaAoD
         9GHa53IJeclI6MoeraUsYGRZi0acJ9WlphVtudsMPsRFaOGijInje76/jzzGeJ6HRn7e
         O95dmx8vmKYNO5CG/NuWH2ZzC8aEyNMa3KKCzmE1UpzaFPN1pERStUizSsZc7D3cbfDL
         UyrcmhhW22YsXcQBSBdWXVUR7gxa/F86PkSP2YNOJvjHy4bGuZHySv7945vTdX1uoh/6
         N8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c5+O5EWDGELCD8DgeUp7bbX4iy5UvIKCg6uMDjassJE=;
        b=PsW6YMsGrFEj6I1qQCS2Fh1Eh2PpmFWDoVnJeYh3hn6N1oBBf1BIhLmuSCElrfsQ1R
         Kk5IVz+gBDnT9Dekkuo+sL5nXpECvQN9DTyOu30/hbhHWNSc25AJZdU9MPg7pdjOKStx
         GmzqUOf/RUPd5nJE0srXt/y2i7UPykykWNLhMUnphg+ow2p9/ny/UGxnq4KmmxCvrk/3
         vDxCEdre+DCqj0xp3KVDIn7GJ6z3TnYsw9KDzaiVDo69cHVZKTtgAtp/Nh8JKBDHBBNT
         aKusRTFeZyt02rvFZeeL2/jyAqhavyZdzQRi3+wSZjDp9JyXAtZiCwYg/QBK9XsoRHBw
         +SaQ==
X-Gm-Message-State: AOAM533nK0ilQroGOylz54GVPG7LgLkvcjBkq0618Jz3h/RligYpMIL4
        UylCUI5W8TxvYGvHPzl3rD32kJjNx1TmV0NG7Lq9mg==
X-Google-Smtp-Source: ABdhPJyv9yMWI2fakCSPIIr7ZyafZlLRE7DawhIDH7NQMuJ0GulTY3eCa0lZhR3phDwGX5EWxcT21n3hIZclRg+5RBI=
X-Received: by 2002:a17:906:4f91:: with SMTP id o17mr34979155eju.503.1618360480436;
 Tue, 13 Apr 2021 17:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <1618340250-29027-1-git-send-email-kan.liang@linux.intel.com> <1618340250-29027-2-git-send-email-kan.liang@linux.intel.com>
In-Reply-To: <1618340250-29027-2-git-send-email-kan.liang@linux.intel.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Tue, 13 Apr 2021 17:34:29 -0700
Message-ID: <CALCETrVVPzUd_hQ8xoomHn_wWRQJUvROeCt2do4_D4ROZoAVMg@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] perf/x86: Reset the dirty counter to prevent the
 leak for an RDPMC task
To:     kan.liang@linux.intel.com
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 12:05 PM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> The counter value of a perf task may leak to another RDPMC task.
> For example, a perf stat task as below is running on CPU 0.
>
>     perf stat -e 'branches,cycles' -- taskset -c 0 ./workload

I assume this doesn't fix the leak if the sensitive counter is systemwide?

Could Intel please add proper security and ideally virtualization for
this?  Ideally RDPMC permission would be a bitmask for all RDPMC-able
counters, not just a single on/off switch.

-Andy
