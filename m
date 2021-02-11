Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A6631924F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 19:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbhBKScY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 13:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbhBKSbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 13:31:18 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A76C061756
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 10:30:38 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id t196so1518990oot.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 10:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r9+HPdy88LuNzw7CIi6Ld4av+X55WJ9pzXOwOLwNHOE=;
        b=v5bBAJO0D9kbSk+SQC4rKXBMPVAH5CsB7WbuPjMO8ioZfAwvf+A0D1tXkcm2RoHETU
         2S/wE/Lzwn9jfXRADna4tqdL/O2iZMUkVHtsuW+48j3l5AN5sP/CvObaud2VMg2VJIfF
         bPXlk9eXfhBQM+RiTR8IX9BVdKRxiCSqlWTfKZ9MbiTGzShbqDgKHRdzLFtYDXm4jZoH
         /xaiTAyZMHeJ66zAAkMZoMxbJXNnUdI226g+le+qA5/GNaQrok22j4JvqKNyBDsR8yLS
         uQwDSAgBX4YflByhq6/BRMWOq6JD6ovkqw373F26uvvH+3nSt7ycbw1cOP7057rr9oB0
         1tFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r9+HPdy88LuNzw7CIi6Ld4av+X55WJ9pzXOwOLwNHOE=;
        b=TLwlK7LiFMJY9AyeMD+dT1NAmLEtbZfE5LtdyVrZEhdqbu3MVxXv87bD9ez1uWBEoX
         uAl//ahLTae+e/27eaK892EawG2MDvSpesI6YvA6pahFKkbwRo3MtRDdI/ih5/sm24Zj
         IvkWd12fvt4AeBa0Yz89TSPvqi9QKWj71JS376tbD8M64u3tdKvC13xbDfj81iWv4zh6
         tO41/sZkibaIdEzZXF8dDX0lAwRvUArJYOJTUasof/ytQUm3p0qsjwApcoNTQZut1W3U
         9eq91ysTZHdVKhxP+QRNQex06Nye8O4p1Rtz67cRqQ7J4h+naBu9x6/5HUgea4A5oDP1
         opwQ==
X-Gm-Message-State: AOAM530V+PUeZr+pgVkQ1oKtc828+GQOY9i/BppQmEicQiJoYjni4vsS
        h5t7VxjCy35JCz5WxvNRiKqplJon4x+FUVA1hN32kg==
X-Google-Smtp-Source: ABdhPJxZ5V2xaPLSoSTNPCWH0nPKZLl9JUX0OzAdpMfc+5uHARdOACsQWJhrgoB6ou0Hv6YF7rUMALoN5Ilf93pGXrc=
X-Received: by 2002:a4a:858c:: with SMTP id t12mr6312870ooh.20.1613068237502;
 Thu, 11 Feb 2021 10:30:37 -0800 (PST)
MIME-Version: 1.0
References: <20210211173044.141215027@infradead.org>
In-Reply-To: <20210211173044.141215027@infradead.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 11 Feb 2021 10:30:25 -0800
Message-ID: <CAKwvOd=9Xx=w6vWq8Tb160dM3a9uDPNCP-Yt0it7E0804HxnsQ@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 0/7] objtool x86 decoder fixes
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Julien Thierry <jthierry@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 9:40 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Hi,
>
> Since I had to look at instruction decoding for the stack swizzle thing, I
> ended up with a few more changes to the objtool x86 decoder.
>
> These patches are lightly tested (they build defconfig and allmodconfig using
> GCC10), but older versions have seen some robot exposure and other compilers.

Did a quick test of x86_64 defconfig on -next with
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=objtool/core&id=2a512829840eb97a8b52eca7058e56d484468f2d
and ToT LLVM. No new warnings/issues observed during a build.

Tested-by: Nick Desaulniers <ndesaulniers@google.com>

>
> v2:
>  - actually Cc'ed LKML :/
>


-- 
Thanks,
~Nick Desaulniers
