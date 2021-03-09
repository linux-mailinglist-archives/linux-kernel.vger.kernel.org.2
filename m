Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E601C3322B3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 11:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhCIKMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 05:12:48 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:60197 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbhCIKMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 05:12:19 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mnac7-1m0MxZ2mrV-00jcoP; Tue, 09 Mar 2021 11:12:16 +0100
Received: by mail-oi1-f172.google.com with SMTP id u198so9392389oia.4;
        Tue, 09 Mar 2021 02:12:16 -0800 (PST)
X-Gm-Message-State: AOAM531GYf0QcRsCg+oWK0MvBSWOHvTYCG363r+VZ5sLZj8YYGX1q8Qw
        tRXAFPfStZWZgpOikh4I2/b7rxA+tw1s77rv2PM=
X-Google-Smtp-Source: ABdhPJxylwz3rs6J/KqfBZxwA8hOMntZMK3cLMLk15q+NDo1af2lCauhyjw8RikXum8XlK1RdTAGUj9Vcf/G6tGj0TI=
X-Received: by 2002:a05:6808:3d9:: with SMTP id o25mr2424473oie.4.1615284735329;
 Tue, 09 Mar 2021 02:12:15 -0800 (PST)
MIME-Version: 1.0
References: <20210308182339.379775-1-krzysztof.kozlowski@canonical.com>
 <20210308182339.379775-4-krzysztof.kozlowski@canonical.com>
 <9c8109f7-47b3-a865-5bd7-656b7c3c318f@canonical.com> <7e4fb9fb-493f-2f05-20fe-e9d8cc6a4ed2@canonical.com>
In-Reply-To: <7e4fb9fb-493f-2f05-20fe-e9d8cc6a4ed2@canonical.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 9 Mar 2021 11:11:59 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1eOEFkCpQm15Y6Xpe+yD4koba_XL-1pweRRib29Vaxiw@mail.gmail.com>
Message-ID: <CAK8P3a1eOEFkCpQm15Y6Xpe+yD4koba_XL-1pweRRib29Vaxiw@mail.gmail.com>
Subject: Re: [PATCH 3/3] clk: socfpga: allow compile testing of Stratix 10 /
 Agilex clocks
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Ui7KFPID1y6EL0NwtZjYxj2ZG713wBxY9crm0E+5zRAfpReBhpD
 BSUlfVt8BgFx2uZUakxpHSZQYzyEAOXH2i3KCjohbqNhhKY7aA9TY/5WE5kmwpY5hznxAtx
 1durcfAcLOSpNlaLWBWYK5uuIeX7KkeJ9ZFE5j+WWgNv0TCNpGRVAAx2MwLBhnykAUju09+
 eNOX6Kr/AYGkzqG3Dj4YQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:oRNKUcORbgU=:w6El0iGhxwFHV0PqqQOU2s
 tP3Qf2uKuFzVE439CZyW51MNm8+oyapYFo3AZ84tovkBA7fYA877/7G2c6e6tHcBccA92h7Of
 ua1as4a7Vklj1fZkvIV69ysdwR07F/lSNlysOa7cWfC6Z1JLDMphriycOXTvzaxVvdEBur0KF
 W+0ohloxDGH2kgJIThPy8Ml4lqj9bVUIs4IYm1AYxCvO6hK0OXW1OsME+ljaIC4HGxABI/rKp
 lLYvhtI15ytfa5SRHo/2qgulPYbelfJHbsTpkoMCcRSQa3iCF9hFs7nI37KkQIxGagM/0wjkf
 +YsJZYnbbTDgv77GRutcwkvTAVK0Oxb4V9I1ksw463iRQwtHUdrND5Dw32Ri5lhhImFMN0B58
 4tj/ABE7+jEnD4mJ9jxyGI9SYVfv4YqldbQPp56uBnbiKalsQ3J+oD5YsggfZ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 9, 2021 at 10:02 AM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:

> >
> > Kernel test robot found here wrong configuration - possibility to
> > disable the clocks with compile test. I'll send a v2.
>
> Uh, that's not that easy. Intel created three different arm64 architectures
> for one real arm64 architecture... I guess it was driven by
> the marketing but here we are - the solution would be to have entries like:
>
> bool "Intel SoCFPGA family clock support" if COMPILE_TEST && !ARCH_AGILEX && !ARCH_N5X && !ARCH_SOCFPGA && !ARCH_STRATIX10
> ...
> bool "Intel Stratix / Agilex / N5X clock controller support" if COMPILE_TEST && !ARCH_AGILEX && !ARCH_N5X && !ARCH_STRATIX10
> ...
> bool "Intel Agilex / N5X clock controller support" if COMPILE_TEST && !ARCH_AGILEX && !ARCH_N5X
> ...
>
> I think it looks wrong. The stratix/agilex/n5x are basically flavors of
> socfpga from Linux point of view. This is the same architecture for Linux
> kernel, from high level point of view. Instead of going with unified ARCH_SOCFPGA
> (like all other platforms, e.g. Renesas, NXP), the Intel create three
> different kernel-wide arm64 ARCH_xxx symbols.
>
> It's too much. How about converting all these arm64 Intel platforms to ARCH_SOCFPGA?

Agreed, that seems best here.  There is no need at all to have multiple
top-level Kconfig symbols when these are all part of one SoC family.

       Arnd
