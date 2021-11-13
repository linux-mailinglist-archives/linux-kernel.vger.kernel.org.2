Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9C244F1E8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 07:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbhKMGwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 01:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbhKMGwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 01:52:43 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08102C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 22:49:52 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id 64-20020a4a0d43000000b002b866fa13eeso3704218oob.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 22:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2csE+vfv+2C2Bz2Yg7KDQ9CqRXO/lvNFRQTf9C1HtyE=;
        b=O5ScEO9Lnymlxgtrt0VnwhAOUfh6wUMFcWezCUuVHgW5qzBDLhfcUGP+XXkdMKQdTZ
         t2YPupfg0cTo5epRZ+NEVN+96JFbfxiOQZfoPwoeGYOQCt1gKubanZ8Xpq02sq4Xldb9
         DgsbKNc4InO5E83J5hExxe/MvT++eKnb+FKplhjQ1uFL55cjsqvM6socxCuaM+gxW7rT
         /3GhtKRBSS9M2sylVTCmIFcRhE53RyKBzaPk3wrTiF9eHcmgFLdfRd5ANDBQd1o0JlVr
         h1eh4e3aQq2pwre62N4vkUPG7qWFeUQTlko19Vnne4CUL8JQf0v7T21xc3OonMfEmkHB
         2UCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2csE+vfv+2C2Bz2Yg7KDQ9CqRXO/lvNFRQTf9C1HtyE=;
        b=Jxdq3ITJCX7FR8M0V3OdtIWEJ8+z1t7zM4jTSa9PuwIRYjY4A3v3J1JI6VHficRv+x
         0m1t5j+gIkEkRqv7PTO7n7m6WL+40kVfRLZhKWtlGSJ4G6YVcdEu1hHDrvC/GVHcbbdt
         nwFvzmSYQ7KbahsOZVd5zYYnwODCAFFWvpewD2KJ8jJWl/XAWVUqMDkaYF/3MV9AeVD4
         YhSp0zxYU/0XDPTMm01l4BK7oeiPAiEq6TFaUI/t1cyKewt0Kcky5jbqCxDPVXBuhvzV
         sZslBtzn+kWyw57aSI/GgqA8bt7PnWu0XPmNlJyelzlyZAxYaeStGJVNR2kGWeKeJzOB
         LyHA==
X-Gm-Message-State: AOAM532/Iycn0TerJIBvzVgn6ebgeMpQSGhnqeWkZ2tIqo2bk2DLCSVI
        n++e3h+fdO92eK1U+mqIfXYegUWj2OSi7/sfNwM6TA==
X-Google-Smtp-Source: ABdhPJxMWxdpfcGoVS97J2AbMPmA0ST2r4Bw+GFy5CqvCIbF6DvvD0V0naRL3hjqIPOrVn/FrIjFt2H7TA755ioyTVM=
X-Received: by 2002:a4a:d5c8:: with SMTP id a8mr11706781oot.18.1636786191098;
 Fri, 12 Nov 2021 22:49:51 -0800 (PST)
MIME-Version: 1.0
References: <YY9ECKyPtDbD9q8q@qian-HP-Z2-SFF-G5-Workstation> <YY9WKU/cnQI4xqNE@qian-HP-Z2-SFF-G5-Workstation>
In-Reply-To: <YY9WKU/cnQI4xqNE@qian-HP-Z2-SFF-G5-Workstation>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 13 Nov 2021 07:49:39 +0100
Message-ID: <CACT4Y+bj7JU=5Db=bAafjNKJcezeczzDCTwpKvhhC8kESc5+kQ@mail.gmail.com>
Subject: Re: KASAN + CPU soft-hotplug = stack-out-of-bounds at cpuinfo_store_cpu
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Nov 2021 at 07:07, Qian Cai <quic_qiancai@quicinc.com> wrote:
>
> On Fri, Nov 12, 2021 at 11:50:19PM -0500, Qian Cai wrote:
> > FYI, running CPU soft-hotplug with KASAN on arm64 defconfig will
> > always trigger a stack-out-of-bounds below.
>
> Actually, KASAN is not enough to trigger. It needs some addition
> debugging options to reproduce. I'll narrow it down later. Anyway,
> this one will reproduce.
>
> http://lsbug.org/tmp/config-bad-14rc1.txt

This may be just a bad format string.
But I don't see kernel/printk/printk.c:2264 doing any printk on
next-20211110. What's up with line numbers?
