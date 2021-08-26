Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBAE3F8988
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 15:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242826AbhHZN7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 09:59:09 -0400
Received: from mga04.intel.com ([192.55.52.120]:28430 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242755AbhHZN7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 09:59:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10087"; a="215898819"
X-IronPort-AV: E=Sophos;i="5.84,353,1620716400"; 
   d="gz'50?scan'50,208,50";a="215898819"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2021 06:58:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,353,1620716400"; 
   d="gz'50?scan'50,208,50";a="516629474"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 26 Aug 2021 06:58:17 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mJFtZ-0001Ii-1K; Thu, 26 Aug 2021 13:58:17 +0000
Date:   Thu, 26 Aug 2021 21:57:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Woody Lin <woodylin@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Todd Kjos <tkjos@android.com>
Cc:     kbuild-all@lists.01.org,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] ANDROID: staging: add userpanic-dev driver
Message-ID: <202108262128.xSDRVTrK-lkp@intel.com>
References: <20210826092854.58694-1-woodylin@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <20210826092854.58694-1-woodylin@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Woody,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on staging/staging-testing]

url:    https://github.com/0day-ci/linux/commits/Woody-Lin/ANDROID-staging-add-userpanic-dev-driver/20210826-173040
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git a69bbd2f77a6e26b2b1c3d7fcc5c715169dc01c5
config: openrisc-randconfig-r032-20210826 (attached as .config)
compiler: or1k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/89dde12be7959a5a75172d0609d344f104d80070
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Woody-Lin/ANDROID-staging-add-userpanic-dev-driver/20210826-173040
        git checkout 89dde12be7959a5a75172d0609d344f104d80070
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=openrisc SHELL=/bin/bash drivers/staging/android/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/staging/android/userpanic-dev.c: In function 'userpanic_device_ioctl':
   drivers/staging/android/userpanic-dev.c:21:34: error: implicit declaration of function '_IOW' [-Werror=implicit-function-declaration]
      21 | #define CRASH_INFO              (_IOW('U', 179, struct userpanic_crash_info))
         |                                  ^~~~
   drivers/staging/android/userpanic-dev.c:52:14: note: in expansion of macro 'CRASH_INFO'
      52 |         case CRASH_INFO:
         |              ^~~~~~~~~~
   drivers/staging/android/userpanic-dev.c:21:49: error: expected expression before 'struct'
      21 | #define CRASH_INFO              (_IOW('U', 179, struct userpanic_crash_info))
         |                                                 ^~~~~~
   drivers/staging/android/userpanic-dev.c:52:14: note: in expansion of macro 'CRASH_INFO'
      52 |         case CRASH_INFO:
         |              ^~~~~~~~~~
   drivers/staging/android/userpanic-dev.c:53:21: error: implicit declaration of function 'copy_from_user' [-Werror=implicit-function-declaration]
      53 |                 if (copy_from_user(&crash_info, (void __user *)arg, sizeof(crash_info)))
         |                     ^~~~~~~~~~~~~~
   In file included from include/linux/printk.h:7,
                    from include/asm-generic/bug.h:22,
                    from ./arch/openrisc/include/generated/asm/bug.h:1,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:15,
                    from drivers/staging/android/userpanic-dev.c:11:
   include/linux/kern_levels.h:5:25: warning: format '%d' expects argument of type 'int', but argument 3 has type 'long int' [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/kern_levels.h:11:25: note: in expansion of macro 'KERN_SOH'
      11 | #define KERN_ERR        KERN_SOH "3"    /* error conditions */
         |                         ^~~~~~~~
   include/linux/printk.h:390:16: note: in expansion of macro 'KERN_ERR'
     390 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~
   drivers/staging/android/userpanic-dev.c:61:25: note: in expansion of macro 'pr_err'
      61 |                         pr_err("failed to strndup .title_uaddr: %d\n", PTR_ERR(title));
         |                         ^~~~~~
   include/linux/kern_levels.h:5:25: warning: format '%d' expects argument of type 'int', but argument 3 has type 'long int' [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/kern_levels.h:11:25: note: in expansion of macro 'KERN_SOH'
      11 | #define KERN_ERR        KERN_SOH "3"    /* error conditions */
         |                         ^~~~~~~~
   include/linux/printk.h:390:16: note: in expansion of macro 'KERN_ERR'
     390 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~
   drivers/staging/android/userpanic-dev.c:69:33: note: in expansion of macro 'pr_err'
      69 |                                 pr_err("failed to strndup .msg_uaddr: %d\n", PTR_ERR(msg));
         |                                 ^~~~~~
   drivers/staging/android/userpanic-dev.c: At top level:
   drivers/staging/android/userpanic-dev.c:83:21: error: variable 'userpanic_device_fops' has initializer but incomplete type
      83 | static const struct file_operations userpanic_device_fops = {
         |                     ^~~~~~~~~~~~~~~
   drivers/staging/android/userpanic-dev.c:84:10: error: 'const struct file_operations' has no member named 'owner'
      84 |         .owner          = THIS_MODULE,
         |          ^~~~~
   In file included from include/linux/linkage.h:7,
                    from include/linux/printk.h:8,
                    from include/asm-generic/bug.h:22,
                    from ./arch/openrisc/include/generated/asm/bug.h:1,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:15,
                    from drivers/staging/android/userpanic-dev.c:11:
   include/linux/export.h:19:21: warning: excess elements in struct initializer
      19 | #define THIS_MODULE ((struct module *)0)
         |                     ^
   drivers/staging/android/userpanic-dev.c:84:27: note: in expansion of macro 'THIS_MODULE'
      84 |         .owner          = THIS_MODULE,
         |                           ^~~~~~~~~~~
   include/linux/export.h:19:21: note: (near initialization for 'userpanic_device_fops')
      19 | #define THIS_MODULE ((struct module *)0)
         |                     ^
   drivers/staging/android/userpanic-dev.c:84:27: note: in expansion of macro 'THIS_MODULE'
      84 |         .owner          = THIS_MODULE,
         |                           ^~~~~~~~~~~
   drivers/staging/android/userpanic-dev.c:85:10: error: 'const struct file_operations' has no member named 'unlocked_ioctl'
      85 |         .unlocked_ioctl = userpanic_device_ioctl,
         |          ^~~~~~~~~~~~~~
>> drivers/staging/android/userpanic-dev.c:85:27: warning: excess elements in struct initializer
      85 |         .unlocked_ioctl = userpanic_device_ioctl,
         |                           ^~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/android/userpanic-dev.c:85:27: note: (near initialization for 'userpanic_device_fops')
   drivers/staging/android/userpanic-dev.c:86:10: error: 'const struct file_operations' has no member named 'compat_ioctl'
      86 |         .compat_ioctl   = compat_ptr_ioctl,
         |          ^~~~~~~~~~~~
   drivers/staging/android/userpanic-dev.c:86:27: error: 'compat_ptr_ioctl' undeclared here (not in a function)
      86 |         .compat_ioctl   = compat_ptr_ioctl,
         |                           ^~~~~~~~~~~~~~~~
   drivers/staging/android/userpanic-dev.c:86:27: warning: excess elements in struct initializer
   drivers/staging/android/userpanic-dev.c:86:27: note: (near initialization for 'userpanic_device_fops')
   drivers/staging/android/userpanic-dev.c:83:37: error: storage size of 'userpanic_device_fops' isn't known
      83 | static const struct file_operations userpanic_device_fops = {
         |                                     ^~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +85 drivers/staging/android/userpanic-dev.c

    82	
    83	static const struct file_operations userpanic_device_fops = {
  > 84		.owner          = THIS_MODULE,
  > 85		.unlocked_ioctl = userpanic_device_ioctl,
    86		.compat_ioctl   = compat_ptr_ioctl,
    87	};
    88	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--zYM0uCDKw75PZbzx
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICMiXJ2EAAy5jb25maWcAnDzJcts4sPf5Clam6tXMIRNJXpLUKx9AEBQRkQRNgLLkC0ux
lUQ13kqSZyZ//7rBDSBBOfUOic3uZmPpvQH6999+98jr8flxc9zdbR4efnrft0/b/ea4vfe+
7R62/+sFwkuF8ljA1V9AHO+eXv/78PyyfdrvDnfexV/T878m7/d3l95iu3/aPnj0+enb7vsr
sNg9P/32+29UpCGfl5SWS5ZLLtJSsZW6eve8n/79/gG5vf9+d+f9Maf0T286/Wv21+Sd8RKX
JWCufjagecfoajqdzCaTljgm6bzFtWAiNY+06HgAqCGbnX3sOMQBkvph0JECyE1qICbGdCPg
TWRSzoUSHZceohSFygrlxPM05ikboFJRZrkIeczKMC2JUnlHwvPr8kbkC4DAfv/uzbUEH7zD
9vj60knAz8WCpSUIQCaZ8XbKVcnSZUlyWBZPuLo6m7WjiyTDMRWTxnRjQUncrP5dKy2/4LAr
ksTKAAYsJEWs9DAOcCSkSknCrt798fT8tP2zJZBrueQZCv53rwZlQvJVmVwXrGDe7uA9PR9x
jR3BDVE0KsfxNBdSlglLRL7GPSQ0ctIVksXcd6JIAXZgYvSOgwS8w+vXw8/DcfvY7ficpSzn
VAsIpOcbYjVRMhI3bgxPvzCqcJedaBrxzFaDQCSEpzZM8sRFVEac5SSn0brDRiQNQNo1AdB2
KJmRXDIbZs4lYH4xD6WW1/bp3nv+1tsV10sJqACvR82HfCko2oItWarkSSSqNgko0TqqBaJ2
j9v9wSUTxekCbIDBphsaDeYV3aK2J3qvW3EDMIPRRMCpKXTrLQ6T73GyWPB5VOZMwsgJmIyt
VfVODabbmlQWNkuCX13rATDaChhk3E0CgUWa5XzZGpoIQ1M2NrfmvSxnLMkULEK7oM7yavhS
xEWqSL522kZN5dio5n0q4PVmQTQrPqjN4W/vCKv3NjCvw3FzPHibu7vn16fj7ul7T2rwQkmo
5sHTubFaGaB5UQbGDXg1jimXZx1SEbmQipi6hSDYsZise4w0YlXD2gVrKBfGpFxrl9zaSslb
mQRcEj9mgVMnfmF7Wi8NG8OliEntKvT25rTwpEv/03UJOHNO8FiyFSi6S3ayIjZf74FwHzWP
2jQdqAGoCJgLrnJCWTu9eifslbSebFH9Yvi2RcRIADZmRioMS2AhEQ/V1fRjp5A8VQuIVSHr
05xV2yfvfmzvXx+2e+/bdnN83W8PGlxPyYFthTHPRZEZc8jInFWab/o4iEJ03nssF/DDCP2a
UylpxIyMJCQ8L50YGoInBF96wwMVWfJV5gvu0FgRZDyQp/B5kJBT+BAM/Zblp0gCtuR0JD5X
FKDOaGmnSNB9nUAnXLr8dTsDCFVGZBPoW2oUUcTcOUxNIPKBA3GxixhdZAI0Cf27ErkRBvRO
Q7aghGZsINYSxBQwcImUKFN8fUy5nFlCRLfkmIUfo8ta6gQrN9jpZ5IASymKnDIj+cqDcn6r
U4eOe1D6AJo5BgBUfJuQjjMAVrfWY3wres/n1vOtVMbMfCEwFNjGC3muyCBE8lvIcEWOYRd+
JCSlViTqk0n4xTHniCxZWfBgetmNUHm47rmH1rkIZH6Gjco5Uwn6+C7AthOppFUjHDMIq6xm
mL8O0wDLJ5kvgJo6tdwnkImFhT1uiw0LKLAc/FkmzBxB8nlKYl3rdAEN5xYGrpcx0bKJZQTe
yp0kc+FgAYGyyK3ATYIlh5XUmygtb+iTPOemMBZIsk7kEFJauU8L1buEVqP40rBMFLEOv2aZ
t6CJZQ4wPguCEV+Z0enkfFAD1OVvtt1/e94/bp7uth77Z/sEEZtAzKAYsyHHM4PIL77RDbxM
Kjk00cTtqmVc+JWPc/ksKOiIgoTZUjQZE98V+oGTTSbcZMQHkeUQ5urMps9bx4WYS3CUYBXC
rTU2YUTyANIJly7KqAhDKFN0YAVpQzUKztdypIol2pdjjc5DToldRFWltKWLOvPQztyqYexa
uiEWGUtziDGG+4IUzEfFSQNOjJGSxMhxmtIlumFQFNjlBxeZgDidkKw3JyyUwpjMwdkUGdI4
SiFZGGkD5LR0Ub06eANrJogwBkIrZLZ/vtseDs977/jzpUo2jaynWXQ+XZTT2WTSsYOaC+Jc
eZNzxVQEgW4edchmk3RfAPLGMlA+BqEq+X/YHA4e5x5/Ohz3r3fYLKqMo/+2duU8BZUIw6lT
cVyk8dShOA5C8PqOGXf4gC9NdXBP29DhJHNOEcrE6WQyhppdTFwx7LY805vd4+KmvQJax5aA
ZskMwmReBnL1C7snIxKIm3KeOUMUTQLdnWqkGGy/vn7/DqWI9/wykOCXIsnKIhMplKJVMAwg
BoORoS2ekg6D2baEGASrTMuUg2PgBnVKl6322GZ/92N33N4h6v399gXeB+drrKSRKQN9MsKO
3idsnFT2GQmxGJokKIJuDJRgFlCUGDEPX8SOHmTSmnWRaiMaI6ExI/kY0dnM57q0L5Xlcso5
URHLUfrgcOdG9IuVaKr7hlwERcwkxsWSxaGOmIannCssUcsYAg9EaKsxCHGkmgCmDbYrhIFZ
CH6XY7QKQ2l7IDOKybZrScXy/dfNYXvv/V0Fxpf987fdQ9UHaLUKycoFy1PWy34ah32KTd+r
v6ECbQaLfgKSKmasQ2cXMsHUY2pvJWZWpc5d1WCXTWuuqYGSYhFK3MlGTVWkfYoOX3diXcyh
Um+67u40tZtyf67NMuhAVzSmlw4bGHAhbj9t08xm5yfno2kuLscHOft0/gvDXExdNY1BA4YW
Xb07/NjAYO8GXFDPc2wfodGcGq4lxMrqlwhXt+MTa4nqyqnPBLOeGyxzJSQxXZVa8gTDust1
w4u6BQ1Zk4L1fjh83T19eHy+B+v4un3XdwYK0jDQSbEorLTYR+t1MCcynRoZdlodYkDk4anW
XLroOS50NrpPH2gipJDjJPlNQ6A9Aftve/d63Hx92OojKk9nz0cr9vg8DROF/sxdQFVoSXPu
7FfWeGwjXD0axSeU+EHRD/G1TxmblZ5Wsn183v/0ks3T5vv20RlmIMdTVvunPqcwG3tNRMpi
8LqZ0r4U3K28OjcnCZ6ZjsRYnTLnDJXEyn4TPs97g8APVdm5MPLchTRm2PQxE8hagQX4mCDI
r84nny/bxJaB+KDs1kFhkViVPAS2Kqo5Ew2rDQOPw4pmiA3dOQupinVjaQAiEJblVdsQvM2E
sBzarV+43O3tWShiyyJvdRAQ1Dk1nQLoTcdcYTHSIWY5bk+vFz0vsubYrdWxcTXqNtwIOnLh
QyKlWNqEB62L6fb47/P+75GsDXRnwVw2AVa9AmMwnsB+LIlqGJQ/bimtgky32phyl63gMFzD
AhTPNiFVAqnlhh8BBJhAhse+4AXDtYXRr2TRWqcmsLFJVql719hjCipANdKqBEt0udDcdoY5
D+Yu5V3GJC0/TWbTa5O8g5bzZZ6dfK9MlvZYAaO97WlRcUxnI4sgsctZr2YXJuuYZO6jziwS
bpFwxhhO88Jo8nWwMo3rX3TDDfY/hYmYIxq0lUK4wyWhFZFbKdrmt1be69ft6xY0+kPdmO8l
jTV9Sf1r51gNPlKu/kaLDe1w0MCz3NnvatC6sXjdmU4Dh1ji4iZDtzg6/PWJwRS7jnt6XsF9
dyTsdsZtlQ0ezOXUqAT3wLZNhM9zs2RpoIHUluxYO/wcaSm27+Zui203+/oNaYBP1HMdiING
YsGGk70OHaKjImDxEBxej2EoAd4O+uF4URQOCTPOXEKF8QBzcj/A7WEeeZImi52twk700iWr
OvgP+qC6RbL7trvrXQDC92gs++sAENZS7vP1Gq8oTwO2sjcLEeHNEFaczboNrAH6NMGI/zV0
GFAQk8tlZouggV4OwSHk4UNodZrU3zW91GzMjhpuLB/yS/Bii9XlRgzTYBes6gEa93gMFDUv
/xjw1F+rgZbVONiskVnXBAlTxMlV3/UabDGhPSAAykzEnLL+piFmTuhIaqDRCc8rX9qDSwj7
MRvCUyjMB8AML7i5Bpd8pKfXEix81rsUNKCBibhy0waNkb+/9Qgf15Z6YKjXhkvhoWPRqkhT
FpcLth7i5kT13gAWmn3lp4eIoQutEY2pWjhFm1R06O9CHhqBI6C+8ZBKPFgVeNXMlIwP6RnB
YmPpSqLqHNNKvWrYIDnt46HizXxCrbORJYdaSbQ0rtdtiu4aUbdUKIcXenRzHSeUIpXWAX4k
cwfhda4MX4FPpUysnELDQPJO3dTIJOKnDtJ1ku0OqAZFlYL3In2+Kv1Crkv71NHX6YlZh3jH
7eHY5Gt1nTNA9RBm7WLsEklyEtiT7RZEXPWwb3gCH4/FWGAcJAEkD1GalvYBWcpc+TtgIh5k
FsfIUkQAxO54rTEjdy8Al8gQPekYmgiZ9dAd0ryZ10Eli0MsLwfx23943R6fn48/vPvtP7u7
rXe/3/3TnFwaC6PcV3JstyuCJfxzzynJl3FvUxFUnmKYqEUfbSELkqsez2sQHpjEGMfKcJ3d
nNFd6Bjc8JzFvdyqRuXhgsdGGlg9QzJW3frtbl1U8Hk2mrJ+HmQRnzPHvG1874ILJTy02ljw
fKqdgmjgFDCXf9XYQvqGhw+p9QB+bs6x5DMnDuDUqQyIATWxOcgoiGnnJzZ7L9xtH/BM/PHx
9alOLb0/gPTPWj5GI00z4InNMUsvzs8doJLP6AB8duYAuSlnZa12BjzhNBf61McNHnKSajaF
n8QNrekNJ/hLG9K2l1x5kJUjxDdVdmCqZkh4LJYj/RGmIiVE3ES2gQ8JKpsJWs/RTIVSklvd
s4wmlJMBg4y+v9vs772v+939dy3c7uhud1cz9kS/h1pUB0sRizPz6ogFrhvgxk30pUoysz3Y
QMqkvq5awyGpTgMSD+/Gau4hz5MbkrPqGvxgReFu//jvZr/1Hp4399u90fe90Yc/5nzBleek
ZYhz7cTSUOt7LPWS3NeAWsrmMMHp6PrzauZwQ1Kl75U1TW9zzdXxg4l1TkH7GCjZ+Zge1QRs
mTN36KsIME7VbCAhTEAtHY5EExG5TmlDWl25b7W8vS2RFfUlREPmOZtbVy+qZ215fZiMeQKZ
jeHda3iW8AHxzXQAShKzVdIMZN6rbxhSarhZfV4cgT4EeFs1NPUFUSFLadVlZoP7K0OLqSL9
68Hwnp1wc/wKRTE8ERB5GbsbMr6almOdQ41buRPLiEsOdZ5Iyzhz98wxaJfM585zu4hjVmkc
XFSANuR1AdxYnHk4An6OwrIcvOepNISKT5Ak5ZzEPWCCF4ddCMnz0I0p/NUAkajAetAKjBOo
HOBmf9xpp/6y2R8sJ4q0JP8Ifiy3OzOI8GlyebZaVUjXBgJNfYvDzUCEw3ctAv0dSF7yhMyh
6HenEAadyt3XTpAE1TmT8cnJgr7r+6LNZB2oABIxlOm6Op+8ej+1h7FYlEVaXxkbud03fANj
tkjjtdN/DgWl5VfAr17yjHfEq+t8ar95OjxUcTre/BxIFCrPgSxweI6ncmDzCZG904rqlj9J
PuQi+RA+bA4/vLsfuxcjXzdlHnJ7876wgNGeh0Q4eMm+46zfx4JbX77tXzWo0amQN8RVFzUE
PsTGtWIlkrkYxAZ+VDRIOGciYSp33YZGEvSdPoGCW1+ELw0P7MDOTmLPbSwOzqcO2Ky/HqFO
7QS61xjbIcM9TgLZdwwIh9yDDKGF4nHPJkjSA4gegPgS0hUznzyhQ9Xh9eblBSvuGogn2xXV
5g5vWvUUTWCyucKNxDO3gaZk0VomJ+Qr6cVsQoNxAsg5Nc0ogZIXF85Lcnr4mKhqj7pD1TeW
V30Osn349v7u+em42T1t7z1gNSyPzVVkeGtLJrxv0jKG0cfmFg2kB//6MHgulYD6St99t07b
ayzL9d0kxE5nn+qMfHf4+714ek9xYYP03JpiIOj8zOnr3t6EqmCDNNneDoToVNFeHTg2xDiB
1c3ddXW31La4hqL53KgfwWo0lD2ycB64m1RgqG7usxX6wTlu/0/bwm7KetaVB978+wFc/+bh
Yfugl+59q+wI9mn/DNC+bmjuMDf80EyR/uyrSYGFuA91W5I6dp4mwhslb5AkJF+ykS8JusFi
iuna2Ww1Hswrbr9K6Oc00Zt1kkqsUjKeiWiSEPIHHrozyZZoGV5OJ1hTvzH71RsEMirDmKo3
disgS95rdgyJ1Gr1OQ3C5I0RQ/kWBej4SKrdkmDOfTEZuS3XEGHa/cb2KNd1AmP3hrZYLRVL
iTcWoZKzWQm78YbWJ0w67zW1BNhKc04CHT9eyjzNn0LBnFJXednZFHhXkjrH0GG9jOfWIFUI
3R3u+n5Wv4L/ST4WESp14nIhUv2t9+MJZJW1YZKG30wFttMaow2wL9D9AYNxUvyK+TRL31eN
r65u6VEKceM7RArv8Pry8rw/OtwgM/+0gwmFJBD7+Yl9S81NAHGW9tMMk8zvf+bf3NhzzLDt
sWEM0+uIM9gl73+qnzMvo4n3WF3DckZ+TWYL6pqnoWiT6naItxmbTAq/l8ADoLyJ9f1yGeGd
tF4moAl85td/02E2sTcIsSHUFKdyMaSZxwXU4iP6Ga0zlle9kK7A9xMK4e3SeXEnUIa8RWj+
jtfHVHvhrQNDtYZfjrjqQ8DirUm8rGpxgtwrXrtRC+F/sQDBOiUJt2bV2oUJsxo0Aq/JQ3W7
xMLMvLNZIfDE0oJhIzUma6ttCOFb5MPjl3SZME+2BtMppAlvfYqzfxNczC5WZZAJ14FQUCTJ
2l4Np/Lz2UyeT6amHHXuUErpDj/gJWMhi5xhX0P30ka6PZfns+nycjLBIcfbPVRAxBxLQzQF
6mqeuW6JkCyQnz9NZiS29JDLePZ5MjlzvFGhZsaHTFASSZFLqB3iGVQPnaU1CD+afvzoeEEP
/nli3E2JEnp5dmEVhIGcXn5ytbOklV2u8JO0VSmDkBnnA3RmfqnFGPiRZOhRKzgIbXZujlyD
YzYn1P1HG2qKhKwuP328cMyxJvh8Rlfmx7QVFIrk8tPnKGNy5RiWsemkn3Y0vtdeR/VHO7b/
bQ71l1WP+jvIw4/NHgqNI/ZOkM57QGd9D4q/e8FfTQP5f7zdTbgRZ8ylPuhxbhXB+6IES/HM
9SkFo5GwLHyZkZRT5/It260KTCp5U00NpItIvJtvNjhdL1R/jIYx5k3PPp97f4S7/fYG/v1p
sOwOCHjO8AzTOcGTTKwDybqVPnBk/Onl9Ti6ouoo1DRXBAzOwC1kGKKzxSPXzjoqTPXHaRbY
wR+wTKDg56tFL861TboH/EBsh1/afttYx4j126KQDJbo4Ftj8HytcH1v3SOTFGJRWq6uppPZ
+Wma9dXHy082yRexds6CLd3HtA0Wu+KPpkDGa//qlQVb++L/GLuSLbdxZPsruey3qFechyVF
UhIrSQkmqBTTG51sO/u1T7ucPnZWt/vvHwLggCEAauFBcS8xDwEgECh6zPZdSqykk8FPVgaB
ohHPQtZnCH4bZSbsniskMHDK0bB/ibpRuMCUzdpkYBMXrruYPKYjMj3FmZLymUyzPhIQN9/n
14OdYdRtwdYAslGeiYmkWPJVwxKiwaY5KS3nS3l8bAY8iD0454J4nGHMaVCA5YhCC7Z8Lohl
AXcW1waLkz5qKoQnOo6jsoHJxcZiTaRiqTM8yKVDUPAKtOZhltyKU8GajxzwCoX4jsNKqPCx
XyJgyvACl+ddX6BRH/YBtnxe8b4h+IcMuHXYdvJKuTRtW3fnAQ0AlqU9bkK5cGhTscngVMnW
pws4dFWJiBtxO9AG3IIwQNNzBdcOZ/xEeCHB8VLbokZba6Lhztu536GxcHBXWHTKlQYXoWrs
PHDN/rWp2A80lo/H+nS8FK7PCxp7vo9+DaP6xV21H65NgxX+njZFsjMnBH5dFzcUmwgweoiJ
xsGyeNDpuybSNnK5SLFo4RI2wGiSvSc535olfMw5a8ygmhQyne/7hiTQJaFnSBSVeJJhVSYg
+VrLJIln9fv48uMzt5Zofj8/gEaj3BNXcsJ/MoVyp82NQt4XV2w9wLFJz0S/Y8JOs7pXv+1L
/MOCQELQGheEc0vYup1QfDtAcOjlFDU3dzgwqOuUiXDRiuhQdPwqoim5nWgcZ4i8jeQtFKw6
Fg0W0z+FvsPWBS+fmMaHrZ6HATtWFDMjt3hRTD8a0iH+C7kUNhxnf1KKHBYF4ga8cilqxdhC
F78oyDlC3xaD+r6Qb2dzmCpHTkJEG/zyD0e508zqjB/ki1TBpYTzHg+joATueD7CdA3knWW/
+kTKLh3HbeIU4G5AaWu6do6SOF4nRzNrTS0i4eSoOcO+DYLuiij0MaAZSTSOGCLMMTGEb2tj
AN/HRoHhERPX4/PpTDEEyhWTMz2eDmCqhmBlOfQnRUFasbEhx7rHRkdW3Mpe11CyP0QXNFTM
D7rUpLE541b2sYcjfPsJhxomOdVy+cno6fJ0HmTzewCfWEJhB3ZU9uDmz+gQhh9JEFlX/iNT
r5619cPqE8YYTpbZY2pw/YUO3OvZYugnFmQsNnNhLFucQX74agx2kJXRAsqOu+DAOgeA3H/S
kxpUdxnnuLu/vr5/+f719RdLNqSDnwsjmwS8KvqdGNX5HaT6hF56ncIXOr0eK5NC3H/q4nYo
o9BL9JwBRMoijyPMi4/K+IV+3JxYE8c1v5nT1+gQy9CqlsLAgu/asSQt7rbTWbByLJM1KrgI
VMuLqtaFvAbaw5lw8+Cl4SxTHxi6WSru2IzxsVJm4rXhcW+aD38HM7nJ8OFvf779fP/634fX
P//++vnz6+eH3yfWb2/ffgOLiP8xWgbXVKzFLIZyOzzkuKMQDo5jYw95V7IBGTy7OhmP5xM2
kHG4Lzs67NSSL8GSUF+U8hZhnugq7QV86XHbX1U11kDaFvK5gIbOB5RG3M2hKc+tZb0EDDE5
xFZcv16gtZHDkS2zKouFrqBQ/ICZD8adRXPgGOvixDaocsaZhBZTAYD/+BilGW7pA/Bj3Rnd
UIKZQqsuudWOPCSxI+puSJPA3jy7p4RpA47PR4uXA5ihhCpkaU1naENUbwVn2zkdB6/YfjQg
bNCwNizSsS5gD5Sc7Lkjo71rivMci/kDEPpG3xSXB7+wDCLfXuX0eOvOu8Zyi4ozmm6oHRFY
1sYcYtraHjeTWPHUjj+fPlyYHmrvSdwS4rYjFnt5oFxOTAFrHGHMhJtFpw/E+wjF4Cqka2cv
BnEMZYdbe9rGluSOTtGXhWnBWv9iqtO3l68wK/3O5j42Ib18fvnO9allk5ozz+//FJPqRJPm
Ln1iQmZoCd1Pi6R5pWibTpVZebjs1JF9Hs7VNgDC6fzLErugwEk3nHjr8wF3dycUaHUa4Ago
AtbiFRSbmiprm0uUoXzQCPdtmWQyNZZuHlxRMX0qUXnXkIYD4lrXuj1AsAl0ujUhsWBFzWac
MEnxYYAzOsr0+a7hyikS6pFK1hLsh6JFi50cNqepJnqr+OsXOD9cdXIIABTqNUhClA189tO8
UCfs+AmdwzN1ffisbLmPvEe+KlUimKFJIVmCmx5oefshhyjQgbDI3j79Swfqb9wvFTk+w7sW
cOJl85Hz8P7GEv/6wLoa64afuWU765s81J//qzgKGsjNj7NMPMTAZhrcyMZM05LFRcGeBPMF
nQm4GY7Um5NYwZh80Mr3l1M5G6dLUbD/4VEogOg7RpLmpBQjCbxcqfIZYUosqyB81lhIljuo
M77r/Myi58yUqshi70YuBBvUVlLuJQGWTKYL+Rmqc8yMriRBSL1M3cvVUblDzxhTwx/BBMwR
OLipk68gLvLRj2XjiUU+dPsRy0dXjClTzNxlBTv62sm7nuTHzIvNaM9l3Z4HNF64vMnt3KhV
nV5CueIrz6U1iB2uw0abmVi4Xq+zEnf7Krsg8y0zs0IK3dHx60V+ts0J7uDEd3ASfKtZ5dyT
ng0SX0zaV0ozrXw+nNgasbu4i/KEK/8rTLajOtHgjnjIJqegoWUiXQqo7pnGd9sdIsujC0t0
5sLF4LClQRBvU1I3hU3vTpwvMrgiAErAHVS6u4PakoJSWLEa03jP5tyfLz8fvn/59un9x1dM
7VyGFjbFUIvV+lICe7Zq7+ond+MGVp8VaZrn7l65Et1DihSgu0UsxDS/M8A7w8vju4n42ttM
obtfrwGGd/LujDdP7q2T5N4sJ/dGfW+z2VApVuLGALESizuJ0X28sHA32P6jxZWwRLizMKJ7
8xjdWa/RvRHf2fCiO/tuVN6bkfrO9hRtFPJK3G3Vxmk7JHpMA2+7TICWbBcJp20PUoyWbiiN
C227XoEW3pW2NMa3i3Ratt3oOM2t5k208I5eynN6Vy2kwT05HfEbg7Z50wxGbGI7Y+J7gxvq
B+MkmxzSwz3TPNsYmaf9wMDdvCbWRiOc9g4jdwVOrHvCOm4NLJzVEX+jBQ7NrTlXlrelZtK8
54itjJb9yLZyN5SFyFTtO5m0rdzTuxymuwutzNFivoJkKLF4xjWZvnvgk5gbw5CcTqWCJz/i
n7+8DK//QhTRKZwaniPrhkdzcdupj0ut4iD13KnnZyHu1sYp7mbbDZm/sbwESuBur5Bc312B
3ZCkG9oZUDZ0W6DkW2lhmd5KS+YnW6FkfrpVupmfbVM2FENO2ayAcLPosthPHIMFK7gwT+Wr
CtZWa3wK5hGF2XRLGqVtjm5sDR15SlPL2zrL5PLh0rTNrm8u2KY8LMUZKu0SCgG/cwTeoqYr
dLG/+FM97zVDh/mTpv+gvsorNhZNsu6TXhhYKCYbi+j25GvS9aVN+XmBP1++f3/9/MC3FoyB
gX+XsrlRc0DE5eIgXy5fIbYf4Eu4Y0tMsIajpa9xuGeh7Oq+fyYNuAy3E7EjfZMxHqjDNEDQ
xOG/pSnMl4DlrU4hbwlNfR9XLjijutpcInG4BuM+0jsKtLa1z9t+gH8838NbgnzKq8D91PTU
eKxH+gJtr440Nmdsp5dDcGujfCqN6JDdZ4Og+wyQ4W6XJTQdjXC7+vTRNmEIAikz2zG9INiP
+QVucQkwgbjCKkxg4XRqu8ZtR+mia2gHphpaYdYtYnApuiKuAjYAnncXfeBp9sqDiJPwPBoN
np7gFEozlNIozsyx4fM2XlHVch4DS/XBbS62OwxYYd+yFhIMGmWWKYHjzkN2znhqIGUDdmLJ
8WtZ5WFkFtkI/fFGrWOLOFw3cjy2jnGv6Krb3vJUveiR1RAGUag1c/XNEGxuWIzBuPT11/eX
b5/NOaOoSBxnmTawFNWJ6EPRlY1CldlJizENUYc8KxyMWliTdLqorHUZMPzTc2sQUmuMpNxn
carHOJCmDDLfM6qUNaZcb0zSmbpWdmI+3ldmmWqV2jcf3XNZxfLgd9cnOwWO+2LM0H5FYyM7
ptGUOhCHeRRqdd2SLI0TMyihrrkqFo7qjM/6Mh5iizorhoU2yCzmG9Ow0pHaHDUITWLPOSwA
I0us08xwbSMv1GdYJk28yDPiu3ZZ6FvDYmieR4oWbDYK3iqevvx4/+vlq662ac3lcGDjcGHx
XMiL+1zOr3VNEaIBz99wx5Q8Gv+3/3yZDF+6l5/vygBw9SfzjltFgyhTNPAV0yZJ5Fv/Kikm
K6DbWq4IPTRoj0MSK2eCfn3596ua/snc5lirFnALQjtU6VpwyLgXK6mXgGxtLBrA3QZOzuQx
hh/awkwsQBDiQYmjbDNn8E2IjYIqw7dEF9oSGIZMKSgt2QotJQLH/GhwaebZAN+S39qLbIif
ypZdaqtYVpVwn4U78JCsryQhW7CUQeKp9gcSDMsH6zpEJ2rrDJR3qLvmtHHPRuFbz441En+X
vugtp7oSWRg+iB+b5JYVTx5b9hokHmwE2LaNJNq9aZxvtGwShVZ5J+3+Uu9Nw9OJ1dfcW2h3
riQTlyl4FcMTUga4OTD4fOnw0MX38Ixz+2y2UyF3+HhXaMdrhz8WWBWCaNpPFVUJz3CwkVp6
TkRMiDcY89RnIyeAh4Umh/tuNuAJBMu7A9yUYHqol/hywFMS4BGTLI9ivEfOpPIaeD7m4WQm
wJiTSLO/LJcHKUXuW/gBls62PrA1/hPmk2am0J1092POuiLsilOxCo04dh+gNWHNaUkfVxsV
Xz9g3oZUkARn2W1/qdvbobgcaixvTN3zUy/C5huNEphFxpHAH01k0slA11T2FeaiYco8axWh
q0j7MZZqaf6QRZnlXmgWtqEFzgCowUFqfqBrMQt/CBOLGcNKKSM/CXB7sZlU1QP3b8xLKUpi
bPN15rLaj/x4NBPJgdzDgSBOzewCkIYx+kUMcWBfxFnuYWUBkGaPgDCSEQmVdrswQtIn9H0s
SxwJ/NRsTbz1igksQkeSw7mt9g3FF9tLgxpiD21xcwL6gY1GMVYOMNaHeJtYuxcyI5gFWuV5
HuPnaP0pHhI/s/ZnPuDLt2XZz9tToyzdhXCyR9eMO4Wjspd3tqLAFiyLb6wqjXw8hQoFP+Jb
KZ3vWbboVA5+bqFysL6jMnLT+RcHQqW9yJCfpu5Q8yDCXIdVQzr6iK8xACJ1I0KFsFuRCiMJ
8Oii1BZdGqPRHQfLXZyFYbUuXBmlvsWqM0ZwRXjiLw735xZNiHEQoROGkaAVBG8RkCfcYYJg
lOyvooEnivuzWTozSujFBCsq9jcMMRvTfUTOJ15QnixYjOUAnFuNmN4yE/apz5aAe7PKAciC
/cGMbZ/GYRpT85Ou9MM0C6c0GmnZD2x1fhmKocZ8Kc2sQxv7Ge2wABgUeBRbcC8MpoMV6Kdp
gvrQm2F+SlKczDwdm2Pih0gPbHZdIXsBkOREfsNukcPZCB87TWjIUqzy/igtdmIzgY3RvR8E
2My4OqU71cWhNtMv5jG00Qgotd5oV3gW602V484GV2RiVy8HRuDbEhsFgatyOcOa0yhInOXH
GUh/BH0qSJFOwOSJl8T4F4mfY82TQxYrc5mTuyYLRgj9NETGFHDQCIMKUgIcCnN3sEkSBZZk
J0nsKj7OyPFiYonNscSWJPTwxA4l7hl2wQkNwizxkejq0z7wwbuspQ92fcoGlxDLZdslmL62
wmmIdK8ujVEp2tOZPHNGkXn4Z5adcIngVmwYAT8BXQm5s3sw/QQvs9xdZnkcqK6VFAj13aAy
kNIlZZaGCVpSAEWWw96ZcxpKsdXbUHyrfCGWA+usodmIAEhTpOszIM28AAdyDy0I14WJhUOL
0GITNlPOZXkjmcUd3lo8+yzOpX5DVBd/C0/3PiirskGypSAHKToK72qwBMU2xxYGKW49TTxk
Ht5Tcguf0fn5Vu73hCLqEqF54BU7LC3NiZJLf2sIRX1PLrQ+jANMTWNA4gU+1icYlHmJa/xq
ekJj4UpZR2ibZEy7wvtaEHsJfnSlTMOW6w4SJ8x893gBk1AcWkz+tCnQvXoTU57n6uiMEngp
pnwJJEaLWcwsmUvpBUoURfhMmSVZhsQIu1gZ8gFh5Yquf0jTRdpVNqM3JWkSye/wLshYM1UB
XcV9iCP6h+9llrsLi+I/kKoqnaoNmy0jj+lOZmYZEodJiqoql7LKPYt9hMwJ0FP7mTFWpPax
qD+2LN/4EH4FR9741vzMkc3BjJ1ps4yQo2KTtBsoevd8xtkyF61/BjhXrgwPf1k+jH6503Qc
SncXrLqaqYIubbFmq7UIV3gYFPio83OJkcCOOJr8jpZR2jmzPlFUq0wV3YVOZZeWR9jxM97L
VnBMP+dAmKApHwaaOtchtOuYwotPgKUfZFW2uSFF08xyv3XhsMLNNjatmlMReC6tHQgjtgw9
MY0Bm7iGMo0Q6bErY3QcGjrie65lFycgmjGXZ6h635HIOSEAAU17R2If0ceeBj/w0ZXENQvT
NMSceMmMzK/M9AOQ+5Ut1DxwbTVxRmj91jVpMULLpjX11UUVTFDPjxKH9Yjj3iwngdTHPZow
w1RlPXoDbbnA/AfNjiGlo/ZJonn4W8Sn87V4Pl8GBBI+MrkTvFt9Ah+1FcI6k/rE3VFAINKD
JQuBG0070no79tyRBrzKO4czmblcX94//fPz2/89kB+v71/+fH376/3h8Pbv1x/f3hSLlzmk
NYTb4fyEJFYlsLJWdi5ttNMZNZ+10Ql4BJWOWBFaVe+LSyvT9RzbnmOm5/2wVrPcJGVAigtt
QdOuJuZHVGbEckwSkIQ2IEAAYVtliNe9ART76CU5mtHpZNqR9ulRDrMzfGyaHsxOzAi5mC1p
0JKd9BW329WCdcmquIXgMNVNpGzxnngbpCH3+w60uW0eLbp8I05hWxy5SZMNvZu0H67V4Pkb
yZpcgjkb2FWuoOXLmuThVgme+SvNLgY5jZHnZW7S5CHQTXoMb2x4cmVkPrlDmw489OaOYHay
6yTNJ+ruQmfzMSu7kSW43AiO21pvcdLAkqy5kxZjIteVnPHZkHTDVXE3sgGjsvg168b00hIr
3p3Hoh+sMB3ghsJGHrlvNyeFu6KwJgFcAt8O427nDkTwNihVUwz140aTnR1LumnT3Q03aXJ6
Yc3cjPcfCxtlukvkjGa5HOlOzFD5/uYoBpeAnYz5CsBGWdMy9MONgY4/WKsXzjwocHtsABVr
nrKLeE+2lNbkrMeF87tSLkLqhZmjxxxIVdpbK4Es2fLEptxbEfh6pi5d6xoDKN3dyJnShmmH
ks5Od8qPW9U3T7PVzWrgUXaF/LGcT8UsbPV+/I+/vn3iz3FbH/LdV4YrPpA5rc2AINzkH4j2
mIgcBA1TdVUzS233SbmvO7iJgR4V8q+LIchSD08ym9pvF2ozsxQUeO9t39ZjibouXDnHtpRP
sAFgpRznnrxY5dL5CoMqFtZma92tMtX7Ncj1G6GrbPJTpuSB3xO1bH8uuOUO8oJbjlsWHD1M
WdHArNWmtFjBQqWCqhti5noLGgdq/ieF2yirxYRAkyXI90molx2T+hbvPADDtabHXZiHDgp3
4SC8KFlJBzYxgedBejugL4zwCi590D3UVjMJVfd0HCBBEuR6drqRpaS3PecjGEHMNBMXRTxf
aDiOMhm6F8sJiuPR9vGR6VWENw055SBlGbRtaEKwzQeaBFh7AVBMJnpZZBnpMvxJ9AWN0Y8S
z/KOM++Gox/FqO3TBIvrP/81PmNy9MR5hbPEqE8ut3hxWgiZxSnGRMhyDz8/XPAA275ZUPkU
fBVmRhaHJES37WfQCGdevuohnYbR4ssYULYuv1himc1iFdvwSaY/cqXDxrNcEF5nvUfLZzyn
Kzae1iHKLIaPAraYVHJQXBhTywxcOGaaSKye1OGB1iU6JdImSpORQ/Zs2S+icbiLPV9NAhdp
ugmXPz5nrLeoVte7MfY8IwXyV9NFN/FC5NB9+fTj7fXr66f3H2/fvnz6+cDxh2Z+vRDZ4QHC
NFOsL0feH5Ch1ySsmvvSph8s93klGVOgiy4M2Ug40LLQFQf9vqGQZWmWGaG03cVolUXbWVzt
gQ2w78XYQCkMh2XLSyFJNZ1kvlCopm4xOza5wuRYSSGkm2UHneAlXLtdKYWIHT4ucJaMRoQg
zy1WmxIhsJqGTSQ2YYTYRv68fYD1qRkrLpV6Q2n9Fq5SavvH8OW19YM0RIC2C+PQUFaGMoyz
3FqoH7rRnEHac3k8FYcCMwvhepq4kavppUJoKltc2QsiLRdd7HuGAghS3zYd8HuiqR4MNqv8
P2NP1tw2kvNf0dM3u1U7tTxEkXqkSEpizCskRcl5UXkcJXHFsVy2s7PZX/8B3Tz6QNOpmqlY
AIi+0Gh0NxoA6NK4iPODTI0NHm4Os1/BeJYpZeNQg6WmMtvjMiCfvDLtW+5zMPl9PC1Qvxxw
YLfSF2cyg/eJYGNxyg/0o61ec7oOTC12G/AOFaMxW6xNiwsbNRV6Flu138fYANLWaXhTqAOp
IbrZh3GInnQHY8Uw1cA5xCUkMY0jO3Fixp+gT4fz6T5ZiZy6xrQrFs9ydofM8BK5jiauE8iU
uyJLazLJIIayj0rY5El+Sml9LpIRRXwHBGApDART9zP4ioR/6CIS3pTFLY0Ii9uSxuzDuiIx
eYRbp1jAiW065RXVJpEk5U8xZtud5xR/1pWdmp+5R0aTZTSIDB4cMjg+DeRpx0Xive86knpD
KD+QDOkXqUhgfK7KCgpzMCvAUvFoGWE0LR2shuNgChuxWiQRqaFaIyXweZtiVCQdu4nrjuVt
apIsicYLRhblapg2b7+exXfofceGOUsgThfL09ae204gkI902ZFtG2YCjfn8F6Z5zFI2vkfX
xDVFJdEM0YVMdWcPOMVqi5G/5D4ZPuzSOMGZ1GniV7JnINmUKK17+Hy5LrOHp5//XVyfUTsJ
Xcv5dMtMOOWYYPLCLcBxGBMYxkrat3OCMO5m3s5ymm16SmDjlhZljXnedgm9gLCytlnY7DG3
+TnKlLMRiexY4BvfXxIwbG4LtQWbwxZf4hLQOOf9l+7EUaD6TxDZKQ2G0LvKEBI0otDLiVr6
3cPiy8MjbCgunxd3r9BY3G7g32+LP7YMsfghfvyHMqTQHEdRTxOcGG4Gz5O8FFNGTBipZ3R+
eZiBfTipbShgEnp+4tzogtLfcs6IyXAv2FUpjE7aVEqgzTnyKKzag2F32pPnq+VydY4iwxnW
QOV63m8QrbxzakoVqlZvk/xGa/BuFfpWcRyQpxq79dF7FuYLfGf8rEsP6qzmCQYVNizUPO2I
xwl4tipYgwzTl1eGmYlxlNPLECcarriihLbYeqo+Vwb0dEWfhvT9ki9d/wQdTfpUc5o+ltQP
Cgr7k9SpT01jQLfVzoDp2kjvRwxExljONQ1pQD7mWsXuD0yx5zgN7Igj0h8JpyTMbwdjIhhn
JCao3NUgqR295PXztozp2xuOxrx1lSES4UgRnD9UhshovUAOt7C/S9dVc5IzkuXxXM3GHkpY
XtwsnFVP/aVz4tDnzb34TybaeffblO+0WiTNt3OaCe/1kxxUST3X7oFffwmhXC5oEzqFPWRq
yH430ey7OTFBijjJ2jmaQSts49npPpB9mBWBkVk0V/GBqpvXMKMmqndzDWhR2xtECCYkM/z6
2SgTyRagGHGOg+6e7h8eH+9efhEXr9webtsw2g82YFqzaGucdnH38+3652hS/PVr8UcIEA7Q
OaumBdtTsWskxjr8+fnhCkbq/RWDcv1r8fxyvb+8vmKCLUyV9ePhv1Lt+n7p2CGXugq1cegv
XUfXoIBYB4a0CD1FEq6WtkftiAUC8b1xPz+ayl1aGjhqXFfO1zTAPXdJ3XJM6Mx1Qq1hWec6
VphGjrvR1e4hDm13SbkSc/wxD3z54dAEd+nYsP1CXzl+k1fUmVM/CXGnvmm3ZyASbd7fG1Se
3CVuRkJ1mJswXPHgh1NMe5F82p+ILPT9BD7RNhtBDO+SGxF/GZgbj/iV/PRMQuAeePbjYOmo
ctOD8VNVBjYYQFqlB6C3IihXK5XyprFsMX5KL75ZsILKrjQEdL1vi/FuRfBJk088EYapp/fF
gJntjLarPHupc0Ww7Dw/InzLmjOH2qMTWPT7qYFgvSZfaAjoFdEcgBuO94cpc3LpB+V9h4en
tcOOxwXhxTlxJ00ZXYxZz/tmaYxOjhf0gRLFnSc5Wy5PxgnnE1LCwIFHCavtazLCwSS1u3Qp
anftUtSebetj3yNUedKo1m6wpgLB9vibILA1673dN4FjEX049pfQhw8/QKv95/Lj8vS2wPzc
xJgdqni1tFybOgQTKXrtIxWps5+Wy39zkvsr0IBaxQNjQw1Qg/qes6fNg3lm/N4zrhdvP59g
1Z9KGG4yFRQ3Lx5e7y+w/j9drj9fF98uj8/Sp2p3++7MJMw9x18T05++ORnMQpYCNbYc6XDd
XCterbsfl5c74PYEa1R/YqZNjrBq0wJP4zJVhvep5xHKAp1iLfoyZSKwqfesAlpT+Qj1Agrq
L9WKIXStGScAde01WV/Xna2O6xFmRNlZTjirFMvOWZGxySa0t1brjtCAGH0Gp73ERgJ/tjRv
tdT6hEHJxgGc8rIZ0Bi/gWLmWzQz32z9IXrtUS32HUMos5HAJ72SRjTZYn/lU1Cfog3QztCg
a5LvekUt2gD3Z6Sr7Gw38AJVCrpmtXI0uc7bdW6J3h8C2HX0jkeETUZuGvEVjzGlglu6mNa2
NdsNwJ1l2yTYJaltnbqpLdeqIldbVYuyLCybROVeXmbquSu3NHz7jMk19COlOIzyGTOF47Xa
1R+8ZaHX2btZhdqehUEJixDgyyTazWwqvBtvE271L5M2SG4CciWjFTjT7RnA9F3uYCZ4gUPI
anjjuzMTNT6ufXupdgNCV8SeD+CB5Z+7KCerLtWP1Xj7ePf6zbgKxZW98ly9GPTVMOTUGglW
agqsvg5yiXzhr1J9+R5WfhWn3Ecdiun6KPr5+nb98fC/y6LtuLmgnTUw+nOT5lWmXYdyHOzf
7cARFa2CDRzJJ0hFSs5FGl/fNmLXgRxZSkInoeevSNcEjcqna563jqX4ayhYw4hqZAbPS5mM
DjCiENmuoTs+trbktyXiTpFjOQH93SnyLMswOqdoacnRCqTanDL41KPu7HQyvzX0cbRcNoH4
kFrChmBjicGmdPGQfBoF7DayLOUZgYqlzmQ0Ine2cIfGJnP9to3AQiSdlcSWBwGLCGMZ+q09
hGtp8ZMnq2N7BqFO27XtStdBIrYGhTt3IT4OqWvZ9fadNnzM7diGPpSja2kUG2jlkl43CO3E
1FZ7vT6+Lt5w+/yfy+P1efF0+Xvx5eX69AZfEle0+oEqo9m93D1/Qx/P15/Pz9eXN3EThBcd
aXXoXLMbbFxLawbfAQJsWhumvZwA5qvIC6yJi79+fvkCajpWF5Pt5hzlMQa3mwYYYEXZpttb
EST8ndb5MayTM3RvLH0Vwf/bNMtq7pAhI6KyuoWvQg2R5uEu2WSp/Elz29C8EEHyQgTNawv9
mu6Kc1KAQEiZbgC5Kdt9jyH7HkngH51iwkN5bZZM7JVWSJfhAIyTbVLXSXwWT66xmDC6ydLd
vlVqiEHHz/skq5Tj/YmiTTPWatiY7oYFVxr3b3cvn/++eyEjxeIwzCXVAnxY04csbFiZo4gJ
vdvQEg2oqqspvQgYjECAc0G4N8W+hBnMXqTIvXPMA8+i94GItQ0hdrDXctI/FotiPuVi4RgF
a3dql54lmYnYQiJY8YTt0hoUaCbxyhPosaLME1US6zKMm32SUDf1WCvFMkJQA31i+QojduVP
61b0c9Ou3Abrj9IUTFI2d/ffHx++fntb/N8ii+LBl4hQZoDl/jW9yxvRklHMJcKpWRP+po0d
z6Uwo0OyhqmOOfXB+IRrrOmE4y+CMzK07UTVO/cSRYIpHgQry4jyJZERqjoXNX3kwB8UUszR
kHdZmFYataaLzarAI13yJRJfDNIl1Dks4lJOUjghh/cVs7xHJ32ycvxN5iyD/mWMXunOcyw/
qyjcJl7Zlk8JBqi2U1QUFKp30SXLSmLxXPGd+TF8v4/ZA7VhqpS7Uv6FQWYPJ9D3BY3odqG9
IjFRdgCzXsp0pJkcU3c35aGINYNin8bCjB6qnMZT++HHlCKhrZNi1+5FSQB8HR5JxXNA7hQC
efYJLbQaNc+X+4e7R1YzbeeOH4bLNon20ts9hEb1gZJvhqtQhUotCg9gSWRKK5PsJi1UxtEe
Q6IZOEf7FH7dat+UB/q1AyLzMAqzTP+GWa6mcm4rWBkbub7Q77uyqNNGaNsEO2+FuNRInuQN
wiQW6EZb5grs002i1W6X5Ju0ppQlw25rhckuK+u0PCg17tIuzOJUBkJpbXlgIypCb5URO4ZZ
W1Zqvbo0OTZlkdKmCqvJbR22KZlmBdEpehLKJaVtohbzIdyQ3syIa49psQ81ublJigYss9ZY
chbxFC9S2VzHSICi7EoFVu7Sfg4QUPxRSR01YrbUngqx9SHfZEkVxg4XG+nT3XppnQ1pehB/
BOsla0wUXOR3aZSDOFCmASfI0DySG5SHt8x/V4aCDc1kXKFNo7rE4EkKuERXrORWgR6yNh1k
TqpoYfB3R1xZt8mNEQtrJAb0ArE3TZIqacPstjipZVYYCyQyfpWFaGuDhCtzCT1Am5aJtshR
ANPDzb6tYc90kvk1IcjIjVq53rnLwKdJ8v4jEYh+pbBCqeA2CXMNBIIDq0CitA2KrDJVedS5
ojh2dZIUYZNKMetH4Jw8NnlYtx/KWyzENKtTddaB9mkSdXq2e5jjSrMOuCCeq8ZVO/OYpnnZ
0nsjxJ/SIqc2J4j7lNRl3yfjNwNsrqmfbmNYGo1KiMepO+8PG2UEODw6NC3YyfyXtuRmFX21
TC3hY8ZT0uIABJ9jW7GQCQobrjJO6TSrKlOVp/rYiqI9NLCB2keptqufbBmgmHmrkUuuu9Wx
bpKP6DtJr0s9nu/tDHu2iHn4aeYRIP7dxPAfbGP319e3RTS9D9AeISMX9pxCOiwEYBNDY40F
85hMRjQL3KV6FYglcl91I75xDc9fsc254cVSX2sz19nMwqxatJHKGO/xH4MDPmOORa/qMjOc
yCMPDBJmxEYf5zp833w04vp4Q+bROFIu2zlYe23KUmAKR6Mcpr+wEVLZN28P998px9D+20PR
hNsE8+cd8vGBvPjpu0JZJEc0c4TjMfzFzwUmJTTBzooRIGDYQs4iaSnoTY07tgJM5vP+iJmb
ih1768AvBRNiZ8E+g3237cheJxxeuJbjrWlvXU4Bixh9HsbRjbtS4hZJaAwH7KptiPKV6wRa
ZRjco11LGEF7qGEDANO0IPcTjIadpVhKiQzoUEC1buw60dGqhuC1Q58ojgQW+Y6ZoXneSo0t
i0NoiIHBpaHcgAF5/njYUAYmI+Gpq/Uq93DzU0lGNY9loRRoh8MRb8ja2eM9a655gPfGaM3G
EVWObwagdEg1Ndk70V3hnbTGqjQr96Rw7N+7o915UOewnvOQMzpSoSy4gMdOYBHC1boemReD
iw5Pn6QUXjSqOBdJe9qkO417G4UYiGJmVmWRt7bnhqkPVDMr/Z5Hv4li+LKl475z7mOkGrXq
eGK6MmQJYgRp49rbzLXJsA0iBQ96rSjJxZfry+Kvx4en7/+w/7kAO2hR7zaL/uT0J6bTpgy+
xT8m8/ifiprd4O4gVwYmz051oo8L7BmpgxQ+JCw0yRDFXNdQa58AOixSt9JBFZmtmSufXe7a
S31NyHb69Rx3pUCP3vb6cv9NWWnk72u8V6DcTHps4LHI+ONgtC8PX79SjFpY63b0LVEYRQkG
5kvBrL0dlj8YrLvvP5/xYenr9fGyeH2+XO6/SS4eNMXAFQOTomPRLxHAl2/B2kDgPmrL5pa2
FBHfYF7hPRmJoCUsVwSyzLxaxwNm8TDE0JG6CL9Ji3arB7DWSeKkM1Wl7pg5PgwI7jmwTGJw
B/Jws/E+JQ3tmzERJeUnKhL9RHAKLElVD5i5FNcDTdzgRdEMeyQQPUdlOIsi+Ytku/KpA/+B
YH+bB97Kpb7ly9TMtxiPdi27NwgoNY4YRbEWVkEZ4estpaKeDTgW6GqmtLrxItd39NLSJrMd
OUy/jDLEmlSIKIedgeQEBJ7eHJaLyCF7nqFMzkISkUum7JJI5CiGEsqQVWvs8KXdkv4po2B/
dJ0bvU+n5MAayyEi09xQ9YHMqFGOMHbZ3CRswAJei3duA2ILS4NoRY8sYdLaNNwLbLIS8AUZ
AW8gSHLYgvhU6+sOMLNiCgSuo8tK3QWSa9TYXC/Xq97EoEmCQf+hE6Cs/0Rd6kSwY8KDwHRc
c4Ael0Vdb2qqBTYADq10EGNMmS6IoCO9YpG6aR0Rs5Vj1Ny808is+Fso1pDq8e4N7KEf72l/
UJFOMDd/gcCzbVLzeh4xKKhzA++8DfNUvjuSCd5bDlbBnKADge8EnkHn+8v3+YNun5NixoUQ
xbhxlvJruhHDtg/zxbLoq3Ol8rCrBPemvbH9Npxdj5ZBG6zI5QgwhoMZkcSjX1mOJE2+csgH
nJNCXAYWOSfqyovInC8DAUo2qTJn8pKMfaOlwlYJqiSsDSuNycdhIPl0W3zMq2FWXZ/+jKrD
uxYVT7nwjiyYzx5HmiH8+izVtsnO2zY/h1lY5/MjiE/536c4d8xKnSErTeG6poVongFPuzBL
0tVL0yZ27Ocxa8W7ZJi0YpaIuOXXqwR7nXfKMh+ujl3czVeW5fVwyRe9A00fU4ZY5lv4y5Iz
yk0aJKeyyozVGgMqa19++LT0Dc/SJ2PZfPAl0OC+fd6qM8eQnXY3SrwuvYdP88MI+HM3r6mb
ojNvwRgP883DSNI6PulbPRGwML9Ej+etv3rH8j6hwM7ZUr5rkQacORra+ClPjjAvplq29dFL
p+HPW2atp8EtUfAHwZDt6Gon7c0nqOEuAAh0t2EM5JQUO8ltGGG9uyM7Zi8S8TESYkvBDSXE
sG4hLHk7wIgVwkT0AKIFDLngZAnoyYLoJrTtE7WpiI8jb3HU+vw0cU4dkKPmT5QKpvnunMeR
4QsM+JKdU0CuJCOmh5cVJnClZ9eNq/Kc7muiLasHjUyzTRIeWvQvM/TbSHIyk+TVuTIWAcjW
iIS5YlhBMQC86bNiU237ASHxfcCn97D5gZ5HnCA3fo+pR4xIfstglkOmIh3rHFYbIxNOY1vm
AW/T3Pz5mGYlN9ZiJDGPKlNiBlHtY01x++scV4qc5+3Ned8YBx2w0UcTlrnUQruJUhlqjxPk
nO9ywUlnQgha48jGYLi4l6HiLG62mvAOCrGPxCPxbfb4Ozlvwkbywu7htGLG0FrGjh6KQecA
lWgc7kGXiDoRDL0J0qY8Rl5dNs1Gtqi5AsliIpMKwqLHh8vTm6CiWczCc3s6K8MKP0lvAoBv
Dls9tCNjs03lhC7NkcFpqew5GRQ0RkjMyy7p35hQipoTaWe+PbxJsi22gDYfeqJ9Eho8UpR2
CgvP4URE0xsaJUfjh58gb9yoTeuP9AeYPDbvKSbhZZ/Wh0Zy3+m2hktFXFCp0E4CWo5/hL/x
guggv5tl4A3GVySPTHqCtKgOwowcuOWiw7UAHJ4OnQm7oosrMtzFvmxaWAbbTLg0YEDlp94G
Bi3IxxEc1zUl83KQgGwq9U485yzZhdF4+8EC8L9ev7wt9r+eLy9/douvPy+vb9KzhjFwxDzp
UOauTm43smcWaLUkJhMft+FOeK+TggS8vt19fXj6qobyDO/vL4+Xl+uPy9uwHx5ee8kYTv10
93j9yt6sPXx9eLt7xMsbYKd9O0cnchrQfz38+fnh5cIjU0s8hxkUt75rC/EBesCYJUgu+T2+
fUiO57t7IHvC2LWGJo2l+f5yJRb0/sdc9bHS4R+Obn49vX27vD5IvWWkYUTF5e3v68t31rJf
/7u8/GuR/ni+fGYFR2RVvbUrRXv5TQ69PLyBfMCXl5evvxZs7FFq0kgsIPEDT7jO6QFqGgoz
K36Zdnm9PuLF77vS9B7l6KJHiLkyI/jDTf3d/565vxrUZB+Z5Ky5zis0/flLPBs2CBfluahR
Y9i+d/iYzyp4okL4XFuHw6fPL9eHz9NQ4rV3hSllcVdV81jNwlTi1BPnXXPeVrsQk/yajMbm
tmkq8lFCr79YiuBafA0wIPh7kKmwHsxexZDFjRSGrHwTvqzwfc1MpRQf+QFch0cd2KWbGsPj
65hNnca7JD5X+1sdKb8tGqBStquxNsec6okmNqzkA0FYR3vyWVyUc6lRc3oMWQY7kDjaN7AP
9zbjHQimPm5+8Untlq7eNk2yGOun3HxP9SfeOU6L3B6kJRmDNRscQpMsC4vyNJKRVCUm+TyV
tk+3hHt4nKPM4H9/bKq0yEpZkPhK8ni9/75orj9fqDyDPGO1eEIx5LAuN8IhB5TbYDKFnFld
2hiZM12MuSDNJENg5xmKMVvoDM2R7UrNBNu2/X/WnmW5cRzJ+36Fok4zEdXbIqnnoQ8QSUks
82WCUsl1YbhsdZVibMnrx057vn4zAZAEyARdM7GXKjMzhWcCyATykRSY8NdOEh1yVH8H8nbg
LjobIMi+xgPYIhgaB5m50Y6Xe6cdLy+RBwjqDL12ijqls51CMUIg00dhOiY6aGztWj00mAc+
1Fhg6CIcmqxUDAhsdjDxH7c4jziGdLVlg5BEdeYWenCKZD9PhMVO5NPLUMaYziNLllmB5TSy
boEKJdwxDmy5WL3JDLDgIcVkt/nQ4OItxgAj4h3RhwP6BTdsa1/5Vm0kfvIBQVLuLLfG6moB
1Bl6LJoiSgsThmqc7Ek8FG8caNFpu/BwQSUFbWrcoJ3ZEN4SVlm2DGU3EdqhHBxsmQTawlU+
TIJDrfx6ttEzTMhtQDibrHRBijwdNEZhUbzKqCejCA6knZZ2Q8b7QIH6dDcSyFF+++P4evv9
4TjiRPgP8Xu8FNiUbBWHcnnRdxcfFdstVVyhWEzdhOuGLIhkuiZGvpUE1ud0HA0ReMtx5ftf
PyIZbAgu0YHf4xLtoZXu8nh5PWLIYeKVJETvKzjbtfC6Lazyaym72WLxFsfH4PCwoQCFtaW8
GxW8UY96jZGNfHp8+UG0L0+4liNDfArxvwtLeRfSXAm1dRt1NMoWOoF/jYo2teHl7Xz/FdRc
7blHIqC/f+PvL6/Hx1F2Hvk/T09/R0PQu9OfwItB567iEVR7APML+YAv1S+fpXtLykBFEF/B
X4zbMm/UedqhF36UWkRaSZRYiGoFimiv7Ih8f7P0QyVKR1kVdiza3UOj4SmoN0NEucs+LGiw
G/3W6jvj0sFfVxYf/AbP10VvGa2eL7f3d5dH20jUoq/Qzug1mvnSU8Xy7izwAyasKDrnyYrs
N9k6eSVzyH9fPx+PL3e3sENeX55BebJ04XoX+b56z6Tuo3PGMAtOyjN1C17f2XxQhajj9N/J
wVaxmJPksKAjAvZ+Ke8JQTb/6y9biUpyv042g5J92s0mUN/O9AsXpYdncc7Ep9ejbNLq7fSA
5v7NNtD3oorKUAu3Jz5FhwFQp5bSrup+vYb/atIXlMd/WPcZfJ5KAosvXYmOb3tmESTEiZOu
C+av6TsLtdHbzNkRnSQ9rB4nrNty0fTrt9sHYGXrSpNpcuCsQ4vKgF4rggYPq4rTO6ck4Cta
DhTYOPbpgRFYOGXoOwCB5UmAFHaCr37KuX2rkw+HeUEOHTlA5mpSsjKxihuBZlMYYQ00QScA
mciSOkfsjlYHeMSWRg6znVAL+3uumM/D6eF07i9h1UsK27hj/NJR3DYjxxw0+3URUk9U4aH0
hbOMXOJ/vd5dzurs77tqSmLMWl19Yb4RHECh1pwtJ6Q5tyIwL9cUMGEHD8NJE3Bhpd+vJy9T
TAdAKzqSRLIipsNOIjLBvaIrysVy7jGiEp5Mp5bMAooCH3ot7nEtBbAF/Ou5RrjMJCtuDIsX
qQ4HBbP4iEuC0LJm1dEJx9SaXvKr0qliOMBKeslhbugwsXg845u1DSc0iE1uaXSyB+UDuW+1
o7dJ1OBRdU7DsvLpGpAksuQlkmZAVRra6sdN2pIsLGALtO4ICtuY1Cp3kdtcweUNyTrxXevE
1FcYCcWBkf5sG+Hj7G69Ds0X/wZa+VQKAw2Pb/yPNFyZaVFY9IcGqWaXGLlSAX+F18RIZTZR
uZeBKNo0VsPKP9ec/E2PVNTKqxxvLRSJq5Pwr73AcApckz/STQv3Ydo4ZxEvp/WaCg6xN5la
E3AL/LyXoLteUglzFlosW/iejHvfZt7LVeLDtiUc8bRoUzrUfGgImLsY65+eGWUW5rYIxpRj
gcRokfQFQPdCWR9ivljOXKbNcAsz263FAJGt9AJz7HlZI/CJoTNfZdu1Lv7qwAMjRp0AWEb8
6uB/uXLQNV43UfI9l3TXBBlpPplqTlEK0EkhDsDZbGwAFpOpHmo3QT9op2N/pKB60yWIMnNP
RGxjPbLwwZ+5ett4ebXwHMOqH0Er1j3k/vNH/4ap5+OlU2h1A8RdaqEu4Xs2nnW/YRNmfljl
rMDUfrGBXi4PenGRMLIEMUEfHaFgMkvqS6l9soRNA9dOdMjd8aGL1pCLhajUfJOpInGdQ/8q
TPdhnOVovVKGfmkGtVEZ7Ohfbg9z3V8nSpl7OHT7XN8Z2XoEet88sGKlb+QA2scM70N4z+3j
a2zpu5O5NusCoCf2EQDdZxrEMcebeQZgOdPzFiR+7k3cfgBmkS2xnE3nc7SwsjU4CdPqmzPQ
4yR3Z+7Sik7ZDqQBWmDD5x7LSAhBcY9CrfIcfzcwQoSMJF/14PsOv7UYQFh8gdCEcHNTZJbm
FCn6Hy66rFR827ixtevSOceORtccS31cMCAGGJbJ5A2LSmlgu+ZBYg9MrRNZG1AmsMhs2FIM
13jhDKA57Pv0gCI6Af3BxunKUxS4VZ9DgM4Qusk7A71fz4S9LlWUspY91LP+71pRrTFo+CiU
UcO1E7IIuc/Me6X+L9TV6tMD6HlmFMzEn7hTw7iqpfoPDKjqPGv/ngGV//P4eLpDsyjhmaAX
WcYgRudbIm6YRIXfMoWjdZcknJE6pe/zhSkPRey6y6cKkyd8Ph5rmxf3A5h+81CXsNpSzQBi
XDoyGy42PCowvh7f5KZDsoEi0xDxnOs5XMSnKZ9IkKxdM8D8tlgejEnqjr50FDnd144iaHPl
Xx4fL2czfKqS6qREbgbO6KBbmbuNnUaWr3N2wlURXHWrsXPkmMW55RXDOMzAyfcHntc1Nb1o
b0R6yI74aTaBximTG2UMKHn8FfPxiXVIL5XpeGZEDwGIR3IqICaTWYd0uvQslgfBdLacWYTg
IM8wlLXBogGfTFxLxCElJQSkOXoycz09xBOc6FMzLDNCFi6Z2cTPJ3NXExjQcJ3506meQ0Xu
pnVzGzvKgeFtGOT+7fGxTqFgbpcyUF4V7JLEuETp4qQeSF0E9ig1zVvjQ6MJKqL+8X/ejue7
98b6818Y3SYI+O95HNcPYPIhWbzU3r5enn8PTi+vz6fvb2jdqjPuIJ10MP95+3L8LQay4/0o
vlyeRn+Dev4++rNpx4vWDr3sf/eXbQT4wR4a6+PH+/Pl5e7ydBy9dDf9VbJxjHjo4tvUbtcH
xl1nPKZhJq22GQnhSVdAk3znjY2MQBLQ3cnVipe/Rz2U4oxy43XyPtp7KzfZ4+3D609tK6uh
z6+j4vb1OEou59OreSKuw4l0cG9XmTd29NzBCuLqDSHL1JB6M2Qj3h5P96fXd2162k0mcT2H
cpMPtqUu028DHxqm6XcAcMeOcdAZoUOTKIhKMkJ2yV1X2xvkd2ON3EB35HbDo7lUodvjFSAu
rR73Oi53FVhnrxiY6vF4+/L2LBNqvsFAmo+ZSaQ4lWjF+pDxxVy/5qkh5uFylRxmpmSS7qvI
TybubGwrG0mAc2eCc42rQR1hjpZi6Zgns4CTpikNwTLg497pp+Bdk/CBkZIRqESg+96iZ8EX
YATPMS4TdgdHRh2oIZjOx2AfgGBKa+rczAO+9Mx8GwK2nJHHLJ97rq6Wr7bOXN8Y8Hth1O2D
8uIs6IyKiLN48QIKcJRMiiENDTZFyGxKsfQmd1k+NmM5SBiMxnhMXzpH13wGq4bF1O7VCDo8
dpdjZ9GVRlucS5txCaRDhp7R7wBjw71Fw+QFaSD1hTPHyF9V5MV4qicVrFvXiy9ZFlM981S8
B+aZ+NzYOyciA9ZjB6KlS00z5nj6BVyWl95Yz++SQwPdsQnjkeN4nrnlOM6EVkN5eeV5ltSn
sNB2+4iTw1r63JvoGQQFQA8jVQ9NCXPTibQkQJYISwK3pDkbcfM5zdqAm0w9il93fOosXO3g
3ftp3E0+JmEemTExTITSrYmHAtLJjxrP6Bzt32DSYI4cfaMyNyJpFnD743x8lTej5MF3tVjO
qeSjAmFEu2FX4+XSoYdQXdonbJNaHxAACZsh1RdtyWAJYZklYRkWUqzRbpR9b+qSmqPav0X1
9J173bIuumanbeJPF3oS7g6ie9TU6CLxHOsZdsMStmXwH5fxZFuTB2pW5Hy9Pbyenh6OfxnK
lVAedwd9rg1CdaDfPZzOvakm9NfUj6NUH+M+jXxqqopMi6LfHIdEPaIFdRjG0W/o0XS+B23m
fDSMcaAf20KZ5koN2jKbaMNdFLu8NDRtY06lQba1MIL6Vyou0XEHfW/oZzURKZHS/um+K/ng
DLKqTGZ//vH2AH8/XV5OwruPWJLiTJtUeUa/Evcj0EtHaIwmStsw/Ur9hibzdHkFEefUPhK2
qrjTEVaCqUtGOwy4Y6aWBM15YijXoDB3zmQE0Xttmcdd8d/SVrIfMCGmVBsn+RKWLS0u07+W
CigmggcJkBD2Vvl4Nk42uo6Xu+aLKH5395Eg3sKeTyW4CHKQHcfk4qzz3bQ8kZPZ4iM/dzqK
VB47zrT7bSqXAPMkUTszfDojk1Ahwpv3dttOQh4d2lVDy+mEbPs2d8czTYf4ljMQP7WHOAXo
utL2pqgV0c/oYvnSv2TrI9VkX/46PaLehCvn/vQib317Uy+kxOnYUHDiKGCFMPHrhP2px23l
uHrYwRz9nvUHjjW67lqeb3ixHlNHNj8sPUe/QD0sp6Y4gr+k4rmhmCKiobXCTDz14vGhP7qD
Y/L/6yIrz5Tj4xNeCJmrztwsxwyOiTCh7Ym1ddOlqScjPizHM13qlBB9gsoEdBON+8T33Ph2
HP0bDgpdUhffbqDvYFTPGn7Qk/bBhzx3TFAvHAQChWUUOQ4NFmRq2lQSKYZ8JgU+LGKLRaBA
D1gtI34wryYSDERpQ7RycrLit9FqT3sVITZKDrT4qpAuHZ9cYGWwkY29asWJ1GsLYEUYfENb
kVB5H819e6OHYphJPGyqgw6kSCUsfHt5LnUC9TRtJzjQ8gjihOFbkNjcjJBEBMdfTLsjYHOw
QlzBeL7CBHN5BNIQ/d4q6HxGS34CqQzXbM5WgkZZvFoJCENXEx+7Cz+PaWcCQYBvzgPYYuCn
Fg81ibMFVmuwNp9FRdA1e9ew9qh3AhuFviUio0JvC5uroiAgU7MoTJNOUgPvIw5fA4PRD5Uo
1aLienT38/REJFYqrnHW9cu4ah3p5lAswJBsGK2mgWWFc4VpyfSN94tweGTRcCAk2EJ8LCu3
7J8NHTRrkKD4xhw7Vc2Loj7LncZkgTprQTsD1HY6pb+z0tRN2S64vR74cRuRi0VBSG9yIt13
cY0JzywKHBKkpS2umbJMwtr8LFlFqaUYjPSzQQeo3N/iDNKXFBiMp9vpWvHtclLDSDnzryoM
c6Ob0Ycc7Xiz2rejx5j59mbE376/COP1litVVFARjuGdAFZJBPthINHtAgBEfZqIhF2lZbcC
OlscR8T5LAXtlqXcDzHEkrEIsW7pZua4DGuxbD09Og+GPLJsNA0xO2x+lUyMANJWLGW2OBrE
T3DQrLTKIQvbS7tziOG52aQY6mKonWhmxwsshxjjJuoBDl9FTCISpHx4dFPuyrBqtmMDyymw
Gay07OA1RaeVVEcGO6viwvaGliDhLNbTBiJKmLOju9c1NkQTbwWbH0Diapm9w4nbaOa648H2
byNvNvuYZP4RCfoS4M4yxD1AFcEmlWbDM4cJK6Pral8cXAySMDSyirSAXdhapIrcO58K14p4
x/FGb5DJhfje4wt92IWXApQJ7duVSdTlzxq/EDmX7LMOgl3lLlIQybl+pBoo7Fe3fEQOTUeS
5N7HBFipnQJjHAyNEhLsLF7iNf7Ah0rAaEKHKVoqBaG9nMwP46z8iIqV2/lysMvC0DLKrydj
5xcIrwc5VJCIhI5pzqt1mJSZLXKxQb7lYk5/oVx7T+t+LMazw/AcY7BiB9ePlaRgmEhpsBRp
fBqmgp/oZyNBVvvDBeLrQL9qGZRiI/B5NHjgmNTBr1IPbhoNVXmTWwJxIZkSmYJcRkr6iE5s
wr9EOdi42v1naGk1NEM82giVv0xln92GarDprRhrS1UpGl9KRc/xnDEO2tAG0ZBOPiIVepiz
nFS5a1FhgUg6cNm4XejnShS1ng8lyFRRHtqHSt6BXIVhsmI3Awlce6RDi7C5WBFHrJ3BWrrB
io0QvqQUb4rdzbmEzvq+Hnk2KHPtDi7xV/rbxQqFbePC1nSxpQPXsTQosijQFE4JqEBpCTDk
S26olSZ2TZk4dAqow45++n7C3HOff/5T/fG/53v51ydb8Vh5E0mWHLgmsl49QHqWbJF6rO2Y
+GwuLZsqJVjocxF9VLQUmZ+V9P2CcnQM1zuLS7cspFaHQgxhMlRbTWirT1JhUCp7m1AksDdI
nrvrD9ohXCV4wCwZNeqt3V5NQzLcE5Tr7T1RbRF3RxjDjm5NsyF+NAvS5nVg4OqYJB8VhPkR
YKo2XVf4ZgHuQcXIh2Zb+YXYKxKxc3pooxWFZPPuiKIqle4L1s++t/06en2+vROvS/1YR50A
Vs0NDO515dY0mZOwalNuB35SwfGp28opaG464zfwXoaD1miw3+7GyC/fGMFI8btKNgV69+Pf
5Nh2iSpGmoKoLAg57ke1FboNJW699U24qQO3/6rbFJ1IxrzUDPNk2esiDL+FPaw6VHLcYP1s
l8e6VYAorwg3tZVEfeSudYx9SII1/Vxj9CXJrb3hkTECoIViDmk4CKo0Cyg+RpKECU1RxR8w
fq1Q2x19ZGsk/XwcGg339WCpArIK0Ym6W19mCa1RhlTjRVJrGP+DME/vWsyQcU926Aq1mS9d
S9j+nTWpL6JUqG/K7KYfQCrKjGQ2+F3VQVSJ8nkcJZ3Y2AhSYU06AUG0lVvA32nol90VXcPx
+LTc7GpEopaMw/FHS3wG8dADCKwIJKVHN7MIE52oGtKd4IT5VIVcpj2v7xk+ppchcAv623Ld
dR5BGY9ghv24hYYHjDxnSh41rFphKNQqyylpCoP6V4iXUcjrPoCghL6ANxb8GqOp+8VNLgyl
aDBsMBuur4dqHxYy76y2GhSwvyv3KFa7CBZCCiy2SVm5K0KuVywTCRhmJtbcApHEiKDKWhms
X8b1LiNvjdiuzNZ8AvVq+6mASVDbQaijsgXfg47F7KaDVv56dz/1VDtpiPPYxhdsuu0zfxv2
ANo7eePDJwqUl/Avx7f7y+hPYL2W81qNAp2lScFbRsXbRnFQhNqkX4VFqr/Td57t5X9yYLQG
EY1omC/iMtkEBhcNE62srGDpJqwHuWZzwXA0CEUtXkfYb4Xp9Zq7dB93q6hTfA2BHXXPUj8M
xB2gxjcNQfzNCAfcwL/FEX2wtBS8pA4ViWf4xNyf++bHB1aWBVkxD/1d0XHF6FMB327DtIx8
YfVIb3cg5ZHDBWJnZ7gkBIN4Y4QQvLbSdD+JRNm3DIxLUF7anIuB879mxZXOD5SgqmeZgg9Y
AGsG5+Yfn04vl8ViuvzN+aSjfZATcrYJq4mnGbAYmLlu42Vi5lPLbxa6q0EHYzjFd3CUrXSH
xNbMxWxsL3hGm350iChjrQ6JZ619YsVYB2k2swzsYra0/Gbp2X6ztA750rMP+XJCpT01G6Pn
wUZMxDPkpGphqc9xp2NLIwFlmMohknE/ojKC6FU5ZlU12KXBHg22dGPaHZwaQYfv1SmojNs6
ftnta9MfWuwySCgrP4Ogw1dXWbSoim6NAkpfHSIa00nBZsTo7a6m8EMQOCgj95YApMBdkXWH
UuCKDDZURiXaaUhuiiiO9aeiGrNhIQ0HZe2qD46gpSCxUc2I0p0lKLUxDtEHQwHy1pUt7j/S
7Mo1ZWS5SyNcBNqpJQGgqBUJCLnfxJnT3MFpWnxWfb3W5QVDUJYe4ce7t2c0y+xlq7oKb/QI
Q/AFKun1LsRMQEpeao+esOARHCtpiYQFSArU+VIW+M4YyJJbMUPKui28KRW+q2ALIjdo2NhD
WgCsz2fMEcWF9URZRBazuMGzvEaSZ/QWb4lE0pAUWooyr5/lNxWmgfJFvA/d97JLRqlw6B7h
C4oEpnIbxrkuRpNo0GLK7R+ffn/5fjr//vZyfH683B9/+3l8eMLr2Vpgl2e2NixMWwIxT/74
9HB7vkeX6c/4z/3ln+fP77ePt/B1e/90On9+uf3zCC093X8+nV+PP5A7Pn9/+vOTZJir4/P5
+DD6eft8fxSmzy3jqHCij5fn99HpfELPx9O/bpW3dqM1RCX2DlSpNNNzXgqE0HdgRJte6HpR
TYF3LSaBFhGUrLxG29vexEDoLodGAEcezeqrA//5/en1Mrq7PB9Hl+eRnIK2k5IYVTcmsrVT
YLcPD1lAAvuk/MqP8q3OMB1E/ydbxrcksE9a6EpqCyMJGxmx13BrS5it8Vd53qcGYL8EVB76
pLADsw1RroIbFgMKhQuMWJ3mD9H+VcSTF7nyesVv1o67SHZxD5HuYhrYb7r4j5h9oVX4Pbja
5qUi+vb94XT32z+O76M7wZY/nm+ffr73uLHgrFdO0GeJ0Nc8OhpYsKWA3Ij32cALQFg0IMmk
CSUs1yOxK/ah+3+VHdly4zjufb8iNU+zVbu97XSS6XnIAyVREdu6osOO/aJKpz1pV0+Oip3Z
/fwFeEg8IFfPU2IA4k0AxEFeXi5Qi1XesPfjd8ynebg/7r6d8WfZS0xB+u/++P2MHQ4vD3uJ
Su6P9/Yh3JQYU6ZyM3lxQfQhzkDCsfOPdZVvMOP1VG8YvxHt4pwS3Ka//FasiIHOGLC0lZnH
SN5igSz9EMxdHIWTEqdRCHPPsCOUkmhjM8Ji8mYdNLdKowBWY7t84F3XEiMKsnzdMCqJwuyL
zAx20ByGLw52PTVRvG2F88iScp3cH77PjWTBwiZnFPBODbpf48p7kdTkje0Ox7CyJv50HpYs
wUEv7+4ki/bBUc6W/DwiWqIwtFI01dQtPibuxaveBiBrHeci4KXJBQG7JJpXCFjgMhCPttMb
tlQkC/IWArN5MrYIagTg+eUVBb5cENIyY59CYEHAOlAtouomGI51rcpV3GX/+t3JbhwZAbXw
ATrMPRWjKco+Ii9RMfgmviCWRbV2HyX3EME9VGZJMHw8TDACgZq9+ShYSYClDCwW+or4bC48
TaNT+Xe+2GXGtoRSZNgzUWFLe5ZGbFPjnbbhYghHuOPhGHXrSg56II8VfLr6UC2Ul6dXTCo0
1xX5Q5PmrKN8VYYLu5ZQDf18cUJ45tsLYkwAmp3cg77lVGXjwSnh5emsfH/6unsztyvRXWFl
K4a4bsgb3U13m+jGvERLYDQLDgZJ4tjcW3kWkffaUUgR1PtFdB1vOMY21ZsAi5rhQKnvBkFr
1CN2VNH9NTRSNK49nUDDtlqdEJkjKXlyGLG8lMprFeGjGx0PpR/0A19p8E83f+6/vt3Daert
5f24fyZkaS4izfQIOMW0EKGllklMOEVD4tTeP/m5IqFRo3ZplRDsF4fwxG4DOiMoQb0WW369
OEViavQnwCYiVsTUJVohDalH8egXla0pN1y7KQqORhNpccEAUCt2YkLWfZRrmraPZsm6unBo
pmCIy4+/DzFvOpGim4QHTtl6Gbefh7oRK8RiGZpiSo7VZftw/PI37aayyp3sUxKPpyb8nLb+
iBs02dRcOWvRXZoS3hy1QfBapz/kgeRw9sfL29lh//is8nEfvu8efuyfH6fNIq+E5Vg+1n39
ywN8fPgPfgFkAxzbPrzunkbzjfLO2KayxvEZh/j2+hcrNk/j+V3XMHuw5yxeVZmwZuPXR1Or
omFzxstctB1NbFylPzFEpk+RKLENMPFllxomlIfcZ5pOJj3pxFqOBKhw+MK7tTZNChRod2Vc
b4a0kQHl9sqzSXJezmDxeYW+E7kTHxBXTUKat6E7BYfjfhFBcyzvnVxSLA+Lr2P5ApwdSmpQ
HhjUejjVgviyeVy88HY8bMV53R/K7PrBLeCTozrDz8mk7DBJiQFWwKMNff2VQ0JfqKlJWLOe
04EQD9Pp9emK8mzEStjYdJR3BVhjeCKLP0+/9BHMzsVjZVIV1kgQxaJnGuUnanOWpXVbKR83
XmjhQDEULIRfTNRPNpSiRn2NRNxtEWx3QEGGu8/U6wYaKUOY69gvZhDs6iIAsqYgygdol/UF
lbimKTCxJawiir8EMNeHMXVzuNnaObcWIt8WjETcbWfoqxn4BQnH8Q43pW37N8tFPS6XV84F
6DYU3R2LqxkcVGnjotg63nXA0luOT15PBBNsWBY1CY8KEpy2FlwGbK1YPuDx15bp+EwesKsV
vqTZMEtHzjDbuHICtxGUONNQMOxQzhoOSzuTmrZVOLYCv2k3ZSxp0/HyKHt9IQaV2LnIJsRj
jkIE4wpniMby67U3uZojq023Nt/Nq8iuCn+f2udlrmNE/HXQVYWI7a0S59uhY5a9DFOMQXWz
Ki9qAWzDYgAiShNrfDC+HiNAQSK5mZ6YuUd7GavoC7uhpXEgTKc5Lhe4JKtEqlOuh8coMhL6
+rZ/Pv5Qt7c87Q6PocNQym/1CLDTYgWOmZ/LbKYJnUGgrcRcBqclg53nEKunAvHN+xzkej66
G36bpbjtBe+uL8aB1kphUMJIkWxKBhM4hntR4MF/Sh703ahCdZg3DdDR92fNjtloHtj/ufv3
cf+klaKDJH1Q8LdwhNMGahrWrCmvFx/PL6zWgOZd41Pb2C7a4tLAGVE9ittS5vCM45UFmJMP
82EvVNV90BSlj7kQbcE6mwf5GNm8oSpzN4xQlgJbHGY57ctYhzaCzj1cXVBSQ/KHNSs73em6
klzKjla04RN4VeSixPhbqTCRDVhztpTPJcX+1R5Gef3ZmfmH/UKx3jfJ7uv74yN6F8Xz4fj2
jpe+uoHF7AZVzU3bUE/J6Ya2/gxgjBkws/WgZsfvWCudVJKgwLBacg14JaEDlgyYa5klveJY
8mkJHSJ86tZq2ykoroEJZYXMIbLNREo3UuETsRq2vKHTuhRJX8KahlMxLOoTVFFV0XHyCs1B
QadCFfCoqAZiukcNQwDgIAlfoWYgcvem859aBu6cYtAnJ2bTf2rPdqyP5boHIuBwIN3xpYSK
CpZR5SKZLxFdhDEWTV5dt45qXdIX9chzdyXaqvTCRKcKgAVRZxFFAMILGEmw6jXYjm3xSjYU
GBVwYtEbMnnTEGVsd8kwWnKuLZhYnymL20wlwFuAtVDx7SS5N+ajDanN+0hGggTDogIoehRs
jlCKM9QmJZKXyQA/Y/peJlXMik530otQvq4ooy7m4mGsxmAYdgpMJRwUB00d3hR/wRGHpQNM
CTaY6MQWH7pJ9PHGD/CYNoE3Lpm6ckc55ZDorHp5PfzrDC/wf39VXDy7f370zAl4aw0IpIqO
7nfwmFbQ8+uPLhKXVdV3ExiD/ft6ehBrkpdV2s0igVl1+DRYYZPJGn6GRjdtYc8A1jBkmBjd
sZZeC+tbELQguZOZ+1AkL1T1zGRknBpnFWUGQvTbO0pOm305q1YboKdIHOITd7JxzJec14rh
KKMRutAnzvvr4XX/jG51aNnT+3H3vx38szs+fPjw4Z9T/TKvQxaJIe5hjHjdwOq1sjfsIH9A
NGytiihhnOZsZ5IAt/IsM2i6oejhhMbDzQ49xO99+Az5eq0wwD6qtYwY8wiadevkAyiobKEn
HBCW8DoAoF2mvV5c+mAZ0dBq7JWPVXxJa/qS5PdTJNItoegugooEMGE4WYKyz3tT2rnPeTT1
7JCrgxuME+eErqgnXDlztPihuIMcONjFmEwzaGOZ2VnjVAShmW2c+h9Np7W/sYpHhUWOGXC/
NGc3weSG8OnUNcGk5g5LADQrdKPCplTmL7+0pRJcLp/9odSeb/fH+zPUdx7Q1mudXfSgCkqG
1wg+IYpaelMppMw3ErRQl1IWlEnWMTzB4bXQwo0YPNl4t+1xA2NSdoJJA7DykcY9xdE0Y4gt
Xye9QFCVkG+WDb6VFTH2N1TaCJCASuUWYH/uzi6C+G0bZjW5nfCYya0+MzXytDSVVsp7rqEC
S3qp33hjs1+3Wp2xy8XQdxA8fyvfGpL0jtsD/qD1amjXAs+Yfs01KH8FzG1zq1DyVNi69Tvl
GdsN1QVSCKSmR+MMoRyWSUX6G3KJ4vV0VZrqeijrhxR+YzOmGOJ1zjris8na05agbvNTJFLX
pYtxZ6wtWd1mlbMzPZQ5L8MMkFFcEbAKvB2vqaT7TMf22qJSwllZ4sXwmNUkP5i7vciQAzOi
CM0a1SYa9UCVxdw2ZZcFULUI1QIT5RcvD3ZaN5MtkTakTMuWpvSqY7k0UGJ//OVEyAWD6Bjs
/XrwzzzT9nBpKPZgtXOuOJtmTJeVizrhecfmJmfcbEDFNkEDLCPZOA+4404QMnxELMzgfHnd
Pb/tDw8Ok7WNlN3ucEQZifpm/PLX7u3+0Xk3YNnTxxcjNNB8Jx82+KLMWJYBNgXmeorayRPh
nUqcJ+iI2lXoOlFpykTe5rblGCHq9OzpZl4ZY67BPEVoWZKFF0VsEjvspeF/bZlpYSnTx1p9
lIMDXFyt9Cq1/UoNnIclx1SashcOlC+TzvFW4OsbosSzdu1c/I6IFrjznN0mESs7oy4aG47b
zXMvNRE6PXyg7ZTxUmpsX0mwn/TBf3adG1fBKTeD7ELG75LedumghRflEmEHUeOh8CpRhEy+
0VRtXG+C0VwCoiOfHJLo0TPv1Rmzkn5dSaJBKy9IWaGMa71IgnbcST/T3CeWjcEGN3hS6NCE
4iHcAC0JAg7nQfJlYTvZVLvhnB+0bVXIHTjfXxlw5af7eENSUxYwhcKwiqySdqCVk/wuSrxq
aUYs2UWkoilAh+def3rJpT2gTjDyU67UpuNFDFoDfe2O+RoPRyRrNUUg2qtUZu4gM2vt484p
Vm5ZKfBwUoi2xWWeVHFf+I9SuqQsEooNezR+KpBycv0fBvRCuTi6AQA=

--zYM0uCDKw75PZbzx--
