Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2443DA6C1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 16:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237499AbhG2OrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 10:47:09 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33714 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237896AbhG2Opv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 10:45:51 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 62B2E223F5;
        Thu, 29 Jul 2021 14:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627569936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bGzrCEZ3gzxh1c4S1CYTs/FywXEyxc1cV/S7cox9Goc=;
        b=w0jE6T+y7oziHIRH7lWA5FraENqlsRkQgciw4gjwCnCDlKS87VPGYFuBu441Q1QtT4g27Z
        eeomsnJr0/n5w2C/EJSvz0X67J2EOJAL7N+BUuYY1K0KRIO63/NFJ7NEjfW8Bm93txVRwq
        FDQ1F39Tawh2UT3V+UGS2ndrGqerJuc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627569936;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bGzrCEZ3gzxh1c4S1CYTs/FywXEyxc1cV/S7cox9Goc=;
        b=j8u1Y6Nv47aUEt8Ca66ErCygqSL3h0VUxPUgsAaQcpWepOvf/6dErHjr8SNHPv8ozhqJEQ
        XzvvEuqtK7a4kBAw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1AA5513690;
        Thu, 29 Jul 2021 14:45:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 3xEZBBC/AmFOIQAAGKfGzw
        (envelope-from <jdelvare@suse.de>); Thu, 29 Jul 2021 14:45:36 +0000
Date:   Thu, 29 Jul 2021 16:45:33 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: drivers/firmware/dmi_scan.c:151:9: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <20210729164533.48fed217@endymion>
In-Reply-To: <81c31d99-82dc-feb6-1213-2b2fbae7c867@loongson.cn>
References: <202107242204.IbnaQfeL-lkp@intel.com>
        <81c31d99-82dc-feb6-1213-2b2fbae7c867@loongson.cn>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tiezhu,

