Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F64A31276E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 21:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhBGUpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 15:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhBGUpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 15:45:05 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56386C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 12:44:25 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id a8so19124040lfi.8
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 12:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GRu6vX9kYeS9uyfAkOd2bWaUsa4+VhJi3UgaM87SbHQ=;
        b=udjPNLcX7xnzSa0vCxdSbZWMBfeYzy8OmyahSGCCC+xQKCmNJnOeIhZ3GeoReMOT0a
         Iy1/+oybmk2xin1s+VxOpC3Vlr0IR5c+D6TN1S/TcaSv7Iik0ixz3YWPGpCqAM82PEsE
         xKWzCnATbNr0HP7VILA9iEwCE3IxRP9MH7P0y0TtDkGKBm0+BL9xwB3yon65+aUcQe30
         JsxSRs6yfnTeQLbwZ3spf5VhyF8XkwplhdJ9RCUdlTs/wbYZK3NGDALWagVlzlxVhI3W
         +ZCMDNiH+sMnWSZLSZl5clOFqp6kqqWYl7crWZvkkge9ytBxwUCp+tcy/wjocIX/b4vE
         gfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GRu6vX9kYeS9uyfAkOd2bWaUsa4+VhJi3UgaM87SbHQ=;
        b=LIOiQlYpfJUR+1fU74LzTkbJULaz+n2M+sD4WiK6/kLt5MdkiV1oy1rN9ZkdbAGFzO
         4TpOUoloAjZ1YKOIaIdaz6CbcSjgCkt+gF/7M79l786jPxUtO/gFD6XOYdGhO+daSejI
         HObAVp3Jgc+Ykdg0xaqjfCxJmjhAI63p2wxwKN8JYDtzIg5y20n+ShGJ8dt3wlgPKDvX
         fTI7jQe2eAZtDYiAxfHSjMqlt39Xl6VStxCAS6krJSEYwUQvgoPsF8KBHAiDO3o1kno9
         MB7TntbDMREG3avVSgJrQnd3+ra//biBWH3rT3EMZFL4itBkW3Lb7qGs9QNj089GbrHK
         7W9w==
X-Gm-Message-State: AOAM533BKje2CSrHqYhIVSsBohj7tn+6kkyYdm97PbYUgUH2Nvr6QI7e
        qnh/xzFSI6JbTkAbFaFTYBLMoOjjwQyTVMH1cnGljbpH
X-Google-Smtp-Source: ABdhPJwQXuRrUUYSLVTuHYJImlVxX+2+6XDLoVpEVa1LeWBPBQVUfLJinFTJ6SU9P/BlFU69cgPq5KnAynkS/3Le9uc=
X-Received: by 2002:a19:2344:: with SMTP id j65mr3181498lfj.38.1612730663664;
 Sun, 07 Feb 2021 12:44:23 -0800 (PST)
MIME-Version: 1.0
References: <20210207104022.GA32127@zn.tnic> <CAHk-=widXSyJ8W3vRrqO-zNP12A+odxg2J2_-oOUskz33wtfqA@mail.gmail.com>
 <20210207175814.GF32127@zn.tnic> <661b9809-2c6a-5fc8-163b-a159b84c9ab8@intel.com>
In-Reply-To: <661b9809-2c6a-5fc8-163b-a159b84c9ab8@intel.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 7 Feb 2021 12:44:12 -0800
Message-ID: <CAADnVQ+Sqna6X2a3MKaBv7xmdCcj-aD=prp8OggTTwCjoVN_0A@mail.gmail.com>
Subject: Re: [GIT PULL] x86/urgent for v5.11-rc7
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Borislav Petkov <bp@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 7, 2021 at 10:21 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 2/7/21 9:58 AM, Borislav Petkov wrote:
> > On Sun, Feb 07, 2021 at 09:49:18AM -0800, Linus Torvalds wrote:
> >> On Sun, Feb 7, 2021 at 2:40 AM Borislav Petkov <bp@suse.de> wrote:
> >>> - Disable CET instrumentation in the kernel so that gcc doesn't add
> >>> ENDBR64 to kernel code and thus confuse tracing.
> >> So this is clearly the right thing to do for now, but I wonder if
> >> people have a plan for actually enabling CET and endbr at cpl0 at some
> >> point?
> > It probably is an item on some Intel manager's to-enable list. So far,
> > the CET enablement concentrates only on userspace but dhansen might know
> > more about future plans. CCed.
>
> It's definitely on our radar to look at after CET userspace.

What is the desired timeline to enable CET in the kernel ?
I think for bpf and tracing it will be mostly straightforward to deal
with extra endbr64 insn in front of the fentry nop.
Just trying to figure when this work needs to be done.
