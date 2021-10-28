Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF6A43F2B9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 00:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbhJ1W26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 18:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbhJ1W24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 18:28:56 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80471C061745
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 15:26:29 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id q127so9127159iod.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 15:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=69slPYPdxoIP5E1pXozkkOSJJNlQJg/ZybGsQcAlQjU=;
        b=ZvebgKH3pRDT+eHN8yyyqshk7Xwtu0s+RNmQNKAF4bGCFh8HihuoQwIeVuENvHdO95
         K4pfwh4RoUL60H8qNDvbEG+LIbiwhhNCY6AB8N/i63ofgqTMFXz5RCgUwqZQt813ldX8
         xl34jWj15whFLfTX5t4DCQ8y4p545xs63NbwFJlDgG2CyVMvsV+6DPaoKl7czrrymczA
         TkUHOP80lNP15DfhPKvonioyjWR3HaLSrut5ke4tpWu3vINXuVvw27Jal3DQZ+tk+Gtt
         hX0IEZtROh08TtZN4+4mGfm11giUEgwoWxwtDIbMMyyM2KZbz9hRdDivvc2guFYXj9Pj
         N72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=69slPYPdxoIP5E1pXozkkOSJJNlQJg/ZybGsQcAlQjU=;
        b=aYAH9Zun5q9z+21fhQ1ywj1bxoO3NV/x05xSqZoZ9oSczVNFMWTRQT0HZlTza2CuzN
         hXYy2o8yVSXpEaOPuHcRJdHjxa4IENyqfK5HM2yGwPYnEPXEGca0HsOw1FrL2tZKkx5I
         WSAooQeiLBUwn/VRCra7PtENgFEWAhXD6NU9knQwDwGjxWuMkfo/6ioT/c8MMESdlazU
         a1a1Kwxu+Vpfp4wri8kxGF7AKNMHv1TeS4UKrtilZZdJl1XuE4PzvcdrXv7dR2AoNiIP
         uFcHvqkygdheAQjXOhGgdgq9xeoDVPW0MjXkKF3zLFXTH8b0s1c89OMohxCMIXohdCSn
         5PzA==
X-Gm-Message-State: AOAM530iVdlYrXWVd49nz2Gz7NthZEtK50dY2zdJ+ilBoBIZVjAeffHl
        ZjDzftkDbSTGPRkETmUGFrgyoCW9WkasV0hmBv54Pw==
X-Google-Smtp-Source: ABdhPJzNqekMMxyk/B5nOTuy7BzBzfXpYdqoOl1hZ7GQRZVBtPFvvGSBBp2ksLmDaN2z5nG15SHOxsvOfYayG4y1uoE=
X-Received: by 2002:a05:6602:13d3:: with SMTP id o19mr4969665iov.18.1635459988715;
 Thu, 28 Oct 2021 15:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <20211012021321.291635-1-irogers@google.com> <CAFP8O3L_Oi916yOAuPB7MFpa3QoDQtreRbV7oNt2Yh6h1Coq9A@mail.gmail.com>
In-Reply-To: <CAFP8O3L_Oi916yOAuPB7MFpa3QoDQtreRbV7oNt2Yh6h1Coq9A@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 28 Oct 2021 15:26:16 -0700
Message-ID: <CAP-5=fU_Zf4w2K-uEM40Wr0o-v6O+3vQTfEjAJu842HdyotZHw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tools: Bump minimum LLVM C++ std to GNU++14
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Leo Yan <leo.yan@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

Is there anything you'd like me to do extra for these two patches?

Thanks,
Ian

On Mon, Oct 11, 2021 at 8:09 PM F=C4=81ng-ru=C3=AC S=C3=B2ng <maskray@googl=
e.com> wrote:
>
> On Mon, Oct 11, 2021 at 7:13 PM Ian Rogers <irogers@google.com> wrote:
> >
> > LLVM 9 (current release is LLVM 13) moved the minimum C++ version to
> > GNU++14. Bump the version numbers in the feature test and perf build.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
>
> Reviewed-by: Fangrui Song <maskray@google.com>
