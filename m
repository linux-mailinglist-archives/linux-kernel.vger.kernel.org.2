Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84C234BF25
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 23:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhC1VC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 17:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbhC1VCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 17:02:16 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FD5C061756
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 14:02:16 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id i126so5411234vsi.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 14:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0X3Y43CEtr0v6BsOhafWc5Da60XGW9r/SwuYHfpMHP0=;
        b=ke5XdSieHCkw6Wj98XTBYMMQFiN89wcVfL5QHg/+nSfxmdF+O7bRNBka+oFYS+xqPi
         zDPESBRFmnGWAkV5zUtw7iIHwHj0rEA7Ape8Drg1AJby6w0pjHQiJwErxH8onIWaJH1I
         IEmtmet0fC771hC0jvf7/TR7W11EKESN3aa0/8kVXKi1/L/DaZN5Fz99ZYvftuj3t2Id
         LfafciHH4Vc0gf4Q+vG3CAaaLankTu85iXXT6KAnK5QeppM4YVvmehddVT7kNga61Ouo
         SAHZ8oaw+FrMDtgaUKF61Xzm5HXYwYeeC54ht1hM4dBUAL1wCdny5jy83UjWRXQ6H317
         szgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0X3Y43CEtr0v6BsOhafWc5Da60XGW9r/SwuYHfpMHP0=;
        b=lzg0G1EMq1heE9neJr60uP5+EjxrwQ9Ggg+ojYkKjG5aHMgjC8l2vnkrQ846s71HRw
         gJ3FddspNgKHHumQ2LLD5975m097UtMbMpy2JvmDpQShXomV8g9XhLp41fxNAinE1f+v
         uOcTfUzvz5KoFDzRRB21Pz27hTMHNv5tF+JGvwNsN3a3h1So4bCVE+gQa/JQE9Oy1wpO
         niVeOIO2DlSHes+rIEp6SAz9RUosVquObLhGNNt4ZsdB+2mAT0vr5P+dCcDqaWFTkKgB
         AzgKCXKU0Hmx2pDU89eO4ETk1ZGK3T94Xa/OCFzoiquebLJV3bHJWW67wYw/DDPULhw7
         MTuw==
X-Gm-Message-State: AOAM5321hTFRL78J2QKNq49Nh+HkMjuJWMq4+rw3bMGlsa4GhfUJObl5
        BSfG/BcXz9wnsGfWl+mpXWpKIQ/eYzNV3ufX0uM=
X-Google-Smtp-Source: ABdhPJyAvAafBiEu2AN4dGw4t6spSgT/gqf/ZX3QaPPki2W2Ar5n49xzcH+C5YDRU7tpHuXdasWh3PMNskVVidRZTXs=
X-Received: by 2002:a05:6102:b05:: with SMTP id b5mr13060449vst.29.1616965335245;
 Sun, 28 Mar 2021 14:02:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAGgoGu77PEEAJped5bnw4q8rFeDMebL92YWGDGFfNp_ZAnpJ8Q@mail.gmail.com>
 <CAHp75VdT9XeOgY3Tt+wo5bSRh-qdTfcaHFf7uuXotL1FqqF_mA@mail.gmail.com>
