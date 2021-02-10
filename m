Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A22317092
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 20:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbhBJTsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 14:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbhBJTsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 14:48:36 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E05C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 11:47:55 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id j19so4604168lfr.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 11:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jgluCWKZJ2+LY+PEphK7od7mrizftajltQrIKyz138w=;
        b=IEJm95BbLno1mCCZlyZDN8aOD8u2EOWWaw9LBL2rBNQw6P5FQ3CV8fedgEzOaOvysv
         lK+plzchGF9lymr2yrhTDDMJOScF8ZzkrPE5FWEJJIl5ThZreRDrNxuyrX+jb8mSH4XE
         NWW+GA5y6//ZtzsO37YWz0VTXzoXCSIS/90DnCYoA4A4tWyi8lJmt4md//JRB3b0GhRL
         86rhtqPrbjl2j7a6USyHBZe0zXattTFl84oZ3JTduK59X5cgi+cgNHPzVRsLFM8gV70i
         sUATESKACRANXeIsVzM56Pc90TBXc0LmHL7Rwetlp/HfzErX1HucpgMc9at1CqgNXDwc
         0ZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jgluCWKZJ2+LY+PEphK7od7mrizftajltQrIKyz138w=;
        b=JDZU/H7t6685CblMoKiO7NR8UxmahgRFVfB53grKJmZQjPqRCs8DDq2IqjbBUK4Vmx
         4/7WsgQchduUGMjfcJGwfQZxO6CdQKX/+7PxmELlkBYpSF1mCip+fYJRqrWHrfNzBt5M
         b1yBWIIQTBhKnfW9FIi2byvSebw0jrmiiJ+8cQZznVdgdk9JHenBAar+X082aduGT8Nz
         kplXXm25EZe7F9PtqlCQqUKbpe5bcc74L0SYBuj1d3Sy6uU9n9ewTWXFH4Ehw0lE7z5s
         9PZsixLqQwQiPghPyjjgd3J/BUjNq1u8S7DbSqX7QC6FisxVmdLyL3dMofrgLZEswHXn
         RPOQ==
X-Gm-Message-State: AOAM530lJrhJS01TNY6vsyS58zgIDAkL8wHl3MkNAOYtEyb1wCW1bQka
        BYQe34HuVDLEY2FS5dzdvAJuhdA6BRbEZwH44fQ=
X-Google-Smtp-Source: ABdhPJzOGtvr0VJCpc+aS6X06HOVcw8gQoM23bYlMYVSVvSR2Rxcf6ueehYUlSrTgiZjin8irFR8WvRaKto6Z8ZUvIQ=
X-Received: by 2002:ac2:5dc1:: with SMTP id x1mr2389526lfq.182.1612986474144;
 Wed, 10 Feb 2021 11:47:54 -0800 (PST)
MIME-Version: 1.0
References: <cover.1612924255.git.luto@kernel.org> <YCPmL45wQSyWLmst@hirez.programming.kicks-ass.net>
In-Reply-To: <YCPmL45wQSyWLmst@hirez.programming.kicks-ass.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 10 Feb 2021 11:47:43 -0800
Message-ID: <CAADnVQKds2tEyaf8c_oTssWSGJk3dJvEdX862zWtHYfUUOwgxA@mail.gmail.com>
Subject: Re: [RFC][PATCH] kprobes: Remove kprobe::fault_handler
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 5:57 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
>
> Somewhat related.. I had this pending.
>
> ---
> Subject: kprobes: Remove kprobe::fault_handler
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Tue Feb 2 10:43:41 CET 2021
>
> The reason for kprobe::fault_handler(), as given by their comment:
>
>  * We come here because instructions in the pre/post
>  * handler caused the page_fault, this could happen
>  * if handler tries to access user space by
>  * copy_from_user(), get_user() etc. Let the
>  * user-specified handler try to fix it first.
>
> If just plain bad. Those other handlers are ran from non-preemptible
> context and had better use _nofault() functions. Also, there is no
> upstream usage of this.

No objections from me.

Since Masami mentioned that systemtap used that you
probably want to give them a courtesy heads-up that it's going away.
Though looking at systemtap source code I couldn't find any
reference to it. So it's likely a nop for them anyway.
