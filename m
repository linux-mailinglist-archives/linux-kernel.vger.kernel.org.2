Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C744442E0AF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 20:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhJNSDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 14:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbhJNSDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 14:03:32 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D606C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 11:01:27 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id w11so4410161ilv.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 11:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V5nE6QghnmtWowiOD0uX4lLlJm9ZIC6qs5oWJU6v2UQ=;
        b=bxEoBauZxrnW8a9O/6vJa8qZ28kgG9aTOaDYd3Kl3S877go8osilbIoaDxC+Fpyx7P
         jNa6CQe25+XZnxjyBmtz+mJbwkJnIGthEbUYEaT7D6lLdX257i2up/NUNoyLmczxkaL1
         a97//UWDxab326/2v0MN0lV+I0IkFSxUrj64LAtBDBxYOmb0H67q13zDWaao+MV0Gbma
         zkAzoQ2XFxi+/ftX2rTQEQ/eUVVE6MJ6Mr0JjjRuMwFkyaMpvPwOpl3EmKmkC5gLPu4S
         gBJ9XJ/J1oxosJuzvDjlcgx7XGrhnfnTJ75ftI9Dq1MjZHdHt7GPt0dr5uSUhDCn+QnI
         z/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V5nE6QghnmtWowiOD0uX4lLlJm9ZIC6qs5oWJU6v2UQ=;
        b=IUhymy9Q+tDg02hniCZ8vOtacjpzH1nY2gXrqu3G3+fz1zYz4S5vFUx627+WhBg2oH
         7G+B1aNvoTgqRT4hcbmJIr3dM5E0amNbKK2iz9OZEtw99rNAwKDti7lXl92rnhJDH03v
         fJR1NzBE6ja8Am0ILeUGnQaYOIVm4JV8TcZyFoltUv7K8Y48ZI48wdjsztwMzPMxHbnR
         GXlDYf8ZHqFcKxXIS4qoZJ9ejaov6aKDCf87gTNn7GtDy7OLcbLSINmS0DFmZ1CfQnCA
         Yp1vMubwVZQApV3Ysi6n1QsxwbYCbaDTMKqrFbVR3Mzfkw84VckBssbA3hb8mZyCJUo1
         bZtA==
X-Gm-Message-State: AOAM532Gw9uNNYqlZu/fY2rAwznt0CdZgL2/fHtoI612CeJWWUJx7VAJ
        fA5k2sZXi+b0PbUB+pM0CcS0d59sI+cfgeuBvHQezw==
X-Google-Smtp-Source: ABdhPJziRUEslKmpv+PTpuYuEevyfbI4nXOfMUZ9zr/WL2tnqpnSyC0w6ujC+fLXlGdAolYrOZlOKlgoJlZFHzGsXmI=
X-Received: by 2002:a05:6e02:1be4:: with SMTP id y4mr305704ilv.295.1634234486195;
 Thu, 14 Oct 2021 11:01:26 -0700 (PDT)
MIME-Version: 1.0
References: <20211014001214.2680534-1-eranian@google.com> <YWgBzFf31lR6oGVA@hirez.programming.kicks-ass.net>
In-Reply-To: <YWgBzFf31lR6oGVA@hirez.programming.kicks-ass.net>
From:   Stephane Eranian <eranian@google.com>
Date:   Thu, 14 Oct 2021 11:01:15 -0700
Message-ID: <CABPqkBRWQ4cm3gmQf6AmoGKjPwjG9hVDXyt6L4CEUk6dkHTvDg@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/intel: fix ICL/SPR INST_RETIRED.PREC_DIST encodings
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kan.liang@intel.com,
        ak@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 3:09 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Oct 13, 2021 at 05:12:14PM -0700, Stephane Eranian wrote:
> > This patch fixes the encoding for INST_RETIRED.PREC_DIST as published by Intel
> > (download.01.org/perfmon/) for Icelake. The official encoding
> > is event code 0x00 umask 0x1, a change from Skylake where it was code 0xc0
> > umask 0x1.
> >
> > With this patch applied it is possible to run:
> > $ perf record -a -e cpu/event=0x00,umask=0x1/pp .....
> >
> > Whereas before this would fail.
> >
> > To avoid problems with tools which may use the old code, we maintain the old
> > encoding for Icelake.
>
> Uuuuhhhhh.. but we 'stole' event=0x00 for the fake events. There must
> not be actual hardware events there or we're in trouble. I thought Intel
> knew that, I'm sure I told them that.

Yes, this is a pseudo event code. INST_RETIRED.PREC_DIST 0x0100 only
works on fixed counter 0
to deliver the better sample distribution.
