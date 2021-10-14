Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957B942E16A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 20:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbhJNShi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 14:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbhJNShg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 14:37:36 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D27C061753
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 11:35:31 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id b188so14761iof.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 11:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2TRBUw1abzMTx5SXGzbp5vgXw7pHHffZvfIK9vAhNX8=;
        b=OvklV44uraoUs1KlMy2PQ5zJNp87NM+CrkLeyG0YQi8jsFTgoBYTByf3Xi3fDRtJwz
         jNuCqiPFrkxvM5rXfoubeyZr+Wfbfu5lFV3aEkVyHJ8CGNVidWpifTvn7yU7XjX32K3Q
         rXAi5STk1NdV0y5uiC9qiQq96polaKaNtLgvAKDgC2j1jiSOY8NVKs91r8cSDiuq8CRr
         zqVs/9MGR6MzHwvuJQNddBPmZScPWgjFYKkGBOh7oKat4i54qs+Y6mik8rkHS+WO4214
         nQc0ShWQMn9g4X7T/lMnFTX4hkqqiymNB0vGtYDPw7Mhh7O5TEJ5vaDi93+qqzprrM2u
         yGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2TRBUw1abzMTx5SXGzbp5vgXw7pHHffZvfIK9vAhNX8=;
        b=OJY8CAqsXNc6NqyeX8LzG/n+lo09M5CGfr+fHKNTw9hPD40W5zW6HBB20yXR4BpQvX
         wiZLF3uuaumyWau5h51nQ7gF2N4iZk+lLuKS6CZkAv7zlqfhayVCzJNgD8Aw+qe+kXbm
         cUBkj5mAPgRE+JQh4RONkVBII/t+DHiC2QrtAckBlPSdtj09HwRMk6VFIXBZVAxTMI40
         mUDWjkAbQYZq011OHiNMCFRGRmFhe84zVriCxK6U7X71AXM1EDPuFBsC//LCv/3wsiwE
         CAYyk0rAZSgc0tgnUMNsZT/yLF32naG9rgyhtmWOAsAILLi2+Vy4O5OsUhToSqzoXw/L
         ydFQ==
X-Gm-Message-State: AOAM532WciP0tK9tEO8Ht51lmf1yPoiDXoG2XK5Mq1YBr0Z+BpBc7qJ/
        N1tdEcadBM+cS0tLxiQw1dSGsKQhbw+Pcu7jzNg=
X-Google-Smtp-Source: ABdhPJyylmaaAmitQmBmMnrMS9t05hf+zPHBq1Mk1fGEUn9SLcAsW7W8nvNwjil94gBbjsOG75z7OehfzYC6FUEIJeM=
X-Received: by 2002:a05:6602:2d4e:: with SMTP id d14mr490452iow.172.1634236530859;
 Thu, 14 Oct 2021 11:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
 <20211014033414.16321-1-jiangshanlai@gmail.com> <CAKwvOd=znqwGT_FmUPbWPodjrnFHf+FtHMaYCTfvUeukBCM3xw@mail.gmail.com>
In-Reply-To: <CAKwvOd=znqwGT_FmUPbWPodjrnFHf+FtHMaYCTfvUeukBCM3xw@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 14 Oct 2021 20:35:20 +0200
Message-ID: <CANiq72k7E2ahWoFQWSUo6CWNd7iWVh-5sdqtTQ=5JPTHN_tzyw@mail.gmail.com>
Subject: Re: [PATCH V3 06/49] compiler_types.h: Add __noinstr_section() for noinstr
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Borislav Petkov <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Marco Elver <elver@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 8:29 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Can we use __section(section) here (from
> include/linux/compiler_attributes.h)? I kind of can't stand seeing
> attributes open coded.

Yes please! (though it can be an independent patch)

Cheers,
Miguel
