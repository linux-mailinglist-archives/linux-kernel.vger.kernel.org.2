Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B65444FC24
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 23:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236441AbhKNWKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 17:10:36 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:48811 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236374AbhKNWIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 17:08:10 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N3KDM-1me6DM1dx4-010IHU for <linux-kernel@vger.kernel.org>; Sun, 14 Nov
 2021 23:05:10 +0100
Received: by mail-wr1-f49.google.com with SMTP id s13so26804762wrb.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 14:05:10 -0800 (PST)
X-Gm-Message-State: AOAM533o/mlYv+Y6LlZupFuo5l8o0nD29GY4Nq4nYRKcDhVmzJazBrVW
        MPVD38w2jIqye9OvUt/YHNBYdfWnsgUDKhm8DP4=
X-Google-Smtp-Source: ABdhPJz1k2PRyR2pmvTjcTBsWWHAw9pSmKIoUtwnmVc2tgXGFCqkuFE2UPryKhUJ7sGy+V5SWxaA2kz6rpPPfoPdBao=
X-Received: by 2002:adf:d1c2:: with SMTP id b2mr41326612wrd.369.1636927510071;
 Sun, 14 Nov 2021 14:05:10 -0800 (PST)
MIME-Version: 1.0
References: <b5bdea22-ed2f-3187-6efe-0c72330270a4@infradead.org>
In-Reply-To: <b5bdea22-ed2f-3187-6efe-0c72330270a4@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 14 Nov 2021 23:04:53 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1FcP8R1stLEj4468kk_zF28rCQz7mZZhVk31r-jYpYcg@mail.gmail.com>
Message-ID: <CAK8P3a1FcP8R1stLEj4468kk_zF28rCQz7mZZhVk31r-jYpYcg@mail.gmail.com>
Subject: Re: SH: error: implicit declaration of function 'init_cache_node_node'
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:qi27Lhs/sfLvi1io7r8shoNj+T25Y6uNBmneVV2hxciwRNIekLO
 T2TaE9GBkZiZXmHgwTMa88bPU2YMqv6WT0K4JHMhqgm2kvDWj0plpRf/ax8+odPbSZJ10r/
 dxW1AXFzhkOEP2WthG6Eal4C+Fz8Y350wYdI8cYlX1i+9QntkAKIaPTpfe0QZ2o3eibCfmh
 5AcfiSZXrGDrWq8JVfpww==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rpTEI/Iwlas=:K/87tJrhhvQHRgtDgg8Uz2
 cZKCnBSrPEu/Sovxi64dHqY52zItwd5Q0JOisSimvZacfeIK0Znse0JBN7dXkJ4pkEG9CCiAi
 swaOb6SxziqLi1CmH5vkyHtFYIRZBhyfem0hH+L3STZQT+3TAytjheHvsGQaM0qp72dBeIXzs
 lFOVGTQvlNLnAD10qW2pw9Ax1S2fZFYoG6JmVPwkP5AIqoZpJFqn3yNzDgWhwCxy2WBIXcTKP
 lM58JKAo74u7zSaYwqMfteXONRzdjS4GOtJgYu2Rz5xduE3yo+6njQLzCf4t9HiFUTqGZjCkO
 DWfAcUCN83ymc9pZfFkQ5ufIM0/ARWrKRLp/IPfY4DqMzMDSBNXKVBfLOlJH8x1hmwhphn8SA
 2bAwEKf2/4CBiumq0qWVaoz7tEKaWcuP5K5sitafubfE0DwyoeXcxX14TYCDynh52z5uknXwR
 J7oWNni1ghNYN9/05ynS0if9Q4AoJgIJJGMejUupV+/UA3V2YA4l7GYMGhcpx1JJZcNaUyWpX
 8gNW+DuTdDbxeT4fXcLunIy5b8NCCbHzPv4O+ftEsXQdNon7ms2g2gc9zNi7GKjFoe2RpmZLD
 zaQWImgYLY4NqixRKlPI8E7zdkNoGnoYC7+kE/5IGogU85sMfYDPqrS9Mucjb8syA7Xw13REh
 B1X+iQuzJIFHwaS5B+XoziL7mtzgEs2xZ7o3ZyHIGW4NfC+H7rFDxkP0UByE9LL4lz6k=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2021 at 2:17 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> on arch/sh/,
> CONFIG_SMP is not defined,
> CONFIG_NUMA=y,
> CONFIG_MEMORY_HOTPLUG is not defined:
>
> ../mm/slab.c: In function 'slab_memory_callback':
> ../mm/slab.c:1143:23: error: implicit declaration of function 'init_cache_node_node'; did you mean 'drain_cache_node_node'? [-Werror=implicit-function-declaration]
>   1143 |                 ret = init_cache_node_node(nid);
>
>
> commit 76af6a054da4
> Author: Dave Hansen <dave.hansen@linux.intel.com>
> Date:   Mon Oct 18 15:15:32 2021 -0700
>
>      mm/migrate: add CPU hotplug to demotion #ifdef
>
>
> How should we handle this config?

I think we can safely assume that NUMA without SMP is not a useful
configuration on SH and add a dependency in Kconfig for it.

I assume this came from some randconfig build rather than a config
that someone was intentionally using? My guess would be that testing
sh randconfig kernels is not overly productive as you likely need
countless patches before there is a chance of it working most of
the time. I haven't tried this myself, but I spend a lot of time fixing
randconfig failures on arm and x86, and I whenever I try any other
architecture, there is simply too much work needed upfront.

        Arnd
