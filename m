Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9155436A8C5
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 20:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhDYSIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 14:08:32 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:38901 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhDYSI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 14:08:27 -0400
Received: by mail-lj1-f172.google.com with SMTP id b38so20254150ljf.5
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 11:07:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iyW3k8OZ0JjKYF5czynTNPixqOW62r5lvj8I3d5bjl8=;
        b=L3xQ924trW1w5oQAmLDCIlYxSDlQFRdJdPnOtppyoNsOa0L0nohwoXDqM9XWrQqprY
         cjXFLmMy+BjlJNUe0HdlRyE0Lya/TfVegxmPs12Pj7N3oPCaKVEKDRcPssrQau7vtZ8U
         WMMnyxSio03jFlV1ETSInZZDJ0Gkfw6chbyNgzyvZphfzDcc42A+dF+Vv6CGjzNY+zHV
         XaW/2BCQNiE2Ahr+U7PY50L95px/J/n5N/8GcvdWNNLn45bMNxl/2zHerbOXBQZO27/1
         YHs078Q4/TmEG18exTy8wfYyvlmEiG4a3q5/tyP8zFzyHqHnKJD8761exjaz4gFuIYdP
         fcQQ==
X-Gm-Message-State: AOAM530gdipqSrFw/2yJUpKBu9ytptvzCWqMUBoInq9uiJH0Hi79cGQg
        YSUNch1nMUVQAPy5ArGazjm9A57vvD4bBaA0GRE=
X-Google-Smtp-Source: ABdhPJwHxVuT5oZ851/pG2GcmoVMNAI0qIaN+Ec6lQrlD1DsG7kKDsb8yTjsv8p5Ay3aKQ7dZytenrh3/jE+kTE2DJ0=
X-Received: by 2002:a2e:9c07:: with SMTP id s7mr9935817lji.26.1619374065435;
 Sun, 25 Apr 2021 11:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210423182813.1472902-1-namhyung@kernel.org> <20210423184647.GN1401198@tassilo.jf.intel.com>
 <CAM9d7ciy82RM4UDHeAXwu4p7nPSg58euNK=Kdb7E0mj06e10oQ@mail.gmail.com> <20210423202024.GO1401198@tassilo.jf.intel.com>
In-Reply-To: <20210423202024.GO1401198@tassilo.jf.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 26 Apr 2021 03:07:34 +0900
Message-ID: <CAM9d7cjKdo6AKAL43-mp+hpx9m_8UU6j8Zy1RUZkLdh27bR_ig@mail.gmail.com>
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

On Sat, Apr 24, 2021 at 5:20 AM Andi Kleen <ak@linux.intel.com> wrote:
>
> On Sat, Apr 24, 2021 at 04:00:55AM +0900, Namhyung Kim wrote:
> > Hi Andi,
> >
> > On Sat, Apr 24, 2021 at 3:46 AM Andi Kleen <ak@linux.intel.com> wrote:
> > >
> > > > So I added --skip-empty (and --no-skip-empty automatically) to suppres
> > > > the 0 output and add the event stats like below.
> > >
> > > I doubt we need the option for this.
> > >
> > > But if you change it I would add the percentages after the absolute values.
> >
> > What kind of percentages are you talking about?
>
> The percentage of that value to the total sum of all the counts.

Hmm.. do you want something like this?

             TOTAL events:      20064
              MMAP events:        239   ( 1.2%)
              COMM events:       1518   ( 7.6%)
              EXIT events:          1   (0.0%)
              FORK events:       1517   (7.6%)
            SAMPLE events:       4015   (20.0%)
             MMAP2 events:      12769   (63.6%)
    ...
