Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1797C3764AC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 13:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235254AbhEGLsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 07:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbhEGLsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 07:48:31 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D40C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 04:47:30 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id j75so8435389oih.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 04:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q/gF7I6x0B+KcvrXPCckekPT1/lHpLRsyhfHnetvWaA=;
        b=eWAZRFvNFr5L+o6irwV4WIFEpO09WPRocTLDyPIoksK3CBZpbxDE+C+v8THUJtZHFJ
         nENz+uYi/+Waj+u49svBJ2pCmJ1vpMXf6lqJyT3pRXD5WcPUcq6X+z9hA/QSVFAvw+Hv
         Ini2nhRrwluDJWocw+AQF1tSL1BwIL2J0TcjocVocQz3h1scRT00ZuN3GcZ1SGDVCTBC
         CtI1FA39XgPH++zTUp//7eE7yiSXwXv1w1y2JlkkEjv7m4R055E11H30fyXE9lTMcliU
         /5V1jzV3tfMknid9usatzelDm96FmSWB7w/ePtQWt1hjkedbS+SIeoRPLHV1AwLZEBj/
         LGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q/gF7I6x0B+KcvrXPCckekPT1/lHpLRsyhfHnetvWaA=;
        b=Qr7PVfkfHSLwgnNFa0KH6OpvycTKu8D3flVR40kGO3BvUKOAsfuwkkJpiI5BFsS24r
         GCNIdWhTTJ04fM4s+8dMqosxLWn6Okhr3vgJqKngl9V0JZeVa7W5pHqft3hBRzaKtB/W
         1oc8m5iSS1dk1cq28LrINpABmCS91e5/A2moBglnq4EIfNA5Zhk11rd3rc0R36x1hKfg
         +MSq13c4hiPbZw73UoOqnnt4XNNm4LnZrdRSP8319R+QtK78YvyQgLDqdq5Yh380jczL
         d6XHIx9kHAZEQYbJpLJCwyziyJsCBXLYTtAIm7yKzp8bYWDWjprrbEB1mEVyKfzShz4Z
         JMGQ==
X-Gm-Message-State: AOAM532e07OcSHhmAPd8W/Plo/PibGwFpbXnYp3LFHlpVAOhj+XJ+RmL
        tJLHq2y1UlTzUZQu1pvCVJPWwpyhGdNZdfhW87WeJlR8qmQ=
X-Google-Smtp-Source: ABdhPJzpe0JisKgITxijarszqDRb3jeFfshXJxJdFK5jfu47+NooWrGTlsOaZQOSNfWOuF2RnMwSlQiit2F0vEyAAwE=
X-Received: by 2002:aca:bb06:: with SMTP id l6mr6770182oif.121.1620388049264;
 Fri, 07 May 2021 04:47:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210506132827.3198497-1-elver@google.com> <CABJPP5D_azxBiKq08_m_WVmcEy8qbMCa0EsAgu57t2T+eDJA0A@mail.gmail.com>
 <YJQJoq+7MAJosrHg@elver.google.com> <2bea96ba2525c31b18185f51fffea2d2052aa8a0.camel@perches.com>
In-Reply-To: <2bea96ba2525c31b18185f51fffea2d2052aa8a0.camel@perches.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 7 May 2021 13:47:17 +0200
Message-ID: <CANpmjNPXJUWhO6sVcXcqXjf6_0ud9L1Q3TJchmB_=Ov1QZOngg@mail.gmail.com>
Subject: Re: [PATCH v2] checkpatch: warn about direct use of send_sig_info and force_sig_info
To:     Joe Perches <joe@perches.com>
Cc:     "Eric W . Biederman" <ebiederm@xmission.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 May 2021 at 23:41, Joe Perches <joe@perches.com> wrote:
> On Thu, 2021-05-06 at 17:22 +0200, Marco Elver wrote:
> > Setting up siginfo and using send_sig_info() or force_sig_info()
> > directly is discouraged. Instead, new code wanting to generate signals
> > should use the appropriate helper specific to the signal.
> >
> > Eric mentioned that he'd like to make these static at some point, but
> > until that can happen, let's try to avoid introducing new users of them.
> []
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -7153,6 +7153,12 @@ sub process {
> >                            "Where possible, use lockdep_assert_held instead of assertions based on spin_is_locked\n" . $herecurr);
> >               }
> >
> >
> > +# check for direct use of send_sig_info(), force_sig_info()
> > +             if ($line =~ /\b((?:force|send)_sig_info)\(/) {
>
> You want to be able to find uses like 'force_sig_info (<foo>...'
> so you should add a \s* after the capture group.
> And it's probably simpler and more readable to use
>                 if ($sline =~ /\b(force_sig_info|send_sig_info)\s*\(/) {
> instead of the more complex regex
>
> (sline is stripped of comments, $line is not)

Done for v3.

> > +                     WARN("USE_SIGINFO_HELPER",
> > +                          "Where possible, avoid using '$1' directly and use a signal-specific helper setting required siginfo fields (see include/linux/sched/signal.h).\n" . $herecurr);
>
> A rather long and complex sentence.
> How about
>         "Prefer signal-specific helpers over use of '$1' (see: include/linux/sched/signal.h)\n"

Sounds good.

> And in that signal.h file, there's no obvious reference to
> these signal-specific helpers.  Is there a better reference
> in the Documentation/ tree?

Yeah, signal.h has their declarations, the definitions live in
kernel/signal.c. But otherwise, there's no better reference anywhere
AFAIK. The main thing here is to alert someone to double-check their
use of {send,force}_sig_info() -- when thinking what would have helped
me identify the problem earlier, I came to the conclusion that a
checkpatch.pl warning would have done exactly that. Like Eric said,
eventually these might become static, but it doesn't look trivial to
do this right now. When that happens, this check can then be removed
again. But since it might be a while, we can at least try to automate
this "trivial" review around siginfo.

I'll send v3 shortly.

Thanks,
-- Marco
