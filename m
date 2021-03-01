Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6147329148
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 21:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243247AbhCAUXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 15:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236963AbhCARFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 12:05:45 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69560C061794
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 09:05:04 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d11so16922657wrj.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 09:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=orIG0dppKanIHyAZXoB55cY6CKEZZ+MbLfH22/CXSHU=;
        b=cf+gsyY4JTyd31fGJoFGPbr9T5jgYIWbz8/77ayAdUmCiKalB9XypN454gjIJ9Fr4x
         TBJXlmbLrYYnwoOlUVtycLO+gos+ZbljpmMHxNp99KyK3V7bu6JK/ZCVdZcGUWWsSPjN
         s4s3HXPUqPdFDDbz7AX0s322kz1Q2SyteUmJjDgnh4SFPha13UFyR1zoHZeUu3cZ75TN
         n5yKh4E0iUS/puowWh+94sHbhXH24CCp0SkZYSZkbX4KB1Odm7UpxhellqKVyYIXmbdn
         x6AIJ28uzPQ+CuYqO+ALOha7G0K/MW38yzk++r5nZljDL1Mr+KC85OwAHECkXr7XoTtz
         QVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=orIG0dppKanIHyAZXoB55cY6CKEZZ+MbLfH22/CXSHU=;
        b=rz16VxcOTKBFBJZfDl5KNvEmDlxhO+HlDA6tKBtMAv3/rLOTKZbxYUS9h6WxjkOrAW
         7T/FyQiOEMebpOYGlH0Vte6jH30I8CkGiVPZfLN/2zvc434AA+JwrmEihXf7e8d+/zn7
         9fMNaSim0hg1cIx5ewAfYSnXVuM4hUPfVTy5sh/or75O4ec8KnzccI+p1ifXrKTUoI53
         v8m90vtMMv0x3+WePKcwtR7p/47gGKaSlxooF9vJVOXXjtgfQ+EEqkQWe9fUyM5ar8xg
         oix6xslCso2FoBztQjeiuJpEJjUKKiTuizUfKtEKKM8eV5U7nCrxAxWdfypGVqw8XK1F
         /oxg==
X-Gm-Message-State: AOAM53037WcN7Z25jn9nruhEBaIRXBWcl9SEzYrHk0c56BnYABegQNnV
        XmFqUDN/8eg0esskdawQH5HNMA==
X-Google-Smtp-Source: ABdhPJwF7UW0zVTASsYJTNGrMR860fn/Ro6EyeNwPQxLp05WqHxwny2WCR3Md4kqXQoG3lAkOWfTXg==
X-Received: by 2002:a5d:45cd:: with SMTP id b13mr18168719wrs.296.1614618303138;
        Mon, 01 Mar 2021 09:05:03 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:f1e7:963:2248:d2dc])
        by smtp.gmail.com with ESMTPSA id a5sm26680908wrs.35.2021.03.01.09.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 09:05:02 -0800 (PST)
Date:   Mon, 1 Mar 2021 17:05:01 +0000
From:   Alessio Balsini <balsini@android.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Peng Tao <bergwolf@gmail.com>,
        Alessio Balsini <balsini@android.com>,
        Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <duostefano93@gmail.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, wuyan <wu-yan@tcl.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        kernel-team <kernel-team@android.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND V12 3/8] fuse: Definitions and ioctl for
 passthrough
Message-ID: <YD0evc676pdANlHQ@google.com>
References: <20210125153057.3623715-1-balsini@android.com>
 <20210125153057.3623715-4-balsini@android.com>
 <CAJfpegs4=NYn9k4F4HvZK3mqLehhxCFKgVxctNGf1f2ed0gfqg@mail.gmail.com>
 <CA+a=Yy5=4SJJoDLOPCYDh-Egk8gTv0JgCU-w-AT+Hxhua3_B2w@mail.gmail.com>
 <CAJfpegtmXegm0FFxs-rs6UhJq4raktiyuzO483wRatj5HKZvYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtmXegm0FFxs-rs6UhJq4raktiyuzO483wRatj5HKZvYA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 09:40:21AM +0100, Miklos Szeredi wrote:
> On Fri, Feb 19, 2021 at 8:05 AM Peng Tao <bergwolf@gmail.com> wrote:
> >
> > On Wed, Feb 17, 2021 at 9:41 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> 
> > > What I think would be useful is to have an explicit
> > > FUSE_DEV_IOC_PASSTHROUGH_CLOSE ioctl, that would need to be called
> > > once the fuse server no longer needs this ID.   If this turns out to
> > > be a performance problem, we could still add the auto-close behavior
> > > with an explicit FOPEN_PASSTHROUGH_AUTOCLOSE flag later.
> > Hi Miklos,
> >
> > W/o auto closing, what happens if user space daemon forgets to call
> > FUSE_DEV_IOC_PASSTHROUGH_CLOSE? Do we keep the ID alive somewhere?
> 
> Kernel would keep the ID open until explicit close or fuse connection
> is released.
> 
> There should be some limit on the max open files referenced through
> ID's, though.   E.g. inherit RLIMIT_NOFILE from mounting task.
> 
> Thanks,
> Miklos

I like the idea of FUSE_DEV_IOC_PASSTHROUGH_CLOSE to revoke the
passthrough access, that is something I was already working on. What I
had in mind was simply to break that 1:1 connection between fuse_file
and lower filp setting a specific fuse_file::passthrough::filp to NULL,
but this is slightly different from what you mentioned.

AFAIU you are suggesting to allocate one ID for each lower fs file
opened with passthrough within a connection, and maybe using idr_find at
every read/write/mmap operation to check if passthrough is enabled on
that file. Something similar to fuse2_map_get().
This way the fuse server can pass the same ID to one or more
fuse_file(s).
FUSE_DEV_IOC_PASSTHROUGH_CLOSE would idr_remove the ID, so idr_find
would fail, preventing the use of passthrough on that ID. CMIIW.

After FUSE_DEV_IOC_PASSTHROUGH_CLOSE(ID) it may happen that if some
fuse_file(s) storing that ID are still open and the same ID is reclaimed
in a new idr_alloc, this would lead to mismatching lower fs filp being
used by our fuse_file(s).  So also the ID stored in the fuse_file(s)
must be invalidated to prevent future uses of deallocated IDs.

Would it make sense to have a list of fuse_files using the same ID, that
must be traversed at FUSE_DEV_IOC_PASSTHROUGH_CLOSE time?
Negative values (maybe -ENOENT) might be used to mark IDs as invalid,
and tested before idr_find at read/write/mmap to avoid the idr_find
complexity in case passthrough is disabled for that file.

What do you think?


I agree with all the above comments to this patch, i.e., add
FOPEN_PASSTHROUGH, drop fuse_passthrough_out, header version+changelog,
that will be fixed in V13.


Thanks,
Alessio
