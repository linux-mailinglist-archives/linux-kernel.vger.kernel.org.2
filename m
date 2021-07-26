Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86CF03D59D4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 14:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbhGZMN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 08:13:28 -0400
Received: from mail.loongson.cn ([114.242.206.163]:42160 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234039AbhGZMN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 08:13:27 -0400
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxP0BWsP5gvhUkAA--.23344S3;
        Mon, 26 Jul 2021 20:53:42 +0800 (CST)
Subject: Re: drivers/firmware/dmi_scan.c:151:9: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
To:     kernel test robot <lkp@intel.com>
References: <202107242204.IbnaQfeL-lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jean Delvare <jdelvare@suse.com>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <81c31d99-82dc-feb6-1213-2b2fbae7c867@loongson.cn>
Date:   Mon, 26 Jul 2021 20:53:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <202107242204.IbnaQfeL-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9DxP0BWsP5gvhUkAA--.23344S3
X-Coremail-Antispam: 1UD129KBjvJXoW3GFy5AF15AryUJF13Gw4fuFg_yoWfuFW5pF
        y8GFWrtr1kJa1IyF93JF4ruayYqws2qa9xta48A3sava1UuryUtrnxWFW3Cr1jyryDt34a
        vF13tw45KFsrKF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvFb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMc
        vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkI
        ecxEwVAFwVW5JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_
        Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvj
        xUyRBTDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/24/2021 10:31 PM, kernel test robot wrote:
> Hi Stephen,
>
> First bad commit (maybe != root cause):
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   f0fddcec6b6254b4b3611388786bbafb703ad257
> commit: 1062fc45d1e93faefb93961f3be0a687f3f0e2e1 MIPS: Loongson64: Select SMP in Kconfig to avoid build error
> date:   10 months ago
> config: mips-randconfig-s031-20210724 (attached as .config)
> compiler: mips64-linux-gcc (GCC) 10.3.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # apt-get install sparse
>          # sparse version: v0.6.3-341-g8af24329-dirty
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1062fc45d1e93faefb93961f3be0a687f3f0e2e1
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout 1062fc45d1e93faefb93961f3be0a687f3f0e2e1
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=mips
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
>
> sparse warnings: (new ones prefixed by >>)
>     command-line: note: in included file:
>     builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
>     builtin:0:0: sparse: this was the original definition
>     builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
>     builtin:0:0: sparse: this was the original definition
>     builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
>     builtin:0:0: sparse: this was the original definition
>     builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
>     builtin:0:0: sparse: this was the original definition
>     drivers/firmware/dmi_scan.c:143:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [usertype] *buf @@     got void [noderef] __iomem * @@
>     drivers/firmware/dmi_scan.c:143:13: sparse:     expected unsigned char [usertype] *buf
>     drivers/firmware/dmi_scan.c:143:13: sparse:     got void [noderef] __iomem *
>>> drivers/firmware/dmi_scan.c:151:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned char [usertype] *buf @@
>     drivers/firmware/dmi_scan.c:151:9: sparse:     expected void const volatile [noderef] __iomem *addr
>     drivers/firmware/dmi_scan.c:151:9: sparse:     got unsigned char [usertype] *buf
>     drivers/firmware/dmi_scan.c:775:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [usertype] *dmi_table @@     got void [noderef] __iomem * @@
>     drivers/firmware/dmi_scan.c:775:19: sparse:     expected unsigned char [usertype] *dmi_table
>     drivers/firmware/dmi_scan.c:775:19: sparse:     got void [noderef] __iomem *
>>> drivers/firmware/dmi_scan.c:794:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned char [usertype] *dmi_table @@
>     drivers/firmware/dmi_scan.c:794:9: sparse:     expected void const volatile [noderef] __iomem *addr
>     drivers/firmware/dmi_scan.c:794:9: sparse:     got unsigned char [usertype] *dmi_table
>     drivers/firmware/dmi_scan.c:1108:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [usertype] *buf @@     got void [noderef] __iomem * @@
>     drivers/firmware/dmi_scan.c:1108:13: sparse:     expected unsigned char [usertype] *buf
>     drivers/firmware/dmi_scan.c:1108:13: sparse:     got void [noderef] __iomem *
>     drivers/firmware/dmi_scan.c:1114:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned char [usertype] *buf @@
>     drivers/firmware/dmi_scan.c:1114:9: sparse:     expected void const volatile [noderef] __iomem *addr
>     drivers/firmware/dmi_scan.c:1114:9: sparse:     got unsigned char [usertype] *buf
> --
>     command-line: note: in included file:
>     builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
>     builtin:0:0: sparse: this was the original definition
>     builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
>     builtin:0:0: sparse: this was the original definition
>     builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
>     builtin:0:0: sparse: this was the original definition
>     builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
>     builtin:0:0: sparse: this was the original definition
>>> drivers/irqchip/irq-loongson-htpic.c:80:20: sparse: sparse: symbol 'htpic_syscore_ops' was not declared. Should it be static?
>     drivers/irqchip/irq-loongson-htpic.c:84:12: sparse: sparse: symbol 'htpic_of_init' was not declared. Should it be static?
> --
>     command-line: note: in included file:
>     builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
>     builtin:0:0: sparse: this was the original definition
>     builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
>     builtin:0:0: sparse: this was the original definition
>     builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
>     builtin:0:0: sparse: this was the original definition
>     builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
>     builtin:0:0: sparse: this was the original definition
>     drivers/pci/controller/pci-ftpci100.c:37:9: sparse: sparse: preprocessor token PCI_IOSIZE redefined
>     drivers/pci/controller/pci-ftpci100.c: note: in included file (through arch/mips/include/asm/addrspace.h, arch/mips/include/asm/barrier.h, arch/mips/include/asm/bitops.h, ...):
>>> arch/mips/include/asm/mach-loongson64/spaces.h:11:9: sparse: this was the original definition
> vim +151 drivers/firmware/dmi_scan.c
>
> 7fce084a0b3e2b drivers/firmware/dmi_scan.c Jean Delvare    2007-11-03  136
> e7a19c5624c66a drivers/firmware/dmi_scan.c Jean Delvare    2009-03-30  137  static int __init dmi_walk_early(void (*decode)(const struct dmi_header *,
> e7a19c5624c66a drivers/firmware/dmi_scan.c Jean Delvare    2009-03-30  138  		void *))
> 7fce084a0b3e2b drivers/firmware/dmi_scan.c Jean Delvare    2007-11-03  139  {
> 7fce084a0b3e2b drivers/firmware/dmi_scan.c Jean Delvare    2007-11-03  140  	u8 *buf;
> 6e0ad59e3d838a drivers/firmware/dmi_scan.c Jean Delvare    2015-06-25  141  	u32 orig_dmi_len = dmi_len;
> 7fce084a0b3e2b drivers/firmware/dmi_scan.c Jean Delvare    2007-11-03  142
> 6e0ad59e3d838a drivers/firmware/dmi_scan.c Jean Delvare    2015-06-25  143  	buf = dmi_early_remap(dmi_base, orig_dmi_len);
> 7fce084a0b3e2b drivers/firmware/dmi_scan.c Jean Delvare    2007-11-03  144  	if (buf == NULL)
> c926820085437a drivers/firmware/dmi_scan.c Andy Lutomirski 2017-06-15  145  		return -ENOMEM;
> 7fce084a0b3e2b drivers/firmware/dmi_scan.c Jean Delvare    2007-11-03  146
> eb4c5ea50e60aa drivers/firmware/dmi_scan.c Ivan Khoronzhuk 2015-06-25  147  	dmi_decode_table(buf, decode, NULL);
> 7fce084a0b3e2b drivers/firmware/dmi_scan.c Jean Delvare    2007-11-03  148
> d114a333874725 drivers/firmware/dmi_scan.c Tony Luck       2012-07-20  149  	add_device_randomness(buf, dmi_len);
> d114a333874725 drivers/firmware/dmi_scan.c Tony Luck       2012-07-20  150
> 6e0ad59e3d838a drivers/firmware/dmi_scan.c Jean Delvare    2015-06-25 @151  	dmi_early_unmap(buf, orig_dmi_len);
> ^1da177e4c3f41 arch/i386/kernel/dmi_scan.c Linus Torvalds  2005-04-16  152  	return 0;
> ^1da177e4c3f41 arch/i386/kernel/dmi_scan.c Linus Torvalds  2005-04-16  153  }
> ^1da177e4c3f41 arch/i386/kernel/dmi_scan.c Linus Torvalds  2005-04-16  154
>
> :::::: The code at line 151 was first introduced by commit
> :::::: 6e0ad59e3d838a2887e7aa657baee5896030d009 firmware: dmi_scan: Trim DMI table length before exporting it
>
> :::::: TO: Jean Delvare <jdelvare@suse.de>
> :::::: CC: Jean Delvare <jdelvare@suse.de>
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Hi,

It seems that there is no relation between my commit and the sparse warning
"drivers/firmware/dmi_scan.c:151:9: sparse: sparse: incorrect type in 
argument".

I think the following change can make the above warning silent:

diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
index f191a1f..9e254d9 100644
--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -148,7 +148,7 @@ static int __init dmi_walk_early(void 
(*decode)(const struct dmi_header *,

         add_device_randomness(buf, dmi_len);

-       dmi_early_unmap(buf, orig_dmi_len);
+       dmi_early_unmap((u8 __iomem *)buf, orig_dmi_len);
         return 0;
  }

If it is OK, I can send a patch later.

Thanks,
Tiezhu

