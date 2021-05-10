Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6FC379996
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 00:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhEJWEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 18:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbhEJWEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 18:04:39 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70253C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 15:03:32 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2so25643576lft.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 15:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eF6mHXnyQO/5Hgp+d/GWBsHQqZJ5DW8+q46yqFcmkgU=;
        b=dIK3ZtfyVSK/2JyhHVbLHvpO175CBFwmAuHrOWRfTZFvJNS7aVPDYfvS8vsgzreQfo
         Tk8wzdEV9Ofvm+h6RH+61Aq2wfnsqh2F8uVLezaNiu4FQ1b4TErhFnznIrA/p4zCRTqu
         xEOpxTLeh6QuhQhHeYjI8rBnLkVmtcbpzioz0OAdKfaRLKau49CYRc3w1tkRITK0l37s
         ukasPeDm2Ycqv5nz4Ch8YoHUx87x0PlcbmoCH79UaeYz2qaDnqBU87H/87FrI4bwFBii
         Mhzxr93A8of7z71kPsEhBsucuYQXcWOXE/FHmcgO3muv2dsSvihJmlGDVhe2QokLfofZ
         j78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eF6mHXnyQO/5Hgp+d/GWBsHQqZJ5DW8+q46yqFcmkgU=;
        b=YJ82HbiS2ze3QXK8maQv5sI2cGdOSUWs8u2/Ja26dbvEOJwG+daVDZLp3Ctf/dBzzy
         JOVo/i+PzA5n6prPSMw5mC3sooc3pp9ZTPchANMhsK63p/5uEHRQ2OZUJ6re04uujw/v
         sr4ST8o99aIRTepl8zTdimh6M2rRWSG/8cVC+AkuiFVUelm5/khHWltpqxos9XosYx5o
         DGHEE+Il/6a12yJSL+SiprdYHKkfM07WmMUiSj18IsDQN1Cs50c1QZN+koFRBmCJc1S7
         kn4iKnP5/uC+kkNyYMr/NFTeVSw8dSPxL2yIpmjL4oD1HeynHx0lr/9pdOydI2grlrlq
         I1Yg==
X-Gm-Message-State: AOAM530XCVg4rZx+HcmzESY2O5onDkE6fDJ2/oFunXJeUrNgEeXGcej7
        eT+YuFvS7w13ert5KZFXNdhM3z8qDNjxQDr/U0n2Iw==
X-Google-Smtp-Source: ABdhPJwH9NDUEbITCLratMangmuSCZMAh8LBZRXFn6wipm1zvjC0orG5FJLtySwdzp9n/A6mdx/l6tsaKUQ1eDizbPc=
X-Received: by 2002:a05:6512:1182:: with SMTP id g2mr18581406lfr.117.1620684210724;
 Mon, 10 May 2021 15:03:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210510213946.1667103-1-guro@fb.com>
In-Reply-To: <20210510213946.1667103-1-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 10 May 2021 15:03:19 -0700
Message-ID: <CALvZod6VaGu3CDSamCpjsj7m2uz9KSefjiaF8Ni4=wPY_6ewnQ@mail.gmail.com>
Subject: Re: [PATCH v2] cgroup: inline cgroup_task_freeze()
To:     Roman Gushchin <guro@fb.com>
Cc:     Tejun Heo <tj@kernel.org>, Cgroups <cgroups@vger.kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 2:40 PM Roman Gushchin <guro@fb.com> wrote:
>
> After the introduction of the cgroup.kill there is only one call site
> of cgroup_task_freeze() left: cgroup_exit(). cgroup_task_freeze() is
> currently taking rcu_read_lock() to read task's cgroup flags, but
> because it's always called with css_set_lock locked, the rcu protection
> is excessive.
>
> Simplify the code by inlining cgroup_task_freeze().
>
> v2: fix build
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
