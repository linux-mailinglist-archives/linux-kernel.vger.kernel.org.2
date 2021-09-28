Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A32941A4EE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 03:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238595AbhI1BqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 21:46:04 -0400
Received: from mga02.intel.com ([134.134.136.20]:11798 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238496AbhI1Bp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 21:45:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="211848578"
X-IronPort-AV: E=Sophos;i="5.85,328,1624345200"; 
   d="gz'50?scan'50,208,50";a="211848578"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 18:44:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,328,1624345200"; 
   d="gz'50?scan'50,208,50";a="707579586"
Received: from lkp-server02.sh.intel.com (HELO f7acefbbae94) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 27 Sep 2021 18:44:14 -0700
Received: from kbuild by f7acefbbae94 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mV2AI-0000lP-AE; Tue, 28 Sep 2021 01:44:14 +0000
Date:   Tue, 28 Sep 2021 09:43:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: kernel/trace/ftrace.c:128:31: warning: cast between incompatible
 function types from 'void (*)(long unsigned int,  long unsigned int)' to
 'void (*)(long unsigned int,  long unsigned int,  struct ftrace_ops *,
 struct ftrace_regs *)'
Message-ID: <202109280909.aPlO2bOQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   92477dd1faa650e50bd3bb35a6c0b8d09198cc35
commit: d19ad0775dcd64b49eecf4fa79c17959ebfbd26b ftrace: Have the callbacks receive a struct ftrace_regs instead of pt_regs
date:   11 months ago
config: nds32-buildonly-randconfig-r002-20210927 (attached as .config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d19ad0775dcd64b49eecf4fa79c17959ebfbd26b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d19ad0775dcd64b49eecf4fa79c17959ebfbd26b
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=nds32 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/trace/ftrace.c: In function 'ftrace_ops_get_list_func':
>> kernel/trace/ftrace.c:128:31: warning: cast between incompatible function types from 'void (*)(long unsigned int,  long unsigned int)' to 'void (*)(long unsigned int,  long unsigned int,  struct ftrace_ops *, struct ftrace_regs *)' [-Wcast-function-type]
     128 | #define ftrace_ops_list_func ((ftrace_func_t)ftrace_ops_no_ops)
         |                               ^
   kernel/trace/ftrace.c:174:24: note: in expansion of macro 'ftrace_ops_list_func'
     174 |                 return ftrace_ops_list_func;
         |                        ^~~~~~~~~~~~~~~~~~~~
   kernel/trace/ftrace.c: In function 'update_ftrace_function':
>> kernel/trace/ftrace.c:128:31: warning: cast between incompatible function types from 'void (*)(long unsigned int,  long unsigned int)' to 'void (*)(long unsigned int,  long unsigned int,  struct ftrace_ops *, struct ftrace_regs *)' [-Wcast-function-type]
     128 | #define ftrace_ops_list_func ((ftrace_func_t)ftrace_ops_no_ops)
         |                               ^
   kernel/trace/ftrace.c:207:24: note: in expansion of macro 'ftrace_ops_list_func'
     207 |                 func = ftrace_ops_list_func;
         |                        ^~~~~~~~~~~~~~~~~~~~
>> kernel/trace/ftrace.c:128:31: warning: cast between incompatible function types from 'void (*)(long unsigned int,  long unsigned int)' to 'void (*)(long unsigned int,  long unsigned int,  struct ftrace_ops *, struct ftrace_regs *)' [-Wcast-function-type]
     128 | #define ftrace_ops_list_func ((ftrace_func_t)ftrace_ops_no_ops)
         |                               ^
   kernel/trace/ftrace.c:220:21: note: in expansion of macro 'ftrace_ops_list_func'
     220 |         if (func == ftrace_ops_list_func) {
         |                     ^~~~~~~~~~~~~~~~~~~~
   kernel/trace/ftrace.c: At top level:
   kernel/trace/ftrace.c:302:5: warning: no previous prototype for '__register_ftrace_function' [-Wmissing-prototypes]
     302 | int __register_ftrace_function(struct ftrace_ops *ops)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/ftrace.c:345:5: warning: no previous prototype for '__unregister_ftrace_function' [-Wmissing-prototypes]
     345 | int __unregister_ftrace_function(struct ftrace_ops *ops)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/ftrace.c:584:5: warning: no previous prototype for 'ftrace_profile_pages_init' [-Wmissing-prototypes]
     584 | int ftrace_profile_pages_init(struct ftrace_profile_stat *stat)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/ftrace.c: In function 'ftrace_modify_all_code':
>> kernel/trace/ftrace.c:128:31: warning: cast between incompatible function types from 'void (*)(long unsigned int,  long unsigned int)' to 'void (*)(long unsigned int,  long unsigned int,  struct ftrace_ops *, struct ftrace_regs *)' [-Wcast-function-type]
     128 | #define ftrace_ops_list_func ((ftrace_func_t)ftrace_ops_no_ops)
         |                               ^
   kernel/trace/ftrace.c:2672:49: note: in expansion of macro 'ftrace_ops_list_func'
    2672 |                 err = ftrace_update_ftrace_func(ftrace_ops_list_func);
         |                                                 ^~~~~~~~~~~~~~~~~~~~
>> kernel/trace/ftrace.c:128:31: warning: cast between incompatible function types from 'void (*)(long unsigned int,  long unsigned int)' to 'void (*)(long unsigned int,  long unsigned int,  struct ftrace_ops *, struct ftrace_regs *)' [-Wcast-function-type]
     128 | #define ftrace_ops_list_func ((ftrace_func_t)ftrace_ops_no_ops)
         |                               ^
   kernel/trace/ftrace.c:2682:48: note: in expansion of macro 'ftrace_ops_list_func'
    2682 |         if (update && ftrace_trace_function != ftrace_ops_list_func) {
         |                                                ^~~~~~~~~~~~~~~~~~~~
   kernel/trace/ftrace.c: At top level:
   kernel/trace/ftrace.c:3856:15: warning: no previous prototype for 'arch_ftrace_match_adjust' [-Wmissing-prototypes]
    3856 | char * __weak arch_ftrace_match_adjust(char *str, const char *search)
         |               ^~~~~~~~~~~~~~~~~~~~~~~~


vim +128 kernel/trace/ftrace.c

16444a8a40d4c7 Arnaldo Carvalho de Melo 2008-05-12  121  
2f5f6ad9390c1e Steven Rostedt           2011-08-08  122  #if ARCH_SUPPORTS_FTRACE_OPS
2f5f6ad9390c1e Steven Rostedt           2011-08-08  123  static void ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
d19ad0775dcd64 Steven Rostedt (VMware   2020-10-28  124) 				 struct ftrace_ops *op, struct ftrace_regs *fregs);
2f5f6ad9390c1e Steven Rostedt           2011-08-08  125  #else
2f5f6ad9390c1e Steven Rostedt           2011-08-08  126  /* See comment below, where ftrace_ops_list_func is defined */
2f5f6ad9390c1e Steven Rostedt           2011-08-08  127  static void ftrace_ops_no_ops(unsigned long ip, unsigned long parent_ip);
2f5f6ad9390c1e Steven Rostedt           2011-08-08 @128  #define ftrace_ops_list_func ((ftrace_func_t)ftrace_ops_no_ops)
2f5f6ad9390c1e Steven Rostedt           2011-08-08  129  #endif
b848914ce39589 Steven Rostedt           2011-05-04  130  

:::::: The code at line 128 was first introduced by commit
:::::: 2f5f6ad9390c1ebbf738d130dbfe80b60eaa167e ftrace: Pass ftrace_ops as third parameter to function trace callback

:::::: TO: Steven Rostedt <srostedt@redhat.com>
:::::: CC: Steven Rostedt <rostedt@goodmis.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--TB36FDmn/VVEgNH/
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICC5vUmEAAy5jb25maWcAnDzbbuM2sO/9CqEFDtqH7PoS54KDPFAUZXMtilqR8mVfBDfx
bo1mk8BO2u7fnyGpCylRzuIU6CaeGQ7J4dxJ57dffgvQ2+vz993r4X73+Pgj+LZ/2h93r/uH
4Ovhcf+/QcSDlMuARFR+AOLk8PT238enh9N0Esw+jEcfRhfH+0mw3B+f9o8Bfn76evj2BuMP
z0+//PYL5mlM5yXG5YrkgvK0lGQj737V4x/3F4+K28W3+/vg9znGfwTj8YfJh9Gv1jgqSsDc
/ahB85bX3Xg8moxGNSaJGsRkej3S/zWMEpTOG/TI4r9AokSClXMueTtLB1HyQmaF9OJpmtCU
WCieCpkXWPJctFCafy7XPF+2ELnICYpgeMzhn1IioZAgs9+CuT6Cx+C0f317aaUY5nxJ0hKE
KFhmsU6pLEm6KlEOQqCMyrvppF0Ny2hCQOzCWn7CMUpqafzaiDssKAhRoERawIjEqEiknsYD
XnAhU8TI3a+/Pz0/7f9oCMRWrGhmndwaSbwoPxeksKWVcyFKRhjPtyWSEuFFiywESWhYSwVE
GJze/jz9OL3uv7dSmZOU5BRrCYsFX1uqYmHwgmbuaUScIZq2sAVKIxCUASsKQP0WeFhFJCzm
sQgOp+Dp+VUdEtDtnx6C56+dNXYXIikj5QoEA9JP+uvEcCxLsiKpFPWe5eH7/njybVtSvARV
ILBl62AXX8oMePGIYnv5KVcYCvtzV22jbUzNjc4XZU6EXrjW5majvYXVY7KcEJZJ4KmNopmj
hq94UqQS5VvvSioqz1rq8ZjD8Fo8OCs+yt3p7+AVlhPsYGmn193rKdjd3z+/Pb0enr51BAYD
SoQ1D5rOW7mFIoIZOCagjICXw5hyNW2RmaDOHgVt7CKiAoUJibxq8hPrbgwEVkwFT5BUtlrt
O8dFIHw6kW5LwNlrgo8l2YBS+IQqDLE9vAMCryQ0j0pJPageqIiIDy5zhEmzvEoS7k7aZdOl
+cWzaLpcgOM0+qilIe7/2j+8Pe6Pwdf97vXtuD9pcDWDB9tOg+c5LzLhmUX5NJHBii0nXkhR
psKWLjg4gHiGg+vKDW2tGzTqjMULgpcZp6lUNgbhwm+cAuiiEhWS67X6TnErYgGKByaCkSRR
O2kXU64mjm6QBG09DMNkCYNW2uXnFjv9GTFgKXiRY6LCQcssKudfqG99gAkB404dlckXhrw7
BtzG5470GCtI68+XHa5fhIx8W+Jc+Q71uxPFeQa+jX4hZcxz5TrhB0MpdlxXl0zAL74psrhl
bUyu/czAJ1ClFNbhzIlkYBllGxDaQ9cHVyG8QopNvPJ5Si7oxnbZjQcFVVv6Fl7MbboQCdhn
4c5bz1pA/tZuQX8E1baHk4wPLFnQeYqS2Hc8erVx5PBRgdBLLBaQL7SLQJQ7JsnLAnbq8xwo
WlHYWyVWyziBX4jynNrHs1QkWyb6kNKJ3g1Uy02ZlKQrK8MBtfCdsNIFHSm8W4T1kCiyTXmB
VkQraNlkCO3J4vHo0uai/V+Vkmf749fn4/fd0/0+IP/snyDMIPCMWAUaCOEmjlZ8WvbesPWT
HOslr5hhZmI2sdNhkRShSaQcQ4NkFUnIc5d+/UlQ6FMH4OXYTsLDwfFw1Pmc1FF6mCyGdCOh
AlwzmBlnP0G4QHkEMTLyky6KOIbsMkMwOWgC5N/g8L1pDo9p4uQmOm7qOOFkYG6R0IStSEwn
ntQSQSKdQwiAnYPP9xCIgvWhizWBFFB21qKy4DhBc3BQRZZx280JSOCXhqiHi8ErEZQnW/hc
OhaczaXKlcoE1AXMclKFdZ0TBPLHyx4+a1B2fL7fn07PxyBuI72VKIXKdNKIotRRK8AkVEqY
wSB9ji1zsqYEfdkqmE/dzL5AkKmKFQmUXVSCR5J2cqSmTMez7irS8dSrHgY3GsRF49kZ3PC4
1dTnBdMIUnqtiSqSlZdLx3y66Jul35p0YoqhXiN1ruuZSy/QIbLqwTBF9sSLdSPbAuIEBAum
nAck3ZB7D1QnjhqZeZJJh2nmJlZakdj++/PxR3DfaVc0w1ZMZKAy5XTu3XuLVpnBWZKJLxDV
yLFl5lriPI4FkXej/y5HVQOjsXfvkhuzz5Woxd24iWjMyr+1U9DVPaT4ZSRDk7jVCbJlZ3bg
iO1kuq0vxyO/vgFqMhtETd1RDruRXb/eja22jcl9F7mq3Wzf112hcQ7P/0KSD2Fp923/HaJS
8PyiZGS5CJTjBeiYyMANqDRJUEchK0wPoH38Fyd1qxBiSTMI7qll+RmDuEBI5kBU9l5D22jL
yjVaElX0+9Q7Yx1iHS69hCVOljbx+jPsbg0FCIljiqmyIm/Aq6Q5KDinGbU73v91eN3fK4lf
POxfYLBXyKC/ZWyFep24aMnruLDg3GqCafh0EoItgOqXsjMsJxBkkBK0iiuVKyiRTjhrRedR
kYDDgnyqJEmsE7AOF7IB9qbdZjmLhKcEcja8XEPgttZbJSFmUSovddpmSzulaSrQOeariz93
p/1D8LdRzZfj89fDo9OAUETlkuQpSZw4fm5sN9i/cwhNZSSh4IDU3C5edXoqmEpDx62qVOLz
qFUtWAnKDzvny8LR3lAJwxddRDq2KubUtEdLkYHnKVI1yMoIGrvSUiT/7e/fXnd/Pu516znQ
SearpVohTWMm1TFbhVYSYyidrX0aIoFzmklnxQbBqMD+gAZsooJlXhsZWpsdTdgZ1wP5knSC
lQKUKY+ISoVKhiyHUXVD7a5PbVs6amRSK6J2+Jed7BmrAf7WmoovOVHx1V8dMTrPO/PBD6nO
VCWstiiXgnkY1K0vBrsBbinUW1F+dzm6vWoCEQF3DlWGzguWduhOCFTdKn5bMIacD0290AXZ
3kYBEVi6uLuuQV8yzq167UtYWG7gyzTmif1ZW4i72xrW5Kmwv6wjwz4xuCx/ZqDasOY0lENc
+g8jzpHqFRN1jWCFEpIrySnWTgE4L7IyJCleMNStndzswaOiVhuYyF6iFO3/OUCZFx0P/5hi
sSk5Mcqdej3DDFPUY5Dhi/vd8SH483h4+KaTiTaqHO4rxgFv7KUtkI2jXZAEdu0VZERWkmXd
TnxbiaQRUk5+qNGs2cc0ZxAAiLn76K0+Phy//7s77oPH593D/mjZ8xp8oupCWhZdg/ThRsDR
6QfBYTezWfco7SjdMjTb9TG10GUMKqZCl49OuYEcwqSDq02r0Yfuxhr3Dbq71s2/2h22fLSx
lVFOV3qF1jloOFnlxH8WhkBdQVWjwQ8xvvI2r1j5mYtyWahLLffSysAqBln3SqspZFXFQVbU
adxCHuF4WPO5pBPcg4mM0R5wPe6BGKO8z1DfGnUYYhz2CafWzBH4LLEAtdA6E9vHr1AxGLbx
Fc4JDliQVtvw7RQ8aMt1TArl6rpSEuXneV4m/rZGKMeQYvmLPo3bUH+WTwVNKHwok8wfYT+D
bpYkpBNfWU1ZpvwiAxnYnbkFrQBtymJA/Xy4EY29/UY/UtskmIzqrCPbHV8PSnbBy+54cpwc
UIHMrsGec9ffKkSI2dV0szFIXzgFGswinf3UDCwUj/1sAagMnTLwIRL5Y4xFJ/PNIInSqUwk
Z1cISqdb454V1qiI5joMbU3Od3cxdqdxWOjSXbe3Bjph/REqL+dpsvXXJr3T0YdWwK8Be1b3
Oqb5KI+7p9OjLoqDZPej09jUAufee55KlpKqzAcskCEh25QUovDHnLOP8ePu9FcAufdL8NAN
hfqgY+oK7xOJCM5yHhIXDm6q9IBhvOpO63sGnoo+MuVijbKusihMCLFrKyHDBvygxBVh8rOE
c8IZkbnvZkiRKP8VonRZrmkkF+XYXWwHOzmLvexvlI49sA4XLr2SUK4tgUA7ZIxKxiwSMvIN
hnwBnRlYSJp0zAOxDoCzLmMUCkgyvIp9RrNMTbF7eYESsAaqgsNQ7e5VC7Sjflw5z02dmPad
ymILaenwqQs8m4xwNEwAqaGmGSSQYjYbaAzpBUAlAzv2p6bv7NQ0g/ePXy/un59ed4cnqJSB
Z+Xh/fYoMoJyqHY7VimS3qllix4I/u/C4HMpuUSJ7ok6NU2FJbmurxV2PLmpkufD6e8L/nSB
1W56mbQjoIjj+dQrnvd3rnmlkO66MlCQsqqNXU+YEoUb0HY9jGAoYNblAkGak867DDwkIGs8
FGLQWo9whWzzCPWjH+Nwd/9+BE+/e3zcP+o9BV+NgYAAjs8A7Z605hMR1TD2TGAQZSQ9OMRU
DpFI5N0eB3uZDNuDIoEKY87Pk1Qh+DyR6gy8QwJ13YoMXKu2kyVYpV7TyWY4JzDcfpYwzDHr
qopHVJsU+RP/hiSGNITG/qywIVrFV+NRmb5HxjbvEIhFGSdYviOtCK1oiv2pbHvEm81tGsXs
nRlj8R6FKNKBtLkhUfnzzL3H7ROpFPod8Xjv+C3puU/D2q2qsuCdTUg2nZQgjXcMgxHBfZds
DcE8c+/sG4SKE+oJxrnBGMrczguN1pTAC7v3eyaYHk73Hreh/oG6w8spomLJU/VssMcNvBY4
52/gjoPT28vL8/HVw5tgbFdrvjE1TrtuzTnJoigP/sf8nAQZZsF307h58IcNM8AXNt5nZS+5
CDveEwDlOtFdc7FQHbJOyNMEIQmrB6eTkbsuhY0hkz6XdCiaeVJAPThw2ottRvJO8bcIGQbP
fTW79AyKpFVV89j+XXWiZdUxaJgBGIoVdSHmqwwAq5q0qv/tcNJ32H7UkoefHEC0TRGjzqp0
V9TpzwDMaRxwdYsBxd1KlSN2z9ggeLJyZ+UrkjuX+lDPuFfvFQBK95ub69urPgJSlss+NFU1
Gq5Dc7piJBCNwrfqa8Mbc7P6D3WFT1LBcwEaI6bJajSxEgIUzSazTRll9ltWC+h2aqKCsa0r
MorF7XQiLkdj+3x1YC3FQL8fnEjCRZFD1gayVg2j4aYF5hArhgKwplDanme+HAhlkbi9GU1Q
4j4dFMnkdjTy3dAb1MS6F61lJwEDiXYfES7G19ceuJ78dmS92VowfDWdOZfkkRhf3fh9uuhk
7RV4o96obEoRxcSJJtkqQyn1y1vFN/hnSbZlIXwPefCk0lrjZQnUyczysO3BaQyc7sQfLCt8
QuYI+4rYCs/Q5urmemb1aA38doo3Vz0o1Kvlze0iI2LTwxEyHo0uHXfvLt685d7/tzsF9On0
enz7rl9Nnf7aHSGlf1W9C0UXPKr48ADWc3hRv9pW9v8Y7TM815JQIqFuUbVvZlW3BC/c6EwF
LnMpNt1za0s42+BNvYYFreuUXpBUSHW/aEvMN8A8+yeEBOPp7WXwe3w47tfw/x8+rYhpTta0
+4i2fpd/jomZ5unl7XVwxTR1vv6hP4KC2ffGBhbHymUnxr+3tq5x6mFkRFY+g9d4oXt6S6dT
bTAMqme6qTBNA+xRPRw/qDd3X3eOp60G8UIQmK/HrIKXmUDFZhArMES3tNzcjUeTy/M027vr
qxuX5BPfeqYmKy/QXOtZxzBcK5sh4ENCjnJfCWut0Mpo1EfYr+P1GiCYgb812BCE28jDrEz4
nMLPLPMhBYT+TEJg8s/ZoKFyhhzn7PR427nRaVH6ClE/DvRhSYJSSXR17VlCjf2JFag2Fkns
RMZaAi/wYkmlf5JYfdVIzeLPAzUdxF+KBso1TYCyLCF6nsFVhpjNbq8v+4vAW5QN1DXcPBpB
qfKKZ0hWYrPZ+NuDGt8rZ8yumhM+z72l67nXrkkJ9RBqUOn15bT9WFN/VlxLhAlGTt/TRtJM
Ev+TW4tqLjH3TG1RLFC6Rs7L1Ra3DOHDwPwZBGpR+LOvisxoSLlGkGr5g34lAqUjxisN+wYI
Z10fhKLr8WXPFxqoGzIrjM4sMZybmrDv6kOGxjPfi7fK5U03ozIspLQfW9SufnN9fXU7BWlm
0i3VG4Kb29vrCj+8S4ZuLu1M0YCVqkLdRpxLZgsVEcwj93rXwq7UI+LBKZGk+mJXkkl/PLhs
iG9pRTDIY7mRn267K9OP2SAGki5iSxDkocv+bJiNR7dn9CQn8yLRl6DviDEnsiizde4/LJmJ
q9lkfDNMUdSZQzcXQAlDoh03uIAMx7PR1XRaZqzwsMHxzezaVwtX+DUbOG2F0cfZReTLm9FM
LQxObEANcq6+wKcKKKUrg5NH6HY0m5Q8NZx6uKupH7dmN9PxpuwLE0WbZOozUw322SllIGPs
ERz9LCZXt8O6jBmampepPc3SiK5PdzeXryZXo02lW70cUaOvZha6M4chqE3c7xgNpa6ptHmA
HM/QCTy53mwG7Tdn9LJ0n9FpkJFow0vDIFkY4hCPph0GANG+m3fgk6iqSrr043EPMulCpqPe
ouKpzwYqFOoymF32ILM6AV3sjg/6YQz9yANVBDgdDGcn+qP6t/MdCA2GXH4ZRl1oQkOThTrQ
HK27oKoy66SsFWsxYYNfXjGjc6yofM8sDD4LvZx5kmFACn/TrtpvkV7Ss9y1j3C2WXQkN0eM
uEKrIWUqZrMbDzxx6mvfKTW1nq+SMzUEVMy7e6iX+s0pKS03tLK/6c9BTRP9/iYV5j2msClr
Ah+s+xJ8sbaoG7ECfYtQr1SjobeFRUo3txBs5NbvE0zHo4evsZGq49VTdPVSrNZ3sT8edo/9
W9Qq46q/sNPVFUDddJ77mybh89OFRpwMX92Y8FTrFY/hq6+KAENpdj0e+++pKhqBGCilX2QV
CWVnOQC62emAWgNVgXKZUEk8sqhR9TG+z0R9ZaPQj27G/Q1BSTZwM1VRLITvAq8jOsefW8C+
ytbz0tj56qID9qluRaDqSPr57BFhnG68312u8eMrKlSI8q66QQ9jurGqwkvKQpJH6NyRVC+5
PKPrN16eU+1psnHYnySaq2Mdnq0iVES93Vg4lecrx6eeeA8ThaiI1Nf67sbjmfWnUDyUw6fH
NgK8wtk1V+3eTPiX7aLPTaU6Au+IJ8d9sUA4G9JZhQNTMqIad5Dq2jnJvGtuUYOs4RPZIPXl
GTqnGLxm7tlSn+hntEVA1ip8CWSNz9zH1Rb459iz6UA/vzqIFQmL3kl0qfj6rG8Gszo7B01C
glQNJGjnmUTztMWJPT0OqfpTOuoZt7fTlxZJUsXttl1gvnoKNeG5lanWpb/jBeyq78lbXYwG
Zr6getfcg2qoXVolWV+Zssz0PNt4T3PIIs5ECpoxWv05GrtsU1B1Pw61k0RduLp1MV9NcsqJ
FifkwJfiNY15Ma1f0OWxeWhsowXtAiAmdED6z/tEfN6fX5UnPI69J4JEpr4TslRdMkUcDjyk
SDPMlJd/l7BiGEovWZuIme91O7mZAZm/RUC5c/PaYsP/Y+xKmtzGlfRfqeNMxPQ0d1KHd6BI
SuIUtyIpifZFUe2q6VfxbJfDy5vufz/YSGLJBHVwu438lACBBJAJJDLTwFcuGVcSH1hbdUzR
6JtjBnFmkxYiMHcKkCCL6VpcTB+adoAotBehcno4M2oBe1Zqlo09KDorZCq7UyGfJRCB4h24
XjIWl0dSBE26jPxRnztKo9HB/i7sRyU4hzmFKgRcv5SmskQqSUlTyB0rU5vzpR1VtZeSDX1V
ol1IU6lv7/TBZDmMvv+x8wKcousvZE+tPuz1U9E5fpBhyCzmrOi1/ky2GOpkvbxS4dcrXgZc
binnJuTj2d0KDUymFvOXkVoZC3twUQtrdq3EXQF+ff759u3z61+krbRy5goJ2ANssPo9tx0J
06oqmiO8x4kaGBRazxYyb4bxu2rMAt+JrLy7LN2FgXsH5i87pmzI5IF30RnTF7DpQul5gXDR
eNTVlHWVcqFq7Xn59+JNETUM1WFk10JqUVod2305moWkM2QZW+xz+hQDGe5TOYWnXFFTVhnl
b9L/oA85hFvwf3x5//Hz898Pr1/+eH15eX15+F2gfiMmJ/UX/k9Dnpj6i/Yt3ylw8rjDxz+d
phLnTMwGL/HhkA2CTnanvoV3sBnx2Dbg+SQl91k9jHttKtJHMfpVFBMii6cjFzIamYe9goP8
71TsrOWiiOKA6Z6MWhcXC5XtXHjH6VNek6fjqaLRK/C2lTU+1ejWXHXYVR1DtJ2PeMxS8v98
DOIEvPMhxMeinuenVEpseA/WVNnE1t0oVeoYhZbW1GMceZYF7BIFk+3nE3LsTPdGrouh9Jba
8PjPW8wpkBGv2DJHVphFPPV+7GoyH3CmXYM3tpvwecxdvywzpy/hqyNKevSN3WfwMy9AwrUw
+ulWk+UVNgoovaxH1d+Kl/awbs2IXY8vcQPyQJmRyCw+IFetCz220M8+8h6Ekc9NRCwD74r3
7fCheToTUwSfzcxj+bbv9Cf7EuTcEMW0tPCYATe8C2mc1HQsEYubIq413pH8bAQnV3jbpqrb
WaZZn6XKb0UMBaIVfiVGNUH8TjZwsoE+vzx/Y6qifsTL1/OW+j+cdRXQcCFlNbb7djycP368
tar9RwcjbQdigNZaKQ0peR60nepSUsfelj8gZ81uf/6TqymizdLGr+/qQtVBu+UwaDI1Xwtg
aokmdlUKPkzmGyV9x6yeUK7lVA2CymcPZqkdhhrmK7M6y5uBlonHiEBr8qtEVw6KOsibWjxq
llDENK4HYq7UJdO7IeNONvrJPxSrgF+VkZ5W3+WsxZ/fqI/iKmuUAbUV5FZ0qtcVf407duTH
75/+JWmNXLC/suAb3elDVe5ZyNSmGGlEZfq4jdnsw5jWLCzDz3fC7/WBiBSR/Rf2epRMCMb1
x3/LPpVmZcuhDde4pXso8bxcEG48bqh0ylM2texMJ+Gpfn44N5l2dUQ5kf+Dq+AEyXamgmQz
JuZ2pYMfe7CCtUCIYkv0KHhtX0A1PMNm+r52kwRe32dIniahc+vOHXR4t4J2TqTcRM4Uohu5
CbL8zZg66zx/cBJLBQORCOU4bi6f3NCZoIrJ1naArlVmOnfdgH5Jqio072cNwZwrzMa0WVG1
I8QSO4Jdx5sddx03RlOgYM1aR8Gm8TLy1LhxNwbGZgEtvUUtIFyln2HZh2NDDBsyi6ywBlY4
V3K3XVUzeHfU021i6CS0z4190RO14LY/BhmsOizVWXTtRSCn1Au3IfFGo7unxIk25IhiEjum
7J4Cx4WdryTMZl0ME29iIsdN7GvEUCeeZ5dpioki+5BRzG4Lk9e7CInVKPOZNr6L1eVut3kX
34HZ3VHX7h4+9n5+yoYAeb24QugxN7sTqEvYzlahw/4O6JDF7sZWNOT11vASSBLYR450gotE
OJQgkFdE//r19cfzj4dvb18//fz+GVJtlx2CaAED8px2mc0H20GKjOqTNI53O/t3rUD78EkM
7b2wAGP7MrAyvJPfbqP7JSB89GG20C7UK0M4cKuJu7PeXXTvmGzIrQS8t+p7xWZjUq3Ajc1u
AQb34fzULof9x9T+qQRw5zcGdzf9zuEK7q34TnkK7pySQXbvhxR3ikmw0ckrcL81Gs02p+EU
e852n1DYht6wwLbXHgKLkZgmBmx7XCnMv6ttcQgfnOmwZFvoGMy+eQuYn975pXeNQoy8vVRh
ExzSBNsOTTb8QsC+5dJD1Q0NmWCiTQz1rRmyXbKlKPCTUc8uXgK1IYTiFDWwD6BA3cPrtLWw
MFTduRsSOJa3ss2R9CAzaD47hezW5Vy1yu2CsgCJNXgncqhy+64t87RPoRU5DfYZLn1QBL/S
ApCufeGTkBvLkNxOZYBF/NmXt+fx9V+Afin4FDTLjOIusqj24yM0fvXoxY699eyGyS5tDGIX
23pM3I2DAgrx7PJKm+vaB7Aeo3hD6aKQDZWVQnZbbSEfvdWWxI22uCRuvNW7iZtsQzb0PQIJ
VVPT/GR/FyuuBZi8GT+lviepKXTEVIwrP4QEb6y7SxwjV0fLtvB0LmlCi/IM+RPRcx6eN04t
YDEaunQ8iaAlobukyWsP88259pOyfxKp45ZG8MNYxPuE+a+w7D0qr1umeMksRbeLq5Wuibbk
2NJfnr99e315YLUC1iP7ZUy2OBaXFGsXd4iQv4UX444QEv02oOdnHDWekLnD34wRLvui7z90
JU2OhAMh1wcTMR0HiwsFh3EnCawzgDBCvBx4cSDT82va7Y1fFaXlrpUjMFG9HUb6l+M6sCTI
t94KudedPVjxqbpaWlG2kBc+I9HX7NklMxjaDuJnABpKjAHqfRINyPEjB3RZgnkjcADuzcDp
E3TqLkiD8Uns2mt7yDDfAC7Q2vWrRs0h3x2+OqR1GuYeWcza/dlo2tB0wy3DfMI4xNpossTd
piuouM2LU6Y6NrJiPPzXSnYRS4MjhiBBlm1Gt17FM8REBf4GhobhdHaVbrR8qiyryUd0Hqd1
fjuIt9tqkHRorV0801jp61/fnr++KBoW55l3YZgk2kQVpWrEIkFpOuN7jtcbdr/NBTqdYjid
ykr2Jq0mUWrkNWViTh0ZfbSjGDnWFyf+8livZuzKzEtcxxSvIdjp0iFdiGu9yne+Q272trbn
0J5FVGe+B+Sk6W59hYKu8NWcvVE2msvdtdCVsktiX/90WhhGodHvqgbE+864QeQzs/IS3bVB
7dwhCp0kMvqcP0I3+5wSdi4qKeNTPTFu6s/482twqIAh4dFoyKS1TgzF42NhB/xMnR7HI1kI
01F9eMP7tc0ewWSYLFQ7a5T72/+9CVeP+vmHnuvu6grviVs+eAFyAK2CkBBZKwiLTCmzca+Q
HrAiVDV0LR+Opdx1wMfJHz18fv63/LyV8GGOLbfxVMiKxFI+KM8dlmL62fKFtUpQRE4jsbDe
NEcB1iMr2IVioKnsIqQJng8TErTRvoMRXPRrfNjIUjGQE4KM0LwNZBLsNqoi0NYlhQO9fVch
bgwIjxASybxiSaNo7EEwAzOj0hRtlfLmSi7Hk1TlKQea/i5pnt326UiEXGErokBQETrDG7xA
MLYggGWcwMnUH+lIPd/JLuIgtyeiYbc0G5NdEMIa0gzKrp6j3v5qADqSkbI5yhRQChSAZCsq
5R7EsiqOxOoAUwDOkGEvp84R3aEU1mmTGoXzz/dPNKrEhBLUlyU68ZQ/Qc2eyfl4OxOpIWN4
ay5Ipoq5D8gm7sMruAwJoZAFM4AoSG7sBI7ZXkHxEIrnKvN67sU5bgtQ5Qwph44yNkeAhfiR
Y2nMBKpjeDFUHaUk0BI0A9R9Za2JDS/IcfQj9RZVA+TFyPJCsG4IojACP4QFM0I+cQd+Cr/6
r/dI2kmBImISuIjXi4LZQbNKRngh2AxKin1oNkuIkDTB/DhKIAMIE3aJA1VHPtgPYkttQs2L
TTE8pudjQZ81ebsAWCGObZUfyuEE1dqPZFFDcovODcu82IcXx8O5qETtPMCMpfnnbHAdxwP6
JN/tdqESuO10rcE4DEx5SZU0yqKIpcQqBz1ajgYqWPLfhobIEG9SeTrcWz38w9HBcvzgueza
lzwD2NiX3QC1Y86BdmwvpE1Fd7uWA+w4Dv3ikJY9TwVk+Qr5BywpFEtTbzZWZQjTlybC5H3a
HNl/YDJUO82/tI6TMQBnPaXdTFLzKbG4RsBw00c6ohjsVEJP6toKefSt5Ke2L5+sCJ5bwobo
iXFCT43toGyLCwUQcbW397HsH69tm1tBeTur/gggJRSioQGQmQPz0zVHth4fpUIRwvPn62fq
ff39ixJYhhHTrCsfymb0A2cCMIuKasetoX6gqngKrO/vzy+f3r+AlcwrZFZ7setae0Z4stox
/KR5i8+tGTYhAyITc2Yr7KuQCMOWjx/L29Bm1tq2+fEQQs9ffvz6+qetMn6Pb60M4yK1mObb
sMiobFBoMvn06/kz6TarNKzeiWNRd7e0SvV3kKKlKLOV18fJ20WxdbSXK137WtODM3u2gNaY
C1qJ9kplKW7aa/qhVSMSLkQec4I9G78VDd3ooLOoBd52RcNeXlB+DsCP3YMZt9XX55+f/vny
/udD9/3159uX1/dfPx+O76QDv75rRzQzn64vRDV028EZ4mGDh/YwLvyQ5S30wBgWjBSCP1Yw
kX8HxrM1gp++GUOqFPOMyWVTjhnN5Luuw0Vz8FyaHAH6BjZzJlvdwpY2axexfUzCx7Ls6fkC
VN98kmnvEbHp+DSuhx041DsvcjZA487tCc65Azek9W6jTn5LE9j6TNwggj1wGK/56LgbbREP
Qq2SeQX5F93O3+q2lqWutCG6ZgocJ9kSXPZ83A4iWlU/bmD6Jhwjd6M2lijHDpljwdj5jDV9
rT2RZmV2JL+42sLEHlLjclAyRfKIyIPFzWBvow6iu5LlIUeektZTfK46nT73LI1SC9bcTjTC
Ffwr+nCYqgDgDB7pte5Gp7D3t1YI21Oxb2Lv22/Hab+3M+G4DUhepmPxuCHJS4guK0xceG8t
I1U6xBsCz3350Q6Y6f3HFIMI3wtrNYsmYW/MmLvu5qpH9Q0r4lLS6+Otqc6SBSJix+/WKFE5
/svqgE1qpCNmPdxCZ24jNkDs+Illhh07ojiiwtrRTzK+aaXTgAoR9s1ke76lnqt/9LmuwH6c
L9V+++P5x+vLquBkz99fpFsdgugyc2ceaEz1dhjKvRLUTn6FTSFDXranlp2QL9h1ACUAPMIE
IHIxI65Qe5qLHeJNCcbXsnA1//vr6yeWwhXN7XgAUhqSMuvxPAXwqLXHjtgGKIY+23OhE8+Z
6EnHV/zlNL9/NlqTjl4SO6yleG1EDyEjCAdD5AAaY/5QFVMmBypbSacqyzOVwLIgOPKRPCud
b8GNhk6d50xILGsK0K+v1zI9XhUbGerWB16ALFTV6W8pRjzdFzpyP7vSkYx0bODKDDqFZwPI
bg4mbVQXnwCJizAQgI/m9gHyzcvzZr3MB9hgj8sYuWrwT6RuM497f4fcgTAIN8CrLh2QVI0E
dCRbKH1SP9yOSM4sNv6Z64vLHRzTeZjjLyNPpCm9bS4SXSgkWpcGkQCnMgrIgtrVpTEihBSG
k/FwUCBOI41uQYVCOm4kZeRztAg9lFf5NEQedK5NiWZQH1qaJF2NeUKtdFzgGT1ykNScbAJO
bhDGsP+wADB9cwMAJqhYybKjyVq6MySXlScBNMcEOdk5MfCrZOdh82a9HjIKE4PTGPkR+imz
87JcNtvKarHioyKVU+VaLZnv9pRb8DlPAybVCwB1o2Wsa9QRkm1j1sezrLVj6CD+CoychWOY
YGNFwxMY/SvMNrxNRWbsdDK5DOJoAndtyOFJBdQh8giBUR8/JGQiwOtiup9CZ2MLpjYi2mwe
oajPtK13cZ+UykaaWNz3yZozDlmaGwtS1fk7dH7wm1uDYVXrQjc7jc3WVzdEriNfP3L/MNmN
mJfEmjog+ZEpzeTl4H3pQlYuIOemau5wUrHiECcxMYSMlScRttLOrmzgz3auZ92MCIisx8gd
5nitAse3CAoBRE5gAqQKrpXrxb525MrGtvZD31gwx8wPkx36qYZXHuPUZqcmPSIux0zP6cuP
1P6x9cS1TgLQc1QQfVcbRnEsCKg9lBIaaVB0CBZ8gM++a5CAfvZs1WlPNVFcY2qJGyuSoBGN
DF+WVgYWEM9oXHUs5u8GimFw5WkY6bqMmQ8sqIz+HY+nNCfmf52dwXsGq0m0Hv2ITEbrwK3J
jZg3FkQ4lFNBdry2GtOjsiyvEBrN+MwDnA/nGoxCtYLpTTC7CF7gMFOi2xzhWb5iqC2XRCHM
IM1DHwlEIYEa8hfkHCpBNHNupUgmFMBaSKSVt2xumUOiWRwqJQSbpFsRGsVHKJ66Xmo0SFIl
AUmb0A9DZBQYNQH91VaQ6nEkZdximjtOuYSyj+ZKLYeKWDghQoq82E0hGlmDI7jD6bYcu/AX
MhrkLyZDkthDGKsbokrBOlXsl5t1ysqCROG7CkaK4ggiUVMiVHcbhYibEToMNCYUUBIFYPMY
KQKHHLAdNCLo06dhYnCCAB5oOhHyp9O/2955SNgQDZY4sA6rwzzomaYEyjqXjAO4UNRdGLiw
CHRJEsIDQygRsg7W3VO82xYNYn0hb6BVkAdpxyokBMVet+9WivnIQqLtyxRyFJMQWbpT0ifK
pMX6M2mH80eaDBqp9kLWTNBU1TCJjQGooEuYaw3/mN3F9F0N5VDVUHq8SI1Mk3ZejNj0BlZ+
8ikl5rylIw0Lam3FbIiahDFIHHDz6Mf64iH9Nnh1lyKWpIoaNsV1COskRh5vSyjDa9KEVMfQ
dTBZ4Trnvm31CKAo9tIXh/0ZjmOrY7vrNk+mnd8uNZJoQ4ISM9yJwLyCMibxAnBPZKS4gUjE
cgvdyPfgLpotYGvFFOT58PbCDV7Px9lT43mTvW5La1TXt+9Rkl2NsfBc+1YEmceScg68vDTV
ffqwHuok3SzU1oIq3Zd75T10bx4Hqfe0t6zI2HuRFr77YBhBV0wmmUBMmAqOjTvD9nl/YVkN
hqIqMsppDZYxW1M///4mP5MSzUtresGxtkChEuOiao+38YIB6C3zSFOPoYg+zVkiRZA45D1G
mh+CY3T23kXuODleg/rJUld8ev8OZLy/lHlB0wFf9ErIP8a+rZTcRPllvx7wKZUqzFmll7eX
1/egevv666+H92/UtP2h13oJKkmJWcvU9yRSOR3sggx2V+rkNL/oVjAncAu4Lhu2UTXHQlEV
GNdDlQ6nW0VgWaVdmyiwa9PmhcafLMTUHxEozWveh+VR7i2oV5QxmsMsm32mDwsdDWggDA6M
f/7259vP588P48XkTIe1rtNOHWiii5JuTTsy+4Z/uJFMyj80Kb1BY906qD/jqUyGgsVBvlXt
MNCIAyrmXBXLaC3tB1ooT2TT2Y93CFVS8EWGT8HlM/5Wy+mZtSOteYzXXLZ6DLDg+7QUrYCS
Xd9kJJets1ojzPx1BnWfOI5alA979cSF135KeyhdvET1VD6PRD8r1KI+pSm7GyXQBGtFunNA
BYcxH4s0jKPAbJMg3KYR9GgVTUvTOHaiE/TzAzG5wA2V0flRrDaVBa0cUuGyAM5lMUE97Rx3
LQeWJVZek/6RY4GvFGWum/zqtKpaeUUjTV2kQbRU+RS2ctV1J7Yo7Cug2CYK4ZYNpdfD10wm
cLQBZ+/AS1eSta0cOi1mmA2ekdl3RjQFAa+jIIhuWYZcqs0oPwzvAEUhkYES1pD15u2LO76G
eliScWzPsI+M2ILw8DocQDYZwgIdzEt51jcvLbPV2hj4uIHTWQxoOF0VB/B0J2mNeAiIxvoZ
xVh7kdsYeVbD2T04aHZ+y4qzjRXP7Sv8F4JbaWtbWgd+TEyW7gDd1HCMGURELhcTA97sZdzY
GRqFoFzGzOTO3vJQ3rYOoRgifrYPZH4/JeKcoWJsfc+9obItTLSFGQkAeblA1zKyMHrkj2XR
pZu+bcVjimVClQZtTBcEVZd1DjKQqwp19jv1Znsg/OZ8KOr7gHpg7m6EwwX9HKZe279Fhqiq
Demw8QIo5fJDGl70/PXT2+fPz9//Nt5O/Xp5eydq/Kd3Girjvx6+fX//9Prjx/v3Hywfxpe3
v7SvEoN0Sc856KEn6HkaB76hcJPiXSK/hxbFRRoFbgjIOKN40OGUWLSGzg/U4w6x1wy+D+Zw
mMmhH4R6O2hp5Xsp0I7q4ntOWmaeD4US4qBznrp+4Jm/JuZuHMPOOSvAh12bxHrdefFQd5BS
KGZW23y47cfDjYBkibhvfHlA8XxYgLr1RJSniAchWgOuyvDVCkNZEKuJxlQHjClS7JudRglB
YlMTKCICA1Ws9AQaD0GgZwboj/c0yqH5U1IcwgGrFnpkoz8ODhZ3Ukh0lUTksyLo2fYyFrHr
Gh3JiydjbtErHDIXAZkWFGs3jJcudANgb2MExLlwQcQOcgshEFcvsYzfeN0pEQuk0ggqNfvk
0k2+5xnFxNr8f8qebclxW8df8dPWpHZT0cWy5d2aB1mSbaV1G11s97y4nB7NTNfpbne5PSeZ
8/ULkJLMC+hOHpIeAxAvIAiCJAgsHHa+JsgtToejNFt0tcd4TJ7e9Qpk73hcv8mbcHKidC83
q3HekQBfU19sKs3pGTYnqd2pxl4GXpBgz7bpuQSIm0IURAvXXyy1Mu98nxDYTe07FsHDkV8C
Dx+fQaH9u8OHpBPM16lpnbaMZlPLFa9xRUSveKR69DKvK+VvnOThBDSgRtGHYqhWH8PZ3HM2
dLLd24XxF7BRNbn8eOnOeg1on4AMO7a6qAzPXpVPuSHw+PbQgQ3w0p1+vE2+d0+vQtHqCMxd
feJlnjNfaNKluPEMxvohS8okUmf/YKaYm8K7eXzuzkf45gUWqjEdsbqelE2S4/llqte/STyP
utfsm5wB66ZaRxBKaHyEe7R3yJXAkHvlSmBwNh8JXEN2myuBIaRGv0/bOjNDJoQrgbcwsgTR
+trMoJ7OEoAreRcUtDebEjYZg9/uBRDcWhyL7Yx2Crh+r+s/BtXUH0IXBHTueDYBlbwyRuhM
t2URSrUBM1XoUN/3tKWs2C7Ichczj2Sq7fo35XNbz2aOeZXNmkVmWYRmZwjynumKt22NWQAu
LZcCN5ZFgm1b2ygAeGuRZW8tfVuBYKIldWW5Vhm6Gi/zosgtm0RlXlak6rkbRl4NM92OqH73
prlerXc3C4g9BINTPgkjehqHa03MAO4tgxVRXpYEJR3FjBPEjR/f+aQGpjUsU74pwPRHUsNC
7vk6G4K7uatPsGi3mNtTvdkIn5l3ZoD2rflhG2biyiw1ijVz9XR8+y6sDZpZgn4rZm6jF+1M
6wn6dU1nYsVyNXxhLhN1+byuvCpOuUxrc3bFxdv74+1yen78T4e3EGy51i5gGD2m6C3l124i
FvbUtpogiibzHXH51pCSS7dWwdw2Yhe+Pzcg2cG86UuGNHyZNY785EzBzQw9YTjXiHNmMyPO
dg0N/dTYkge8iNuHjuX4JpxnWcbvpoqbhtSafQqfetSJkE421+9sOTacTmvfMjED7UfJk14b
ctvQr1VoSbpZwzmmfjGs4SGJXr3hcZpAGCMT32HSKgTzzcxp36/qGZRi9hro29QGC2n9kmeo
Y3sGSU6ahe0aJLkCbWoavX3qWna1MjX8U2ZHNrBzSi3QGuESejgV9RqlfESt9Naxc83V+fRy
gU/G80LmP/52gc3y8fxl8uHteAFD/vHS/TL5KpD2zcAzyrpZWv5C8AXsgTNbnBocuLUW1l/q
US0DGxKc9/iZbVt/EWy4om25Kpw4onZhMN+Patdm84Xq6gPLFfzfk0t3ht3a5fx4fDJ2Oqr2
d3LpgxINnShSup3I85C1Jff96dyhgGPzAPRrbRwB+bR770xtMmbziBWD3rLKGtdW6v+cwpC5
MwqoDq+3saey39wwkg4ZUHKQCYuSCWexIEqamTvEBcnSBsDn231lVCzF02ogdgzRW9nBe1zb
+wVlXbCv+3kf2Vp/OIqPh94WqHOv0gf6ROGfzyjgXO0JH9wbswekj3x6wGqvYXFTKoc5ovUK
czEENsVFaPtcYuMous3kg3EmyS0swby40QFEmzoAvXfmBPsA6BAi6ypAmMaR2qkUdqg+5aNw
7fFUGcR83+iSDRPMIyaY67lqjVGyRJZn1MWDiA+VxifLOYJJaElUsqDXUqFfvlxWsFpYttbc
OLSN5eDMdEWTj49H5MA6WOmiC/CpTeeqB3zVpI7vKmzlQIcE4rkZoXt9teLPkQ1LLzoXFREp
u2G/Ghj1P+oHX505nImOTUI1NnLNN9fqD5oaqs9P58v3SQCbuMeH48tvd6dzd3yZNNcJ9VvI
lquo2RobCWLpWLL3EYKLyrPplzwD1lb5uwxhN2Ur3U3XUeO61p6Eetq04nDS45fjYaTUxQHn
rKWsPUHre45DwQ78slSHb6epxn0s2tY1V1JH/0R1LRwTH2G++bQedax6WOJZbfIa/1//sAlN
iA/AKBtxNCmmzDqVHPeEsienl6efvYX4W5mmsgyVYry46wIHvQPFT659DMX2oXwzHYeDG+Gw
y558PZ25daN2BvSxu9jf/26SkXy5cRRLisEWGqxUpyGDOaoY4BuwqUU9nxqxjk1+RD4+YTIH
u3BXnRO1v07VhiNQtVGDZglmqqrzQIXMZp5mOCd7x7M8KktJb+5WsLyrIog63VXatymqtnYD
hbAOi8aJFco45b5+fOROz8+nFxZQ9fz1+NBNPsS5ZzmO/YvoOUo4Ww7a31pQJ9Z81XeI3Yy2
aeERTE+np7fJBS/h/t09nV4nL92fRsO9zbL7w4pwOtY9KFjh6/Px9fvjw5vg7Hz15cz2h6Rs
t67Zdz2Sw4FyDQ8w8VxruDISwPwE7Hx87iZ//Pj6FbgYqZckK2BhFqWJ6HoJsLxoktW9CBLF
ZpVU2S6o4gPsH6kwnVgo/LdK0rTi7u8yIizKe/g80BBJFqzjZZrIn9T3NV0WIsiyECGWdW05
tAqYnKzzQ5zD5pcK9T3UKDlWrtCLeBVXVRwdxLelAMc0EWmy3shtA6MgRkEvJXccQDRJyprV
JCy2tT5G32Ef+efx3FEij3wiksSJeBAnEyqoaO8tNiTMh9uEXi9pwQRUua2odQMwGKQVRbpW
RqC2IxbGx9hMdCMzIXeZ7xki2GBj9rDBoG858FvbEBsHG7WBIVvC2BxSkzMnDl5mCKCCJbjU
1TYisjpsV3tJCtooVbiSLLPDet9MPXMbh3D6JjxsDclN2gp9wNiTellEYxjyvMhipSXLqgii
ehOTqViwP8NBswCq0RieKwUxH1X6dC4rmY8reetAaiweWfv48K+nx2/fL2DgwDAN70oIpQpY
/nQC35EkIeWUOc5bifDarSv+rokcz6UwY5QNDcPfQmpg9Q2+jBG3elcMj2SZxtIm84rWk2Zp
JNdgcRTK99XEMBLSsKsWumrONyJxauZagYGJM/FsSMCUvueR3BpfoxPtGV61vdNsU+zAax1b
4Nk8Lan6l9HMtuYkQ6twH+Y53bRU9cYegqvfFuyhlk3EHsf2ZtPL2wn2bl8e316fjoO9ob+m
4rYK/KgLcdJKYPibtllef/QtGl8Vu/qj4wmzuwqyeNmuVnhOxYnoG8TbrRxqS4u19MoDfx/A
Kmn3B3wAQgyTQLFdK6dKAi5M28ZRE8b3bdOMsmsJddHm+qZ+A9aOxl8AinXDz2uOo6aK83VD
vXoGsirYXYej5cUIhSjJeOvX7gH3WdgGwjDAL4JpE4f04sDQYdXSay7DlqU6hCK2BROLejTD
uhund0kutz7c4OtrFZbAr3uVW2Ai1EFCHd9wbLsOKrmgLMAI5Grp7DZDgd2XYH7UMhAYvy7y
imceEUzsAXpYrQxtiTMwC1dyafjAs8jUPsWf72LqmTkf2GyZVOpor8TceAySFlVStLVa9DbZ
BmmUGAqHatl7d7msu/tYBuyCtClKveh4Vxd5QsYuxCbdV0oKFYQm+GBHLSppzML0e7AkHxAh
rtkl+SbI1eLu4rwGe7khc/MgQRoqKd4YMNamJmw8iy2lTxiyWCc4hZRSeij+KIXFYISvVory
Sao2W6ZxGUQOLUxIs15MLeLTHdhdaW2WQdjVJGEGcqGxPIMxrYwMyoJ79qhU/Qo2NEzyjaOV
JWFVYBIDU8Gwc4irWJvWWZs2CZNFY9F5YxLjomriO3kYyiDHbBQwK4SpIwC1mVnGTZDe53sF
imG4Q00uejBYrcbWDiTjav4uJcgf/WaIEaUBbrlyOm8Uo6hgD7tXWwq6Enhj+KR/s6R9g8/A
YEGkM2IyiiYO6Ex3PRaEEpaj2NRWqLVMW0XTVnIoD6ZCMAxHUCem+V9nQdX8XtzLhYlQbZyb
ZFsoENi6x7GiYZsNKBBNUTebqq0bnujU2P0W1+pDWVMWLtOmSZIVjTYh90memVTN57gq+j6O
3www8+T/fB/BKq4q4BqUI4awapckPIQOYmAV9kumCNI+ldjgl0QYGWOWXdn6GVuND3I35DEQ
nwrRYMEMZSxPQFaeT5fTw+lJdyFjb4GXwuCxF7+jwhPy994oTCWTwgBg4EBDZ/Dds9IZKVm0
9NmAkCoQGl1swuSAJz1gQPPTJrlTWigFBIIxkck50hGKkQCaKqGyPyC6TcvksBRnDC8qz5VQ
aAhmaVw2QX3YhDKXFbI8ByM4jA95vOv3xuONg+yZjUzWHvCzp+F9ujg8A0tqpaMrKBaTyWCQ
W1QsMtb0nJ/xtVmr/AEQqMsiasMmTQxh4we6KKlZIr14D3M+D1KcOAa+IvmqzuTqUauzwWC5
BeulPoYs8kcLSjePeJa/j44szLk0J05vF9wnDSfdRA4hNpqz+d6ycNCMvdujwN0i6LOFGfEx
UYDIjn3r2Nam1CSH5RO1Z/seIZWJKHfm3Ch2BWyGcvVSi7452mj3cJ4PzzzYI1lDvySViXhC
nPcJMXr++1TmJ9ESWf/q+280rzYPGyMyHAuOeP6M2UgT5jULrY60puEf2jI8epVHq7Vdhxqt
OvVt+8bwVz7eSy3m+vj3/VYLRDB77Ypn7MYODY+84d8b/VkuTrw+Z1f4dHx7o/bUbCqHVM50
xIB1hoav3OJdpDClycYdfA4mwv9OGEeaAmzuePKle8W7pcnpZVLja+c/flwmy/QOte2hjibP
x5+DP93x6e00+aObvHTdl+7L/0FbOqmkTff0yi5EnzHozePL19PwJXY0eT5+e3z5RrlBM30U
hT7pi8HkIgLBUEeAAQ/rIFrHZl3LidQsHhpBkyirFoMm2V6tNGtaygBjKCYWURVq3zCEKZHI
SKH3RKWIMB5txU/QGP/Kp+MFGP48WT/96Cbp8Wd31vjKBAD+N7Nu6BVefF2apyajaPemi4GR
ZMhEpAl7xqQ9C0A6vnRSuBomyElxKPKUOq5gTduF2vgjjBkdxgYxipuMZxQ3Gc8o3mE8Xywn
tXoqN35fSEGERjDXhgTiLr6HSaVGomGoPmmU7QQEslhp9yIjTjV9GPCTcmzUI+j7EjYxNvhW
LqZ2TsM6Oxd9XwQgvWDPZzZsbbQ5M36DCXoq7WCXoOSjqNESlNpoomTiyNH7gLau57KDKFN6
sBGVDyPHomTDlCwzzpKZEnoIQM5MBgVR27RqGKZ4W8frj4oxuC6a/uRJtthvmGH9sST8nYcz
k04L71nyTW10IrYXMplSTQQrfaruNNjhbh9T5oph0EO2Sg4r2P/ypNhKjxMwY5fbdaANwYDA
TYaxn4b0CkwtVgHsLbbJssJ4fmYJK3ZBVSU3KNAQMDAj3tQglcxSWCV7DPejizqe46x2hgLu
4RNtGYo/M0bvqUtvttq0KLdLx7P3yo5qU8OGBv7heuJrCxEznVlTRb6S/O4Ao8Yewqh6BIas
qO/Y0ds4A8rvP98eH2APz5YkegqUG+m0blB5A47oWF6UfIcRxomUyqlPPgFfId7AEpZGdLuU
TzuaYLMt1I/0nYMhdCofekwCqDRYojAuUb9/ns7nlv6tcGxgYKTUL6b3VAHptSELJmdiiEAC
G0x5VHsk8uvALokcAtsbfoe8zQ78Gq4W6HoVKdz6XeWjOz++fu/O0LHrnlO1XNIydB3SlYDJ
PsqwGgZu2MQRC8q6QqjZUO/t/79jyZuUJQswpajrbNs3RoG5+g4lL5GU7WtMRiA2UVk2lvAJ
r0E2TGr6kCyPG8chA7sL46rHiGL6m6di3JpPKvh17bD7EsWYHG9ZxSzBFCmLOmkU9b/C7Y8K
wuCJimIb5E0jJaHFMt6rMHUOrNRrVabu2D+JtM7Yz/Xxy7fuMnk9dxgo4YS5Cx9OL18fv/04
H4mjKTxrlatEyGGTl7qa5UOjNbHNWTxJM1y4whVLu7JFniXDjtIkIBRL1odouaYf93L0Ll6G
gWkLi6fagg4TpOZ9bg7lNPdlLPSQ/Tw0YZkRsDBRgVVjz217Q9Li28NEK4YrH8kFlyM2kVvX
GMaF5EZfLgtW7FOKjRPUuF2zZ7K7O0cxLxw1/9Uofs3P1+7XkD8Ge33q/urOv0Wd8GtS//l4
efiuuw/wwjE+aZm4rG+e66jD8U9LV5sVPF2688vx0k0y2AHqRgFvRISZ55tMiijLMfk2YfGH
RyzVOkMlksChL0m9SxrxjjUTn6SUu6qOP4FFTgDV/RWLmtYGUjDiLBzsJCH6Gg/A9jfOWfFz
07qNuDraiDI8gg4Y0DUMwaaXDquv+DJtVhmFgG1jUAW1aLDLSKb5TchmIbmVS8gY/3WrH0gE
G86s3oTGQuoyqPaGfIEjXR+w8z0qfsD4DhVrtdGH9UoXFdv3KmTm4Ts0is8mRZFUdLxJYXD3
wdbwWlmiMblCjlUZT7OvNEOu4XfIVvjXlJNzpMqSdBkHhgiignCXVWFm05BK+x2CbH9QBdJE
ZcpRiFQsqfh7fDQTsLz0G/qoTeBLTV+FM/Vw48Ae8Td9dMWxrgy5B1GDmbyM++/NtVPx9uXm
78wFb/BPQt09I3rbykY/q47rDgkCzZuBnrc0ndLme+pmAXHhJ65XpQ829SdjW/uU3IbisuaO
1mj7OCcdZASdJx0XXuFBNvOmaqHFjnZTz+KsbpKQctLAy1S8QLzWwa4TmQcyBTsMTjs6hjnY
sJzyYrsYwbLCc40cz5g2OzwmyNex7s6IzqiaKcC+D4LG5lFA5HKDHEwvb0FrH05RJQbffY6u
3ZmSK1tC7xzlqSjvTpjNXEMqvSuBIboRv65tqyqpYXRz0vOE0TBfbkthNQM6FFBvJgsLQ+3v
RuxCDA81Qi17r5WlZyaS8ey20rCachkplmCuHT61hpcbIlEVfDK1GpMR6QzooYpzAUP1IIUz
mIWUii01Yj2Nx6WnZMIbwN5+33tJmAuUU5UNQH+mDi/riKcOSg+luocoKacbg/a5KusmaFp1
Gqse/yPQc7TelTt64WHIMfuJqdvLyPEtjY+N6y10We1fBJiKymu1nDxu9ksxmDyfV2GAiWq0
4ps09BZ0xAAu3teEzgpYzr08Tjf53SIDF/gu2cyuMdWymQTfdcwM+dsZQVK79ip1bTJjqkjh
7MfHsVetyi5k/3h6fPnXB/sXtlOq1stJ/wTgx8sX3LfpDleTD1dvtV8UvbzE4+BMYY+aFpj3
Pt1X8VrjGSbLvKElWe5fYnIpZETyI4VvpWsUrXqdufbUEtnVnB+/fdNXod7HRp1Qg+sNS4pq
wBWw9m2KRpfLHp81tPUlEW3AHG/AQKbNSYn0tk+oRBqWdNB5iSgIm2SbNPTJtkRpeMUi0Qx+
WFe/o8fXCz78f5tcOOuvEpl3l6+PuJPvD3wmH3CELsfzt+7yi/TCShqLKsjrJM6p41O59yx7
hHFcykDxPjeR4QMLo/4fuYjBx6XbCrZHT5ZJqvC2x1dNiMeh4icI0nLwjNgoC3rXOM26AhSm
RNMc4+r7PMTnrNJlVL1jcPogry/JUD8m9slgN9y/2SV61RPVcbrCsxE5yj3HgairDghDChy5
G+PdYbvX7hM30XQ6F8ODJtkaH4AnyUH1uG7s2R35YKwMKpZiCwQhFk6O2c8B+dFSwFXB+Ck8
T+IIbvji1rJGJxmKgXjryZy600OxonksklAiJ+AVY13pRE8oHAdLrplJcSgxb9g6zpPqk3TS
i9kBMJsBR9FSgp9XrSF9REWkBkCo2AD+G9fNVqy8By8xYYxhVehJkrxsKQUwFJzJk1EAD2/Q
D8RkutJHJZl2hvkpaK1mUHy5UPe+t3hVH4T32jzNHh/Op7fT18tk8/O1O/+6nXz70b1dJO/g
MSDxbdKhSesqvpe8cXvAIRbNKrAW1/wN+CAfBXrwqL/VHGIjlOt0NrOTz/HhbvnRsab+DTKw
rkRKSxBxTpwldUhlmVDpDNmMVDJ2L2XMWdET+Y7naZ1D4KEONPgd/8tVNPflhtXv7dK7tyk5
Kx4euqfufHruxpQbQ4wEGcOpX45Pp28s/kMf3QTWPyhO+/YWnVjSgP7j8dcvj+eOZ1JXyhyU
adTMXXtG6t+/WVofEPv1+ABkL5hrz9CRscq5LeaYhd9zOaTp+4X1sWCwNWNImPrny+V79/Yo
8cxIw/0iu8ufp/O/WE9//qc7/88keX7tvrCKQ7LpsKGRArL/zRJ6qbiAlMCX3fnbzwmTAJSd
JBQriOe+NxWZwwBjEPNRjExFsZr+n7VraW4cR9L3/hWOOc0eekck9TzsASYpiWW+TFAyqy6M
Gltd7eiyXWu7Irr31y8SICgAzITcG3uoKAv5EQSBBJBI5KM5vb18h2PARZ66hBw9EBBmN3YA
aclE6ASGxUbZCE7WQPb88Pry+GDzuSpyVqv+umKmA9aO99t6x64rW9g+lJk4lsDtAdoavR7C
Y02FXU9qhHPnqYsnsrZLN9P7nQurGgT1KaV2Lbg0oWG4vlTTvQZM41c2WbJLE9JSRePAMQMN
VBAXKvDwmOfyTAAtaH+M9xkuFQzZRqbaUrwOSLk4NazbfX374/SOBZtxKOdauyzvWZdB3JYt
djzZZmmeSAMXM8vnvgAVI/QF7x1rIfCqH2hGvkmkZqhDCoSlbZkDFkr7LFquZqTNEaSeFhgu
UZiWeJsIMsRy0lmq9RlhzEuryMelHbPXeycQ78UMSEebeuJuIs1zVlbdCENRVV7HfVc5+R50
xzBxRohzg/vFD7A0F9Pi5mAovTVQdGMqJnBq7cJFVTqVjGXndL1qM/r+cv+HqQmByETN6bfT
6wnW5QexAXx7trbBLEZN+aBqXq8DK9fHB2s3ulnUsucJppM3PkHppexInzZ5M19jvWuAdAJx
rALBHwtCcWKgOJW+zsLU2G2KicgW0TxARwpIC5Jkh2O3aagW14asZsTj10WwXuMaOwMVJ3G6
muHJkRzYJrwwFLEMXdbHNdGiLc/Bn/bSu3ZpkZUXUZ5ki2YHTTO9I1V1GfyvsvhaLHxbNcRS
D9ScB7NwLbOdJLazINaUDuyT/A2pWV4wTvQepa02IFVXMvKMoEHHGN+azIlX1GFP5ZIzWUyI
tWv72sAcbpV4mbpdlT0vbbeIJsMLWHYDCbZxq1SJEBvqKgj65IjbZWkMtSEP9H4ZEaKcCeh3
jAi0oFGksYAGxJ935cHzwQKyb3AduaaXbiCnCd3/PMflJ7mYill1DaFECENea20Va9oyPkbE
rYALxTPp2Kjl8iN1LYkQSTZqtVnHR+rKwt4jKCu2JgWL9j2VYZO3h+tLVRiYj3zddcVbQutT
dKAZxUMKwKNZ0a0LYoXQZLzmkUyzlSRbC6FSBzx/Oz0/3l/xlxh16RMnmLTMRLt3B2kDTiRD
cmHhApcYXRzBBy6M2ARNWBfMCE6xUWvCyEej2vgwHSR9nMQ6C+UC7SGAvqrNhiso90W4GCjj
ZLanP+C15tCYq30brgi7fwdFJH+wUMvV8vL+IlCriwsCoAg7dQu1WoYfaJdAfeCN64DaJ2zU
8gPtAhTsomK4PgjOit3HwcV2F28vSh0aXHy84mOSxh9Er3CbCQe1/ghqQWjk/BxtMP2gFlbH
k6fvL9/EXPsxOAlYx+iPwNFWgk0yvXUqt4mLAqkKGYNvFson3oB7YOGHYJBI1A9Tx4htRhh4
guUcUYVZAVibWUddVST+quIbjlHqBkQRSD3to6691I1lxTa8McYvfI0xEEsoS4TQTvaH165P
Sv67AnYElL6/43VWwncTqzN/+fl6j5iFi4p5E08ubrTKSF7AU0olKXh6IDrdvQeR7ZR5mw9z
17P62gPYtm3RzAQL05Csq+dCkqYB0jR16QFUd7mH2iS+flD50L30RdbvOY1QbnA0/SiWspmv
A8o6LlbeHhgsvPu2jT0oxotNuPS9aWCo5Bqc2eWkIabGEOPY97I2Z3zlG7WOe6gytlbo6xQx
Z5rUxzal7HjQ+rH68jfXGW9ZvKePngAqiSgAA5m3RRT2OS4Vs6Y4rgoQxVzTU6PPCrguz3Ar
FUUljKd1C9RmQR79QaGybQvfXAGNQN/UvsEp2hvfjIAN4GJ/fwJlOfmtfK9q6OPiAqBoD7gs
p70SxQEJ74uxipbg8nToJzI+jWadDj/B74XwL2Zb0eCGryPZlWNsOmGOpFoGselllPXW29kc
AvLi1iusjcUgBN4FaDysXESItlAxJTSEoss4hhBDAZhiOXcOdJYk5uyHo/6fZfl1ZSmXoH8K
UYavMYOuvi/2eB+LKcvE5hDB4tvciWlDViVafiPb7iJ0TXmbik2gcJqnzvh0tUpPQFU6fK92
qBqfkp5wrI7Bzg8fdNj/6ySmXwwzPC6SWxohBbG+4DsSAMsA+bhso2ge3r5MiF4HHX9tIhQ1
p6eX99OP15d7TIXQpBDrb+oSM97lTh5Wlf54evs2FbGaWnyicZMEP1Xjd2DrSVOgwKWOFj3n
1lhvHe9yIbrxXdaMjuGC4Z8f7h5fT0aCCEUQX/lP/tfb++npqnq+in9//PEfV29gtPqbOJ0g
HnQgCtVFn1SCecqpUZw+14iTEta3ygkoZuWROLcMADigpYwfiHQZ2iVJfGiclVvCl0aD8OY6
uDT9GK4gXqpv1ZHvVx0jOvX04PTLOFzx2Q/QkLakTzhc+YnVGT86GBheVhUhOChQHTKkIt3u
afPMJX4TyEa6gRNdOt82E464fn35+nD/8kSxhD5syCt6fCGoYuUAQpk+AB0LfKdjr2MtUJYp
Xf2v7evp9Hb/9fvp6vblNbulmnl7yOK4T8tdhl6pJDVjoRGO4Wy6cuEVylr3P4uOejHsQLs6
PoaX+FMOEGhN0U6YvEKpU8XR6M8/yVerg9NtsfMerMoaDw2PVK4M8gx1CrpIDHsHubGI2dcw
ShMFAPDi7u8ahs8HQPC4phROQEaUV2YWILfxsvW3P79+F1xGMrraVcFe8ZbQe0sEaA0YxJXE
NdJqgxCCUM/xtVEB+DUucUpqnhPbpqSKrQY3ZJBUXiSAoAF3cck5vdCgvWQzMaLXcqWknZ0Q
dyzPKjVD/DLWByaSV2lWxepMLiSrY5W3EKYlrg517lm/JD76G3gi8po8V0+XYsln3eP3x2d3
Mg8PqrAj/TE+mIsT8oTdjC/u5aOOI/whscGQlAswBNo2KeaHlnZtfPZcSP98v3951rEbE/dD
FLhnQvj8pEy9zsctRdpytpmvMfueAeB6sA3FBeuiaIEZHJwB2qcJeRb8mvBToIKom3a69rot
F8pi031SzTuwXQL7XbqGpl1vVmZ+tqGcF4uFHVBjIOjQTYS4U1QN5m2QmTblGViOy/BEWFkf
X6PFScGocrXDolTwdBUb7KFwX3YDRmiAsosHLxEh+owtPG9dYJMu/9xiY2I8btepG8Ah5vEI
Ce2K+R2SlMhFDM/6Xy7anh7Tcgx3MTF51hJY0uWRmSh6KBgtWrWwVbAAnRqCMDedv9Xv4fGx
LBYMKn1scrzUxicsNJ1FEhZZ+bcL1iSzpVuwcQrMdKJGzHP1OjvS003HEyxR4E0Xf7oJZmai
5SKOwsjydWeruWmnPhS4/QfF1KW6oK3nCzQNewHupkE/mHfapW6B2couFoOwsAqWljk9b2/W
VoJuKLhmC8uU7v9gDT9y0Wq2CRorS6soCzeYeZMgLM3xVL/7bMviFDx7WJ6bfCPIm01n/s6k
WRSz44sNhxdGxBeTRw8vUezkbJGEJAhUGTIABomIIZPxbPIavZaWxzSvanBtadO4tZ31VRRS
suZ9t0ItxbKShUKwdrpCK8Co2oTwv5r01EBTHtNujeLcCNZUZI1DmDia3sbhfIV9gaSsLcaR
RfYeqdmadUG0tPZVMMRcon1TxHU0t1O06ri4cH+/WMENeEe1WB3iueBGtJtKdlit7b0SLk+I
TlVbuthCmRmGTm7XRxBQxlD/lgANG3nmDMSZcsRfdQYIutWtTcwaSNxTkaM0yr3Tzz4Le3G4
8gy0jFxD9AKXPAexupWNtHVBKi80VF8QuhwFSbY8KT4Gwlshb1jj2TowY5VBGRcr/8IuUyEt
nSE4bpfBjKj8mIndXjpG9NZQD1J1p6v6uy5EMkPtVerka4b9v0l5zIiUa9OHB9Xbj+9C/Hbz
hhXxPFzg9ZwfUE/8fnqSATH56fntxfFggtu4vt4P+y+x3AIm/VIhoFFYSJdrS8yA3+4uG8d8
ja+L7NbeQ3mcRLMeK7MkEWhP1mQw83e1ue/zmps/j1/Wm86yQne7RPbJ/vFhKJAeOyq/8S9m
wjgtpiiR0V4FHPJZzDznG0HrN8XDgg9V8OFDlTKX1/q5sU3nI9uEaFbIW6dCnDb09C9WkvCX
q6+KI3ERYjFbWq5Wi2ht+aUt5nNLalgsNiE43PPUKY0aq0BZ8Ru/N0uXkZK6gryb+JqW8Pnc
TRzo7IvOo3oPWYaRGTFF7FWLYGX/XpuJxcWWBSaG04WRappYpARpsUC3VrVQCbrJMt7BGB0p
H34+PekUjSZvTGi/qKTFp//+eXq+/2t06PsfCF+RJHxIAG9YmOzASe7r+8vrv5JHSBj/75/g
wDi1gSJwKr7q71/fTr/mAnZ6uMpfXn5c/VO8B5La63a8Ge0w6/67T54T0Xq/0GLzb3+9vrzd
v/w4ibHQy+O4iu2CpbWqwW+XGbcd46GQJENCFjwvC3I3j4jwYfUhmi1k5fTpsh2qAA8tbBlt
d1E4m2H8M/1KteKdvn5//93YGHTp6/tVoyJCPj++W53Ctul8bka7Bv3KLLAijKkSKxomWqdB
NJuhGvHz6fHh8f2v6bCwIozMrT/Zt+YBdJ+AXN9ZBeGMOG/uD0WWZK0ZDKHloTnJ1W930Pft
IcQNXXm2mhF5roHkWnfrHnC/drCKFjMdwsw8nb6+/Xw9PZ2EZPBT9J5901JkA1siPLHtKr5e
maOjS+wN4abollZMyqw89llczMPlzMOVAiQ4d4lwrs23OS+WCe8mG9BQjm5OIy2ylkRPp6jA
NDId7xsi6ySfIFsQKoGw5NAJjrXUdCyPqPwfgiRmGhbVgNUJ31jx9mTJxs7UzPgqCtGGXO+D
lenfDb/XtmOW2GGCNeqIJCjmBiZ+iwLr93K2cOpaLhdYXbs6ZPXMPjKpMvHdsxkecSO75Usx
V1hOKOC1JMLzcDMLcOsXG2QHj9OvAVIQLtAZLV6OlteNbWLxibMgDDC1TlM3s0VoTQbdKBVA
jjgzNwvC9j0/Cj6ao+kixVIpVlNn8YQSQ19WViyITHVRVbeCw4w1qhafEs6GMmO5CQI0VgsQ
5o7YchNFAaZAFPPwcMx4aCmnhiJ71rYxj+a2C6IsWuFmWLpLWzGYCzSZhqSsDf6FgpWpDRUF
80VkdMSBL4J1aGkPj3GZz2domiRFiqyeOKZFvpwRzhmKiPoYH/NlYMq/X8QgiTEJzJXLXpnU
nenXb8+nd6XCQ3a6m/VmZQrZ8Hth/p5tNubeNyhtC7Yr0cKJ3pPtxHqIfY8xc+DBtK2KtE0b
pZrVTxdxtAjnZuAgtXLLV0kpBSdBtkZNnjCEONku1vOI3HM0rimiANua9IUu1rOqz8/xtyfn
88LNtK1rM58Z9ub774/Pk5HD5L6sjPOsHDvQ39vqhqFvqlanbDZ2PuSV8p06ENvVrxBn4vlB
nBSeT2c+ymSQH/H25lC31snUGhxlpDrYPk6vMRA0iTWRn/mWY8dhvNHDHv4s5EVx5HkQ/779
/C7+/vHy9iiDpyB9LfedeV+7afLGeXe5NutM8OPlXQgVj8h1zCI015+EizkfWWv3Ym4dIcUJ
UWx0doG1YrV17orKRCvQFoqOs4XBvKg3Uxc0omb1tDqkvZ7eQJpCBafreracFVhw9euiDm3F
D/x27ovyvVg1jXUjqYUUhsvjbtr32uzeLK4D56RR54F5FFC/7deLssgG8cXSXDTV78nSKEoj
/OZ3WMpkW7F9azE3W72vw9nSaM+XmgkpbTkpcKPUTEbkLN0+QyAZc6DMDcYiDmP78ufjE5wu
YAo8PL6p4EDYRALJyhFjNGNlCWsgK27aH00Ovw7CyJIS66zEOKXZQqQiM8wpb7YzS1zg3YYQ
QjrRqJn9pDGpYB+PlPA+7saLKJ910y71dsT/b/QftTCfnn6AYoSYWXLhmjFIdmXbDk1nBiCM
bs+7zWxpS1uqLMJE2rYQsrzBcvK3odpqxSJtC4+yJMQTKmMfNYqid4Z1q/ihln+7SAdGO7OM
KJReDNhljKb1+zyGXD93hfvoeNWHzlaNIB3qBwDp2C/paZMT5keS7MnPC3TtF0MC0noToVF3
gTg4Z7ifvc+uj7jJPFCzArdyUrQOP6kMxBBf9waq2LNwOzFJVxxN0rUKlsd005EsVhZdXvbR
1PYGUkXjpnjq8Wm6TRvQ4edXoMlEBEnhcVASIBlsek1zE+UYAjS496OJg+8K5fwhMcO1IAnw
2cBJOu3DKcl5uI5rIkWgBJDpMBSVSKAgiYR9nKIVEX6UHKmUi5UEgL8eSaVzjkhqlsaE0elA
3jeUZxUAlCcfSf5isbo6XTS3V/e/P/6Y5h0SFBhdW1HVbzP0RoMl4F3iRCX9JD2sWEbcKg8s
Js4LMTxZU1aXGifa4wU0X1hAozQ3yffhlyZ8voZzHhE/1QyYQGF0U/ZrTr8n/VLWvN8R3SKq
Hp15Rd8lRP5kWB4FlLcpfh4CctkWB0sVNViTwCviqrjOSirWd1WVO7BzqOO9ELMISwghmU76
QR8gXa4a21Wz+Ka3Qp8OmQizuopbMxecCmUifgyh3MwPUTTW7omQDAO948GMcJeSAM9mOwA8
262FGO7bPUA3tJhDBtsbH1kcqvN+h8caVJCclS0R+WkAqB3Rg6D3O4Ouoiz1rPF1Cxi9eMh+
X1eFGc3dL2FqymxFQshQaQNZpgzzAWC9L+pg4RseXsUQ5NKHIJLbKOoYIWXK5F7HfhvS7/KD
71O+fC6JyGAq0IAOHnQp7I/GuSGE1Blw//mK//z3m7TtPu8mQ6bDIbPstLAvsjoTB3Y78SwQ
tCAHxsZVS0gTAjcJVjZSZQ7LXUGG14SnlZc9FfhxQIC/oW6mD7e5WNNilk2ylVoYOdXWKlGw
H9TvuvxDsCBkfwcXidU/I6SzEcy63UdhsucA27OS5RU9kIOrFrQB9yMBkApK5n+3ihxGpB0e
I1BAl7gJj/XTJff3WMnDIYg1IWpCPTLyB2sJqU8jfAwzfIj7sWZ36PgLVdMoc2+7twayl3E1
iIulhJJRTRjLj1iwPcDAQVIF4ILvMg7lcqJ3Yisjp/vgcezrjsFp2Q+BTRmEHN8XQ5w0sbWW
lX+U1c7aH5suhKAUPpYboI2QEd0qtQwtXbqj1QIAcX7goKvH2E/KJhcYR2FwBpd9fUyvD714
m2j3oS0y9yWavpYJk/DM3oAT58g+XJeFzEPuVjISvZ0IKN+IFUUd+QEQ88E3mgA4bIkT9UDv
uHcGiPN07W8Eq+s9ZEIvkkLwIKZDBFgVp3kFVm9NknKb/aXQOswKq+rBIf12Pgs23jYooUdw
Id3ZEkJ5CZ4BBIuOAJV5Hm3okBWb99u0aKv++IF6ppxjECUH+ZsrX0kPr+6/9WzZefuvYdI9
3guRNtFpGfk36dEwOpG/OuLkbSLlarNPCJl0CvXOKRua8My7vp/dF30r2IiSiX1J2HCUTGoV
QfwSTi73H0J6G6ejy/im+YihmVu9Sq7ASZO4XDmK096+N1E0h4wo72edz/t7InGo/LBWabyC
KJhBh/pk0BE6vwzN9vPZyi+wSp2XQIgfNEtI1Vawmfd1SCgNBShhgyxPI4p1cGEGy1ybw+pK
gj6twiDt77IvKEKqVwflAnkwEMeyOqtTenhlMvCQsN0CgDq336Rpcc0+y6TVF6AyTJsQW+h5
csZ5qxtcC+DM5+4D+pLKOqkZT0MgBUoNWcSYrNHIENCTTBFa5CmTpnJDPxBZJBJmaazKY5Fa
24Iy2by7en/9ei/vH121JbfvL8RPsMhqIT8RJzRZZwxEMiLCPQlMcigKTEICGq8OTZxaARym
VH++OAO4bRtGeX/K4W/3aG8iHXN+0tVQ6GJuBCwUP2QGWgj7X1p53oFSMCmtuv7PBml/wGet
AfFEQQcUj9F0H5J0nYKjrt2mKrbEijbFjkgyE26dp51UI7rGOWgMiQM4+OxWmxDrM6C6vQBl
08jhU7MezFM+o0IY5VlxTcTelnY24u8yjdGkCNUBAA4njqY0cUkyoWGcQ6HEwpjepthFMsR2
uz2wJElNy4gxslYbi1MZq9uDnaekmMTk0oYkthe/cit4/H66UquWNWRHBqYDrZg9HNxFOaoY
B1rFMzG4saFrTjuI82ReH+uS/hrCYvZVbdAgl1wPxVZyLgi6Ae5rnwn6FvKMxc3nerS2OhOO
aYPnG9xylbTPsGkZCwxOkEWT3J26DjZ9RJcNCQ/BGb3IOCcj298eqha1Qj601ZbPe7PrVJlV
tBVNUwVnXeKBYzN1yPlmPlyJ3snZZ+f5c2nfpEnWiFnQi/+QKjEky++YWOu3VZ5Xd9irRKcm
aYdSShhJyR5Ee4q0ZXFVTzPJxV/vfz8ZZl5bHrN4n9rMIIuU6QI6JYZKlLL17fTz4eXqNzEj
kAkhnZLR8ASSIiZknjSpYcB5kzal2fPapOI874sarU/9pwf9LGFMm2fMecglB1MFAlKmBVZt
aZpYix86Wd1//ePx7WW9Xmx+Df5hkmOxY9UQHWUerewHR8qKppgGrxZlbdrJOxTb1dem4ffy
Dgi/VrBBS0zP4EACuiFL7BzkQCLP47iPmwPC4p44kCXVi8sNQdlE1DP/W9mxLbet4973KzJ9
2p3pnondpE0f+kBLtMVGt1JSnORF4yY+iaeNk7GdPaf79QuQkswLqHRfcgEgXkEAJEHgc3BO
Ppt+kTbmLFTPxaczt/+iKpDDWupdgPXtZGoHXXGRlI8b0qi8p3Z7+jonNHhKgz/Q4DMafE6D
P9LgTzT4c6DdgaZMAm2ZOI25LMRFK93BVNAmMIoZi1oJm7nc/QoREQezj7b5jyRgJTWSOsge
SGTBahGo4UaKNH2jjgXjb5JIHvAT6ikEdAYsjJF2irwRNdVINT7QgZFvwSC7FGZmWkQ09dxK
U9XkAhmb1EqWUaYfE6/vXnfoAuklOMZkEabSuUHF/K3hmI+104e9nuKyEqAd8hrJJNhTxoe1
xMPzuC9uaGZnZXUYclAB0cYJWHVcsnA6H6RSZpKIfKpeRfKoQdsN0+9W6qK1liKqTfcGTeBD
LE3bF5PzelnISwJTstqYH5WDLWEy5jl0FC0/tDhazMEbuUEUPLKA5Q+djBRNBrOc8LQMxRfr
m3TDMsooHPAVm+NVsYiJ7qB9HBfLHF/fvYFuYducWuarsskVGk0W2A/PC9w256EMJAF6HaGb
trwDnygsjCYIhNSa1aEsAgQbvEXOuk2Ph2TVTQYmI16E2yvjSDIECu5WgWX9Z/QFEb+i9tF9
ut8j3zJjo4Zz8e7nanuPb63f44/757+273+tnlbw3+r+ZbN9v1/9uYYCN/fvN9vD+gGX+Pvv
L3++06v+cr3brn+ePK5292vlIH5c/V3sxqfn3a+TzXaDTys3/111z7yHLgt0uUAnIZxMcywE
pqfXDG7nq3co5iBKbQIj9iJZeY8Ot32IgeDKtMEARolT9GcL0e7Xy+H55O55tz553p08rn++
qPfyFjHYvuamsgOydMFKEQBPfThnMQn0SavLSJSJGY/MQfifJFaycgPok0orT/UAIwkHM95r
eLAlLNT4y7L0qQHol4AXnD4paEa2IMrt4JZ5b6PQ95fNYKeP0a8DUfntD/h1jXkYXHKbeDGf
TC+yJvValDcpDfQ7pX4RfNHUCShHDz6EzNN7ytfvPzd3//6x/nVyp/j4Ybd6efzlsa+00m9r
WOyzC4+ICiNF6I4Tj2RcUQqlZ9SM6Gojr/j0/HzyeTiAfj084qOju9VhfX/Ct6oT+ALrr83h
8YTt9893G4WKV4eVlV+qKzHgudbPT0SJ1f7bBOwXNj0ti/TGfko7LM2FqGCC/UXIv4krckwS
BpLtyjtLmKlwGE/P9+aBQt+MWUQUFc2po/seWUvqkzFO5WZwxg6WyiVRTDFWc6lbawOv64oo
B7SfG5TXWQ5JeORjsIDrJqPGuKqIAU5W+8fQ+GbMb3JCAa+pzl1pyv6d3Xp/8GuQ0Yep/6UC
+5Vck4J6lrJLPp0RHdaYkamFeurJaSzmXqELsqrgqGfxGQE7J9qUCeB05RgUCKLXSZ0snpBv
9Q28HQLhiJieB5LGDhQfptRJS79EEzbx1y0s9/OPFPh8QujghH3wgRkBq8GKmRULoiP1Qk4+
Uyc6HX5Z6pq1aNu8PNoZm3o5RJgeHFOukOxSLMPZqTuOYZiBWoxI74jh/s6JZWXgfOZB6Eei
Pc6tr2NVqd/EVxVLKzY2v73wJmSzLLVTnTtxPnPD7m0uiBXSwY8DoKfn+ekFX19aNvDQyzlY
/ZzoSXpLJrnVyIszn+3S2zOymLNkdK3dVrUfJFrC7uD56SR/ffq+3vXhmPpQTQ5D5ZVoo1KS
zzT7XsoZBlXMG9+WQAwpVDVGyyGPNxDnJKPxKbwiv4q65ug5KWF7TJq8GDTeNfB/br7vVrCh
2D2/HjZbQlGkYkYuNYR3Qrh3gh6jIXGaXUc/1yQ0arCbxkswzSsfHQf61usDMBLFLf8yGSMZ
qz6oV469GzG2kCggnxPKTMFLb9hfLkUeehhjEJYiKq4jHkrJdyTs/Jpk4CGcQVmdB9LZGs1T
D1RZwO3FI6xDDjIeJYzTyJIZyNxAiy6eR9TzMKq26ekZCxT1LeD6YJFgooG3h1Rki5pHagG/
Rao9ZX5nbKl3nT6VkWuHmGo258g940VEEVgBgRKU73IV8NAzBzxLi4WI8JXAm/zHpg3VIvuA
SjkGHheUgSybWdrRVM0sSFaXGU1zfX76uY247E5ceXeLbw5AeRlVF5ib7wrxWIp/03+8rewq
GiHB8j7hI4UKb2t8Qi3tMQ7Yn2pDuVfJV/ebh61+lX73uL77sdk+mNpP32eax9OSjlTQEYKQ
jy5TUdXG6V6IQmki/OvLu3fGlfBvNLAvciZyJm9wCPN63uuzNKjIUpFj5F7J8gW3PYGZ8m8g
ujUTYLxecWnG3+xf+oBdm0flTTuXyqHXPHgxSVKe99gjoxYyFpR0wUyNvM2bbAZ1HsvTJ/vq
RaHB7BEsKtD15LqLJpaiAE719kBRK+qmtUxBZ0cG/8KyTOddTjQbDsuDz24unCYdMfRNa0fC
5JK56TQsilkglyFg7TvcI9yxCyMqujaoUX87GhlHGMP+cygJ2CUuMmMkiGLBUFWPDuxALAiN
uQ+/RWUOJlhnEpvQo6HcN/i2IMsAg5eoEaEU9fVtq52Yhl5pSHt98ZHoTodUzpMl9Zlg5CR0
WCYzt2qE1QmwtYeoQFBFHnQWffVgNhceu9nOboV5GmpgYPQC8DN/sZr3Tf3yj4zdD6sw2Rms
xCsO3ZHMjH+Jb7qLjGcuCD1r8KGFDbdSfuQY0h8gSKYurozZRzA0O2USb2sSLq2tGwxcosqr
bvJI0c6HWFhvUUVlQ5AgFkaoJCpDVF7kPQITNJQ2dkCVRZHaKMk96s55icAwfE3lRjuxEG1F
qqBFqufQmNq0sM6M8P+xdTywQl1kIjJDNUfpbVszqzB8eg72OmVlZKWA1WzoPv/ODPDz2Bjf
QsQwGAtQh9K8X8Xro5iXhf0MDh9e0Y+bi9lXtgikaqpRIZPdN4IhOcrTHRlRODPWI9T2sErS
WHwIImUQmY4hsyZcapSVsXmXZOKaAWlf5/VWjoK+7Dbbww8d2+hpvX/wr/gj7Qfdgu2Zgi2Q
Dlc+n4IU3xrB6y9nAzt0NplXwplpaWWzAk1OLmXOMtozIdjY4QRm83P978PmqTOW9or0TsN3
ftd4rm59sgaPsxIeGXf1cwmNaJdM5l8mp9OzfxhMVGLya2ywZURJzmJVGiCJJZFwjKuBvojA
0+btT7eiQRhgTPpMVBmrTbHrYlSb2iK3b9F1Kfpee97k+hOWCoypOKVO7JXMWzIQV7qnZaGc
kK0uWRjyAvpY6ZKzS5UHSUvWoz37u5OiplCdQW3uel6N199fHx7w+lZs94fdK4btNaYvYwud
JljFKvGBw9Wxnucvp39PKCodtYIuoYtoUaFPSw5q5d07p/MVMQuVksNL/ElKooEMrx0VZYYe
3uER7gu079GbWWV7MikAbFYC7z00eob5YKlDV41GV06nCs1HmaUOlc8KbLgAi1aFSO0wjb81
j3YntWuGP5punjPT9WAo98gTylWPX9eY5cH2zdbFIV5pSWr3gd8Wy9zcyigYLIGqyB1nDRsD
cwNmfe44oISIbznppnZsIoiTuSsjQLeBLCAYrkOMaXabcO6cRdhY9V6A4hCbzPZtsnH4aDrR
/gyBSkBUgKTonza8WVknqXvFMTEUR9rMemLKLU7h0a6sHO7t2A6s1hRkl9/SHhNsm/ZtaVC1
mV9XoEniDsnzWCuWETkQ8O1RvK/y7il3GHekE7FILIM7UkdjalY0OypuFLegkOK42w653jPH
9eM2qkqceED6hhPpT4rnl/37E8yw8PqihXmy2j7szTWocrODlrLeWlhgfOLRGMfJGomsVzT1
l1NjOIt5jQ5cTTlk1QoMJiLbBN+L1qyiR3z5DXQeKNHYjVkxvFEZ66D2hQQldv+KmsuUPke3
IgLtDi728pJzN+ilPr5BV4CjvPzn/mWzRfcAaNDT62H99xr+WB/u/vjjj3+ZB1W6YNxsNTW/
Ji/VuomFWnE4CUH7xpdyWfGscvlQbxVglUF//DK7lzNq69JLJ/pMVvnowdziLqH17fN+/pa6
mWOirormVkEm3/8/o9uXp97v4W5nnjLTZ1WtcIU8wpRtBuqlbfIK9rUgB/TxCSFdtGQLLLEf
Wm/erw6rE1SYd3gAuPcnHI8Pw3pEHS66hubChWi3WMf00+K0jVmNG1sVA1q48aSsNRNosdvg
SPLO49LPFw9Kg9Lo3lz2BjfoGJUYK8wuSBLiKYMEdK1RkltH+P0mYvm3auSBj90ldzBAGmnj
WSqzmfLpLkpdv3SU12Djj2MXYAsmNE18A9ssWLlzh4V1AZrpM6WeYXzwwPZIosvDyNWt87H+
LOoETD9MKAHcxLAqlamit07J4Rcs77qtlgL3Om7LjaI6k7hamrvxEgybDFgVLHf1qdq7VHb7
rPr6/bJbUUfYVk3ZvQ7r90ROj2dFUaM894sOTtEbsxOamOGzUhbzzuA2RZFXEMYULOZzD64N
FI8plimryXGAsa5yVlZJUQcR/dbPmQ/NDzMQghh9ULXbsaItnO/2PcyrRrM8xxj3mMZXfefc
Y/RUIIB7PFFYP7dGEXZjvAmjV4NxdpHXieboUH28Y3iRo9Q3Pz7yaTuDLWaSMRkILmjwPknp
VAfbVjxSxRHxuqL7gL8a2e2Txglaffk/vaDb45JTZ4tRcTXM0MDbx7MGXS9wMojrckSkG7W+
SVwxjAjoa5rt/f7D1NI15glZvd4f0DpAwy96/s96t3ow8iJcNpY1rv7V8tx8BKLB9pG9hvFr
1SgSh4yrTCRzZHr9jCdjKjHEV30iRPZYn3eQNPY+AXYHOCF61O1LDglcriQatARHG116yMpg
/xE8SR0bS8OeQ3tJvVZGV/IiajJ3DdmkbCb0MNBJG5wjzv8B1tYxEHXIAQA=

--TB36FDmn/VVEgNH/--