On Mon, 26 Jul 2021 20:53:42 +0800, Tiezhu Yang wrote:
> On 07/24/2021 10:31 PM, kernel test robot wrote:
> > Hi Stephen,
> >
> > First bad commit (maybe != root cause):
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   f0fddcec6b6254b4b3611388786bbafb703ad257
> > commit: 1062fc45d1e93faefb93961f3be0a687f3f0e2e1 MIPS: Loongson64: Select SMP in Kconfig to avoid build error
> > date:   10 months ago
> > config: mips-randconfig-s031-20210724 (attached as .config)
> > compiler: mips64-linux-gcc (GCC) 10.3.0
> > reproduce:
> >          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >          chmod +x ~/bin/make.cross
> >          # apt-get install sparse
> >          # sparse version: v0.6.3-341-g8af24329-dirty
> >          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1062fc45d1e93faefb93961f3be0a687f3f0e2e1
> >          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >          git fetch --no-tags linus master
> >          git checkout 1062fc45d1e93faefb93961f3be0a687f3f0e2e1
> >          # save the attached .config to linux build tree
> >          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=mips
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> >
> > sparse warnings: (new ones prefixed by >>)
> >     command-line: note: in included file:
> >     builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
> >     builtin:0:0: sparse: this was the original definition
> >     builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
> >     builtin:0:0: sparse: this was the original definition
> >     builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
> >     builtin:0:0: sparse: this was the original definition
> >     builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
> >     builtin:0:0: sparse: this was the original definition
> >     drivers/firmware/dmi_scan.c:143:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [usertype] *buf @@     got void [noderef] __iomem * @@
> >     drivers/firmware/dmi_scan.c:143:13: sparse:     expected unsigned char [usertype] *buf
> >     drivers/firmware/dmi_scan.c:143:13: sparse:     got void [noderef] __iomem *  
> >>> drivers/firmware/dmi_scan.c:151:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned char [usertype] *buf @@  
> >     drivers/firmware/dmi_scan.c:151:9: sparse:     expected void const volatile [noderef] __iomem *addr
> >     drivers/firmware/dmi_scan.c:151:9: sparse:     got unsigned char [usertype] *buf
> >     drivers/firmware/dmi_scan.c:775:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [usertype] *dmi_table @@     got void [noderef] __iomem * @@
> >     drivers/firmware/dmi_scan.c:775:19: sparse:     expected unsigned char [usertype] *dmi_table
> >     drivers/firmware/dmi_scan.c:775:19: sparse:     got void [noderef] __iomem *  
> >>> drivers/firmware/dmi_scan.c:794:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned char [usertype] *dmi_table @@  
> >     drivers/firmware/dmi_scan.c:794:9: sparse:     expected void const volatile [noderef] __iomem *addr
> >     drivers/firmware/dmi_scan.c:794:9: sparse:     got unsigned char [usertype] *dmi_table
> >     drivers/firmware/dmi_scan.c:1108:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [usertype] *buf @@     got void [noderef] __iomem * @@
> >     drivers/firmware/dmi_scan.c:1108:13: sparse:     expected unsigned char [usertype] *buf
> >     drivers/firmware/dmi_scan.c:1108:13: sparse:     got void [noderef] __iomem *
> >     drivers/firmware/dmi_scan.c:1114:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned char [usertype] *buf @@
> >     drivers/firmware/dmi_scan.c:1114:9: sparse:     expected void const volatile [noderef] __iomem *addr
> >     drivers/firmware/dmi_scan.c:1114:9: sparse:     got unsigned char [usertype] *buf
> > --
> >     command-line: note: in included file:
> >     builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
> >     builtin:0:0: sparse: this was the original definition
> >     builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
> >     builtin:0:0: sparse: this was the original definition
> >     builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
> >     builtin:0:0: sparse: this was the original definition
> >     builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
> >     builtin:0:0: sparse: this was the original definition  
> >>> drivers/irqchip/irq-loongson-htpic.c:80:20: sparse: sparse: symbol 'htpic_syscore_ops' was not declared. Should it be static?  
> >     drivers/irqchip/irq-loongson-htpic.c:84:12: sparse: sparse: symbol 'htpic_of_init' was not declared. Should it be static?
> > --
> >     command-line: note: in included file:
> >     builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
> >     builtin:0:0: sparse: this was the original definition
> >     builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
> >     builtin:0:0: sparse: this was the original definition
> >     builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
> >     builtin:0:0: sparse: this was the original definition
> >     builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
> >     builtin:0:0: sparse: this was the original definition
> >     drivers/pci/controller/pci-ftpci100.c:37:9: sparse: sparse: preprocessor token PCI_IOSIZE redefined
> >     drivers/pci/controller/pci-ftpci100.c: note: in included file (through arch/mips/include/asm/addrspace.h, arch/mips/include/asm/barrier.h, arch/mips/include/asm/bitops.h, ...):  
> >>> arch/mips/include/asm/mach-loongson64/spaces.h:11:9: sparse: this was the original definition  
> > vim +151 drivers/firmware/dmi_scan.c
> >
> > 7fce084a0b3e2b drivers/firmware/dmi_scan.c Jean Delvare    2007-11-03  136
> > e7a19c5624c66a drivers/firmware/dmi_scan.c Jean Delvare    2009-03-30  137  static int __init dmi_walk_early(void (*decode)(const struct dmi_header *,
> > e7a19c5624c66a drivers/firmware/dmi_scan.c Jean Delvare    2009-03-30  138  		void *))
> > 7fce084a0b3e2b drivers/firmware/dmi_scan.c Jean Delvare    2007-11-03  139  {
> > 7fce084a0b3e2b drivers/firmware/dmi_scan.c Jean Delvare    2007-11-03  140  	u8 *buf;
> > 6e0ad59e3d838a drivers/firmware/dmi_scan.c Jean Delvare    2015-06-25  141  	u32 orig_dmi_len = dmi_len;
> > 7fce084a0b3e2b drivers/firmware/dmi_scan.c Jean Delvare    2007-11-03  142
> > 6e0ad59e3d838a drivers/firmware/dmi_scan.c Jean Delvare    2015-06-25  143  	buf = dmi_early_remap(dmi_base, orig_dmi_len);
> > 7fce084a0b3e2b drivers/firmware/dmi_scan.c Jean Delvare    2007-11-03  144  	if (buf == NULL)
> > c926820085437a drivers/firmware/dmi_scan.c Andy Lutomirski 2017-06-15  145  		return -ENOMEM;
> > 7fce084a0b3e2b drivers/firmware/dmi_scan.c Jean Delvare    2007-11-03  146
> > eb4c5ea50e60aa drivers/firmware/dmi_scan.c Ivan Khoronzhuk 2015-06-25  147  	dmi_decode_table(buf, decode, NULL);
> > 7fce084a0b3e2b drivers/firmware/dmi_scan.c Jean Delvare    2007-11-03  148
> > d114a333874725 drivers/firmware/dmi_scan.c Tony Luck       2012-07-20  149  	add_device_randomness(buf, dmi_len);
> > d114a333874725 drivers/firmware/dmi_scan.c Tony Luck       2012-07-20  150
> > 6e0ad59e3d838a drivers/firmware/dmi_scan.c Jean Delvare    2015-06-25 @151  	dmi_early_unmap(buf, orig_dmi_len);
> > ^1da177e4c3f41 arch/i386/kernel/dmi_scan.c Linus Torvalds  2005-04-16  152  	return 0;
> > ^1da177e4c3f41 arch/i386/kernel/dmi_scan.c Linus Torvalds  2005-04-16  153  }
> > ^1da177e4c3f41 arch/i386/kernel/dmi_scan.c Linus Torvalds  2005-04-16  154
> >
> > :::::: The code at line 151 was first introduced by commit
> > :::::: 6e0ad59e3d838a2887e7aa657baee5896030d009 firmware: dmi_scan: Trim DMI table length before exporting it
> >
> > :::::: TO: Jean Delvare <jdelvare@suse.de>
> > :::::: CC: Jean Delvare <jdelvare@suse.de>
> >
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org  
> 
> Hi,
> 
> It seems that there is no relation between my commit and the sparse warning
> "drivers/firmware/dmi_scan.c:151:9: sparse: sparse: incorrect type in 
> argument".

