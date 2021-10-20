Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E805434FCB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 18:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbhJTQNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 12:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhJTQM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 12:12:56 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF83DC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 09:10:41 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id z11so16091157lfj.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 09:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=h+J8kql7ts99MUdmO3b2U3koHRITr97auu7ua3ar878=;
        b=GGgsYRr4ZPlcSxvkp/NcwB3W972FzU6ssWcqZ6uzobBcWvaVbwawRD44BDdY2D+xfz
         1uv4DDU3wSMH030SCj+NvevUWAiU8O+NUsV4VPG19FPPfWZdxmSMZN795snhB8fq0o8U
         L/rgKf+Aur+Ig0SQQuoe1I1OQA7rKZSvOHBfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h+J8kql7ts99MUdmO3b2U3koHRITr97auu7ua3ar878=;
        b=o9/85iLmBXGWUGZhqcxCt6tHb1+G85/qru/JSSrAPa1X+2c8Up1Lp1nAhVNe7v2ZCd
         MEPcHRgl80zl1aB9lQ2UEfcPcAHoPpxOBwuzLBYL7t0SJLbuzlyI5kSfAFrE+ZhfG/jx
         AA2XGoIndHruRTNHqI9uOlXaj+PNKlJQ6kY+AIWCxkLk+v9Agnk75+SqAoHwei/6xGv7
         65MVMvOOfFWvufDr/WNfDGT+iNa0mX8qm6ASxGUhxkZtPVZqAQtbhpmUDFKqOpjJbifE
         pFGQUm9Tc1Ps7QcE6BJIW/pDDB2UXjyqsiMHYAZO6EBj2JLiwxSnA3Hf5R6C9kEDeDyO
         d2xg==
X-Gm-Message-State: AOAM5304/Q1IaqsDfWJSRdnsCTpkJ6spJamrCxsY+8J1cbBdRNvOUI7l
        0P+YLb32B4bUBUvH1dF3fv1qV4dUqvTzXwSN
X-Google-Smtp-Source: ABdhPJxC0t7qufCa+0fVc+9VcCUTyynDmUyiVoz6jWGjjJVdtCtrFLRtfUvNfNDB01vOxR6SkrKfVA==
X-Received: by 2002:ac2:5e7c:: with SMTP id a28mr166928lfr.413.1634746239536;
        Wed, 20 Oct 2021 09:10:39 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id q17sm240187lfr.270.2021.10.20.09.10.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 09:10:39 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id q16so13513141ljg.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 09:10:38 -0700 (PDT)
X-Received: by 2002:a2e:934d:: with SMTP id m13mr322286ljh.191.1634746238625;
 Wed, 20 Oct 2021 09:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20211019091344.65629198@gandalf.local.home>
In-Reply-To: <20211019091344.65629198@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Oct 2021 06:10:22 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjvGRtwMHDJ9VR8197+_rVveqE73Uv-MMFbvuUEbWKNtQ@mail.gmail.com>
Message-ID: <CAHk-=wjvGRtwMHDJ9VR8197+_rVveqE73Uv-MMFbvuUEbWKNtQ@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Fix to recursion protection for 5.15
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 3:13 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> tracing recursion fix:

I've pulled this, but the commit in question shows that you are doing
something wrong in your workflow.

In particular, you seem to have cut-and-pasted email names from some
raw email, and done so incorrectly.

As a result, we have this:

    Cc: =3D?utf-8?b?546L6LSH?=3D <yun.wang@linux.alibaba.com>

which is not a valid name for Yun.

It should have been

    Cc: =E7=8E=8B=E8=B4=87 <yun.wang@linux.alibaba.com>

Either let the email tools do proper decoding of the headers and
cut-and-paste from that, or use one of the explicit tools that do
email header decoding (there's at least a few online ones).

Yeah, yeah, I know, we're much too used to US-ASCII (or, in my case,
the slightly expanded Western Latin1), and there's a couple of other
examples of this in the git history, but we really should strive to
get peoples names right.

                    Linus
