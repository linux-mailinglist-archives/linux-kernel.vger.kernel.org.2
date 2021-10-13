Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2904342C693
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 18:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbhJMQod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 12:44:33 -0400
Received: from mga18.intel.com ([134.134.136.126]:6927 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229946AbhJMQo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 12:44:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="214416429"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="gz'50?scan'50,208,50";a="214416429"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 09:42:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="gz'50?scan'50,208,50";a="480877986"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 13 Oct 2021 09:42:23 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mahKh-0004pe-70; Wed, 13 Oct 2021 16:42:23 +0000
Date:   Thu, 14 Oct 2021 00:42:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [mcgrof:modules-next 1/1] include/linux/kern_levels.h:5:18: warning:
 format '%llu' expects argument of type 'long long unsigned int', but
 argument 3 has type 'Elf32_Off' {aka 'unsigned int'}
Message-ID: <202110140056.Fb6aizTM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git modules-next
head:   8b1185a4427b772b9f02376a08272c3019777581
commit: 8b1185a4427b772b9f02376a08272c3019777581 [1/1] module: change to print useful messages from elf_validity_check()
config: um-i386_defconfig (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/commit/?id=8b1185a4427b772b9f02376a08272c3019777581
        git remote add mcgrof https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git
        git fetch --no-tags mcgrof modules-next
        git checkout 8b1185a4427b772b9f02376a08272c3019777581
        # save the attached .config to linux build tree
        make W=1 ARCH=um SUBARCH=i386

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:19,
                    from include/linux/list.h:9,
                    from include/linux/module.h:12,
                    from include/linux/moduleloader.h:6,
                    from kernel/module.c:11:
   kernel/module.c: In function 'validate_section_offset':
>> include/linux/kern_levels.h:5:18: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 3 has type 'Elf32_Off' {aka 'unsigned int'} [-Wformat=]
       5 | #define KERN_SOH "\001"  /* ASCII Start Of Header */
         |                  ^~~~~~
   include/linux/printk.h:418:11: note: in definition of macro 'printk_index_wrap'
     418 |   _p_func(_fmt, ##__VA_ARGS__);    \
         |           ^~~~
   include/linux/printk.h:489:2: note: in expansion of macro 'printk'
     489 |  printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |  ^~~~~~
   include/linux/kern_levels.h:11:18: note: in expansion of macro 'KERN_SOH'
      11 | #define KERN_ERR KERN_SOH "3" /* error conditions */
         |                  ^~~~~~~~
   include/linux/printk.h:489:9: note: in expansion of macro 'KERN_ERR'
     489 |  printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~
   kernel/module.c:2953:3: note: in expansion of macro 'pr_err'
    2953 |   pr_err("Invalid ELF section offset/size: secend(%lu) < shdr->sh_offset(%llu) or secend(%lu) > e_shnum(%lu)\n",
         |   ^~~~~~
   kernel/module.c:2953:77: note: format string is defined here
    2953 |   pr_err("Invalid ELF section offset/size: secend(%lu) < shdr->sh_offset(%llu) or secend(%lu) > e_shnum(%lu)\n",
         |                                                                          ~~~^
         |                                                                             |
         |                                                                             long long unsigned int
         |                                                                          %u
   In file included from include/linux/kernel.h:19,
                    from include/linux/list.h:9,
                    from include/linux/module.h:12,
                    from include/linux/moduleloader.h:6,
                    from kernel/module.c:11:
   kernel/module.c: In function 'elf_validity_check':
   include/linux/kern_levels.h:5:18: warning: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'unsigned int' [-Wformat=]
       5 | #define KERN_SOH "\001"  /* ASCII Start Of Header */
         |                  ^~~~~~
   include/linux/printk.h:418:11: note: in definition of macro 'printk_index_wrap'
     418 |   _p_func(_fmt, ##__VA_ARGS__);    \
         |           ^~~~
   include/linux/printk.h:489:2: note: in expansion of macro 'printk'
     489 |  printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |  ^~~~~~
   include/linux/kern_levels.h:11:18: note: in expansion of macro 'KERN_SOH'
      11 | #define KERN_ERR KERN_SOH "3" /* error conditions */
         |                  ^~~~~~~~
   include/linux/printk.h:489:9: note: in expansion of macro 'KERN_ERR'
     489 |  printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~
   kernel/module.c:2974:3: note: in expansion of macro 'pr_err'
    2974 |   pr_err("Invalid ELF header len %lu < %lu\n", info->len,
         |   ^~~~~~
   kernel/module.c:2974:42: note: format string is defined here
    2974 |   pr_err("Invalid ELF header len %lu < %lu\n", info->len,
         |                                        ~~^
         |                                          |
         |                                          long unsigned int
         |                                        %u
   In file included from include/linux/kernel.h:19,
                    from include/linux/list.h:9,
                    from include/linux/module.h:12,
                    from include/linux/moduleloader.h:6,
                    from kernel/module.c:11:
   include/linux/kern_levels.h:5:18: warning: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'unsigned int' [-Wformat=]
       5 | #define KERN_SOH "\001"  /* ASCII Start Of Header */
         |                  ^~~~~~
   include/linux/printk.h:418:11: note: in definition of macro 'printk_index_wrap'
     418 |   _p_func(_fmt, ##__VA_ARGS__);    \
         |           ^~~~
   include/linux/printk.h:489:2: note: in expansion of macro 'printk'
     489 |  printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |  ^~~~~~
   include/linux/kern_levels.h:11:18: note: in expansion of macro 'KERN_SOH'
      11 | #define KERN_ERR KERN_SOH "3" /* error conditions */
         |                  ^~~~~~~~
   include/linux/printk.h:489:9: note: in expansion of macro 'KERN_ERR'
     489 |  printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~
   kernel/module.c:2994:3: note: in expansion of macro 'pr_err'
    2994 |   pr_err("Invalid ELF section header size %d != %lu\n",
         |   ^~~~~~
   kernel/module.c:2994:51: note: format string is defined here
    2994 |   pr_err("Invalid ELF section header size %d != %lu\n",
         |                                                 ~~^
         |                                                   |
         |                                                   long unsigned int
         |                                                 %u
   In file included from include/linux/kernel.h:19,
                    from include/linux/list.h:9,
                    from include/linux/module.h:12,
                    from include/linux/moduleloader.h:6,
                    from kernel/module.c:11:
>> include/linux/kern_levels.h:5:18: warning: format '%ld' expects argument of type 'long int', but argument 2 has type 'unsigned int' [-Wformat=]
       5 | #define KERN_SOH "\001"  /* ASCII Start Of Header */
         |                  ^~~~~~
   include/linux/printk.h:418:11: note: in definition of macro 'printk_index_wrap'
     418 |   _p_func(_fmt, ##__VA_ARGS__);    \
         |           ^~~~
   include/linux/printk.h:489:2: note: in expansion of macro 'printk'
     489 |  printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |  ^~~~~~
   include/linux/kern_levels.h:11:18: note: in expansion of macro 'KERN_SOH'
      11 | #define KERN_ERR KERN_SOH "3" /* error conditions */
         |                  ^~~~~~~~
   include/linux/printk.h:489:9: note: in expansion of macro 'KERN_ERR'
     489 |  printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~
   kernel/module.c:3007:3: note: in expansion of macro 'pr_err'
    3007 |   pr_err("Invalid ELF section header overflow: %ld > %llu\n",
         |   ^~~~~~
   kernel/module.c:3007:50: note: format string is defined here
    3007 |   pr_err("Invalid ELF section header overflow: %ld > %llu\n",
         |                                                ~~^
         |                                                  |
         |                                                  long int
         |                                                %d
   In file included from include/linux/kernel.h:19,
                    from include/linux/list.h:9,
                    from include/linux/module.h:12,
                    from include/linux/moduleloader.h:6,
                    from kernel/module.c:11:
>> include/linux/kern_levels.h:5:18: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 3 has type 'long unsigned int' [-Wformat=]
       5 | #define KERN_SOH "\001"  /* ASCII Start Of Header */
         |                  ^~~~~~
   include/linux/printk.h:418:11: note: in definition of macro 'printk_index_wrap'
     418 |   _p_func(_fmt, ##__VA_ARGS__);    \
         |           ^~~~
   include/linux/printk.h:489:2: note: in expansion of macro 'printk'
     489 |  printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |  ^~~~~~
   include/linux/kern_levels.h:11:18: note: in expansion of macro 'KERN_SOH'
      11 | #define KERN_ERR KERN_SOH "3" /* error conditions */
         |                  ^~~~~~~~
   include/linux/printk.h:489:9: note: in expansion of macro 'KERN_ERR'
     489 |  printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~
   kernel/module.c:3007:3: note: in expansion of macro 'pr_err'
    3007 |   pr_err("Invalid ELF section header overflow: %ld > %llu\n",
         |   ^~~~~~
   kernel/module.c:3007:57: note: format string is defined here
    3007 |   pr_err("Invalid ELF section header overflow: %ld > %llu\n",
         |                                                      ~~~^
         |                                                         |
         |                                                         long long unsigned int
         |                                                      %lu
   In file included from include/linux/kernel.h:19,
                    from include/linux/list.h:9,
                    from include/linux/module.h:12,
                    from include/linux/moduleloader.h:6,
                    from kernel/module.c:11:
>> include/linux/kern_levels.h:5:18: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 3 has type 'Elf32_Word' {aka 'unsigned int'} [-Wformat=]
       5 | #define KERN_SOH "\001"  /* ASCII Start Of Header */
         |                  ^~~~~~
   include/linux/printk.h:418:11: note: in definition of macro 'printk_index_wrap'
     418 |   _p_func(_fmt, ##__VA_ARGS__);    \
         |           ^~~~
   include/linux/printk.h:489:2: note: in expansion of macro 'printk'
     489 |  printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |  ^~~~~~
   include/linux/kern_levels.h:11:18: note: in expansion of macro 'KERN_SOH'
      11 | #define KERN_ERR KERN_SOH "3" /* error conditions */
         |                  ^~~~~~~~
   include/linux/printk.h:489:9: note: in expansion of macro 'KERN_ERR'
     489 |  printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~
   kernel/module.c:3049:3: note: in expansion of macro 'pr_err'
    3049 |   pr_err("ELF Spec violation: section 0 type!=SH_NULL(%d) or non-zero len(%llu) or addr(%llu)\n",
         |   ^~~~~~
   kernel/module.c:3049:78: note: format string is defined here
    3049 |   pr_err("ELF Spec violation: section 0 type!=SH_NULL(%d) or non-zero len(%llu) or addr(%llu)\n",
         |                                                                           ~~~^
         |                                                                              |
         |                                                                              long long unsigned int
         |                                                                           %u
   In file included from include/linux/kernel.h:19,
                    from include/linux/list.h:9,
                    from include/linux/module.h:12,
                    from include/linux/moduleloader.h:6,
                    from kernel/module.c:11:
>> include/linux/kern_levels.h:5:18: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 4 has type 'Elf32_Addr' {aka 'unsigned int'} [-Wformat=]
       5 | #define KERN_SOH "\001"  /* ASCII Start Of Header */
         |                  ^~~~~~
   include/linux/printk.h:418:11: note: in definition of macro 'printk_index_wrap'
     418 |   _p_func(_fmt, ##__VA_ARGS__);    \
         |           ^~~~
   include/linux/printk.h:489:2: note: in expansion of macro 'printk'
     489 |  printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |  ^~~~~~
   include/linux/kern_levels.h:11:18: note: in expansion of macro 'KERN_SOH'
      11 | #define KERN_ERR KERN_SOH "3" /* error conditions */
         |                  ^~~~~~~~
   include/linux/printk.h:489:9: note: in expansion of macro 'KERN_ERR'
     489 |  printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~
   kernel/module.c:3049:3: note: in expansion of macro 'pr_err'
    3049 |   pr_err("ELF Spec violation: section 0 type!=SH_NULL(%d) or non-zero len(%llu) or addr(%llu)\n",
         |   ^~~~~~
   kernel/module.c:3049:92: note: format string is defined here
    3049 |   pr_err("ELF Spec violation: section 0 type!=SH_NULL(%d) or non-zero len(%llu) or addr(%llu)\n",
         |                                                                                         ~~~^
         |                                                                                            |
         |                                                                                            long long unsigned int
         |                                                                                         %u


vim +5 include/linux/kern_levels.h

314ba3520e513a Joe Perches 2012-07-30  4  
04d2c8c83d0e3a Joe Perches 2012-07-30 @5  #define KERN_SOH	"\001"		/* ASCII Start Of Header */
04d2c8c83d0e3a Joe Perches 2012-07-30  6  #define KERN_SOH_ASCII	'\001'
04d2c8c83d0e3a Joe Perches 2012-07-30  7  

:::::: The code at line 5 was first introduced by commit
:::::: 04d2c8c83d0e3ac5f78aeede51babb3236200112 printk: convert the format for KERN_<LEVEL> to a 2 byte pattern

:::::: TO: Joe Perches <joe@perches.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--u3/rZRmxL6MmkK24
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICIcFZ2EAAy5jb25maWcAnFzbd9s4j3+fv0Kn8zLfOduZNmm76e7JA01RNj/rVpLyJS86
rqO2PpPGWduZy3+/AHWjJDCd3Zc2IcAbCAI/gFB+/unngD1fjt93l8N+9/Dwd/C1eqxOu0t1
H3w5PFT/HYRZkGYmEKE0vwJzfHh8/uu35+/B+1/fvv/1zevT/n2wrE6P1UPAj49fDl+fofPh
+PjTzz/xLI3kvOS8XAmlZZaWRmzM7auv+/3rj8EvYfX5sHsMPv56DcNcXf2r/umV003qcs75
7d9t07wf6vbjm+s3bzremKXzjtQ1M22HSIt+CGhq2a6u37+5atvjEFlnUdizQhPN6hDeOKvl
LC1jmS77EZzGUhtmJB/QFrAYppNynpmMJMgUuooJKc3KXGWRjEUZpSUzRvUsUn0q15nCRcAJ
/BzM7Wk+BOfq8vzUn8lMZUuRlnAkOsmd3qk0pUhXJVOwT5lIc/v26gaGaehroVSmgsM5eDxe
cMxOJhlncSuUV6+o5pIV7jZnhQQ5ahYbhz8UEStiY9dBNC8ybVKWiNtXvzweH6t/dQx6zZxd
6K1eyZxPGvB/buK+Pc+03JTJp0IUgm7tu/QyYIYvSkslBMFVpnWZiCRTWzwaxhf9yIUWsZy5
g7ECrhUxzIKtBBwCTGQ5cBUsjttDhUMOzs+fz3+fL9X3/lDnIhVKcqsDepGt7UTV431w/DLq
Mu7B4aCWYiVSo9s5zOF7dTpT04AaL0FzBExh+r2BUi7uSp4lCWiAs0NozGGOLJSc2GfdS4ax
GI3U/7qQ80WphIZ5E9Akd1OTNXbKlUftPuDHwSa6hQGhbOTqLqwbfNixUw4lRJIbWKS9mPWA
efGb2Z1/Dy6wnmAH3c+X3eUc7Pb74/Pj5fD4dSQ86FAyzrMiNTKdO3dCh3izuQAVArpx5Tim
lavr4bLbCZheoq3RJDXXktzsP9iC3ariRaAplUi3JdDcBcOvpdjA2VP6rWtmt7tu+zdLGk7V
Wahl/YNjs5bd0WTcXYBcLgQLQWVIe4UWCBRgISOwce/645WpAWPNIjHmua4loPffqvvnh+oU
fKl2l+dTdbbNzaIJamcZ5iorcu2uEMwEnxOrm8XLht2x/fb3UvOFcHxUxKQqh5RudB6BQ2Np
uJahWZDaoIzbl2Rpps1lSCtUQ1dhwihrWFMjuDR3Qk02E4qV5GLSDMo41v6GkkjNX1pGKGYF
JVB0GjpncHkcY2zAkzq/o4NIB8cD5lpBE32RZDgitVMJMxoGZMuXeQaKhWbMZEqQI9ozsE7S
7oW6NFsNRxoKsEGcmeFhj2nl6oo+chGzLUlBpYMDsb5X0cowyzJT1j9Th83LLAcjLe8Al2QK
zT78l7DUHnEvjhGbhh/ozQ58tfWIhQzffnAH8xqYlrO9aQAfJJ7nABSAxHrP2t6oBVyZeAIH
OuczMBQunHFMkogjEJNyBpkxDbstBhMVgIZHv4JajXZcN/Mk3/CFO0OeuWNpOU9Z7IJXu163
wXp3t0EvwPw4wFg64ExmZaEGromFK6lFKy5HEDDIjCklXdEukWWbDG5B21aO/O2YbCWFWmrk
Soxvo4WBEa2csA4RhkMzZk1zE53k1enL8fR997ivAvFH9QjejYHR5ujfAEW4Vvwf9mjXvkpq
6ZbWow/UBPBQzgzAbUdVdMwGGFDHxYy6AMAG0lVz0eLfYSegol2NpQa7AjqbJbRZGTAumAoB
89ES1IsiiiCoyBnMCecB4N0M0X5v/mz8ARpCoolh0GElWyTx6/NTtT98OeyD4xNGiOcePwDV
0ajEgQYABmU2UFTbkmfguxIX9COCBfNX6iJHoiNuwOBLo8D4T2kd/mWAyxXYTRA12EfnDt7d
vu3DzFShb9K3b7tbgQgdQzIOOF9goCesPWuR4eJ4vgRPp+O+Op+Pp+Dy91MNrgbQod32u5sP
ekNKG0k04f0LBOPxlUhLkg2hcsmHm4F1TXLQalkkUtIDdeSX6bRittR3NHXp2djyPz3tN3Q7
V4XOaI+biCgC/JGlNHUtU74AVOBZSEO+pu9SAnrkGXcuslDMN29foJaxRxH4VsmNV94ryfh1
STt+S/TIDn2VpxdYAPr4Njcf2utDaBJSJdrCFHdT344aR793WeK3fhrY+zIHO1PjJ104JgDJ
oN3DhsZHfng3bs5Ww5YEEE5SJDYKi1gi4+3th87xseurMhJgsgfgA1nBeNgtEc0sCaeNi+3c
RsKjZg5azwo1JYCJSnUiDCuvr6bUuwXLNjJ1A6QfGhfHuuLGh1JwJ7kuY3BgcZnPDZvFLkju
DJzmDcgYE5XAg8LMTLlq0AEQBJsa2cVaQCg/9GI2KWYTZFSQFsK0SkK0HW4dSQ6aSwX+1Umx
4EIiF57A/zpz8VzC5tKmgtQnB7GApoIArK8oM/CRCox8fwvA0wDOJJbYSKyWn769duAKCB1B
GJ4ryrbxPaS/JJ1j6zYD/m132u0BcQRh9cdhXzl+UxtYqSone9Ta0dIUYCdcIuaI0LrPUZPZ
jlrMpGUDFzoZtcF/JcR2Wd386sv9f735D/jn7SuXoaY9Xc6vnBUSrSg0DSAqvP3eMRK/lphj
GwJsPHdMlWXA6sqVkF4n2LS6/Hk8/T4VKy4D4jgnVqwbSmEWEG64sKOlGEB+VLuOJdEaMjFK
k7WUleA+zNWxhFS81FITzrShRs45o4JKZ6Eqd80LJaF+1JVUBqOEhALz1jDoQoOHDzF+0nI2
0M6aMmmY5gnyBNYlRO7uB9owSLbtNDZNyjVbCgSEVICeJ6PRJkmDPtX7CVa/Fqq0QEEixG+g
+CTIaCHv7rT/drhUe7TAr++rJxAmBA5TxMsV04uRDms4Btd21aBVqk9RzOZ6il6tmK+vZtKU
WRSVDqVOH+ukTLKwSb+P7faawW4w55EzBQa8zd2PhrAHKTiGMS+QSogFzCC2HneZMPYuoKHU
OMCXwIlN1qZcW5uchQW4KgsTMN5WA8ccAy+Ekny5hoDH2XqGzkPOG4W7nhAYNwMpNPFbLWQ0
5yMp2qcYmxEeEUS+EBC8sRgwA0AgTUlvBW6ldjk9ddBWaxbPVq8/787VffB7HZeCz/9yeKjT
yn3M9QLbYGp8RMvjYi7TQS79HypwOxSGX5iacHdmQ3edYDrlzeiYBlGFbcLcD8ckKwuJ8254
ihTp3s41mQauveL76DiOVrx7nhq/A4w4yZxXQ0Q1UZiZb3R03Lmjz+8kbbTGjJu7f8R2Bwjg
JUaM4teYNtUQq/dp0FImaEoo8wgdAXTPMAsAuOrVb+fPh8ffvh/vQZs+V52jnqF1HTxPNNnD
mZ5DKP2DBKMRcyXNy2nIu8yXpmg5zEJlxkyTEA7bema8tCZlLLMY4v6U+1fTMXLAGD/mypXM
vFxaAHjJGa1pyFA/+ZawILXN0RZNPE2+O10OeBkDA4h/kEIAU26kscocrjDvSl4tHWa6Z3Uy
hJEcNHemYTzjT856rTetHyWz/vXDcXTJJ5BJndsOBQuHD9oOcbmduR6kbZ5Fnyyia6eMPpWt
oIlHi/axc7CUbshatDqXqbUcgPSlGwM0dIhdwob+Eo3suwa1Fr7OLnHYu8c9VpLir2r/fNl9
fqhsCUZgk5AXR6YzmUaJQbc3yDkP0QT+VoZFknfP5+gmmycxx2jXY9UR1aQZH1x68I1D4oiu
cvgWa3eSVN+Pp7+DZPe4+1p9J4EQYBszyO/pPAZfmxsrJptue+c8HqA/5uN74VyAOR4S2jaf
WVjqhLgUrYgw0sMEAVygUN2+e/OxywykArQRgkAbkS8HGJLHAi4b4hdyxkhlqcEKBfrlavhw
1rXf5VlGm4k762IzOrmHT+m1GBA9Ln1SgI3YzML4obhGHJiNEGDrHqvq/hxcjsG33R9VYLEZ
AFQ4eTzue+C17OHusgvYHtMQQXJ8PFyOpxabtNJlyfjAGu3x9W3pfgXqz8W096aJVmCAqZqB
1izFIC6qW8pQMsqxF6l0HmfwN7gi7nNJVDdm2SCXb9vGQ/Zv8zENRjYRhNX4vkFSMTpbii2x
SJkOtyTz+qELQ0BaO/LOM5RgRY1nRmDLU1pdcTEy94CYmjhHuyOSgk5h6m0KtzhbSkHLoh5j
ZegUJ1KjrKBXjURGv3RbGmAfPxFCIbAtHiHbI3UNOkb8PG+bhyMVYe5XAcuh2PoHHEgFIWqj
MhqY4Ozw4/wlT9/x8GLmlp61xq6l377aP38+7F8NR0/C9yPM6+jHypMUz6Gn7+CwLA3DvYQp
KttncxQmx1o+QKvR1pVr2ztfbG0UBnYryX22DZjrMJMGWfkLRFD8kHt2ILFMwtA05amOMKBV
JAF8HtkeX3lmmCkZzmn/YvVF015kFbO0vHlz9fYTSQ4Fh970SmJOPwkww+IlSdlcvaeHYjkd
EeSLzDe9FELgut/Tz0M2Y+UtWgm5JwIBsTMLjklylot0pdfScNqIrDRWyXkqq2BFts7Te6+T
3GP964oResqF9vuEeqUQCXk54usyAVcAoMXH9UkZ/wQpH1eLtZilhuD2xvqiHYenvtGUhbLG
cFPOCr0thxUNs0/xyK0Hl+p8GQELu4KlmQsaXUx6jgguUnBkzhLFQt+2PK96nkATYILaKJ8R
iMol9zyOjixN07yWSsQQ9w/QZzTHizJ4Tqxl1BI6GPe5arEbwvQgYdwyOMFa04LAEJ99FtCy
qV+03zjWLlpKT7IED+SjB+gyGdEEkS9KX9IgjWjZ5Ro8QOw3iDKiafHaFGkq6NVHTMbZinzo
EWZhAJC317zVzToxHoSnwx911Nsngw/7pjnIOjDa48S6YGQhYvpdCe6rSXI3Gdy2lAkWmQzK
G9KQxYPcaK7q4SOpkjUDOGaLrds1R4fT9z93pyp4OO7uq5MTiq1tOs4Nw8UGwohuHCzJ7oXV
ctd1ctOtEJxt3orYMTDZEMqNLccr7cC3zWphDmgQkXaSwjglVHLlWU/DIFbKg0FrBgyBmmEg
pkxAMWgfj2wMYC1vmW3+jNhiV20CkVdd+jjNwE61pq5ifj4H990zVW8mFhKNJ2n83C5uAA3a
P35iGqrFSJmZSgJti3DxA4/L6fhgX5mdkExiOdSXHdyD/HS8HPfHBzcx/f/q3y94nmVzTPg2
KjhZtqm+nnbBl3bx93bx7vwehomOtdt2pk61J3nsSbpmEXHqTbqSSpbal9lZTKHhlqWYhVRP
aMZIiiq9aFk4XJGuHH9Ei7Ms79M6bqtNftg6ttub6bQ2KZkh34uZ2VDNKG/fbXsWDnJ6TbNi
tC8EwFmiVUYb/OK0o1lr8LBKRKCfn56Op8sAOazwaX4M9Vt44HaqE1mH8566gGB7ki0m88iF
iZTHmS7AAIOFtPeddoBX48qAOg0owJAkwXm6+JpSfrzmmw/kBkZdm4vy1+4Md+18OT1/t8WM
52+g9/fB5bR7PCNf8HB4hAsCWz084Y/DW/R/7l1bjwe427sgyufMuYPHPx/RpAffj5ijDX45
Vf/zfDhVMMEV/9dgp3xB47B8lbNUcnL3g8Oqi/YRydYtjjxbDwpEfPZw75liMrRfVtEnpifI
uK3/JyZy7AZtNgxTc4TJo8rwHs30zsJBOE22t78FWRqOQmJXSd0bhzByXjBPlbf4VLAYIJ8/
MDDCc1UBP658dW8y95JWGx8FXabH787AGxQhbYjmniga1qcFDShhX7wuo6EyKUXqyg9+LVf2
DOzXXh4YuvLZqzQepUN7jIllSGZ4zoDkwkwB5mEcHxDc78lccsLuXEvvkuA8UyMZTVScbOds
Jd2SO5dks+v0cOIOayJJUu3ISdKiYGshSZK8uXq/2dCkYTGeQ0kkHkwW0ZKM5aDw3u3H1ErE
L4zp3Vw9o0joTaTM+GnCqCzNEloyKd3p5vrjG5KQi1RjLThJxHuNiGBg6JJRBmbaTcEd1EyT
QyrMiCiSBAGaLtxPCFxaFjMVxUzRu9YZlxDQbOjzA9yT5XpLL2jl0fMNVqtvBvn/xdYXdCYQ
/TcIfeKVc65bA3/fAeX+qXRK7YKyPHdtCPyK3/SNk84DeijwdYy2Lkh/IZOJ5CTP/X3tQ8G4
8NLl8BRNY182hp4Dqg2FjKEeLGw1XF/LFy+4KxKkdiGi7xsF5NFwUel8iyUnWHOMP32YnB7W
zL4+H+6roNCz1kNbrqq6b9IiSGkzR+x+94S1gxPQsI7dIkj8rbOoYWLE0kOzpaoOsl14K56G
3RLX0rmkmYLIGmRGU7nUPKNJI+s5JiktB1892/pKMiXldJzYzwFRhJJ5JUOYV5es2PDL+gFN
sNg7LuyDJmhDtxsP/902dG2gS7L+VaTWJfYYi01LN9aAcR/wqROILspdr8fwpzEngw5DDEbl
quo6jMen54sX7Mo0L5yd21/LKMLPuMaJxZqmbX3gMvE8X9dMCTNKbsZMdaHtuTo9YMB/aKP8
QQDV9M8KuPCeHHXN8u9s+zKDWP2IPrpojrQmabxBz6XYzjJAy73Y2ha4mcthgN5R4uVyRpuw
jiUVa+MpZOh4tMnWbO35ZLPnKtIfzrYxSzIqd07Ara60n1/oK6IJoGiuqfbZNqSa42wu4f88
p4jgLFhuJCcH5FvrCiiSrW6wH9UOy+1aOn5+g2CZ9u/99ALN4DiOnM6WFXyxJP9SQ88U4R+7
aAD6aAwI/6Wn6KtmWOnNZsPoN7z6gOx3Bp63spoB16i5EuPHkOE5+76gVol8NwlBa5+5O93b
sF3+lgVoTdwPEPBPO7hlvvAr/jv6BM82A9qqFar31rZdsTXtyy0VuiSjgus+i25ZSMtJLbor
D6MsZG2Uuo8F7sffBACgGdaDfLzBbyYc5YzFnPGtt7HJql07f3IGzsLWso+LXNNyrukA22YM
jad0stayugxznBRuY9K6bN8f6S7WzcekzmaTuG/rVwJrn+dD6TckWEBd0eWkU7A7XNpCG/sV
ef0eQJ7c9AxqQ33FqVQYNlOjuOwO9zWt/DpP6JfOxTDP06HcgaOEX6cwrg4Wch3sHw51vmy6
eOzIY/tdwdJ+sO3B1B2XVZkfMY1PpVtJ85edjid3MTXV5LDO4/73KWDAkoy3729u6r8R47wx
DdrtJ/1ZyrpHW2HfGYMmyEL/763huBxhmVVw+VYFu/t7W2i6e6iXc/51EFxNVunsX6bcKNrE
okB8oV79fQd4GY9tren46UXsKcRZCJV4bLv9U0FhRtcDYAou9n5grfjEGPcuA5F0yQWnPiqr
HyBPu6dvh/1Q6dpnpjGts9KDT6vwEZHHTHb1vQsZTrUDGgdRggyxyALChy0gFyXSuScFBow+
s18syFIBHLp5QGtXpPGTOVAV7HA/hm7Iz96N3bFt5aqgvn62NDhnMelQYIjh6TET8VK6381A
GwedUNtxm4TftuOxwSnMGa0CSE4YflBJa57tbnXBs7QePg36gOTnWaqkprULWUSiISjwk2PB
M6qM1hLvAHKO55yLZCY9+WZLjxTt8CwxzsDNezwaMqzkioFp9NJhQRYd+Rm2flmsAdR53rvq
ucVaZ5OnCHf5W8W8FcvIIDkjP+mzNDNRx3+zmaKRIlLNWqYLRqWXa0mk+CWIGf2NLqDE3Jo6
77ixSLMV/RZTK+r/VnZlzW0jOfh9f4VqnmaqnMRXHPthHnhajChS4qEjLypF5tiqWJZLx268
v34baDbJJoGWtiqJYwJs9olGo4EPj4GDuqyBJQRTp4E+90NLd4RqkBNPTlx9WRGmXnwcgw2j
Ow/R6mWeCxHjego0IWs92mAG1JE4coiVL2YrP9FHXmaF84j2jUUGISZCx1AAHGwSmHD8ehA8
cwytNvT2KAmGFl+N1ApMTS2NuzzdG5rfH3mey1ofkYO9ZCqpXgj6LnOlijx5NAoNUiPhdD5Y
s3CMstKAX2dog/wez42fyALDkhFSJfUYMyfQc9gixfmHxnkDjlkQDfnyISrbWDswaTmmFQkH
fVK7Jnfe6ujVUBSqM0RqL+K+E8DlSxZCfJPYtjQZJE4MKYDjMZdzUyGAGCdbywFQvMAOQi6m
LMkc6YTYUZTcoWXnfiNcoD4SgBUbMDbJEuV7EE3D9FCr4EZt85lQ4kccClfO+B1OfI4gTnSl
4xHlVlUe+IZepIHzTdwRpTVMEMehw4xPOU9dSZU3oXJYy0Nvp7OH69Vuu9/+c+j1P96L3adJ
7/lY7A+UknqKtaHcCynPnXaFkuIxaoEQj4+cA7n0mhEzhpFOUwghg1NPp4UOnk7S7XFHXw+R
9MYasILQjindNBBVyhsR4JqbIRJ7o+VzIeOwUkLpP8EqwR2LzfZQAKIIVXeCKt963+yfyRc0
gtTYY6f3Z+kMFr+Jo/76/a9ehXzRdjzbvG6fxeN061DFU2TpK7fbLp9W2w33IkmXzkKz0Rd/
VxT71VL0zXi7C8ZcIadYkXf9eTjjCujQmsfmcH0oJNU+rl+f4AJKdRJR1Pkv4Vvj4/JVNJ/t
H5LeWDmxs9BVJHx5BqHmv7kyKWq1mZw1KRpHcoBsmPiJxzhdzcCRgzk4AywvbR1lxOtoOuw0
Fdy9VqKWlODq0JoH/hTddkB9C0Pi5mbUn2vgqrWMKx1HgYGsZH+OQNMIIeR4XcdXZUDRPtAy
cjjMDU9idbdN6+1pt10/NetoRW4SB3Q8rmJv7J+M6gmed90O70/BzWwF7vqEFS1tx9IoPaT7
Vv0SOqSR9hyPgecMYiagLQyG3AaEN6mOdLllthpEDKRVCP1SqnTSFQtdjp+mrYjzb+ACfp2f
SkAPyqlc0IT8tzRnabFariGmk1lJNy1aTbnVoErwAVxkAKInlNn6xi1WDJE0LYc2limu1HNy
Fh0Ambgr8++2q30XfmeZwZPeVh7n1QoNAGQylU1rLNzyMSKRMca8kgVAiMWw+7Q0aXxgMQP3
QpLrOzKQpBlPevRTdiTtLOFfjILQ8Kp/zb8JiLMWpa54M9BT9F5UzyR2xCIekVEAAGoPdAk+
2vwSDYnQ5BBiLyDdTvw0ijMZUqjkT/tBIB8sSozYulhLEohSx3mcaVf++KAKBMO171sOZdlB
9NiSf2olUau1ksDjEo0hNH9CAwhK2jVXXw3WDu6e/BRX8kZ/Jh/VvYBLm54E4IQgTjMtshRO
y9WLft3vp0ScvFKOJbdkdz8l8fCLO3FR5NUSTw1XGj/c3V1qNf8eh4EeD/1DsDG1zl2/0yBV
D/rb8rwYp198K/vizeDfKGvVrtY0EGSD+fZEvMvLXAMxygyrWNDa0rreSkzVlrrHvjg+bRHC
odPZKNOa0h4fDHS4CXzWSbAADxGNQByogizWlhYSnX4QuolH2SsBk6/5VQRsrn9V8VH1zo3h
UeZNRvJ0RG+tH/quOMp6lm51lT+Ivld6VbfzqiLhjhekmqh95umQyLFQ1x49fkgt10DzeVrf
SAKTELtPGGpj8yTDW05iDRlSOs6ttM+tEcNOBwCeM1YcDQ2tH/G0cTS7NVLveGpi+ujIAPk+
Tyfca7mhu5O4Q1RSoLxkZWZcZJAffspkAIDwTG50A25shzbGvDAXCk7sWvzM5trWxB4Vv1Sw
2H+s99v7+68Pn64a4YnAID7jofS5vaGRbzWmb2cxfaNj3DWm+6+X5zDR8fUtprM+d0bF7+/O
qdMdrVS0mM6p+B1ttm4xMdH9OtM5XXBHA1K0mB5OMz3cnFHSwzkD/HBzRj893J5Rp/tvfD8J
FQfm/oKGv9aKubo+p9qCi58EVuow4NPNuvDvKw6+ZxQHP30Ux+k+4SeO4uDHWnHwS0tx8ANY
9cfpxlydbs0V35xBHNwvmHgtRaZBc4A8tBzYwpgQLMXheIAsdIJFnHnyhD77VkxJbGXBqY/N
kyDk/DIV06PFum5WLInH3EIqjsABV1F666t4ojyg7Tda951qVJYng4AB+gCePPPpVZxHASxP
Yk8M4sV03Awi1wxE0uZerI679eGDuuQaeHNm/y6NMAt36KVousySgLFhGQ02ikju6IhHqlJS
4NHbiUfzOvWEdnvfZqM/JwHFgQeiQAz4ChICqW6n1YiDC9Ph33+A0zpc11zAPxCxevGx3Cwv
IG71ff12sV/+U4gC108X4Nj+DD188fP9nz+0nCMvy91T8aYDkjWB8dZv68N6+br+bytlIubh
k2DkbURRJEm4UnF8Uu1gjCKKGQAGWV4daq1dpVZOFKJFlR2/PdFUa2TUuLq1cnYf74dtb7Xd
Fb3trvdSvL43QSgks2jeo9VMhqM9vu48B6wS8qFmECyfi6UqNjpGM5UsbTA2soCFG6SI/g4Q
ECnxIfDWNX0FfzBad9nePOt7TKxVyYJIfW3Ly+j483W9+vSr+OitsL+fwevvo7n2y9cTBjmq
JLu0uCqpnnOSbi7ec5ITHOmQ1hVUF+bikHH99evVQ6cPrOPhpXiDtKaQzNR7w44AFNP/rA8v
PWu/367WSAIQQqJnHAabpyQ/mslO3xJ/ri9HcTi/urmk9241yt5jkF5d08Jf9YM3Dujwlqor
+5ZY75NOP9h46bzZPummOFVP2zi7HJ/2m1VkxoRdkTmrQFllY+FhQnuIluTYXLXRiZbNzHUT
W+M04TA7y2EDZ4csN04D8EzpDkl/uX/hR0ToCqYi+yfosxMNn7Tel4bN9XOxP3TEsJM4N9cO
IdqQYKzFrG8xuk7JYYfWwLs2jqFkMY6TqEh2dely2FLlWj1Vl3NW6dCldfSKbH47EOvTC+Gn
iS0ZulfMSV0Jgr5Fn69q+vVX+lxTc3y9Mg6e4KCPLJVQNpMzoW/YjN97yTMdteogV8L6/UW5
DrRlpHEaWJgg1jyX4qnPqd9qMllDTxw7jBsSgKsaRxoYjP3vmpvi489z9hbzfpFAgi3zKBon
dDaNT/VXybJopSGTw7fdvO+K/V4qtt0+4EPblfj/wUDwSfL9rXEKhz+MjRPkvnEhtpH1pa+T
OBNsN73ouPlZ7MqUCQe6gVaUBgtnlHA+ZmU3JPYj+tuZmL4HEFHhgd8Ic+xpaK0LoR8vTom7
ijEdOMGof1oXRuYTban4LM/qdl2p9r+uf+6W4pix2x4P6zdy/wsD+xzBD2xyIZzkInXELp/a
BCBo/IfXTABFMJ1XNVr/a+3n0+poVOwO4PQktNI9QhHs189vmMyrt3opVr9aKT/OYUf+0NDp
oy5KeEmxgwxwBJO0nfQE84FlSeSIs7oPQFR6YlWNJ/SiFlk5MyFUchY0jfqK5AeQDChIIFgw
0PMAx0krkXjdkASybUX50PYY1CYHgqocsZjIsXD0zLLAbFQsnEWQ5QumrJvWuVM8EBI59NuH
NZ0hDBzPnt8Tr0oKJ9GQxUqmvEAFDpuxYQkqY4cXFJZA20XFzJcqI/cafcaR8aFMH1Vcsx8A
WEx0XxSDQ3az28SvKIo47x933ET5CeE+WDOyJGPEoyXeTEU3Kh+qch12lpduAlLrFp++79Zv
h18YEPm0KfbPlFWuTEIOQZLcTAc6RIYxkruR8xShPxdkSJ0jo4AhQF/m/1MXat9YjnEOLhZV
uvShON7AnUGnhNu6Lpg0uqyyy2afdueRJVRjg9OLxsGBpaXzoR2LxbLwkgSy3TQ8fvA18VdI
NDtONZxRdlAqRWb9Wnw6rDelYN0j60o+31FDKL/W9gMriX4iaoZ+P39fXV7fNoctAYT+dAjt
YK6axd6KNieLyWMB3009TJEBzgdDCEFtRuLrFKzFIo7ChiuUrB5iK+i+UGUCCEy9NPWsgUqH
QZoTz+41zZW9XDRu8fP4/AxWxgbi4L8aMMVVCsc6uUkE3fL35e8rikuGxjeAJDo0MLDkHuQq
b4LcVjkvSLO8nTK4LWc1Rx8zmYGyPV8x/8qHZjOuCtN3cbEKvVkG4X2MLVgWCIx89hAsJp5G
XCQ6kMXEgHhHRheUX4nt7x5n+ymnaGhRSa/xRqDsEISksQbdGagopuLRdp6DcKIFJCYXklyQ
eZD37JTlTfjFJp3K0dTesEA7qAENLDFDGmHLOhU8NTAtVyy4gkzonJh2RoXs6nb5etg7be23
8EelQQf4e/H2fX/RC7erX8d3uf76y7fnlgIYiaUgZEJMu2RqdHA0zr06vZskwk4V51kTIxxC
MsGPMwcUs4xPaimJi34eAQ5mSo/BdGwOpUcIZvk1cjma+0Lekql8Udr60mYL9rYGXwKPOyl0
6vsQosj22EHPDTyvnctCau1gtq1Fx5/79/UbgiJc9DbHQ/G7EP8pDqvPnz//VVcVfWuxbAhv
akQMNbSHeFL52NJKHJQB7TIsiDr/n2kVEnFSLZbThUynkkmIjHgKSelMtZqmHrNxSgZsGi//
aiboPDwglwopXSgWJ6Z2Bhi/rN5at8Ck3aaObyhKqZr/x5zoaCNlIlFKbar0RR3CLMF7xkUe
QaAq5AxCPd3QdQMp+c2SXVPCGsKqzFv5BDmhYJtcyTTWHbUqDJguLLe4E/TUtHOht3fAnSBx
b4sWLkBSCw00yQl/dE3mME1qf9VJRPcCRqueIkTanJyc3vMFYQH5tg0zD1hOTk9gSjz/rLKS
lj+7RvXGBA5OHQ6otaOzyselYpkQKqVabTJRYwuNQe0Bomq6xFPqbGdei4WQYsJcIDAHKJT4
Bob+VNTGxBCnkVCUPBMLQv6cKEaqtXXKJuRkkg0hbZFG1ijtx9QatMX6FTq/2AEwzqLtWqCe
W5FYBaKv3fIFRjxX7ABib2KsEn/GhgmUzqOsv8C8FYbm4alkYYtp0G+nkWrUCxPyBng4gMgE
XuRiDpHukjtuKC3As5JwXp5kmwqaxt08+mcy7QyqGs7238Vu+Vxo3jd5xLkVlVIIjrEIyPnd
45MeyplB8pQclUVu4MSTjhoqlE/xuMw2PdIu+4CfKC/JI5naXnQsrLl2wDjqY5BIAOLjeY3N
DSaM4cmuzBewZRpkkg03TQY6JG1M4zCGeG6WCw+6QrFdmAsrcyaydCuLh4Fzd2ve5rHlfW8G
WUsY202CcuxkISWj9HFi1kzJlzrMxQEyDARHxkQ3IgPOedoOKr/gWJGBLC1mPD3P23GjTerM
ShLGaIR0iD/yhWrIcyRwHYL4iYYR4W5MkBq4XLAoHDwGtEak2h63ISKa9Ikhl6fsnBTz5pjG
zx6ZOj8Ua6kf4x5C+4+gtR3ym5vFKpZGpWFpzQUMATK0h7cBlrMVPfhYz0Q5Y4exYcaIE7kj
dlXDjEN9N+CkryrEzIA+dWARoU9/xj2g41QnbcT/A4396WuNmQAA

--u3/rZRmxL6MmkK24--
