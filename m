Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA8931132D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 22:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbhBEVMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 16:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbhBEVMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 16:12:19 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C90EC0617A9
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 13:10:12 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id f6so5893435pfn.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 13:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=PWPQxeCAdhLh3iBL7DE/6gQVuXBKlPLZEtdhRuCjmxw=;
        b=NVSHL24F+1cvfoWwSWqqObWmcSZ+jmqBVq/c4//iEhKqhjfAp3ck1OyTyQIfo6vOwq
         IzvZWR1V+fZmIKTRY6keeQrrjFffwzyRbKg3KIWQTXZG0lh7XU9IgpA+YOZv+FIAZcRT
         Y+vHWkVnhODRGhUCp43s+0N8646L9yGlYSaJMHPWkJcbGyxE6mfFn2GgozQvGnNmv/hx
         DOC8+qufXNZX+iIhg7SxYhq7Zs8t7mHXlFelstQIOF6k3tYIMUgbiCKZ1vrIn7pt4aLn
         VPPBnli46CbhzX6rWKn9wdj2s6mcob+dODr4z/GN36VnNl7wnwOxI27Y/AXrcLtdrIDP
         saug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PWPQxeCAdhLh3iBL7DE/6gQVuXBKlPLZEtdhRuCjmxw=;
        b=ZH+713y+y9kDj3nLuN2mDf7Z5VESHspEUgXb76+hBaT3ky2qVvef34p+ZvpukUsF4N
         I1efSZ+SSFKHkXqPpj6yHfx+Lu5Om8wTJ6CUgZZmau1EIzzxXMLeX5gyg+e6LVlHui9v
         yQGp/ImWZppWHPCZvvxZDqqvn+dw9TGXsesI/kxjGQOxZfzUaW9j3VHV6TtGYCm+RfqN
         SBs51mM1Xp1xqFntm3UMWwSx1stPmUKgmwjnWdFNt20QpQabVV0xlEV9u7NC//hutSkm
         arK1AgVZhRIa+4WOlKGtAb8wUO9v8Fw2rl0sE1DngzUri7K/2yuU7k9meeJrCbfkbbU3
         GbyQ==
X-Gm-Message-State: AOAM532G8S8bogm9f/LpsIdw3PKUU4/72IaohsB53nxeNH7cu7wogjhU
        CJeHoXsyV1K9+hMfylFtmrEuVu6Se9V0lUZyjI0=
X-Google-Smtp-Source: ABdhPJxExyVCuSceD3ifRJmPh4e6qYieel8G6WM1s0Z4zTD3g3ANK25YrnpQAQC6Cgtpy/n50ph6dZ0xx7gfZ2oOuns=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:fce9:1439:f67f:bf26])
 (user=ndesaulniers job=sendgmr) by 2002:a17:90a:2b8c:: with SMTP id
 u12mr5684697pjd.98.1612559412019; Fri, 05 Feb 2021 13:10:12 -0800 (PST)
Date:   Fri,  5 Feb 2021 13:10:10 -0800
In-Reply-To: <CA+icZUVQSojGgnis8Ds5GW-7-PVMZ2w4X5nQKSSkBPf-29NS6Q@mail.gmail.com>
Message-Id: <20210205211010.2764627-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <CA+icZUVQSojGgnis8Ds5GW-7-PVMZ2w4X5nQKSSkBPf-29NS6Q@mail.gmail.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: Re: ERROR: INT DW_ATE_unsigned_1 Error emitting BTF type
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     sedat.dilek@gmail.com
Cc:     andriin@fb.com, arnaldo.melo@gmail.com, berrange@redhat.com,
        bpf@vger.kernel.org, cavok@debian.org, dwarves@vger.kernel.org,
        jengelh@inai.de, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        mjw@redhat.com, omosnace@redhat.com, paul@paul-moore.com,
        tstellar@redhat.com, yhs@fb.com, zzam@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
> 
> when building with pahole v1.20 and binutils v2.35.2 plus Clang
> v12.0.0-rc1 and DWARF-v5 I see:
> ...
> + info BTF .btf.vmlinux.bin.o
> + [  != silent_ ]
> + printf   %-7s %s\n BTF .btf.vmlinux.bin.o
>  BTF     .btf.vmlinux.bin.o
> + LLVM_OBJCOPY=/opt/binutils/bin/objcopy /opt/pahole/bin/pahole -J
> .tmp_vmlinux.btf
> [115] INT DW_ATE_unsigned_1 Error emitting BTF type
> Encountered error while encoding BTF.

Yes, I observe this error, too.

https://gist.github.com/nickdesaulniers/ae8c9efbe4da69b1cf0dce138c1d2781

via v9 of my DWARF v5 series, which should help make this easier to
reproduce:
https://lore.kernel.org/lkml/CA+icZUW3sg_PkbmKSFMs6EqwQV7=hvKuAgZSsbg=Qr6gTs7RbQ@mail.gmail.com/T/#m45ec7e6df4c4b5e9da034b95d7dfc8e2a0c81dac
