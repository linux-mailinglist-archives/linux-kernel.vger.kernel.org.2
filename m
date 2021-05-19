Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E8E388A9D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 11:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345147AbhESJ1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 05:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345004AbhESJ1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 05:27:01 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DA8C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 02:25:41 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id b26so2078820lfq.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 02:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ot6ZK3/nej5RyczDb4RE10Q16Anslrad+1Oh+HwDCUI=;
        b=HKqRUKnuNKLWZOqmw2W6g5yXpNgWskuObChpR4qIfQVfKBc9yujBjTMk/n5qhIKU6k
         ko6X54unnAmi2NpgMzTpf0cwdVlB4ko/6wQcD/jYICPr/thNRhF/AACDOde4r8IFnoAx
         pbAxKfMVX8FaX270Cq0EI8fjCsaVlid+Y17q/cIUc6VUJwbJe37fpQP1/Jdo6DinbRjm
         /y8fZmKRjcoFUMH7yudnmmrI2uKZni9gr+cQe/30qM/NyV27yijb/ZvJdnJ3pt+BYass
         V1GLDQ7RHBSub9erQx+yCXSPuKyTZz8L+Ig1Tk3nhUqOzvkVU5ArZX0E5U4yq4vbk4Cy
         6iYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ot6ZK3/nej5RyczDb4RE10Q16Anslrad+1Oh+HwDCUI=;
        b=Ylo419cywdHi4S+nROgsQ3bXAcJ21q0EcmlgU397oo0ki3gYdosfj1K1ffWUqKM3Sq
         ijuJlEeagDZ7EU3XUi64UjE5hw5gscD9hgqmJW/37P3bL6oPdz1g5/erZj580f28pM2L
         WJB30dWbt33z+56JdtrQ+UrnsZ6/4ysk5Gsx83GcfjdKxDtZqowmjddzPH8oG0YSk4G5
         hyFrOIInnkADII0LIzkp5E/1tnYlwh3HbTicWPvzeskcZ5vd8SrSDCLTDZko3tdgMPiz
         +cFSLOrKdSXLFOXmpvvT+c7gUQ0hNA5DDF9jNK8xna+KECa7ziNPSaCO9W9WsekS2qWb
         qKDA==
X-Gm-Message-State: AOAM533z1ssV3pxaaEtiLx2JkNMpndbqM6dyyecPAYTYXojQBhEDr8XL
        xp5sXmWo3xEUDiVJobkbwPwgZy4dpaoq+Oz9xK0=
X-Google-Smtp-Source: ABdhPJxYtwI0FnG4WYbtU9qNzgbyESwDD64CkxxyH3eyeGY/vxNCHGv/xEWkNdAroGCKZGBLy6ukZOsDVRjUHBDBHbY=
X-Received: by 2002:a05:6512:3f87:: with SMTP id x7mr7835894lfa.617.1621416340225;
 Wed, 19 May 2021 02:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210519063355.5147-1-ruifeng.zhang0110@gmail.com> <87v97ft9j7.fsf@jogness.linutronix.de>
In-Reply-To: <87v97ft9j7.fsf@jogness.linutronix.de>
From:   Ruifeng Zhang <ruifeng.zhang0110@gmail.com>
Date:   Wed, 19 May 2021 17:24:48 +0800
Message-ID: <CAG7+-3OofjNSrpEjVVuUEH6G_f-QBqhda5P0bvfL4-eJYZgKHg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] printk: always output coreid in caller information
To:     John Ogness <john.ogness@linutronix.de>
Cc:     pmladek@suse.com, senozhatsky@chromium.org, rostedt@goodmis.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ruifeng.zhang1@unisoc.com, nianfu.bai@unisoc.com,
        orson.zhai@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear John,

Thanks for your review and reply.

I am glad to know the Linux Community had been discussing this requirements=
.

My patch really has some problems you proposed.

I will pay attention to the modification about extra message output in prin=
tk.

Thanks.

Best regards,
Ruifeng

John Ogness <john.ogness@linutronix.de> =E4=BA=8E2021=E5=B9=B45=E6=9C=8819=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=884:25=E5=86=99=E9=81=93=EF=BC=
=9A
>
> Hello Ruifeng,
>
> On 2021-05-19, Ruifeng Zhang <ruifeng.zhang0110@gmail.com> wrote:
> > From: Ruifeng Zhang <ruifeng.zhang1@unisoc.com>
> >
> > Sometimes we want to know which cpu the process is running
> > on when the log output, rather than the thread id.  So add
> > the processor id output always in the caller information.
> >
> > caller_id bitmap:
> > [63:32] thread_id
> > [31]    flags of in thread context
> > [30:0]  processor id
>
> The primary purpose of @caller_id is so that the printk-subsystem can
> coordinate LOG_CONT messages.
>
> Your patch is about logging/printing additional context attributes of
> the printk-caller. This is something we have discussed before [0]. I
> think this should be addressed at some point. But we need to come up
> with a solution that is flexible and generic. We should not be touching
> these core structures every time some new attribute needs to be printed.
>
> Also, this patch is controversial for other reasons:
>
> - it adds bitwise logic, when it could more easily just add a new field
>   (for example, caller_cpu)
>
> - it increases the size of all records by 4 bytes
>
> - it changes the internal structure in a way that breaks existing crash
>   tools
>
> - for non-task contexts, the increased size is wasted
>
> John Ogness
>
> [0] https://lore.kernel.org/lkml/20200904082438.20707-1-changki.kim@samsu=
ng.com
