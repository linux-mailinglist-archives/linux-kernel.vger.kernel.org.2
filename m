Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65EC3EA10F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 10:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbhHLIzG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 Aug 2021 04:55:06 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:51139 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbhHLIzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 04:55:04 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mow06-1mtD8a0ffi-00qVxq for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021
 10:54:38 +0200
Received: by mail-wr1-f45.google.com with SMTP id q10so7214363wro.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 01:54:38 -0700 (PDT)
X-Gm-Message-State: AOAM531Gou1N3h4yRFKOzMsen8vmyCbgdJSsGin8aXFay9orXOdu0t2P
        Bk/pKA8qOnmRifO2ejqPFq5oMZc0snmPgbUjyrc=
X-Google-Smtp-Source: ABdhPJzZv/5OPQVMV4X72DNrEeILwE4MD89RT2+33mM5oD+u5NtsqZPGmxrUuRpkUtjSdyCe45aXAKV0gko4m0wLh/Y=
X-Received: by 2002:adf:fd89:: with SMTP id d9mr701787wrr.361.1628758477814;
 Thu, 12 Aug 2021 01:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210806030138.123479-1-xianting.tian@linux.alibaba.com>
 <20210806030138.123479-2-xianting.tian@linux.alibaba.com> <CAK8P3a2=BmVv0tvUKaca+LYxuAussAJtAJW9O3fRN2CbV2-9aw@mail.gmail.com>
 <f18d017b-d6f7-cf87-8859-8d6b50c7c289@linux.alibaba.com>
In-Reply-To: <f18d017b-d6f7-cf87-8859-8d6b50c7c289@linux.alibaba.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 12 Aug 2021 10:54:22 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2ykLvJkhX+wDAOHdyLHjPFAfhOxi5BNM9kTKv_8F7VQg@mail.gmail.com>
Message-ID: <CAK8P3a2ykLvJkhX+wDAOHdyLHjPFAfhOxi5BNM9kTKv_8F7VQg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] tty: hvc: pass DMA capable memory to put_chars()
To:     Xianting TIan <xianting.tian@linux.alibaba.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, gregkh <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Amit Shah <amit@kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:BQoTlOxcHqA6Jtpz6G3I3iEkEbcUJNnHyR0h3BwaWv5nor11G/e
 PLoxk9dK0LwHMNkHlClRBDGKWtyOaPSjZHVTKpsd6v2dC97N3iRp5KbE5CoGpBMiQPLs3yx
 9hpQ4SFJ9lUHe4to0Oh9N1yzyLqvJutjexWJ+FEP6UDCSb72Pl5tHmdmrEB9bRtEXCSIJv+
 6GMkfVieEBNRLWHGOeF1A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BjMA3fbz6kw=:CyRb4FO92E5xxUMElyAPUF
 aRnGrM15tGTjfzAQFXeDt7dU44dduc49Mw5jiDlV1OBRS5i6tMI4NsHfVUcVpDnjd2l6QXp2O
 PeZ8r8gyjZN0sDF/3folLaRYBs5jIZ3GkbeW3Q0+smu0I87KEBmEi2kNZRUj12HtkpjWscx25
 ZgV4OulF6Ab3UQf9QYpSMN5c2CwHXlCSVM10xok/ZVsZa9CTDKdu4SnxGZFVM4x0zx9VS4EYj
 3hhQ+mLHIHRpJXHx/j1nlIRnko2jDOE2egYsWt3i+WhtcUVKfQ1K/Hqb55wTVXzYnCsid6l7r
 /iFeoIPIWXx8ja2aSHM1+dzmAFKXGGYPNptskr7DI9CrpA/2ga9CDkvajt6VQ1OfQXyRSylnB
 O2y4atQ95WlVPNiiuS8S2oUrmm8stWpimhob7G1dQ6+WhVRJBGNPVcdRkEfRY3A17rGyM4DlT
 56iIRtdeCEEDxRukWQHZlEjprxs6BPLSsnHUX+9xdl2KUTjfLV5f4aTiPhqaFc9YBE9nDSNXc
 U2Ee8el8dTxaABFY86c99JlaoCS6yvPdP1VlMPoJO15UvCJlTF/1LNzuszNlZpUjWqud9SveR
 at+8MNf/Q8rOzDHPdb4TLuvqxcXbdah9wAJLSZfeMYwPyPbXDC0EPSosd59+JgePg1KqhBjYx
 toW1CO8E14jQXs1U1q53ag0pu9LwazV87/GctFxtK8RhAq83TOrek9bzXCKUiRf57fUjnfS28
 G8HHJMCV9zLRgO+jnpLQp6tAaxKrQZ/g6n2gW4TOR25pf2VG7ME3Sy5oYqpqnj+1F3bbcHwMq
 j8QJWmfU/8TDyFqTgXBI2DLgsnQuURoV3rJZRqnFM7W3IHwsLCgVU/n6Xl5QV/7daawkc8fTH
 hTBcOjlORguiQAbfhYR5Ao5ACmDZ9uyPELRRtDh9dnsHBzTAiCbHoveO8lcojK14vOlK4kex6
 AyifyKgV5VJzzK48ec769bMJMHjbatbLUov+gIsXggmeTNBN+K0Ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 10:08 AM Xianting TIan
<xianting.tian@linux.alibaba.com> wrote:
> 在 2021/8/6 下午10:51, Arnd Bergmann 写道:
> > On Fri, Aug 6, 2021 at 5:01 AM Xianting Tian
> >> +#define __ALIGNED__ __attribute__((__aligned__(sizeof(long))))
> > I think you need a higher alignment for DMA buffers, instead of sizeof(long),
> > I would suggest ARCH_DMA_MINALIGN.
>
> As some ARCH(eg, x86, riscv) doesn't define ARCH_DMA_MINALIG, so i think
> it 's better remain the code unchanged,
>
> I will send v5 patch soon.

I think you could just use "L1_CACHE_BYTES" as the alignment in this case.
This will make the structure slightly larger for architectures that do not have
alignment constraints on DMA buffers, but using a smaller alignment is
clearly wrong. Another option would be to use ARCH_KMALLOC_MINALIGN.

Note that there is a patch to add ARCH_DMA_MINALIGN to riscv already,
as some implementations do not have coherent DMA. I had failed to
realized though that on x86 you do not get an ARCH_DMA_MINALIGN
definition.

       Arnd
