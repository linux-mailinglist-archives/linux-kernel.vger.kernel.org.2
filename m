Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7259932E5B8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 11:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhCEKGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 05:06:39 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:55975 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhCEKGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 05:06:33 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MLiXQ-1l0aV12ZFY-00Hj7X for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021
 11:06:27 +0100
Received: by mail-oi1-f177.google.com with SMTP id z126so1902303oiz.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 02:06:27 -0800 (PST)
X-Gm-Message-State: AOAM531Hw6L0Lo5Vmhvsu0TzU8wo7/GE8JEnP7jzzDw9pO+97HqaC+QW
        3Jt1HKKmte1p+FXT4MoPfkMj57qFXH9g+/gFskU=
X-Google-Smtp-Source: ABdhPJwzyOO7oekaLxVCuYpCBrhMK4PzMy38JZ7xjbD74JT6jclKDiqZP1kKYyYJiRiPAwfQ+NkcFWiabrQ66QAV4CE=
X-Received: by 2002:a05:6808:3d9:: with SMTP id o25mr6442482oie.4.1614938786377;
 Fri, 05 Mar 2021 02:06:26 -0800 (PST)
MIME-Version: 1.0
References: <f08ef2b6f339ba19987cfef4307a4dd26b2faf97.1614933479.git.christophe.leroy@csgroup.eu>
In-Reply-To: <f08ef2b6f339ba19987cfef4307a4dd26b2faf97.1614933479.git.christophe.leroy@csgroup.eu>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 5 Mar 2021 11:06:09 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2b+u+8smkKWB-V2Non+nnZmNG4dNi6cGpM8weYuY5j6A@mail.gmail.com>
Message-ID: <CAK8P3a2b+u+8smkKWB-V2Non+nnZmNG4dNi6cGpM8weYuY5j6A@mail.gmail.com>
Subject: Re: [PATCH v3] powerpc/32: remove bogus ppc_select syscall
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:XD4AW04t8YHVMP2SQ5rTmd4fjBic97r75+2s7osFwY/sZV6klA2
 +V9o2ertgiassocNqDbpY3ltAWvtFUV8cnJO/jjfYlx0UHYx5NWIZ0a7mfpFRcFpIuRy7+5
 pvUO6QrFy7Slz/HFqk5W3159Oq8+b07qrneHqBJDJuiWiuJ+5z6QemRVQNEmoBKimao3YPu
 rkmkSctvyihDFOzFjZlmQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RLgcZuQPRGw=:GOTj6mchfe8I/RGLDL0XvW
 W9A0al+WgOPSzseyodwlr+CkCz3FvPX/3x+mTMyFu59KXRAs8jD2hI1EJ4v65Xi8OILaN4iHm
 503u5IieeL4oMsmkxTBUkYDUodGADzKNCXqXr4UIMdxZhaW7AtppoctPlQ9ZVGs2nlh56SxGQ
 Z/JzMj2/ItLx23dyPQmuN3veELYe7d3TGaXXnQdMbWtT+9FduxNBonqsEL2f1+wASmjU4RFJJ
 HGC0LXTADbdOSiQbfAqo6U898baEloc/V1RXJkxebiBinuMlp6usAsjZNOYRnAUi1vw9R9Aay
 jcwhC8s0IdrLw7lW/BuTIWzMbuANBH1tcDZL+R7la6dEWCqsZtGz8wTVlhGBqHvhKyT25FYj/
 jbB3A83DKZUjltDp0K6BQVQG1jUu+QMF3pJqD8hDWVcKn7LivdIjOpkpXl4JlE0IfScRnBneJ
 OfxjzatgjPqCcCqsddB7Yqb1FjKj9FHwwy34vGgNCSBBAdNl8tFe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 5, 2021 at 9:40 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The ppc_select function was introduced in linux-2.3.48 in order to support
> code confusing the legacy select() calling convention with the standard one.
> Even 24 years ago, all correctly built code should not have done this and
> could have easily been phased out. Nothing that was compiled later should
> actually try to use the old_select interface, and it would have been broken
> already on all ppc64 kernels with the syscall emulation layer.
>
> This patch brings the 32 bit compat ABI and the native 32 bit ABI for
> powerpc into a consistent state, by removing support for both the
> old_select system call number and the handler for it.

The description still seems wrong, please drop all the nonsense I wrote
back then and explain what is actually going on.

This is what I can see from the linux-history tree:

- The original ppc32 port (linux-1.3.45) had a regular '__NR_select/sys_select'
  syscall at #82 and an unusable '__NR__newselect/sys_panic' syscall at #142,
  while i386 had the indirect '__NR_select/sys_oldselect' syscall at #82
  and the regular '__NR__newselect/sys_select' version at #142. This was
  rather confusing.

- linux-2.1.48 changed both #82 and #142 to the ppc_select() version that
  tries to guess whether the x86 __NR_select/sys_oldselect() behavior or
  the regular __NR__newselect/sys_select() behavior is used.

- linux-2.5.5 added ppc64 support, with a compat version of ppc_select()
  on both #82 and #142 that would either use the __NR__newselect/sys_select
  semantics or panic() when passed an invalud 'n'. The native ppc64
  port started out with just __NR__newselect/sys_select() on #142

- linux-2.5.19 changed ppc64 compat mode to no longer panic(), making
  both #82 and #142 behave like __NR__newselect/sys_select().

- glibc support for ppc32 gets merged during the linux-2.5 days, supporting
  only #142 with the new behavior.

- linux-2.5.41 dropped support for #82 on ppc64 in compat mode but not
  native ppc32.

- linux-2.6.14 merged the two architecture ports but kept the behavior
  unchanged for both.

- linux-2.6.32 changed the native ppc32 #142 __NR__newselect to
  behave the same as compat mode and no longer emulate the
  x86 oldselect, but #82 remained unchanged.

So we have changed behavior multiple times in the past, and the
current state still theoretically allows running non-glibc binaries that
ran on kernels before 2.1.48 that used either the original powerpc
select or the i386 compatible oldselect semantics. Chances are that
those binaries are broken for some other reason now.

          Arnd
