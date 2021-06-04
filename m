Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42FD439B992
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 15:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhFDNLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 09:11:37 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:47507 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbhFDNLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 09:11:36 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N7hrw-1lJzeJ0CeI-014grh; Fri, 04 Jun 2021 15:09:49 +0200
Received: by mail-wm1-f45.google.com with SMTP id h22-20020a05600c3516b02901a826f84095so613448wmq.5;
        Fri, 04 Jun 2021 06:09:48 -0700 (PDT)
X-Gm-Message-State: AOAM532Cjn2Pkz89cMAKF92UYv9RGkqVUfgXbw0z9roZH7a6ekbrEtI9
        5apxJPrpk48tBOTwOZhmfQWbYgLZ+aN6oAS5GEw=
X-Google-Smtp-Source: ABdhPJx8ue47u+2ojqaxQh82xTDoIj4A1jS8LO4yWYCY2SGX6umqH0TLVpYxZ8XFEA31FUz7gYr0AljW1hTzcG9ZN9s=
X-Received: by 2002:a7b:c849:: with SMTP id c9mr3677194wml.84.1622812188705;
 Fri, 04 Jun 2021 06:09:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210604120639.1447869-1-alex@ghiti.fr>
In-Reply-To: <20210604120639.1447869-1-alex@ghiti.fr>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 4 Jun 2021 15:08:05 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1TiSNoqUEjTaqPyqnU8d0-p-yZkrsvmXt5fo4Rkfue_w@mail.gmail.com>
Message-ID: <CAK8P3a1TiSNoqUEjTaqPyqnU8d0-p-yZkrsvmXt5fo4Rkfue_w@mail.gmail.com>
Subject: Re: [PATCH -fixes] riscv: Fix BUILTIN_DTB for sifive and microchip soc
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        DTML <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:YVJc7OWAWU7GAvZqagl35gj2DCcFhbhF7GnWixU7eVSHQRUOVrc
 T6zud0qNlFvjXJz+qQaJclwyEZetFmZnc7SrdVNBp6YaeHnYO5sufcfJWpD+6uyTh1Qkldy
 tu2D7p2MxuSmIvRCgo06Xjp6azjpdMbpJD5Hw4sdOsBPMdntYCrwJDb+mqmNh7hqPGv6wBx
 Q53Rq28e41IPUBm89V+kg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WVKVmBNwTsU=:m+XH20dnWnI2PwIArnEOXc
 vOzgQKTo5/hp5WgHDCUtsAtKfz6XMbDA2nce3nhCyFmPVe0HZkrjIjuKfxQyU4w7y7Upiu9Ll
 gW86taA+rb0+8CSDuDcqCTzTW/vuzg4EN3wL5gQhuJ8xwJFUUaVTqJYVpu25CSHjx9PcOzkrJ
 ruhT3jGaczJfGdKalN2OAEtzS/Xcyx8TDUt7XaMnbZpHjgzcPPY6lCmE1ReOXe8asRjM+8D3m
 Sq8QyWFTQHWMlwN//eyRy1jnttODZYRByx3O+ZY0SnusgBqAU3TLtostJexTtCxSAbt2Rg48J
 G9plCSXBWFjmyGoLPRWkBr+Tc9rHiHVPECdHAfoA7Yy4Pmz5GDMbhx7RfDidGay7JJ1Sun9V+
 E4vI7Qhfp8m+k58Zla0HkFWzs77UUqkZubdB/0BAUNfAZ+zbvTtoGwjPawoe0rjXpVgjPvQ+h
 PS/6wdzOxxTprre15GQu5jqWR6hK3ddvLtsLUSenKO/WwLcPCqtHTzRNyB2q7QYGek3XSgxMG
 WGyx34JluSNrieDKfvAGfACTk3sddFJef4i95VKLrfYwjV0GkJVG/rC2zzRqtNFoqwpUGwNp4
 mN2fE+6P7sp5nS11XFgcGPOfdoTXnTU72zjvo9pH3oiTKr3Onc662oYURXL399Yc+mzNylPpx
 NbPc=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 4, 2021 at 2:06 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> Fix BUILTIN_DTB config which resulted in a dtb that was actually not built
> into the Linux image: in the same manner as Canaan soc does, create an object
> file from the dtb file that will get linked into the Linux image.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

Along the same lines as the comment that Jisheng Zhang made on the fixed
address, building a dtb into the kernel itself fundamentally breaks generic
kernel images.

I can understand using it on K210, which is extremely limited and wouldn't
run a generic kernel anyway, but for normal platforms like microchip and
sifive, it would be better to disallow CONFIG_BUILTIN_DTB in Kconfig
and require a non-broken boot loader.

      Arnd
