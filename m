Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600543DF97D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 04:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbhHDCAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 22:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbhHDCAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 22:00:19 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA76DC06175F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 19:00:07 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id hw6so1342537ejc.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 19:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KnuZs/g8Oew5RJJwXI/t9ztON31nLnDM5yCpxcP3G5Y=;
        b=M+OBkl7Ni519XngieCIV8Nw7Z3EiKgKSxTlp7loQj9h9rhj3+EAkRpflcKTj02vYCr
         T+a5qt2T4XvSU2J3rpwVHUGXIabN167Bq1GNqy/pNlomMwnmc+iG3CxMGxZhV8JVMaLf
         woHlclSeqZP9UqG8RTivp2FtSH94w/Ul8yTnYGkz4RRRzH/ZIzRNoPP4PNX5Ei+d0uGb
         ZlHPg9s7oF50/OtM7981W/R0vLRyp9zy6jix2xvKjKH4ShnHXbuURbvJEOqe11u52OGi
         ckXT2tKfpC/o4vJKAhjZxRd2UIFXlWpCYEF21knP9FNOvsLefIHvzg8JD62mSiEtMh4M
         X63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KnuZs/g8Oew5RJJwXI/t9ztON31nLnDM5yCpxcP3G5Y=;
        b=hwf18bB4VdUtyTnHMVxxuxLBpYaTtkEynRWc5LctO0Cl2bsPb4VCTTJ2wgkL/uI0Zc
         /+ab91itLHomitQoxNfX4j0t4dMHslfeFP52F3MaoN+fzmT5jqn1VfjFMiVu9x2XQeYM
         zM29nMObg+B7UlAvcK10C6XsgEUIdT9UTC7DFltWO4twpRHQY4fz+5f1rJAzVF03d6hU
         yjTPIPWRwGUsfQ8ixSW6nn9AvGCyYRQNrcTfaNpnXuFqbj7Ubw1TIEhCpVErsqzzxCV8
         9JdsgUNi6kEatRstFNZxmYtpEWAwc+3fHqQKbWYcSFQ5WxAFg+1h0wu4Ki1Ij8ZjvmvO
         OMxA==
X-Gm-Message-State: AOAM532qQmCHp004uZMEfdw3Vqek/a4vzKey8+vRmkmdUEtipgbnfn9B
        U0OrqHpNKacjMLI7GIwQb5P6JNf1L7prCkn1KF1eww==
X-Google-Smtp-Source: ABdhPJzrmInWA81g9WZA9syNr4nSHk73VmvWHU0el4ZKHkRh7fMDg0SGz0UdWcEWP/UM/q3b7HX/cmf3n+i0tYBAYck=
X-Received: by 2002:a17:906:d20a:: with SMTP id w10mr24376079ejz.426.1628042406564;
 Tue, 03 Aug 2021 19:00:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626252248.git.zhansayabagdaulet@gmail.com> <6d0caab00d4bdccf5e3791cb95cf6dfd5eb85e45.1626252248.git.zhansayabagdaulet@gmail.com>
In-Reply-To: <6d0caab00d4bdccf5e3791cb95cf6dfd5eb85e45.1626252248.git.zhansayabagdaulet@gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 3 Aug 2021 21:59:30 -0400
Message-ID: <CA+CK2bCwuDG+LRU_im-N=iZzomNntmreABjg3K5hFFB9o8LgKA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] selftests: vm: add KSM zero page merging test
To:     Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
Cc:     shuah@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 4:56 AM Zhansaya Bagdauletkyzy
<zhansayabagdaulet@gmail.com> wrote:
>
> Add check_ksm_zero_page_merge() function to test that empty pages are
> being handled properly. For this, several zero pages are allocated and
> merged using madvise. If use_zero_pages is enabled, the pages must be
> shared with the special kernel zero pages; otherwise, they  are merged
> as usual duplicate pages. The test is run as follows: ./ksm_tests -Z
>
> Signed-off-by: Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
