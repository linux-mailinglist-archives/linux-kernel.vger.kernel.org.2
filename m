Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF6743D95E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 04:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhJ1Cgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 22:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhJ1Cgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 22:36:52 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAD6C061570;
        Wed, 27 Oct 2021 19:34:26 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id x123so4469492qke.7;
        Wed, 27 Oct 2021 19:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f6o+IkFBRDipXB+mr7tK5K3Jvog77+/qkpkilgk8pQc=;
        b=LqMRoqh1KWXj4y0Bzc/3KgBIvy6PlgRiTW6fJiqDefb7KoHeIlOeqEIgQaR1YcRFPa
         90Mq1Z+VYVOHBZq5bfiaNEVxAF9Th/vXlWQXuNlxQxgX401E71eRNlJx5INWbVVEifj2
         yvUnT9rmlLIw2+bLIdvYVTX3PFcAnP9Ep8TMZFyLjS0+O4lYKPqBpMXFTCwOi9ye/8nJ
         BvQs4ougRNwANW+2gmFOIEONxXE3IGpouPcEvrFGtHY0mUGR/DMPwrTFu5XOYVxOweb7
         7JxzLhPO5uUcTGCZ7dKJW95uAIaZoecRTcMUgGMq4lOTpywPSToDHob+n89G11le86tV
         u0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f6o+IkFBRDipXB+mr7tK5K3Jvog77+/qkpkilgk8pQc=;
        b=Hbdiwip33oF5C4/uY6hJFIz866NX2OaVhs/nNQ+QivmQbx51mcjicC0mFvM1Py6oiK
         PsxQ3P7YCUPzZvkU+clkfZFvWI4Df4N7RYn7kJ2AK4Qz5Mbv+5AzyUMiM/amC4jUlh4P
         jbqAOV6yQ1NK60SYpeFyLY3upAlW2d0nOeGchvgthGaGVIWb9oIVXymXxHQ4LouPPY9q
         q10sEufj/Ihb+/HOZk4n3Ese4ZpP2F80kbZmcNPROFYDomXEMD4U8oNXntfZtDSdf9uA
         V9utR5UtHtLEX5+p99/srQZLVyBdhSO22OWWI63qlyYvPVBbZwpgicGGMv1+TXiRY4KE
         rUvw==
X-Gm-Message-State: AOAM531Pvo5n91garYTHL5JZMliNTpqgN5bagTEAKqJ3DKjOKQGoLDNd
        RTcaHTwufuppwbK6FAwuS7QUuU1k8Aw=
X-Google-Smtp-Source: ABdhPJwGpmqLpY7cp17kCOHJ1E8xZMR2ZKtcHsVfYYIYDcbmjgypWFnsw1iaEnTT5itq03PDiVxc5w==
X-Received: by 2002:a05:620a:46a1:: with SMTP id bq33mr1278125qkb.521.1635388465555;
        Wed, 27 Oct 2021 19:34:25 -0700 (PDT)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id k14sm1110585qko.120.2021.10.27.19.34.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 19:34:25 -0700 (PDT)