In-Reply-To: <CAHp75VdT9XeOgY3Tt+wo5bSRh-qdTfcaHFf7uuXotL1FqqF_mA@mail.gmail.com>
From:   Fawad Lateef <fawadlateef@gmail.com>
Date:   Sun, 28 Mar 2021 23:02:03 +0200
Message-ID: <CAGgoGu6by5VosFWgeys8Mt7+t-s6DgOw_OL=x3ivpAPsK7JzOQ@mail.gmail.com>
Subject: Re: Compiling kernel-3.4.xxx with gcc-9.x. Need some help.
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     kernelnewbies <kernelnewbies@kernelnewbies.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Mar 2021 at 22:49, Andy Shevchenko <andy.shevchenko@gmail.com> w=
rote:
>
>
>
> On Sunday, March 28, 2021, Fawad Lateef <fawadlateef@gmail.com> wrote:
>>
>> Hi
>>
>> I am using an Olimex A20 SOM with NAND and due to some binary blob for
>> NAND driver, I am stuck with the sunxi kernel 3.4.xxx version. (Repo
>> here: https://github.com/linux-sunxi/linux-sunxi)
>>
>> I am currently using buildroot-2016 and gcc-5.5 for building the
>> kernel and every other package needed.
>>
>> Now the requirement is to move to the latest version of gcc-9.x, so
>> that we can have glibc++ provided by the gcc-9.1 toolchain.
>>
>> Main problem for moving to later versions of buildroot is the kernel
>> 3.4 which we couldn't to work with gcc-6 a few years ago _but_ now the
>> gcc-9.1 requirement is mandatory so now have to look into compiling
>> linux-3.4 with gcc-9.1 or above.
>>
>> Now I need some help.
>>
>> -- Is it realistic to expect 3.4 kernel compiling and boot
>> successfully with gcc-9.1?
>
>
> Pretty much, but i=E2=80=99m not sure the patches will be acceptable by u=
pstream / stable.

Upstream patch is not really a concern as we are already running a
non-upstream kernel from sunxi.

>
>>
>> -- Secondly, till now I am able to compile until the point when its
>> going to generate the vmlinuz image, it failed with error at LD stage:
>>                   arm-none-linux-gnueabihf-ld: no machine record defined
>>
>> Last few lines from compile log:
>>
>> ------------------------------------------------------------------------=
-------
>> include/linux/init.h:267:24: note: in expansion of macro =E2=80=98__init=
call=E2=80=99
>>   267 | #define module_init(x) __initcall(x);
>>       |                        ^~~~~~~~~~
>> net/sunrpc/auth_gss/auth_gss.c:1721:1: note: in expansion of macro =E2=
=80=98module_init=E2=80=99
>>  1721 | module_init(init_rpcsec_gss)
>>       | ^~~~~~~~~~~
>> In file included from include/linux/kernel.h:20,
>>                  from include/linux/spinlock.h:55,
>>                  from include/linux/mmzone.h:7,
>>                  from include/linux/gfp.h:4,
>>                  from include/linux/slab.h:12,
>>                  from net/sunrpc/auth_gss/svcauth_gss.c:40:
>> include/linux/log2.h:22:1: warning: ignoring attribute =E2=80=98noreturn=
=E2=80=99
>> because it conflicts with attribute =E2=80=98const=E2=80=99 [-Wattribute=
s]
>>    22 | int ____ilog2_NaN(void);
>>       | ^~~
>>   LD      net/sunrpc/auth_gss/auth_rpcgss.o
>>   LD      net/sunrpc/auth_gss/built-in.o
>>   LD      net/sunrpc/built-in.o
>>   LD      net/built-in.o
>>   LD      vmlinux.o
>>   MODPOST vmlinux.o
>>   GEN     .version
>>   CHK     include/generated/compile.h
>>   UPD     include/generated/compile.h
>>   CC      init/version.o
>> In file included from include/linux/kernel.h:20,
>>                  from include/linux/cache.h:4,
>>                  from include/linux/time.h:7,
>>                  from include/linux/stat.h:60,
>>                  from include/linux/module.h:10,
>>                  from init/version.c:10:
>> include/linux/log2.h:22:1: warning: ignoring attribute =E2=80=98noreturn=
=E2=80=99
>> because it conflicts with attribute =E2=80=98const=E2=80=99 [-Wattribute=
s]
>>    22 | int ____ilog2_NaN(void);
>>       | ^~~
>>   LD      init/built-in.o
>>   LD      .tmp_vmlinux1
>> arm-none-linux-gnueabihf-ld: no machine record defined
>> Makefile:875: recipe for target '.tmp_vmlinux1' failed
>> make: *** [.tmp_vmlinux1] Error 1
>> ------------------------------------------------------------------------=
-------
>>
>>
>> After some investigation I found that the MACHINE_START macro from
>> arch/arm/include/asm/mach/arch.h  is optimised by compiler and removed
>> from the object file during compilation of
>> "arch/arm/plat-sunxi/core.c" due to the error here:
>>
>> ---------------------------------------------------------------
>>
>> flateef@flateef-XPS-13-9360:~/src/tmp/linux-custom-venus-gc-9.2$ make
>> ARCH=3Darm CROSS_COMPILE=3Darm-none-linux-gnueabihf- EXTRAVERSION=3D-cus=
tom1
>> uImage LOADADDR=3D"0x40008000" -j4
>>   CHK     include/linux/version.h
>>   CHK     include/generated/utsrelease.h
>> make[1]: 'include/generated/mach-types.h' is up to date.
>>   CALL    scripts/checksyscalls.sh
>>   CHK     include/generated/compile.h
>>   CC      arch/arm/plat-sunxi/core.o
>> In file included from include/linux/kernel.h:20,
>>                  from arch/arm/plat-sunxi/core.c:20:
>> include/linux/log2.h:22:1: warning: ignoring attribute =E2=80=98noreturn=
=E2=80=99
>> because it conflicts with attribute =E2=80=98const=E2=80=99 [-Wattribute=
s]
>>    22 | int ____ilog2_NaN(void);
>>       | ^~~
>> In file included from include/linux/scatterlist.h:10,
>>                  from include/linux/dma-mapping.h:9,
>>                  from arch/arm/plat-sunxi/core.c:24:
>> arch/arm/plat-sunxi/core.c: In function =E2=80=98sw_irq_unmask=E2=80=99:
>> arch/arm/plat-sunxi/core.c:287:14: warning: left shift count >=3D width
>> of type [-Wshift-count-overflow]
>>   287 |    writel((1 << SW_INT_IRQNO_ENMI), SW_INT_IRQ_PENDING_REG0);
>>       |              ^~
>> /home/flateef/src/tmp/linux-custom-venus-gc-9.2/arch/arm/include/asm/io.=
h:52:88:
>> note: in definition of macro =E2=80=98__raw_writel=E2=80=99
>>    52 | #define __raw_writel(v,a) (__chk_io_ptr(a), *(volatile
>> unsigned int __force   *)(a) =3D (v))
>>       |
>>                         ^
>> include/linux/byteorder/generic.h:87:21: note: in expansion of macro
>> =E2=80=98__cpu_to_le32=E2=80=99
>>    87 | #define cpu_to_le32 __cpu_to_le32
>>       |                     ^~~~~~~~~~~~~
>> /home/flateef/src/tmp/linux-custom-venus-gc-9.2/arch/arm/include/asm/io.=
h:244:36:
>> note: in expansion of macro =E2=80=98writel_relaxed=E2=80=99
>>   244 | #define writel(v,c)  ({ __iowmb(); writel_relaxed(v,c); })
>>       |                                    ^~~~~~~~~~~~~~
>> arch/arm/plat-sunxi/core.c:287:4: note: in expansion of macro =E2=80=98w=
ritel=E2=80=99
>>   287 |    writel((1 << SW_INT_IRQNO_ENMI), SW_INT_IRQ_PENDING_REG0);
>>       |    ^~~~~~
>> In file included from arch/arm/plat-sunxi/core.c:53:
>> At top level:
>> /home/flateef/src/tmp/linux-custom-venus-gc-9.2/arch/arm/include/asm/mac=
h/arch.h:69:34:
>> warning: =E2=80=98__mach_desc_SUN7I=E2=80=99 defined but not used
>> [-Wunused-const-variable=3D]
>>    69 | static const struct machine_desc __mach_desc_##_type  \
>>       |                                  ^~~~~~~~~~~~
>> arch/arm/plat-sunxi/core.c:424:1: note: in expansion of macro =E2=80=98M=
ACHINE_START=E2=80=99
>>   424 | MACHINE_START(SUN7I, "sun7i")
>>       | ^~~~~~~~~~~~~
>> /home/flateef/src/tmp/linux-custom-venus-gc-9.2/arch/arm/include/asm/mac=
h/arch.h:69:34:
>> warning: =E2=80=98__mach_desc_SUN5I=E2=80=99 defined but not used
>> [-Wunused-const-variable=3D]
>>    69 | static const struct machine_desc __mach_desc_##_type  \
>>       |                                  ^~~~~~~~~~~~
>> arch/arm/plat-sunxi/core.c:410:1: note: in expansion of macro =E2=80=98M=
ACHINE_START=E2=80=99
>>   410 | MACHINE_START(SUN5I, "sun5i")
>>       | ^~~~~~~~~~~~~
>> /home/flateef/src/tmp/linux-custom-venus-gc-9.2/arch/arm/include/asm/mac=
h/arch.h:69:34:
>> warning: =E2=80=98__mach_desc_SUN4I=E2=80=99 defined but not used
>> [-Wunused-const-variable=3D]
>>    69 | static const struct machine_desc __mach_desc_##_type  \
>>       |                                  ^~~~~~~~~~~~
>> arch/arm/plat-sunxi/core.c:396:1: note: in expansion of macro =E2=80=98M=
ACHINE_START=E2=80=99
>>   396 | MACHINE_START(SUN4I, "sun4i")
>>       | ^~~~~~~~~~~~~
>>   LD      arch/arm/plat-sunxi/built-in.o
>>   LD      vmlinux.o
>>   MODPOST vmlinux.o
>>   GEN     .version
>>   CHK     include/generated/compile.h
>>   UPD     include/generated/compile.h
>>   CC      init/version.o
>> In file included from include/linux/kernel.h:20,
>>                  from include/linux/cache.h:4,
>>                  from include/linux/time.h:7,
>>                  from include/linux/stat.h:60,
>>                  from include/linux/module.h:10,
>>                  from init/version.c:10:
>> include/linux/log2.h:22:1: warning: ignoring attribute =E2=80=98noreturn=
=E2=80=99
>> because it conflicts with attribute =E2=80=98const=E2=80=99 [-Wattribute=
s]
>>    22 | int ____ilog2_NaN(void);
>>       | ^~~
>>   LD      init/built-in.o
>>   LD      .tmp_vmlinux1
>> arm-none-linux-gnueabihf-ld: no machine record defined
>> Makefile:875: recipe for target '.tmp_vmlinux1' failed
>> make: *** [.tmp_vmlinux1] Error 1
>>
>> ---------------------------------------------------------------
>>
>> I modified the MACHINE_START macro in arch/arm/include/asm/mach/arch.h
>> and added "__attribute__((used))" so it became:
>>
>>             static const struct machine_desc __mach_desc_##_type
>> __attribute__((used))    \
>>
>> And I managed to get the vmlinux image.
>>
>> -------------------------------------------------------------
>>
>>
>> arch/arm/mm/mmu.c:919:1: note: in expansion of macro =E2=80=98early_para=
m=E2=80=99
>>   919 | early_param("vmalloc", early_vmalloc);
>>       | ^~~~~~~~~~~
>> include/linux/init.h:241:33: warning: =E2=80=98__setup_noalign_setup=E2=
=80=99 defined
>> but not used [-Wunused-variable]
>>   241 |  static struct obs_kernel_param __setup_##unique_id \
>>       |                                 ^~~~~~~~
>> include/linux/init.h:247:2: note: in expansion of macro =E2=80=98__setup=
_param=E2=80=99
>>   247 |  __setup_param(str, fn, fn, 0)
>>       |  ^~~~~~~~~~~~~
>> arch/arm/mm/mmu.c:175:1: note: in expansion of macro =E2=80=98__setup=E2=
=80=99
>>   175 | __setup("noalign", noalign_setup);
>>       | ^~~~~~~
>> include/linux/init.h:241:33: warning: =E2=80=98__setup_early_ecc=E2=80=
=99 defined but
>> not used [-Wunused-variable]
>>   241 |  static struct obs_kernel_param __setup_##unique_id \
>>       |                                 ^~~~~~~~
>> include/linux/init.h:252:2: note: in expansion of macro =E2=80=98__setup=
_param=E2=80=99
>>   252 |  __setup_param(str, fn, fn, 1)
>>       |  ^~~~~~~~~~~~~
>> arch/arm/mm/mmu.c:165:1: note: in expansion of macro =E2=80=98early_para=
m=E2=80=99
>>   165 | early_param("ecc", early_ecc);
>>       | ^~~~~~~~~~~
>> include/linux/init.h:241:33: warning: =E2=80=98__setup_early_nowrite=E2=
=80=99 defined
>> but not used [-Wunused-variable]
>>   241 |  static struct obs_kernel_param __setup_##unique_id \
>>       |                                 ^~~~~~~~
>> include/linux/init.h:252:2: note: in expansion of macro =E2=80=98__setup=
_param=E2=80=99
>>   252 |  __setup_param(str, fn, fn, 1)
>>       |  ^~~~~~~~~~~~~
>> arch/arm/mm/mmu.c:154:1: note: in expansion of macro =E2=80=98early_para=
m=E2=80=99
>>   154 | early_param("nowb", early_nowrite);
>>       | ^~~~~~~~~~~
>> include/linux/init.h:241:33: warning: =E2=80=98__setup_early_nocache=E2=
=80=99 defined
>> but not used [-Wunused-variable]
>>   241 |  static struct obs_kernel_param __setup_##unique_id \
>>       |                                 ^~~~~~~~
>> include/linux/init.h:252:2: note: in expansion of macro =E2=80=98__setup=
_param=E2=80=99
>>   252 |  __setup_param(str, fn, fn, 1)
>>       |  ^~~~~~~~~~~~~
>> arch/arm/mm/mmu.c:145:1: note: in expansion of macro =E2=80=98early_para=
m=E2=80=99
>>   145 | early_param("nocache", early_nocache);
>>       | ^~~~~~~~~~~
>> include/linux/init.h:241:33: warning: =E2=80=98__setup_early_cachepolicy=
=E2=80=99
>> defined but not used [-Wunused-variable]
>>   241 |  static struct obs_kernel_param __setup_##unique_id \
>>       |                                 ^~~~~~~~
>> include/linux/init.h:252:2: note: in expansion of macro =E2=80=98__setup=
_param=E2=80=99
>>   252 |  __setup_param(str, fn, fn, 1)
>>       |  ^~~~~~~~~~~~~
>> arch/arm/mm/mmu.c:136:1: note: in expansion of macro =E2=80=98early_para=
m=E2=80=99
>>   136 | early_param("cachepolicy", early_cachepolicy);
>>       | ^~~~~~~~~~~
>>   AS      arch/arm/kernel/head.o
>>   LD      arch/arm/kernel/built-in.o
>>   AS      arch/arm/mm/cache-v7.o
>>   AS      arch/arm/mm/tlb-v7.o
>>   AS      arch/arm/mm/proc-v7.o
>>   LD      arch/arm/mm/built-in.o
>>   AS      arch/arm/lib/copy_page.o
>>   AS      arch/arm/lib/csumpartialcopyuser.o
>>   AR      arch/arm/lib/lib.a
>>   LD      vmlinux.o
>>   MODPOST vmlinux.o
>>   GEN     .version
>>   CHK     include/generated/compile.h
>>   UPD     include/generated/compile.h
>>   CC      init/version.o
>> In file included from include/linux/kernel.h:20,
>>                  from include/linux/cache.h:4,
>>                  from include/linux/time.h:7,
>>                  from include/linux/stat.h:60,
>>                  from include/linux/module.h:10,
>>                  from init/version.c:10:
>> include/linux/log2.h:22:1: warning: ignoring attribute =E2=80=98noreturn=
=E2=80=99
>> because it conflicts with attribute =E2=80=98const=E2=80=99 [-Wattribute=
s]
>>    22 | int ____ilog2_NaN(void);
>>       | ^~~
>>   LD      init/built-in.o
>>   LD      .tmp_vmlinux1
>>   KSYM    .tmp_kallsyms1.S
>>   AS      .tmp_kallsyms1.o
>>   LD      .tmp_vmlinux2
>>   KSYM    .tmp_kallsyms2.S
>>   AS      .tmp_kallsyms2.o
>>   LD      vmlinux
>>   SYSMAP  System.map
>>   SYSMAP  .tmp_System.map
>>   OBJCOPY arch/arm/boot/Image
>>   Kernel: arch/arm/boot/Image is ready
>>   AS      arch/arm/boot/compressed/head.o
>>   XZKERN  arch/arm/boot/compressed/piggy.xzkern
>>   CC      arch/arm/boot/compressed/misc.o
>>   CC      arch/arm/boot/compressed/decompress.o
>>   CC      arch/arm/boot/compressed/string.o
>> In file included from include/linux/kernel.h:20,
>>                  from
>> arch/arm/boot/compressed/../../../../lib/xz/xz_private.h:15,
>>                  from
>> arch/arm/boot/compressed/../../../../lib/decompress_unxz.c:145,
>>                  from arch/arm/boot/compressed/decompress.c:50:
>> include/linux/log2.h:22:1: warning: ignoring attribute =E2=80=98noreturn=
=E2=80=99
>> because it conflicts with attribute =E2=80=98const=E2=80=99 [-Wattribute=
s]
>>    22 | int ____ilog2_NaN(void);
>>       | ^~~
>>   SHIPPED arch/arm/boot/compressed/lib1funcs.S
>>   SHIPPED arch/arm/boot/compressed/ashldi3.S
>>   AS      arch/arm/boot/compressed/lib1funcs.o
>>   AS      arch/arm/boot/compressed/ashldi3.o
>>   AS      arch/arm/boot/compressed/piggy.xzkern.o
>>   LD      arch/arm/boot/compressed/vmlinux
>>   OBJCOPY arch/arm/boot/zImage
>>   Kernel: arch/arm/boot/zImage is ready
>>   UIMAGE  arch/arm/boot/uImage
>> Image Name:   Linux-3.4.113-custom1
>> Created:      Sun Mar 28 20:27:03 2021
>> Image Type:   ARM Linux Kernel Image (uncompressed)
>> Data Size:    1869496 Bytes =3D 1825.68 KiB =3D 1.78 MiB
>> Load Address: 40008000
>> Entry Point:  40008000
>>   Image arch/arm/boot/uImage is ready
>>
>>
>> ------------------------------------------------------------------------=
-----
>>
>>
>> -- I still can't boot the kernel on the platform. I believe its
>> because there were lots of warning like above (unused const variables
>> etc) and might have removed some other code/functions OR macros?
>>
>> So please suggest what I can do for compiling working kernel-3.4 with gc=
c-9.
>
>
> Is it possible to switch to new kernel, like v4.4 or even newer?

As mentioned above, not possible. The mainline kernel doesn't support
the NAND chip/driver due to some binary blobs. So pretty much only
option for us is to stick with SUNXI provided 3.4.xxx kernel version.
(Mainline kernel supports Sunxi-A20 SOM from Olimex but only the eMMC
version _not_ NAND).

>
>>
>>
>> Thanks in advance,
>>
>> -- Fawad Lateef
>
>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
