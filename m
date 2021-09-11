Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D75407901
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 17:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhIKPPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 11:15:19 -0400
Received: from mga12.intel.com ([192.55.52.136]:5618 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230472AbhIKPPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 11:15:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10104"; a="200826422"
X-IronPort-AV: E=Sophos;i="5.85,285,1624345200"; 
   d="gz'50?scan'50,208,50";a="200826422"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2021 08:14:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,285,1624345200"; 
   d="gz'50?scan'50,208,50";a="526725919"
Received: from lkp-server01.sh.intel.com (HELO 730d49888f40) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 11 Sep 2021 08:14:03 -0700
Received: from kbuild by 730d49888f40 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mP4he-0005Xr-W9; Sat, 11 Sep 2021 15:14:03 +0000
Date:   Sat, 11 Sep 2021 23:13:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [linuxppc:fixes-test 1/2] arch/powerpc/include/asm/reg.h:66:29:
 error: left shift count >= width of type
Message-ID: <202109112316.qD0AxaLJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://github.com/linuxppc/linux fixes-test
head:   d45e8e4cdd90ce2e6fc64b568229c56e68b638e8
commit: e0940aca08c125f641ee253c2db9f28f3edd2d97 [1/2] powerpc/64s: system call scv tabort fix for corrupt irq soft-mask state
config: powerpc-mpc837x_rdb_defconfig (attached as .config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/linuxppc/linux/commit/e0940aca08c125f641ee253c2db9f28f3edd2d97
        git remote add linuxppc https://github.com/linuxppc/linux
        git fetch --no-tags linuxppc fixes-test
        git checkout e0940aca08c125f641ee253c2db9f28f3edd2d97
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/powerpc/include/asm/ptrace.h:25,
                    from arch/powerpc/include/asm/hw_irq.h:12,
                    from arch/powerpc/include/asm/irqflags.h:12,
                    from include/linux/irqflags.h:16,
                    from include/asm-generic/cmpxchg-local.h:6,
                    from arch/powerpc/include/asm/cmpxchg.h:526,
                    from arch/powerpc/include/asm/atomic.h:11,
                    from include/linux/atomic.h:7,
                    from include/linux/rcupdate.h:25,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/context_tracking.h:5,
                    from arch/powerpc/kernel/interrupt.c:3:
   arch/powerpc/kernel/interrupt.c: In function 'system_call_exception':
>> arch/powerpc/include/asm/reg.h:66:29: error: left shift count >= width of type [-Werror=shift-count-overflow]
      66 | #define __MASK(X)       (1UL<<(X))
         |                             ^~
   arch/powerpc/include/asm/reg.h:1379:61: note: in definition of macro 'mtmsr'
    1379 |                                      : "r" ((unsigned long)(v)) \
         |                                                             ^
   arch/powerpc/include/asm/reg.h:115:25: note: in expansion of macro '__MASK'
     115 | #define MSR_TM          __MASK(MSR_TM_LG)       /* Transactional Mem Available */
         |                         ^~~~~~
   arch/powerpc/kernel/interrupt.c:151:33: note: in expansion of macro 'MSR_TM'
     151 |                 mtmsr(mfmsr() | MSR_TM);
         |                                 ^~~~~~
   cc1: all warnings being treated as errors


vim +66 arch/powerpc/include/asm/reg.h

14cf11af6cf608 include/asm-powerpc/reg.h Paul Mackerras 2005-09-26  62  
9f04b9e327c495 include/asm-powerpc/reg.h Paul Mackerras 2005-10-10  63  #ifdef __ASSEMBLY__
9f04b9e327c495 include/asm-powerpc/reg.h Paul Mackerras 2005-10-10  64  #define __MASK(X)	(1<<(X))
9f04b9e327c495 include/asm-powerpc/reg.h Paul Mackerras 2005-10-10  65  #else
9f04b9e327c495 include/asm-powerpc/reg.h Paul Mackerras 2005-10-10 @66  #define __MASK(X)	(1UL<<(X))
9f04b9e327c495 include/asm-powerpc/reg.h Paul Mackerras 2005-10-10  67  #endif
9f04b9e327c495 include/asm-powerpc/reg.h Paul Mackerras 2005-10-10  68  

:::::: The code at line 66 was first introduced by commit
:::::: 9f04b9e327c495f8ddbf89c08da6cbe626e1b1b3 powerpc: Merged processor.h.

:::::: TO: Paul Mackerras <paulus@samba.org>
:::::: CC: Paul Mackerras <paulus@samba.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--KsGdsel6WgEHnImy
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICJjCPGEAAy5jb25maWcAnDxdc9u2su/9FZr0pWfmtJXljyRzxw8QCEqoSIIBQEn2C0eR
mVZTR/KV5Db593cX/AJIUM7c89ATYRfAAtjvXfrnn34ekdfz4evmvNtunp+/j/4s9sVxcy6e
Rl92z8X/jAIxSoQesYDr3wA52u1fv/3+cvi3OL5sR7e/Xd38Nh4tiuO+eB7Rw/7L7s9XmL07
7H/6+ScqkpDPckrzJZOKiyTXbK3v31Wzf33GtX79c7sd/TKj9D+jq6vfJr+N31nzuMoBcv+9
Hpq1a91fXY0n43GDHJFk1sCaYaLMGknWrgFDNdrk+n27QhQg6jQMWlQY8qNagLFF7hzWJirO
Z0KLdpUOIBeZTjPthfMk4gnrgRKRp1KEPGJ5mOREa9micPkpXwm5aEemGY8CzWOWazKFKUpI
azc9l4zAUZNQwH8AReFUeK2fRzPz9M+jU3F+fWnfbyrFgiU5PJ+KU2vjhOucJcucSLgRHnN9
fz2BVWrSRZwiwZopPdqdRvvDGRdurlBQEtV3+O6dbzgnmX2N5li5IpG28OdkyfIFkwmL8tkj
t8izIdFjTPyQ9ePQDGtnd/3mhNbi9gG78PXjJShs5LmdgIUki7S5Y+u09fBcKJ2QmN2/+2V/
2Bf/aRDUilhXoB7Ukqe0N4D/T3VknyUViq/z+FPGMuYld0U0nec9eP3YUiiVxywW8gH5k9C5
vXqmWMSn3nVJBorFs6J5DCJhT4OBFJMoqjkVmH50ev18+n46F19bTp2xhElOjUyouVhZiqMD
ySO2ZJErRYGICU/csVBIyoJKaHgys+4yJVIxRDInLfZPo8OXDmHd3Y1QLtuzdMAUuH8BdCVa
eYCxUHmWBkSz+hb07mtxPPkuYv6YpzBLBJza7wB6BCA8iPxvbMBeyJzP5rlkypxAKhenOnqP
mkZw07AjZAyG8j+4rg8CP51TNPsiXnVdXrqqdbz0uIvW+6eSsTjVcFajZ1sBqMaXIsoSTeSD
d78Ky4aV5KbZ73pz+nt0hksYbYCA03lzPo022+3hdX/e7f9s30ZzushhQk4oFbBXyVXNFksu
dQecJ0Tzpf/NkEkNW7Xo/ptSAdoQykBOAVV7kdAYKE208h9ece9F/8DhzSVJmo1Un1eB5Icc
YPYlwM+crYGFfapBlcj2dFXPr0hyt7Jua1H+w3+VizkIeYe9G7uEBgiYcc5DfX9107ITT/QC
rFLIujjX5anV9q/i6fW5OI6+FJvz67E4meGKUA/UMqEzKbLU/xio/kEFwXt6wXTO6CIVQByK
rRbSzz0K8AJjZ81WfpwHFSowPcD7FJRP4EWSLCIPnnubRguYujSGTAau8yBJDAsrkYGKtYyc
DDqWHAamMDBxRlyTDgO2JTdw0fl94/x+VDqwOW4qBIhdjzlaP0ykIGb8kaFJQOUK/xeThDpK
pIum4B9Dtg18mQAdMSoCloNWJzlDJwpFXST2ohcRfawa5EKmc5KAzZaJY/xLo+/8BjGjLNXG
OZeEWr5nKX/t7xg8Dw6W3PI91YzpGHRG3jNpJdP0hkMgC6xPO1D6HaVVsUaNVNmun2V4WRTC
XUhrkSkBQxxmzkYZhBqdn3nKrVVS4dDLZwmJbN/f0GQPGMNsD6g5ODxWXMEtjuMiz6TjL5Bg
yYHM6kqsw8IiUyIlty92gSgPsXLczWos7xjDLtjcBsoj2oyOFyaN/xgGnvnG18Jgo6UnR0qn
hC4san1o6iGh9ZO05NI49WwDPtMnGy1g8Lhm1KtXYBMWBMxHsJEiFMS8cZlaU0Wvxjc9K12F
qWlx/HI4ft3st8WI/VPswVQR0MYUjRV4MLb/YS3vNX0/uGJN8jIuF8uNqXZYHsMloiHWsthe
RWRqn0pFmd+JVpGY+gwlzId3kjNWRw7uagANwaGJuAIrAYIp4oHVbcQ5kQG4pH4zoOZZGELQ
lxLYE5gHojmwPQOuFAa0PXelulg3FG30QkqvJ847p/Su/87p8bAtTqfDEfy/l5fD8dw6GzAB
Vf3iWuW9lfIPt9+++WlF4ADsZjwwfvPN8yTW/nfja0vj2eOWpWq8/9Txj9j1eEwnOOqXGgRf
D4JnN11QjwqXshDcUclm/VGbplBFKK5GZmLXMrXRXoRKiQ5sXQbgGUvdffojFSLpIZK0+6Y4
ViqZS5umcZarLE3LTEm7AA6jJfMzu1fBJRIvV91ftczc58dGIQRKXFuODfr9U3zAJODEst3X
kym3TXGcdTRyHMMxZQKeEsTKeUzW91fvLyFwzJ/5EWpN9NZCDp6zHlwBhCXq/vZq0qgiDWbE
OBjWPdeW1gzDjDAiM9WHY1QM7mcfUAvHfMUgPtUOM1h2m8jooedSpCSpAnKRgbP+oUnjlS6x
iLkGnQdOdm68aNs4l9dAHirWAUEIqMuIWTCd5Vd3t7djaxamMczc/gEc/8YabMx4TYQlgXUu
KOMxKNuugeZTJksPEV0sxadRF0VlKgU2Gwaby8aUgxRTZov+rEwrmgyKup9UOvd5c0YbaKlc
Rw7pXPrDCwTGKQVeGda9CJ9c0M1pTOiw4u7MtEHX377Z8g77fLgef4P4wG9nDfzqDfjkWx4H
fo1Rwy/Ov3ljPsC5Xg/D796Yf4f7L4bh73vzO1Cg3r40olIkyp/kjBlw7dXA9VcL9szw3cBT
187gEJzEfEZE4g91F+B8zbJOMrpdOiUphHVEEsy/DNArwjJMxMgVwgcnU89Tk2qrs0Gj8Fj8
72ux334fnbab5zIB1MaJoObBoeq4vG06xTO7Xpg/PRejp+Pun+IIQ812ONzdoZ/ns3YoJ1gj
9sJ2RsjnJ4CKyqV2UosxzSr2/MjiHn/WhrCrJGy3/PCCZSPH/ca0I8QZ/pTkY341Hvvigsd8
YhSvjXrtonZW8S9zD8vY+fo18ysZKoma50HmdQeMMgXDpuEcYNaJo2l5FLEZiWrtni9JlLG2
ooQ8d7MwznTH9TL+dZVnamxsVdlp0k+1ocCUQRfX5LXRvOePIDACXHppGXAaB4a726QMWwPT
AzdALAGRVjteWRErZqnMCsYLj8Zqtv5SBVILnpqYcSDV3JgunxjGEI4w5rp5sclgmXG/FYjz
FVkw9CN8ei2NO6v13MW2CvIJ3moFL8XCkFOOoVxlhy+FhzVnN8+uSB7EJCcmIVFmwF9PlgB0
PIEK32UBDi6iZFSDA2KlNdAJV4K6AyWG46hHU+ql2KbDEEae/sGw9qkpCrbaNlhi/iswKS+R
ODdr8ILiy+b12QxgEvg0AtEfber1tnaxuN5ztDkWo9dT8dReQiRWKDqYSrsffwM5Nv9r3TgQ
BBGGimmAbjvQqsYGzqf0gdP5g+KUtAjjDoI2ua1y5881rLmrztW4KfyMRPyxx8VOmXVz3P61
OxdbTPv++lS8wLLF/txng1K/9PIrpV/mZdM/QBflELUzX6KorMA0/JslQOkswTQwxepAxw/M
FDOVV82TfOqWF81CHMjCiACo0R3Qous5lqOSaS8A2Mg/oRzF+nPYSVEaeJgl1Di6TEoBkUfy
B6NVDtVGM6cx8+cQ4fbdbYjmjMWs1Kgn4wU6U/Pwoc5Y9xGACasaaAdowjdk07x7R1j0j0VQ
Vby7R8eYOyeoMjF8qh6oUhsOXplUs4dM5sqN2dtxzARWa6LZ8t1Uy0KXoXamsY1O8xnRc9ij
jBTQFnjBWOZ5A6W0dCiC7pWuCPAuRpnmWgm8+JJosGhx712A5iTmZYmGxumazmfdtRhZ4DkY
Zk4J/ZRx6d/OWF6s+taNC56rUYxiZHwBlIcgTk4avTulh9ja0ApCCYSpg3kNs6V5XxRLEAdh
7/ZD4/BTCjt/HWlRF03tXTzlyq6G6FcoOxggANUFpYzykFvmC0BZBMKPaggT/8htnvXZGuUr
Kcv7eI4OjhKhRhigiFXSRWkE2OxgEqEOw7Uv6GRRLqVgLGeqkuSIl804TSLEt36yhNACNKGd
GI7g0nPMwq+IDCyAwG4YPut5YNU46SjBKl1TqiJ8D9/+SzxD53Z8Ywa5tPtgPiszK1drz50C
H3HwUhyclp27wEuFCTTXOXCh4wq10jlU93LTGWW9AbWKSU/X/teMiuWvnzfgeYz+Lp22l+Ph
y+7Zqdw3lCB205FVFrjazPWFlZwLx162NMpmPHFKF9bwxcz4G95DvRVIZ4zFL9usmgqRipHw
cUfQnJDODFWhQiSIrwhT4WQJwgcnl2B/yqE1fkNwXEdJ2nSFDfSC1JjeAm4FRCGQaEO77R9d
OFagL+3SIA50d3XRsNx8CRGZcZXHXKmy36Mq7uc8NmzrP5FxjICX9fz+3e+nz7v9718PT8Bt
n4t3VgQveQwPAAo0yBdYIPRW6YWR7rYaXpXtp2o21LjVVvY1m0mu/Q0zNRZGmf4LQIzV1J+V
QZgyEQYZ6P8BhLJnEmJrKh9Sr8Odbo7nnQkz9PeXwvKswZhrbnzHOphxElvgcictjj/lxNdv
YAgVvrUGpq3ewoEIhb+BExPqx6jhKhCqxXDeWwV5wNWiFzO0i/MEjqqy6WUalIiAUBCLD3dv
UJvBeqCo2Rv7RkH8xkJq9tbFQHgu33wnlb311gsi44F3qjBYyP33i42Xdx/eWL/Kugxh1Tm0
DjP/ZIlC/MnNBuBYGtu/Qc7zOXgI4Fm3HT21EeSi7UeypARW5aIsi2Ajipv3tICLh6nrrNaA
aejPdLr7NdmRUp5VChEnGg6guGyydOEm11XCL8G8c1egr9jQZBvoznY9CaLBTaS5jFcerydB
TxMsVkTSFDU6CQJjB4xWt7IzTZbMPAD7Vmxfz5vPz4Vpvh+ZpoKz9RRTnoSxRj/Vqm9FodsO
g79MXNfUiNCvrXrbLGYo11JU8tSpelYAMEa+Qi2uXgWNzUMO0W0OFRdfD8fvo3iz3/xZfPVm
OKr8aDewJ0rnsyztXO+CsdR0n7ivZ2BlgrVuRJ4LjZ7UWzgS/mXHryqNwEVOtWEAU8u9aQ8P
TjTtSreJUSVDtuj0MzTKcyaJ646buAmc2WnmNvmo2DO/fkcTYoAmNux0fzP+eFdjJAzkLGWm
9pwvnIQmhbg2MfGiV+uEEOZpTOwM6CR/b/tjKoRfYT8ax1L4WKdOtZQV2Spz5CiMoO4dwQhp
MdTLCufEY/Y6VUtPPkvLbw72RfF0Gp0Po782/xSj0u8PFbAs8umTx6tPNSsjUOI49MP8215+
08mcFOd/D8e/wdnvczlwzoK5/QVmBCwg8XENWsiWYTJjf6md3wjLQSGcepwZ6y7ZuoOR389e
hzI2eSF/tynDIM3X4MnLw9e/0rJNkILoOg+btuliKSAekb6l0jxNUmcx+J0Hc9ofxDpc2tkB
xyUZKDPjCXg64NSXwBmqTRZn/toqHs2Q7mu0ekhANYgFdwOoctml5oObhsLfoYO3mpP5MAzC
g2EgT1FPDTyWYQ3b6MGQpmk97K6UBekwKxkMSVZvYCAU7hXzSf4YAXeHf7YVBQ/lDQ7NpnZ+
qNaMNfz+3fb18277zl09Dm7VUNN3urwbqIXDzKGHww+uMBcXE7nwUIvHTnWKH6VBQBc+dJjC
zE7nDyYNA1osToc0HSCXOUB/9JNeAAK/BnTgBFh/o9oPkwO9Axq4aiA08Rdoo8nADlPJg9nA
FyjIL8pvcpYRSfIP48mVv1M0YBRm+ymJ6GQoqor8nRDrya1/KZL6w+F0Loa254wxpPv2ZvDM
xk/2H4v6OjuDRGFfv8BP5RzXDR6DmGjWH4umLFmqFdfUr1qWCj9AGvj8A+gE/3gxLO1xOmBb
8ISJ8m85V8MWp6Q0YP7DIEZ0DVGv0iaa8WN9knp4g4S6n7RYILlG1+whd9vEp5+ijqUfnYvT
udPeYcR/ocHd8YY9vZkdgO08WBdFYkkCLryHocQfUg7kVcBzkGs5JM8h9m77X7ijNKrhFcfi
iXJsHw1nyPNO6095RzWg8c8+F7VTZirEMaEGwQpAqxH0+NBTm5vGhbIuaymucMEHUoP4IB8H
HFzCQz+ApfN8KPmVhAP9ZgqU+dDXdWiZQz8sWuksSbzlWiMIEMChT+vccEh4hCGmLw+h5xr8
81pka5YNin92W3CFTZOP5ZhWfYxW4qD7o/o2UrmD7ecd7QVQbuIgkB1fpwVAibIzEvWIr0G9
gZmWC0UGvoBz0TA+/yHk9gueQUSw4X45wMPHXtWBEKwfLjqfI/ALTSXmKvVAaz8CufDrNoSl
0u9dGhhR3G9VzOngjXJgO9M/MfBYBmfgaQwMq6qXd/ihiy4RmZzgf/x2oozlEb2f34Wx7WF/
Ph6e8Uu6p4a/ndsINfz3aqAPDBHwq+o6Ru3tERSn3Z/7Ffan4Hb0AP9QVqtrpcIvoZXZkMNn
oG73jOBicJkLWOWxNk8FfmxiwO3RT97uW7xgSgIGL5CnESk/Hx+8hT/eT66YB6XuFHxz5yZR
6X+V5sXY/unlsNt3acXed9MP589+2hObpU7/7s7bv36AB9Sqcip0t5fPWn94Ncs6rKO8o+Os
jSiRA59JkpR3bHjbErTbVqp5JPqtkFn54dCcRemAhIAHpOM09OldsJtJQCKnep/KcsWQy9jk
4c3fV6hNRbg7fv0Xufj5AA9+tCkJV6YY2KWiusDuxCZZYQpcWApyEogN7ZidCSRfDh7OILCl
HGh5KhHQSFbL5GVazx/LIBoxn61VyKaUdiFlZTocMi0MnlPu9b9c09T3ZGyu85SKo4+AjYZD
HBTPeR9mdejVi1r8KMB9oEPfWs0SNbCR9gXbgbYibBHaDyVMzkkP/FEPgGIqVzvNPDBYJvy8
oIWY/uEMVJlyZ8zJwsNvJ+cksCtEMblkQV4mkW1qyyS8L3MFQGzCrDMIVMyZBIHodnXglyXN
lx4pkb1vhMohzwZV7dNXV02yKMIffqe9QgqHC6YIRr2uFJwZIvPrydrXOlGjRkJYKTR71GST
TVvO/Yf+FqaiKhDvIiWBnF4mNXkDrtYfLlAvSdwnHvtkSrqv7nwwEx1cT97fWceigRQxRmY0
WPoJwlZp5Bj0oC9S/NaJpXIfpAwZlzFzrH33mhDuDR0AkA+EHAbWS1XVEaW9Y+l/7E5bn1Ii
we3kdp2D6fW7BqCx4wcUxIHsB0n0wOejmoexUfr+5AhVH68n6mZ85QWD0xIJlYF5QgnnQ3/u
YJ7mEAz5nzQN1EcIH8lAcoKraPJxPL6+AJz4fUbFEiUk+NCAdHt7GWc6v3r//jKKIfTj2J99
nsf07vrWn8UK1NXdBz9IgSj456zytfkwALXIoC9Yu2K9P+LU5snwE16IxYNw6OOISVc7lpVO
BpY09rmrJQQkceJPl1Vw/HCC+vPJFUZM1ncf3vvTeBXKx2u69md/KwQe6PzDx3nKlP9ZKjTG
IK648Upg56DWxUzfX417clH+XZ/i2+Y04vvT+fj61XxNfvoLXKqn0fm42Z9wndHzbl+MnkCW
dy/4Tzt2+H/M7jNjxNV1zicDGSJMOhP0KlN/voXRuV8YsaYM0yn+CQ3qD1wNitRq/QMYmfIH
zXMyJQnJyUBovEzx40/vcznqsfz7LZgjLEf6n5MjEDuxbBsvCQ/M32jzeuI4gYo4tmvBOOj+
cnsczQj+8Z48VLWDbsiq6Bmdv78Uo1/gQf/+7+i8eSn+O6LBr8B2/7E6B2pT69BK57IcHe6/
MmBfkqmZO/N5OFPlT3b8H2XX1uS2raTf91fM09Y5D9mIpC7UIwRSEjwEySEgiZoX1WQ8iV0Z
X2o8Ppv8+0UDJEVQaCDrKjsR+iMI4tpodH8YnkJM0F0FlbBlQQzRGlJUux12aqIBgoIhfBpm
dK072Y8GWzfXj9bstgFtyJaGEEz/GwAJ4P0LQwq2Uf/xYJralU3PMTT53P+y6/HUU6GNVj2Q
YMdfRqoDIT2x8boZ290mMXg/aB4Cbco29mA2eewRdj0yUUue+qPHJ/6mfY0cP2mpymPdtu61
oAd4W4qgpgEjJtRfPMLoylsAAKwDgPXcB+BH7xfw44F7WiqrpVo33LO/eT8c8qqO40E0lCOn
Qlqeq/LFbjlXWoGef8v8dHP8MsV4VIgB46+KWiYhQBwAsIR7PlVw0sj6wVPfh63YU29/lgzZ
vpmRdRBqKp2uhlYZzw3COqNLeLOS2stYm0TryFO+rTlZQBd7M5ciJGhGWIKzpFdOMLOv+QSZ
e4aDOPNFQlM1cSAqtimgpxEfdAVfojj1FOKhIKFJMKPJeuGOfDfjBgq6XrnVZo0oRZ14vuKU
raK1pyrwIwyjofDA5FXzdIbs80z+E5VgvH5NNLDBRiPHehJsaMByPbLhqBS1n99UED8E8YG2
SIcnTDKotWnSKAUj+/b/fn7/pMr29Rex3d59fXr//J+Xu89A7/T707MVeq8zIXusP/dSbYqH
kxG3ig0Imh/da5GWPlQNs3bj4zdshbWi6zQ1EGi0jJEG1uWC1SlQdsEKe2c2qk5VNYN+qmrp
eVp9zz9/vH/7cpeBU6Gr6upMqVUZ4nKo3/4gMBunKVyLFW3DjUptCqdS3CXUMMsuAj2CMU+l
cffhnJaVHhnsC5lAeBm7mvYJkSlRC48nXHgoPK17ZJ7KPzKZC3G7X63/eXXWupshJTBCjhxZ
amEjkcXMiKVqKa+8Tpcrd1tqAOXZcu6Tn3U4Dw7ItwShO9Nzk1IYlm6DwyD3FQ/kbexWa64A
tylLy5lM4ygk9xTgA2e0QcIXNEDpK2oz4e63GlDmkvoBrPxAkFXKAES6mkduu44GVEWGjlgD
UDoRNstogJqH4lnsawmYqdR7cAD46mBargFkiAuJHsDI7tgI4ayjASdCT/Zq8lgi+kbtmz+0
UFZizzaeCpIN2xaI1lT75hEtPLFyU5VW5Zl5hFW/fPv6+vd0LrmZQPQwnaE6o+mJ/j5gepGn
gqCTeNrft3ib9n2cEstYJ72/P72+/vb0/Ofdr3evL388Pf/tOrKGfBwOCfaLbrcx/SYmuz02
Gadxw/yb5RDxbQVDqr0RK3NkJlNSUPNcnDmdKJpkptM8+PliOXlCO5FDYCNWAn1mh4Qc4rEO
w4EVclKh6W3ws4rtQbjCC8G/8y5K1vO7f20/v72c1N9/uyzbW9bk4CrnzrsTXspKTL6rj5by
vWZUOYSyEgZwd7TtskKqSVhVA5ymXHtD2X25ZcxToxQzsukDIacEPmN3wOwc+YOmRvEEGmAH
XeConiPnGeqrwT/YKWM1Kjq2mASGHeI9sCFNfsjcasYO8XlW5RPICQmsiFUpKsRtUB7cBVTp
l6NuNH33AvL0ETvILAuUo7OZOlL3LQeEHNbRO7z+mJdZ1VwSWllH78eqwbbV8lzvK2f85Cg/
kpFazUtWPK5J0mw928k4cmSwy+3OnMsoiVyn5OOHCkIh/M++vkIUjFYCGUjXR2Vuh4URmmPG
ke4ERYrQR3DyOD4psER2sDLP0iiK0IPrGhrVVqsceaqxWUpGrIwfkGDX8XMNdZcRekxluUIS
WWC++IXbNAACd+cGCVa/gYbeNBXJJl12M3ebTjaUw2yAHJGUrft7KNb2ku2q0q2DQ2bITvMs
ZM6nR6njB10j1v5g8AG0vrck/mc6p0Fn01JyZAfuFu3zQmgy9GtlmKSLdDfxIHZXyyB2t89V
fHT5sY5LxgS1yjUdoI5HdFCnNSJ2OQTDD9Ohe3V0T6GjjDN7ctOrm9qaOymFR091/tzXFxWx
24tIHMps6nR7m1+uNK3comTZ5HGw7Pkj3dt3IZmUS1kDZ3Cp5l4OvoXTUXObEwRAgxO51TGB
oG7LiWvS0XR2D0oDtPsXJLc7IEDgE/fKvs0YKdXWfPoMFJBeWI5YuK8QJNvRl+yqale4x8r+
QE45c4pYGi/a1i0qpX0sl2NW7Hy607AliOPNzv3NKv3ojohgLfaIEiAvmaNvD4w7bWgA2qZx
DXzgge5cMGn3Zp2g/50sjI43GtOFtRM5LudJ26KLKj9O+8V1+N0jIW7i/hxYhbkqBSkr6zt4
0c4v2IFW0S7wTYuSipNXvD2Fm8LuifciTReRetZtx7kXj2k6v3HgQBp5OpWob1+pWv8n3UNN
xM6hw8+NxXgJv6MZ0iDbnBRl4HUlkd3LrhO2SXIr1yJN0ti14x3nCdTIU56QGOlOx3YX6Prq
f5uqrLh7CirtsjM1W+b/v5k6TdYze8GK78MtXB5ZZuuT5ka14Gis7q0SK7yTUmD0RBdMn5c7
Vtpx2HulRqte5qzYcw6O6VsW0HDrvBRADOesXHPAN37jQ0ES7Jj+oUBVQ5Vnm5cXTPzgDI0e
F+QAvlXc0mofKDioYQTpDQ82fJNZn9YsZ/NAz25y2N9YakoaJWvEnwREsnJ3+yaNluvQy0pw
CHA2TAPhrI1TJAhXGpLluiRgGZvO9Y4n8zHZ5lgA3Edb9ddSZgRizlDply00V6DnCVYQe46g
63iWuDjVraesEaB+rrEjcCaidaBBBRdWH8hrRtEjdYVdR8ghghbOQzOjqKiaF+GqWGc1Sz35
W58nOeh+4aY7lPa8UNdnniPcYtA9EO5xCmH9JTL3Mxdj+rgQ57Kq1X7O0uJP9NIWu8kovX1W
5vuDtCZGkxJ4yn6CXWitVAIgIBAI65YsnNr3KM+jPaurn5dmzxDufZAegX97QhN3m+2JPZY2
R4pJuZwWWIcbAImTx32UuXFWHmfeuS/D9Ag6ojP/DkNahk+jHaYoVHtgmG2WuXuM0n9qZyzp
/lywzcg74aRSrj+3rAXOH51kXPsZu1M/e1cJ13kC1w+4TSYZeOFgws4whAPaNF2tlxsU0Btc
cADli3kEpzo4AFzffPJ0nqaRF7DyZEAZJRn+iZ0lAJVn5Mh8H8hoXRwEKi5aiT8KW8FLeyJn
/HFwjJPRLIroFNMrwWZ/0/WYq27cJSv9GM28x6RpG6s/HlxrDo4uOxSSK31QKQcXpX+iGL3h
8Ir1ruEfICTeHYYtBI6opFJWlT6FIsw9BQQva9nWFzpfXOQHotZEvO8BLoR58Ba2U7o8cq0n
4XKlK3krFdZuXCjzaIa4XoCpW83CjOIvz2rYMOEdC+SSphHemjqHeeqXL1cB+RqVd74vqLxb
AXZqEo4b+Nc1AjNWXczB2/gUlvUscP3Efirhqs/OxtUlVttJQp9ZMyHt1dkxuSHIuZ0BUOCE
ZdhSpTF7Bu6Z6HKmMfyIhWAYsaBUjTNmaVFmrQK7Cf/5+v75++vLX5Nlqq+SCz+03VFwkbfI
iaEN5sAqt7t5XU2FZ1lU0ksLECv/ISL85tHRkzXiWus25KrKMhRH5mR23G4gokS66xqE9+SE
maFAXOc7IpBwYpA3skgjJEjtKncfZYAcrDIpsqMFufqL2cJBzOq9Wzs/FeN77uDX9QSQm02k
SyatAzr10+OcqqQLzFRhZ8rHtx2MRaPjIoe0P1ZwiHojLiJq1O7O2pFUEFQVKOfVUOkSdusr
Ih0Z3BzihnTHCy7ZsKl3CccBTGPB2Bd3nC4R/OM5G+/lxyKtgualfRZzIrf+GOAZ8fry48ed
Eo6H+ek0Pevvhrj1wGjK5y2cmWKWGicBz1VlE5nDU+Tr95/vaDAZK+vDmEsRfl62Wwhqn7Ir
GZnQl1Hcc4S704A4AfLjKUgX5/Dj5e0V7msfnHGtabF7vgLqcIRdy0A+VGc/ID+G5JOxO6qt
G9KiybP3+XlTYc4mo0/wl18o9cR9jmYg+pYShN7NAKoD3QultyJG+q4kE07dkR2Ozd3BoPun
t4+aUIP9Wt3dxquBCdkxXzi4CzTUOsckPL89Ue7GhOu1gyeSqxubUn16ent6fgfKlCHEvNcC
pbXtOLqsjkBdulY6nDyP5gDj34YmdiwA8WKgASgyHWV6AOYCMjCaiJe3z0+vo+V/VINKgdcU
FdSKyjSCNB7f4jlKHBFo91dguXH6IlByORKVNLmnegzbwoLgYpMcg6jxFHK/yGLtGgvyljRu
SdlcDqSRI4rjsbSB61p4PkCc5c5bNSu7r+i2Pm8SkTCuSMRbfVwSGavNpw+mFGSXU6YhXvj2
9RfIRqXoTqCDZh0eel1W8LlTc5CNsAm3R4mjBprm+kEg12sbsWBbhjic9QhKS2SLNSCiJRMr
LLrPgDrfow+SgJOee06zoSFYt/epRRCppiWfuKmR6CQj1hfX1aF3aBQrwT85BKVgZYa7YzK2
Y1RNF25Oo8nUcZNNacKVM2wVguv6zAWj++Nlcwb3MsTrsLzskF5SVo8VdtoIZDIS8YbdH811
xL5q0PHayN5B5dvdnYxsixs18/W93r3y1ZypRajMCoza7eS7fZ7UNbjfuWnRjxZrvL496fpT
iadkPZKqv7X7RaoXF2esGrQQ2+ua0l9kcxBSB0Z7+LFuV0ij68TUoRDGI7c69eOiFR3VtSs7
2VztNEnbK6hNPgTJE3brkcQwi+lls18yoVCDHgC8U9cSdrvqO8Eh/dO3H+8B9jV4hdpdRIvE
HbkxyJcIE0svR8JbtJxnq4U7vKYTg4skKmcpEpyohVhIBggh1MDtmwbSUh95u2c2Lddn5Jdd
jXCBK4hgYrFY4zWn5MvEvbnvxOslQmuuxFiwRierm1vCOt1f//7x/vLl7jcgJDMNfvevL6on
vP599/Llt5ePH18+3v3aoX5RK/Dzp8/f/z3tE1ku2K7UBHTemIop1rmb1z28ptNOX8HKjLD/
QOvRQDyHqUJ+wxk4Epsl8Kaa8r/USP+q1g6F+dWMlaePT9/f8TGSsQr2vAeEekUP7TpeIvFP
IG6qTSW3h8fHSyUQbluASVIJtfHCv1iy8jxlWNGlrd4/qfJfv2jUAaZfY5YH50SITi6TeseI
UbWwwHheTXcBSkCceWqAkGLndj+4QjA2vvG8PXouQdScGgm9rJGlfe8mma1tdtlaeKxfpawB
cWsSVWnPr58NQZCDNVRlSgt9Q+w97AGQqMYrSu+6QqBd7SC/hJL8oW+1e//2drvIyFqV89vz
n7frI1DsR4s0hTsSx1fB2OnDPYUoQEdS94terqmo78zh6x1YR1DG/vdv6iNe7tRwUKP6o76U
SQ11Xdgf/2NVpv0+lsk0rhMkDvMGOyXj7g3TNxUzyoSVVDbus31oA4zX+uReAA2zMrAsIryx
PfNyXbhOHvcnbru56YR+fO7ZrWWqNPH1jlllYEvLVvMIoToYQ9IAhEezGKEksDDu+dbGuFUP
G7MOY5JweaLVKoRZx3PEQWfASDQC0saEyqMwS2zjNsKE+O80JlDPexkq8cOBgD580JcCLMCL
yI8XSahcgq6WoT7SssuWAJNmKRvkYqRrfnWOXPYwQGRb+1+oVjVBGFz31CD+xxNgLdzaZY/T
R1IQYuJHiWWADBHICAOVxRb3ShdHOGU6zHa1SFYLhOKgx0gh84MkEtHtetyuWEQpanwZMPEs
hFktZwg7whXhHwd7tl9GiKLeYz7QuT8TNds2URxoB+2Hgbmg9xhJ4/XcP+IMZoVyAVq4daBM
ks6jhb9zACZGtFsLE/srSWPC3zaPl+EyK3Xbi+GkjWL/hAyQ5WzpL48GRf4VQmOW/lUNMOtg
eZJoFeiJwKAZGswakwTLvFwGOrXGBEhUNeYffVigI3JaJ6FlX9IlcmHPgKhFnKShvtGs1Mzi
VvWGPsYRo8cVsAoCAl2dBzQGBfB3qoJj9FVXQKiQaaiQaaiQoRlGqT0hQKiQ60Wc+BteY+aB
eUxj/N9bSrXL3ucNZzirUQ+lcpXO/N8GmPWUhnaKqbUXpR/z2KpNX0Pu8zKwENFtulgjWwaO
mVL7p8VGYmxnA6LBqAZ7xF4GhrFCJAhn2hUxDyJo4C0e+1yPyTmN5oGZQGHiKIxZnmKMR60v
EBd0vuJRYDgIKcUqsCILzpeBhYtkNIrTLA3utsQqjQMY9XVpSIEsSTzzLzkACXRzBUni4CKA
0en1gD2ngVVL8joKjFwN8be6hvirTkEwGvUxJPTJvF4gFFE95MjIMl36VeGjTOPARvaUJqtV
gp1MXTEpxh85wqAck2NM/A8w/i/XEP9YUJBilS4w7mILtUR8NPWiQFy3gZ0I3IhX7WwfKJOG
mzoHRFmdyLk6uHwvBow5qjMEv+au5BFn0ICCqwS1NUzlNr6FbQDg3MDXNzXasghX0XQ53RiC
Tk/vz58+fvvjrn57ef/85eXbz/e73bf/vLx9/abtQjYI9xWCSOLhxc5SdYfYXswjYw1403hB
/VVLXlB28stB1YXIYy+IFIyvoll0OWWIa9Iymc1ysUEB6V9//TUV9rcq/fLb04+Xj9fKpU9v
H6cXKtXUW0CVs+u+roPYBDNXGHfmfYOCz2slBNtMnC2E677MDeXECd9MLrg2zsngl/z7z6/P
YNH1+A3zbXYhVKZqD+2eDDVAJCvEgtaLka1sDdfLk6xeLJC9vn4enFYv4OxAkQP0K2pfUIR0
DjAQgLOeIYumBmTrxSriJ7cnn35NW8ezFrUVAITDyTjCDQffm5H1LMHLAOJF7H2Dhrjn6F6M
WGkGsXsR6MSYF7UWF4jKDMIdkblm7bvskJMSXUE0gtBhfyXW8RKxJIN4z9RuO9L16cQodVbf
DUjd31nU9MKQ026QYSfh8GoTqVRz93SjEQ8C46AF8QdSPl4orzBeBcDc57xGuBdBnKaaaDgg
x3uIli+Ri1hMH26j+QLZUHeA1QqzlF4Bno5kAClyNfUAQNSVAZDOvYB0PfN+RLpGzj0GOWKN
ucrdKquWy2WCGN96sS/3vNzG0Ybjg+TIaiB+xpyyAFLKFjnTB6nSStw2cxCqve9CTRR49TYZ
TTAuVS2X8xRRkI14MfPlThdygdhbtPw+RXYLWlou5BLZrIFc5NTDGAIANl8t2wCGL5DdiJbe
n1M1iPDZUqiNiCfzs6AIfx2IJbChJ8mivUih9DG8jYs6WXvGSFGnqxSvJ/Wagnv6CCk4wv4v
a7GMZguEIE8JFzOEfla/VwM8s4MBIMayARBH+PiCT1Mf71mKO8QCsQ2M3uKpQACkiGvSAFhH
/hVfgdR8jwwmeSrms+T2pqUxACgt/J35VETxKvFjCp4sPENW0mSRIvT6Wv7AW0+THtvUo9UU
Fd2XZIdRtoJu1rDHqiTeijzxdO5ZOJU4ifyaCUAWsxBkvXZbVfTcVO25UjVXERZtNgYpXdAz
yw05hUFKs235we0tZWYj0KY805nkW7y4ahsTLwOKseZp0YrLpLD9zVS+Tck1K6BeLQhmTm58
8zpEjl0oEGweapRp0KAcCMNu/Pb0/dPnZ6dHEdm5AtuOO2B1H7EcdAn6ivddfRBwv+N12+xw
7icqbXyhYVdf42Rzpe3b05eXu99+/v77y1tnKbB2c9uNs96dj5nrXZ+e/3z9/Men97v/vlM7
q9u4rqvWTLMLLYgQXfSvs2Y3hN4XOmIHh/Z3wAbePFxOO22O0T65OjgYuPcsu3WzUomW8w5T
W0EiZd6cVbdv8nKHhKUqYEPcoR2HPXPFi0DWHd/1ELbz/eUZnO/hgZvYHcCT+ZSuVadSetAh
WVjJFKJx+kJrWV3bZoIhkSEu7CA/NLnTZqcrLC/uWXlTjbms6ovz9nUQ033eNCPGD5PG1K/z
NCdaHbDJH8ScUFIUSIQAPK6HNS5WXybZMb+IzWzhZH/SKHM5wrRoqhPsqrLBrroASM7FpBZs
cZFjxg0jdkXAacnjfX5TVbucbxiyKdDyLeIGrIVF1bAKOdkCwL4qJlFclvjIjqRAeWBga3v2
d9v7M16NB4pf5QTyEymw6zNM2fKTqNyMqPrbz42mu5hWKNCm4IXCaHVA9oFsEFsQSOWJlVig
jKmrUjA1+yD7AIAUVLsm4vK8rI5uQ4MZNqo68ehRAykkdiOGkZ+3ajrHG7TJzQBBKn3MgzlO
riB6/LZza7YEfw8qkXsNjKxhblMuSIHS2xWgCLKalHBqoYaHtViMkn0jvM5LDmGcWOa5JMXZ
pm7S6RC0hdx+puUFAX881aXxAaswZyHJlOTaxjRMqSOeJlQv8QyB5v8ou7LmtnUl/VdU5+lO
VXJOLK+ZqTxQJCgh5iYuluwXlmIzjurYkkuS77mZXz/dAEkBZDflecgi9AcQa6MB9BK7rkOL
UzMVY07y/Ur4qVPJIuxmsumoY4jG/DyC9aVfU0WA5mG2bp2JKCL0Z9StGPdirxgIWkc72cBG
o+LdfY/vsWSeL8iBJQsMLuPUKxV9hlZacCzPB9hCgYJLmWT0YU6z0qEdaSlhOrPUB5HGgw1E
JwhsmB09+viKWM4Y0wgljQTdmHmNMSMhUDWvMrT8h/47CBkwYUK91fCexX/9/e5njpZm1rfb
4pRtGjIf3pRFk9EDs9cN+WIam5jlt2buZk2MBsQYYS2QeR4IjIItTSclSK8PQHZiG9fX6osi
SGTXfsQgK0v9mZOVM9ezirPL1rbdVsFOFAHPdAUGu6xPC30zDwxoXL28rDbV9n2vOn/7hifI
vT2+nlARVYDTppnM8u6nfPgCxllUrE4y+raqnPvIwWecUEYxE9VWdW9O7zI1DWOjeYWbB5IJ
TNzgPJnhA7WyQU/RD1dnSZi9BeeBrAC+GIFIKoDpfxubZD1wx4WAFo3H8H/Uk7Ia8avr5Zcv
JReBEyFLnEkdgEEWNdkebZWa4gs8NKjMc4Ka5zjuGZwRqLyd6bJE22xcl65HmKp1M2tTfaKS
ypI59ruz40gesqJTY7YsxmdfZslgj8ksOTu7Wg5ifBh9KGkQExM9b6/MU4AsQJdjQ4j0xrm6
uvx6PQjCrslFho5IvL6DD5xuteKC+7Lak7Z0agJ37YBM7pAqb0IsfcFEPEJabr+haPubOBf/
PVJdkMcp6pE/VW/AMvej7UbH4/zxfhgdY4qPXle/G22M1ct+O/pRjTZV9VQ9/c8ITaTMkmbV
y9vo53Y3et3uMITmz223pQ2S6in5unpeb56tGx9zGXsu9/SnyChNc3ITAGTC34+p9e5F2eD1
mPqIGnOPcXWguOSCeXqtibwbLrSWkp6gJahm8Vzbz2pt3ym3F8zs0q4AyGz2FsLkB3mUeVWv
qYx1lJrZXpEXtHitq3aXCX6/CMQ0ztlTnkIMrM360gL+vXaZd38NUzpZfLd7/DFR8avck6Xg
gk2pTsDrJdjP8DxCghSgDH20NMpytO9nzDtUn0nY6yZ3U36iMA/oiiOkGDjkTsLhnLtIVm2O
F06aygEEMj1+TswyFdEL+KIvl3kxsOxkhveiPnOXCIB7yM1PIPGghoAJ1KNWa6E82I0vz5a0
SK1AGQg28J/zS0ZX0wRdXDGa2Krv4WBWwjiLtNdF7apLfv3erx9BUA9Wv2lz8ShOtIThCknr
5DQM4bz7EGvI4sx37EKmjjdlbD/z+4R5Q1f7YwxzNlvInNMZ4R7wRci75EJ5F9YKLV46LojB
mZyAlMO4RJHwdyQnTkTJZAKOXiVMexRiMzctDDFckXqCf5q7peWmGRPUDb6dNHNB/rynExun
oH/sDo9f/jABGPcJ5Bg7V53YydW2DyE9e3CDFtVeU9RcStHlpOn+zQCCTOFrPU77+yodRHSX
SO74HDHTy0IKFXCIHBVV6/SOXhB4fsOaEqugyedMJpcPgjmyH0EifqAVp46Q5Q2j+9NAvAxW
FP10bkIY1XEDcnVNs6QGMrsPbziHKA0GNUU53/4NJs0u3fMT35JZcDZmdEZsDKOu2AHR230D
WgKEfs1uEMq4ZDzcdoXh1PUs0PlHQB/BMDo37WhcnOWMnVQDmczPmZBdDSI7vzz/ypiaNhg/
POcMSdtRh4nMWEsbkMsb+lXbLIXRAmsgIjz/wtg/tqXcAWR4ciGEift8hNzcMHtv23ceLM2b
HgNBzxs2AzEZFDoHivDSVLbPjoBH3w8fYDxedj4+UW+YOWPOQtTqoa+M6H8cjKuzs75wn7ys
DnCiej1VVTeM6U3T4EljRgfFgFwy+swm5HJ4mJD53VyCJBtK5lnSQF4ztqNHyPiCkbbaaZHf
nl3nzvAMDC9u8hOtRwjjwcqEXA7vMWEWXo1PNGoyv+AM/trZkFy6jIpdA8FJNcwCHu6juW31
r2bOdvPZTQp+zWDW41N9f6ZpI4hhFpbD/05yqOuO8NrqKWTVZr/dnZry0zjwfMm8v3mojU7f
mwJpUvjGZWmbKbuPXDixMN7udL4yjO8wlHMufcbdvIbxbntqwEw43Xt8G6DEMwyJ2zU4qkX8
TjsMOblYDp02Cy4Qmc8RZNo6NicEz9pRYCiiwo4bo5K5SO5NrpD7qJdQMUzv0I92/1sqlfNS
rqk6mLK+8Sciq9dX6o+77X778zCa/X6rdp/vRs/v1f5gPV40SlsnoMfPT1PBOh90Y1TPIEkw
8FMuQvfg1NdvFXBQYV4IF7ADRuiBqNd8V/kcyrbvO8Yq5hieQ+ZXF7RWFVmIUYYjg0lMuiqE
ehfGKUyrnaH3qPXjSBFHyeq5OignTll/RE5B9aGoet0eqrfd9pFkLSKMc4HnH7JpRGZd6Nvr
/pksLwmz6ZCrNDunMfiow9WNKK/FF6jbvzLtny/ejFz0vDfa48vfT2j78TFDK9C9vmyfITnb
2py0UaQjyFr/bbddPT1uX7mMJF1fLy+Tv/xdVe0fV9D18+1OznuF1G2cF9J166B+ZOecKksV
tv4zXHLV7NFMN2DB+lBp6uR9/fJU7Y69SFRWRxuFzm8cAfVcntbf/Hjpqvj5++oFOpLtaZJu
zhP05tebJMv1y3rzH65Mitq+IX9oeh0rkIR4/vdTMSeZjVjmLqfMD2stZa5xmD0hyukrvLtQ
sF5uk0Vfr1Sm8xG6rCT8sqbzbtBS9DssaX7QK8doAsasZCul/K0xM0mL/bN74Fs/tIdNcx7W
ghkbrAY92bmwweFFb4a3h8zlOYaJuUWlcbwbPVGaNnr1PgLKnIDR4EAU+m+W4fImnHe9T1qw
UC5FAH8ncvijydIpxzdRqG5mT6OwpeQw2p1t5ManB5cJwRC6nMdg9m38ojfMzuZpt10/WbrU
kZfGXf2Lhl/XcENUdKidNOo6T4af7W3fcTWp5AifFyMvLuOcbqiGpaHor6PZYnTYrR7x0Y5y
uZ4zHkiVIWFXs7jR2ugXeczpJ8yrh8+5G5Exfd+XBZL1YqLeW+H/kXBpeVKFJWDYf8dOXaun
r2FD0LPL2lPunEB6Ti6g+qWK95ESYwk0EGgcI6wL8NRxaQ9lnVQunTyn1zsgzkufEt+BctEv
7kJVKs7ksnRc+lq3QWXCLVLuRl6BuCvr7xNvbH4Xf7Ng+FI4cR13Zqlvp0JCvwGN8UjwnSct
edLUz8YcbZIPfC6SwUBWf8znBAq9mMUS5eHuAOm0clK7QaUGFg+yaD10K20lQx9PQW56n7CK
kYCAfYOO6Oln+uxrOGPvJkidACxPReg9FusMHJvnRZzTixvVe/zsgus4TWa7FSrB0TDCDxyS
O2S9QlePvzo2JJmae/SRR6M13PucxuFf3p2n1j2x7GUWf726+sLVqvD8Hqn5Dl22vtWIs798
J/9LLPHvKOe+HmaA5L59B3k5miqYnfc5MQQNSxyqmZZ29tX703b006pxswnDYaw0n6lUwq0d
pkOloeFoHnQSEwejoceRzGNrLioiiHqBlwpKQftWpJH51c5bWR4m9opUCScYpsb0ePRRHvZr
ewyLw+l/+O4lOq8tEqPlIBvAZ0URWhWOQUCcCn7hON4AzedpQnEWjjrjMwJJRVHl2O5AXScD
1eFJbuqEDCmbF0424xbJwMYRyggmAMdvwoHWJzxtHi0vBqlXPDUd+miC6liMI9H77I7lUAPd
nfZ5ccMial/b9nxsiCqX/ftu3Pl9bkmvKqW71kziRReeLRhZXsNLKvC60tSMOoKzjyqXoolU
5UVkc2sQMhIQd72o07pGv7XwEuPOy/wGpcMwTR04ZSUY78vQDcVNvvtTt9/4YKvC3IxwEaWJ
2/1dTm0zrzqVv812RTJjV5jk1leo1NK4w6kbew7Pe7j5FZg9HGSN4vO3P9b77c3N5dfPZ4Ym
BQLgM0LtDxfn9AOeBbr+EIhx1mmBbhjvIB0Q/ULUAX3ocx+o+A3jr6MDop+kOqCPVJx5kO+A
6Je/DugjXXBFv/11QPTTngX6ev6Bkr5+ZIC/Mi/LNujiA3W6YdRREATCJs79kn4etYo5G3+k
2oDiJ4GTuZKJZGXUhc/fIPieaRD89GkQp/uEnzgNgh/rBsEvrQbBD2DbH6cbw8RDsCB8c25j
eVPSrLYl075OkBw6GHkm5OKa1QhXBLmkb+GOkCgXBePVvgWlsZPLUx+7T2UQnPjc1BEnIalg
NMYbhHRRtZdWqG0xUSHpmyKr+041Ki/SW+5NDzFF7tOruIik2zE/aI6acbmYq+28cXlgXkXp
96Tq8X23PvzuGw/dintLFMDfZSrmBer1EofhRqjUdkYqvIyAcYqmjKio7yCEsoymIUAovRk6
pNTmyZzjTX3/VHqhyNTdep5K5upu8K6qIZLihYq1qiKvRVBlvNpw4+S+dAKQtpzO4bIHo68m
QOTDa5IsLlJGn0JZr7qqGDQw0YHciMo1Nl7HrnAMyS7Iwm9/YDRgfJn9hH89bf/ZfPq9el3B
r9XT23rzab/6WUGB66dPqDL6jDPi04+3n3/oSXJb7TbVy+jXavdUbfBu9jhZ9Lt59brd/R6t
N+vDevWy/t8VUo1XFbQvg7a4txhQ0TrdKlIc6X5s28HcSzVgH5Ytg20kSFcZ3qE9Zon+EbAL
0Zp3as1ogkwesZnmNWS+d45hJjuLrKnnEiOQo7xuyK6OUkOxLzh0WihCN7nvpi7jtJuUzLsp
qSO9K2ihG98dSWoBtjEB3d3vt8N29Ii2O9vd6Ff18lbtjoOowRhRy0lkt4w6edxPF47XT81u
XQwbn357ZQj9LDCcMzKxD02jKVERtuTbJCHgGGmmnwxsHISgfr3rdOs2uyYV9L2+nbE9DqKO
dEaUgpFA+VKQSn1b/UNvXk07i3wGnHgIQqptJ+8/XtaPn/+ufo8e1bx5Roc0v82bxmY0Mvpa
tyZ7jBKLpgr3JH24eOGmJxBZSEubTRcWcEwdX17awTv069374Ve1OawfV4fqaSQ2qiPQhdM/
68OvkbPfbx/XiuStDiuiZ1zG7K8mT4fJ7gy2YGf8JYmD+7NzRuW6XYVTifqfg/0g5oytSduV
Mwc48F2vHyZK4+d1+2TfmDf1nAzOLrfrnKlDZt6zWjK1V7cVnsBC7WYJUtrYqCbHPmVmXBMT
aAxR5JJxCd4wGHG/SJmrp2aAUCstLwYHHG1f+p0/W+1/8X0PcuVQkbMT9OWJwbvr5NcvEevn
an/obRxu6p6PXZJJucxRuKnFcsa5WakRk8C5FePBiaQhA7MFqpGfffGkT1RxeqoCH1mEoUcf
4lryidyXaKM9CJGwQpXmxCAsDb0z5ranYQUzhz6jG/RTlQHMmInYe0Rcng0OPCDoo3HLuofJ
OciJE86Xu8Yskk4d9Cpav/3qKIC1nHRwqQO5ZJzwtPMwXvCqm/VUdEIBx9vBbct1snxwwiBg
sP+94ab46t+P7EDDu0qawFFweBQH10W+iLv9pcdl+/q2q/Z7fdLoN84PHMY/VbMRPNA3ETX5
htHib3MP1hrIs8H18ZDlfSd9KRzStq+j6P31R7XTCq3NUao306JMYoxARkO46YZ0MlXa0kOg
7xJd/glURmOOqoYoW4KYX55ihy2wkec/BD7RlhaHZ4r+dNCnl5f1j90Kzmq77fthvSE3xUBO
qN2AgukZfhJFioh9XLNJgEgsH8S3M7Kwj+wkx6rR4l9nk18QOxoabc6kH5XXXxlXxQYQ9fZc
h/EpZeByJ5A5Y4dkwHTIAuEOro8jEHeSLxfDhwh0VeH4YukK+undwLku7Aonvxwqf3vldEmX
B4fqMESHOa66pEJL6f6MrHYH1JqFI8BeecXYr583q8M7HK8ff1WPf683z7bxCb6J4sxEZ6FZ
e3tG3kh8pGxVeNBfD/X39I2AeVPQpJQTOBGCaJje2v7elCYRMc8mEjZaNA4xLiwaPVXYgyM3
uS/9NA4bhSACEoiIoUYiL4tcBvahOE49RshBh24CDsThhLZWaRVoXdkq1hkzwIX5AeyQXE3u
2ZV5IeCWlLzoljIvSqaA884hHRJghwz87hHbBgTSFZP7GyKrpnAbkYI46YLfBxExYe6ugcq8
vwGFJVwTzQB2RQn/7g2B1bK+peHnRF4cDnfUA3JEGakt37j3fMDFjBc5tfPSNv2CTMctmSQs
HzC5+7tc3lz10pTOcNLHSufqopfopCGVls9g9vYIWeKk/XIn7nfLG5ROZbrp2LZy+iANlVKD
MAHCmKQED6FDEpYPDD5m0i/IdOz+/vo3L9hb5pvFrtRua500dUw/uo5SlzW1n3US6leUlhot
pntmiyIhvDJT5nfoPXSaG/eNrSs3JKLufuhkRlh6TIWWBE4qgDfNlDBlDgvSUXLhdFuzaaAb
ahQ5N1TZpkE8McvD30PrIQpQyYzoTOX94srSjJHpHIUO6nYRVpXvGQ4xYuURcwqbk+W7GF9G
mi/ceVnc/+5U5CoMmO+Zg2XmUQHHSlNJJkMF/DggxiBBhXTrErolASUVMMyo7ZI4OcbRmkYE
rtC+REo/KLJZo1RsgtRrxcIJjEHOgFM2+0W9Dfd2V/u1pNnjVerbbr05/K1Mz59eq/0zZYCq
nH3dqr7gNjek45MFI1OreudKS2hSyMArSW/c8E8WK+3gaQA7d9DqylyziHkhRf7t4qitmGWo
DtAr4cKY9bXHwAFTWBPR88/VCkbhJIadrhRpCnBhMg/MBn/uMBxMJsyhYbu7PTyuX6rPGHhO
S0x7BX3U6TtqcPTXYJehfFL7KdSsXDhp9O3sy/jCHJBUJsCy0AAj5KyBHE9d/jtMmPKZwNBa
GNcShpdcqbpumXDxmRT1PkOMr2bM3Q5F1bSMo8ByM6xL8eMUZo9fRDqLWkJlz9qzznIXBjIq
lsha6RE2ilwI5xafh0s0Pyel2o+OimUaWi83r/rx/qwcyMnN/rB7f602B1vzGV0+o5id0rZq
dVXZx1/FF26nnsWJ8TeR4choJpkTgRQWyRzOfMjkzdyKyn3v1sWsyMhkUCvSdyxdB1tuTw2t
hthdOqgg3Dz/1Y+cbWEWX8Kljp44o4yzGdAFIlBtZDT7wmLiRcTwLkVOYomeysmDRiu7514R
Jv2ZG0++C5e5i69XSOBQw6X6u+4o2EICmKj90hvKUPHqjbvIHMZ/m/LpWaPQWyn8dCn30Edx
QxV7F5bJNHc6AQ4b2kB9jhk/8BGZ5oUTEF/QhIHPaFNO9Tw/3Lmq5Wh24Qfxov8lizy8DJ3M
9NvbIeC7hC1N1foAmnp0bmFTUT0ZJl4Zxcf16nndwAeqjOHK+WgLaeXx+y4zbN2C47LrdcpM
2gxLP7IgfhRv3/afRsH28e/3N80qZ6vNsy1SQFNcVJqIaSshi44maYUwg76if3rUTygSqE4O
q4vxCaiJ5ayA/stBNiZBi/lw1FPlMVB/jeyr4UZrdSbYNp7elV9fg5FZy091q6XjjMm8nw2q
yO4gocR2K0TS4Vv6CgZfR488+l/7t/UGX0yhEa/vh+o/FfynOjz++eef/3WsqrLrUmWjEwhK
QzxJ0RFJbd9FdqcqA9s1sHTxVFTkYsm8BdRTkHAY0WUBJwtZLDQIeHC8ANmc8duia7XIBCMs
aYBqGr/RaFDj6y+AgTlRFvaxuq+uz1T0t9VXYQWgR0veA+axocQBzZh0/kBRzfni/zF1eoJq
OvcDh1G+Ox4T6CagdKj0oiJ0uY+6UeoWZqAXb/XmyzCqv7Wk8rQ6rEYoojziVSUhXbNuwWvx
4gQ9Y44ZiqiMD6VgfJcr+SEqPSd38CCSFoR5pMWGmCZ1v+qm0H9RLp2gb2WYugUtbwEBJogT
DMwyhJycighKhf+hstjJgFQxz6hjXOPFxGpHb+HPa/k/JST/ZmU5IFu6950YNubO2p5HVEXT
zt7fUqepk8xoTHPY9BW1W4A+M4fKtlvpyaVeB4L2hbgmFBLE1CjPOgi3zqhLORIxh83Fm1Nj
U5W2IzrN5BfvEACWPuzb/mAZaiscAMwWMCZDgDiLQFQXQxAVA/5EMToOfavNqZGMLa8eo3oc
mOibKn+ZRU6SzWJKHJ2gC+QZbp/KQLqrkNqkYwgG2Dqhk3QGZm9r4TAxBoGNR3UZDyy17D7K
Z6W4A4bBxRDJsI/kdMp10nF2Hp9xmJoLEQKTS+c6aALPHjInTAIyWoxxhFBeImSmNuWFGbhA
a2PXCOviMbZpPfb4tv2n2r09MkdStEqrlSYXIk1jSskSQZp4rI+6Q6vXkCeSfPbtyriuQUV6
kIlBSFULdmgHh+mI7q1BMh6EhZks9c3hMG4ZMifriSeH/CxP4jhfwuAt6WKxC4STBvcD/Lvf
0eY9Zl7tDyh9oKTtbv9d7VbPlTkSt0XEmT/UO26phgDOh9/1NRTdnWr9k5jubLu1tZj16e3/
CruSHAZhGPi2UqiIaAliqbjx/180M4aKJWOueBRo7NrxmuSVpccm/0t3yDUBn1mvT0oaUWew
BNw+T5Wzix1Cy1F92mEZ1I0BpJbhK9JoxT9SC7lwrHOBOiaHzrxFfEdMfZMoTjVJ7t3iL9ZV
fbLRmr5lEHxZ3tecSxC3p65mxHKEnetv/4TGAQNae4RQiytueIoSFwKahBjFyBgCqDzy1xXZ
G56P1iGbHtD0aRI3L5E6M9ml6bnIyRHRI7l6iQedOKJqe0gNZb4Qw1z3Ju8hbL89ioGXpK8x
G2dzUP8ju2nsHZ23+aisqCMPG/lC51doS3znjeU0TnPahPO1NKqeLLK1R/Y+mTx+oiMPaAdJ
hytPNY0s2hDqeVvEB7DZBqFZeQBAm3taBui9+lwfZS2Oa1oufTWWR/sBTOHJ8tEyAQA=

--KsGdsel6WgEHnImy--