Agreed. However there are two other sparse warnings in the report:

>>> drivers/irqchip/irq-loongson-htpic.c:80:20: sparse: sparse: symbol 'htpic_syscore_ops' was not declared. Should it be static?  

>     drivers/pci/controller/pci-ftpci100.c:37:9: sparse: sparse: preprocessor token PCI_IOSIZE redefined
>     drivers/pci/controller/pci-ftpci100.c: note: in included file (through arch/mips/include/asm/addrspace.h, arch/mips/include/asm/barrier.h, arch/mips/include/asm/bitops.h, ...):  
>>> arch/mips/include/asm/mach-loongson64/spaces.h:11:9: sparse: this was the original definition  

They are the ones that would have been uncovered by your change. The
dmi_scan one must have existed before already.

> I think the following change can make the above warning silent:
> 
> diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
> index f191a1f..9e254d9 100644
> --- a/drivers/firmware/dmi_scan.c
> +++ b/drivers/firmware/dmi_scan.c
> @@ -148,7 +148,7 @@ static int __init dmi_walk_early(void 
> (*decode)(const struct dmi_header *,
> 
>          add_device_randomness(buf, dmi_len);
> 
> -       dmi_early_unmap(buf, orig_dmi_len);
> +       dmi_early_unmap((u8 __iomem *)buf, orig_dmi_len);
>          return 0;
>   }
> 
> If it is OK, I can send a patch later.

Explicit pointer casting is almost always the wrong way to make
warnings go away. I can't confirm because I'm not able to get sparse to
work at the moment, but more likely the correct fix would be something
along the lines of:

--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -137,7 +137,7 @@ static phys_addr_t dmi_base;
 static int __init dmi_walk_early(void (*decode)(const struct dmi_header *,
 		void *))
 {
-	u8 *buf;
+	u8 __iomem *buf;
 	u32 orig_dmi_len = dmi_len;
 
 	buf = dmi_early_remap(dmi_base, orig_dmi_len);
@@ -754,7 +754,7 @@ static BIN_ATTR(DMI, S_IRUSR, raw_table_
 static int __init dmi_init(void)
 {
 	struct kobject *tables_kobj;
-	u8 *dmi_table;
+	u8 __iomem *dmi_table;
 	int ret = -ENOMEM;
 
 	if (!dmi_available)
@@ -1101,7 +1101,7 @@ EXPORT_SYMBOL(dmi_get_bios_year);
 int dmi_walk(void (*decode)(const struct dmi_header *, void *),
 	     void *private_data)
 {
-	u8 *buf;
+	u8 __iomem *buf;
 
 	if (!dmi_available)
 		return -ENXIO;

(Note sure why there are only 2 sparse warnings when the same issue is
present 3 times in the file.)

-- 
Jean Delvare
SUSE L3 Support