Subject: Re: [PATCH] scripts/dtc: Update to upstream version
 v1.6.1-19-g0a3a9d3449c8
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20211025172028.738446-1-robh@kernel.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <65c90678-b612-d208-1db3-aa7e48d8975d@gmail.com>
Date:   Wed, 27 Oct 2021 21:34:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211025172028.738446-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/21 12:20 PM, Rob Herring wrote:
> This adds the following commits from upstream:
> 
> 0a3a9d3449c8 checks: Add an interrupt-map check
> 8fd24744e361 checks: Ensure '#interrupt-cells' only exists in interrupt providers
> d8d1a9a77863 checks: Drop interrupt provider '#address-cells' check
> 52a16fd72824 checks: Make interrupt_provider check dependent on interrupts_extended_is_cell
> 37fd700685da treesource: Maintain phandle label/path on output
> e33ce1d6a8c7 flattree: Use '\n', not ';' to separate asm pseudo-ops
> d24cc189dca6 asm: Use assembler macros instead of cpp macros
> ff3a30c115ad asm: Use .asciz and .ascii instead of .string
> 5eb5927d81ee fdtdump: fix -Werror=int-to-pointer-cast
> 0869f8269161 libfdt: Add ALIGNMENT error string
> 69595a167f06 checks: Fix bus-range check
> 72d09e2682a4 Makefile: add -Wsign-compare to warning options
> b587787ef388 checks: Fix signedness comparisons warnings
> 69bed6c2418f dtc: Wrap phandle validity check
> 910221185560 fdtget: Fix signedness comparisons warnings
> d966f08fcd21 tests: Fix signedness comparisons warnings
> ecfb438c07fa dtc: Fix signedness comparisons warnings: pointer diff
> 5bec74a6d135 dtc: Fix signedness comparisons warnings: reservednum
> 24e7f511fd4a fdtdump: Fix signedness comparisons warnings
> b6910bec1161 Bump version to v1.6.1
> 21d61d18f968 Fix CID 1461557
> 4c2ef8f4d14c checks: Introduce is_multiple_of()
> e59ca36fb70e Make handling of cpp line information more tolerant
> 0c3fd9b6aceb checks: Drop interrupt_cells_is_cell check
> 6b3081abc4ac checks: Add check_is_cell() for all phandle+arg properties
> 2dffc192a77f yamltree: Remove marker ordering dependency
> 61e513439e40 pylibfdt: Rework "avoid unused variable warning" lines
> c8bddd106095 tests: add a positive gpio test case
> ad4abfadb687 checks: replace strstr and strrchr with strends
> 09c6a6e88718 dtc.h: add strends for suffix matching
> 9bb9b8d0b4a0 checks: tigthen up nr-gpios prop exception
> b07b62ee3342 libfdt: Add FDT alignment check to fdt_check_header()
> a2def5479950 libfdt: Check that the root-node name is empty
> 4ca61f84dc21 libfdt: Check that there is only one root node
> 34d708249a91 dtc: Remove -O dtbo support
> 8e7ff260f755 libfdt: Fix a possible "unchecked return value" warning
> 88875268c05c checks: Warn on node-name and property name being the same
> 9d2279e7e6ee checks: Change node-name check to match devicetree spec
> f527c867a8c6 util: limit gnu_printf format attribute to gcc >= 4.4.0
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> As usual, the diff is what's changed from upstream and not all that 
> meaningful to review.
> 
>  scripts/dtc/checks.c              | 222 ++++++++++++++++++++++--------
>  scripts/dtc/dtc-lexer.l           |   2 +-
>  scripts/dtc/dtc.c                 |   6 +-
>  scripts/dtc/dtc.h                 |  40 +++++-
>  scripts/dtc/flattree.c            |  11 +-
>  scripts/dtc/libfdt/fdt.c          |   4 +
>  scripts/dtc/libfdt/fdt_rw.c       |  18 ++-
>  scripts/dtc/libfdt/fdt_strerror.c |   1 +
>  scripts/dtc/libfdt/libfdt.h       |   7 +
>  scripts/dtc/livetree.c            |   6 +-
>  scripts/dtc/treesource.c          |  48 +++----
>  scripts/dtc/util.h                |   6 +-
>  scripts/dtc/version_gen.h         |   2 +-
>  scripts/dtc/yamltree.c            |  16 ++-
>  14 files changed, 275 insertions(+), 114 deletions(-)
> 
> diff --git a/scripts/dtc/checks.c b/scripts/dtc/checks.c
> index 17cb6890d45a..781ba1129a8e 100644
> --- a/scripts/dtc/checks.c
> +++ b/scripts/dtc/checks.c

< snip >

Cursory sanity check review.

Light testing: Build with a few config variations, boot dragonboard 8074.

Reviewed-by: Frank Rowand <frank.rowand@sony.com>
Tested-by: Frank Rowand <frank.rowand@sony.com>
