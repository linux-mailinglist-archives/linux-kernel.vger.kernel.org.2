Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68AD63B7D48
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 08:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhF3GM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 02:12:57 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:45951 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbhF3GMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 02:12:12 -0400
Received: by mail-lf1-f46.google.com with SMTP id h15so2892332lfv.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 23:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iRrCIidg3p+53Gp3G45rzdNB0fDCAtNVq4tw07rh17E=;
        b=GOyJ9GZVYmnLV3Zlg/8z+/x4h33OQ3qlM0q5j/MhnC92PGSY/MZTsmKr5JAjzfE6fY
         OLqnGXXAY52wt0UYxs2xDGu4ciINkCWPZV875lDZuUFvqg7ii3+WU3HaxCTBRHcgGmlK
         MvwZ7TgSt2P6K7TokjHMDqfzdh1j89XEcDTdaHNLbZlarORN75mymXhSXBeqfceyuvgr
         eb0JWVCR44qmDmdrLf0Yw3BwTUN5d3PGFgjSWBGGFve0pu7iuULqBARNq/3A4zEi+Z25
         1oeArf1DatAnOxIFwYHDLJZw3me4vrvh47Xz31r/jVqMWaqWuMpujJbOZMeQc6GD4lVz
         4uEQ==
X-Gm-Message-State: AOAM5330rvZXQct3RM8ieoaJonSsIbK5xTfSGcWTXwdD5OxaH5XWB3BH
        L8bDnelAM7IcKqJ00UaHj+4+YGeIuZEXB1Cyuko=
X-Google-Smtp-Source: ABdhPJyLdHzrdIlcN0w/nUWGHFQEFCK+aHbuSFItAWYWWBJ7WPQIq7LI/x841iN7W90xyHCqrCn5ZDl/SDP2LXftPjY=
X-Received: by 2002:a19:4916:: with SMTP id w22mr27050107lfa.374.1625033382693;
 Tue, 29 Jun 2021 23:09:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1624350588.git.alexey.v.bayduraev@linux.intel.com>
 <CAM9d7ciOMPTbwTzHwDp2sjn59KButCQpPOpQsqttopodGC7_kg@mail.gmail.com> <8b738198-c77e-e35e-2bc8-f709d8ec937f@linux.intel.com>
In-Reply-To: <8b738198-c77e-e35e-2bc8-f709d8ec937f@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 29 Jun 2021 23:09:31 -0700
Message-ID: <CAM9d7ci4M5hNTXm4iqj91=DXnC=qUpeWMXAHsFtgBq=J=VTqKw@mail.gmail.com>
Subject: Re: [PATCH v7 00/20] Introduce threaded trace streaming for basic
 perf record operation
To:     "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 1:11 AM Bayduraev, Alexey V
<alexey.v.bayduraev@linux.intel.com> wrote:
>
> Hello,
>
> On 27.06.2021 3:46, Namhyung Kim wrote:
> > Hello,
> >
> > On Tue, Jun 22, 2021 at 1:42 AM Alexey Bayduraev
> > <alexey.v.bayduraev@linux.intel.com> wrote:
> >>
> >> Changes in v7:
> >> - fixed possible crash after out_free_threads label
> >> - added missing pthread_attr_destroy() call
> >> - added check of correctness of user masks
> >> - fixed zsts_data finalization
> >>
> [SNIP]
> > Thanks for your work, mostly looks good now.
> >
> > I have a question, where are the synthesized records saved?
> > Is it the data.0 file?
>
> Thanks for the review.
>
> As I understand the synthesized records (as well as other user-space
> records) are saved to perf.data/data, kernel records are saved to
> perf.data/data.<CPU>

Ah, ok.  I saw you added a reader for the file in patch 20/20.
Maybe we can save all tracking records (task/mmap) there
in the future.

For the patchset,
  Acked-by: Namhyung Kim <namhyung@gmail.com>

Thanks,
Namhyung
