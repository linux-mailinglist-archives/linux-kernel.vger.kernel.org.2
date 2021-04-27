Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C2736C781
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 16:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238263AbhD0OGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 10:06:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:54820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236074AbhD0OGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 10:06:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9542B613DE
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 14:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619532350;
        bh=fy3CYi7BqJJdl/r3iPs3eZ4UiVL7usbFkRW1ao2uWt0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ao8V084H63JV4GUymCNWzXeX2/V89RTI0OQYLL35lB33h2i/jZ0PZ9APIFoXFhdJa
         t9C1iSZApnBzeoOCLzaeDk8uikyQIymIi02WavTFBBirCwS/KMBv+d6slirb0XLmIE
         MGNJbB8hipSKnvKdWyqHy74xl+95ZZw3Wnn7M98bTrrNVqPPjVZbPCOqzoKbyYk2W1
         YHMxOTeT6MlY7XDEqL1RTHnQD9Gq08c76/gOqupTVVQgnNjlXnM+CdOZHZlCgpKqwZ
         omDHZ3YgttgRWFw8gFKp2Gj7/6vYnv4IGKC6O7xMp0NBLWvaWUuJUCQYb98yeGbwiH
         Wcdt2Kx37+PvA==
Received: by mail-ed1-f45.google.com with SMTP id g10so2140579edb.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 07:05:50 -0700 (PDT)
X-Gm-Message-State: AOAM532mip1fVtzB4QLARNE/mS8sFjk8daRwaalAgwLs0ZjxpX/vdZYX
        S+zcuW4gxcXY5x1LTJgXiw9OgJ1ymHS+9gzB+g==
X-Google-Smtp-Source: ABdhPJzYJHjginYKmJvGlKi37gvPyFmM2boVwhYaPwHwlMcARmiUe3NWgzmG3JK4LvfqVZViFmgeZQbfrs8FcpV7hog=
X-Received: by 2002:a05:6402:1a52:: with SMTP id bf18mr4609112edb.289.1619532349176;
 Tue, 27 Apr 2021 07:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210427134852.1411642-1-robh@kernel.org> <20210427135506.GC37475@C02TD0UTHF1T.local>
In-Reply-To: <20210427135506.GC37475@C02TD0UTHF1T.local>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 27 Apr 2021 09:05:37 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+s+9TVBaeGjRxKa+-DKJqO_ZUUJGgYsJOv5xauMDUgpA@mail.gmail.com>
Message-ID: <CAL_Jsq+s+9TVBaeGjRxKa+-DKJqO_ZUUJGgYsJOv5xauMDUgpA@mail.gmail.com>
Subject: Re: [PATCH] arm64: perf: Ensure EL0 access is disabled at reset
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 8:55 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Apr 27, 2021 at 08:48:52AM -0500, Rob Herring wrote:
> > The ER, SW, and EN bits in the PMUSERENR_EL0 register are UNKNOWN at
> > reset and the register is never initialized, so EL0 access could be
> > enabled by default on some implementations. Let's initialize
> > PMUSERENR_EL0 to a known state with EL0 access disabled.
>
> We reset PMUSERENR_EL0 via the reset_pmuserenr_el0 macro, called from
> __cpu_setup when a CPU is onlined and from cpu_do_resume() when a CPU
> returns from a context-destructive idle state. We do it there so that
> it's handled even if a kernel isn't built with perf support.

Indeed.

> AFAICT, that *should* do the right thing -- are you seeing UNKNOWN
> values, or was this found by inspection?

Inspection. Sorry for the noise.

Rob
