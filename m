Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1A3452337
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 02:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355704AbhKPBVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 20:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243843AbhKOTMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 14:12:10 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25F9C0431AA
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 10:00:55 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id z10so49203917edc.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 10:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QLyoo22P0xia39fScctyITZrnCx0/YeMWxTRLOMeqOg=;
        b=vuolPHGwseJYpPxJzPOmJPADIZqTPSQtp8Xzn/+oyIPjeoG+HVQrek7UDkJwsqlT/4
         zow6CvpEJFHqKnhCntzZZOE3nS40kYbaR0BmAUlh2BX4cFyZmDxRaJ9ADBACfkM+bLmo
         FzlLItJsInYGntQ7UEeXqX74Jw3Gvw/bhKieMY1CwQe/OwdATTNwAj0y9LBDx2zW+pp6
         ukyjHHH4tXqhHF0FajIDdnGPUdd4p0CdMycCh5OGUlVkJACjqfztw35VWYSuo458ZzAt
         c4bGaIFKJuMmIbkzGq4TqYezYx+6UPhXg/NOqSBJuLZsSG0w23DDizCdyg/bTT10SIAh
         7HMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QLyoo22P0xia39fScctyITZrnCx0/YeMWxTRLOMeqOg=;
        b=5NHzPXwBbyhgl+W4FGPIzoOkwMZ/6uU97BUNoLwqObk3YIPmDqTUq93uUBs8X6YDre
         05Df5laE60kur9Wqi/nHFCjzkFoki+HnuLwjAPgg3oPMbVO0QQwHudFkwr1jMRNMqdeq
         GI8J1QkUF9gPpMIQM1h59iOCOqCKLXyz6VHhkOmLbvXB+rSpjjha8OQKfy16Qu8GMZ/s
         YcVhBnz6UaFGtE3u/fV/3SE3CNxtETtNopmaPC5O71vzhz6JRVxSFUWHmnN8mQLSfXpG
         bswIOFm/Y8TbUxZjTW9o9VKlo+n4vhOKH4/fkCa1d/BGuOAcI/0pCvaT9MaRs6uuPgnZ
         lWWw==
X-Gm-Message-State: AOAM531SktZgMvYrgjlvlO2qnUgLb+szxI9tHWIaSMbWJHUS6+RnG9r1
        fz1afXEm4RU/Ox8moRYLfBo8f+c99yLo93YGRgOR6A==
X-Google-Smtp-Source: ABdhPJwXCk1h3D4p4OMrc6claSgZzbUW6IyzicewPNx5Q9zsT3CFoHe1lB2pV8uM9bVi3g9hCTSsPQWS81r6dNyBuoQ=
X-Received: by 2002:a05:6402:4412:: with SMTP id y18mr766255eda.103.1636999254435;
 Mon, 15 Nov 2021 10:00:54 -0800 (PST)
MIME-Version: 1.0
References: <20211115165313.549179499@linuxfoundation.org>
In-Reply-To: <20211115165313.549179499@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 15 Nov 2021 23:30:41 +0530
Message-ID: <CA+G9fYvxhzL9KUxZcRzMxnbGPK5GKTCtb5kWM3JB09D+-KhVug@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/355] 5.4.160-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        f.fainelli@gmail.com, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        stable@vger.kernel.org, pavel@denx.de, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, linux@roeck-us.net,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Nov 2021 at 22:39, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.160 release.
> There are 355 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 17 Nov 2021 16:52:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.160-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Perf build broken due to following errors.

> Andrii Nakryiko <andrii@kernel.org>
>     libbpf: Fix BTF data layout checks and allow empty BTF


In file included from btf.c:17:
btf.c: In function 'btf_parse_hdr':
btf.c:104:62: error: 'struct btf' has no member named 'raw_size'; did
you mean 'data_size'?
  104 |                 pr_debug("Invalid BTF total size:%u\n", btf->raw_size);
      |                                                              ^~~~~~~~

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
https://builds.tuxbuild.com/20xsgAxLwf4E60xl2dTdXnNS8FZ/

--
Linaro LKFT
https://lkft.linaro.org
