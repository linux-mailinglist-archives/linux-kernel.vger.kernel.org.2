Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6829145FD38
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 08:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352564AbhK0HYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 02:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238637AbhK0HWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 02:22:13 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1152EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 23:19:00 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id gt5so8573205pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 23:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2NVZAUN1nteqIUhENJeAMECc6HageHA3iNJoAEhBcZk=;
        b=owgXJaxv1EUj/ChI6ouKmRZC8BZNKsQtlLk4nfsj1s/J4EL8zuW6smpb1Wd4kUeIDu
         WM/MjjqdzubT6gP36yyd9Rh91/Hm4Qp+jQdMhbslnaSIYsXvuxQrCCoaOCOTE+C7N7eU
         gzAJKAPwrUdEVKbkg44PV5CDWrPZKY2OkSV89THu7xXqg5PxubqgSqDMeiJjyBOUzmQi
         NMDkwQrnvV69HHqI7eYkgM4jVLCp9aO5i/RtWCdsIny3CKY9luJgZjTic+HExQF9SCc3
         d+9vQpgEpQLoeYzQAuwmWvOrSRKMaNJPn++rPPgCUlYxcAm4dBlyNDmqY7aN88FYgFkS
         0sHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2NVZAUN1nteqIUhENJeAMECc6HageHA3iNJoAEhBcZk=;
        b=xsurK/csEodeq0lY5VBoEDFQ+ZZgpO2WPfjr1xpfXvS+5iIZS3PRHOlZQxB85cOFIl
         alABq+pFF/eIuB6YsEQla0JFmijYnLfRUAV5BCpdVjmsXFBRYsOpOXKIq1QSK/7tkvo/
         0+5on9b2xLrbdSOgqY0azNHtPJYSLxKWsUqja5HXtamoEn5YuGN+YkH3QOIvflzVZqTS
         yRT+LjyB49cKVoZERHPK5F0M8JrlqLtqcrSLCNYqIG9ij45TQ5/gUf0eOtFRavwxdsMh
         ED74ZTsDuTZ3Wb/ZgsuYP0Ocvw3VkPMQLFQX1vhOwKpzZZa7l7rqISixTUceRSIwPhwl
         Eucw==
X-Gm-Message-State: AOAM5335Qk7oMOj2MIwPhtpLmbQnvOG7r9MDlFZmqq4g32BPYDvBUTs3
        K4K0y5uRZqk11twdtPFdCDMc6wX66gRg3n20cOM=
X-Google-Smtp-Source: ABdhPJzeKn2NDeEZtU4K6t5xUE542favbI9DoQdzWcMrCiyIq2NYUvh2LsIKXAvH/mrPaue09gCDJ4zv7mBIleoVGwo=
X-Received: by 2002:a17:90b:1892:: with SMTP id mn18mr21541713pjb.178.1637997539527;
 Fri, 26 Nov 2021 23:18:59 -0800 (PST)
MIME-Version: 1.0
References: <20211125193852.3617-1-goldstein.w.n@gmail.com>
 <20211127063904.102017-1-goldstein.w.n@gmail.com> <CANn89i+AAx6dAFkUr9eOSxp6d47=y6oZox8DErGQdNyfjLipdg@mail.gmail.com>
In-Reply-To: <CANn89i+AAx6dAFkUr9eOSxp6d47=y6oZox8DErGQdNyfjLipdg@mail.gmail.com>
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Date:   Sat, 27 Nov 2021 01:18:48 -0600
Message-ID: <CAFUsyf+qeVFPrmPnq+WHsxvKi6gVAf8ZanG0kgAM6-SgKtT67Q@mail.gmail.com>
Subject: Re: [PATCH v3] x86/lib: Optimize 8x loop and memory clobbers in csum_partial.c
To:     Eric Dumazet <edumazet@google.com>
Cc:     tglx@linutronix.de, mingo@redhat.com,
        Borislav Petkov <bp@alien8.de>, dave.hansen@linux.intel.com,
        X86 ML <x86@kernel.org>, hpa@zytor.com, peterz@infradead.org,
        alexanderduyck@fb.com, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 27, 2021 at 12:51 AM Eric Dumazet <edumazet@google.com> wrote:
>
> On Fri, Nov 26, 2021 at 10:39 PM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
> >
> > Modify the 8x loop to that it uses two independent
> > accumulators. Despite adding more instructions the latency and
> > throughput of the loop is improved because the `adc` chains can now
> > take advantage of multiple execution units.
>
> Oh well, there was really no need to resend this, especially if you do
> not add my ack.
>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Sorry!

Is the protocol for tags to let the maintainer add them or
should I post a V4 with your tag?
