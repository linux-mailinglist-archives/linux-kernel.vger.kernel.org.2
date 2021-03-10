Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6FA63341A5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 16:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbhCJPgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 10:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbhCJPgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 10:36:11 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB52AC061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 07:36:10 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id d20so19491397oiw.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 07:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A/E9kQ5Uo1gvORiM39VYVMz1qLELRHsxm4ZfQ2Ba1Pc=;
        b=C/fYb1rPn2lYTjZyilsNcgD7bmyM8JrocFqLFJxMLeXFKg9Qc+8QqaeWRzFq0hp4Oo
         I8hgW4GJuGst0rt6Za/ivCnF1vrlGxChnH4ZApcMQDcsEFcg0K9RswuQ7VirYad+xRSU
         syPPzylCP/oR7GQefNgiQpGqUUvuOKK7RtL71c7yYapai5imZhSRYf6bUR4ahdUXCLsS
         Ogne7nKas/vVBtYZGTQF89YLcGODyA906cNgRYxaiNEkoYH/ioht8010m7Qf6gNsFt24
         UdUH5u4WzFMGHmsZdtapQnuguz5Q9w9h+vafSd3PXLg8T7amjuqMgF/fnwInolEmMtX7
         ZuBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A/E9kQ5Uo1gvORiM39VYVMz1qLELRHsxm4ZfQ2Ba1Pc=;
        b=A9HXSSwfZpIec2U7GB6IWtfsfsmg6Xekvq2i39b0qf3wIrUsCvd8IpvxaUAWcLh0Iu
         cq/PRIVupbUM+G0FwOMwa7A165hSdxtAUA1soZETIixznz2oozQYRXg4LER+nqrTRsM+
         AuzT9ve/3TNZM727jkXcBEIN1G6Q8Bcg3lKyz0uajGqS5z2/+B9w2mgfv5eMHdb8gOeD
         EMuP85uXyOkf2w/8OPcGmeoj7tHCnMCeUqr9bpUkaIhCaDUhtIsWHBf5m8ho+fYCn826
         HxavITDIOuhq842kCLSDGLE6lQLH7bEPzlOtXBoGfRnfkFtc/99vT4lxLbClCVkKfJiW
         VlXQ==
X-Gm-Message-State: AOAM5316lWP/MnKYIa+SJwYkfDgK6oLNKmbsiqmf+LRx/jDawrx9742Y
        6kX9nV3Et6ppuK3q6unhv13Y7csobMXexhr0oyri/A==
X-Google-Smtp-Source: ABdhPJyIGJXLWZ3SLUmhdkRgYDdPq4kh3OwT9XIQrMx6wWWm+zEVQjVLXqAmMKPABMJQ7GVe71jtICGJzhFHymAM688=
X-Received: by 2002:a05:6808:1450:: with SMTP id x16mr2773457oiv.6.1615390569935;
 Wed, 10 Mar 2021 07:36:09 -0800 (PST)
MIME-Version: 1.0
References: <20210310152333.1291338-1-ak@linux.intel.com>
In-Reply-To: <20210310152333.1291338-1-ak@linux.intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 10 Mar 2021 07:35:58 -0800
Message-ID: <CALMp9eQ9yV0Q_Op5U6M0xuPcq5cDZZFAG+tDqBL3J=Kk6Z1ekw@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/kvm: Fix inverted pebs_no_isolation check
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 7:24 AM Andi Kleen <ak@linux.intel.com> wrote:
>
> The pebs_no_isolation optimization check is inverted. We want to disable
> PEBS isolation when the microcode is at least the revision in the table,
> not for older microcode. So remove the extra !.
The original code was correct because of the double negative. A "good"
CPU _has_ PEBS isolation. It's bad to have pebs_no_isolation.
