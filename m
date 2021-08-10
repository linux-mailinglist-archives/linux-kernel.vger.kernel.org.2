Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAAF63E7BCC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 17:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242666AbhHJPLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 11:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237554AbhHJPLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 11:11:47 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECC4C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 08:11:25 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id x10so21828442iop.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 08:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=24eQSegGgTAQct3c3ZDXvjME4kw/3yiL3Gj6Xe/n13w=;
        b=at/MKIGeLCAYbO+Ydd2zLsZPp8HXWW0fZpNY6zj939Lk6MJYmhFzKQwgDtb9ochemg
         lm9OyF5HqNn+M15cHO/ZvGd2h8mrSZ1athAJxnC8dnJf5Fl6hEmZe5WkpQsZhN+p9PRr
         eKzdkTqFq2Ua6r63NLtFSWsfO5V3CF5lesjXcyE2gu+3gbtyzlbStl9jJncsaQPnVVx0
         HNyr7LaZ7KVXEzxDGQzTQCfeKRLRnFb906bFS74Un2CtpF4HpINg0rLJS/Zw5vIO/ZcW
         Mg0jsVCJfsGgEmWXmZuP1OrPfw6058bKmU0OMvkiL5v/EBEbmNR/10tMC5GbBGdB6HJG
         7t0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=24eQSegGgTAQct3c3ZDXvjME4kw/3yiL3Gj6Xe/n13w=;
        b=MRIzxOAKHB8eFeoM9eocw7dqSUXhgBUMlKvqSFEbxC8p2y2H8jO5fzCgeJWoSrKwTU
         LO02Gm812Z7Liic4fzZZK4FKNRvKXfaFB6plu4F+CzI8JH+KYdNe41j2ZK+nIcg1n3x+
         sLRBSfm3RxwEgY9DfKESGOZIyLD3jbyikv6X34DQJ3el431+88pb7JmI0UsVWxCZzmMb
         KaHyGJsMHMcmKq1TNTObeXyvyLU5GYF57POm7SD5ZCdJsnx5K8xC19Aje0N9EFId5wS2
         gPZTjbDGGaCsUyIvL3eZErFk5FQRXjJsv7R0TELDZNEL+K+k7TWsVo6mzlVyjoyH5W+z
         k1Ig==
X-Gm-Message-State: AOAM530p/wlv9BPpLN+qTJTvzNX/y8/gOhedoQU7fMHZGwfxMIrlplsd
        FeGVXcbpLbO+7vRdxq2x0gHFulwlqIGQWFv/qw8=
X-Google-Smtp-Source: ABdhPJy059m/HIwrjY9V3mRYz2Teewm3r7ui68KDeZMd2v8MXG5zW9IpGDkoiY5xMon4HVVlZkvBOQ4wbJFHh02IH+0=
X-Received: by 2002:a02:1d04:: with SMTP id 4mr2252896jaj.98.1628608284774;
 Tue, 10 Aug 2021 08:11:24 -0700 (PDT)
MIME-Version: 1.0
References: <202108101908.Xq5QKkNW-lkp@intel.com>
In-Reply-To: <202108101908.Xq5QKkNW-lkp@intel.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 10 Aug 2021 08:11:13 -0700
Message-ID: <CAEf4BzaxSUF31qjjZx1+7OLomxyx3mAaqNY71GAV-TQMoGnOCQ@mail.gmail.com>
Subject: Re: [linux-stable-rc:linux-5.10.y 4948/4972] tools/testing/selftests/bpf/prog_tests/core_reloc.c:860:
 undefined reference to `ASSERT_FALSE'
To:     kernel test robot <lkp@intel.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, kbuild-all@lists.01.org,
        open list <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 4:25 AM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> head:   e97bd1e03e6ef58ec47ee7f085f8c14ed6329cf7
> commit: 183d9ebd449c20658a1aaf580f311140bbc7421d [4948/4972] selftests/bpf: Fix core_reloc test runner
> config: x86_64-rhel-8.3-kselftests (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.3-348-gf0e6938b-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=183d9ebd449c20658a1aaf580f311140bbc7421d
>         git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
>         git fetch --no-tags linux-stable-rc linux-5.10.y
>         git checkout 183d9ebd449c20658a1aaf580f311140bbc7421d
>         # save the attached .config to linux build tree
>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash -C tools/testing/selftests/bpf install
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    /usr/bin/ld: tools/testing/selftests/bpf/core_reloc.test.o: in function `test_core_reloc':
> >> tools/testing/selftests/bpf/prog_tests/core_reloc.c:860: undefined reference to `ASSERT_FALSE'
>    collect2: error: ld returned 1 exit status
> --
>    /usr/bin/ld: tools/testing/selftests/bpf/no_alu32/core_reloc.test.o: in function `test_core_reloc':
> >> tools/testing/selftests/bpf/prog_tests/core_reloc.c:860: undefined reference to `ASSERT_FALSE'
>    collect2: error: ld returned 1 exit status
>

ASSERT_FALSE() macro is defined in test_progs.h, which is included
from core_reloc.c. There must be something wrong about how kernel test
robot is building selftests/bpf.

>
> vim +860 tools/testing/selftests/bpf/prog_tests/core_reloc.c
>
>    765
>    766  void test_core_reloc(void)
>    767  {
>    768          const size_t mmap_sz = roundup_page(sizeof(struct data));
>    769          struct bpf_object_load_attr load_attr = {};
>    770          struct core_reloc_test_case *test_case;
>    771          const char *tp_name, *probe_name;
>    772          int err, i, equal;
>    773          struct bpf_link *link = NULL;
>    774          struct bpf_map *data_map;
>    775          struct bpf_program *prog;
>    776          struct bpf_object *obj;
>    777          uint64_t my_pid_tgid;
>    778          struct data *data;
>    779          void *mmap_data = NULL;
>    780

[...]
