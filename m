Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B663576D9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 23:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbhDGVcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 17:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhDGVcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 17:32:11 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED9CC061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 14:32:01 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id u9so22455827ljd.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 14:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c7XbFRdOrSbgxAsfvMsJ/PdpQkSZRqfaNHt5MaBYo/0=;
        b=M6BTfeF00ewRfd37ZMlbtLq2k9T+kqW1geTzQBd0FiQBsf/5eRE9WiUn7SDNSbojzn
         4NvtpHgYycYC+dW/BdizBrRwOLdTm9Sz9DHjrBEE6/d44z2o+2q6gEkxaQhSKWBF9PBG
         Vgg43Hf3UIyK2OsE5zYhu5sHuWTsvTE7wJ9SFqOZLEV+eEd6GuV9/Fzf8lvS5qItyDEl
         +HsoFMzdpWFv8K6CGZCSVVanj86ZJwaW/3H0a7p2y6yaTGVQevezHMs+OFun3l+6nJA5
         sO5Z76PYbygKCPZ0hk0VbAT11XJbxW0C/g4QXuCJgI7dvltyBM1kNY46DD0ZYBbcTr1r
         +IAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c7XbFRdOrSbgxAsfvMsJ/PdpQkSZRqfaNHt5MaBYo/0=;
        b=VVQC2dXxnNW/6h8twGzxTnJi6olbkI75IOkUufLqhSVEWZV1U/oexuFxL8O7hmd8/O
         3J6scv6sLIXMGi7kXHmpRj1LlDA6GNcBh4MYyRQ4/RF0o7ugzGQ/r0VuBYxACP4Mgd/u
         esU3Jdc8Ws9fT+MV8yJAJFj5bfJ9tawYo1ZNKpLPgjQrT5zGQooVVT5z4u3fisvbliit
         FM53PsIf9iBf7NfQctvAIdynfnm86r0IuyPjC/ZYjrwsQU4lYepvutN7kccJujU/+5VO
         6P+T52NApJL0zc3j/tzO3O3fyymUq70TfuDe7M87Fho7lRht+j4b5RsdQnXswL1AzNwB
         0JJw==
X-Gm-Message-State: AOAM531ykMRYAvwrHdjT6SdXzWF/1YtnFrILZwS1DoYEp2Km2TRK44tM
        onFkLznj5Vub/in02nd038B2zLP7/klvuthD4yOBSg==
X-Google-Smtp-Source: ABdhPJywPf4ZdSQbV/cxH+epSR213HD9M1ethoIB1pZ/wQs3upDDi+y87K+TuFd0iCds5UbtT79Xi4Hh3hD8G9n49XY=
X-Received: by 2002:a2e:b88d:: with SMTP id r13mr3454991ljp.479.1617831119956;
 Wed, 07 Apr 2021 14:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <1617177624-24670-1-git-send-email-yang.lee@linux.alibaba.com>
 <20210407120239.GD25319@zn.tnic> <CAKwvOdnuKazNhqXAM9Qj7DgCW=PqVHkyyfYWytmkyBzv0QeYsw@mail.gmail.com>
 <20210407190328.GM25319@zn.tnic> <20210407190727.GN25319@zn.tnic>
In-Reply-To: <20210407190727.GN25319@zn.tnic>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 7 Apr 2021 14:31:49 -0700
Message-ID: <CAKwvOdkzYOv15EWh2cPXhHU4UhqadWZMiiETks09ZXKnh_r5QA@mail.gmail.com>
Subject: Re: [PATCH] x86/kernel: remove unneeded dead-store initialization
To:     Borislav Petkov <bp@alien8.de>
Cc:     Yang Li <yang.lee@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 7, 2021 at 12:07 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Apr 07, 2021 at 09:03:28PM +0200, Borislav Petkov wrote:
> > On Wed, Apr 07, 2021 at 10:41:26AM -0700, Nick Desaulniers wrote:
> > > You do have clang-tidy installed right? `which clang-tidy`?
>
> Btw, for user convenience, that "clang-analyzer" Makefile target could
> check for the presence of clang-tidy and fail if it is not there, with
> an informative error message. Methinks.

Yes, that's a good idea; we had a similar discussion recently about
what happens if you enable CONFIG_DEBUG_INFO_BTF and don't have pahole
installed. This is very much in the same vein. I've filed
https://github.com/ClangBuiltLinux/linux/issues/1342
to follow up on.  Should be a good beginner bug for folks looking to
get started contributing.

--
Thanks,
~Nick Desaulniers
