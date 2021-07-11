Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA643C3AAC
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 07:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhGKFF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 01:05:56 -0400
Received: from mga01.intel.com ([192.55.52.88]:15106 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229660AbhGKFFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 01:05:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10041"; a="231634460"
X-IronPort-AV: E=Sophos;i="5.84,230,1620716400"; 
   d="gz'50?scan'50,208,50";a="231634460"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2021 22:03:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,230,1620716400"; 
   d="gz'50?scan'50,208,50";a="425173911"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 10 Jul 2021 22:03:03 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m2RcM-000G8O-Mh; Sun, 11 Jul 2021 05:03:02 +0000
Date:   Sun, 11 Jul 2021 13:02:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [linux-stable-rc:linux-4.4.y 1224/1774] net/core/skbuff.c:1523:32:
 warning: comparison of integer expressions of different signedness: 'long
 unsigned int' and 'int'
Message-ID: <202107111320.JR3ecJ6N-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
head:   38c92ba3580f0d00e57a55caf8f880aa1a0f2a50
commit: 2555bb2a5163e3741d5dd5916f3a9f0228750aca [1224/1774] net: drop bogus skb with CHECKSUM_PARTIAL and offset beyond end of trimmed packet
config: mips-randconfig-r013-20210705 (attached as .config)
compiler: mips64el-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=2555bb2a5163e3741d5dd5916f3a9f0228750aca
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-4.4.y
        git checkout 2555bb2a5163e3741d5dd5916f3a9f0228750aca
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/net/sock.h:51,
                    from include/linux/tcp.h:22,
                    from net/core/skbuff.c:50:
   include/linux/netdevice.h: In function 'netif_msg_init':
   include/linux/netdevice.h:3304:37: warning: comparison of integer expressions of different signedness: 'int' and 'long unsigned int' [-Wsign-compare]
    3304 |  if (debug_value < 0 || debug_value >= (sizeof(u32) * 8))
         |                                     ^~
   In file included from include/net/rtnetlink.h:5,
                    from include/net/sch_generic.h:12,
                    from include/linux/filter.h:16,
                    from include/net/sock.h:62,
                    from include/linux/tcp.h:22,
                    from net/core/skbuff.c:50:
   include/net/netlink.h: In function 'nlmsg_ok':
   include/net/netlink.h:337:18: warning: comparison of integer expressions of different signedness: '__u32' {aka 'const unsigned int'} and 'int' [-Wsign-compare]
     337 |   nlh->nlmsg_len <= remaining);
         |                  ^~
   include/net/netlink.h: In function 'nlmsg_parse':
   include/net/netlink.h:372:21: warning: comparison of integer expressions of different signedness: '__u32' {aka 'const unsigned int'} and 'int' [-Wsign-compare]
     372 |  if (nlh->nlmsg_len < nlmsg_msg_size(hdrlen))
         |                     ^
   include/net/netlink.h: In function 'nlmsg_validate':
   include/net/netlink.h:405:21: warning: comparison of integer expressions of different signedness: '__u32' {aka 'const unsigned int'} and 'int' [-Wsign-compare]
     405 |  if (nlh->nlmsg_len < nlmsg_msg_size(hdrlen))
         |                     ^
   In file included from include/net/sch_generic.h:12,
                    from include/linux/filter.h:16,
                    from include/net/sock.h:62,
                    from include/linux/tcp.h:22,
                    from net/core/skbuff.c:50:
   include/net/rtnetlink.h: In function 'rtnl_msg_family':
   include/net/rtnetlink.h:20:21: warning: comparison of integer expressions of different signedness: 'int' and 'long unsigned int' [-Wsign-compare]
      20 |  if (nlmsg_len(nlh) >= sizeof(struct rtgenmsg))
         |                     ^~
   In file included from include/uapi/linux/stddef.h:1,
                    from include/linux/stddef.h:4,
                    from include/uapi/linux/posix_types.h:4,
                    from include/uapi/linux/types.h:13,
                    from include/linux/types.h:5,
                    from include/linux/list.h:4,
                    from include/linux/module.h:9,
                    from net/core/skbuff.c:41:
   include/net/sch_generic.h: In function 'qdisc_cb_private_validate':
   include/net/sch_generic.h:267:33: warning: comparison of integer expressions of different signedness: 'long unsigned int' and 'int' [-Wsign-compare]
     267 |  BUILD_BUG_ON(sizeof(qcb->data) < sz);
         |                                 ^
   include/linux/compiler.h:491:19: note: in definition of macro '__compiletime_assert'
     491 |   bool __cond = !(condition);    \
         |                   ^~~~~~~~~
   include/linux/compiler.h:511:2: note: in expansion of macro '_compiletime_assert'
     511 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/bug.h:50:37: note: in expansion of macro 'compiletime_assert'
      50 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bug.h:74:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      74 |  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |  ^~~~~~~~~~~~~~~~
   include/net/sch_generic.h:267:2: note: in expansion of macro 'BUILD_BUG_ON'
     267 |  BUILD_BUG_ON(sizeof(qcb->data) < sz);
         |  ^~~~~~~~~~~~
   In file included from include/net/sock.h:62,
                    from include/linux/tcp.h:22,
                    from net/core/skbuff.c:50:
   include/linux/filter.h: In function 'bpf_needs_clear_a':
   include/linux/filter.h:517:16: warning: comparison of integer expressions of different signedness: '__u32' {aka 'const unsigned int'} and 'int' [-Wsign-compare]
     517 |   if (first->k == SKF_AD_OFF + SKF_AD_ALU_XOR_X)
         |                ^~
   In file included from include/linux/tcp.h:22,
                    from net/core/skbuff.c:50:
   include/net/sock.h: In function 'skb_do_copy_data_nocache':
   include/net/sock.h:1838:54: warning: comparison of integer expressions of different signedness: 'size_t' {aka 'long unsigned int'} and 'int' [-Wsign-compare]
    1838 |   if (csum_and_copy_from_iter(to, copy, &csum, from) != copy)
         |                                                      ^~
   include/net/sock.h:1842:46: warning: comparison of integer expressions of different signedness: 'size_t' {aka 'long unsigned int'} and 'int' [-Wsign-compare]
    1842 |   if (copy_from_iter_nocache(to, copy, from) != copy)
         |                                              ^~
   include/net/sock.h:1844:44: warning: comparison of integer expressions of different signedness: 'size_t' {aka 'long unsigned int'} and 'int' [-Wsign-compare]
    1844 |  } else if (copy_from_iter(to, copy, from) != copy)
         |                                            ^~
   In file included from include/linux/tcp.h:23,
                    from net/core/skbuff.c:50:
   include/net/inet_connection_sock.h: In function 'inet_csk_reqsk_queue_is_full':
   include/net/inet_connection_sock.h:294:38: warning: comparison of integer expressions of different signedness: 'int' and 'u32' {aka 'const unsigned int'} [-Wsign-compare]
     294 |  return inet_csk_reqsk_queue_len(sk) >= sk->sk_max_ack_backlog;
         |                                      ^~
   net/core/skbuff.c: In function '___pskb_trim':
   net/core/skbuff.c:1440:13: warning: comparison of integer expressions of different signedness: 'int' and 'unsigned int' [-Wsign-compare]
    1440 |  if (offset >= len)
         |             ^~
   net/core/skbuff.c:1446:11: warning: comparison of integer expressions of different signedness: 'int' and 'unsigned int' [-Wsign-compare]
    1446 |   if (end < len) {
         |           ^
   net/core/skbuff.c:1481:11: warning: comparison of integer expressions of different signedness: 'int' and 'unsigned int' [-Wsign-compare]
    1481 |   if (end < len) {
         |           ^
   net/core/skbuff.c:1486:11: warning: comparison of integer expressions of different signedness: 'int' and 'unsigned int' [-Wsign-compare]
    1486 |   if (end > len &&
         |           ^
   net/core/skbuff.c: In function 'pskb_trim_rcsum_slow':
>> net/core/skbuff.c:1523:32: warning: comparison of integer expressions of different signedness: 'long unsigned int' and 'int' [-Wsign-compare]
    1523 |   if (offset + sizeof(__sum16) > hdlen)
         |                                ^
   net/core/skbuff.c: In function '__pskb_pull_tail':
   net/core/skbuff.c:1603:18: warning: comparison of integer expressions of different signedness: 'unsigned int' and 'int' [-Wsign-compare]
    1603 |    if (list->len <= eat) {
         |                  ^~
   net/core/skbuff.c: In function 'skb_split_no_header':
   net/core/skbuff.c:2571:18: warning: comparison of integer expressions of different signedness: 'int' and 'u32' {aka 'const unsigned int'} [-Wsign-compare]
    2571 |   if (pos + size > len) {
         |                  ^
   net/core/skbuff.c:2574:12: warning: comparison of integer expressions of different signedness: 'int' and 'u32' {aka 'const unsigned int'} [-Wsign-compare]
    2574 |    if (pos < len) {
         |            ^
   net/core/skbuff.c: In function 'skb_split':
   net/core/skbuff.c:2609:10: warning: comparison of integer expressions of different signedness: 'u32' {aka 'const unsigned int'} and 'int' [-Wsign-compare]
    2609 |  if (len < pos) /* Split line is inside header. */
         |          ^
   In file included from include/linux/bug.h:4,
                    from include/linux/thread_info.h:11,
                    from include/asm-generic/preempt.h:4,
                    from arch/mips/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:59,
                    from include/linux/spinlock.h:50,
                    from include/linux/seqlock.h:35,
                    from include/linux/time.h:5,
                    from include/linux/stat.h:18,
                    from include/linux/module.h:10,
                    from net/core/skbuff.c:41:
   net/core/skbuff.c: In function 'skb_shift':
   net/core/skbuff.c:2648:18: warning: comparison of integer expressions of different signedness: 'int' and 'unsigned int' [-Wsign-compare]
    2648 |  BUG_ON(shiftlen > skb->len);
         |                  ^
   arch/mips/include/asm/bug.h:33:44: note: in definition of macro 'BUG_ON'
      33 | #define BUG_ON(C) __BUG_ON((unsigned long)(C))
         |                                            ^
   net/core/skbuff.c:2687:16: warning: comparison of integer expressions of different signedness: 'int' and 'unsigned int' [-Wsign-compare]
    2687 |  if ((shiftlen == skb->len) &&
         |                ^~
   net/core/skbuff.c:2688:41: warning: comparison of integer expressions of different signedness: 'int' and 'long unsigned int' [-Wsign-compare]
    2688 |      (skb_shinfo(skb)->nr_frags - from) > (MAX_SKB_FRAGS - to))
         |                                         ^
   net/core/skbuff.c:2701:12: warning: comparison of integer expressions of different signedness: 'int' and 'unsigned int' [-Wsign-compare]
    2701 |   if (todo >= skb_frag_size(fragfrom)) {
         |            ^~
   net/core/skbuff.c: In function 'skb_append_datato_frags':
   net/core/skbuff.c:2952:15: warning: comparison of integer expressions of different signedness: 'int' and 'long unsigned int' [-Wsign-compare]
    2952 |   if (frg_cnt >= MAX_SKB_FRAGS)
         |               ^~
   net/core/skbuff.c: In function 'skb_append_pagefrags':
   net/core/skbuff.c:2993:15: warning: comparison of integer expressions of different signedness: 'int' and 'long unsigned int' [-Wsign-compare]
    2993 |  } else if (i < MAX_SKB_FRAGS) {
         |               ^
   net/core/skbuff.c: In function 'skb_segment':
   net/core/skbuff.c:3082:13: warning: comparison of integer expressions of different signedness: 'int' and 'unsigned int' [-Wsign-compare]
    3082 |   if (hsize > len || !sg)
         |             ^
   net/core/skbuff.c:3095:15: warning: comparison of integer expressions of different signedness: 'int' and 'unsigned int' [-Wsign-compare]
    3095 |    while (pos < offset + len) {
         |               ^
   net/core/skbuff.c:3099:20: warning: comparison of integer expressions of different signedness: 'int' and 'unsigned int' [-Wsign-compare]
    3099 |     if (pos + size > offset + len)
         |                    ^
   net/core/skbuff.c:3175:14: warning: comparison of integer expressions of different signedness: 'int' and 'unsigned int' [-Wsign-compare]
    3175 |   while (pos < offset + len) {
         |              ^
   net/core/skbuff.c:3204:12: warning: comparison of integer expressions of different signedness: 'int' and 'unsigned int' [-Wsign-compare]
    3204 |    if (pos < offset) {
         |            ^
   net/core/skbuff.c:3211:19: warning: comparison of integer expressions of different signedness: 'int' and 'unsigned int' [-Wsign-compare]
    3211 |    if (pos + size <= offset + len) {
         |                   ^~
   net/core/skbuff.c: In function 'skb_gro_receive':
   net/core/skbuff.c:3282:16: warning: comparison of integer expressions of different signedness: 'int' and 'long unsigned int' [-Wsign-compare]
    3282 |   if (nr_frags > MAX_SKB_FRAGS)
         |                ^
   net/core/skbuff.c:3315:40: warning: comparison of integer expressions of different signedness: 'int' and 'long unsigned int' [-Wsign-compare]
    3315 |   if (nr_frags + 1 + skbinfo->nr_frags > MAX_SKB_FRAGS)
         |                                        ^
   net/core/skbuff.c: In function 'alloc_skb_with_frags':
   net/core/skbuff.c:4540:13: warning: comparison of integer expressions of different signedness: 'int' and 'long unsigned int' [-Wsign-compare]
    4540 |  if (npages > MAX_SKB_FRAGS)
         |             ^
   In file included from arch/mips/include/asm/atomic.h:22,
                    from include/linux/atomic.h:4,
                    from include/linux/debug_locks.h:5,
                    from include/linux/lockdep.h:23,
                    from include/linux/spinlock_types.h:18,
                    from include/linux/spinlock.h:81,
                    from include/linux/seqlock.h:35,
                    from include/linux/time.h:5,
                    from include/linux/stat.h:18,
                    from include/linux/module.h:10,
                    from net/core/skbuff.c:41:
   arch/mips/include/asm/atomic.h: In function '__atomic_add_unless':
   arch/mips/include/asm/cmpxchg.h:212:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
     212 |   if (sizeof(long) == 8) {    \
         |      ^
   arch/mips/include/asm/cmpxchg.h:227:33: note: in expansion of macro '__cmpxchg'
     227 | #define cmpxchg(ptr, old, new)  __cmpxchg(ptr, old, new, smp_mb__before_llsc(), smp_llsc_mb())
         |                                 ^~~~~~~~~


vim +1523 net/core/skbuff.c

  1508	
  1509	/* Note : use pskb_trim_rcsum() instead of calling this directly
  1510	 */
  1511	int pskb_trim_rcsum_slow(struct sk_buff *skb, unsigned int len)
  1512	{
  1513		if (skb->ip_summed == CHECKSUM_COMPLETE) {
  1514			int delta = skb->len - len;
  1515	
  1516			skb->csum = csum_block_sub(skb->csum,
  1517						   skb_checksum(skb, len, delta, 0),
  1518						   len);
  1519		} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
  1520			int hdlen = (len > skb_headlen(skb)) ? skb_headlen(skb) : len;
  1521			int offset = skb_checksum_start_offset(skb) + skb->csum_offset;
  1522	
> 1523			if (offset + sizeof(__sum16) > hdlen)
  1524				return -EINVAL;
  1525		}
  1526		return __pskb_trim(skb, len);
  1527	}
  1528	EXPORT_SYMBOL(pskb_trim_rcsum_slow);
  1529	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--u3/rZRmxL6MmkK24
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--u3/rZRmxL6MmkK24--
