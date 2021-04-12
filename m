Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF1A35B865
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 04:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236454AbhDLCDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 22:03:54 -0400
Received: from mout.gmx.net ([212.227.17.22]:59321 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235543AbhDLCDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 22:03:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1618193014;
        bh=1i0/bU1YcO3Qhu8dneeqOidjDAAzbbaq+60xWyhVHAk=;
        h=X-UI-Sender-Class:From:Subject:To:Date;
        b=P5G+iVhksCNwNeK2X96Z+TXirEA1XJoIfFJV9kGaimDOcEYsa7k7em9s8N+mLmu3d
         L8jBhYa3mmyLHZscYAeqEGBty6uJ6+BCouUrZYJrufWouKI/0eKeRt8XISUN5z9N26
         kqmc0rrVTv9f/p1cBlVY25OTOWWTtY6EtiGZpn1Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from obelix.fritz.box ([46.142.11.40]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxlzC-1llfB21qTG-00zDeX for
 <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 04:03:34 +0200
From:   Ronald Warsow <rwarsow@gmx.de>
Subject: Re: Linux 5.12-rc7
To:     linux-kernel@vger.kernel.org
Message-ID: <c8f19524-28a5-5468-93d6-25ee2c9045f6@gmx.de>
Date:   Mon, 12 Apr 2021 04:03:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hWvMIJMWPBIcvRmH3evYO2doIFC8+DDL9cg+mVWX8doPZEL/5Ke
 q+wsKDM1bUvsa5WZsbzkyFA2LI2valppR/K/Uho4ZlSyBMwdq+3/i2nRVasuwaDwlZgX+NT
 rL5MQ2wcjdCZoWvQCXXN8WS2rM5neq/CLtZhLKLx7eTbeFBai76vIvAeY4KOh7nke/fgrB1
 Adx1eg7rlycGtabf2HmOg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:d2vnwmKlTeY=:apQRgL9X5a1BetIzXSHJ1u
 yHn9jdyTs1tQeUqdHheZGm4uTthjmhHZEIGDQqbA4xhoVxmyU64ks6kPrIBSYcc/8Yl+gjLWC
 /Y22dLG4LupvirmDRoc6gkBxLbtLLSRvx2373V7YUc4AOnDuHq/ODKbc9pTpK4fBRUXW8e0dH
 Xqh/Pnu0LFZmC9G4UCBbry0CtXhU68IbZzLRdtdEPnwrjTEL9+B+mHFhUL+7Tx3NHH0BffePE
 h3hlWVBqWXbXYxiqI9GLFVrvwjRyDohk3iPxuRexG+GlcG6Qv6vsHv6MUO2WG/5laizFPj3IF
 GK9E+4ACtksyqFC7cjh0fLPFIjL7qQM1yVoauhypscB3NUOJDftOWoulBuGftaOLf3nipqGSG
 CTno4MwQ1t7oxwKNMGmZG3vfVZTujhoENTSSZJqqvQgrB6zrIVX25fbmgViaj4t5SziFgHphm
 992wRDbf1Ahg5MehbbrzkunhX6X4AM72HC4dnoJ/TvmNgKjvVYoTC3jP53CQ6hZpz0Iwl6omF
 2dn8anfrichajRyiE+G5tdP8+3YaHW45n4S+YpmkKVBekZ0zh2DSm+vDeugN1eXcdJkowvVCF
 5ukQNu7ILlkptjUYrHF0u6aoJomvJpGb7FQrtoSpXVyJyMMKEnJgv09RTKhQOzYUYG93RJdel
 i7ByFNAAmqC7++aB0lSebFaGDCU3F5/13igCpBP6jglPMveUKamWV5ONRFryDe8pK9ZjNwvbl
 w/fvSsxXDYIjPDjz2CPCyoJ2Xw6T5iGJcHMIjySDUnciP/j1CGx30z4gYULBhep2WT7svFL1d
 a/vN7DRbLZ+wRKNb9hyozD34QSvkbhYtlDKe8EG2pfAiO8ukS4z2e001S4VcKZ3fyssRKH/9F
 f1rfGSFuipbauh6ZrBKGTYbO12yfnxu16ZV13g9zMaEuT7KxS1ZnjAc2ujVUuzmq1MbAoefNu
 ylHI19wlfNaf/QmOV7Fh+OuFZVzlA15JsE6P37M4CXrrN8c6VF8RPPpAxUHJWfiFlq+upE+g+
 eEAhz59znWisFWqvRv0JrBlH5IKfSGlGgKcaUnmx2CQJ4Tp2+xbDsCmVZgn0z8wXvDXjEUP9R
 XRvon2mF4bM7cz64pbZ9pOv7Sb7w8QQLv303dozq25fnoO8yjhRgbCVP5OvwLl8ljHG6qp+Vq
 iewGbvilb+SUsw+ADR0p5JrRMsm2BuZgZ8MMqlyocXuEPJmOelq/UPWm3EP3zQ4FRSRvI=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo

thanks all for the new kernel.

however, I see the following since linux-5.12-rc6 (when I started
testing 5.12)

I'm, as a non-developer, quiet not sure what the warning mean or better
how important they need to be taken, cause the box run's fine, so far.

I'm not sure if the warnings, etc. are only caused by the new compiler,
what is: gcc version 11.0.1 20210405 (Red Hat 11.0.1-0) (GCC) on an
Fedora 34 (beta) box or if it's something else.


during compilation:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

...
In function =E2=80=98poly1305_simd_init=E2=80=99,
     inlined from =E2=80=98crypto_poly1305_setdctxkey=E2=80=99 at
arch/x86/crypto/poly1305_glue.c:150:4,
     inlined from =E2=80=98crypto_poly1305_setdctxkey=E2=80=99 at
arch/x86/crypto/poly1305_glue.c:144:21,
     inlined from =E2=80=98poly1305_update_arch=E2=80=99 at
arch/x86/crypto/poly1305_glue.c:181:8:
arch/x86/crypto/poly1305_glue.c:86:9: warning: =E2=80=98poly1305_init_x86_=
64=E2=80=99
reading 32 bytes from a region of size 16 [-Wstringop-overread]
    86 |         poly1305_init_x86_64(ctx, key);
       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/x86/crypto/poly1305_glue.c: In function =E2=80=98poly1305_update_arch=
=E2=80=99:
arch/x86/crypto/poly1305_glue.c:86:9: note: referencing argument 2 of
type =E2=80=98const u8 *=E2=80=99 {aka =E2=80=98const unsigned char *=E2=
=80=99}
arch/x86/crypto/poly1305_glue.c:18:17: note: in a call to function
=E2=80=98poly1305_init_x86_64=E2=80=99
    18 | asmlinkage void poly1305_init_x86_64(void *ctx,
       |                 ^~~~~~~~~~~~~~~~~~~~
...

   CC      security/selinux/ss/sidtab.o
In file included from ./include/linux/string.h:269,
                  from ./include/linux/bitmap.h:9,
                  from ./include/linux/cpumask.h:12,
                  from ./arch/x86/include/asm/cpumask.h:5,
                  from ./arch/x86/include/asm/msr.h:11,
                  from ./arch/x86/include/asm/processor.h:22,
                  from ./arch/x86/include/asm/cpufeature.h:5,
                  from ./arch/x86/include/asm/thread_info.h:53,
                  from ./include/linux/thread_info.h:59,
                  from ./arch/x86/include/asm/preempt.h:7,
                  from ./include/linux/preempt.h:78,
                  from ./include/linux/rcupdate.h:27,
                  from ./include/linux/rbtree.h:22,
                  from ./include/linux/iova.h:14,
                  from ./include/linux/intel-iommu.h:14,
                  from arch/x86/kernel/tboot.c:9:
In function =E2=80=98memcmp=E2=80=99,
     inlined from =E2=80=98tboot_probe=E2=80=99 at arch/x86/kernel/tboot.c=
:70:6:
./include/linux/fortify-string.h:19:33: warning: =E2=80=98__builtin_memcmp=
_eq=E2=80=99
specified bound 16 exceeds source size 0 [-Wstringop-overread]
    19 | #define __underlying_memcmp     __builtin_memcmp
       |                                 ^
./include/linux/fortify-string.h:235:16: note: in expansion of macro
=E2=80=98__underlying_memcmp=E2=80=99
   235 |         return __underlying_memcmp(p, q, size);
       |                ^~~~~~~~~~~~~~~~~~~
...

   CC      net/core/fib_rules.o
In function =E2=80=98snb_wm_latency_quirk=E2=80=99,
     inlined from =E2=80=98ilk_setup_wm_latency=E2=80=99 at
drivers/gpu/drm/i915/intel_pm.c:3108:3,
     inlined from =E2=80=98intel_init_pm=E2=80=99 at drivers/gpu/drm/i915/=
intel_pm.c:7628:3:
drivers/gpu/drm/i915/intel_pm.c:3057:9: warning:
=E2=80=98intel_print_wm_latency=E2=80=99 reading 16 bytes from a region of=
 size 10
[-Wstringop-overread]
  3057 |         intel_print_wm_latency(dev_priv, "Primary",
dev_priv->wm.pri_latency);
       |
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/i915/intel_pm.c: In function =E2=80=98intel_init_pm=E2=80=
=99:
drivers/gpu/drm/i915/intel_pm.c:3057:9: note: referencing argument 3 of
type =E2=80=98const u16 *=E2=80=99 {aka =E2=80=98const short unsigned int =
*=E2=80=99}
drivers/gpu/drm/i915/intel_pm.c:2994:13: note: in a call to function
=E2=80=98intel_print_wm_latency=E2=80=99
  2994 | static void intel_print_wm_latency(struct drm_i915_private
*dev_priv,
       |             ^~~~~~~~~~~~~~~~~~~~~~
In function =E2=80=98snb_wm_latency_quirk=E2=80=99,
     inlined from =E2=80=98ilk_setup_wm_latency=E2=80=99 at
drivers/gpu/drm/i915/intel_pm.c:3108:3,
     inlined from =E2=80=98intel_init_pm=E2=80=99 at drivers/gpu/drm/i915/=
intel_pm.c:7628:3:
drivers/gpu/drm/i915/intel_pm.c:3058:9: warning:
=E2=80=98intel_print_wm_latency=E2=80=99 reading 16 bytes from a region of=
 size 10
[-Wstringop-overread]
  3058 |         intel_print_wm_latency(dev_priv, "Sprite",
dev_priv->wm.spr_latency);
       |
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/i915/intel_pm.c: In function =E2=80=98intel_init_pm=E2=80=
=99:
drivers/gpu/drm/i915/intel_pm.c:3058:9: note: referencing argument 3 of
type =E2=80=98const u16 *=E2=80=99 {aka =E2=80=98const short unsigned int =
*=E2=80=99}
drivers/gpu/drm/i915/intel_pm.c:2994:13: note: in a call to function
=E2=80=98intel_print_wm_latency=E2=80=99
  2994 | static void intel_print_wm_latency(struct drm_i915_private
*dev_priv,
       |             ^~~~~~~~~~~~~~~~~~~~~~
In function =E2=80=98snb_wm_latency_quirk=E2=80=99,
     inlined from =E2=80=98ilk_setup_wm_latency=E2=80=99 at
drivers/gpu/drm/i915/intel_pm.c:3108:3,
     inlined from =E2=80=98intel_init_pm=E2=80=99 at drivers/gpu/drm/i915/=
intel_pm.c:7628:3:
drivers/gpu/drm/i915/intel_pm.c:3059:9: warning:
=E2=80=98intel_print_wm_latency=E2=80=99 reading 16 bytes from a region of=
 size 10
[-Wstringop-overread]
  3059 |         intel_print_wm_latency(dev_priv, "Cursor",
dev_priv->wm.cur_latency);
       |
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/i915/intel_pm.c: In function =E2=80=98intel_init_pm=E2=80=
=99:
drivers/gpu/drm/i915/intel_pm.c:3059:9: note: referencing argument 3 of
type =E2=80=98const u16 *=E2=80=99 {aka =E2=80=98const short unsigned int =
*=E2=80=99}
drivers/gpu/drm/i915/intel_pm.c:2994:13: note: in a call to function
=E2=80=98intel_print_wm_latency=E2=80=99
  2994 | static void intel_print_wm_latency(struct drm_i915_private
*dev_priv,
       |             ^~~~~~~~~~~~~~~~~~~~~~
In function =E2=80=98snb_wm_lp3_irq_quirk=E2=80=99,
     inlined from =E2=80=98ilk_setup_wm_latency=E2=80=99 at
drivers/gpu/drm/i915/intel_pm.c:3109:3,
     inlined from =E2=80=98intel_init_pm=E2=80=99 at drivers/gpu/drm/i915/=
intel_pm.c:7628:3:
drivers/gpu/drm/i915/intel_pm.c:3086:9: warning:
=E2=80=98intel_print_wm_latency=E2=80=99 reading 16 bytes from a region of=
 size 10
[-Wstringop-overread]
  3086 |         intel_print_wm_latency(dev_priv, "Primary",
dev_priv->wm.pri_latency);
       |
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/i915/intel_pm.c: In function =E2=80=98intel_init_pm=E2=80=
=99:
drivers/gpu/drm/i915/intel_pm.c:3086:9: note: referencing argument 3 of
type =E2=80=98const u16 *=E2=80=99 {aka =E2=80=98const short unsigned int =
*=E2=80=99}
drivers/gpu/drm/i915/intel_pm.c:2994:13: note: in a call to function
=E2=80=98intel_print_wm_latency=E2=80=99
  2994 | static void intel_print_wm_latency(struct drm_i915_private
*dev_priv,
       |             ^~~~~~~~~~~~~~~~~~~~~~
In function =E2=80=98snb_wm_lp3_irq_quirk=E2=80=99,
     inlined from =E2=80=98ilk_setup_wm_latency=E2=80=99 at
drivers/gpu/drm/i915/intel_pm.c:3109:3,
     inlined from =E2=80=98intel_init_pm=E2=80=99 at drivers/gpu/drm/i915/=
intel_pm.c:7628:3:
drivers/gpu/drm/i915/intel_pm.c:3087:9: warning:
=E2=80=98intel_print_wm_latency=E2=80=99 reading 16 bytes from a region of=
 size 10
[-Wstringop-overread]
  3087 |         intel_print_wm_latency(dev_priv, "Sprite",
dev_priv->wm.spr_latency);
       |
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/i915/intel_pm.c: In function =E2=80=98intel_init_pm=E2=80=
=99:
drivers/gpu/drm/i915/intel_pm.c:3087:9: note: referencing argument 3 of
type =E2=80=98const u16 *=E2=80=99 {aka =E2=80=98const short unsigned int =
*=E2=80=99}
drivers/gpu/drm/i915/intel_pm.c:2994:13: note: in a call to function
=E2=80=98intel_print_wm_latency=E2=80=99
  2994 | static void intel_print_wm_latency(struct drm_i915_private
*dev_priv,
       |             ^~~~~~~~~~~~~~~~~~~~~~
In function =E2=80=98snb_wm_lp3_irq_quirk=E2=80=99,
     inlined from =E2=80=98ilk_setup_wm_latency=E2=80=99 at
drivers/gpu/drm/i915/intel_pm.c:3109:3,
     inlined from =E2=80=98intel_init_pm=E2=80=99 at drivers/gpu/drm/i915/=
intel_pm.c:7628:3:
drivers/gpu/drm/i915/intel_pm.c:3088:9: warning:
=E2=80=98intel_print_wm_latency=E2=80=99 reading 16 bytes from a region of=
 size 10
[-Wstringop-overread]
  3088 |         intel_print_wm_latency(dev_priv, "Cursor",
dev_priv->wm.cur_latency);
       |
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/i915/intel_pm.c: In function =E2=80=98intel_init_pm=E2=80=
=99:
drivers/gpu/drm/i915/intel_pm.c:3088:9: note: referencing argument 3 of
type =E2=80=98const u16 *=E2=80=99 {aka =E2=80=98const short unsigned int =
*=E2=80=99}
drivers/gpu/drm/i915/intel_pm.c:2994:13: note: in a call to function
=E2=80=98intel_print_wm_latency=E2=80=99
  2994 | static void intel_print_wm_latency(struct drm_i915_private
*dev_priv,
       |             ^~~~~~~~~~~~~~~~~~~~~~
In function =E2=80=98ilk_setup_wm_latency=E2=80=99,
     inlined from =E2=80=98intel_init_pm=E2=80=99 at drivers/gpu/drm/i915/=
intel_pm.c:7628:3:
drivers/gpu/drm/i915/intel_pm.c:3103:9: warning:
=E2=80=98intel_print_wm_latency=E2=80=99 reading 16 bytes from a region of=
 size 10
[-Wstringop-overread]
  3103 |         intel_print_wm_latency(dev_priv, "Primary",
dev_priv->wm.pri_latency);
       |
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/i915/intel_pm.c: In function =E2=80=98intel_init_pm=E2=80=
=99:
drivers/gpu/drm/i915/intel_pm.c:3103:9: note: referencing argument 3 of
type =E2=80=98const u16 *=E2=80=99 {aka =E2=80=98const short unsigned int =
*=E2=80=99}
drivers/gpu/drm/i915/intel_pm.c:2994:13: note: in a call to function
=E2=80=98intel_print_wm_latency=E2=80=99
  2994 | static void intel_print_wm_latency(struct drm_i915_private
*dev_priv,
       |             ^~~~~~~~~~~~~~~~~~~~~~
In function =E2=80=98ilk_setup_wm_latency=E2=80=99,
     inlined from =E2=80=98intel_init_pm=E2=80=99 at drivers/gpu/drm/i915/=
intel_pm.c:7628:3:
drivers/gpu/drm/i915/intel_pm.c:3104:9: warning:
=E2=80=98intel_print_wm_latency=E2=80=99 reading 16 bytes from a region of=
 size 10
[-Wstringop-overread]
  3104 |         intel_print_wm_latency(dev_priv, "Sprite",
dev_priv->wm.spr_latency);
       |
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/i915/intel_pm.c: In function =E2=80=98intel_init_pm=E2=80=
=99:
drivers/gpu/drm/i915/intel_pm.c:3104:9: note: referencing argument 3 of
type =E2=80=98const u16 *=E2=80=99 {aka =E2=80=98const short unsigned int =
*=E2=80=99}
drivers/gpu/drm/i915/intel_pm.c:2994:13: note: in a call to function
=E2=80=98intel_print_wm_latency=E2=80=99
  2994 | static void intel_print_wm_latency(struct drm_i915_private
*dev_priv,
       |             ^~~~~~~~~~~~~~~~~~~~~~
In function =E2=80=98ilk_setup_wm_latency=E2=80=99,
     inlined from =E2=80=98intel_init_pm=E2=80=99 at drivers/gpu/drm/i915/=
intel_pm.c:7628:3:
drivers/gpu/drm/i915/intel_pm.c:3105:9: warning:
=E2=80=98intel_print_wm_latency=E2=80=99 reading 16 bytes from a region of=
 size 10
[-Wstringop-overread]
  3105 |         intel_print_wm_latency(dev_priv, "Cursor",
dev_priv->wm.cur_latency);
       |
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/i915/intel_pm.c: In function =E2=80=98intel_init_pm=E2=80=
=99:
drivers/gpu/drm/i915/intel_pm.c:3105:9: note: referencing argument 3 of
type =E2=80=98const u16 *=E2=80=99 {aka =E2=80=98const short unsigned int =
*=E2=80=99}
drivers/gpu/drm/i915/intel_pm.c:2994:13: note: in a call to function
=E2=80=98intel_print_wm_latency=E2=80=99
  2994 | static void intel_print_wm_latency(struct drm_i915_private
*dev_priv,
       |             ^~~~~~~~~~~~~~~~~~~~~~
   CC [M]  drivers/gpu/drm/i915/intel_runtime_pm.o
...

   AR      drivers/media/platform/built-in.a
   AR      drivers/media/pci/ttpci/built-in.a
arch/x86/lib/msr-smp.c:255:51: warning: argument 2 of type =E2=80=98u32 *=
=E2=80=99 {aka
=E2=80=98unsigned int *=E2=80=99} declared as a pointer [-Warray-parameter=
=3D]
   255 | int rdmsr_safe_regs_on_cpu(unsigned int cpu, u32 *regs)
       |                                              ~~~~~^~~~
In file included from ./arch/x86/include/asm/processor.h:22,
                  from ./arch/x86/include/asm/cpufeature.h:5,
                  from ./arch/x86/include/asm/thread_info.h:53,
                  from ./include/linux/thread_info.h:59,
                  from ./arch/x86/include/asm/preempt.h:7,
                  from ./include/linux/preempt.h:78,
                  from arch/x86/lib/msr-smp.c:3:
./arch/x86/include/asm/msr.h:347:50: note: previously declared as an
array =E2=80=98u32[8]=E2=80=99 {aka =E2=80=98unsigned int[8]=E2=80=99}
   347 | int rdmsr_safe_regs_on_cpu(unsigned int cpu, u32 regs[8]);
       |                                              ~~~~^~~~~~~
arch/x86/lib/msr-smp.c:268:51: warning: argument 2 of type =E2=80=98u32 *=
=E2=80=99 {aka
=E2=80=98unsigned int *=E2=80=99} declared as a pointer [-Warray-parameter=
=3D]
   268 | int wrmsr_safe_regs_on_cpu(unsigned int cpu, u32 *regs)
       |                                              ~~~~~^~~~
In file included from ./arch/x86/include/asm/processor.h:22,
                  from ./arch/x86/include/asm/cpufeature.h:5,
                  from ./arch/x86/include/asm/thread_info.h:53,
                  from ./include/linux/thread_info.h:59,
                  from ./arch/x86/include/asm/preempt.h:7,
                  from ./include/linux/preempt.h:78,
                  from arch/x86/lib/msr-smp.c:3:
./arch/x86/include/asm/msr.h:348:50: note: previously declared as an
array =E2=80=98u32[8]=E2=80=99 {aka =E2=80=98unsigned int[8]=E2=80=99}
   348 | int wrmsr_safe_regs_on_cpu(unsigned int cpu, u32 regs[8]);
       |                                              ~~~~^~~~~~~
   AR      drivers/media/pci/b2c2/built-in.a
...

   CC [M]  drivers/gpu/drm/i915/i915_scheduler.o
lib/crypto/poly1305-donna64.c:15:67: warning: argument 2 of type =E2=80=98=
const
u8[16]=E2=80=99 {aka =E2=80=98const unsigned char[16]=E2=80=99} with misma=
tched bound
[-Warray-parameter=3D]
    15 | void poly1305_core_setkey(struct poly1305_core_key *key, const
u8 raw_key[16])
       |
~~~~~~~~~^~~~~~~~~~~
In file included from lib/crypto/poly1305-donna64.c:11:
./include/crypto/internal/poly1305.h:21:68: note: previously declared as
=E2=80=98const u8 *=E2=80=99 {aka =E2=80=98const unsigned char *=E2=80=99}
    21 | void poly1305_core_setkey(struct poly1305_core_key *key, const
u8 *raw_key);
       |
~~~~~~~~~~^~~~~~~
   AS      arch/x86/lib/iomap_copy_64.o
...

   CC      lib/assoc_array.o
In function =E2=80=98intel_dp_check_mst_status=E2=80=99,
     inlined from =E2=80=98intel_dp_hpd_pulse=E2=80=99 at
drivers/gpu/drm/i915/display/intel_dp.c:5901:8:
drivers/gpu/drm/i915/display/intel_dp.c:4554:22: warning:
=E2=80=98drm_dp_channel_eq_ok=E2=80=99 reading 6 bytes from a region of si=
ze 4
[-Wstringop-overread]
  4554 |                     !drm_dp_channel_eq_ok(&esi[10],
intel_dp->lane_count)) {
       |
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/i915/display/intel_dp.c: In function =E2=80=98intel_dp_hpd=
_pulse=E2=80=99:
drivers/gpu/drm/i915/display/intel_dp.c:4554:22: note: referencing
argument 1 of type =E2=80=98const u8 *=E2=80=99 {aka =E2=80=98const unsign=
ed char *=E2=80=99}
In file included from drivers/gpu/drm/i915/display/intel_dp.c:38:
./include/drm/drm_dp_helper.h:1459:6: note: in a call to function
=E2=80=98drm_dp_channel_eq_ok=E2=80=99
  1459 | bool drm_dp_channel_eq_ok(const u8
link_status[DP_LINK_STATUS_SIZE],
       |      ^~~~~~~~~~~~~~~~~~~~
   CC [M]  drivers/gpu/drm/i915/display/intel_dp_aux.o
...


in with dmesg
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I see this ACPI Error's since 5.12-rc6 (a regression compared to 5.11.x)


[    0.960137] ACPI BIOS Error (bug): Could not resolve symbol
[\_PR.CPU0._CPC], AE_NOT_FOUND (20210105/psargs-330)
[    0.960141] ACPI Error: Aborting method \_PR.CPU1._CPC due to
previous error (AE_NOT_FOUND) (20210105/psparse-529)
[    0.960168] ACPI BIOS Error (bug): Could not resolve symbol
[\_PR.CPU0._CPC], AE_NOT_FOUND (20210105/psargs-330)
[    0.960170] ACPI Error: Aborting method \_PR.CPU2._CPC due to
previous error (AE_NOT_FOUND) (20210105/psparse-529)
[    0.960195] ACPI BIOS Error (bug): Could not resolve symbol
[\_PR.CPU0._CPC], AE_NOT_FOUND (20210105/psargs-330)
[    0.960197] ACPI Error: Aborting method \_PR.CPU3._CPC due to
previous error (AE_NOT_FOUND) (20210105/psparse-529)
[    0.960222] ACPI BIOS Error (bug): Could not resolve symbol
[\_PR.CPU0._CPC], AE_NOT_FOUND (20210105/psargs-330)
[    0.960224] ACPI Error: Aborting method \_PR.CPU4._CPC due to
previous error (AE_NOT_FOUND) (20210105/psparse-529)
[    0.960248] ACPI BIOS Error (bug): Could not resolve symbol
[\_PR.CPU0._CPC], AE_NOT_FOUND (20210105/psargs-330)
[    0.960250] ACPI Error: Aborting method \_PR.CPU5._CPC due to
previous error (AE_NOT_FOUND) (20210105/psparse-529)
[    0.960274] ACPI BIOS Error (bug): Could not resolve symbol
[\_PR.CPU0._CPC], AE_NOT_FOUND (20210105/psargs-330)
[    0.960276] ACPI Error: Aborting method \_PR.CPU6._CPC due to
previous error (AE_NOT_FOUND) (20210105/psparse-529)
[    0.960300] ACPI BIOS Error (bug): Could not resolve symbol
[\_PR.CPU0._CPC], AE_NOT_FOUND (20210105/psargs-330)
[    0.960302] ACPI Error: Aborting method \_PR.CPU7._CPC due to
previous error (AE_NOT_FOUND) (20210105/psparse-529)
...


and this one since 5.11 or earlier:

[    2.598268] i915 0000:00:02.0: [drm] failed to retrieve link info,
disabling eDP

box is connected via HDMI only.


regards

Ronald
