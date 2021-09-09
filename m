Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85111405B4C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 18:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239858AbhIIQvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 12:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234524AbhIIQvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 12:51:44 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5BAC061575
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 09:50:34 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id s3so3978360ljp.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 09:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=I16UVI1xVNxqcbO392QGXtKnK4wf/LUEXByP19oIeTk=;
        b=Ts2msjDfBeODNwvVyn3lwhkrQzPDGDljScDheKIeHLjMmkvMh7yGfx688Vm87Hv5D/
         RF65aHED9Q5juZc+DoS23IdDOeQgwYzCoXIrXr5Fw4VOE7FTPw3mx+H/yRoXJ4YoKHRk
         2toWXQn8T84Uwzeqeh0micHUDl6U5YT3P2zgfa2f/NNEwx0LV36LXvFpCPDXLbr8V7fM
         5YRQrdmhm2pTpZdbRv39VwXOMaJ52wXaSiRHqj4TVSIb7KgrDhxfRfxzCXtoi+dTr2nd
         j8hZGk/fqXUJadr8sgos3olZOpt8LLlGqPp2jOdwOpHYO6Ovzu0YNtoyoutkl6jMzO/0
         mCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I16UVI1xVNxqcbO392QGXtKnK4wf/LUEXByP19oIeTk=;
        b=f8gKL8iWAq+oghTxdSViMC+OgThdfQu7hzaVNc0ev+XggK2z/EFJXd+FpZEtTKDk33
         0iO+6GFxHfgLz7wnYOkbj9JV46FlpnJ4ayhmA4KIukBi6/ea479k7rCRamxgIeWUlEKY
         z6bEBMuDoW8vTqfPNXKIMcsITXMWS41jiWq1wnkmTgiJzgao6wfm/KgD3bXr/phHvPUd
         oNpVIxSHq5kj/m+NRU3prhJqLiD20rsdLHtNurZMtB7el4yuEBc+Kw8jNEFN/XvqymRm
         LTyqo5RMnB/7ajKGszOSiXOSAGaS8OYwssCOpCm5WWB53OtcMDEiEvovbFjq1v7NXIYa
         JNbQ==
X-Gm-Message-State: AOAM5315aFS7VYWBw/n9n90U6qujTIBWsxw9q9MAK1W1oA7XDqlkkDsx
        bImTlXt5REq1I5aWkKnVmWZbPRAm2zk0bZJbNs2eNA==
X-Google-Smtp-Source: ABdhPJzsq+40EzV4QjbIXO9dYnNo3PtCyHv2QiJiQaPtGgeQiWLSJR50jmB2S74ONZs4Ir7Zr6hyKPjYJjCgFbiffgo=
X-Received: by 2002:a2e:858e:: with SMTP id b14mr656887lji.508.1631206232900;
 Thu, 09 Sep 2021 09:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <988f340462a1a3c62b7dc2c64ceb89a4c0a00552.1631077837.git.brookxu@tencent.com>
 <86e89df640f2b4a65dd77bdbab8152fa8e8f5bf1.1631077837.git.brookxu@tencent.com> <20210909143720.GA14709@blackbody.suse.cz>
In-Reply-To: <20210909143720.GA14709@blackbody.suse.cz>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Thu, 9 Sep 2021 09:49:56 -0700
Message-ID: <CAHVum0ffLr+MsF0O+yEWKcdpR0J0TQx6GdDxeZFZY7utZT8=KA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] misc_cgroup: remove error log to avoid log flood
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     brookxu <brookxu.cn@gmail.com>, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 9, 2021 at 7:37 AM Michal Koutn=C3=BD <mkoutny@suse.com> wrote:
>
> On Wed, Sep 08, 2021 at 01:24:36PM +0800, brookxu <brookxu.cn@gmail.com> =
wrote:
>
> So there could be two type of events (not referring to the v1-specific
> failcnt):
> - max - number of times the cgroup's misc.max was hit,
> - fail - number of times operation failed (rejected) in the cgroup.
>
> The former would tell you which limit is probably set too low, the
> latter would capture which cgroup workload is affected. (The difference
> would become apparent with >1 level deep hierarchies.)

We are adding two files in this patch series, misc.events and
misc.events.local. I think "fail" should go in misc.events.local and
its name should be changed to "max". So, both files will have "max"
entry but the one in misc.events will refer to the failures in the
current cgroup and its children, and the one in misc.events.local will
refer to the originating cgroup.

>
> Regards,
> Michal
>
> [1] https://lore.kernel.org/lkml/20191202191100.GF16681@devbig004.ftw2.fa=
cebook.com/
>
