Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 365BF369A95
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 21:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243621AbhDWTBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 15:01:45 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:36607 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhDWTBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 15:01:44 -0400
Received: by mail-lj1-f178.google.com with SMTP id o16so56777145ljp.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 12:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jt0WjA3QstDJmdtc2xOL+sviTt5qIXiiGdH1nAQBv6E=;
        b=PHIIxigM2E+zhewMbBFXSMt+pYKaWKyven45Cd1yIUfcOwHjG3vX8Bc/avyJTTArm4
         uy1oEbw9HmbsSHEUXeZrDcPBPpV1kaRbXFJ0qqiLGiiZy6/4p0zHgrioOn24VgD+o3bO
         iNiq9/szGLtS7ABAmudX9HM8INqtijximUBzHcdN7Yc+10hs0uc6KxTTa0SC4PpkaHuT
         KLvR9jCq7DlhOOPDM1+QMAPig0KFX61YaF0Pn/ptHsrMHUj6tz1SVDGHo/CcYMFCW6Zf
         mbR3GxLimKql37pko6TsNbQe2DnT/FADeBlQ69AUA02fiMnxoq4FfHORa0VbbQxQsImt
         nWVw==
X-Gm-Message-State: AOAM532MlDaLbHJREdrr3meRwKbf11wKR7HJ8y0uiLJzPRGc1CLBXiCU
        M+7ct/lEoeVRGMlQ16LbFd3hR0iba52bbLoyWLE=
X-Google-Smtp-Source: ABdhPJxBBnjd0NlX0jPC6qwDzx9hsXnlp1D6Cy7T8VYvejDhr6ks/HxNNFMPx5/V5me4NqwY27HFPgmH9FsJFeZgyLY=
X-Received: by 2002:a2e:9015:: with SMTP id h21mr3512019ljg.233.1619204466360;
 Fri, 23 Apr 2021 12:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210423182813.1472902-1-namhyung@kernel.org> <20210423184647.GN1401198@tassilo.jf.intel.com>
In-Reply-To: <20210423184647.GN1401198@tassilo.jf.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 24 Apr 2021 04:00:55 +0900
Message-ID: <CAM9d7ciy82RM4UDHeAXwu4p7nPSg58euNK=Kdb7E0mj06e10oQ@mail.gmail.com>
Subject: Re: [PATCHSET 0/5] perf report: Make --stat output more compact
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

On Sat, Apr 24, 2021 at 3:46 AM Andi Kleen <ak@linux.intel.com> wrote:
>
> > So I added --skip-empty (and --no-skip-empty automatically) to suppres
> > the 0 output and add the event stats like below.
>
> I doubt we need the option for this.
>
> But if you change it I would add the percentages after the absolute values.

What kind of percentages are you talking about?

Thanks,
Namhyung
