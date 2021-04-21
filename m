Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B862366E9A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 16:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237851AbhDUO7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 10:59:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:33225 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243724AbhDUO7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 10:59:13 -0400
IronPort-SDR: jamjdIdyPykLNpwBDI14C4SqFiAOD7icP59NhzeujpMaSJ6NGjNgfIv5WF08OQcpAqocW+I/2s
 CvkZXIqpvpNQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9961"; a="182841152"
X-IronPort-AV: E=Sophos;i="5.82,240,1613462400"; 
   d="xz'?yaml'?scan'208";a="182841152"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 07:58:38 -0700
IronPort-SDR: OrS8s2S9J57r2n496V024uandMwUcVHyWZcQ1wr2UAxkhpgnzAyOGT2hbciKaQuQWVs4gKhGQc
 sZWd/hKFpa2A==
X-IronPort-AV: E=Sophos;i="5.82,240,1613462400"; 
   d="xz'?yaml'?scan'208";a="617360082"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 07:58:32 -0700
Date:   Wed, 21 Apr 2021 23:15:56 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: [net]  6628ddfec7:
 kernel-selftests.net.pmtu.sh.IPv4_over_geneve6_PMTU_exceptions.fail
Message-ID: <20210421151556.GC23923@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="eqp4TxRxnD4KrmFZ"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eqp4TxRxnD4KrmFZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Greeting,

FYI, we noticed the following commit (built with gcc-9):

commit: 6628ddfec7580882f11fdc5c194a8ea781fdadfa ("net: geneve: check skb is large enough for IPv4/IPv6 header")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


in testcase: kernel-selftests
version: kernel-selftests-x86_64-cf9ae1bd-1_20210401
with following parameters:

	group: net
	ucode: 0xe2

test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
test-url: https://www.kernel.org/doc/Documentation/kselftest.txt


on test machine: 4 threads Intel(R) Xeon(R) CPU E3-1225 v5 @ 3.30GHz with 16G memory

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):




If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-8.3-kselftests-6628ddfec7580882f11fdc5c194a8ea781fdadfa
2021-04-19 18:11:25 mount --bind /lib/modules/5.12.0-rc6-00349-g6628ddfec758/kernel/lib /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-6628ddfec7580882f11fdc5c194a8ea781fdadfa/lib
2021-04-19 18:11:25 sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
source /lkp/lkp/src/lib/tests/kernel-selftests-ext.sh
LKP SKIP net.l2tp.sh
LKP SKIP net.tls
2021-04-19 18:11:26 /kselftests/run_kselftest.sh -c net
TAP version 13
1..47
# selftests: net: reuseport_bpf
# ---- IPv4 UDP ----
# Testing EBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing EBPF mod 20...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 10: 10
# Socket 11: 11
# Socket 12: 12
# Socket 13: 13
# Socket 14: 14
# Socket 15: 15
# Socket 16: 16
# Socket 17: 17
# Socket 18: 18
# Socket 19: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 10: 30
# Socket 11: 31
# Socket 12: 32
# Socket 13: 33
# Socket 14: 34
# Socket 15: 35
# Socket 16: 36
# Socket 17: 37
# Socket 18: 38
# Socket 19: 39
# Reprograming, testing mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 0: 30
# Socket 1: 31
# Socket 2: 32
# Socket 3: 33
# Socket 4: 34
# Socket 5: 35
# Socket 6: 36
# Socket 7: 37
# Socket 8: 38
# Socket 9: 39
# Testing CBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 20...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 10: 10
# Socket 11: 11
# Socket 12: 12
# Socket 13: 13
# Socket 14: 14
# Socket 15: 15
# Socket 16: 16
# Socket 17: 17
# Socket 18: 18
# Socket 19: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 10: 30
# Socket 11: 31
# Socket 12: 32
# Socket 13: 33
# Socket 14: 34
# Socket 15: 35
# Socket 16: 36
# Socket 17: 37
# Socket 18: 38
# Socket 19: 39
# Reprograming, testing mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 0: 30
# Socket 1: 31
# Socket 2: 32
# Socket 3: 33
# Socket 4: 34
# Socket 5: 35
# Socket 6: 36
# Socket 7: 37
# Socket 8: 38
# Socket 9: 39
# Testing too many filters...
# Testing filters on non-SO_REUSEPORT socket...
# ---- IPv6 UDP ----
# Testing EBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing EBPF mod 20...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 10: 10
# Socket 11: 11
# Socket 12: 12
# Socket 13: 13
# Socket 14: 14
# Socket 15: 15
# Socket 16: 16
# Socket 17: 17
# Socket 18: 18
# Socket 19: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 10: 30
# Socket 11: 31
# Socket 12: 32
# Socket 13: 33
# Socket 14: 34
# Socket 15: 35
# Socket 16: 36
# Socket 17: 37
# Socket 18: 38
# Socket 19: 39
# Reprograming, testing mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 0: 30
# Socket 1: 31
# Socket 2: 32
# Socket 3: 33
# Socket 4: 34
# Socket 5: 35
# Socket 6: 36
# Socket 7: 37
# Socket 8: 38
# Socket 9: 39
# Testing CBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 20...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 10: 10
# Socket 11: 11
# Socket 12: 12
# Socket 13: 13
# Socket 14: 14
# Socket 15: 15
# Socket 16: 16
# Socket 17: 17
# Socket 18: 18
# Socket 19: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 10: 30
# Socket 11: 31
# Socket 12: 32
# Socket 13: 33
# Socket 14: 34
# Socket 15: 35
# Socket 16: 36
# Socket 17: 37
# Socket 18: 38
# Socket 19: 39
# Reprograming, testing mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 0: 30
# Socket 1: 31
# Socket 2: 32
# Socket 3: 33
# Socket 4: 34
# Socket 5: 35
# Socket 6: 36
# Socket 7: 37
# Socket 8: 38
# Socket 9: 39
# Testing too many filters...
# Testing filters on non-SO_REUSEPORT socket...
# ---- IPv6 UDP w/ mapped IPv4 ----
# Testing EBPF mod 20...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 10: 10
# Socket 11: 11
# Socket 12: 12
# Socket 13: 13
# Socket 14: 14
# Socket 15: 15
# Socket 16: 16
# Socket 17: 17
# Socket 18: 18
# Socket 19: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 10: 30
# Socket 11: 31
# Socket 12: 32
# Socket 13: 33
# Socket 14: 34
# Socket 15: 35
# Socket 16: 36
# Socket 17: 37
# Socket 18: 38
# Socket 19: 39
# Reprograming, testing mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 0: 30
# Socket 1: 31
# Socket 2: 32
# Socket 3: 33
# Socket 4: 34
# Socket 5: 35
# Socket 6: 36
# Socket 7: 37
# Socket 8: 38
# Socket 9: 39
# Testing EBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 20...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 10: 10
# Socket 11: 11
# Socket 12: 12
# Socket 13: 13
# Socket 14: 14
# Socket 15: 15
# Socket 16: 16
# Socket 17: 17
# Socket 18: 18
# Socket 19: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 10: 30
# Socket 11: 31
# Socket 12: 32
# Socket 13: 33
# Socket 14: 34
# Socket 15: 35
# Socket 16: 36
# Socket 17: 37
# Socket 18: 38
# Socket 19: 39
# Reprograming, testing mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 0: 30
# Socket 1: 31
# Socket 2: 32
# Socket 3: 33
# Socket 4: 34
# Socket 5: 35
# Socket 6: 36
# Socket 7: 37
# Socket 8: 38
# Socket 9: 39
# ---- IPv4 TCP ----
# Testing EBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing too many filters...
# Testing filters on non-SO_REUSEPORT socket...
# ---- IPv6 TCP ----
# Testing EBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing too many filters...
# Testing filters on non-SO_REUSEPORT socket...
# ---- IPv6 TCP w/ mapped IPv4 ----
# Testing EBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing filter add without bind...
# SUCCESS
ok 1 selftests: net: reuseport_bpf
# selftests: net: reuseport_bpf_cpu
# ---- IPv4 UDP ----
# send cpu 0, receive socket 0
# send cpu 1, receive socket 1
# send cpu 2, receive socket 2
# send cpu 3, receive socket 3
# send cpu 3, receive socket 3
# send cpu 2, receive socket 2
# send cpu 1, receive socket 1
# send cpu 0, receive socket 0
# send cpu 0, receive socket 0
# send cpu 2, receive socket 2
# send cpu 1, receive socket 1
# send cpu 3, receive socket 3
# ---- IPv6 UDP ----
# send cpu 0, receive socket 0
# send cpu 1, receive socket 1
# send cpu 2, receive socket 2
# send cpu 3, receive socket 3
# send cpu 3, receive socket 3
# send cpu 2, receive socket 2
# send cpu 1, receive socket 1
# send cpu 0, receive socket 0
# send cpu 0, receive socket 0
# send cpu 2, receive socket 2
# send cpu 1, receive socket 1
# send cpu 3, receive socket 3
# ---- IPv4 TCP ----
# send cpu 0, receive socket 0
# send cpu 1, receive socket 1
# send cpu 2, receive socket 2
# send cpu 3, receive socket 3
# send cpu 3, receive socket 3
# send cpu 2, receive socket 2
# send cpu 1, receive socket 1
# send cpu 0, receive socket 0
# send cpu 0, receive socket 0
# send cpu 2, receive socket 2
# send cpu 1, receive socket 1
# send cpu 3, receive socket 3
# ---- IPv6 TCP ----
# send cpu 0, receive socket 0
# send cpu 1, receive socket 1
# send cpu 2, receive socket 2
# send cpu 3, receive socket 3
# send cpu 3, receive socket 3
# send cpu 2, receive socket 2
# send cpu 1, receive socket 1
# send cpu 0, receive socket 0
# send cpu 0, receive socket 0
# send cpu 2, receive socket 2
# send cpu 1, receive socket 1
# send cpu 3, receive socket 3
# SUCCESS
ok 2 selftests: net: reuseport_bpf_cpu
# selftests: net: reuseport_bpf_numa
# ---- IPv4 UDP ----
# send node 0, receive socket 0
# send node 0, receive socket 0
# ---- IPv6 UDP ----
# send node 0, receive socket 0
# send node 0, receive socket 0
# ---- IPv4 TCP ----
# send node 0, receive socket 0
# send node 0, receive socket 0
# ---- IPv6 TCP ----
# send node 0, receive socket 0
# send node 0, receive socket 0
# SUCCESS
ok 3 selftests: net: reuseport_bpf_numa
# selftests: net: reuseport_dualstack
# ---- UDP IPv4 created before IPv6 ----
# ---- UDP IPv6 created before IPv4 ----
# ---- UDP IPv4 created before IPv6 (large) ----
# ---- UDP IPv6 created before IPv4 (large) ----
# ---- TCP IPv4 created before IPv6 ----
# ---- TCP IPv6 created before IPv4 ----
# SUCCESS
ok 4 selftests: net: reuseport_dualstack
# selftests: net: reuseaddr_conflict
# Opening 127.0.0.1:9999
# Opening INADDR_ANY:9999
# bind: Address already in use
# Opening in6addr_any:9999
# Opening INADDR_ANY:9999
# bind: Address already in use
# Opening INADDR_ANY:9999 after closing ipv6 socket
# bind: Address already in use
# Successok 5 selftests: net: reuseaddr_conflict
# selftests: net: run_netsocktests
# --------------------
# running socket test
# --------------------
# [PASS]
ok 6 selftests: net: run_netsocktests
# selftests: net: run_afpackettests
# --------------------
# running psock_fanout test
# --------------------
# test: control single socket
# test: control multiple sockets
# test: control multiple sockets, max_num_members
# test: unique ids
# 
# test: datapath 0x0 ports 8000,8002
# info: count=0,0, expect=0,0
# info: count=20,0, expect=15,5
# warning: incorrect queue lengths
# info: count=20,0, expect=20,5
# warning: incorrect queue lengths
# info: trying alternate ports (20)
# 
# test: datapath 0x0 ports 8000,8003
# info: count=0,0, expect=0,0
# info: count=20,0, expect=15,5
# warning: incorrect queue lengths
# info: count=20,0, expect=20,5
# warning: incorrect queue lengths
# info: trying alternate ports (19)
# 
# test: datapath 0x0 ports 8000,8004
# info: count=0,0, expect=0,0
# info: count=20,0, expect=15,5
# warning: incorrect queue lengths
# info: count=20,0, expect=20,5
# warning: incorrect queue lengths
# info: trying alternate ports (18)
# 
# test: datapath 0x0 ports 8000,8005
# info: count=0,0, expect=0,0
# info: count=15,5, expect=15,5
# info: count=20,5, expect=20,5
# 
# test: datapath 0x1000 ports 8000,8005
# info: count=0,0, expect=0,0
# info: count=15,5, expect=15,5
# info: count=20,15, expect=20,15
# 
# test: datapath 0x1 ports 8000,8005
# info: count=0,0, expect=0,0
# info: count=10,10, expect=10,10
# info: count=17,18, expect=18,17
# 
# test: datapath 0x3 ports 8000,8005
# info: count=0,0, expect=0,0
# info: count=15,5, expect=15,5
# info: count=20,15, expect=20,15
# 
# test: datapath 0x6 ports 8000,8005
# info: count=0,0, expect=0,0
# info: count=5,15, expect=15,5
# info: count=20,15, expect=15,20
# 
# test: datapath 0x7 ports 8000,8005
# info: count=0,0, expect=0,0
# info: count=5,15, expect=15,5
# info: count=20,15, expect=15,20
# 
# test: datapath 0x2 ports 8000,8005
# info: count=0,0, expect=0,0
# info: count=20,0, expect=20,0
# info: count=20,0, expect=20,0
# 
# test: datapath 0x2 ports 8000,8005
# info: count=0,0, expect=0,0
# info: count=0,20, expect=0,20
# info: count=0,20, expect=0,20
# 
# test: datapath 0x2000 ports 8000,8005
# info: count=0,0, expect=0,0
# info: count=20,20, expect=20,20
# info: count=20,20, expect=20,20
# OK. All tests passed
# [PASS]
# --------------------
# running psock_tpacket test
# --------------------
# test: TPACKET_V1 with PACKET_RX_RING .................... 100 pkts (14200 bytes)
# test: TPACKET_V1 with PACKET_TX_RING .................... 100 pkts (14200 bytes)
# test: TPACKET_V2 with PACKET_RX_RING .................... 100 pkts (14200 bytes)
# test: TPACKET_V2 with PACKET_TX_RING .................... 100 pkts (14200 bytes)
# test: TPACKET_V3 with PACKET_RX_RING .................... 100 pkts (14200 bytes)
# test: TPACKET_V3 with PACKET_TX_RING .................... 100 pkts (14200 bytes)
# OK. All tests passed
# [PASS]
# --------------------
# running txring_overwrite test
# --------------------
# read: a (0x61)
# read: b (0x62)
# [PASS]
ok 7 selftests: net: run_afpackettests
# selftests: net: test_bpf.sh
# test_bpf: ok
ok 8 selftests: net: test_bpf.sh
# selftests: net: netdevice.sh
# SKIP: eth0: interface already up
# PASS: eth0: ethtool list features
# PASS: eth0: ethtool dump
# PASS: eth0: ethtool stats
# SKIP: eth0: interface kept up
ok 9 selftests: net: netdevice.sh
# selftests: net: rtnetlink.sh
# PASS: policy routing
# PASS: route get
# PASS: preferred_lft addresses have expired
# PASS: promote_secondaries complete
# PASS: tc htb hierarchy
# PASS: gre tunnel endpoint
# PASS: gretap
# PASS: ip6gretap
# PASS: erspan
# PASS: ip6erspan
# PASS: bridge setup
# PASS: ipv6 addrlabel
# PASS: set ifalias dd92e639-529c-4948-9fc7-f3f3dec29199 for test-dummy0
# PASS: vrf
# PASS: vxlan
# PASS: fou
# PASS: macsec
# PASS: ipsec
# PASS: ipsec_offload
# PASS: bridge fdb get
# PASS: neigh get
# Error: Unknown device type.
# Error: argument "test-bond0" is wrong: Device does not exist
# 
# Error: argument "test-bond0" is wrong: Device does not exist
# 
# Cannot find device "test-bond0"
# Cannot find device "test-bond0"
# FAIL: bridge_parent_id
not ok 10 selftests: net: rtnetlink.sh # exit=1
# selftests: net: xfrm_policy.sh
# PASS: policy before exception matches
# PASS: ping to .254 bypassed ipsec tunnel (exceptions)
# PASS: direct policy matches (exceptions)
# PASS: policy matches (exceptions)
# PASS: ping to .254 bypassed ipsec tunnel (exceptions and block policies)
# PASS: direct policy matches (exceptions and block policies)
# PASS: policy matches (exceptions and block policies)
#
not ok 11 selftests: net: xfrm_policy.sh # TIMEOUT 45 seconds
# selftests: net: test_blackhole_dev.sh
# test_blackhole_dev: ok
ok 12 selftests: net: test_blackhole_dev.sh
# selftests: net: fib_tests.sh
# 
# Single path route test
#     Start point
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
#     Nexthop device deleted
#     TEST: IPv4 fibmatch - no route                                      [ OK ]
#     TEST: IPv6 fibmatch - no route                                      [ OK ]
# 
# Multipath route test
#     Start point
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
#     One nexthop device deleted
#     TEST: IPv4 - multipath route removed on delete                      [ OK ]
#     TEST: IPv6 - multipath down to single path                          [ OK ]
#     Second nexthop device deleted
#     TEST: IPv6 - no route                                               [ OK ]
# 
# Single path, admin down
#     Start point
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
#     Route deleted on down
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
# 
# Admin down multipath
#     Verify start point
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
#     One device down, one up
#     TEST: IPv4 fibmatch on down device                                  [ OK ]
#     TEST: IPv6 fibmatch on down device                                  [ OK ]
#     TEST: IPv4 fibmatch on up device                                    [ OK ]
#     TEST: IPv6 fibmatch on up device                                    [ OK ]
#     TEST: IPv4 flags on down device                                     [ OK ]
#     TEST: IPv6 flags on down device                                     [ OK ]
#     TEST: IPv4 flags on up device                                       [ OK ]
#     TEST: IPv6 flags on up device                                       [ OK ]
#     Other device down and up
#     TEST: IPv4 fibmatch on down device                                  [ OK ]
#     TEST: IPv6 fibmatch on down device                                  [ OK ]
#     TEST: IPv4 fibmatch on up device                                    [ OK ]
#     TEST: IPv6 fibmatch on up device                                    [ OK ]
#     TEST: IPv4 flags on down device                                     [ OK ]
#     TEST: IPv6 flags on down device                                     [ OK ]
#     TEST: IPv4 flags on up device                                       [ OK ]
#     TEST: IPv6 flags on up device                                       [ OK ]
#     Both devices down
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
# 
# Local carrier tests - single path
#     Start point
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
#     TEST: IPv4 - no linkdown flag                                       [ OK ]
#     TEST: IPv6 - no linkdown flag                                       [ OK ]
#     Carrier off on nexthop
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
#     TEST: IPv4 - linkdown flag set                                      [ OK ]
#     TEST: IPv6 - linkdown flag set                                      [ OK ]
#     Route to local address with carrier down
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
#     TEST: IPv4 linkdown flag set                                        [ OK ]
#     TEST: IPv6 linkdown flag set                                        [ OK ]
# 
# Single path route carrier test
#     Start point
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
#     TEST: IPv4 no linkdown flag                                         [ OK ]
#     TEST: IPv6 no linkdown flag                                         [ OK ]
#     Carrier down
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
#     TEST: IPv4 linkdown flag set                                        [ OK ]
#     TEST: IPv6 linkdown flag set                                        [ OK ]
#     Second address added with carrier down
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
#     TEST: IPv4 linkdown flag set                                        [ OK ]
#     TEST: IPv6 linkdown flag set                                        [ OK ]
# 
# IPv4 nexthop tests
# <<< write me >>>
# 
# IPv6 nexthop tests
#     TEST: Directly connected nexthop, unicast address                   [ OK ]
#     TEST: Directly connected nexthop, unicast address with device       [ OK ]
#     TEST: Gateway is linklocal address                                  [ OK ]
#     TEST: Gateway is linklocal address, no device                       [ OK ]
#     TEST: Gateway can not be local unicast address                      [ OK ]
#     TEST: Gateway can not be local unicast address, with device         [ OK ]
#     TEST: Gateway can not be a local linklocal address                  [ OK ]
#     TEST: Gateway can be local address in a VRF                         [ OK ]
#     TEST: Gateway can be local address in a VRF, with device            [ OK ]
#     TEST: Gateway can be local linklocal address in a VRF               [ OK ]
#     TEST: Redirect to VRF lookup                                        [ OK ]
#     TEST: VRF route, gateway can be local address in default VRF        [ OK ]
#     TEST: VRF route, gateway can not be a local address                 [ OK ]
#     TEST: VRF route, gateway can not be a local addr with device        [ OK ]
# 
# FIB rule with suppress_prefixlength
#     TEST: FIB rule suppress test                                        [ OK ]
# 
# IPv6 route add / append tests
#     TEST: Attempt to add duplicate route - gw                           [ OK ]
#     TEST: Attempt to add duplicate route - dev only                     [ OK ]
#     TEST: Attempt to add duplicate route - reject route                 [ OK ]
#     TEST: Append nexthop to existing route - gw                         [ OK ]
#     TEST: Add multipath route                                           [ OK ]
#     TEST: Attempt to add duplicate multipath route                      [ OK ]
#     TEST: Route add with different metrics                              [ OK ]
#     TEST: Route delete with metric                                      [ OK ]
# 
# IPv6 route replace tests
#     TEST: Single path with single path                                  [ OK ]
#     TEST: Single path with multipath                                    [ OK ]
#     TEST: Single path with single path via multipath attribute          [ OK ]
#     TEST: Invalid nexthop                                               [ OK ]
#     TEST: Single path - replace of non-existent route                   [ OK ]
#     TEST: Multipath with multipath                                      [ OK ]
#     TEST: Multipath with single path                                    [ OK ]
#     TEST: Multipath with single path via multipath attribute            [ OK ]
#     TEST: Multipath with dev-only                                       [ OK ]
#     TEST: Multipath - invalid first nexthop                             [ OK ]
#     TEST: Multipath - invalid second nexthop                            [ OK ]
#     TEST: Multipath - replace of non-existent route                     [ OK ]
# 
# IPv4 route add / append tests
#     TEST: Attempt to add duplicate route - gw                           [ OK ]
#     TEST: Attempt to add duplicate route - dev only                     [ OK ]
#     TEST: Attempt to add duplicate route - reject route                 [ OK ]
#     TEST: Add new nexthop for existing prefix                           [ OK ]
#     TEST: Append nexthop to existing route - gw                         [ OK ]
#     TEST: Append nexthop to existing route - dev only                   [ OK ]
#     TEST: Append nexthop to existing route - reject route               [ OK ]
#     TEST: Append nexthop to existing reject route - gw                  [ OK ]
#     TEST: Append nexthop to existing reject route - dev only            [ OK ]
#     TEST: add multipath route                                           [ OK ]
#     TEST: Attempt to add duplicate multipath route                      [ OK ]
#     TEST: Route add with different metrics                              [ OK ]
#     TEST: Route delete with metric                                      [ OK ]
# 
# IPv4 route replace tests
#     TEST: Single path with single path                                  [ OK ]
#     TEST: Single path with multipath                                    [ OK ]
#     TEST: Single path with reject route                                 [ OK ]
#     TEST: Single path with single path via multipath attribute          [ OK ]
#     TEST: Invalid nexthop                                               [ OK ]
#     TEST: Single path - replace of non-existent route                   [ OK ]
#     TEST: Multipath with multipath                                      [ OK ]
#     TEST: Multipath with single path                                    [ OK ]
#     TEST: Multipath with single path via multipath attribute            [ OK ]
#     TEST: Multipath with reject route                                   [ OK ]
#     TEST: Multipath - invalid first nexthop                             [ OK ]
#     TEST: Multipath - invalid second nexthop                            [ OK ]
#     TEST: Multipath - replace of non-existent route                     [ OK ]
# 
# IPv6 prefix route tests
#     TEST: Default metric                                                [ OK ]
#     TEST: User specified metric on first device                         [ OK ]
#     TEST: User specified metric on second device                        [ OK ]
#     TEST: Delete of address on first device                             [ OK ]
#     TEST: Modify metric of address                                      [ OK ]
#     TEST: Prefix route removed on link down                             [ OK ]
#     TEST: Prefix route with metric on link up                           [ OK ]
#     TEST: Set metric with peer route on local side                      [ OK ]
#     TEST: Set metric with peer route on peer side                       [ OK ]
#     TEST: Modify metric and peer address on local side                  [ OK ]
#     TEST: Modify metric and peer address on peer side                   [ OK ]
# 
# IPv4 prefix route tests
#     TEST: Default metric                                                [ OK ]
#     TEST: User specified metric on first device                         [ OK ]
#     TEST: User specified metric on second device                        [ OK ]
#     TEST: Delete of address on first device                             [ OK ]
#     TEST: Modify metric of address                                      [ OK ]
#     TEST: Prefix route removed on link down                             [ OK ]
#     TEST: Prefix route with metric on link up                           [ OK ]
#     TEST: Modify metric of .0/24 address                                [ OK ]
#     TEST: Set metric of address with peer route                         [ OK ]
#     TEST: Modify metric and peer address for peer route                 [ OK ]
# 
# IPv6 routes with metrics
#     TEST: Single path route with mtu metric                             [ OK ]
#     TEST: Multipath route via 2 single routes with mtu metric on first  [ OK ]
#     TEST: Multipath route via 2 single routes with mtu metric on 2nd    [ OK ]
#     TEST:     MTU of second leg                                         [ OK ]
#     TEST: Multipath route with mtu metric                               [ OK ]
#     TEST: Using route with mtu metric                                   [ OK ]
#     TEST: Invalid metric (fails metric_convert)                         [ OK ]
# 
# IPv4 route add / append tests
#     TEST: Single path route with mtu metric                             [ OK ]
#     TEST: Multipath route with mtu metric                               [ OK ]
#     TEST: Using route with mtu metric                                   [ OK ]
#     TEST: Invalid metric (fails metric_convert)                         [ OK ]
# 
# IPv4 route with IPv6 gateway tests
#     TEST: Single path route with IPv6 gateway                           [ OK ]
#     TEST: Single path route with IPv6 gateway - ping                    [ OK ]
#     TEST: Single path route delete                                      [ OK ]
#     TEST: Multipath route add - v6 nexthop then v4                      [ OK ]
#     TEST:     Multipath route delete - nexthops in wrong order          [ OK ]
#     TEST:     Multipath route delete exact match                        [ OK ]
#     TEST: Multipath route add - v4 nexthop then v6                      [ OK ]
#     TEST:     Multipath route delete - nexthops in wrong order          [ OK ]
#     TEST:     Multipath route delete exact match                        [ OK ]
# 
# IPv4 rp_filter tests
#     TEST: rp_filter passes local packets                                [FAIL]
#     TEST: rp_filter passes loopback packets                             [FAIL]
# 
# IPv4 delete address route tests
#     TEST: Route removed from VRF when source address deleted            [ OK ]
#     TEST: Route in default VRF not removed                              [ OK ]
#     TEST: Route removed in default VRF when source address deleted      [ OK ]
#     TEST: Route in VRF is not removed by address delete                 [ OK ]
# 
# Tests passed: 163
# Tests failed:   2
not ok 13 selftests: net: fib_tests.sh # exit=1
# selftests: net: fib-onlink-tests.sh
# Error: ipv4: FIB table does not exist.
# Flush terminated
# Error: ipv6: FIB table does not exist.
# Flush terminated
# 
# ########################################
# Configuring interfaces
# 
# ######################################################################
# TEST SECTION: IPv4 onlink
# ######################################################################
# 
# #########################################
# TEST SUBSECTION: Valid onlink commands
# 
# #########################################
# TEST SUBSECTION: default VRF - main table
#     TEST: unicast connected                                   [ OK ]
#     TEST: unicast recursive                                   [ OK ]
# 
# #########################################
# TEST SUBSECTION: VRF lisa
#     TEST: unicast connected                                   [ OK ]
#     TEST: unicast recursive                                   [ OK ]
# 
# #########################################
# TEST SUBSECTION: VRF device, PBR table
#     TEST: unicast connected                                   [ OK ]
#     TEST: unicast recursive                                   [ OK ]
# 
# #########################################
# TEST SUBSECTION: default VRF - main table - multipath
#     TEST: unicast connected - multipath                       [ OK ]
#     TEST: unicast recursive - multipath                       [ OK ]
#     TEST: unicast connected - multipath onlink first only     [ OK ]
#     TEST: unicast connected - multipath onlink second only    [ OK ]
# 
# #########################################
# TEST SUBSECTION: Invalid onlink commands
#     TEST: Invalid gw - local unicast address                  [ OK ]
#     TEST: Invalid gw - local unicast address, VRF             [ OK ]
#     TEST: No nexthop device given                             [ OK ]
#     TEST: Gateway resolves to wrong nexthop device            [ OK ]
#     TEST: Gateway resolves to wrong nexthop device - VRF      [ OK ]
# 
# ######################################################################
# TEST SECTION: IPv6 onlink
# ######################################################################
# 
# #########################################
# TEST SUBSECTION: Valid onlink commands
# 
# #########################################
# TEST SUBSECTION: default VRF - main table
#     TEST: unicast connected                                   [ OK ]
#     TEST: unicast recursive                                   [ OK ]
#     TEST: v4-mapped                                           [ OK ]
# 
# #########################################
# TEST SUBSECTION: VRF lisa
#     TEST: unicast connected                                   [ OK ]
#     TEST: unicast recursive                                   [ OK ]
#     TEST: v4-mapped                                           [ OK ]
# 
# #########################################
# TEST SUBSECTION: VRF device, PBR table
#     TEST: unicast connected                                   [ OK ]
#     TEST: unicast recursive                                   [ OK ]
#     TEST: v4-mapped                                           [ OK ]
# 
# #########################################
# TEST SUBSECTION: default VRF - main table - multipath
#     TEST: unicast connected - multipath onlink                [ OK ]
#     TEST: unicast recursive - multipath onlink                [ OK ]
#     TEST: v4-mapped - multipath onlink                        [ OK ]
#     TEST: unicast connected - multipath onlink both nexthops  [ OK ]
#     TEST: unicast connected - multipath onlink first only     [ OK ]
#     TEST: unicast connected - multipath onlink second only    [ OK ]
# 
# #########################################
# TEST SUBSECTION: Invalid onlink commands
#     TEST: Invalid gw - local unicast address                  [ OK ]
#     TEST: Invalid gw - local linklocal address                [ OK ]
#     TEST: Invalid gw - multicast address                      [ OK ]
#     TEST: Invalid gw - local unicast address, VRF             [ OK ]
#     TEST: Invalid gw - local linklocal address, VRF           [ OK ]
#     TEST: Invalid gw - multicast address, VRF                 [ OK ]
#     TEST: No nexthop device given                             [ OK ]
#     TEST: Gateway resolves to wrong nexthop device - VRF      [ OK ]
# 
# Tests passed:  38
# Tests failed:   0
ok 14 selftests: net: fib-onlink-tests.sh
# selftests: net: pmtu.sh
# TEST: ipv4: PMTU exceptions                                         [ OK ]
# TEST: ipv4: PMTU exceptions - nexthop objects                       [ OK ]
# TEST: ipv6: PMTU exceptions                                         [ OK ]
# TEST: ipv6: PMTU exceptions - nexthop objects                       [ OK ]
# TEST: IPv4 over vxlan4: PMTU exceptions                             [ OK ]
# TEST: IPv4 over vxlan4: PMTU exceptions - nexthop objects           [ OK ]
# TEST: IPv6 over vxlan4: PMTU exceptions                             [ OK ]
# TEST: IPv6 over vxlan4: PMTU exceptions - nexthop objects           [ OK ]
# TEST: IPv4 over vxlan6: PMTU exceptions                             [ OK ]
# TEST: IPv4 over vxlan6: PMTU exceptions - nexthop objects           [ OK ]
# TEST: IPv6 over vxlan6: PMTU exceptions                             [ OK ]
# TEST: IPv6 over vxlan6: PMTU exceptions - nexthop objects           [ OK ]
# TEST: IPv4 over geneve4: PMTU exceptions                            [ OK ]
# TEST: IPv4 over geneve4: PMTU exceptions - nexthop objects          [ OK ]
# TEST: IPv6 over geneve4: PMTU exceptions                            [ OK ]
# TEST: IPv6 over geneve4: PMTU exceptions - nexthop objects          [ OK ]
# TEST: IPv4 over geneve6: PMTU exceptions                            [FAIL]
#   PMTU exception wasn't created after exceeding link layer MTU on geneve interface
# TEST: IPv4 over geneve6: PMTU exceptions - nexthop objects          [FAIL]
#   PMTU exception wasn't created after exceeding link layer MTU on geneve interface
# TEST: IPv6 over geneve6: PMTU exceptions                            [ OK ]
# TEST: IPv6 over geneve6: PMTU exceptions - nexthop objects          [ OK ]
# TEST: IPv4, bridged vxlan4: PMTU exceptions                         [ OK ]
# TEST: IPv4, bridged vxlan4: PMTU exceptions - nexthop objects       [ OK ]
# TEST: IPv6, bridged vxlan4: PMTU exceptions                         [ OK ]
# TEST: IPv6, bridged vxlan4: PMTU exceptions - nexthop objects       [ OK ]
# TEST: IPv4, bridged vxlan6: PMTU exceptions                         [ OK ]
# TEST: IPv4, bridged vxlan6: PMTU exceptions - nexthop objects       [ OK ]
# TEST: IPv6, bridged vxlan6: PMTU exceptions                         [ OK ]
# TEST: IPv6, bridged vxlan6: PMTU exceptions - nexthop objects       [ OK ]
#
not ok 15 selftests: net: pmtu.sh # TIMEOUT 45 seconds
# selftests: net: udpgso.sh
# ipv4 cmsg
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv4 tx:1 gso:0 
# ipv4 tx:1472 gso:0 
# ipv4 tx:1473 gso:0 (fail)
# ipv4 tx:1472 gso:1472 
# ipv4 tx:1473 gso:1472 
# ipv4 tx:2944 gso:1472 
# ipv4 tx:2945 gso:1472 
# ipv4 tx:64768 gso:1472 
# ipv4 tx:65507 gso:1472 
# ipv4 tx:65508 gso:1472 (fail)
# ipv4 tx:1 gso:1 
# ipv4 tx:2 gso:1 
# ipv4 tx:5 gso:2 
# ipv4 tx:36 gso:1 
# ipv4 tx:37 gso:1 (fail)
# OK
# ipv4 setsockopt
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv4 tx:1 gso:0 
# ipv4 tx:1472 gso:0 
# ipv4 tx:1473 gso:0 (fail)
# ipv4 tx:1472 gso:1472 
# ipv4 tx:1473 gso:1472 
# ipv4 tx:2944 gso:1472 
# ipv4 tx:2945 gso:1472 
# ipv4 tx:64768 gso:1472 
# ipv4 tx:65507 gso:1472 
# ipv4 tx:65508 gso:1472 (fail)
# ipv4 tx:1 gso:1 
# ipv4 tx:2 gso:1 
# ipv4 tx:5 gso:2 
# ipv4 tx:36 gso:1 
# ipv4 tx:37 gso:1 (fail)
# OK
# ipv6 cmsg
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv6 tx:1 gso:0 
# ipv6 tx:1452 gso:0 
# ipv6 tx:1453 gso:0 (fail)
# ipv6 tx:1452 gso:1452 
# ipv6 tx:1453 gso:1452 
# ipv6 tx:2904 gso:1452 
# ipv6 tx:2905 gso:1452 
# ipv6 tx:65340 gso:1452 
# ipv6 tx:65527 gso:1452 
# ipv6 tx:65528 gso:1452 (fail)
# ipv6 tx:1 gso:1 
# ipv6 tx:2 gso:1 
# ipv6 tx:5 gso:2 
# ipv6 tx:16 gso:1 
# ipv6 tx:17 gso:1 (fail)
# OK
# ipv6 setsockopt
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv6 tx:1 gso:0 
# ipv6 tx:1452 gso:0 
# ipv6 tx:1453 gso:0 (fail)
# ipv6 tx:1452 gso:1452 
# ipv6 tx:1453 gso:1452 
# ipv6 tx:2904 gso:1452 
# ipv6 tx:2905 gso:1452 
# ipv6 tx:65340 gso:1452 
# ipv6 tx:65527 gso:1452 
# ipv6 tx:65528 gso:1452 (fail)
# ipv6 tx:1 gso:1 
# ipv6 tx:2 gso:1 
# ipv6 tx:5 gso:2 
# ipv6 tx:16 gso:1 
# ipv6 tx:17 gso:1 (fail)
# OK
# ipv4 connected
# device mtu (orig): 65536
# device mtu (test): 1600
# route mtu (test): 1500
# path mtu (read):  1500
# ipv4 tx:1 gso:0 
# ipv4 tx:1472 gso:0 
# ipv4 tx:1473 gso:0 (fail)
# ipv4 tx:1472 gso:1472 
# ipv4 tx:1473 gso:1472 
# ipv4 tx:2944 gso:1472 
# ipv4 tx:2945 gso:1472 
# ipv4 tx:64768 gso:1472 
# ipv4 tx:65507 gso:1472 
# ipv4 tx:65508 gso:1472 (fail)
# ipv4 tx:1 gso:1 
# ipv4 tx:2 gso:1 
# ipv4 tx:5 gso:2 
# ipv4 tx:36 gso:1 
# ipv4 tx:37 gso:1 (fail)
# OK
# ipv4 msg_more
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv4 tx:1 gso:0 
# ipv4 tx:1472 gso:0 
# ipv4 tx:1473 gso:0 (fail)
# ipv4 tx:1472 gso:1472 
# ipv4 tx:1473 gso:1472 
# ipv4 tx:2944 gso:1472 
# ipv4 tx:2945 gso:1472 
# ipv4 tx:64768 gso:1472 
# ipv4 tx:65507 gso:1472 
# ipv4 tx:65508 gso:1472 (fail)
# ipv4 tx:1 gso:1 
# ipv4 tx:2 gso:1 
# ipv4 tx:5 gso:2 
# ipv4 tx:36 gso:1 
# ipv4 tx:37 gso:1 (fail)
# OK
# ipv6 msg_more
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv6 tx:1 gso:0 
# ipv6 tx:1452 gso:0 
# ipv6 tx:1453 gso:0 (fail)
# ipv6 tx:1452 gso:1452 
# ipv6 tx:1453 gso:1452 
# ipv6 tx:2904 gso:1452 
# ipv6 tx:2905 gso:1452 
# ipv6 tx:65340 gso:1452 
# ipv6 tx:65527 gso:1452 
# ipv6 tx:65528 gso:1452 (fail)
# ipv6 tx:1 gso:1 
# ipv6 tx:2 gso:1 
# ipv6 tx:5 gso:2 
# ipv6 tx:16 gso:1 
# ipv6 tx:17 gso:1 (fail)
# OK
ok 16 selftests: net: udpgso.sh
# selftests: net: ip_defrag.sh
# ipv4 defrag
# PASS
# seed = 1618856025
# ipv4 defrag with overlaps
# PASS
# seed = 1618856025
# ipv6 defrag
# PASS
# seed = 1618856029
# ipv6 defrag with overlaps
# PASS
# seed = 1618856029
# ipv6 nf_conntrack defrag
# PASS
# seed = 1618856034
# ipv6 nf_conntrack defrag with overlaps
# PASS
# seed = 1618856034
# all tests done
ok 17 selftests: net: ip_defrag.sh
# selftests: net: udpgso_bench.sh
# ipv4
# tcp
# tcp tx:   3312 MB/s    56177 calls/s  56177 msg/s
# tcp rx:   3314 MB/s    56188 calls/s
# tcp tx:   3272 MB/s    55503 calls/s  55503 msg/s
# tcp rx:   3275 MB/s    55546 calls/s
# tcp tx:   3258 MB/s    55268 calls/s  55268 msg/s
# tcp zerocopy
# tcp tx:   2381 MB/s    40387 calls/s  40387 msg/s
# tcp rx:   2382 MB/s    39941 calls/s
# tcp tx:   2381 MB/s    40396 calls/s  40396 msg/s
# tcp rx:   2384 MB/s    40313 calls/s
# tcp tx:   2394 MB/s    40609 calls/s  40609 msg/s
# udp
# udp rx:    161 MB/s   114903 calls/s
# udp tx:    161 MB/s   114912 calls/s   2736 msg/s
# udp tx:    162 MB/s   115752 calls/s   2756 msg/s
# udp rx:    162 MB/s   115867 calls/s
# udp tx:    162 MB/s   115920 calls/s   2760 msg/s
# udp gso
# udp rx:    908 MB/s   646910 calls/s
# udp tx:    910 MB/s    15444 calls/s  15444 msg/s
# udp rx:    912 MB/s   649930 calls/s
# udp tx:    911 MB/s    15461 calls/s  15461 msg/s
# udp rx:    910 MB/s   648850 calls/s
# udp tx:    909 MB/s    15434 calls/s  15434 msg/s
# udp gso zerocopy
# udp rx:    857 MB/s   611018 calls/s
# udp tx:    859 MB/s    14577 calls/s  14577 msg/s
# udp rx:    867 MB/s   618312 calls/s
# udp tx:    866 MB/s    14703 calls/s  14703 msg/s
# udp tx:    874 MB/s    14831 calls/s  14831 msg/s
# udp rx:    875 MB/s   623332 calls/s
# udp gso timestamp
# udp rx:    833 MB/s   593744 calls/s
# udp tx:    835 MB/s    14179 calls/s  14179 msg/s
# udp rx:    848 MB/s   604086 calls/s
# udp tx:    847 MB/s    14369 calls/s  14369 msg/s
# udp rx:    850 MB/s   605724 calls/s
# udp tx:    849 MB/s    14408 calls/s  14408 msg/s
# udp gso zerocopy audit
# udp rx:    859 MB/s   612362 calls/s
# udp tx:    862 MB/s    14622 calls/s  14622 msg/s
# udp rx:    870 MB/s   620390 calls/s
# udp tx:    870 MB/s    14759 calls/s  14759 msg/s
# udp rx:    870 MB/s   620208 calls/s
# udp tx:    869 MB/s    14751 calls/s  14751 msg/s
# Summary over 3.000 seconds...
# sum udp tx:    888 MB/s      44132 calls (14710/s)      44132 msgs (14710/s)
# Zerocopy acks:               44132
# udp gso timestamp audit
# udp rx:    834 MB/s   594663 calls/s
# udp tx:    837 MB/s    14201 calls/s  14201 msg/s
# udp rx:    844 MB/s   601373 calls/s
# udp tx:    843 MB/s    14305 calls/s  14305 msg/s
# udp rx:    845 MB/s   602148 calls/s
# udp tx:    844 MB/s    14323 calls/s  14323 msg/s
# Summary over 3.000 seconds...
# sum udp tx:    861 MB/s      42829 calls (14276/s)      42829 msgs (14276/s)
# Tx Timestamps:               42829 received                 0 errors
# udp gso zerocopy timestamp audit
# udp rx:    739 MB/s   526987 calls/s
# udp tx:    742 MB/s    12589 calls/s  12589 msg/s
# udp rx:    748 MB/s   533484 calls/s
# udp tx:    748 MB/s    12690 calls/s  12690 msg/s
# udp rx:    749 MB/s   534030 calls/s
# udp tx:    748 MB/s    12702 calls/s  12702 msg/s
# Summary over 3.000 seconds...
# sum udp tx:    764 MB/s      37981 calls (12660/s)      37981 msgs (12660/s)
# Tx Timestamps:               37981 received                 0 errors
# Zerocopy acks:               37981
# ipv6
# tcp
# tcp tx:   3210 MB/s    54445 calls/s  54445 msg/s
# tcp rx:   3212 MB/s    54443 calls/s
# tcp tx:   3274 MB/s    55541 calls/s  55541 msg/s
# tcp rx:   3279 MB/s    55592 calls/s
# tcp tx:   3265 MB/s    55385 calls/s  55385 msg/s
# tcp zerocopy
# tcp tx:   2376 MB/s    40299 calls/s  40299 msg/s
# tcp rx:   2377 MB/s    40284 calls/s
# tcp tx:   2407 MB/s    40841 calls/s  40841 msg/s
# tcp rx:   2410 MB/s    40861 calls/s
# tcp tx:   2403 MB/s    40766 calls/s  40766 msg/s
# udp
# udp rx:    133 MB/s    97368 calls/s
# udp tx:    133 MB/s    97481 calls/s   2267 msg/s
# udp rx:    138 MB/s   100831 calls/s
# udp tx:    138 MB/s   100749 calls/s   2343 msg/s
# udp tx:    138 MB/s   100964 calls/s   2348 msg/s
# udp gso
# udp rx:    895 MB/s   652800 calls/s
# udp tx:    897 MB/s    15222 calls/s  15222 msg/s
# udp rx:    901 MB/s   657664 calls/s
# udp tx:    901 MB/s    15283 calls/s  15283 msg/s
# udp rx:    905 MB/s   660736 calls/s
# udp tx:    904 MB/s    15348 calls/s  15348 msg/s
# udp gso zerocopy
# udp rx:    849 MB/s   619264 calls/s
# udp tx:    851 MB/s    14442 calls/s  14442 msg/s
# udp rx:    857 MB/s   625664 calls/s
# udp tx:    857 MB/s    14539 calls/s  14539 msg/s
# udp rx:    859 MB/s   626641 calls/s
# udp tx:    858 MB/s    14556 calls/s  14556 msg/s
# udp gso timestamp
# udp rx:    836 MB/s   609998 calls/s
# udp tx:    838 MB/s    14229 calls/s  14229 msg/s
# udp rx:    848 MB/s   618555 calls/s
# udp tx:    847 MB/s    14369 calls/s  14369 msg/s
# udp rx:    848 MB/s   618598 calls/s
# udp tx:    847 MB/s    14372 calls/s  14372 msg/s
#
not ok 18 selftests: net: udpgso_bench.sh # TIMEOUT 45 seconds
# selftests: net: fib_rule_tests.sh
# 
# ######################################################################
# TEST SECTION: IPv4 fib rule
# ######################################################################
# 
#     TEST: rule4 check: oif dummy0                             [ OK ]
# 
#     TEST: rule4 del by pref: oif dummy0                       [ OK ]
# net.ipv4.ip_forward = 1
# net.ipv4.conf.dummy0.rp_filter = 0
# 
#     TEST: rule4 check: from 192.51.100.3 iif dummy0           [ OK ]
# 
#     TEST: rule4 del by pref: from 192.51.100.3 iif dummy0     [ OK ]
# net.ipv4.ip_forward = 0
# 
#     TEST: rule4 check: tos 0x10                               [ OK ]
# 
#     TEST: rule4 del by pref: tos 0x10                         [ OK ]
# 
#     TEST: rule4 check: fwmark 0x64                            [ OK ]
# 
#     TEST: rule4 del by pref: fwmark 0x64                      [ OK ]
# 
#     TEST: rule4 check: uidrange 100-100                       [ OK ]
# 
#     TEST: rule4 del by pref: uidrange 100-100                 [ OK ]
# 
#     TEST: rule4 check: sport 666 dport 777                    [ OK ]
# 
#     TEST: rule4 del by pref: sport 666 dport 777              [ OK ]
# 
#     TEST: rule4 check: ipproto tcp                            [ OK ]
# 
#     TEST: rule4 del by pref: ipproto tcp                      [ OK ]
# 
#     TEST: rule4 check: ipproto icmp                           [ OK ]
# 
#     TEST: rule4 del by pref: ipproto icmp                     [ OK ]
# 
# ######################################################################
# TEST SECTION: IPv6 fib rule
# ######################################################################
# 
#     TEST: rule6 check: oif dummy0                             [ OK ]
# 
#     TEST: rule6 del by pref: oif dummy0                       [ OK ]
# 
#     TEST: rule6 check: from 2001:db8:1::3 iif dummy0          [ OK ]
# 
#     TEST: rule6 del by pref: from 2001:db8:1::3 iif dummy0    [ OK ]
# 
#     TEST: rule6 check: tos 0x10                               [ OK ]
# 
#     TEST: rule6 del by pref: tos 0x10                         [ OK ]
# 
#     TEST: rule6 check: fwmark 0x64                            [ OK ]
# 
#     TEST: rule6 del by pref: fwmark 0x64                      [ OK ]
# 
#     TEST: rule6 check: uidrange 100-100                       [ OK ]
# 
#     TEST: rule6 del by pref: uidrange 100-100                 [ OK ]
# 
#     TEST: rule6 check: sport 666 dport 777                    [ OK ]
# 
#     TEST: rule6 del by pref: sport 666 dport 777              [ OK ]
# 
#     TEST: rule6 check: ipproto tcp                            [ OK ]
# 
#     TEST: rule6 del by pref: ipproto tcp                      [ OK ]
# 
#     TEST: rule6 check: ipproto ipv6-icmp                      [ OK ]
# 
#     TEST: rule6 del by pref: ipproto ipv6-icmp                [ OK ]
# 
# Tests passed:  32
# Tests failed:   0
ok 19 selftests: net: fib_rule_tests.sh
# selftests: net: msg_zerocopy.sh
# ipv4 tcp -t 1
# tx=63418 (3957 MB) txc=0 zc=n
# rx=31710 (3957 MB)
# ipv4 tcp -z -t 1
# tx=49828 (3109 MB) txc=49828 zc=n
# rx=24915 (3109 MB)
# ok
# ipv6 tcp -t 1
# tx=52634 (3284 MB) txc=0 zc=n
# rx=26318 (3284 MB)
# ipv6 tcp -z -t 1
# tx=42575 (2656 MB) txc=42575 zc=n
# rx=21289 (2656 MB)
# ok
# ipv4 udp -t 1
# tx=70296 (4386 MB) txc=0 zc=n
# rx=70293 (4386 MB)
# ipv4 udp -z -t 1
# tx=51885 (3237 MB) txc=51885 zc=n
# rx=51849 (3235 MB)
# ok
# ipv6 udp -t 1
# tx=68014 (4244 MB) txc=0 zc=n
# rx=68011 (4244 MB)
# ipv6 udp -z -t 1
# tx=51422 (3208 MB) txc=51422 zc=n
# rx=51422 (3208 MB)
# ok
# OK. All tests passed
ok 20 selftests: net: msg_zerocopy.sh
# selftests: net: psock_snd.sh
# dgram
# tx: 128
# rx: 142
# rx: 100
# OK
# 
# dgram bind
# tx: 128
# rx: 142
# rx: 100
# OK
# 
# raw
# tx: 142
# rx: 142
# rx: 100
# OK
# 
# raw bind
# tx: 142
# rx: 142
# rx: 100
# OK
# 
# raw qdisc bypass
# tx: 142
# rx: 142
# rx: 100
# OK
# 
# raw vlan
# tx: 146
# rx: 100
# OK
# 
# raw vnet hdr
# tx: 152
# rx: 142
# rx: 100
# OK
# 
# raw csum_off
# tx: 152
# rx: 142
# rx: 100
# OK
# 
# raw csum_off with bad offset (expected to fail)
# ./psock_snd: write: Invalid argument
# raw min size
# tx: 42
# rx: 0
# OK
# 
# raw mtu size
# tx: 1514
# rx: 1472
# OK
# 
# raw mtu size + 1 (expected to fail)
# ./psock_snd: write: Message too long
# raw vlan mtu size + 1 (expected to fail)
# ./psock_snd: write: Message too long
# dgram mtu size
# tx: 1500
# rx: 1472
# OK
# 
# dgram mtu size + 1 (expected to fail)
# ./psock_snd: write: Message too long
# raw truncate hlen (expected to fail: does not arrive)
# tx: 14
# ./psock_snd: recv: Resource temporarily unavailable
# raw truncate hlen - 1 (expected to fail: EINVAL)
# ./psock_snd: write: Invalid argument
# raw gso min size
# tx: 1525
# rx: 1473
# OK
# 
# raw gso min size - 1 (expected to fail)
# tx: 1524
# rx: 1472
# OK
# 
not ok 21 selftests: net: psock_snd.sh # exit=1
# selftests: net: udpgro_bench.sh
# ipv4
# tcp - over veth touching data
# Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# tcp tx:    312 MB/s     5303 calls/s   5303 msg/s
# tcp rx:    313 MB/s     8226 calls/s
# tcp tx:    419 MB/s     7122 calls/s   7122 msg/s
# tcp rx:    420 MB/s    12619 calls/s
# tcp tx:    330 MB/s     5613 calls/s   5613 msg/s
# tcp rx:    331 MB/s    10536 calls/s
# tcp tx:    412 MB/s     7004 calls/s   7004 msg/s
# udp gso - over veth touching data
# Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# udp rx:    185 MB/s   131787 calls/s
# udp tx:    224 MB/s     3816 calls/s   3816 msg/s
# udp rx:    223 MB/s   159444 calls/s
# udp tx:    223 MB/s     3792 calls/s   3792 msg/s
# udp rx:    222 MB/s   158432 calls/s
# udp tx:    222 MB/s     3772 calls/s   3772 msg/s
# udp rx:    225 MB/s   160692 calls/s
# udp tx:    225 MB/s     3823 calls/s   3823 msg/s
# udp gso and gro - over veth touching data
# Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# udp rx:    337 MB/s     5696 calls/s
# udp tx:    398 MB/s     6766 calls/s   6766 msg/s
# udp rx:    393 MB/s     6633 calls/s
# udp tx:    395 MB/s     6705 calls/s   6705 msg/s
# udp rx:    492 MB/s     8062 calls/s
# udp tx:    482 MB/s     8189 calls/s   8189 msg/s
# udp rx:    370 MB/s     6277 calls/s
# udp tx:    368 MB/s     6244 calls/s   6244 msg/s
# ipv6
# tcp - over veth touching data
# Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# tcp tx:    341 MB/s     5791 calls/s   5791 msg/s
# tcp rx:    341 MB/s     4019 calls/s
# tcp tx:    416 MB/s     7057 calls/s   7057 msg/s
# tcp rx:    417 MB/s    13385 calls/s
# tcp tx:    346 MB/s     5876 calls/s   5876 msg/s
# tcp rx:    385 MB/s     4648 calls/s
# tcp tx:    417 MB/s     7084 calls/s   7084 msg/s
# udp gso - over veth touching data
# Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# udp rx:    205 MB/s   149604 calls/s
# udp tx:    251 MB/s     4268 calls/s   4268 msg/s
# udp rx:    248 MB/s   181300 calls/s
# udp tx:    245 MB/s     4164 calls/s   4164 msg/s
# udp rx:    230 MB/s   168028 calls/s
# udp tx:    230 MB/s     3903 calls/s   3903 msg/s
# udp rx:    230 MB/s   167755 calls/s
# udp tx:    229 MB/s     3899 calls/s   3899 msg/s
# udp gso and gro - over veth touching data
# Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# udp rx:    321 MB/s     5459 calls/s
# udp tx:    374 MB/s     6356 calls/s   6356 msg/s
# udp rx:    361 MB/s     6131 calls/s
# udp tx:    359 MB/s     6105 calls/s   6105 msg/s
# udp rx:    356 MB/s     6052 calls/s
# udp tx:    356 MB/s     6048 calls/s   6048 msg/s
# udp rx:    358 MB/s     6088 calls/s
# udp tx:    358 MB/s     6081 calls/s   6081 msg/s
ok 22 selftests: net: udpgro_bench.sh
# selftests: net: udpgro.sh
# ipv4
#  no GRO                                  Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
#  no GRO chk cmsg                         Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
#  GRO                                     Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
#  GRO chk cmsg                            Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
#  GRO with custom segment size            Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
#  GRO with custom segment size cmsg       Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
#  bad GRO lookup                          Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
#  multiple GRO socks                      Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
# ipv6
#  no GRO                                  Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
#  no GRO chk cmsg                         Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
#  GRO                                     Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
#  GRO chk cmsg                            Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
#  GRO with custom segment size            Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
#  GRO with custom segment size cmsg       Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
#  bad GRO lookup                          Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
#  multiple GRO socks                      Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
ok 23 selftests: net: udpgro.sh
# selftests: net: test_vxlan_under_vrf.sh
# Checking HV connectivity                                           [ OK ]
# Check VM connectivity through VXLAN (underlay in the default VRF)  [ OK ]
# Check VM connectivity through VXLAN (underlay in a VRF)            [FAIL]
not ok 24 selftests: net: test_vxlan_under_vrf.sh # exit=1
# selftests: net: reuseport_addr_any.sh
# UDP IPv4 ... pass
# UDP IPv6 ... pass
# UDP IPv4 mapped to IPv6 ... pass
# TCP IPv4 ... pass
# TCP IPv6 ... pass
# TCP IPv4 mapped to IPv6 ... pass
# DCCP not supported: skipping DCCP tests
# SUCCESS
ok 25 selftests: net: reuseport_addr_any.sh
# selftests: net: test_vxlan_fdb_changelink.sh
# expected two remotes after fdb append	[ OK ]
# expected two remotes after link set	[ OK ]
ok 26 selftests: net: test_vxlan_fdb_changelink.sh
# selftests: net: so_txtime.sh
# 
# SO_TXTIME ipv6 clock monotonic
# payload:a delay:81 expected:0 (us)
# 
# SO_TXTIME ipv4 clock monotonic
# payload:a delay:54 expected:0 (us)
# 
# SO_TXTIME ipv6 clock monotonic
# payload:a delay:47 expected:0 (us)
# 
# SO_TXTIME ipv4 clock monotonic
# payload:a delay:62 expected:0 (us)
# 
# SO_TXTIME ipv6 clock monotonic
# payload:a delay:10065 expected:10000 (us)
# 
# SO_TXTIME ipv4 clock monotonic
# payload:a delay:10104 expected:10000 (us)
# 
# SO_TXTIME ipv6 clock monotonic
# payload:a delay:10069 expected:10000 (us)
# payload:b delay:20036 expected:20000 (us)
# 
# SO_TXTIME ipv4 clock monotonic
# payload:a delay:10100 expected:10000 (us)
# payload:b delay:20150 expected:20000 (us)
# 
# SO_TXTIME ipv6 clock monotonic
# payload:b delay:20350 expected:20000 (us)
# payload:a delay:20384 expected:20000 (us)
# 
# SO_TXTIME ipv4 clock monotonic
# payload:b delay:20351 expected:20000 (us)
# payload:a delay:20385 expected:20000 (us)
# 
# SO_TXTIME ipv6 clock tai
# send: pkt a at -1618856139102ms dropped: invalid txtime
# ./so_txtime: recv: timeout
# 
# SO_TXTIME ipv6 clock tai
# send: pkt a at 0ms dropped: invalid txtime
# ./so_txtime: recv: timeout
# 
# SO_TXTIME ipv6 clock tai
# payload:a delay:9663 expected:10000 (us)
# 
# SO_TXTIME ipv4 clock tai
# payload:a delay:9720 expected:10000 (us)
# 
# SO_TXTIME ipv6 clock tai
# payload:a delay:9806 expected:10000 (us)
# payload:b delay:19756 expected:20000 (us)
# 
# SO_TXTIME ipv4 clock tai
# payload:a delay:9640 expected:10000 (us)
# payload:b delay:19644 expected:20000 (us)
# 
# SO_TXTIME ipv6 clock tai
# payload:b delay:9664 expected:10000 (us)
# payload:a delay:19743 expected:20000 (us)
# 
# SO_TXTIME ipv4 clock tai
# payload:b delay:9655 expected:10000 (us)
# payload:a delay:19688 expected:20000 (us)
# OK. All tests passed
ok 27 selftests: net: so_txtime.sh
# selftests: net: ipv6_flowlabel.sh
# TEST management
# [OK]   !(flowlabel_get(fd, 1, 255, 0))
# [OK]   !(flowlabel_put(fd, 1))
# [OK]   !(flowlabel_get(fd, 0x1FFFFF, 255, 1))
# [OK]   flowlabel_get(fd, 1, 255, 1)
# [OK]   flowlabel_get(fd, 1, 255, 0)
# [OK]   flowlabel_get(fd, 1, 255, 1)
# [OK]   !(flowlabel_get(fd, 1, 255, 1 | 2))
# [OK]   flowlabel_put(fd, 1)
# [OK]   flowlabel_put(fd, 1)
# [OK]   flowlabel_put(fd, 1)
# [OK]   !(flowlabel_put(fd, 1))
# [OK]   flowlabel_get(fd, 2, 1, 1)
# [OK]   !(flowlabel_get(fd, 2, 255, 1))
# [OK]   !(flowlabel_get(fd, 2, 1, 1))
# [OK]   flowlabel_put(fd, 2)
# [OK]   flowlabel_get(fd, 3, 3, 1)
# [OK]   !(flowlabel_get(fd, 3, 255, 0))
# [OK]   !(flowlabel_get(fd, 3, 1, 0))
# [OK]   flowlabel_get(fd, 3, 3, 0)
# [OK]   flowlabel_get(fd, 3, 3, 0)
# [OK]   !(flowlabel_get(fd, 3, 3, 0))
# [OK]   flowlabel_get(fd, 4, 2, 1)
# [OK]   flowlabel_get(fd, 4, 2, 0)
# [OK]   !(flowlabel_get(fd, 4, 2, 0))
# TEST datapath
# send no label: recv no label (auto off)
# sent without label
# recv without label
# send label
# sent with label 1
# recv with label 1
# TEST datapath (with auto-flowlabels)
# send no label: recv auto flowlabel
# sent without label
# recv with label 177325
# send label
# sent with label 1
# recv with label 1
# OK. All tests passed
ok 28 selftests: net: ipv6_flowlabel.sh
# selftests: net: tcp_fastopen_backup_key.sh
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# all tests done
ok 29 selftests: net: tcp_fastopen_backup_key.sh
# selftests: net: fcnal-test.sh
# 'nettest' command not found; skipping tests
ok 30 selftests: net: fcnal-test.sh
# selftests: net: traceroute.sh
# SKIP: Could not run IPV6 test without traceroute6
# SKIP: Could not run IPV4 test without traceroute
# 
# Tests passed:   0
# Tests failed:   0
ok 31 selftests: net: traceroute.sh
# selftests: net: fin_ack_lat.sh
# server port: 59901
# test done
ok 32 selftests: net: fin_ack_lat.sh
# selftests: net: fib_nexthop_multiprefix.sh
# TEST: IPv4: host 0 to host 1, mtu 1300                              [ OK ]
# TEST: IPv6: host 0 to host 1, mtu 1300                              [FAIL]
# 
# TEST: IPv4: host 0 to host 2, mtu 1350                              [ OK ]
# TEST: IPv6: host 0 to host 2, mtu 1350                              [FAIL]
# 
# TEST: IPv4: host 0 to host 3, mtu 1400                              [ OK ]
# TEST: IPv6: host 0 to host 3, mtu 1400                              [FAIL]
# 
# TEST: IPv4: host 0 to host 1, mtu 1300                              [ OK ]
# TEST: IPv6: host 0 to host 1, mtu 1300                              [FAIL]
# 
# TEST: IPv4: host 0 to host 2, mtu 1350                              [ OK ]
# TEST: IPv6: host 0 to host 2, mtu 1350                              [FAIL]
# 
# TEST: IPv4: host 0 to host 3, mtu 1400                              [ OK ]
# TEST: IPv6: host 0 to host 3, mtu 1400                              [FAIL]
ok 33 selftests: net: fib_nexthop_multiprefix.sh
# selftests: net: fib_nexthops.sh
# 
# Basic functional tests
# ----------------------
# TEST: List with nothing defined                                     [ OK ]
# TEST: Nexthop get on non-existent id                                [ OK ]
# TEST: Nexthop with no device or gateway                             [ OK ]
# TEST: Nexthop with down device                                      [ OK ]
# TEST: Nexthop with device that is linkdown                          [ OK ]
# TEST: Nexthop with device only                                      [ OK ]
# TEST: Nexthop with duplicate id                                     [ OK ]
# TEST: Blackhole nexthop                                             [ OK ]
# TEST: Blackhole nexthop with other attributes                       [ OK ]
# TEST: Blackhole nexthop with loopback device down                   [ OK ]
# TEST: Create group                                                  [ OK ]
# TEST: Create group with blackhole nexthop                           [ OK ]
# TEST: Create multipath group where 1 path is a blackhole            [ OK ]
# TEST: Multipath group can not have a member replaced by blackhole   [ OK ]
# TEST: Create group with non-existent nexthop                        [ OK ]
# TEST: Create group with same nexthop multiple times                 [ OK ]
# TEST: Replace nexthop with nexthop group                            [ OK ]
# TEST: Replace nexthop group with nexthop                            [ OK ]
# TEST: Nexthop group and device                                      [ OK ]
# TEST: Test proto flush                                              [ OK ]
# TEST: Nexthop group and blackhole                                   [ OK ]
# 
# IPv4 functional
# ----------------------
# TEST: Create nexthop with id, gw, dev                               [ OK ]
# TEST: Get nexthop by id                                             [ OK ]
# TEST: Delete nexthop by id                                          [ OK ]
# TEST: Create nexthop - gw only                                      [ OK ]
# TEST: Create nexthop - invalid gw+dev combination                   [ OK ]
# TEST: Create nexthop - gw+dev and onlink                            [ OK ]
# TEST: Nexthops removed on admin down                                [ OK ]
# 
# IPv4 groups functional
# ----------------------
# TEST: Create nexthop group with single nexthop                      [ OK ]
# TEST: Get nexthop group by id                                       [ OK ]
# TEST: Delete nexthop group by id                                    [ OK ]
# TEST: Nexthop group with multiple nexthops                          [ OK ]
# TEST: Nexthop group updated when entry is deleted                   [ OK ]
# TEST: Nexthop group with weighted nexthops                          [ OK ]
# TEST: Weighted nexthop group updated when entry is deleted          [ OK ]
# TEST: Nexthops in groups removed on admin down                      [ OK ]
# TEST: Multiple groups with same nexthop                             [ OK ]
# TEST: Nexthops in group removed on admin down - mixed group         [ OK ]
# TEST: Nexthop group can not have a group as an entry                [ OK ]
# TEST: Nexthop group with a blackhole entry                          [ OK ]
# TEST: Nexthop group can not have a blackhole and another nexthop    [ OK ]
# TEST: IPv6 nexthop with IPv4 route                                  [ OK ]
# TEST: IPv6 nexthop with IPv4 route                                  [ OK ]
# TEST: IPv4 route with IPv6 gateway                                  [ OK ]
# TEST: IPv4 route with invalid IPv6 gateway                          [ OK ]
# 
# IPv4 functional runtime
# -----------------------
# TEST: Route add                                                     [ OK ]
# TEST: Route delete                                                  [ OK ]
# TEST: Route add - scope conflict with nexthop                       [ OK ]
# TEST: Nexthop replace with invalid scope for existing route         [ OK ]
# TEST: Basic ping                                                    [ OK ]
# TEST: Ping - multipath                                              [ OK ]
# TEST: Ping - multiple default routes, nh first                      [ OK ]
# TEST: Ping - multiple default routes, nh second                     [ OK ]
# TEST: Ping - blackhole                                              [ OK ]
# TEST: Ping - blackhole replaced with gateway                        [ OK ]
# TEST: Ping - gateway replaced by blackhole                          [ OK ]
# TEST: Ping - group with blackhole                                   [ OK ]
# TEST: Ping - group blackhole replaced with gateways                 [ OK ]
# TEST: IPv4 route with device only nexthop                           [ OK ]
# TEST: IPv4 multipath route with nexthop mix - dev only + gw         [ OK ]
# TEST: IPv6 nexthop with IPv4 route                                  [ OK ]
# TEST: IPv4 route with mixed v4-v6 multipath route                   [ OK ]
# TEST: IPv6 nexthop with IPv4 route                                  [ OK ]
# TEST: IPv4 route with IPv6 gateway                                  [ OK ]
# TEST: IPv4 default route with IPv6 gateway                          [ OK ]
# TEST: IPv4 route with MPLS encap                                    [ OK ]
# TEST: IPv4 route with MPLS encap - check                            [ OK ]
# TEST: IPv4 route with MPLS encap and v6 gateway                     [ OK ]
# TEST: IPv4 route with MPLS encap, v6 gw - check                     [ OK ]
# 
# IPv4 large groups (x32)
# ---------------------
# TEST: Dump large (x32) ecmp groups                                  [ OK ]
# 
# IPv4 nexthop api compat mode
# ----------------------------
# TEST: IPv4 default nexthop compat mode check                        [ OK ]
# TEST: IPv4 compat mode on - route add notification                  [ OK ]
# TEST: IPv4 compat mode on - route dump                              [ OK ]
# TEST: IPv4 compat mode on - nexthop change                          [ OK ]
# TEST: IPv4 set compat mode - 0                                      [ OK ]
# TEST: IPv4 compat mode off - route add notification                 [ OK ]
# TEST: IPv4 compat mode off - route dump                             [ OK ]
# TEST: IPv4 compat mode off - nexthop change                         [ OK ]
# TEST: IPv4 compat mode off - nexthop delete                         [ OK ]
# TEST: IPv4 set compat mode - 1                                      [ OK ]
# 
# IPv4 fdb groups functional
# --------------------------
# TEST: Fdb Nexthop group with multiple nexthops                      [ OK ]
# TEST: Get Fdb nexthop group by id                                   [ OK ]
# TEST: Fdb Nexthop group with non-fdb nexthops                       [ OK ]
# TEST: Non-Fdb Nexthop group with fdb nexthops                       [ OK ]
# TEST: Fdb Nexthop with blackhole                                    [ OK ]
# TEST: Fdb Nexthop with oif                                          [ OK ]
# TEST: Fdb Nexthop with onlink                                       [ OK ]
# TEST: Fdb Nexthop with encap                                        [ OK ]
# TEST: Fdb mac add with nexthop group                                [ OK ]
# TEST: Fdb mac add with nexthop                                      [ OK ]
# TEST: Route add with fdb nexthop                                    [ OK ]
# TEST: Route add with fdb nexthop group                              [ OK ]
# TEST: Fdb entry after deleting a single nexthop                     [ OK ]
# TEST: Fdb nexthop delete                                            [ OK ]
# TEST: Fdb entry after deleting a nexthop group                      [ OK ]
# 
# IPv4 runtime torture
# --------------------
# SKIP: Could not run test; need mausezahn tool
# 
# IPv6
# ----------------------
# TEST: Create nexthop with id, gw, dev                               [ OK ]
# TEST: Get nexthop by id                                             [ OK ]
# TEST: Delete nexthop by id                                          [ OK ]
# TEST: Create nexthop - gw only                                      [ OK ]
# TEST: Create nexthop - invalid gw+dev combination                   [ OK ]
# TEST: Create nexthop - gw+dev and onlink                            [ OK ]
# TEST: Nexthops removed on admin down                                [ OK ]
# 
# IPv6 groups functional
# ----------------------
# TEST: Create nexthop group with single nexthop                      [ OK ]
# TEST: Get nexthop group by id                                       [ OK ]
# TEST: Delete nexthop group by id                                    [ OK ]
# TEST: Nexthop group with multiple nexthops                          [ OK ]
# TEST: Nexthop group updated when entry is deleted                   [ OK ]
# TEST: Nexthop group with weighted nexthops                          [ OK ]
# TEST: Weighted nexthop group updated when entry is deleted          [ OK ]
# TEST: Nexthops in groups removed on admin down                      [ OK ]
# TEST: Multiple groups with same nexthop                             [ OK ]
# TEST: Nexthops in group removed on admin down - mixed group         [ OK ]
# TEST: Nexthop group can not have a group as an entry                [ OK ]
# TEST: Nexthop group with a blackhole entry                          [ OK ]
# TEST: Nexthop group can not have a blackhole and another nexthop    [ OK ]
# 
# IPv6 functional runtime
# -----------------------
# TEST: Route add                                                     [ OK ]
# TEST: Route delete                                                  [ OK ]
# TEST: Ping with nexthop                                             [ OK ]
# TEST: Ping - multipath                                              [ OK ]
# TEST: Ping - blackhole                                              [ OK ]
# TEST: Ping - blackhole replaced with gateway                        [ OK ]
# TEST: Ping - gateway replaced by blackhole                          [ OK ]
# TEST: Ping - group with blackhole                                   [ OK ]
# TEST: Ping - group blackhole replaced with gateways                 [ OK ]
# TEST: IPv6 route with device only nexthop                           [ OK ]
# TEST: IPv6 multipath route with nexthop mix - dev only + gw         [ OK ]
# TEST: IPv6 route can not have a v4 gateway                          [ OK ]
# TEST: Nexthop replace - v6 route, v4 nexthop                        [ OK ]
# TEST: Nexthop replace of group entry - v6 route, v4 nexthop         [ OK ]
# TEST: IPv6 route can not have a group with v4 and v6 gateways       [ OK ]
# TEST: IPv6 route can not have a group with v4 and v6 gateways       [ OK ]
# TEST: IPv6 route using a group after removing v4 gateways           [ OK ]
# TEST: IPv6 route can not have a group with v4 and v6 gateways       [ OK ]
# TEST: IPv6 route can not have a group with v4 and v6 gateways       [ OK ]
# TEST: IPv6 route using a group after replacing v4 gateways          [ OK ]
# TEST: Nexthop with default route and rpfilter                       [ OK ]
# TEST: Nexthop with multipath default route and rpfilter             [ OK ]
# 
# IPv6 large groups (x32)
# ---------------------
# TEST: Dump large (x32) ecmp groups                                  [ OK ]
# 
# IPv6 nexthop api compat mode test
# --------------------------------
# TEST: IPv6 default nexthop compat mode check                        [ OK ]
# TEST: IPv6 compat mode on - route add notification                  [ OK ]
# TEST: IPv6 compat mode on - route dump                              [ OK ]
# TEST: IPv6 compat mode on - nexthop change                          [ OK ]
# TEST: IPv6 set compat mode - 0                                      [ OK ]
# TEST: IPv6 compat mode off - route add notification                 [ OK ]
# TEST: IPv6 compat mode off - route dump                             [ OK ]
# TEST: IPv6 compat mode off - nexthop change                         [ OK ]
# TEST: IPv6 compat mode off - nexthop delete                         [ OK ]
# TEST: IPv6 set compat mode - 1                                      [ OK ]
# 
# IPv6 fdb groups functional
# --------------------------
# TEST: Fdb Nexthop group with multiple nexthops                      [ OK ]
# TEST: Get Fdb nexthop group by id                                   [ OK ]
# TEST: Fdb Nexthop group with non-fdb nexthops                       [ OK ]
# TEST: Non-Fdb Nexthop group with fdb nexthops                       [ OK ]
# TEST: Fdb Nexthop with blackhole                                    [ OK ]
# TEST: Fdb Nexthop with oif                                          [ OK ]
# TEST: Fdb Nexthop with onlink                                       [ OK ]
# TEST: Fdb Nexthop with encap                                        [ OK ]
# TEST: Fdb mac add with nexthop group                                [ OK ]
# TEST: Fdb mac add with nexthop                                      [ OK ]
# TEST: Route add with fdb nexthop                                    [ OK ]
# TEST: Route add with fdb nexthop group                              [ OK ]
# TEST: Fdb entry after deleting a single nexthop                     [ OK ]
# TEST: Fdb nexthop delete                                            [ OK ]
# TEST: Fdb entry after deleting a nexthop group                      [ OK ]
# 
# IPv6 runtime torture
# --------------------
# SKIP: Could not run test; need mausezahn tool
# 
# Tests passed: 163
# Tests failed:   0
ok 34 selftests: net: fib_nexthops.sh
# selftests: net: altnames.sh
# SKIP: jq not installed
not ok 35 selftests: net: altnames.sh # exit=1
# selftests: net: icmp_redirect.sh
# 
# ###########################################################################
# Legacy routing
# ###########################################################################
# 
# TEST: IPv4: redirect exception                                      [ OK ]
# TEST: IPv6: redirect exception                                      [FAIL]
# TEST: IPv4: redirect exception plus mtu                             [ OK ]
# TEST: IPv6: redirect exception plus mtu                             [FAIL]
# TEST: IPv4: routing reset                                           [ OK ]
# TEST: IPv6: routing reset                                           [ OK ]
# TEST: IPv4: mtu exception                                           [ OK ]
# TEST: IPv6: mtu exception                                           [ OK ]
# TEST: IPv4: mtu exception plus redirect                             [ OK ]
# TEST: IPv6: mtu exception plus redirect                             [FAIL]
# 
# ###########################################################################
# Legacy routing with VRF
# ###########################################################################
# 
# TEST: IPv4: redirect exception                                      [ OK ]
# TEST: IPv6: redirect exception                                      [FAIL]
# TEST: IPv4: redirect exception plus mtu                             [ OK ]
# TEST: IPv6: redirect exception plus mtu                             [FAIL]
# TEST: IPv4: routing reset                                           [ OK ]
# TEST: IPv6: routing reset                                           [ OK ]
# TEST: IPv4: mtu exception                                           [ OK ]
# TEST: IPv6: mtu exception                                           [ OK ]
# TEST: IPv4: mtu exception plus redirect                             [ OK ]
# TEST: IPv6: mtu exception plus redirect                             [FAIL]
# 
# ###########################################################################
# Routing with nexthop objects
# ###########################################################################
# 
# TEST: IPv4: redirect exception                                      [ OK ]
# TEST: IPv6: redirect exception                                      [FAIL]
# TEST: IPv4: redirect exception plus mtu                             [ OK ]
# TEST: IPv6: redirect exception plus mtu                             [FAIL]
# TEST: IPv4: routing reset                                           [ OK ]
# TEST: IPv6: routing reset                                           [ OK ]
# TEST: IPv4: mtu exception                                           [ OK ]
# TEST: IPv6: mtu exception                                           [ OK ]
# TEST: IPv4: mtu exception plus redirect                             [ OK ]
# TEST: IPv6: mtu exception plus redirect                             [FAIL]
# 
# ###########################################################################
# Routing with nexthop objects and VRF
# ###########################################################################
# 
# TEST: IPv4: redirect exception                                      [ OK ]
# TEST: IPv6: redirect exception                                      [FAIL]
# TEST: IPv4: redirect exception plus mtu                             [ OK ]
# TEST: IPv6: redirect exception plus mtu                             [FAIL]
# TEST: IPv4: routing reset                                           [ OK ]
# TEST: IPv6: routing reset                                           [ OK ]
# TEST: IPv4: mtu exception                                           [ OK ]
# TEST: IPv6: mtu exception                                           [ OK ]
# TEST: IPv4: mtu exception plus redirect                             [ OK ]
# TEST: IPv6: mtu exception plus redirect                             [FAIL]
# 
# Tests passed:  28
# Tests failed:  12
not ok 36 selftests: net: icmp_redirect.sh # exit=1
# selftests: net: ip6_gre_headroom.sh
# TEST: ip6gretap headroom                                            [PASS]
# TEST: ip6erspan headroom                                            [PASS]
ok 37 selftests: net: ip6_gre_headroom.sh
# selftests: net: route_localnet.sh
# run arp_announce test
# net.ipv4.conf.veth0.route_localnet = 1
# net.ipv4.conf.veth1.route_localnet = 1
# net.ipv4.conf.veth0.arp_announce = 2
# net.ipv4.conf.veth1.arp_announce = 2
# PING 127.25.3.14 (127.25.3.14) from 127.25.3.4 veth0: 56(84) bytes of data.
# 64 bytes from 127.25.3.14: icmp_seq=1 ttl=64 time=0.066 ms
# 64 bytes from 127.25.3.14: icmp_seq=2 ttl=64 time=0.052 ms
# 64 bytes from 127.25.3.14: icmp_seq=3 ttl=64 time=0.045 ms
# 64 bytes from 127.25.3.14: icmp_seq=4 ttl=64 time=0.044 ms
# 64 bytes from 127.25.3.14: icmp_seq=5 ttl=64 time=0.046 ms
# 
# --- 127.25.3.14 ping statistics ---
# 5 packets transmitted, 5 received, 0% packet loss, time 138ms
# rtt min/avg/max/mdev = 0.044/0.050/0.066/0.011 ms
# ok
# run arp_ignore test
# net.ipv4.conf.veth0.route_localnet = 1
# net.ipv4.conf.veth1.route_localnet = 1
# net.ipv4.conf.veth0.arp_ignore = 3
# net.ipv4.conf.veth1.arp_ignore = 3
# PING 127.25.3.14 (127.25.3.14) from 127.25.3.4 veth0: 56(84) bytes of data.
# 64 bytes from 127.25.3.14: icmp_seq=1 ttl=64 time=0.070 ms
# 64 bytes from 127.25.3.14: icmp_seq=2 ttl=64 time=0.046 ms
# 64 bytes from 127.25.3.14: icmp_seq=3 ttl=64 time=0.047 ms
# 64 bytes from 127.25.3.14: icmp_seq=4 ttl=64 time=0.045 ms
# 64 bytes from 127.25.3.14: icmp_seq=5 ttl=64 time=0.055 ms
# 
# --- 127.25.3.14 ping statistics ---
# 5 packets transmitted, 5 received, 0% packet loss, time 123ms
# rtt min/avg/max/mdev = 0.045/0.052/0.070/0.012 ms
# ok
ok 38 selftests: net: route_localnet.sh
# selftests: net: reuseaddr_ports_exhausted.sh
# TAP version 13
# 1..3
# # Starting 3 tests from 1 test cases.
# #  RUN           global.reuseaddr_ports_exhausted_unreusable ...
# #            OK  global.reuseaddr_ports_exhausted_unreusable
# ok 1 global.reuseaddr_ports_exhausted_unreusable
# #  RUN           global.reuseaddr_ports_exhausted_reusable_same_euid ...
# #            OK  global.reuseaddr_ports_exhausted_reusable_same_euid
# ok 2 global.reuseaddr_ports_exhausted_reusable_same_euid
# #  RUN           global.reuseaddr_ports_exhausted_reusable_different_euid ...
# #            OK  global.reuseaddr_ports_exhausted_reusable_different_euid
# ok 3 global.reuseaddr_ports_exhausted_reusable_different_euid
# # PASSED: 3 / 3 tests passed.
# # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
# tests done
ok 39 selftests: net: reuseaddr_ports_exhausted.sh
# selftests: net: txtimestamp.sh
# protocol:     TCP
# payload:      10
# server port:  9000
# 
# family:       INET 
# test SND
#     USR: 1618856276 s 399083 us (seq=0, len=0)
#     SND: 1618856276 s 400550 us (seq=9, len=10)  (USR +1467 us)
#     USR: 1618856276 s 449317 us (seq=0, len=0)
#     SND: 1618856276 s 450337 us (seq=19, len=10)  (USR +1019 us)
#     USR: 1618856276 s 499478 us (seq=0, len=0)
#     SND: 1618856276 s 500531 us (seq=29, len=10)  (USR +1053 us)
#     USR: 1618856276 s 549767 us (seq=0, len=0)
#     SND: 1618856276 s 550847 us (seq=39, len=10)  (USR +1080 us)
#     USR-SND: count=4, avg=1155 us, min=1019 us, max=1467 us
# test ENQ
#     USR: 1618856276 s 706738 us (seq=0, len=0)
#     ENQ: 1618856276 s 706796 us (seq=9, len=10)  (USR +57 us)
#     USR: 1618856276 s 756958 us (seq=0, len=0)
#     ENQ: 1618856276 s 756971 us (seq=19, len=10)  (USR +13 us)
#     USR: 1618856276 s 807197 us (seq=0, len=0)
#     ENQ: 1618856276 s 807222 us (seq=29, len=10)  (USR +24 us)
#     USR: 1618856276 s 857632 us (seq=0, len=0)
#     ENQ: 1618856276 s 857667 us (seq=39, len=10)  (USR +35 us)
#     USR-ENQ: count=4, avg=32 us, min=13 us, max=57 us
# test ENQ + SND
#     USR: 1618856277 s 19202 us (seq=0, len=0)
#     ENQ: 1618856277 s 19231 us (seq=9, len=10)  (USR +28 us)
#     SND: 1618856277 s 20250 us (seq=9, len=10)  (USR +1047 us)
#     USR: 1618856277 s 69689 us (seq=0, len=0)
#     ENQ: 1618856277 s 69710 us (seq=19, len=10)  (USR +21 us)
#     SND: 1618856277 s 70756 us (seq=19, len=10)  (USR +1066 us)
#     USR: 1618856277 s 120059 us (seq=0, len=0)
#     ENQ: 1618856277 s 120093 us (seq=29, len=10)  (USR +34 us)
#     SND: 1618856277 s 121105 us (seq=29, len=10)  (USR +1046 us)
#     USR: 1618856277 s 170421 us (seq=0, len=0)
#     ENQ: 1618856277 s 170441 us (seq=39, len=10)  (USR +19 us)
#     SND: 1618856277 s 171453 us (seq=39, len=10)  (USR +1031 us)
#     USR-ENQ: count=4, avg=25 us, min=19 us, max=34 us
#     USR-SND: count=4, avg=1047 us, min=1031 us, max=1066 us
# 
# test ACK
#     USR: 1618856277 s 327673 us (seq=0, len=0)
#     ACK: 1618856277 s 333850 us (seq=9, len=10)  (USR +6177 us)
#     USR: 1618856277 s 378073 us (seq=0, len=0)
# ERROR: 17264 us expected between 6000 and 6500
#     ACK: 1618856277 s 395337 us (seq=19, len=10)  (USR +17263 us)
#     USR: 1618856277 s 428489 us (seq=0, len=0)
#     ACK: 1618856277 s 434731 us (seq=29, len=10)  (USR +6241 us)
#     USR: 1618856277 s 478725 us (seq=0, len=0)
# ERROR: 17259 us expected between 6000 and 6500
#     ACK: 1618856277 s 495984 us (seq=39, len=10)  (USR +17259 us)
#     USR-ACK: count=4, avg=11735 us, min=6177 us, max=17263 us
# 
# test SND + ACK
#     USR: 1618856277 s 635412 us (seq=0, len=0)
#     SND: 1618856277 s 636460 us (seq=9, len=10)  (USR +1048 us)
#     ACK: 1618856277 s 641562 us (seq=9, len=10)  (USR +6149 us)
#     USR: 1618856277 s 685671 us (seq=0, len=0)
#     SND: 1618856277 s 686747 us (seq=19, len=10)  (USR +1076 us)
#     ACK: 1618856277 s 691931 us (seq=19, len=10)  (USR +6259 us)
#     USR: 1618856277 s 735907 us (seq=0, len=0)
#     SND: 1618856277 s 736956 us (seq=29, len=10)  (USR +1049 us)
#     ACK: 1618856277 s 742118 us (seq=29, len=10)  (USR +6211 us)
#     USR: 1618856277 s 786360 us (seq=0, len=0)
#     SND: 1618856277 s 787390 us (seq=39, len=10)  (USR +1030 us)
#     ACK: 1618856277 s 792546 us (seq=39, len=10)  (USR +6185 us)
#     USR-SND: count=4, avg=1051 us, min=1030 us, max=1076 us
#     USR-ACK: count=4, avg=6201 us, min=6149 us, max=6259 us
# 
# test ENQ + SND + ACK
#     USR: 1618856277 s 948662 us (seq=0, len=0)
#     ENQ: 1618856277 s 948683 us (seq=9, len=10)  (USR +20 us)
#     SND: 1618856277 s 949703 us (seq=9, len=10)  (USR +1040 us)
#     ACK: 1618856277 s 954821 us (seq=9, len=10)  (USR +6158 us)
#     USR: 1618856277 s 999138 us (seq=0, len=0)
#     ENQ: 1618856277 s 999158 us (seq=19, len=10)  (USR +20 us)
#     SND: 1618856278 s 183 us (seq=19, len=10)  (USR +1045 us)
#     ACK: 1618856278 s 5323 us (seq=19, len=10)  (USR +6185 us)
#     USR: 1618856278 s 49459 us (seq=0, len=0)
#     ENQ: 1618856278 s 49479 us (seq=29, len=10)  (USR +19 us)
#     SND: 1618856278 s 50504 us (seq=29, len=10)  (USR +1044 us)
# ERROR: 18740 us expected between 6000 and 6500
#     ACK: 1618856278 s 68199 us (seq=29, len=10)  (USR +18740 us)
#     USR: 1618856278 s 99944 us (seq=0, len=0)
#     ENQ: 1618856278 s 99964 us (seq=39, len=10)  (USR +19 us)
#     SND: 1618856278 s 100990 us (seq=39, len=10)  (USR +1045 us)
# ERROR: 18970 us expected between 6000 and 6500
#     ACK: 1618856278 s 118914 us (seq=39, len=10)  (USR +18969 us)
#     USR-ENQ: count=4, avg=20 us, min=19 us, max=20 us
#     USR-SND: count=4, avg=1043 us, min=1040 us, max=1045 us
#     USR-ACK: count=4, avg=12513 us, min=6158 us, max=18969 us
not ok 40 selftests: net: txtimestamp.sh # exit=1
# selftests: net: vrf-xfrm-tests.sh
# 
# No qdisc on VRF device
# TEST: IPv4 no xfrm policy                                           [ OK ]
# TEST: IPv6 no xfrm policy                                           [ OK ]
# TEST: IPv4 xfrm policy based on address                             [ OK ]
# TEST: IPv6 xfrm policy based on address                             [ OK ]
# TEST: IPv6 xfrm policy with VRF in selector                         [ OK ]
# Error: Unknown device type.
# Cannot find device "xfrm0"
# Cannot find device "xfrm0"
# Cannot find device "xfrm0"
# TEST: IPv4 xfrm policy with xfrm device                             [FAIL]
# TEST: IPv6 xfrm policy with xfrm device                             [FAIL]
# Cannot find device "xfrm0"
# 
# netem qdisc on VRF device
# TEST: IPv4 no xfrm policy                                           [ OK ]
# TEST: IPv6 no xfrm policy                                           [ OK ]
# TEST: IPv4 xfrm policy based on address                             [ OK ]
# TEST: IPv6 xfrm policy based on address                             [ OK ]
# TEST: IPv6 xfrm policy with VRF in selector                         [ OK ]
# Error: Unknown device type.
# Cannot find device "xfrm0"
# Cannot find device "xfrm0"
# Cannot find device "xfrm0"
# TEST: IPv4 xfrm policy with xfrm device                             [FAIL]
# TEST: IPv6 xfrm policy with xfrm device                             [FAIL]
# Cannot find device "xfrm0"
# 
# Tests passed:  10
# Tests failed:   4
not ok 41 selftests: net: vrf-xfrm-tests.sh # exit=1
# selftests: net: rxtimestamp.sh
# Testing ip...
# Starting testcase 0 over ipv4...
# Starting testcase 0 over ipv6...
# Starting testcase 1 over ipv4...
# Starting testcase 1 over ipv6...
# Starting testcase 2 over ipv4...
# Starting testcase 2 over ipv6...
# Starting testcase 3 over ipv4...
# Starting testcase 3 over ipv6...
# Starting testcase 4 over ipv4...
# Starting testcase 4 over ipv6...
# Starting testcase 5 over ipv4...
# Starting testcase 5 over ipv6...
# Starting testcase 6 over ipv4...
# ./rxtimestamp: Expected swtstamp to not be set.
# FAILURE in testcase 6 over ipv4 sockopts { SO_TIMESTAMPING: { SOF_TIMESTAMPING_SOFTWARE |}} expected cmsgs: {}
# Starting testcase 6 over ipv6...
# ./rxtimestamp: Expected swtstamp to not be set.
# FAILURE in testcase 6 over ipv6 sockopts { SO_TIMESTAMPING: { SOF_TIMESTAMPING_SOFTWARE |}} expected cmsgs: {}
# Starting testcase 7 over ipv4...
# Starting testcase 7 over ipv6...
# Starting testcase 8 over ipv4...
# Starting testcase 8 over ipv6...
# Starting testcase 9 over ipv4...
# Starting testcase 9 over ipv6...
# Testing udp...
# Starting testcase 0 over ipv4...
# Starting testcase 0 over ipv6...
# Starting testcase 1 over ipv4...
# Starting testcase 1 over ipv6...
# Starting testcase 2 over ipv4...
# Starting testcase 2 over ipv6...
# Starting testcase 3 over ipv4...
# Starting testcase 3 over ipv6...
# Starting testcase 4 over ipv4...
# Starting testcase 4 over ipv6...
# Starting testcase 5 over ipv4...
# Starting testcase 5 over ipv6...
# Starting testcase 6 over ipv4...
# ./rxtimestamp: Expected swtstamp to not be set.
# FAILURE in testcase 6 over ipv4 sockopts { SO_TIMESTAMPING: { SOF_TIMESTAMPING_SOFTWARE |}} expected cmsgs: {}
# Starting testcase 6 over ipv6...
# ./rxtimestamp: Expected swtstamp to not be set.
# FAILURE in testcase 6 over ipv6 sockopts { SO_TIMESTAMPING: { SOF_TIMESTAMPING_SOFTWARE |}} expected cmsgs: {}
# Starting testcase 7 over ipv4...
# Starting testcase 7 over ipv6...
# Starting testcase 8 over ipv4...
# Starting testcase 8 over ipv6...
# Starting testcase 9 over ipv4...
# Starting testcase 9 over ipv6...
# Testing tcp...
# Starting testcase 0 over ipv4...
# Starting testcase 0 over ipv6...
# Starting testcase 1 over ipv4...
# Starting testcase 1 over ipv6...
# Starting testcase 2 over ipv4...
# Starting testcase 2 over ipv6...
# Starting testcase 3 over ipv4...
# Starting testcase 3 over ipv6...
# Starting testcase 4 over ipv4...
# Starting testcase 4 over ipv6...
# Starting testcase 5 over ipv4...
# Starting testcase 5 over ipv6...
# Starting testcase 6 over ipv4...
# ./rxtimestamp: Expected swtstamp to not be set.
# FAILURE in testcase 6 over ipv4 sockopts { SO_TIMESTAMPING: { SOF_TIMESTAMPING_SOFTWARE |}} expected cmsgs: {}
# Starting testcase 6 over ipv6...
# ./rxtimestamp: Expected swtstamp to not be set.
# FAILURE in testcase 6 over ipv6 sockopts { SO_TIMESTAMPING: { SOF_TIMESTAMPING_SOFTWARE |}} expected cmsgs: {}
# Starting testcase 7 over ipv4...
# Starting testcase 7 over ipv6...
# Starting testcase 8 over ipv4...
# Starting testcase 8 over ipv6...
# Starting testcase 9 over ipv4...
# Starting testcase 9 over ipv6...
# PASSED.
ok 42 selftests: net: rxtimestamp.sh
# selftests: net: devlink_port_split.py
# Traceback (most recent call last):
#   File "./devlink_port_split.py", line 277, in <module>
#     main()
#   File "./devlink_port_split.py", line 242, in main
#     dev = list(devs.keys())[0]
# IndexError: list index out of range
not ok 43 selftests: net: devlink_port_split.py # exit=1
# selftests: net: drop_monitor_tests.sh
# SKIP: Could not run test without tshark tool
ok 44 selftests: net: drop_monitor_tests.sh # SKIP
# selftests: net: vrf_route_leaking.sh
# 
# ###########################################################################
# IPv4 (sym route): VRF ICMP ttl error route lookup ping
# ###########################################################################
# 
# TEST: Basic IPv4 connectivity                                       [ OK ]
# TEST: Ping received ICMP ttl exceeded                               [ OK ]
# 
# ###########################################################################
# IPv4 (sym route): VRF ICMP error route lookup traceroute
# ###########################################################################
# 
# SKIP: Could not run IPV4 test without traceroute
# 
# ###########################################################################
# IPv4 (sym route): VRF ICMP fragmentation error route lookup ping
# ###########################################################################
# 
# TEST: Basic IPv4 connectivity                                       [ OK ]
# TEST: Ping received ICMP Frag needed                                [ OK ]
# 
# ###########################################################################
# IPv4 (asym route): VRF ICMP ttl error route lookup ping
# ###########################################################################
# 
# TEST: Basic IPv4 connectivity                                       [ OK ]
# TEST: Ping received ICMP ttl exceeded                               [ OK ]
# 
# ###########################################################################
# IPv4 (asym route): VRF ICMP error route lookup traceroute
# ###########################################################################
# 
# SKIP: Could not run IPV4 test without traceroute
# 
# ###########################################################################
# IPv6 (sym route): VRF ICMP ttl error route lookup ping
# ###########################################################################
# 
# TEST: Basic IPv6 connectivity                                       [ OK ]
# TEST: Ping received ICMP Hop limit                                  [ OK ]
# 
# ###########################################################################
# IPv6 (sym route): VRF ICMP error route lookup traceroute
# ###########################################################################
# 
# SKIP: Could not run IPV6 test without traceroute6
# 
# ###########################################################################
# IPv6 (sym route): VRF ICMP fragmentation error route lookup ping
# ###########################################################################
# 
# TEST: Basic IPv6 connectivity                                       [ OK ]
# TEST: Ping received ICMP Packet too big                             [FAIL]
# 
# ###########################################################################
# IPv6 (asym route): VRF ICMP ttl error route lookup ping
# ###########################################################################
# 
# TEST: Basic IPv6 connectivity                                       [ OK ]
# TEST: Ping received ICMP Hop limit                                  [ OK ]
# 
# ###########################################################################
# IPv6 (asym route): VRF ICMP error route lookup traceroute
# ###########################################################################
# 
# SKIP: Could not run IPV6 test without traceroute6
# 
# Tests passed:  11
# Tests failed:   1
not ok 45 selftests: net: vrf_route_leaking.sh # exit=1
# selftests: net: bareudp.sh
# TEST: IPv4 packets over UDPv4                                       [ OK ]
# TEST: IPv4 packets over UDPv6                                       [ OK ]
# TEST: IPv6 packets over UDPv4                                       [ OK ]
# TEST: IPv6 packets over UDPv6                                       [ OK ]
# TEST: IPv4 packets over UDPv4 (multiproto mode)                     [ OK ]
# TEST: IPv6 packets over UDPv4 (multiproto mode)                     [ OK ]
# TEST: IPv4 packets over UDPv6 (multiproto mode)                     [ OK ]
# TEST: IPv6 packets over UDPv6 (multiproto mode)                     [ OK ]
# TEST: Unicast MPLS packets over UDPv4                               [ OK ]
# TEST: Unicast MPLS packets over UDPv6                               [ OK ]
ok 46 selftests: net: bareudp.sh
# selftests: net: unicast_extensions.sh
# ###########################################################################
# Unicast address extensions tests (behavior of reserved IPv4 addresses)
# ###########################################################################
# TEST: assign and ping within 240/4 (1 of 2) (is allowed)            [ OK ]
# TEST: assign and ping within 240/4 (2 of 2) (is allowed)            [ OK ]
# TEST: assign and ping within 0/8 (1 of 2) (is allowed)              [ OK ]
# TEST: assign and ping within 0/8 (2 of 2) (is allowed)              [ OK ]
# TEST: assign and ping inside 255.255/16 (is allowed)                [ OK ]
# TEST: assign and ping inside 255.255.255/24 (is allowed)            [ OK ]
# TEST: route between 240.5.6/24 and 255.1.2/24 (is allowed)          [ OK ]
# TEST: route between 0.200/16 and 245.99/16 (is allowed)             [ OK ]
# TEST: assigning 0.0.0.0 (is forbidden)                              [ OK ]
# TEST: assigning 255.255.255.255 (is forbidden)                      [ OK ]
# TEST: assign and ping inside 127/8 (is forbidden)                   [ OK ]
# TEST: assign and ping lowest address (is forbidden)                 [ OK ]
# TEST: routing using lowest address (is forbidden)                   [ OK ]
# TEST: assign and ping class D address (is forbidden)                [ OK ]
# TEST: routing using class D (is forbidden)                          [ OK ]
# TEST: routing using 127/8 (is forbidden)                            [ OK ]
ok 47 selftests: net: unicast_extensions.sh



To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install                job.yaml  # job file is attached in this email
        bin/lkp split-job --compatible job.yaml
        bin/lkp run                    compatible-job.yaml



---
0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation

Thanks,
Oliver Sang


--eqp4TxRxnD4KrmFZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.12.0-rc6-00349-g6628ddfec758"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.12.0-rc6 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-22) 9.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90300
CONFIG_CLANG_VERSION=0
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23502
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y
CONFIG_PREEMPT_DYNAMIC=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_BPF_LSM is not set
CONFIG_BPF_SYSCALL=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
# CONFIG_BPF_PRELOAD is not set
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_XEN=y
# CONFIG_XEN_PV is not set
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_PVHVM_GUEST=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
# CONFIG_XEN_PVH is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
CONFIG_PERF_EVENTS_AMD_POWER=m
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_I8K=m
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_AMD_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_UMIP=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_X86_SGX=y
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_PMIC_OPREGION=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# CONFIG_X86_SYSFB is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
CONFIG_APPLE_PROPERTIES=y
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=y
# CONFIG_KVM_WERROR is not set
CONFIG_KVM_INTEL=y
# CONFIG_KVM_AMD is not set
# CONFIG_KVM_XEN is not set
CONFIG_KVM_MMU_AUDIT=y
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
CONFIG_BLK_WBT=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
CONFIG_BLK_WBT_MQ=y
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
# CONFIG_CMA is not set
# CONFIG_MEM_SOFT_DIRTY is not set
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
# CONFIG_ZSWAP_DEFAULT_ON is not set
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DEVICE=y
CONFIG_DEV_PAGEMAP_OPS=y
CONFIG_HMM_MIRROR=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_TEST=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_NET_REDIRECT=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE_DEMUX=y
CONFIG_NET_IP_TUNNEL=y
CONFIG_NET_IPGRE=y
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=y
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=y
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=y
CONFIG_IPV6_GRE=y
CONFIG_IPV6_FOU=y
CONFIG_IPV6_FOU_TUNNEL=y
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_SEG6_BPF=y
# CONFIG_IPV6_RPL_LWTUNNEL is not set
CONFIG_NETLABEL=y
CONFIG_MPTCP=y
CONFIG_INET_MPTCP_DIAG=m
CONFIG_MPTCP_IPV6=y
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_COMMON=m
CONFIG_NF_LOG_NETDEV=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_FLOW_OFFLOAD=m
CONFIG_NFT_COUNTER=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_OBJREF=m
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
# CONFIG_NFT_XFRM is not set
CONFIG_NFT_SOCKET=m
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
CONFIG_NF_FLOW_TABLE_INET=m
CONFIG_NF_FLOW_TABLE=m
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m
# CONFIG_IP_VS_TWOS is not set

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_FLOW_TABLE_IPV4=m
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_FLOW_TABLE_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_TARGET_HL is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
# CONFIG_NFT_BRIDGE_META is not set
CONFIG_NFT_BRIDGE_REJECT=m
CONFIG_NF_LOG_BRIDGE=m
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=m
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=y
CONFIG_GARP=y
CONFIG_MRP=y
CONFIG_BRIDGE=y
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=y
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=y
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
# CONFIG_6LOWPAN_NHC is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
CONFIG_NET_SCH_ETF=m
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=y
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
# CONFIG_NET_SCH_FQ_PIE is not set
CONFIG_NET_SCH_INGRESS=y
CONFIG_NET_SCH_PLUG=m
CONFIG_NET_SCH_ETS=m
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
CONFIG_NET_EMATCH_CANID=m
CONFIG_NET_EMATCH_IPSET=m
CONFIG_NET_EMATCH_IPT=m
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
CONFIG_NET_ACT_MPLS=m
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
CONFIG_NET_ACT_CONNMARK=m
CONFIG_NET_ACT_CTINFO=m
CONFIG_NET_ACT_SKBMOD=m
CONFIG_NET_ACT_IFE=m
CONFIG_NET_ACT_TUNNEL_KEY=m
CONFIG_NET_ACT_CT=m
# CONFIG_NET_ACT_GATE is not set
CONFIG_NET_IFE_SKBMARK=m
CONFIG_NET_IFE_SKBPRIO=m
CONFIG_NET_IFE_SKBTCINDEX=m
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_OPENVSWITCH_GENEVE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=m
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_PLX_PCI=m
# CONFIG_CAN_SJA1000_ISA is not set
CONFIG_CAN_SJA1000_PLATFORM=m
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# CONFIG_CAN_MCP251XFD is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB2 is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

CONFIG_BT=m
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_HIDP=m
CONFIG_BT_HS=y
CONFIG_BT_LE=y
# CONFIG_BT_6LOWPAN is not set
# CONFIG_BT_LEDS is not set
# CONFIG_BT_MSFTEXT is not set
CONFIG_BT_DEBUGFS=y
# CONFIG_BT_SELFTEST is not set

#
# Bluetooth device drivers
#
# CONFIG_BT_HCIBTUSB is not set
# CONFIG_BT_HCIBTSDIO is not set
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
# CONFIG_BT_HCIUART_INTEL is not set
# CONFIG_BT_HCIUART_AG6XX is not set
# CONFIG_BT_HCIBCM203X is not set
# CONFIG_BT_HCIBPA10X is not set
# CONFIG_BT_HCIBFUSB is not set
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
# CONFIG_BT_MRVL_SDIO is not set
# CONFIG_BT_MTKSDIO is not set
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
# CONFIG_CFG80211_WEXT is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
# CONFIG_MAC80211_MESH is not set
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
CONFIG_NET_IFE=m
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
# CONFIG_XEN_PCIDEV_FRONTEND is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y
CONFIG_PCI_HYPERV_INTERFACE=m

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
CONFIG_ZRAM=m
CONFIG_ZRAM_DEF_COMP_LZORLE=y
# CONFIG_ZRAM_DEF_COMP_LZO is not set
CONFIG_ZRAM_DEF_COMP="lzo-rle"
CONFIG_ZRAM_WRITEBACK=y
# CONFIG_ZRAM_MEMORY_TRACKING is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_XEN_BLKDEV_FRONTEND=m
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
CONFIG_NVME_FC=m
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
CONFIG_PVPANIC=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_HDCP is not set
CONFIG_VMWARE_VMCI=m
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=m
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_XEN_SCSI_FRONTEND is not set
CONFIG_HYPERV_STORAGE=m
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_PLATFORM is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
# CONFIG_MD_MULTIPATH is not set
CONFIG_MD_FAULTY=m
CONFIG_MD_CLUSTER=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
# CONFIG_DM_MULTIPATH_IOA is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_ISCSI_TARGET=m
# CONFIG_SBP_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
CONFIG_DUMMY=y
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
CONFIG_IFB=y
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
CONFIG_VXLAN=y
CONFIG_GENEVE=y
CONFIG_BAREUDP=m
# CONFIG_GTP is not set
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=y
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
CONFIG_NET_VRF=y
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_FIRESTREAM is not set
# CONFIG_ATM_ZATM is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_AMBASSADOR is not set
# CONFIG_ATM_HORIZON is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set

#
# Distributed Switch Architecture drivers
#
# CONFIG_NET_DSA_MV88E6XXX_PTP is not set
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_MDIO=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
CONFIG_IXGBE_IPSEC=y
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
# CONFIG_IGC is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLIB=y
# CONFIG_LED_TRIGGER_PHY is not set
# CONFIG_FIXED_PHY is not set

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AX88796B_PHY is not set
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# CONFIG_PCS_XPCS is not set
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
# CONFIG_USB_NET_CDCETHER is not set
# CONFIG_USB_NET_CDC_EEM is not set
# CONFIG_USB_NET_CDC_NCM is not set
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
# CONFIG_ATH11K is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_MT7601U is not set
# CONFIG_MT76x0U is not set
# CONFIG_MT76x0E is not set
# CONFIG_MT76x2E is not set
# CONFIG_MT76x2U is not set
# CONFIG_MT7603E is not set
# CONFIG_MT7615E is not set
# CONFIG_MT7663U is not set
# CONFIG_MT7663S is not set
# CONFIG_MT7915E is not set
# CONFIG_MT7921E is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
# CONFIG_MAC80211_HWSIM is not set
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set
# CONFIG_WAN is not set
CONFIG_IEEE802154_DRIVERS=m
# CONFIG_IEEE802154_FAKELB is not set
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set
CONFIG_XEN_NETDEV_FRONTEND=y
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_HYPERV_NET is not set
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
# CONFIG_RMI4_F54 is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_BCM63XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK_GT=m
# CONFIG_ISI is not set
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
# CONFIG_TRACE_SINK is not set
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set
CONFIG_NVRAM=y
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=8192
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_XEN is not set
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# end of Character devices

# CONFIG_RANDOM_TRUST_CPU is not set
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# CONFIG_PTP_1588_CLOCK_OCP is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=m
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
CONFIG_PINCTRL_INTEL=y
# CONFIG_PINCTRL_ALDERLAKE is not set
CONFIG_PINCTRL_BROXTON=m
CONFIG_PINCTRL_CANNONLAKE=m
CONFIG_PINCTRL_CEDARFORK=m
CONFIG_PINCTRL_DENVERTON=m
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
CONFIG_PINCTRL_GEMINILAKE=m
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_SUNRISEPOINT=m
# CONFIG_PINCTRL_TIGERLAKE is not set

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_AMDPT=m
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
CONFIG_GPIO_MOCKUP=m
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
# CONFIG_SENSORS_AMD_ENERGY is not set
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_MLXREG_FAN is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
# CONFIG_SENSORS_MAX20730 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_PM6764TR is not set
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_Q54SJ108A2 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_SBTSI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=m
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
# CONFIG_INT3406_THERMAL is not set
CONFIG_PROC_THERMAL_MMIO_RAPL=m
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_MLX_WDT is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set
CONFIG_XEN_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_INTEL_PMT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_INTEL_M10_BMC is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_IR_IMON_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_RC_DEVICES=y
# CONFIG_RC_ATI_REMOTE is not set
CONFIG_IR_ENE=m
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
# CONFIG_IR_STREAMZAP is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_RC_LOOPBACK=m
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
CONFIG_IR_SIR=m
# CONFIG_RC_XBOX_DVD is not set
# CONFIG_IR_TOY is not set
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_CEC_CH7322 is not set
# CONFIG_CEC_GPIO is not set
# CONFIG_CEC_SECO is not set
# CONFIG_USB_PULSE8_CEC is not set
# CONFIG_USB_RAINSHADOW_CEC is not set
CONFIG_MEDIA_SUPPORT=m
# CONFIG_MEDIA_SUPPORT_FILTER is not set
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_PLATFORM_SUPPORT=y
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

#
# Media core support
#
CONFIG_VIDEO_DEV=m
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=m
# end of Media core support

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2=m
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
# end of Video4Linux options

#
# Media controller options
#
# CONFIG_MEDIA_CONTROLLER_DVB is not set
# end of Media controller options

#
# Digital TV options
#
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set
# end of Digital TV options

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_RADIO_ADAPTERS=y
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_USB_MR800 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
# CONFIG_USB_KEENE is not set
# CONFIG_USB_RAREMONO is not set
# CONFIG_USB_MA901 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_WL1273 is not set
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set
# CONFIG_SDR_PLATFORM_DRIVERS is not set

#
# MMC/SDIO DVB adapters
#
# CONFIG_SMS_SDIO_DRV is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_TEST_DRIVERS is not set

#
# FireWire (IEEE 1394) Adapters
#
# CONFIG_DVB_FIREDTV is not set
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# Audio decoders, processors and mixers
#
# CONFIG_VIDEO_TVAUDIO is not set
# CONFIG_VIDEO_TDA7432 is not set
# CONFIG_VIDEO_TDA9840 is not set
# CONFIG_VIDEO_TEA6415C is not set
# CONFIG_VIDEO_TEA6420 is not set
# CONFIG_VIDEO_MSP3400 is not set
# CONFIG_VIDEO_CS3308 is not set
# CONFIG_VIDEO_CS5345 is not set
# CONFIG_VIDEO_CS53L32A is not set
# CONFIG_VIDEO_TLV320AIC23B is not set
# CONFIG_VIDEO_UDA1342 is not set
# CONFIG_VIDEO_WM8775 is not set
# CONFIG_VIDEO_WM8739 is not set
# CONFIG_VIDEO_VP27SMPX is not set
# CONFIG_VIDEO_SONY_BTF_MPX is not set
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
# CONFIG_VIDEO_SAA6588 is not set
# end of RDS decoders

#
# Video decoders
#
# CONFIG_VIDEO_ADV7180 is not set
# CONFIG_VIDEO_ADV7183 is not set
# CONFIG_VIDEO_ADV7604 is not set
# CONFIG_VIDEO_ADV7842 is not set
# CONFIG_VIDEO_BT819 is not set
# CONFIG_VIDEO_BT856 is not set
# CONFIG_VIDEO_BT866 is not set
# CONFIG_VIDEO_KS0127 is not set
# CONFIG_VIDEO_ML86V7667 is not set
# CONFIG_VIDEO_SAA7110 is not set
# CONFIG_VIDEO_SAA711X is not set
# CONFIG_VIDEO_TC358743 is not set
# CONFIG_VIDEO_TVP514X is not set
# CONFIG_VIDEO_TVP5150 is not set
# CONFIG_VIDEO_TVP7002 is not set
# CONFIG_VIDEO_TW2804 is not set
# CONFIG_VIDEO_TW9903 is not set
# CONFIG_VIDEO_TW9906 is not set
# CONFIG_VIDEO_TW9910 is not set
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
# CONFIG_VIDEO_SAA717X is not set
# CONFIG_VIDEO_CX25840 is not set
# end of Video decoders

#
# Video encoders
#
# CONFIG_VIDEO_SAA7127 is not set
# CONFIG_VIDEO_SAA7185 is not set
# CONFIG_VIDEO_ADV7170 is not set
# CONFIG_VIDEO_ADV7175 is not set
# CONFIG_VIDEO_ADV7343 is not set
# CONFIG_VIDEO_ADV7393 is not set
# CONFIG_VIDEO_ADV7511 is not set
# CONFIG_VIDEO_AD9389B is not set
# CONFIG_VIDEO_AK881X is not set
# CONFIG_VIDEO_THS8200 is not set
# end of Video encoders

#
# Video improvement chips
#
# CONFIG_VIDEO_UPD64031A is not set
# CONFIG_VIDEO_UPD64083 is not set
# end of Video improvement chips

#
# Audio/Video compression chips
#
# CONFIG_VIDEO_SAA6752HS is not set
# end of Audio/Video compression chips

#
# SDR tuner chips
#
# CONFIG_SDR_MAX2175 is not set
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_THS7303 is not set
# CONFIG_VIDEO_M52790 is not set
# CONFIG_VIDEO_I2C is not set
# CONFIG_VIDEO_ST_MIPID02 is not set
# end of Miscellaneous helper chips

#
# Camera sensor devices
#
# CONFIG_VIDEO_HI556 is not set
# CONFIG_VIDEO_IMX214 is not set
# CONFIG_VIDEO_IMX219 is not set
# CONFIG_VIDEO_IMX258 is not set
# CONFIG_VIDEO_IMX274 is not set
# CONFIG_VIDEO_IMX290 is not set
# CONFIG_VIDEO_IMX319 is not set
# CONFIG_VIDEO_IMX355 is not set
# CONFIG_VIDEO_OV02A10 is not set
# CONFIG_VIDEO_OV2640 is not set
# CONFIG_VIDEO_OV2659 is not set
# CONFIG_VIDEO_OV2680 is not set
# CONFIG_VIDEO_OV2685 is not set
# CONFIG_VIDEO_OV2740 is not set
# CONFIG_VIDEO_OV5647 is not set
# CONFIG_VIDEO_OV5648 is not set
# CONFIG_VIDEO_OV6650 is not set
# CONFIG_VIDEO_OV5670 is not set
# CONFIG_VIDEO_OV5675 is not set
# CONFIG_VIDEO_OV5695 is not set
# CONFIG_VIDEO_OV7251 is not set
# CONFIG_VIDEO_OV772X is not set
# CONFIG_VIDEO_OV7640 is not set
# CONFIG_VIDEO_OV7670 is not set
# CONFIG_VIDEO_OV7740 is not set
# CONFIG_VIDEO_OV8856 is not set
# CONFIG_VIDEO_OV8865 is not set
# CONFIG_VIDEO_OV9640 is not set
# CONFIG_VIDEO_OV9650 is not set
# CONFIG_VIDEO_OV9734 is not set
# CONFIG_VIDEO_OV13858 is not set
# CONFIG_VIDEO_VS6624 is not set
# CONFIG_VIDEO_MT9M001 is not set
# CONFIG_VIDEO_MT9M032 is not set
# CONFIG_VIDEO_MT9M111 is not set
# CONFIG_VIDEO_MT9P031 is not set
# CONFIG_VIDEO_MT9T001 is not set
# CONFIG_VIDEO_MT9T112 is not set
# CONFIG_VIDEO_MT9V011 is not set
# CONFIG_VIDEO_MT9V032 is not set
# CONFIG_VIDEO_MT9V111 is not set
# CONFIG_VIDEO_SR030PC30 is not set
# CONFIG_VIDEO_NOON010PC30 is not set
# CONFIG_VIDEO_M5MOLS is not set
# CONFIG_VIDEO_RDACM20 is not set
# CONFIG_VIDEO_RDACM21 is not set
# CONFIG_VIDEO_RJ54N1 is not set
# CONFIG_VIDEO_S5K6AA is not set
# CONFIG_VIDEO_S5K6A3 is not set
# CONFIG_VIDEO_S5K4ECGX is not set
# CONFIG_VIDEO_S5K5BAF is not set
# CONFIG_VIDEO_CCS is not set
# CONFIG_VIDEO_ET8EK8 is not set
# CONFIG_VIDEO_S5C73M3 is not set
# end of Camera sensor devices

#
# Lens drivers
#
# CONFIG_VIDEO_AD5820 is not set
# CONFIG_VIDEO_AK7375 is not set
# CONFIG_VIDEO_DW9714 is not set
# CONFIG_VIDEO_DW9768 is not set
# CONFIG_VIDEO_DW9807_VCM is not set
# end of Lens drivers

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
# CONFIG_VIDEO_LM3560 is not set
# CONFIG_VIDEO_LM3646 is not set
# end of Flash devices

#
# SPI helper chips
#
# CONFIG_VIDEO_GS1662 is not set
# end of SPI helper chips

#
# Media SPI Adapters
#
CONFIG_CXD2880_SPI_DRV=m
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_MSI001=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_MXL301RF=m
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_TDA18271C2DD=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_MT312=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
CONFIG_DVB_S5H1432=m
CONFIG_DVB_DRXD=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
CONFIG_DVB_DIB9000=m
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_RTL2832_SDR=m
CONFIG_DVB_SI2168=m
CONFIG_DVB_ZD1301_DEMOD=m
CONFIG_DVB_CXD2880=m

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_S5H1411=m
CONFIG_DVB_MXL692=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=m
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m
CONFIG_DVB_MN88443X=m

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
CONFIG_DVB_LNBH25=m
CONFIG_DVB_LNBH29=m
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
CONFIG_DVB_LGS8GL5=m
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m
CONFIG_DVB_HORUS3A=m
CONFIG_DVB_ASCOT2E=m
CONFIG_DVB_HELENE=m

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m
CONFIG_DVB_SP2=m
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set
# end of Media ancillary drivers

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_MM is not set
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT=y
CONFIG_DRM_I915_GVT_KVMGT=m

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

CONFIG_DRM_VGEM=y
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
CONFIG_DRM_GMA500=m
CONFIG_DRM_GMA600=y
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_QXL=m
CONFIG_DRM_BOCHS=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_XEN is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_EXPORT_FOR_TESTS=y
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_XEN_FBDEV_FRONTEND is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
CONFIG_HID_CHICONY=m
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=m
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_PLAYSTATION is not set
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=m
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_CDNS_SUPPORT is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_CH341 is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CP210X is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
# CONFIG_USB_SERIAL_GARMIN is not set
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_IUU is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_METRO is not set
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
# CONFIG_USB_SERIAL_MXUPORT is not set
# CONFIG_USB_SERIAL_NAVMAN is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_OTI6858 is not set
# CONFIG_USB_SERIAL_QCAUX is not set
# CONFIG_USB_SERIAL_QUALCOMM is not set
# CONFIG_USB_SERIAL_SPCP8X5 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
# CONFIG_USB_SERIAL_SYMBOL is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_XSENS_MT is not set
# CONFIG_USB_SERIAL_WISHBONE is not set
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_UPD78F0730 is not set
# CONFIG_USB_SERIAL_XR is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
# CONFIG_USB_ATM is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_STUSB160X is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_REALTEK_PCI is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# Flash and Torch LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# LED Blink
#
# CONFIG_LEDS_BLINK is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=m
CONFIG_EDAC_GHES=y
CONFIG_EDAC_AMD64=m
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
# CONFIG_EDAC_IGEN6 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
# CONFIG_INTEL_IDXD is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_XILINX_ZYNQMP_DPDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# end of DMABUF options

CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_UIO_HV_GENERIC=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_VFIO_MDEV_DEVICE=m
CONFIG_IRQ_BYPASS_MANAGER=y
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
CONFIG_VIRTIO_MEM=m
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
# CONFIG_XEN_BALLOON is not set
CONFIG_XEN_DEV_EVTCHN=m
# CONFIG_XEN_BACKEND is not set
CONFIG_XENFS=m
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
# CONFIG_XEN_PVCALLS_FRONTEND is not set
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
# CONFIG_XEN_UNPOPULATED_ALLOC is not set
# end of Xen driver support

# CONFIG_GREYBUS is not set
CONFIG_STAGING=y
# CONFIG_PRISM2_USB is not set
# CONFIG_COMEDI is not set
# CONFIG_RTL8192U is not set
# CONFIG_RTLLIB is not set
# CONFIG_RTL8723BS is not set
# CONFIG_R8712U is not set
# CONFIG_R8188EU is not set
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set
# CONFIG_FB_SM750 is not set
# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_ASHMEM is not set
# end of Android

# CONFIG_LTE_GDM724X is not set
# CONFIG_FIREWIRE_SERIAL is not set
# CONFIG_GS_FPGABOOT is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_FB_TFT is not set
# CONFIG_KS7010 is not set
# CONFIG_PI433 is not set

#
# Gasket devices
#
# CONFIG_STAGING_GASKET_FRAMEWORK is not set
# end of Gasket devices

# CONFIG_FIELDBUS_DEV is not set
# CONFIG_KPC2000 is not set
# CONFIG_QLGE is not set
# CONFIG_WIMAX is not set
# CONFIG_WFX is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_HUAWEI_WMI is not set
# CONFIG_UV_SYSFS is not set
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_XIAOMI_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMC is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
CONFIG_HP_WIRELESS=m
CONFIG_HP_WMI=m
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_INTEL_ATOMISP2_PM is not set
CONFIG_INTEL_HID_EVENT=m
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_MENLOW is not set
CONFIG_INTEL_OAKTRAIL=m
CONFIG_INTEL_VBTN=m
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_I2C_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_IPS=m
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
CONFIG_INTEL_PMC_CORE=m
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_MLXREG_IO is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_HAVE_CLK=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_XILINX_VCU is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
CONFIG_IOMMU_IO_PGTABLE=y
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=m
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
# CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON is not set
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_EPF is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_USB_LGM_PHY is not set
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_DTPM is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_DEV_DAX_PMEM_COMPAT=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
CONFIG_STM=m
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_ONLINE_REPAIR is not set
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFS_V4_2_READ_PLUS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_NFS_V4_2_SSC_HELPER=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_WEAK_PW_HASH=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_WRITABLE_HOOKS=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_SECURITY_NETWORK_XFRM=y
# CONFIG_SECURITY_PATH is not set
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
# CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=9
CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=256
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
CONFIG_IMA_WRITE_POLICY=y
CONFIG_IMA_READ_POLICY=y
CONFIG_IMA_APPRAISE=y
CONFIG_IMA_ARCH_POLICY=y
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
# CONFIG_IMA_APPRAISE_MODSIG is not set
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=y
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=m
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_BLAKE2B=m
# CONFIG_CRYPTO_BLAKE2S is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_POLY1305_X86_64=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_DES3_EDE_X86_64=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CHACHA20_X86_64=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
# CONFIG_CRYPTO_LIB_BLAKE2S is not set
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=m
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
# CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
CONFIG_CRYPTO_DEV_NITROX=m
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
# CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=m
CONFIG_PRIME_NUMBERS=m
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
CONFIG_DMA_COHERENT_POOL=y
# CONFIG_DMA_API_DEBUG is not set
CONFIG_DMA_MAP_BENCHMARK=y
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_REDUCED is not set
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
CONFIG_DEBUG_INFO_BTF=y
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_DEBUG_INFO_BTF_MODULES=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_32B is not set
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set
CONFIG_DEBUG_PREEMPT=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=m
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
CONFIG_TRACE_PREEMPT_TOGGLE=y
CONFIG_IRQSOFF_TRACER=y
CONFIG_PREEMPT_TRACER=y
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
CONFIG_PREEMPTIRQ_DELAY_TEST=m
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_SAMPLES=y
# CONFIG_SAMPLE_AUXDISPLAY is not set
# CONFIG_SAMPLE_TRACE_EVENTS is not set
CONFIG_SAMPLE_TRACE_PRINTK=m
CONFIG_SAMPLE_FTRACE_DIRECT=m
# CONFIG_SAMPLE_TRACE_ARRAY is not set
# CONFIG_SAMPLE_KOBJECT is not set
# CONFIG_SAMPLE_KPROBES is not set
# CONFIG_SAMPLE_HW_BREAKPOINT is not set
# CONFIG_SAMPLE_KFIFO is not set
# CONFIG_SAMPLE_LIVEPATCH is not set
# CONFIG_SAMPLE_CONFIGFS is not set
# CONFIG_SAMPLE_VFIO_MDEV_MTTY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
# CONFIG_SAMPLE_VFIO_MDEV_MBOCHS is not set
# CONFIG_SAMPLE_WATCHDOG is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# CONFIG_UNWINDER_GUESS is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_LKDTM=y
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_STRSCPY=m
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_BITOPS=m
CONFIG_TEST_VMALLOC=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
CONFIG_TEST_BLACKHOLE_DEV=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=m
CONFIG_TEST_SYSCTL=y
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
CONFIG_TEST_LIVEPATCH=m
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
CONFIG_TEST_HMM=m
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--eqp4TxRxnD4KrmFZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='kernel-selftests'
	export testcase='kernel-selftests'
	export category='functional'
	export kconfig='x86_64-rhel-8.3-kselftests'
	export job_origin='kernel-selftests-bm.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-skl-d06'
	export tbox_group='lkp-skl-d06'
	export submit_id='607dc6b5b5388d5844003d9e'
	export job_file='/lkp/jobs/scheduled/lkp-skl-d06/kernel-selftests-net-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-6628ddfec7580882f11fdc5c194a8ea781fdadfa-20210420-22596-1xcbswy-21.yaml'
	export id='d1ed35df109a8f60241f5f0659a359b941ceeafc'
	export queuer_version='/lkp-src'
	export model='Skylake'
	export nr_cpu=4
	export memory='16G'
	export nr_ssd_partitions=1
	export nr_hdd_partitions=4
	export hdd_partitions='/dev/disk/by-id/ata-WDC_WD10EARS-00Y5B1_WD-WCAV5F059074-part*'
	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSC2BB012T4_BTWD422402M81P2GGN-part2'
	export rootfs_partition='/dev/disk/by-id/ata-INTEL_SSDSC2BB012T4_BTWD422402M81P2GGN-part1'
	export brand='Intel(R) Xeon(R) CPU E3-1225 v5 @ 3.30GHz'
	export commit='6628ddfec7580882f11fdc5c194a8ea781fdadfa'
	export need_kconfig_hw='CONFIG_E1000E=y
CONFIG_SATA_AHCI'
	export ucode='0xe2'
	export need_linux_headers=true
	export need_linux_selftests=true
	export need_kselftests=true
	export need_kconfig='CONFIG_USER_NS=y
CONFIG_BPF_SYSCALL=y
CONFIG_TEST_BPF=m
CONFIG_NUMA=y ~ ">= v5.6-rc1"
CONFIG_NET_VRF=y ~ ">= v4.3-rc1"
CONFIG_NET_L3_MASTER_DEV=y ~ ">= v4.4-rc1"
CONFIG_IPV6=y
CONFIG_IPV6_MULTIPLE_TABLES=y
CONFIG_VETH=y
CONFIG_NET_IPVTI=m
CONFIG_IPV6_VTI=m
CONFIG_DUMMY=y
CONFIG_BRIDGE=y
CONFIG_VLAN_8021Q=y
CONFIG_IFB=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_NF_CONNTRACK=m
CONFIG_NF_NAT=m ~ ">= v5.1-rc1"
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP_NF_NAT=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_IPV6=y ~ ">= v4.17-rc1"
CONFIG_NF_TABLES_IPV4=y ~ ">= v4.17-rc1"
CONFIG_NFT_CHAIN_NAT_IPV6=m ~ "<= v5.0"
CONFIG_NFT_CHAIN_NAT_IPV4=m ~ "<= v5.0"
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_ETF=m ~ ">= v4.19-rc1"
CONFIG_NET_SCH_NETEM=y
CONFIG_TEST_BLACKHOLE_DEV=m ~ ">= v5.3-rc1"
CONFIG_KALLSYMS=y
CONFIG_BAREUDP=m ~ ">= v5.7-rc1"
CONFIG_MPLS_ROUTING=m ~ ">= v4.1-rc1"
CONFIG_MPLS_IPTUNNEL=m ~ ">= v4.3-rc1"
CONFIG_NET_SCH_INGRESS=y ~ ">= v4.19-rc1"
CONFIG_NET_CLS_FLOWER=m ~ ">= v4.2-rc1"
CONFIG_NET_ACT_TUNNEL_KEY=m ~ ">= v4.9-rc1"
CONFIG_NET_ACT_MIRRED=m ~ ">= v5.11-rc1"'
	export enqueue_time='2021-04-20 02:06:45 +0800'
	export _id='607dc6b5b5388d5844003d9e'
	export _rt='/result/kernel-selftests/net-ucode=0xe2/lkp-skl-d06/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/6628ddfec7580882f11fdc5c194a8ea781fdadfa'
	export user='lkp'
	export compiler='gcc-9'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='e242eeab609680685a735f61f42eda2902d346fd'
	export base_commit='d434405aaab7d0ebc516b68a8fc4100922d7f5ef'
	export branch='linus/master'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export result_root='/result/kernel-selftests/net-ucode=0xe2/lkp-skl-d06/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/6628ddfec7580882f11fdc5c194a8ea781fdadfa/21'
	export scheduler_version='/lkp/lkp/.src-20210419-111420'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-skl-d06/kernel-selftests-net-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-6628ddfec7580882f11fdc5c194a8ea781fdadfa-20210420-22596-1xcbswy-21.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3-kselftests
branch=linus/master
commit=6628ddfec7580882f11fdc5c194a8ea781fdadfa
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/6628ddfec7580882f11fdc5c194a8ea781fdadfa/vmlinuz-5.12.0-rc6-00349-g6628ddfec758
max_uptime=2100
RESULT_ROOT=/result/kernel-selftests/net-ucode=0xe2/lkp-skl-d06/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/6628ddfec7580882f11fdc5c194a8ea781fdadfa/21
LKP_SERVER=internal-lkp-server
nokaslr
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/6628ddfec7580882f11fdc5c194a8ea781fdadfa/modules.cgz'
	export linux_headers_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/6628ddfec7580882f11fdc5c194a8ea781fdadfa/linux-headers.cgz'
	export linux_selftests_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/6628ddfec7580882f11fdc5c194a8ea781fdadfa/linux-selftests.cgz'
	export kselftests_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/6628ddfec7580882f11fdc5c194a8ea781fdadfa/kselftests.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/kernel-selftests_20210406.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/kernel-selftests-x86_64-cf9ae1bd-1_20210401.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20210222.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.12.0-rc6-00349-g6628ddfec758'
	export repeat_to=22
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/6628ddfec7580882f11fdc5c194a8ea781fdadfa/vmlinuz-5.12.0-rc6-00349-g6628ddfec758'
	export dequeue_time='2021-04-20 02:09:41 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-skl-d06/kernel-selftests-net-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-6628ddfec7580882f11fdc5c194a8ea781fdadfa-20210420-22596-1xcbswy-21.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test group='net' $LKP_SRC/tests/wrapper kernel-selftests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env group='net' $LKP_SRC/stats/wrapper kernel-selftests
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time kernel-selftests.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--eqp4TxRxnD4KrmFZ
Content-Type: application/x-xz
Content-Disposition: attachment; filename="kmsg.xz"
Content-Transfer-Encoding: base64

/Td6WFoAAATm1rRGAgAhARYAAAB0L+Wj5vJ34UhdADWZSqugAxvb4nJgTnLkWq7GiE5NSjeI
iOUi9aLumK5uQor8WvJOGrz5sBfYW+9jUYWrnfX8GdlPOLfWrQJlRboG4a+8jUbMgqAae2pT
4LhhVufBrfDJwINgPVB4rO3Q3N1VH0Sn6X8fscXduXXxBV0Bkh5Erz7zufkRl/tVrdO3rXit
N+DkNDKj08wnPcbKstRhbVKWB3D0mI/EJ+0dj1ugB/hR9u+6fHK1EfOiFmo/C9kyEZpDc1Ju
3ciH8zMF0w3jyd2TN4IOsR0oc6Gm72bfJMPtVd2Hl8cUXw+YMvVNzVZaO1XBvu/obkrIUacO
M4AI7G7n2Y4afIx4e2alaq5iHNFscKZXERpgyMBjwYKgrhUgMcXi/OAmEjUhodUq4zc0qO+B
NoflMsEEVNjVUMjgVoyYmnzIn+gh6RZ5q/VIIBgR5gZJPhVk+JmaMdKIFPT3+wF6FQMhQx0y
qILMOnn2a6QARLxCkXGWxmHAht4Bs/4xek1d8SBpYF+ipeXI8MD5PaXvW0sEdcuiv5uJ1/o2
N8N6UWbuOWQrMQ3ArWctYrSl2WH/3XqClGgyrjYy20tkaY79db4+3srGLNW4Tpz0ziQrqWs6
PAv/lZaqhiYxuH1SGyjQHEPz+pXM48QsgYjP6j79v4Gc7f0IrEXvAUZuBqCr17CRuQo94bbX
LXpzk1VXLQFsR0LXtQ/Ts1knjjeHBsskF7oj9U9GGFHrK/7IOJTQyGGMFl/p7YZv/gZDMfJ8
eeSXdVUy+xzp6x8g5x+XE/awa10ErZcrhn3ygrQHB964iAucFUXvFG2Ko9F4ecORlAKtB0Tz
yymZZVcDVlbiNl/qHMcZieJun5Eu8ZQXpGryPjTso+8LWq0bM82U0aMiLYAxgtyBfu0EY1HE
/HsJfmBJgeDHs8U8I5m043Wjev10AfEbiFp+ZpB5AqpXv4rx9v/pXr/7VCvOfoRFFBcfek5t
PnwygJndmALE4mSnJLxIcDQHU6p9IzDMpRgf8eCxLf7rGXQezNDBz8jNWpg+xUKf+9q+eRfi
AouiY5+wCmxZ8tE8RTrTMRgV5CP3CHH/XlWPpFMCcc/GQI2dCyB2KWrLVEHOhJIWIulsR5Kr
KJv72Za3KuiWxwYwJ0uPhac/5+AzGLxSIdWTGWpN1gsQYKGyQUDAoUcWTklcakEedj8NAcBm
/8X9nOVQwCuQiqGkVcdRI6OW4Ep+K1AQpsVJTWiM/xvVTUEicSjodQtdSOMV7OvjOrRo1ltU
nmSV/4TCXe1TQxvwOixEZov53zWokebMP7/gf45kNnhvnSQGtEIfmXZ1gvOmt+PonVabDUvE
3Lgb92JfIQZRZnS8Awn5+hN/IUK6uIGJ9fgtXucyuLunmF1M5UvAvJ4z8BWhPrFKxcjFSTdA
k7ALJho7FT7cqMSfo26zRcuBSyw6QmYxBMEkUFsa3c3GT6YamBh25o6lvgNg0TBhC8STRARz
Wnmi2U9x03pbhiNqs8TSzcygNsuHtleYKhYWo33r6vork6Ui43PC+IKqvG7FjyOU3LZ+jqjG
6Brqb8xmYgN9D6YY7rBSYAnSj3H6igkI9pT4bAeI+/tUGUilqBAPasCFWr7lsjhUm+82fsmu
WdbWJv6eRZ9Gh4/2FPvPa6K5RX6sECFfs3DDAtDyf4xPLaUhw/48QsVAzZstPBo2uC9U2WGd
pghZb9cVnxLvFwM8lQMyI2Ppn5ooqtxsSsz+OCORYhD4ZAOJAGHcTT+mTPIKqti6+/gzyu2c
2skpI8oOGeWwQBlGIJtaetU99l9f3b5w+iyRfyapqduaeZg/sY6zq3/l2QXPNbenCVR/lic2
BuIUoTVhO60qa12CFnglZCKXYPPTV0lcRU8ksiR7Mc5K0eXFPelNXj2v6OGVjypov7It6bjB
coiQ2irBF15Mc4Ss5kCKCJJgSqoqEyqFM38b0VFjTiRDwG+j0A1UMtstj8LXnrLAvDvsDX5a
B14b8dDcdzQGN1hEiP3I3plUHBfeJPYdYZbmhxPQsN3h7XYrAg2YKYe9WdTn8YKjoUBv5EtV
amYbgcmObpbSgA72hpMUbRb3i3Q9h0jK9vWKfR0xG4koYF7tSgkHHSd+VZCUgJiisGut7mzc
ACcUudQ1GFCVkRwSqcyp9uY8go6vnrmrAUrKPxehaKV5/mHvT8ZGGEo+HZBTcth/9P8aP/hT
6gQLPHFk+giVFhUCncIoP90h2FB97cPU5hoYUGCqOp7FA/dnbyMULOdoNgfX+cwyQo76MnPN
N3851PxtK/tFTDBxMaMZxJ9k247c9m0I1qTM/huETzJoK4OkWM2IiK1YvyMhUUupX20Y/Sh5
H5dEWGO8wvBdOmYEtrwWAHrEUHaZVu8Q/lCcvOb+jgwErfqNP50T+/CI4i4SEJcXon4MHCeZ
YY1pJmqz7l5pl6P4+ULHhAljfMETS1SZCAimXhtcsrp5SikZy7RBwSM0a4HG4xtgTgFMEhj2
bqrDVqBrQRXMU4pg9U8VpMwTYD47aVh8GY/+gimSypCCSt/UstbNfheov55HMds/51ZcNf1S
LLI2xGai7Yjz2FxoGGcbmhEDMhB+lk2A6nj2BuepkNSqobWWItTO9qDspuZHIyids+QgV+Qi
80jbOV+2xXUI15pd+X2AdjUss0AU+H0jfCBzn4NCHgGfxZf4Ok6r62P5eAcWVHDR6oQQbXUF
JEf2EMe3TWrcz6lyX8qkFkKEy1SFPpTdpXouS1wm9jeNXJJgRT4JMAtC+7zh6k1LH350+A/F
2mbbXtKsjQ8qOm47UnOzGGkzd7zwHUvy1AQduQYzwA9s4+OW2EhVzo423XZ3K51MoF7MOOPz
wuitaVFqJweEltZvHtiY7+QQUmeA32PBwd31KKtM4bTq4ARBfxMnbkVxyu5g6XV/TH6T6f9U
aNiUNVQAoctSj0BjL2tJdQA5SZw86dh1lvaNpeue5pTZ5RF6qSWXCQNbHppr4RRH+JvVXt4F
U2SvoHrn/uJH/ZNdhlv07hKPgRfdYKOiQ7NYdXBedsV4huJfK6dxxICBsazrT7s7+AZQJbJ1
E/fzY6q4QvBT/kc5VjnB4Rxig2cnQs9z3QBGQg88BPZMH+x1pNWobhxbcrteZ/fkSnnQc96B
PAT8uq12R+oi1CmwPJqL1TuKGAGtMTLUsZdGQxQdOPT1ibVhaIDeJvFJWudkZe9e9GumuSmO
vj6ysFXQIdECYXG2QD0ApCA6PU7sGdJxhQuL5PDJC40nBt15vifgrvXUY57FHU3hlBQcHwtV
y+H913Q7h680qfV9J0FcpprN5YVpNNj5MOZT8zKWTYx60zxDWCmg6rdEm6BoMLuoSPJMaWBV
nox1DPVe6Owxf+zJdvnD6dFKbAaFgC7IOpGF983bFDx2QIdxbEUDh0ITvYgEfK8RuoqJcx3b
jC7IjnZngEvacplU9b+9JUCDiimZrucdy+HByya87hqvqfXDkgRRsRv+7iknzaCSV/aKd3uo
46sEOaS/ywRcyD9eO3E8ETWNWGwrZdjyeOKch7pMWnlUpzeZoiJHq2EEVdGU+qTdqB03Gz8r
q9WQdKvQ+tV/YxiwWxV/5wWasfSin8/kmnO9xjkmFSPygpOzKD6HKTzvUEdjmx4BG9HlBpMt
vY1EBuXBXiwJpeZgF/7VLy2V3Ge+1Rz64/wHOJJv9PA/8lNHMbCNT1yK7XTEuPyUBMh+0GZS
VZgfSqCjVFpKX53zIc0iT+uJwoMJyQPdUz2jOjqoukyhVLRwikqel6YZDlyLEQJe7FJYx7BZ
er72AdBRRS9U9EdMcLxJOjSTgXOpmEDC2rAHxLIoszSyKSrLvsFJJs1jixLGrQBRWK19jlR0
Rr+1jNiEB1UO7UwZJeh6XYT7BfxjjKt5NbnUu8c3zkbX2xAuqtXgCaHZWbQHSTGy7kFM5VvA
jo0+AjotoBSjOssgPadeO9dtA49ZhChozbabV0ROGnuv/nnXNZufATtAgKlKIy1bLrnycklX
me7ZsV+Y05aAscrVdpqdrMaBmbSI8ef4WvMNmspQdGxY2Y44IbrUWKw7AmOKP4M2XLdV6Nbj
OwJIEOPOXqC4eVmm5iaiaH03sMyiC1+xM0FTg4TnzwRjiiYyljLDWvhcv7Bo2M/QoKZwUh3y
BJuwwgzXxw1MTr40OsbiZUC7VFrX4fFuK+LmYHZM1biEYpKdKk1NTlE7lgK4+etMDUpnclkd
voI+IyIaYB4kx82aZEw928xwWHidRiD0OjiJM/WtSmdkRUSXpfpwQLeLDQZCufF95kys9Uhg
V6bmI7KwF+uDenoknM82h4MskFkR66zWwSyguXVrFcbPbQU1JLYqYG+xxKWFTteGWf05Q/w3
uOs8QM2lggUt6bkyzEoYJWVn49SvXEW2XTtNuCCE7jRepd4fZUp7XnpTaXGE3p4vsQNRIvyk
8k2s1l2mLCsF8k5CDsMH5enNzu4nJw6Kq9SWwXhbBKV5qvCLwQYtrBpSAbuszzPW4zNX10xI
VAk7AzZ8l92rDBA6+At8mHTlVsam4Nb+B4ui798QMYUH0s2sppiF6nfFys6r46ec6By6+b0n
liWNdXFE60qShhxMDj0jJEMOp+zjrULfAebYOkWAk7bG2ao6m9A466slUqKXZ3IbWm9pkiFH
tGpagt2F6wIFOgjUncvacUG0gF5N018Tew1iMEOpnVbWzg7Dk+e8G2cUuOEpj49JS9b9vT1t
vbm9srFB/tt865LVK+epbNTYgX0eTctnQgxvBp+VXoeHySTR04OWwU7H6Z/QWJSEA89gBNV2
cP0HlNGi6d/ganiuuMD23MdaQd+GOymJARZ0EKgwAfjzljSCi6x9AvsW9+3vyvcRBafVO4Z+
vLN/KzF1KIHiVbLSPRk0XxiT8AX+f82i2hkRr46GEpPKNG5bdK1y61weFGXpNuQB/ZkWZZQt
ioqY5tFtt24WXDLCDUi3EqTVEiIGK7MCnWeI5B7eMhdiGQBVuNRBiCJTrNRlL4ExjkDQoo6C
+Ibyiq1316nIsFcnXRaWxhcUrLfRY9YynlG1lbAcj3zODyTdQFNTfHgi7TT484WRMRGvG+9/
l+o+MCwJVblAahx9z4/lVIoDLFnCXDJ37E7+4aHFNbomxOvZkbaii26aAqnPr4guWO1tSthK
JyEKyhygg3WejSzkEBSm9R+va/GN6gywaZBLKc7kMXhsXNNOAs/Uod3Kg90ggsK3HmPNx6pq
8NTdGCswZvfOyfxKgVt/wv1lZW+HjwIJEmaCD7wts0vxCPFb2EXhcaFjuTYv05iwdtVXXmC/
oTM6zmKxtGtCj+qLYJl0hOK30vNZfnQguVhDxi6Qji9RzndcLWIqXqL/ep1h1d16SRellGl8
JK6NQCc5bMo2lhG4U4n4WQ3dyqeqj1eJO52cfGPr/ZcC8bwH4PBH18KOd8t4dDlLRD85RN9G
q/DZzqrQL4IP2mWkg6BJQ+IZtD0DhZ6SgDZ7wh42YwZAlG31ATX2R1kAoWVmk6Iyit8qUH+X
SwuLJj2IxlaKzyZSo1AmwNaywc9PEXvF4qwbT6jzFxMJ3n07/RLVl96GeK/GXVwbAtursHzN
tUCbpleZDD0qVZRtsjQdEuP2XyWYKFvken/jR8AS28YLJrB6CiKKc+yt/HTsqKziGi0hMF+7
iTQwo6Ie5+kJPH5MYXM2ebic0LC6LGrLoMvwl/JmDJ5Sg/ImlJ40MDjjOjZXqaVl/pOdTKIe
MamTmBgfgjosLrMzy36VNp+hV7+XfqsUTFFVkxSk3hNAYTf+7kl3TCqROT45So7zWmrznI5b
YPyFiURKTSTWEk0NZ1fVDJ9hUPLZWiks36CWMytO0E+aC0b3ylYrah9sYSroNmugE/MZ5Jxl
Syt69hdKbtGVjA1qDAnS//5uO7sB/66gGKMYd5HYtpSa46e0kqS2HDpD9Znfe+vtT9B9IyR5
J3K+bV/p+rPCSy0ySUdQz8CdglttoQoSdyf6TUp8PZlxUIYIcYo395BR+Brs7w2n307pJ0R5
odVWjKEPdGMGV21bNFWa3H+AeBy9WG7znRU7Iztfcs9t9wwaQ9+8uyaAUitR1lZhJ2X/Hpy6
pgUPnHtUL2OL5WKjF0/kBnuM5acqhZyDVDgPMy+yDzq/87mcuZUb/Pl7ZEEi0MVP1t41ST5L
+tTN6bG1u1ZwxcU/6PtKYBtiUDPG0cZ0cS8WfR4Ncjp2IM5wzAkjyZH5i6+KRWQb4mXGV7iC
kZt10BrJmsrldgldffXSzR9UXF9ZHfQkadBDj892iFU1XgithLOBEW2EUOQj1lyqnFCd96CN
h9ku2ZiHbmdiB5XJEJR1ZY9zd6mcj/8Vzl3I0qtAj846KiPqbOZWCr6MC679ciIax4yW7C8z
E1MNZc88anquKbPiu+PKaIb/WG4VrAbqK+SRZdopbo7xTN/MLpKxxVTSKn3QOKBjTHLbQOrs
+Amqi+FgKMgKpNT6QXVQLTtBSVv1maQccEPrNEPjMGxZrxemFu05fbP2wU9myiReACwzOBra
n3J362khxMtlhwPlcQFtPf4HGQDnX0Gl4Vd1GmstZtOv22a7S5ol8tVX28KTqfWAu8UG/0zr
3Mkk/4fIBw0ilGBvkO+iIzgyLTOezKY6QxfyeiD+5yrhdp59ODYJsulfT3Uor4q7KflQY/UG
hpKK6JS4DncDmG3PNlH2UwV3nTvKDAEvfnL+uM4RlHGEN/6NYL0MT0Z9d9owqoHQux+nhqSg
gin+L5WNu/c/L/CbaH4qU+LFX+Wk8oLAwG4s8yGA3NePyxW+oH38JbQK6tvENYcSMi2aeH9q
1KAM4cpOIaYGZeYQ7MlsSf/TcY2Cc/opHOYBrUEPGERxrTWpbhH6L3qiy+HTagCabOFoWBrb
ZEpBORxGC/4NkmBCTRHw58dKqA1oe3m2kyicZEyFRe7V+GfXZwoiz3AXCXii1Quo23ZWR2S/
ZcTUtofgcAIxMHCefhYg1kq1ODZmqRAu3cW/bT2fbfTFidcDkcKhovmV4hcOVwSN09yNvkEw
m7/SvsseNK5lRM9NRjszzOKnyYqbTz7E62RGi/k2CaR6YmbPdUwj+RX0+lcZqd+/I0/+nSGE
4gQO3iB5JeVvowiI48YijZZuNzN1eThqQnqn9Fq14ne3XJ66e+mA+RagHe+xsybWyTHbDUuw
/sib5plavnwkuNOgtbraQriS3N6DCrlU0yjPMDPzhx64LOJyJV9o6GOnKzQ9f5IGWmOYM+7p
COxr1X8HqiBFAdTlf5+yuqrchQgg7QLiw1kiJ+e6qKFRNadB0xtXMImu2U+Uty3h0izuYoXi
uQ5aCni8ov2gMddTHW3W7b7INEz1Knk+rLRySss7SNfPi4bi7GsPbWJQtTCHavrekZp0HeuX
+lv5eTLgIGihaGp8+8xSMD5AML1ydhkqQ3hyo1F+L5QnTADcyFETK4HgEqK7IX3yopXwuMXS
m942W+ZDwFHPLYKuTpbAfXrk8hIoEtiUvm6Jw/Y78MrWiHcizj5unir90d8adWkOG9+XBvHD
3cYy7mBFnL1VAdjmdcs3u2opjp9T29gJOPjdVmBrWYq8S/l859irzISiWhtL4uHXtFYAZJzC
txCJT2YN3lm+PqkfJnFMDA2eaAO3GyiFm6bAs55b805AY9BW3wIrm9VTHq37IlycxmI9D7rf
9yEo4Yn17iNruLuMs6lv5Vwg3eQwBLDpFPUN0W9EXGm1XB6Iqyf9BCPJOhsDXf+meZneKuui
goOIUG5W1W9DzMc7sGk3sUGo3GDqqt2YgEhpPvIiERdTQN6FQyTuOOUg/gVDs42WM9p5wfYR
u2x9JZT/1N7gUlH6hNJ4/fg09BGyG+MQKUrhogiGiHXI1Lutp0LuB8xsRvyOqvfoq4Z/DUcd
svs18glit5vzmitRAnXw+anL9QCcsfRN5tN6GlPPINQMlYKSvXyM9u9tkDWsCPNuc2ONfRtz
1590tynWSeqsapwt58tq3dNzodnp+UIENI1q3KY7ricxG2Fd+KDZi+7+Weiu2BNbOXKjNmkm
jLj3rwbIwLzXS6TgcQdG/Leca+xoPbrHzI0zpPvH8G6Gu8SxFmQB5bS7MgNSszMaS1u3KLqr
eXD0kBm+DASoQy8ccyEWw316cve6NKpLSSbwH5yI3+42CHAX+MburQBuVlvrsHIrZ6btyXOS
xEljGIif4a8hio6AOdLbulAe1oTN0aq9mjIrVRVX+GcDJAML7ftO4KppN97O6VomobHz8P7E
LUmoPs8BAZkXIbbq+rS9MrgEsToWXp5I5yyJJOjII/Jccaq8ClSQmb0p01yiv0U42Q6rREAb
+lJTS3r8PfAgsBGrg3hHlT0EWtVdqvX2EntS3glSQcPLMgNqUyFExjNDDPrMhtuRV0rfYR/t
7uTWi/e4e47aF1OqI/dRSHjDEsPGEqRKOUTqGOQGSUu7umEaTNvk8p3Y3D1zwoTRFFxFD5vb
VyW1g3BBbGurG7lndCzfA32QdqdLLRjBf+1f0zQUG4bKuSbjOYgxJ3NsSMFNM9TBNHgbQsUE
3xiWJydMQ/kSISt01d8Nb6KPLHaI9yVYlllOGurrwoOLo4bXeWV9xI6HuCo9R0Dkk282qaIA
KfbEnLWSVDemVqnZIEZ174i5kRR2wuE9NFg1H1P+aE/CefVHc+auOv2KtMzrq5zeMTlXpGgI
f0SrolkYQM4DoeYzLpdg+sSMfcJfzHEf78wi5KwydhgRYb22GsOwWvpDCh7HZJHu9/DaJuq8
7rR4r8jlA47aimaDyV6wDDDLSESd7be63FHSLixaodTSd2xuCsELG3WQZh268uf94sp+mvON
GOqvw8Wx5Tnzu2erVUFpC302SKegT8DAthBfuBjK2enqUtCEnZhkXrB+ybwkhujaDvYvBUjT
zOkB+lEuFtxfeLam4y99QMMxtd6rL6u7QGFdA9c6IpklXaoBHhqLIKyJ3vXVk77h4Pz1CFZd
EAVXup/kvOcUtvDgkGsMPnGdIpXO9mJpu9O0O1FZu13VfmgSPAVSMvZMgddThFEFG9b9ClgI
EM4ZjwMEeaKLeW269eVcO75kEYb84PF/FKW/4wWplvr/B8QtFqRR0R15vrZSFRmmckZ2qKBr
p9Fk/CQESyth2oDi816o5aE0f5wKhoobTWlZNLNtB5EWpKNswjbkTt6LwdcJpPbqsUy/WdGO
JG75qs7PG1ITUGXpZKdDaE6Go79k7M43MkybhZX/u3tnlp3exuLGLVW1SGP8pxFTJLjr/bCE
v7WnP5wSJJdhSxQPP2ORCjiR/ZOZ0vOVlDusa1ak9iEFEANcXxgSboytURIKDamWA5KAnR+Y
nCHqpsj1AgKUHxmYGLecbzj2eQRJu7kCEJZb9ksfbQ79eTPG/QYI9AgtYFaLaEoHgVymeVW5
Vt0TMY4/vfR7u9oungVDEIvkfaE0ffBU4F1VFSmOOw5ZFcUKWhDv1MeLV47IF6ysQ35+MShV
oRXT/VBFhSZZu9QPbu0O4GR5+za9Il+2caFKVcnzQDfsBd0mUfXibA8dAkXhqWuHchHg0lF+
U3m+vXD3LvxyG6gCbT5STpe1SaBqze9lqMhZtS3aJj4VOQzZm5d+OTzpQ5VDFduT6lEc2XdH
U/yJzwAEvC1n3xMP4VXHfSyBZeED/WRdICTlj1GhgbpHzkVAV8Lvd+H56BrANvSNv5rncnaM
/2ef+2Aij3aHjpVx9RYNxRhp6/rrQaCkcpJxxtJZMNY3vRBWjv0ahXHIVDEC8xa0MyCh07uN
oh9pDo1H8NUQLKFYusSYqe8UudGFJAv2XytQnIxqrlg/PJLwS8kipjTFgrE4alIxmGytUx/h
igDsQhvP7DBYZahtyR2/yKsltttC0wDbyBRMjg8F5ojjzg1QOHTawfC8HR4FoleZKgh2RREC
9Ki7lysMvsxyMwARVXMLzSJCfZkrE+S6p5AIdMncpAbHILAx6hca5MHpl6ZtWIRaGqsNVq3q
PLErg8/wEakD6jRg5hnF0C1ssSHD0zGRwBy5BRcQFVO+mZ/Y9Lel57zT4vDy48504x9YEIDI
i/bas6KYWJugdU+0UEG+YXa/XrQGTEUxV8I1t1Ptm7YEQ9UV3ROlsGQxpx+UExMM9Q21RZlx
DW8skJkA++GFfORGu6SSy053HARyvTBl0e6Zyjkas3UT4tFTaVUEdS7eBmz///teIaf/WExp
q1cjCrBtOBtX96rLfmwYLI7X4S5DueMpaCYoIQtIGUXY/jMrUz3R+am6TuObQZRYEu36Z4XE
c1DgXLzamX/l70QVOzw2ndb77ZeHxosZGNtI/Yf6ZHnvqd2Mt6HhhBBnJ460NtTCKbw5euZU
Gzplj3CCm3A1/qeiiQq5FKL58WxO2DSb6aKWlypCi7QixV56+PPK9QTWG2WSCgyLNB+Kf53T
xpNOnSmOjEkuPN65Fu5QH4NReBOxwxUNfbT4TzFezBIUNziTDHzsOUeBdtbtAaxO3gvGVBk+
Wfm2bzj5JlsKlJWa21spADJVdtZRIqRuJZMxxlLtmh71ZedErINa7M7+bdcS4U7Pig+yIJ+A
7O2yWvWd6M8Wm7EHucmXzHoXvfNmThX0Mt4KpZ4+NH9hUk2s81IoQ3uX+1umS/huZ9GyReYw
YwKVmieh11D0vabzYdumqU00D44w/mrwm9rTJ8PF26mX7Hu6Ij34vH2QmGdVBBiOewdCYd12
iI8D/X+lYbS0wojmgitkCNGTXcQMeonfbkTIShkQaKxIxPFkdlTcBXeQH8ElyaKlvEcS83pq
53aFPXqwxuagYOsBOwT7VeJ8Q9yeQYmVDe4NM8tdrStk2TFoVVCbQMXP7bhr68uBm/Yh3a8p
Ofh17JAnNfuQkKFNFutpWuQaEm8wdyoMV5XmKOncHksUPWczipBzaEOGdu/1IrS1MI5mHciM
vnRNnbgSa8xT7ZdujNpnB5w4fwaBRG/4dF9JGVSG1zeSndYmOrLP49Asn7HhiQR9MSNzNj5w
Fg+9rLgWkhjCBggcmvtnYQG35cDR8XziMcbDaNGPf0Ti7RwZ2BdJEdLM63XzqRVk0H6uOZYR
YgAwGiJbH2N0uW7RWg75+cXQlMwq+RSQrBNlLJFAQug5/YkcO7dtGp33TpaODF/IKst7GXem
xMcZHOpDOCOfrx5jbnhfkD0ayym+W+5LamA+VTHVJ9csmCEixsyEVDbQ8oiZjH72/Y/gtCmu
OW9i3gQLdnjiuAxNj6QvDSTsIoZwIceAkt1mhSoyIyTeSpczN0UqnRGtGQpQzWhu1kdGQ+de
tFLCWRk/TlhrGqCP2WoRRfP+OKNURl3frhfDrDDmwBHLrgJBhWKXufI4nr0GpKNKuXMISrbQ
0p1O6iykogV9jP3ir8bhVopAvLRQ938SagHi8Y6CF5l6zskMMX9nAECxdyzmgK8umEfmLDbK
ye1qRSrqfPyPK9x8nLBa7BhcbcHg3VDMaQg9B+/OuHHW5Jk0XuncLsG3X2XCwzB80Eop748n
uK6DxdHSqNhoS5s9HokoKSduCGNYeCX4DhNvp5GYt8zubbJDfCGN5ZdpS0wHFcZ8mx6svh7w
VtjHJyQ7ocRuPNdsaCR9Hsm0OsHzY2Wa8fFmLnQY6/zkX/fOPJMjUMt2OnIPFCOVfL8Clr1b
l2fidxBOBMOrEcvy1jzebIbReNnsPauxqO/IHvkcRir/5RSwvka3Qt4dwJQ0Ut5gE9s6NouD
VVJgCSpXtdLxA/j1tZZnFAOKtZQf4RcHEh04sTHcqG9XjdOTVHG7ESQA8TPBTxAFVghxPmL+
aIIAIGNAkkBCRmsv6TU161fEGbmtmcplu3+KPoAYTqNtFDee4Y/9OxjDP8qjxmQglJ2r5pt5
P252ilu0bQ0qqzKzCgKLDP5o4lPoWnyeo+dybQkp0SDN6fHjrogThMzAWK1cUArH8xS8+meb
7LB62pxEwee9RP8eh03B1E1cWz6BIeHh3N6casVEMeB+PrMk7ecXmKy4IxDlEnbfHuKEpM7e
srzzth6dl3dcnX9kV9NzRdOsNam6hDV7gmEegvWNPy1mYEgOP9GOyxbVK3if85yA6u4FTBqS
S0vXoIx4vvkd8y61meKJM9amN3tlwyt2bmcyhRhIcAIT0xb4jDbBnmbHXyoii8A2i8gai3lH
Vo0a/KHtnKUZ2EcBG017tdn9dDL1525qvz4zUZi/qZEKn07QQNBbzsPvQ1bBJ82BiODKWwKh
qakjob0IuwbpLAI3S7aHJEo9JEzFn6esAVf2RF5vGfLTS9hVQuUfE+1eTamp2EHkaReuFXBk
ZNhMF8bS3v/vztw4L7P3bNDNknKHYyXkHbFjJVkcSG2CfyNJMq/Il0y0SleUSvTwkhYrgWKe
DkywKySm4fOd4sYnbRBxeWAnyrJvHTVIRP3DOhM6uAT1nbNjdKoxSjsGXB9K1A9LQpSbFkWB
Yw7Fv09husMbwno+z4XQhqZxw+/0n1h3Tn8yRsbIBl6jwuWD/EFC4FqTvo1ZmDM+zE53BMfU
ZpXPHDdYqqdBAH4QLSEFZrMr5CIJ5Zu3LsRpjjC/AwYcU10VQGcULsmKL3KM7aGHBpFD74xH
Vh24IjN58N1hMLKqvV442kwhhbir+eWId5juPrueaCncSGYhbpLiO7eZGCmVfemZhHonSwc8
PqoghWwz/Wsnx07qrra0+R3Jm/yxGzHj9Fn6KGjjMX2L0+0rNjScPhwuEcSLIdUNwQWPozod
2XFnz3gOQ9XFIduK1T2TfEJgvm7th9fHfT1nEk2WiASsXbxcSiBQlfRcdRYIVV9K7s247B/x
mgBwXeU0NyG07RlzFITqtUujGVlNBehhF1LOITha0Zj2hdAv5csK+wdTjg8MbMizqhsXF8RS
Vyr2yOgtIw90psydAaSWnCVcBoMbSiEZcfXwN8rvxam1huUz0tEZCZSkdsPmP90QenZVxuB+
dp/SrhTmAT6IswADEO9qwICBdKLFpX+gKG33gg74XU9PmcuFqufaKOYXLdX5AlO9xadfJdvA
gPurqzwCF+YyBYPqIuHxkHgn+Ud/pd65AlayIPxkhB/JpB9fgzO1BCG18IRjLU1IwY+4RoBI
DlE8OlNLLuf9Up3QyoNv+J+mCMCJFsGukgSNTJE6Bs8Ch4EwGeBF7h1H5I6G4cUPxXaQiMfI
twJCd7I9kZkUdwLWy9Jlo/mwqtq8qYz2EjKalkYxHqEHT/Jkmch0/56qcynWOyuxdAdGa56m
mSPuIeTYeEDcor2pzxdu1wkBdahbk+OaZuOKgYYh6DDYJJ2G4Q8RgiAfkq5InIN5vcCwdCcD
0HMzlDw6nhPZmBM0khHLW4QB3b4Hs+z4rVuAavKLdMOfyAmvCQH/9le32kTmR1LG5WyrUfi6
ixtwifdtiJrRZESrJB4Xxo3NlasnVhadI7jYnCSJ6Pn19Sh/1ONcVJyNFXdWSw/NlZulQYLl
XIWXMY2TEX9Cz2GpVu1X3c6b8Ex57h9yqoSgpm+YJnIgtH2wef716hUQDkA6kHsWjHUPZyGK
XpGuz9mKAD+bDz8WmUy60lKDM9ifuaupgb/jbvVKEGG67XXfohoB+FUetw356X78GpCtuoSX
u0+fcOqyJwjE8Vq2dJ/kkZUvS01mUgId6en2vT4D/XxuJnj+ZUDBM6Ww1Bqrkd33xzqdF807
xVvpL9sJTf3EcfwuEdRr4abbTBYrFW7teVt5D7FbM4FqwlRBMLr4tADtvyG8J6Y5uqH0mpTN
+xtQeCbxagLUgHFPfQh1GLIetWZd7DPkV4aZR/3lE/ou+SZ2C9YmoPDdYj0og17sDwTNbDHu
xylWnvajR5dn2RBPnyPN6lgSUDIfYXffsdYzi10fVLQPb6ypYCMnpKVdlUlT1DnZe/fTmFVv
zU5Ib6zEID2UpZsUDY3uMx9KB8Vs5CwxnZdht2VM2fpSaXm5Tn/Nb78abwamv4Hi6ayF3tve
yRLJQfiGltCT9GPcUsDbAk9TVKcizxJvz6uJf7+vyLcoL5UnIy7AIUf04Vs0gu6Ud0qo7a+a
k//sQ6FVyVWj9jb63fj+vPmQR0htFui1avGjI3Q5A9r2OJzqGOVna7QbODQasRvQgb4GttdL
aEK29NWpsEHWrJe+D0nGVXeboA/nAZevfoUaR6AWcEjroaCoLLNKGHx1RVnmxLNL97ESuL8L
sX2AWGoLCpXjb2sk7u7M+xDkiCEnwOFQSQ4XRm4qy8RAaLANH1UIzoK1hdNHKhToWkWr/9Ui
IoDP+FTk4A2oOWcvY3Es6JilT+f2iYt/1Z+2tEd+FIgboFzY7XyK6ky9KE4jkFwZLkdWE4MD
1u1lUFo/nqEGcPe/fE73yV4HjeYfHg/d2CT7Wc4jXhEX++7fecJY092muVhPslv1F++sfv3D
bbvzT+My3qG7MbYXYYAwmHNkh4c1nfePJCkubFuRXrLTca5bH4/5BFXgpUcIZ6Q3CAljUwwL
HeiL4sj09HcqXkbPZdsDxLbUUUg1yoqdkMF0f0n407joCwklMexN3ededvUD8fKxpo1/MWji
27YSYFz3uX2VXRa6Y0ARyrFLfXL5bQL7JWV+LpqIeVmP8Tt8FLVsFObv7riFZwPMwheA7hmj
OslUcwyhVr7L/X2KLnfGbMevlJ2v8EZMa8DCOViNwUkHChxRTxSu3KTOfF+bzJSdil7MKKSu
Omv/ICGL8rpacmlRbr8IA6Nz5uMc9Iku+LIsd7whbx4FOx5BDTZk7BIFraBQKTdNhOf1JCye
mlWOZKeVqsSDW4aAdpWGv2fqvWjoFx58M+Okj54j3V1b5zJO7eyHhmWpSKYZ+1fY+jS+tYgS
Tk1C/dyYFEs3hd5PRFXu1XFOhnCRW55JImHea6pSZask8CmnZcmasIbBTXRBCz1JEEnSKVS4
dL+31WwKbboiqwWZkHO5tBZhExbrXVlVbBZdoL5bobPcsoNsHDLyA4nMTKUVNajHv3GcX5nS
vHkzdrFDenmOoKAQ/rzxCzlQzqeTHyy+A540eH+Ctdk7DoaWndZf/Mf69OVTZQzOkh/81pdw
wGhRPqocGODbu7T/xvGOD7VpJldesjbFHz+9xPaOL/nnfy7jg0/bMDujQXfuOR3IE+BgP5gh
WSRtp90P6MMvtJkv58nkMUp6A/L6IA0J2UY/QO+AZPcKqdlATYdJ3L0JaFtmZdWKSdEePfmq
JD2qtA4CAL+VtBNQLhj5Gc18pjyjvHSFktUtH2SVxAo+wRXTqmlS+EYZSFbwMaVhEDfXGE8L
4fiiOPkhgNkLNKyRVJb9hFDFJXNjyGyAUTWxXyJx3ppCxZFGqteEiIOjw/inhI2Zx+2DxLMt
W412hX7yZ8vUKeOcEgxvDH4mO/TGC53ZAsKIlyHuu/JUH+Z33WQuoxV2CdaS9M8rl93FNkD+
i4dqOAYw2Mb6J7oK8Itn9fsNaWgcQdnOKJ2JYXhbX1re2qetGdEzbG/l8+2lrm3Fju3WiH9b
tUulYYH4bvNMtYKgNub+KHaqHO8yb4Bq04XHwXyLgwp69xXTfyaVzcgjVW3vq3V+HS+HXZeo
xRJfmDuZDPCXGHm9y2hKy8GSBI0N3TU+jl9e4w7RTEd4c/Ciu3dDoEIEz1bgBMjdQgnE24wz
jn3m2I7RwJQCrsGup3z3dnt1l3OFqgQ252ktmcfzlccgvo7SAcvIM4hVtGWjlMXs8YO5oPi9
vk2OWn2KhaCMyLwxoHCi3u3ffwPwgFAp374iS20OhuWAr5o3xPo7Q2DTEsQUe81glN1rCYbL
0VOxF44CaFMClw55QMOQ9ykhcGOIY6QV8FMaeo9fVciNUSS1aNMtt73EuKiXNAsIo26P6il9
8OXFl86Qgj6dX8T+hcYrqK6NzzXouFVbTCRo0sR97QUPOwO1Rpy3ptWN4sjwDrJJ0g0pMtts
DMfHYxqII8+G+UAWTJJ6oqrZeCU3B1rVZt8/tT+VuWixtrbNqO+g6CgfAzK5vhf1WFJCgoTP
lN0eNvxK3X7zSNSKDunNeROcOVe9nGAk7Axtm1mgj8XHrpo5ZIz/H8nxXVKXpcDLQwafKQG+
M/igbA35X37rhADZC372kS9Y/mNZsbnQ/mebSNUEJQ6TnUmI68/oxZP8Rih1MGgNt5/9psfY
QusYFfjthTiYHWYJ3rB3Ck7LYhrhX1Y8mwixeJhbsrWngYRZlC2U/MxSIrBnBxEIxLrPXsAS
R8uXuy1BK8WLKOsiFCdlbdklzZ1CQI0EQuXtrYBuGMtdYfDE7xsfRmVU+zbNDWYQy278K7VC
WAia03SJikZFeeAeijb5zYlG0+gH2MsuewWHph5rrBAn9oRig0Rsqc90+kP1xEM2XVNhNY1S
WjP2bW7PZyMYwxHJ2o6fPYcqd/F7OGmk9wETwQhC/JXyEXZqxBSYGgwLFycMewmdIEzPSuNE
+fAxm+glcfD519XOnkwFNSjqmFpPwLOiubQoBxROTMMIyHxZGQ2XrT0cmr+uw7PglhnzbSZJ
8WHHSI5aSCaalHp/Pvlcd+6JoipI6breXAJ0EwYYNh/F9p+vPU3I4KejZBNqK/pqlh8vr5TM
CNuY9NlZZwZ37wIex+q6QqEcIJFfHMdb078DginJmKxhGIHSjCfMrPtzc5Xo3KNoRqKsOHkd
we2NjnPRlfFLYTQR8Zq6MI5593pmfCJHIUiwpKGTZb+yv0O5+WvzsVbx8bfbiVAdH2Ex+7wI
yPI57wdjcsHW4u7idEPHDS0j53w1wdsCHKMvJICuVm3zcECyYTlTRHm7KKZFvCscbFbyEacL
0fU/b9DPktvWdEMSEtaMM+4tTMfWdc7JBjFQRX5Jl+lEPb4BV+n+nxhnX0yUqkm6cdxjm5bB
0ES6vyIX1bwUFOfKmagG8IQ9a4q8ty9/mwIwLQdJNIySKJlpcgTeYocXoA40qJYEjtJDOr/w
ma39kQhOvVjyKIR0Zf1JJwiQ2nSW+fcp/kSorJha0sGPPzFvycq3sxwxWaMiV8dBjmRyZieJ
xq816EQAi3Ys5126PZVCKhyGqN+J9DVbLUJd8x5JrmNWBTtKBFYLxhjTJb4IQMHWA6clDDGi
epJUCcYC+HY4tcWlA592CV8bBVfNtxE7D9CIVV9r2e60ktyXefhkXIVQORaUjLM1srbHvCPd
q5Vdo42qpGQ2LnKfgIHEVYr0rTOxqpXvO40sB++QbR2bAQzbuWZ2iM03VYH6LbS/1AHQQuvQ
7PttC1GWYSc9TFYYZq4H6xhneWQ0StK0C6h6mkOZ/237j0Q3Q4QqvXuAO5LoTjRRUP25+kd8
To3srzBlH41Oy0SrQb6oPFcwfT1yHGl3bWXlZPJSdRdIgmeYsCjj0FcoSWZypAaTijlEEFTg
lleCwTlIMiLl1oKSvuNDHZ6uLmWgN/vN3UMJ6wvJ2dDOiOChShgzAL4bS8XYleftDWAUikfi
HoYMAsrPh0QOHA1427udUIxOiELy/Tn6PzV3eZtH0c0TU6pOBfuObrFrxYbnfnnmcktOQaPZ
EpvYPqhc4FKn9uwo4/O2E8EuVt0+CnWi9IdOx5cjQ27niZIxEd6p+DtX5nRcKWmMfOYyZLwC
dLWmyvIs6usorLBW5YVV70TyrzzozdVfK/nWcsW6vDufwRSyjZZGs9Li2FjdiFJ9weG9y+1+
+L6HGVjoYybKxmWAh3pCs/NeFeHgzN2kml+R4Daz1046AR7Vju+rLj6SbS8KiwW1gvSDlMWK
gmwBgV8S9i7KjtWVmn+fdesL8RmK7KHKUR/4YaYO1Dpp3tH9Nmt4lpoQa+sSSnuqGuJ1m1lK
99AzkUpmPqKvytnfTsbDsLtyZLMQPHJFRs3vRdxwkLd9wVO8jt2dh+iZNelaC2M+jvvShU96
CYDnE7QqpUChrAvckrGqU5TkSVmiq8huaNBu879q8fDzkGnb7IbltwQpOP/az85t1ZKXUzCL
4S3hMzkeXHqlDZg6iZx3VhvCrsJI5eudri8Oq0edtNnlXGB0YSUiHhm4q1qlIUG6AvNy3nfM
oHCWhNcUWUelF21Nl4cdvs+3VU9APkm0QbUJQmZ90uiPN5uppXEwVRuYHjM0VJKP6nMvV9VT
XBJtsKQHwSJB8EsCL+kblCCBaj7rnoLXXskCy57uwkKa03qKNgTR/dXkZv5dIMWajnLcCE/s
pPtbzzVQH4h2KDuLeAkSHAnz1DZ3tqza3reOAiEfI0ZZR1FrGADHRfTaKzlr8CRl61odT5Av
utWD4I65aA2k6TF9XoXmBmZb5BiBxAOeWJUkSHbHH1ksWu2RROBLh7PPN68EQfnqSbpWmVXF
VUkcuzKUqq8ccNYqnmvxqOVkHzNM49ZQHfeEPNtECqjdNrkjKpchQYQEsC8uCR8iWh2ESxBT
AMd1nyW8S50kZVuZZfGH7RRUP3IggikbGN3NZEDjn42jcsBA1Lkjs0zqZuL8EcNMTjPdcgv/
AI6wA+BGndOfCJosDqjYqy+E5PL6kq0cc/4GUHyOMogJG3zE37CMa5MDwZ52xsQAs/YEcqr9
4DoDr1RrHjTLzgA0gF2LXjvI3gMKHJBkZjU2aTlFufcTHb6WPD1tAqk2us4dt0+48jtZYU/u
GD2ftyo/mtlQ/VXFf83Hn2dRCipIN9arNAl68Gf5/dAF2HUH7T3zCxh+re/6f1NX9Ts2Yu7x
W/CO9EtKJs7m4pq6rN5sCZvfHwgWDZBXCM6nDyV/jInrfiSAVgtnBvtZiaiJecD4j9WO9Jj+
n87zhKjkqhNDobTNPHjSiI4Xavt4X4u79RzQuOeX/E1NyDj571KLvkeZctvf4e2DXwIvXRB7
3+9lrddmhoxLDuEXrlzAq+aTarcswZUD0vYw7o1GDQ6YFSiuCDyfeKmDLupddALMOAYKmvEo
SDgXI18kzXsd4RocLjuT+RdX6hKb0gHjmXPKTwRDXpG/zZ9rkF28qvdLWOTl8Ph5ynuFzPZ2
ySjy5wSpJqMlcNNwpi3Y+Zlh3EWDCDNjf/VEx++n1EQ60HDhROv0QIuC296hVAo0dzjXBLQT
Ie7o0kXevMGLwbC50O+fWNvX3kpnSBreDWt/4bWbgxmJBsvD/6HdXgL4jt4wonXUt2B3nZPI
4CiwUqjxzyy5lT0HMtZvVNlyokpE3zbxXCzPF+UTu/GAPI0naZhn+Dg2Y/UkFBx6CU3KFVOm
grz8hhGnYXSBFRSOxCI4IdF7Ripoxia2ISR/it52d/O0avUuDepZkI/DDTcSwVV/zKCiHDav
8OC300b+ArqU4De8m1dHgfjnNtvGCwgMq74BJXfiUsai8wh8mC9QNzOCqGDtrCUZE3TQsNYt
B50z6AX2kuU8JUeH1QSrN3yoc38P6m9yz9EYoS0vbyBg4xD5mRsYrpJogUoa+9g/l2yuQrOA
Y0/p5DgYFTRut8Fvzue+npDmr9NVoR8JzaMYzwkHJwpOpGEEuxduJUrFytl8TrRRJwnYMhm2
ZKuY2SZ3P/zHF3KSWaIW/+XxJyRqjemGkusKzrY6oe2xxb7uFfhbvSghfNyj8YW/n/gdseif
1QlbSgDYYKVzKha6/VdyjiKmMCtb9BRjpEX7l5/sibzrM4Wf4Lj0K4M0PqbZc0VXfnFvLVO9
GhL9plbOFidxizl31rkAl2fqq/unPdBsZo+hw5dmCWCLZ79Nx2c3R/A6G1ejn7FuR1Cx9hMZ
Y8vpBLCkHECVspeB0IDWiU4ollOPX2QAQTkAk0UK7UgORgH10+YSWthCV/2on+5bzM1dRp2Q
dGCB5SRLYvpDNtow89hUjRlrOJPs9qRCLMX7QIscMNh4SgyalAD+ysH5c63FV6rhY34hkQwq
x7HPGUN0PBarwnASOYmCPsAEEWBdMbr/wMC8EbzJF+Pj97PeFFZsTU2D3IXhX8qo1VzZx7m8
4nWKXGDBL2wpmxdD3G4/+6WsXZIIqu9XGLfD9kLU9YK2ZcTwy0UKo0LBo0SrL5qk4cjdVkxF
6066CZUcsgMJJP03Ef5qh1sXCUj7izRJhrMNyAK8Phg/FvS8lIxVRCdSDQFTecAu8GCbBc8b
dc17x/zy4N4bYqFQpNJltEwkykXDab4CM3ouxXhkcpPAVgt5TKBac29ZsCreNrHI1Uapr17Q
1QVPZsmsnCmmzwgU387kaLqJOpwcYEKw2s7ySQu9eyp9nimWbugwzNaCZu3YdlxUL+eJHJVY
MWVohn/YkiTmpXxLRb71ZQ4HmyHqMGibZnVJO8z1H/rgGDSp2cbN9ICVNdjr0NRXXxN6q3XS
GAs9d8my1twfRq2V3K/lp65iI6FVTb5kzzZ9OMd97QYqeMEY+rcwJf7avnqe1FbWNRsZHtq0
z1kczsXuruo29M8zxV0iOg9qQJ2GQetG9Yr47bLOYpXwVPcHCJfBRZxa6hUcb675EAcH7swO
ecWxcGvxCHNayEIRUKKwCaIh8aEuHPGt4EuVvUJ4Q+ApcmubXUdPYv6ts6kUp8Iq4uVpArsb
qJ6nIj/Rq4Ln3JufaihMIgvaALbnDE0tYqc+ktnSgE+DpND9vmNA1PE2apnCHjsUmyvTYHHb
ThOLkFPN5aOo/hUoPdfpHj1kXPU8NEBAOSEaVfibfZeIChOCggLUH5qWhwGTd8QUFwhE9DS5
GKDItycn3bhfuDvURlSMBq3bjd0HjTb+N33gupsehd1HvZf8QmvfrEm627aTcbnms09EfoAX
LmK9fZCWUPYTpyjKTGd0n+dpoipt9uuVfcb6R6LpxLd0IvvO4l8ew0/6fSvK+Yd5RkRFP1yy
znYUHbXtoBFY4dlxSxsTY6uBSMThQShIN0enCG4XbI2JTomAmSqomPXe3SdgXu+780i2O1lt
pUPBRYdnI1TT3QQ2nYCtoVnc5TnSjfR48K4YJNHJOxqDxZITqmYx0K4/JkfNTZJsI9rvs3Jd
dvJzAdluJ28Ewb/83F5fbEQXz4TV1XZgFZSPbhReNDjT5JAvk3D34B0nO7YR7pAaDxEF3wWh
uglEVxPFaaTWiUpKIJYf+rLct5I3J7jDpGdWf0ff+hWnFHodDOCjadBAy5XA4jMVrOs53l2S
jUCO5FjNX/XTOVm13WS+H+U+2hxJNNXJXJqv40Ck4MaFb5RtkL2ZMIgFMWyY2sY+H82ko+6x
0i07/v218TyMScRgsyFm+FqU/Kne/2YOj3XLGSrn2Vx8j/kovti0DV0k0q8aJxCNSnnwZaMZ
7PmXxFO/AdSXWSE+3iGaeNklmwZq5eKLoidY6d66JYWe9KSJiLqpgcqMUT578eRs4TFRAS5x
MruxnnSmUETeUMp6WczetyiDbxbf4A+QBSFEWmcxUf3BPuFjbNCyVvujk/7v5GyO/4Yz+Zse
JdulW8wb8l6JFJ6FBXX5y7BMwTIzz32sWnguwRk7jQgdgyOypFcGas0w7OKemAg5OY86KSaZ
Dqj0dSRJMNZ7jmjYSuScAujjCUtsM5XYhyk8hhWsV1KxnqmoBocJkRYTyUvxJm1HIy5ICe5l
2coU3DZihMf/a2KFPLQhpkSPa/bjs7LcD8rYZE+G/BFywwT7yNy8ypuOGizBiB5CaCY/sU8l
ClUogfAjFoSgCFZZ2yBp+Hc4HNMEVSfSVywrwsGh9/vacLITWs6+ebw/MPSSsa6tNlDY+91x
1L2cYJJidfvo7Khm4L8xbF112cBaKZlb9hThzU6Xpf70O2x95WitMCPHF5zHkXOp4zrhupsc
gWQrbdc86UgBAnx39ZLXNIEDIaHtNB7sBi1XhCHKEfjcg3hYC2Q9pzPcsDapGDQHO3VerZIB
zPG8M7oce0sdIwkaqet/2hi0TjZcmBryi9eL5q9g88mCw2vOP+c2PB3mpO5a5Seq6dnFrkwN
K10rTaD5LX3Gn9BiibdevKkXWOu9MkeP3MhXC6I/uFWzViwYurYGaac36OjKOTlYRVr+gq5U
osbUSlpUDCGNEpa05OR8P9zCAZ9Ng3gS4/RQ2artdJyVdQzkDpAet9LAKM807h31FY5Z22T8
R0tAhm32ZcPTlrrBykBO2DtWJMXe7MacdguU2mhGVC0sFUf0vb14falRekp7JzuMfsM0Afil
GmWKOlIWjw/VgNXgZEimszoidS5vGPqpskvvd+ea5HJ+YOKi1K8tEHNUPRwTUqvuR+L3sv/D
DF5YYtoXN+fEA+XvHVH8hQ3NlOw7+oC2dEkDUgvfr4PM29VKNprkH/80eeqsKpUs3h7TVthb
JCWar1RjfKUxTv6PF9FPxZ2jJsieOzuNhuklbDou7n31ytxB3ekypS5sD513YpfLy4cW479z
Fb8JjS8eaZKXZHx9ju9dF3qYTv+LXC0LKAhJJRaf0wTtjd0UcCiGXLzQmxctyDMaQ6pyc08u
/Hx29IAaypAlp11leDPQHsbFICk1alra0Q3HAD1y1EgIWh2HDiIQfFkgDknJI9V/4DAcBxac
yqUCzLXhdNDQkANV5pwuKe1+3s3x5BoLN51jziFikIqJhVVCF5/pNrLqGCevRSyJmWcveB4u
aoph18rTeU5GxkK9mri71sZL1FLI9UfK4CruQO8F248GT9LyB5K0Y/C3ffS+xmGw2DLErL6l
uIFhVR+oRFSowfmN3fX1PXw+WeI/Cgv3G+0gunR6afRRAS8HrSlWMrWW4VcaUwiJDs+Pf7GK
+UdfmeGYea78fs8nsF/6zIeIWpFoawQg+apGCcLyLm7cphVwg+HFJdGcvd5l9l5c6PuT6ipu
+7kenUOuqUrOLL1Zr3a3arVrl1rgzTPxNm5KtQ+dkuqn/aAp7hEVHsECybrVwLjUF9/T2XdO
eYkf5WKd2rSgT3guHd0l4rWcVzfgTe/Udff76tLyW94u7P4mgze4cfSb+Mz4WCvzVfHf5KOa
lhTxnIPLvkd8RHNiLuWYtmFRufaBb9sBNK8yXVD377AUwyQf/F3nWpf2Dng9n5gvtmAYGh20
AbSFX3k4hrfSVBujV/LGJckOOwyueMulhVYsxZXvycPuyg76bUl6HpRLQTZ1LZTMTW0QVsKk
Ubku1npQsPDq4iQUVgMIGovdM1YnHydoxaIcpV1Gj4Dx4H5SANwc2xHdhvv/IFVArsL8OZco
I8wiFlwueQcZmme3ecOT6wmMzGK9W/AIId8qyow06rwtKONKI8w9uqIwfQdjz5Phalh01/hh
izH481HIQNQ5TcrTRvgWfaACn4ni/nsTC3vPvSkvuv2X9qseo66kdFk81L3G7SJQgS8gTaF9
2iY5+0xDybp6+PLLQdP5SLxWgdPOcybENGhle5Yrqcz2lTz/xRMSMmMwb4vwO40RBNeHIqor
510soQgPxNhwyTrGDa4vUjdDtGC4g/wugwGASp4ggDNA7YimnHFEnSRdq4kQYrEU3ocXk0Ym
/XF+hxK6PXydbVza4BWh0StzU+ops6vtY9B8IfzVt2TaaxZ8fQRqQAfqWksib85rCU9om5gj
JXaPB03GVLrQHjyNfUJK3VF8V0AZkJ6u8bHN0RUz+vEVK30hA5b0VAnm+2HmdQBvO+9XbNdK
7HXEVc2CjQlSiGE+LnuAE+NiMN1zP5QmtmGPEkIw0sWHjVgAtYkZZiFXVD3VGaOQNNxZMaiC
AFf515Xz336n/F3NuNgPQJlMXBGTgTjKqTtB0eRX0TccYIqERmXgE4Vzq2pkfNCxnSLW6Bxl
s7+IptxWeIKvt7MMD0jAsaDnXYBiTJ0+X9pffwzcbi5gnyPdrj+ab1Y/AS3Y4Dg079wZhTpY
GJMhQLEdpzHpLB8EzIy5UuCU6j+OrBD0GFupVqqyxxz672IqiWuPc3VZzqZqp914Q4QgTMJf
xCeVAn0sdEJmeaNHlcVJ/OiRQEDr0Imo3txib5UXAqdZrmkawcAwki0n1bPfKw5vb4jxvwtO
jG51fDAnoZpw+6+wa0zrQa9OZNa+q0TBX/lPeeJcPT7ZPTVbtMCC2qucMQD2oAxRJ1di9dGW
abEw3xxLb3IunhnHXiELHohdbp3zhShBgughRriw0buMlLqojs4pUl43D24UBAfMsZ8z0G+l
XqH6RoUerzHNCz/hm3ZggrIOxauesg/cT4EAhvGDuvMHh3++WqaXDxx1pUxnuK+naH1dyl5P
ueUx6Z1L9R0y9esmON7FZqF907jsVMQJdVtfSYAdNMmkWhLEaAqhp8EPnlu2B8J6U9LFUcUA
7BCIEKyxIc1PaliYgXzh88rmje8kf34UZntuxc1+4X//JLskUW1PGbOBpOMnuSxDqz+1gsbr
20S9RY/Aon6n/aXQIeLsBTW9NPNbYqdVq0muYzYB/JCGvdTwsUwqtbNch/6KcBD6QmAlq6cL
SJhTNGpCvzngKSX3Dho20TcnavRGlHoMu3k4XSsMIa7SYGCbTgJnLwb9tYhaB8X03V4yg42/
mboQ0JbwN5/4++U67alw2FR/fIZCMOMakP772jDuuE6vWYKPMkO03rRO204nDgPdg+yxFit0
neAHEFu6sFGa+nj9rCfrwkXBAoKcedbXSmeyg9qj911a6PWWCAJRQgVkcYBh5nnh0gbMq48w
ix48Hz2sz3g/90ZNVsylBbVpZ8upsSbIpazNWQh7kPesEmRSyLD33+SisdfyuTZ4W5+Ia8B+
pP4xSrc6ZyFVIWwv5ol1p+yHXlq/CpmgZF7IfAKfW4+Glysro5nm8VzqWxeF7QvLuU7rq+gS
iaNz2qjhnPRXpND6qVr07PimxfLVgquySDt/XTMaurG8HqekridMRVEWTtXonLzMzY144v5E
yCA1nh6oC30hWUIVRbwWreVIV1mWl/oTfdkT+ZUXBGAmRLfACKEQapaYNmO8SajEZF9+Hz0R
BWCojxQZMzlGPBfy7wJf2kc09v8LeKjIfZ5SS6NzLWdx0ooubNH1OQG9CCBhGgk10sO6tjrv
/AxosIW2M9BNStZU8TDaA4XaPHNc1r2gMYXb3CKMtS4NTj8YN3/jt9IIi7Udo/hj6SNsA7qy
2rU/4FK0jn59DwWoPiGGaM1O2e6Sbc9uSgQc1cvfpY8L11+F2X+MW9pYJji3F453uSTwIja7
FFZMINFeOIuLKVtgIgOcfBx0ptOp/d3qJ0iNamLVJ4M9HNuYSozqqS194+/FcYez+wR3QL4U
qSwAyu5FjK15Mror/lAQJlrz6xw9J5tfHrB8U6jquhKMLw2ykHs9IMxn6AV4VePGv8ctEnGe
vxXD7DPkAh/JUkdozLCGRRYcqvOVVaNkqOLY+CP9aZoWWFczNeEYkIwCpQQfDTVnWcvPCq8b
BOx5U8wy7iV0zngWFHj2EqFQ+dr5G0lI24Gbsah+UAxGMv+FY/Vg0d/UquXqua7TW2aCkJpJ
fS7ZMVzer2UphyK4kj6RGEEfJ3keTXlSaI2wx3aiz5wE8ZDYpGIDV4o73nOlmsStyoRNFEyX
rfejWqJTgFxYJFJiORjqzUL/G8IrPlrkXJUn5+jWGBobia+ukAnR1HzwFeeKe0JYVl2kVoWd
sQNAl26Ku//YIfthSvMn2VYXbIqNamBacm5drWfON6npG2qvkWFoCGUPj/ItgwDbc1R4ydME
hygMVpTGdLlIwgb5wpcwFPdoPR9qyRGYwv3INzGz1VQ/Ui4rPKbyFxGk9JzsQQunVA1EzfSB
VdKHsLkU1DJFPzzBkWZKIC8Z0aW/SE/1tD4ccP3ZV2Te+y/QadzfscJ8nYLENyLXlN65Sycm
qQcQm4woGaOsqJtRsz3TBpZS622wOLXVZE16zcqIPj1s/CH6dUq1HUv116aawtPQWScKWGtc
NaG9v8CSX1p0yG5+Q0mjG8Au5/x8fdeqyUQV5yPvEg8JWrxXasmyN3k3PBkh+T73AkW/kcK9
jW0A4IhLDDx+WWthIhJ4h+lDK+u9wOkMOMP7pGLmk1RzfML2q49uP2VdphFufi1uOGnDZOFy
RRUnM3fY2gtspls8O8zACHSuhLU80nfItP0Z5BqvtNwPlbX5iQdZuU31vqZf9iIBCZ+8CEgp
PnFl8LSexRH30KcrtCsz23h/LqjtxUoWrnrYWKu7X8GwGX/qjnRUs4HAmeRqU5DldtTvjEMy
YbjbTVWiV1Yw8EgEiiGaixxABtZgreu1W7XtLQUjUrjnnUXYh62Iwb6ZHaw7SCqNJnrbLK2T
yS0oP2Atam10H0vR/NUUZL2KwFwxtB9k9kqlKqc60/T9jXhbMDQGvxOXObQOEwbJGlrjXS3l
MkvytWqqarEPHp1LFNyAu/bKWFAyExtUJu5uHnT++ua0K74vtYB7tnUrunMCJIxJ9kR8HvD3
uK0tMiH4TNlzsHgAKZkC2zub9W0vsY68g+l1D5Zr/9SwiNZpSvUVEM7xPOQJw4fPgJg29+tH
1hB3Ud8bLmLC6coqzWmdosNLO+xSAAJggE00hp7/tjpHJro6ZcsLzIhzBiT7M1vI2k/t2VZt
X1V7Ii9cSIDKEE9MhKMtnajLf+ZuOYwiQyOtPZhRSpwpFv+kp/yBu85z1Kse6n6TnYhdCrdf
sg3XGz8x3xpiAIsuX7+v7Owt80e/2NYVgHRiqsy3t41GqjUZgeyoNlKlzBdoGWPDxK+2LlmO
vfbi9XeCL+haH+MPAscGri3pTIZR8TZyaVKuXuiCxWOZ55U1BKu7SyEvn97SfEnKxswuNVmR
YxPe0RCYZuWlCATqb/oO9v38YjXCrqg4wax9lAp462wx+MZl7gOzvpsHqdWJrg9TFw6ot5hk
tnbPQy3942fBaG+QsS+9ALkClsVIx+tpUiyRdy/WROaFiGQ/Pv4wDxZ9ufTKueha+zMhweE8
8nJxQC/l7fdObElqaJadjkwt4Ncd3KZrA55iRINvr9QhzIu37cmJHZ3n7zfz9KM18jXTrCAl
9XLn7HgrF2axet5SoNVWPp0XLVpVQwqkkLsnwIMJIbbEk0A+PR0UUP/LqAx5aBS4IwELoYt4
qTVF9uGdOL+1pcchfDnf9RjYpw6Mv6aISxbmMb44WVQY46vZK6ysc61uvKw6HYgXhfy8d8pv
l0QWO26145I2HDbcQgIJGWeUKERETDkdsqE+UC8kOKpo3Aq0YTOOqMv1WvKwV/AEmB7txP8I
XpHw3hE8eDFz3lfxL99tDsr7PQlvIdaWlnmlyeoM36xBI7h41wxjDYcoHrJH52a7dpMHP96e
Mriv+sCg81Lk0PqVdHotqCeOywDmkp/jwlYPfPnmZEOFRGZ/WGJgovgJQDeBsIJr4qYQtWtM
2WP55bEQ475pccNa6ZYxmCjceB63fTqVmNAO2enoPFU9YKiTWWvDH/0eKzrdHkmZUmqXngcr
eQisT31ENvAHvp98hsm/tZfSzYDgOLlRQdJ+Bt8C5oPcVxrODMeZU8pRooxN2T8h0189g93f
64sCGjzKhbe35HblGI1rBDMIW9jekC4caUWBS1CJNzr4vuoFJz7kZRuad+f4io1YL4EKsE1S
5ot9dzmPcHs45aGKeEep33qxeM1p2FbWtctU58LBGtrs46zXx1laaJ1r8U4cMO+bMOnMxWSl
KWKHCNaruFLSuu2uP0UaDYSr2xHBOjN9YDpvjpYdJP5xaVuNjZkliObKbuMIEBGHQMbr3ChA
Rja9fFXlzTDusrVTuS435rk+MDZVHg27kRx9jn+gA5pcSWZ1I8yYKA0SBBDSGsvPCxc6dfR8
6tk8Uuh/IK/kjwrybz8I04C5u9/O2FA6v0tkC/JqoQiMP9z9Fgd0N61ngfeT226XNeN9odPG
VmNV3M7Dm/ahsm/4t9v6BvnaSrcNCN03eIIZr2jb8D/0ie+uXHNvM8RnQqkgPMBm8kpuW6iv
VfiplqrralLWDvkS7H9yooZ9oCnm0Z+HknaexDIvwxh1/8C9X0BAqwP3GVl4QoVxvbK68yhs
wrioJpApZX2ijvolHXT7LdOhc5KISOkYPre5umNAj3IAkuRNJuDcOndQl7gTEo9hbsBdb6IZ
ScR+f6nurW0eY0m2rZu5Mx9zmerqIZRrRmpSJ4d5ONX3z3Vkp4l6uuD+m65sc7Fr//NGV3ww
QZBv1Uaz3ROz0KY+ymjvG5M29d4RdQhiJm8yal788wPv9cwQKHFsukDx5/kiOXCJ61kaihLF
4gzqQsBmsb8a66XgOoasTEdeLvcWYG+L7zOrMhIWSaGbKZtTrZZ2fdxgPurlwVuJGV+m76Mz
8ax3Hl9Q+8BXMgRah2+AZr43Ltb76xAdxkeS1FeZ9x1ERY+i5xgv14oFqUN4eEBVgfOm+7E7
yxDDVNLTLUNpojxtpzRRsP0EFd58+Uu5WQDREN1xC4f3M98r+xTm7gO1TSe6Yno80ivoGuWo
jLjOap0Z99lXx9kQD/B4HHBrgA3Q0q74Og07OgZ9E0GT65pbqjKzT3QuwExg6FhO+ta7upK+
if2mG0WVglCj7T1ReUvy9ZGzH9CWbINtPW30eLiShklC5DVBRyNMqLtyaiVAExE9cR+/V3a1
IACtmjihHebZMZRq5zgmsGT/bAOzPLtDRI4fwAjPUQ1LLtjG1yKmUO3kxNxERvztRpsMuzpd
Ll3AsNAbUtylSJMcclgOxe+wfmf6vSEFlyV7g0ZC3fufpSFIyRsZZQVNY65CITg649Hamqtv
kGz13AxEZDsHs2buZDaW/UNuB/XYvEjdGJKAElYdA42M2LBJemWGBpbjW2kh85fcKsI3LoWL
rrg2WSp2zTU8hXUzF3S4cOuytg63MdjCCSCaoM9Y5Lat0L4beO9mjwMgDpowvETl+NgsXgS+
G3CECRhQe3OFbqQaTj1smtK0p/sJd2BJyHDxUzOfiAZngMAz8KXg6osfB2yP/CbFEsinP87C
Bu8DuNYhF2AvgsY/Fey9vMZOCB3BsBMSb5kBI0uef294JOg68JZs1nSWUlDhL9nMSLnx5VzD
+xWPg8Lx969If1Uglvlu6SolIZkqdRFdPAvsQ/KddQAPlTfTnhOzbj6c4ACVekOkowruSUfs
IOtx9HRZV94NfMXSBQD1gmGc6Ym9QUtbmMSFfSKbB44uOLbTgsvMwz4xzLuC+5yg3O19nQu7
nvQq16D+wHJWekLyHjml3KxvEfjqr8+J4yF7CgeQiz2KKv/bJkGYDoy2YNrxrkhBQH4/b3Y2
AiSMgCu7UyR+Rgn0jMWwlPmKScJeCekY+6mEiyJzY9IUuj3DNK4v3Zm40HNM0yNKD9rlRK5B
hXGCTbVrgHapA6xKAfBz7empZSRgNpFeR4rPuy6d9WnkPlQyzSxM6VlC3SNfzfK+nTKceJ32
Etij+Qobb+gOgc+vCGiRW37OGCIkvTgCXN2RH6QKMZUhAU8LeTkDU/oWi+QKZCcyXrGZjrYE
bVhoX/nG45x3WWBEXLfZpeyzDNUDhuBCE4XjyW33PsSgjehNbJY9+Vrzmzyp2UV8MKdMVGEw
7DMMU4nfgpeR8cJ0pykGj6k6VPCGAn5ZBGPxsLR05bKLF96QmlmoeVVnhuDwpfGvMHWKe7Ma
sA7D6TaL2TeEsCaja6clZgVzKBvKXUPo1f3vTjeyLveJNhibV0p56eUxDxe1YUqUz0dMgWRS
7iUX4zwc4q1QHpDexuYdJZ2C2Y2al7rM/pSlEzoq352pH++Y2Yr19QTBWGKkdBIGaynGtsoy
1WIpPZ8B9vuCkBr5pGrNkt/WL08HMEJC1NKil4nJ0+fiNCr+9crVwqIX2Ckj6Lnp7h4xkVmD
OCaXKjDJRaRFbVZYAiMbFRKtw5kw0suyl/VQB1bO/N4HmBVzYSS7arDyOaDE2yFjKfxWRyDT
5mcM+kN/rh/bhxizYMZpQ0peHKzulHA9lKNS41T6zqUZ+irkeGW3fX1fDM8tKVrupJOKF6C3
88lTjkxKW7KGy8kXIAYDse4d29qXdEKuqi29tV4FhalCfQq1fF8PV8Fag+OOZ60VCl07oOa7
hxy+pdQ5SOyv4kyrSbwr8I0Fxcc0u/AUDcm8P+rTRFenOhscgI42mHU3XP0zWzPtBi/Zm5j1
1F1xtfEWW0hX8PJLAKyARPtD5EDauOPMAVK4a5ndPGXgEGCmnWNtv1qlFUfenOaetoYk/52e
2lVYm6hfyZGHERj+jjG5Zygc+nPM6uFKVT63djNUb9KYJ7pFx9r0iMR1elKY9WTNK5rbiIDa
4hVRzypUVcMREDaPfdb9N+xq+QJqVkv90W3nNOQLGqI202bwYyAvxaut68ahhtAHgMACltpz
jFddEal5KqklJzQLhbobw3+72NBPe5+8dKzdmZ+ziK1BR6KbVpEhYF964Xs3iFJbJ+HG/vNG
tb5AlWdpcGDoSYYx2ZU4f6e2BTZoaD61NBTmLqS0Cmoxp1n+eHpSao9HVYxlaK/GtMpmph5x
WbJin0ZVMZzeNcAmA3SyuHlXWH0BpA9JojaOmTK0hN2Tat0PZfdDGZG53fjC2ilAm8ZycCdi
5xn45XjdDimDvbjgSbMqlTPNHepwzmqXcH1RIITsvAgiYim+9L7jsIq92DIN7xJ+qDjI8dfM
PGziS+ucvYYzbpS/MavpgFKbI7mbNRiV0gNkN8cj1I0HxNvoEyEtEVgQzmVAsjX+Q+29KKdI
0JanbjfC90zggrqvIx8Dv8eDT4+LKpktdmtgH0Q5vE4lB1WuFTOI7TZFXcrutB3CbYMXyfAP
eLGVXuFPxMogjetd3hHzOVI+b7cjLuT6rkVPKcLJYQBSIuelbrsdhOns5NV/Z73KvOfgRoQc
wtEOG6iRgfUSFxgVTdsWXkzwDPRmZPZyo0WXry4pxiFxWXPNEIJhW4pII7BrwsayRTW/xQBy
NVDl3JWF4WlALoZhnhqylvsqCMykDI63gnTqH/xZNstVfWgxLECkXFvBoF//IX0wTZyHfoem
43cl3+zOTY6Mdo+xfoaQ5gZos1kCPAQTLYgnYlcV1ci4VpQmzO8v7JOIASd6/W8nnGosfzyQ
7hE7YWLR0NS7Mz1S1AW8rAKEvPv6yCHKR28Kjvi+RDCCH98wpjwuvgA4il2DmaGz8orLaEWz
8meAngUqCd/+pkdylxNJ/+Mz8vuIDbXwcF+G4iExqj7zID8MuJ2nb4kis5TddM1Fy2u3F+Sm
UIcAeIXGhMU008zPDjTB9kMp6CtW8IHMQXOUlJKfs80GCFKGXbZJoDWE2nK9ReQ9xR1aY5SM
EUk1AvDs3VpdGK6VlPfZnlhOTPCXUk8WpCO3lVukM6ITKc/WJ4PeQa4Q/ZQjOCKwxdQSpiLZ
C7Q8joQAB5rTs6wBO0tRtcQit9lNr1eMLAHJWi/Abuxin5j1RMP7+nE7+DTDlWOgAkU1gCbr
jhWTrbJiNmOAgkhvBoG/vX3XNr2fQMNJM0LzBid8X5hZ+rCtYjY2hmoSbTaFIh7O/H7NYXMW
wJupRr0WdWq88IkxnFfs59aF6jiFuZkPceqJyqAkrNsekHb1xn41x507k4SZR8bb4tGkrhoZ
92KE9UmpSWZB7LHSsENQE6zEBqS6jNd1E/aD5oWl1sUJ23/MoizKmNLd9OeGAAjG0h+Mf4RC
CFKGLsee4tRo2VaDN5DZ9fRWgECCrIPyJt/gbZIL6CTkruF/1g+ReYNC+U84Yq32N2FjfmQD
ArsfOsgZYxSiDAuV9wiJjQbcO9vXzAUjvtuAvXy/XbhR2GI6nQ/Zh6VczqBxu6IozuqVCdsT
D0hT31hkHLea7b6G3StcuyEDbivgVgNRHgXqX4JtdB9rKgWQlwGwOuCSDcekWHKW7n30oNde
9uGsqWcDMS9qNFN6aQvA4YHy+eUkZXwIN3bdLDG/kjPRTPE6hWkwNmECW2UJSLg5N2ChUVEW
lrH3m7G9MlyqDU6PNHbFpV7wkSVfXIIIfQY6M8T1A+AG1pSsR2EOAgXgBAn0JlNbf8UBON4m
yLd5cLtnPQ25+w+kQ6jJ+x3GPsapK41FLCS+JCkoHGN+Kh8UGRSvFx/oB1tQapJpWRr0U3I3
NIhec2zAU8umA8xfyccr83oBJ93+MRfvh7Q9hHWFwXpSjErgz8GbKihXADiHRiXyyy+hUJP7
qUSVNvQX5/l4vsasGkj0+SfNi2tw+nchcHFzaEIDKA4ZjLrZK4bpzF7Tv0viDYm6OgUZlND/
SWfYY0yJJYc/jNYmKqLnk/slxTmlB52y8/rXPhRVgmaC8ypYaszoyoBtdKNw+59pbYskUrHH
VfEyCfw83Cl0D/j+iHEwqfgWXodq2kpj8Kg7vqDAadyNOxzARnLAYrcvMjFBroQtIi0UQsUA
zKB45bY78ZQ/M8uPiRLEXqRFz83eJ7dpeZ+w498pFSWrThF2KE8qi/MsvC/a+ss1gmZGBLuC
kP+jHR+U0xObmXllVYHEZ6HIcE81UCwVJDJwVxns+OeBCyDU+bY9WnlVbey56EATEcDWSd3k
TRzV0tpGaWp0/wWvKPRhvtG9vk/XQF9Hx9916+UKOF/3DJQMzyG6Cp9qtptxp3DgzGOf1Xnk
FHeZrXZp79MhZATNaKJOFGARWvB+eFhT91PFJTs5zLClL6X5Qaxp6iyWSPrhkhOx7AorBtV5
OStiXpgRM4QznzjoKYXp3gHK3+qd9SsaCeaz23t8V4K77z2Qbo/3tJc9sfTThVmm/Stk1nd2
TfFCn1U2KGtQbklhTaFvA8qHSwRoElycoCJf49R4l/vRGeUYJBywdViWfFszEoO9ZUA8ZXUb
tkt/MTuU7PVueb2n2so15PfueopskvYGR9PpZ6qig1sWz3cyRu9TkrkuNymyLMPtLpj5Uhtm
RdtDN9QsMg2LwUfgrIYW2KzphqDLjs38qPJh3GIX/olc2wvAMieOLRoFwI3SrhSge7e7YA73
mkoAvqyPG5CrlCYW7PVIFaWuVcdCvpCZcxaDm1dSllNajEsMuynneldslcNY7ON6mTAI5S+p
LvIWjVv1yxN+8aFGiYspW1cQYe3LQ7KDgrlrSpUQJWxKRVV/rxuUBAMf7X93V4lSizhR8WQu
9xtZd71nofs4eaJ0GZtpH5aj0h/4rm8EwOvvhmtGyKkUqkBPyim6YBKbVsxwKNkcxALLheyU
WAP/VwhGSY/Im8I74wbHW27mIRXIOtVOgAoWCwJYUg9vwzyDab0gMu0r1dgxNFpxUZC0w0BQ
VzvcRVDTPv2UjtezDPVsv355L1e1wuarkqOH5lalhYNy8mA5k/eG5qtfM+svm18UvY+/Ymyo
A1s7hfaw+RMqxIRhqQ2NO9sPO9Urip+opfCUSh/nZ4GOFWKJq5vkmspX4zCVD+O0vYkbmRYt
RERGVC488/4Vdy9d0Wu/iLl9vOYBnjEllGKOG9Is2wxE6cg7t92gehfP3GtizeekezrO9m30
t7up96cVpbjdPG+LJH+cMhaI1zT1ZKrDqugRGxVeswGxvCfa4t6KGWeWG9mQ5whXXAJVYTgf
Qo+Yc1/toCZDR2QilNT8il4leJ1GompCqQJEVSFYslMfNCncoVBQPUzDkx2vsYbhn7thRzqI
GRgtBcJkzyctkNcEAvxZr5huGwqGxv4jivigPEDGn5FNposFLK361qFiobREMpkEP0xEcH+d
ks611Zqcj1/BVJjdiA3VMC3oEiXfBJWCRwdKtkqHbbrjWIsTC5KfU9qitTkhislahf2Ysall
PwfhTNaL1eybulFvqGuqTGxJXjhj+w1WM22hwsshWxz3W4aGhD83mpLxYo4n3jIgrJ6MvC5n
lZdlpe8oZfAcxzHBAJFlBUuK1aq/JqEXDokWeFN+UveDJfk14tELUmp3aohShrdjHinGClR9
dSlZ/k51U6UyI6oxEs6ALubpqE6Kf+VR76FIQ6nY+EGmMwP1a88+UmBp1EImYqIvOqnk85nh
SLurFRmmYPNg2876ygKO8tZupYLmMpGRKOL4RxECT2HtvHII4/vudmQOcYAY2+hdqQyEEX1/
euWWoGbyWlaN4nBzkWdHnBxDgLB8OESPfpfdkK3lsUloGYyRXLMtkpDRiSLKf8Ro8acGEthD
Ms1RpSB1WJ2CrqE8P8ecammrmh4Id4S4DmrQJl6GJxFHyxVnUyWsY2gfUY07b7gPk6mtgrUP
MYU8RJtxIeF3zp2hSbd26ilEo4UOK5tkjBZIE3yZvA6/9Q+1Bdhi4jVRGSIwhNMj3WSyUXYU
1kEngz8kj/RcDZw0wuRSXq3mBwFw0wkov6qKl7ILJCpbvOuoeNRot7POeVA64b7dmGy0jjJl
6PPJH63kDG0b/y4Xe+2sHfw9lDj+lkZ9zfzUB9xxKVXBCleyElh+2i66TOGvW1TEJNOkDeM0
dA1NPS9O3MmLmo7JaI9YtuMEpzg9YzoX+8/qmEmLYVwKzs1PZiHdi5lBL56p/fqOL5reqicJ
5+588G5OtTXfIyyhSh3ADshiZq8twvXP7RKRCk057yxpKytLjNNCuQTCVSS2bZSTiD68zojw
lZog5qK0DxXdDThnKcKh1UPHcHzaWI5s3pPB8xqiNHprfO15UBmJgRWRbxwHEcbvmCaR4U/+
BP0Vppe39oa5wtOOorI3cX7zUQ51r6GsCmFmFfNjxWzaHHn48XXPej7mgvyT9Bgz9dIe9JDR
Boh0IZKXMLZMGaCQtfH9atyVa9DC7+ICsgyTgaBXrJX/VrPBYapL+9JwJtP/NXrdp57cpkdS
xu/bLjtcWMjC104R3YTM6XaCXnsRyPNt9SZpBb5jiljGFgYTunZmg+ISLZawPZ7+99UY2X29
g2eFm0JNf1CJmch9ZoXJ+Hv+ypPK9ir+6aIHRrW8xQQlP0jRVQtuIyGbDTcBwxdKvBfyeMNM
DtmXadkzNw3OJXxuG6uMm6dLJsdDBRoWjCvqHyLjlTtSEZLCHb88FCL5KjmewCXakl569qCx
F23XlZbQ5SsByIDt6WhvyuxdKoqOWYGB72MxV8pxiZ0Lj/8jU6lUQ4tgig/qTya7NrUELe95
gaU7OxIyodKguL3xtuQboAY3B5tn1y4n/qwcWJoddTwkI8YiHCXfd6GW5vDbiq/Sg6DDaGNt
DVALN9vN7AcFh0mAynplJlhfMCxcXQHWYCk+3u526VZ/zGZO7B5qy//0EEEbV4sN7ZJbR+hs
cgqWTKAiUqGkiYhgnA5NQN+hnEJUQp9xLAl8P5YKhp1pp7hk4dk1bEvV6NKwLbS8SJ8S8EvI
F8ZeK5AuUG3NCg+FiVP6eH6Bns6DtqLseErIwc2Dg1dATKNoAHVQZBxA+vgbFtBB0MjgvXLJ
GCtGVW01sfUL21AG0x5JNDysuFJj2q+rQfdAWtJC8HccxdDnB2whKP5z7b736rXtwQVYtjWB
glEkePo136Y/eHhF+ICm0ntYTvRBLWcQGLVokbBY4kahu+V+1BEDQOJt2y2MznO13TZKlyQ+
tBjm/XAh4E6cc2y0dA0CThLEKK4s8l2L3RZgI/YyelFM/DPQvgVPb7rcH2MeNgJLFs1wV/39
W4mygatyYI5cgxx0RQo9w8eLDPX+0XEqx8haxYd7GVrybwHJUq9pBE5g4lQpxXDsD3v42Pbo
56Xk00knRQwY1SCbPyQbuC6VrMdoJ0z1PbH08wBN60f0p8WdJ2YqPyjkMt3BEodQefX/LwVf
cqYBLxzjA0Q5HMm/Yllti6PvwIIA31sqoq2hv4zurURM2YXv1hxvB5rLzcxjyY7WTpVoXuPG
6EB9z1HJSuqaZS0U7/AenD2y8IhaS2PNFrLg0gJEJ4aiJ6029B28pGJMVdnYKeCMV2dzmTAS
xtNXKrAQ3MUcxGlZewuImdJVaY9tkYrUPBPUtZ2tlZl+WnosWKr+SNEHHcEDVu4ic13A8vsK
twQYFGYbP61WN0iJCqwDwQGicIgP2ZqVd2NhtUNJaacyCPK6q3Z9Ni8CtC8PLRLJEj6hpE2g
KbIutINMHLUZjXWgxObZup6nJ6sm+wK+dUVcaZpTjIuUjQDzUH9+X367NE8yXOOaBbBs2cFn
Bs2g69iTl18phO92sUxUNOcHujiI7dFKjFD2xe4Z5GI5o+V1NaCiKnHzWeAEGDVbYKoZC5sP
qzTfqExBWUMw8+Y+OyDqpZCxmQAoeBsGooaTfSt+X8hh1UBakw4gywE4e+SFl+675KDGwHoK
9UBN7zMb4yxOJsbVkeR+wN/aPSs6b1QVt9XJpfI58j492kYvoD1eyI4TfDxq964SbuKiUEMZ
38CSIuUMoudy+EqQ8H91jNbomnLASE+5iK93JPn8pRoKNMAr8brsAtudSPKnuTTDxsHG9TT+
s+eIk0zeWWvmdsftRzQKRMFWpGFiSKgChL92eBTMUj84cnYxppTiYtZCRsDp5o5WVHWXUk3f
dddtQgrXNCbmRb78PHCJyhyA7PEhaH3XE+aWUumWOdjOhT8luxx1BG/NlSJ6ASNq80iXp8bQ
DEJEcn5hjdhiF/lYUKvn14zhy4dQG7fdEKT7dhXa8Tm/6vLjNxHHaomlWgrqDwoOE80hf/vV
SjCmQ94YPhFXyHlusuJ1OMiihYvjJ44EGx3eZpTq3vQ6pcMw8s9Vd0p79bpj+P5rmfOYBs8e
DwDuM7ipmTb8ykdJlsH9ngzYwT8eBralCcaFpX/8V3PWfpxfUzIVRPyqpw8qANPFxekv4/sq
gUsaqN9/f5NQPdpu6iLotgzqpriDCl1eKk0eM+IFxoAWOPqNHP28KVVo+9AARTCsCsE7eCFn
Dahup+Af8yFHwcEi/CYkeBpN/dQJShVO/p7dp0vtetfSkzkSPG0CdXRsa2A4QYl7RDiICKpF
oI8UogsPpY163IiBKrDWRcIyMA/5FwFM2wazcoN2UWC8jC7Faq4CjTDFN09CKgbNXBWkNtcR
nk4XYQ//zgicTOSjIkXOrN8Ono524o5cIWDJ/2JJLuh6SFWPKDFYP+V52oStROR6KDcyVAP7
DbQVBrzZ4zJPQYAcF4JgPiCv/doedZeltR4fm8gAM0vYBUPgBPEsoh9E16eEIwPLtTK2EOEM
WLCaDF7bAdsFBl+nsI2nTic2iG4GRwP/RT7bwTdyYiVclLfvhonGnZyFZvT4r70V2Al0fdEE
xripEg5A6lMqk8IKXvjrhqtOUAN+GTzfVdqVZ9NkDDc8L063d8Z1X7iHAQsNQCI02Arz4Nyx
0rOqz0hWdLgj4QXkcGs2KNSqb+jJ//xnEfNEMPL/bwUf7ZqMcxefmzlsMsnUw8EulWpVE0tY
hMESOgd+siu6Ua7Wqmso9fJBaFqDPbBXszNu/jf39OmPHBDUCCEGu5j0cmSNpwocckvr4IH9
tn7XDg+Esp18gyW+fhXtyRcYXfRO8I58tuD8OH1hQ/JJzJFH+vhl1t007k5OiYMU3Nf14pyf
1PlB0yjK7zybwptwzReczh2kOzXJNsjXroOgNUQU98lDokpdSnLPcDFUn1iKG5rOKh6RqixM
oh0t5sKfnZxmAhg13dEk+hgg3EimihleELqGilKwTT1V3b6A/2iiUkv3iEuQZOdItYgKwi7Q
r3p1g/riwGJ28k78Rj16A9GuhX4yRTobtWGIxTMEp/ou1tQ3K9NZL8+VwYnhIUw9gR+pjlZo
EnAsQ/0vq+USu6LBJHYc/t/DEV/hMt4z5E1oJb4N42N77Gj+xsFHPbdzwAkmkq54g3mjJdc/
wSauEDgGH3DhyTnmfx0SnpMFKKuM3fOkjOKvtG11uSKa0iiXdSy3pihEfkXDL+WIYGqq7QBM
zJ7luYWZ3Px/8o6EocIb0QqJPsXL9Chdt3qdzd/Cers2ydLryvqdX4sHixTTchvTof3dmvMl
D2QYSgGqOqmTcS96ny6dgPxz//o56o8UsLKmxVgOGLAQa2luTZU4kKEeldjhI5cdXRBdEOGM
hTgarJwuhjLddErLMD1M0pfLxPc1uhkTxSxW3iBZNtePLSS8dPt4u1hcu5RJMSCNcogPulTr
ne0puSkA8vF7zsXQHxfpLhKgVGZt+zBCScrHKYRfx4Yep9gzcdtBP3EuMmICxX9RnZtwn3UQ
Xfe1ETb5zMm/7ZH1+3xIjPbtPY1gmm6Nj626df/t871qAnVuWVKYT2emts+E3MvUiRddDFVz
T2HdHMp4BEPYoqvuc/o4J9px/HP685REm+uRbc+2+28d4e13b3ka99rjBuWuCG4JPwL7XCy5
5p/4ksYM3Xk7kvP0LS4UBZ1DtMpIfITBkiLdEAK8iUCwLdf6WZ657bv5PRGI4QLt0ecQm4PP
BX7EJH+Xqi6ZAHBEaHTaGKeElvAMdW7YChn5UKFE5x3hqXnUSvzDUEFdIaH+TMQ929rqiMn4
MjRdTTU4Jd4jxnNMZefdFWXeqLsJ+IWemcu9s305P9x/vCbkwZvduI6afNy5rOG7PSopjQJH
yGrfFMXVfqDa9A3lJFlas94Wp5goonLFq+wwjIrNI8WaGi3GukzjLZ+KvscZW4vmFZkMl3jP
Ynwb127F346Zy73BptUR81wj0/WJXjVghok1s6wgf6ua5Y0Hr1J0JYOUNJvJ/cfsHh1DAVub
6ZLSRLtzoexbTAs3H40keZ2mBFq0HWU/32+dulOC6qmbxHNj30cF+ko/XYDPRbjDaaluXnlq
ftknHxT+8NYCW3gRpVun+NytbtgTyFIFw3OvpYlxx4bJkVhKrk+i/ZtEM/UNHRE5NbRk/y/q
Fx94C3itBP2WzOvt8ZDhKPU86nbU+WCv7Awa5WUWsMfdp40JHS4CBLBuDkiLbDT1Y/IxBi//
plSfZqBwV4ZaLOxx5JmywP7Db7PEzoioNwCKPaG0/rtsPOAbwrJNAxBCgkAtK3fMfRsmDVhj
TuYgxzBVE0WiWLONLpZnVeSV/FTg0BIqONSMSC2+8mxwBd6FdQEaHSsRye8WIyQpJjA0abQL
vm1YEQd478hnx5OG9CI9ApeJ99HXMYVXxImcXm4YQ3vsCzhrlnV5kl2CnixaM7jjESmS9o4W
4eMoVFoPLvgj3mxCRjloDvX5u6agZFLB3PsevDPVC4k3GD5HB262nZGO7LYNFKqlWaAN8F/9
CK30z2S5WYvykRlXRCCUz6VDO/L/aru/NO041CyifaVQBv1fbz7xRfUDb85mHxyXerKcPJuu
MtMT06uaRJ9sB5qp+6I8gGXCugXR/b7LpGDDV6CpAXg5zKIyQ+dbckuem7l32hGYNJ876QeV
+liwThRxfb8P3AUk4eQJe2LlnlHAQkJ7el/M0M2cSSM+Vl2y/5ZKTDEHrN1i9JSNjyWVsDIN
2BRXPSJCz9aMKC6d7rExbkA9gIniGIW1GPQpH8NLErU8sCAsDFOJ3kDNkd71uTf1QsAofgsF
rfrvZost2vXH3wlTRlcdMeQe0GBb0qf1gbBvBI6yWCx/7GZlLrGmpUaalzZiZ2lFtC+puMyv
9moavcgOe3yl8kbzlJJoowoJoq9CyM1S9D3ccLqvTKJXUklwKZLmST7E0BmZkAR7a2LJ7yi/
/OnROtgsYoTH2msKlNoeocuT549Kvq+OVEX5sZzzVvOOwFJeqAXhTsTAsyxqGk9MDk2WLAUB
myLIznhPGVShMsKinn/6rrAap2ClTm8zb0SGALkblB8fBwiANeu7p+Y5bMUUy4Oi11bxPRiG
bStwou3F5JvtuDbFM00uRPtnMdjvHwjOw3MtXxsdVH8IIUVfxK4fkP+Bm2Po2JL9UlbNbpHo
uofIrtBPxw/bcvhDO8LKl69cThAiP4leZGSyDPfycZM9Pvq1GOZYZeMt5nvr8wUIzvsT9pRe
RB5RYss2p502JqXe5LDP89wyx2CeLJJMfDm3Aq+JX5HIs0V+2fbg99gQLJwqzeotzh6ebh6q
/r+qdvYgDFvitpbmJ9fqGgYW8t/vFzwhaYXWgmgxUkFXBBKnDVDtMV5lAtRXtKXKcfqWwul7
VWpZRLmQVGwhN/8OS2epMotJqX4EbWixtNk4jEmMVJ3BaIH8wVkFACMuqlmeXZ2Es2zLafXm
X932pes2hQwYK9Yq3nij0gnw4lw+BFMEXBs4RRzzvxyiETMDMIInT4Mpuao9fgeRPYTEDt0u
4OSiy8Dsc6sSctI3JMAbocxM3HSUvJrgz9IoUr8Fd86NY/8UgDcP5mQZAkvB1NPaMO9ku1am
Vp8ge1IJxRIgOPyvZ0F3Al/+zHfUQlXy12dw/XNqRhSzv0sFMYrY28UFXUK4i1AYddIFVF0u
ZFAawXuTYQkYOFDXAKJY9gbkwpk3sWxxQseqb094WWxMYksIOl/Ov7YyE6mRBYqK603Yeh8B
1rskgL9gUfRyqKRkOvsUEzBiYK/gPzovz26erWqADRhvEn+MothskFcDo1C3G2UBsWvAx7ne
G9+1N5CHJ7zUOkzWTxvhrCGF/M+AaM+6Ldb7m4QK11LkPdyagCvG7Mss7IYc12KZobbJs0+2
sBXJyeiEKoNdyU5UIm/B5LEODlzn8lyZ+hHdwQCapRnN5mzMEJj5l4tiPCO29NuSFvHQNddR
tk3yrTf7foUsrSzJbIDsmnE0p+yiRA8QhjSZ2LbhABCUD6jv/gtVngAP7JK4pNX5wXVHfRe4
QG3T8nYqToqRnH5flECHU9OwCrRIQpqLP2J9EoDxfqXU6iFldMmov6+ff70pkMahH8JyLodh
S1h3xSpG01U+wFOGPEbw1UoorPZLWdhgQf9NEhUrwIveia3bCGXyZPzxIGa8exGyrKOmTOmI
HnVVn9PmJMivcfTZCCtMLFn0722rauIeiRoFMnfBkFxCzsmbBzp9ZxBrT8VHjp5Ot+HlULls
VNF8W7gIVG6zSOmI4WPg/tEVymVrXwMsldSwaNE2Vet0hWbPn1Ez01AKJaHf16GfUkNLjAu8
nJw6L4wyYrLpzw+6+fOcyNVVEp4zuny/ywRllR+MJy9YUrSdZ1Y9NNlFlR9Q+xBejpjHM0+s
cJPZ//tQax4aTQ71ANHHS+FrTA4FqKAU0N0Ie5HmVkLiHvHrthscIGv1zOiz6lfzj86gMHjx
VUZNXjD66XZLr04QgsNYH0eST+ItrKfBBkw+ebqALUST2UUxLGsmx7IQTz3A5Ch6J4IQMRuS
oSRSkmlkB9U/CatoFXbl8/sFxO3BpOl1eCHuKgyX1bYQvLVEbLYfj+9+LjIQRf6tanuWCyPe
jxs4uSaIIg1VylTwY5NEchcH520k/wEKjWElSda5MWYnoUA4TkoU4QX+51vHl6Pfe/j41OP/
ldBsxXezQt9l9XnVVTPzgtS2LAEZSHt4tP/g9fO2eO3l7CRPUtXQ+tfTZLo4dFV3Qcw83La6
kKInfIgQM877yyiIy+Wj+yXlG4HynmNibKO9+KCdkKZwMbzf4OdxncbLiOC820WRmTWjnBeE
uYhNFCdaF3Dobl7oR3X411bkhruimPBgRpkYiEdP/Qr8DIi57EGcSKdVcKO8gwgjOC2YYfly
5XX01drvqM6SNSjcwVyLOPU82kMG3cQNkx7wIt6eGEwdJov1PfJQ4NrKeSn9K74hfk8WH/+6
MjxbV/vpgomq2Baad7an7ehhQBhVtfwBCTczx7AnOunEVOvhL9ziblTfHan3IjM/XgO3UYfx
n/4Ke/bAJxqFvC0KRe1dnDlTRcJ1TG1YCjqOd4PLbtFXDA5kKblKYI7htpb/p+r9ePxRBQtt
T631Xh1hgJcMQ2alcKHoemXRPObms/QJNGzrVkMTGY7xScSIa1H0fZTGfzXwAQdRq63oL6lC
pEa7Ja2odFG8RFK69dIL0dHu4A/Z5pcEcF25zFQMvdm5jMknKwGxguJP0gz3vlfXY/RJiGrW
TMAJ7ulrTWz2KJ10kp3JU7Q7T/gUdgGc/7mxAVYDpptZcFKsg/Nt7sEyDVbm6MIEhayf3cle
gCQ4T2MNrl7nKDrbJ1/lU/f1OHBHZ/zo7y49AEYaJeUkyAryHc5wp39UXWoClpzD1cNFObn2
OWYTpkSeHMCnrGenyFUDpsIinpeyUPLaTSv44ORbgKbiATBxMwiiROZ8spmBUtWLIEDUa75Z
5YKjLUfuSStTyo6U8WdemCUhqQCrHpwy3h0TcPaxt2MXdixyMAxy3wZSaMlrIVue6Exhf0h5
z/j14MlfpJiFt4GrdCSN4dppbMs+vVqL1H28vWwixjeJKC7M2uaCsW2TP6zWgewTqINDyn56
KrRTCrZZuQW0yusam6KGps9ToLhEQVwghAm7Rax5EFZc/fZfzodDYET0j1oRmKpj9tpvaEQF
666TxJCew4Mg5XeXTYQOpiT+AH8He3pIFx8qfsas7Irtcmz44n6ZS5XDn2m/g6RotTavT+pp
aEydfw9INOa0ICZ8qU9q7JXwNjZOkAV0woJbPVTwOmTx0BeuquoCFleM4ZEBcT7GWIvoCSf7
lW/gIy5OhkOxMwnBG1MGCYSKaKRWyO/Xk6yoIoqbmyVwPJl3E/KfFZKujudiVlgIS2ZIiRLq
92uKJxirwtaCA8qiuv6VAktR6Byj6lGD7fo314iNWhFVEHaVaOze/9ScLP58f/eYoiF0mpvW
0eaR3myIo9CkajC+K2AuTMRPmcSxIO9g6E+27oBQ8iadbFVgFogNqcMntLdaYVQEzvTrUhxa
eT3BwRUbmOVO40t+uJNnb4QQJYU0F3QwVRpWtCZiTjupxmT1/FyYdsybjodLyhwklUL+xvLA
FhQNoNTs4npGia1mTWsDzUdAMqtP0OXVjW8F0lRNF3b7T0D7h7I0cFTLnTSBkoTQRRTg6jS1
dC7VLh+6rPLOymQgFTpKL2YrH3TAvLq6kF6nVR1SdtE/EQiob+jUTGlfjdAjd1WaT6aTrNul
xYzBoAbSlmTdq9VKtY+RpI4W3JsDJPiReKAVJIlNPO2IJfSe/I0Req9pNxzSMeGvklqZiSpn
Nu0LUKfqTqqAz55iEuqu6A/p1nRdvMGqkHJ813jvf1NWk2nmzbTZlLC33E0HxcFbNFfspbjY
DlzRg3jis8FOYfYau1ex253Tz4nBlYilLCQZOCdxshMnCEWNYanOYskplhNBCik44Fe9Qi3j
rD4V6ePmeNPDOes0lNUFozmNyFUXXs1rE3ig4HqQLMbX8aAZ9OxtfsZOlivJr9FmBeNuj1xr
Qiowrgd+LFpfoz7z/E7NlbMzEuasajNkgglTctBRZgqecoMEzWCCm7Zo6Hj+RJzpU7fnJa5e
JaK21Adx5cLQ4MXgD0/2vehCW6/MG17/jLsOp1VDurxTtuAT4dnHevUjzx1ADdTeddVMRDFj
f+5PlwGQDW8JdFSTNyTeUnKjd1qTnGaguuAfGSS3OkA+2M5iJI/s1S7IogbqagUY8F6DmwnO
i2TxdotwbGygOz5ktPb5TDhWCBbNrhz9t7vyEQBAPbUpws2QkBaaVxRuRYKe1so2II2KgdHu
MJe5elwDqlwPhNy/1ZVqZxU8xY941YwIh+pS99G8yaUu6n79c5cSJ4ZKXA/Ho5S19FbJ0A7M
IERcy1Z3rneWa2ulBY9anur+LEd+mGWkDAU1Bv5JYVLxKctQVXx9b8wrMQKvP0+v1Gg8RIk2
w5oZv+OWB+zxyKTmcGRMwrEsAU6sHmsRzeNiBYMdQcrmoMqpx+2cLEOEw0H+MNsQG6Uc/0ZJ
rr7ETb707XCvdwvhTvynHmlG9BrMEvG19JRrP79bSMwOqQxsNb09bwZDMcMWQEMtIWwdsRaC
23RibBsbkElSM+L/Z660Ol/FT3pD9RRGfeWVuBuJta4XqOqU5RK0BWmc49JtRJJ9jFnKep+Q
UleeeTiDTHE0YBzpYjtmqxvzVjywtVfYXphr2XCdPPO5jWIVvee8+B8/qOZ40Dh+1a07vEKp
Y29ukd0t79OG9xlJ1iXU1zUF/i8fMwXmJ1CUNMSlYuJeXQB+zfN9POJe3HpJxfjh/fR8aeZ6
e64losDnw79MyjKD1WessGCIw+AFbw9I5J5KD6ArHfNpkN9JaeAeNmFIU6eGBaKN08SczV9B
vb+Hqr6lhQ/1BJx46phu+r44eXTP/UYvfrPG45eT6g2t1Moxc6Rr/I+YcfrG3Rvi2sZqq1p6
V+AljKEKutlE+pMo6GBEPunhbR1UMxcABg+cFOHuNkyl4S/5wcKV/Qu72Icj7lpTxH5EIIDc
TyFQxBo0JVX6Zld2RgCECbM/BEYnMlQz1ImY917PFNvaM6XdEDS9+Xay19k9fJF1AlknJl97
KF6dOWhVTRw90Bkd+atg/7HBI31oERLOjPuyon30NrK0KGcNfLweCOvu9L+e1SJrhNSSdwX0
/vkkZ19I9CwtzpvRqsvIFyAzkblkzL+t5qHqziuSVW44MvaPJm60V+WUnWneaFZUen1dPo7l
qGIka+x/h1QpHMeCAYvka2i64eKAiYlxPZgZF3dbtfjxK5cLSuX/H5cmHRgpjWkHRJpdY8xU
nlP2jFBRZRw2Dv8q8qcSGaJorgdDJlozzL84Zqq5Ul/odMDlM55Bte5sGmt/MkxrAYzmKXIX
P9mwUHGedD5KGb26gUlQnGsg6btFv50D5IAeVlnE3uU0bx6+Wy4limPBtTiE9KgdxGBkv2bd
nu05shDrpc7q5A82IyqzFyVXUuF7TgOzhOJ/4RZ0njdCAS3xjGudvdSwlDftrHC/+xGvuGHT
HekeE+JgghY3jUMyZ8SylOLFUIOeuK9N05AImVvvDFuPT6WEEN2xTqDAD2pT1jHR9ZhJzp+N
+txycC2ovl+aNMqoEfbKnKMHH2E2pShKMmZRzyxmF5JiXi5qElodOlsR4HMb7RdKPxNHQ4rn
gjvW9JzB+76Hi/n4+Lbp6mGVRaw3FVQZKbEVTGL68S/mgsVSiBvaXxm09tcoSjJsrmKSe5pb
DoayT/p8i9diJWaVMgNTLbRjgWqu5sJecwKikA//pncwitEnHultiy1TkWLZZksbZ/liUZz9
utoa7vaau52QNV9kfZORT06bBowncYuI1LrB9+qxQC8JIBxyv4HfCrmpe2FRKzTQxaQ0RdbH
Z3edvJOT4H2RK1ptrTPW90ngqsgUyvO8aW1FpIOC3laMO0BjbQVPWGuCXoVllYo1aquw9ZgU
bcVxeEGNz77jVWQxYSwv/Lo6M5qciL+0UOJI0Gv7YgGmli/paCy4y6MvVLuKWELAlbmJmLMQ
DLDcdIyRuR+WsPG/oY3gikiOTgkuhzk0peTc44sDuZkhPAe32DPVnCKzy1ERxd4ZqNB2bS/R
RzNz59J77fSpSK6yot8ge1/uqENjAV1FdghVPi06VLzXVypTNTARYPmlhZH/IHw9pr9d3I2T
d1owuULoOdNgjpNXCSp/yu6fGLQBnwG4Qh7S9o8Nxzfb5NK6bAekreRjts1ybqn+I2wXVXuR
bLKXqH+x8d5ig3F+UektDnW74wx5tjaHELW9sA3Z5YXrxUXIkOsjw8/84gZlue2JEqLO4x1T
eMr++L3ZJ6E5LvvLR+wBX+NmVex7e3kA+NcHcOH3O9Kj8SD3T6+XC4LU/qhAK9r4YbHyh653
m23oi3dUxacuUbYbi4MX5tFy/glMDv5P9rWyfdMxWIfNRO3BbAmD07zkm4SeWY9vBrFYvhzF
um11cOvH3kTIg6NOQqF5jPAGmJBWaMR4tVpLa0D7QYgdq+wUaBd/4fHucbWS9Q1LK5+hFjkH
OPw38F1EoBL9bgFN9wBbOwN64WBgV/zI7xTlD0rsO+1tDirjG5nD/ApcfqWEOgOTAm6KkZJx
ukuonDn6G6JJ2KloQ+nxCSWBiPI5r12zIjF+zvquMZxzMB4/mvjF9r90+9eowgJdfEfTN4P8
vlT2sPyb7oXawOVZ54QTvyolANY5wQkrKXM0AZj0yBEcLnc2Qsy56STIiCR1g42ycotuJPoz
2v1wmeV3ofncwOpIPu/3D6uOiooNcLv3jtZ7hf1b10Fw7X1rb8+etzbbF7BIibidX0UvSUMe
c4nWDIvUgZi4194zqc/xAulGX3Fq7pw8QTQY5JgQll2ZVY2QITqsxmyAu1DFiUyarlPj6Xdn
bE1+QbY1Qbwan55/tId3wSzvuVXWrc/RlC27k6vt0LCJEAT+za9VcMa2nHvxCcDbsM/v/FMw
Dv2w3suZyyjMmJ+TBuuAYoYqJWONN6FydXWie65QGnWB2rIU2HBceJH8EG2Lm+qeTOYzuf0x
4b2SlWZs7hyPLT+PoQ0QzL/wnm0se63+fO4zw8mXw7MKnPvzeoBwBWm9Q4mtHqzVVwmUID+X
y3OuvwIPuQhwdvOfCdXJU0/J7oSdv5TqMEdu5r4ZRq1395LOWjPfJRpWyDAf7TFtKaSUFFqH
+hJEvnumG+2nGqN2Ztu44MHFsqQFEoCwKruin9OVuYgfczUBRcN6BnZvXg+7NZFHefYwt9lD
4BeDK4k0QvgmAppN6NupCyjNtfwL+pXvsbNTQdejNj+vtsFe4gtd1KApSMzDHRU3WjNaNrXu
4QWLXyRi43JOKr4XNqzyKyLRtjlS2IoXGQCICb5LVz/TyVut1OxqXn5UnUlvXUl2hRDfQ1B9
3XF/mreXdphK1T0AaEbQo9gHkD4ys3xnb3VrKR5SlcIPEI9Ew/HUtuIvJqiwQxctQJRHGWNM
6Eaufh4T3xLEb8iU/p2hw41Ajq5XAsYX8/K2RcCMcvIh3tVzix5SLFYUm2F9w7N/LdURcjQC
qrHcyKkMRrLLdZYGwPn6qdOxvBVVKN4RG2YKQUMcqASUkj2g+UpqEvedqnqrlGQFtfwY797r
Qt7YFk0Q/z+ACCgiHyytNF2skwobCHmlgIpNLohVcCP1mIWOztdAyDPWJacFUtv3A1OcxkkJ
GLIjoLg6Hfw4yGA847j0EOHle9dfmhNFShU5Cs93l6MiapwT0YlByImK1TZbi3LvXby1pqQL
VnRPfT3218bpsuNsHIvcOl1eKKwPwThIYLkkvt9eTWywDhIr6Gij5MAH5AxB92pgVQeqea+5
WNzsmQLOmHY3LX3yG9xK1HGDBglXOx0rXJ2aAjWFTJzPp3B+oOcb1w64FiPK2HWCTW1peVUs
AKxX3Q6kkRjJ3w8TMyWFfaz4SP6JEboTjHVdOfoAkf47jKehYBU+Ebd8NoG5qsbKS2I3aPFh
Fpo6jmAKE80u1OlMtoqTEep7wJOFE5A9wx6o8ug5H2yAipy1SukCUTd2xPqKMw+c5PQ7FNBF
eDpgEYDvrvpxwXAGZhzF5V6pDu/VP7JzR4iyxwoedWhBCbsZR89EhczA0SvUMb/wR6Yh1Vla
y+OGRVC1DSV9Ziya72Drc0SBqDGgzMGs3fe8Td8YtRAqf+qf8zCVAkOk5xtWkNkPxCH74no9
6zNG7oXWHJ2KU3cjTs+HGYvoOHE3wUlx4mBjbU4IWRr0bNxKXAgCoUB6XqkMz4IIOWgAL76k
czlV4K5I27L5t2CX1GZUomHXFMCncJIpyiH1pDQt4Ox3RDQpAxz6YFlVWJ32dt+d2ECmKo+g
fBcOrxp0qpLiLtuoUrFPMuIg+qYNvCrR3pJs9UwNeeyQSxgmirSgPrX1bJYCEdrYMiV5p2D5
L+6aDVyic0PILE3XHbAt6Syv/g7JJom35OSj0ZdD0h0SAeFWSIy/SU4KDqOIRxHCxn8vbuLw
j4+X6PV/10U89/vf5GU8FPE4E0NoUDdkTywJi162md3kynR65nxjE+qP2lwUGmgb4kEyQjoT
yh/DaKDDp18MqsrxGCR5VgtSog/Y7QxRI7V2/q9VDGR4TprdSua5RrlU/CpnqDOgS1gSmZp6
4swVw2YdHbYiA+aDEAYjmzQfp0LNJWa9HGLXBFOBj6XvMecTHGrV1ep8ExrPMItJt7Bn3X3v
/tyjZLahyhEcu1cYjG/eS0eftwdFLKkJL6w6sCaL8FA9DZxQOa8sfAFMQcJm+gEz4uvLgjzD
tF9txZF3Az8l2BY5XDEsR4syY3U9lw0mIgjWoBcAoR9WQhIGiyGRKyMyh2xG5rNmP9gcq+IF
1g9HMKd4D9x8efPjCMl0s7EJlQoQhuQGSYvSBWFXew6FiAcYaxbS2dZx0deMm7kFMNtDzlpv
BSYoKilnG5w2JiCi8pixmUlcK1XvFOFKDDhiOgBZZyDhqyk1L1MlqG3DN7HP4CUfxA0juAdz
k3OyV3spo1qCJX/5HlUUGEHE0GiYUmIIvVbaB8ReQq9FfvMW3EzUiF4sHuo1VewIVZNs39D5
uPmLkm7YJSlpwYEw0yE8iAVhAkKXNWzjA1PEnjGbjWw8l8NeCZ2xPFsArjn48nCZiTONU0+g
x0VgP7fDWDqujacN7uwQ96ufdQ8lnSKcryoQP+10ctBXN2fYp/QHnsn3y+kpHgaRcSrhzkVI
0X2JJdbo6fv9b8D0f4hjRRB/iZM414klW3WxubAnAeEnshzi+ETTRlhP9sgjjG5JQ0MrZmD7
kqBYATBGyDJAGVSmnOwzZ5gsKx0DrKYZpVH9gwFcebO2L/T/u4WO6oKF1UUz/SoC+l+O5FEF
7Fo3CUog++XjOwvP18OtlRZAJs7pSPTNXxaReI8cNcsh5pd2kftqSNAhTkxyxtIULBaLHDnU
yY8bOiM/aqCcyGO3QDduLgfnT4R5kaxhEI3mfdaq9Jwc1/Nl04ruEFo/UlR2SY9LH17uean3
t666ScTFAjcKZatc4slWo3vwPR15CX4EldxZSb+PKOaWBAFMIjv2Pfks7KvtlsT2TLD886IA
UktnNo1CswSum54+A/yyqlJlMvHU4hOcUsPMbw+/2UBsjpZdsrqJdXQTCRD06gpkMYEZrbwu
L9927NwLy6a5fSb0uUtQAlrY5YiTLv9CP61bbiCbV4m6CtRKrIxZ0jl/LyIaUpGUCSQJ/0Ys
jPqUGh0u40bd/z1YdX+kxBluDolCR1ma64Li7nwNJ9c+ylno5wkGaTrsIoBKBqXARsiGelnQ
J1vxRW/8xk7E4Ns+tZ5LGUfeH+mlRF3HF8QVC1zWOGrEfWxDDuA/GLhRnnA3cYbBMKPFKIxV
PRfO9qLIJGLKH98SCg8fDBfrpNr9GQF1T9Xmw2n53TnvFwVyrkmZUw/AooKNDoYHJvzgunM/
I/EXLK0iSvpMKfvvk+QbXZF3PrSP9cxu7BsLfVDB9xZieQmbOo9KzvNTY8dRUR/Lnob4dbY7
73lBq+7A9LF/XFGAukbvCtaLbAPXmcHxO59q+NmdGAb6FtFY5LW981j1SzZKltD6difD9XO+
pY/7Fy3s/YRdVyvwdiza33lCdvLaqw82Clxadm4Njsn9zhXqfrdJnLwdRaGuXGiaqK1PO6rC
zEsiunkppJ8RbAP7Anr2wuLl7CufNrma7BpeTBOKdmS4sZs82OXq9GIItKP+WQoPE3vRbC6j
BDtsb5dhuaFP3cTMl13e7qFB/bpiCVkmJ0kkXlBvKN9261vCXS09UvjQXgCipY2BDOG5dMcN
1+x/7eKSoy5C40TKTS6eV2SkrNFdRY5hav0s7oR45whfzMu4zznF7c7+G5xEfW8cb9iivQV0
9zRFgwlyAAGHhIruRGpIZ3feO0SIO4soERkSL0omFI228x2WqkR5k3sVlSSuJTovtaKkYD45
gAGhwRPiFFi9IddW25VS875eyoLsJEA6QkMBYHpsYwZFMIC6wcabs01txewtyHtfTk8+7Y+N
nLcHjPXCm8jh/kASEeJScAHaNBp2j3v76ncslov5tZIQUfDnr4yPKuVZ/EYAPjZZ81yaQXX7
UqlWC20uhy6ZbtlHy0vGanY0vwiHodXWXO0PC0qTgFfn9jh6SnNwIKHHNwrfkvDM20R7sBHE
GMTj/H/mRaHwA9UAmSpeFl329UHLMUPtw2RSXiP5xXU77A3ycTYXp6LR7jM+mR97ecgT/l+A
B3IFF68YXhbWb2T2Kfa3fQIpTWNUEgOHLwp0OwEjdTT4XBA1196u5gqy7cbjSE8EwiXvFdJz
61z1V75HgHiXCforoLIw/eQc5iHfYsHIqu2FMRsO83ms+nf2AwWtuSNGD2C8KWIjprFil+SE
W5gOSmarQaekGu4TN6U52g2jowQKkN9+Kpsb/1LbacLeo6t8Efw3C14dfNNKB0Lm9YSuHNeU
EQKQflgrSSQ/uz2PxnoZvTPvkyjhAogDapYZoBBhuliqsaLFHaD/5IN1Ti37WECnw2JSQfYS
jfFFkDDkacKHQGJUc0eLBEEhSzvzkd3UgvqTelNsY58zKUJBkkKQYTNa6sZrcvY88tvrsBed
vpln1LNnAR6LxWaYYR3sHNwYjlnx2gyA1L24ZSyDK+HmibmRIRPRJmibwOsa10kexkzeMZv1
KRPlKcV7qlbB0cCztIuyBqM0usuZeqE5SI/1ml3yaww0YHNGhHuYqtRKc0cPfhoo7c64eSZG
Ie0kcFx7KRDSbjpe2C5LiRz8eJTqyJ/aGtUqu1MabGiPIN5IwXx1B9WdyFhL9Lb1Rax+o/56
s/M2bkPfxrqbbnLlwoNSJClRgQ1/l499uYXNof4yipcvbzXuiO1jmaFUFpCWI1t/TmWcVrt7
Yg0F2pd2kRPBp/cXbcrgVk+LbUbhNNn2L1eIyYYoS0SD3qZzAVqw+V1uTYuSKkoBc6msD5U3
/80j+NaFSVigGyhzM1I58bmotPoHXIHtJXvjMS+6XmdMuJiedl7tHRzx3sQXoHt9MJrDvlKc
YMycLecZv0xy/RUjUCuuO8Hk2xFfI8cax42z+TGEm60ewoq2J+bLn/LyiW9QtHqXXywBj+yl
w9s2lkNy8UPvd2ap7WqMShXUgxgcx2Eqnn+9OQ0IYHK3aj56/9GbilKKhYoVmuzLUg7Lowm7
EDcaed+NBQTZK2CozwWkXIDe2av57/NELyP7x8KW8ooUixuq/5rHNPciesR+Sohsq7rynuZx
6/cQLldqziBQSBop/GJC9ExcohE7BZZT9HCQpzm0pmsbsWg4rfGCsuJJdiWLNruFO8pV0wif
FeK8KU4EqtXvSWTABPLDl/OCNqclWYGEF0lJDnrOANjYOUULi0FmI0kPP6kBS/AI8l7FBaM3
+RjYCiXt2vY0UfeojfOj1asn54IQtTw1fxxhFzFBwDVL2YY0NSNQH+s64iyzLZMfoJuw2Ymz
duFnXV0tcf97dFIBLT+f3PoA7wJk3AH6g1MLj3HrR/zPSV4kPFX/OrK29WrE6ojhzARWT/1v
31zxy8XSwVx4DFFciS15VZMjznLEyWiEBLm7Q5VZV4//r5G25JUcjWRCCY4Dw/83vEtFcx3j
JDiqqYQYNbVe4aJqFzzNBSg9m1UYUy59paCxhNh5BV2TDQCIc/KHPGivpMxwGsifbwN62ZIy
fJbuPMlc5axFXZZM0w7K2y0b8zMFo2f0ztqfniY4A16cM5L2ANnujZS293TvUQeHVJOc7KR9
d7JJvenAUSynb8/tEQNXoFaEgc+11OvQRxKu9jUF2y9eKPmZETkZZlkqOZxhj439vNlBt0j5
l9B/T2wRg99Jsc2wzbTNqOFsrLxpxsGRdb0A4DlBZiDntU/R7RUqpIhcemgHzSOrEYdcMIYJ
rSrZdxrsa3MGtVi8sY/vpFTnCIWnQqtnQknchWUG2nM4wOlndJj/VCNUz5oN0HH43ovIHHAr
0IoKQpTeE4cjbfMrRSPOUqJ/Gemy/im2nggwK2HEeLhauQKAjlGN6ra36qsLwb3MH3tHe8Lw
lvgPqsPNcckHTT2/kJfvytAaRa7xk6KaBhPrYAPDp8QakTIZcsF6sSf3R/YSJ8xfccGtE1ih
5Ca2UCtapW1Rlg8bppZ8e46m5VAqRPLOkfS/qpFSMdXVWSZtC0f1KMLhIc1JaBJIwJYgZ8qX
qo3myI//PaHL5v3gRcOjMVzcBEcfzTBlr0nfUHocCJ3nTX1oeUvmLgmsvEE9ds2evUFiejCc
QFLNU72AtVLawgfbkH5SE9uAG+x2ZS46AUCJk5uJoIjh9F7J5AlO4s9+qegnadaMkawTm6+c
kQAY2TvVoDuxo+gOVg6ab4qDXTxTIO6ugsM4qDawubClRnKPQ1pgOd/gMUwEitS+dVo99Fp7
FPjK9xrY5AWBOxZs65O4CGVjt1feve6jZOA2hrYeUYWKlD92QQUvrnt+HWb5K5GapNwrV6je
wxcaXsaZJtaZjETUZoa3nfb2KE623/qpbL3UihGEOBq2f0Vldx1hyaAyamP4F2avcft5lOCF
LkWK0Y/cnujFdME8TyaqZ3dv3jBVdvyLUWOD601DrFZ3Le/bSyi6IiCBT3Jrt/Or3ks9s4lv
24tSGrusPHS4A2wziTo5TZJ2KGRoWS8hn8/PzkWE+E5aiHlSp3G3k8ur6PqSd9Yy+PHPgOnp
ufqlT5Mq6aTHuG5Pndbe0MHSM3FWCNrqd/XQhr3Fx7Y8aOPh1E2axaOqZJ7xajmMA2sOZL27
epwNpY9Yt1fGryAOHHHXKovR/1hkj4Z/YvkVxUthh150iBKSq8XMWMgo1l2OK6vQzXqPESx0
AWvxhsOjX70maREaAuinqe9dhJxFBb/rzxfNfsm78D6ZV413IQm4OIlKaf9VUdtu6Zm6cpAu
bmwACP2BNTX/HwXK4wRWPajKrWl1sMdWkDbLj7a0rR82n6fceZ8a2TmiIN2b8VTk3Db9acL/
8+W0kJ811M23bGI1ydZjVxSdLWNy3uoyBf3dO6Nbt2cTFYPuhpzFFBzJRZ8KugNgDUYf9BjV
r83E2ggav2MiiOBlt5SctXO/iMB8J38TBXMrn/zRLCmqnRPmp3OQUg7OlJ+Ad69VBlL2Gc+t
d14KEnb+VC5mdvdnu69cTfZLgof3T7rXi5mu0upm+qX22wjJnWn8uJFQfiAW53dG2tg9oVxF
ilFLp/JSrHO4SGrQrs3aMxM19z1Cs+F4VoXgcrurVVAWZncdR/5B7z7U8KDOd06I4GPezEYi
ZprbBsu8gEm50TMZ1xNGWjbNJNjD5+xVmGGRkroV0sqUCxSv6o/65Ylb1H5H/VHZ0Do78jFb
VHLLF8n58Gdw5/jV8nIKdFeCoI2zD7muVmqmclEwyqLIf378Fmd8Q/fAQqdmG759iS1OfhxF
SE3ufWjT0wPiiYHlHbf64Tpw3qm61tJd42RauUzNl/rm1BuI9lzriMlwZNFKfaVj2ZXNXPEF
IfdYp7/VdxtSDBFyc3CgPIeT5fOXvwH/nhMstPslxxp0CMydVLmfK6mdLpzCmxRHHDt+8nDq
qtv0Z/RmZDrTl5427ftaj6xk8IJJ77IvJM1aqlXgfaQ63rvl2yU5m/06htZDjUHewEAoqWrX
nToIpQPHpyxnkIGteZW+YkuTtTd4Z57SOERuzXHZxbJtD1T+mXgBtiQcFqOSkbpzxA3jR5YY
MJsNZOUxL/nxuK8MjyTVzYAK8eatWS7DnFnaY/P0EFkhaMi8gbVwGCGlBucbTSVXjmJFQOUZ
LsoWonXn5DJPnww74xamAcaEmKwwze+pOsXUzj4qQf/KDW+nSDabFzbRiIH5+KJ24q9dJ1Rk
zY2rv13sNerBFPgjp/F2AWsTFyqPShfCpPZF1jZYw/e158JlGzA1ljozW0TJdwCOWBlCPEAc
YyBlxXUhWEXLlgS7EIr3meli4Xr5WssPAjskUfbtNdPmwJilCpBrBOE3DogA8QwWYu5TtnG3
v8D7OeQ+5RGNVZ6fCfCY90g6DPdPRgXtYLstazlKzvqUOBFYKxJnIhQx51b1SQ+bAyV6JmBw
+medmhFFy6T9Fn4lqFL5QoWfxpphJS4QRxnv6TrzOAYZ6BHf5j2la7kh4QNM6SND4Drx0e1j
9n4d3VC48yRkQuGMKVv3UtrOM6xRNGw+6yHoIT7J8lpuQJqCmrA8/BZXLYWxNiCXMCE3d+X9
jw7PKegUAuUCg03sFE4YfrlvlVofJUXDdRNkyH6LcQziaAFDGPA7fBk6NcpTHYtlGD0lYlft
JSFhNpKJ9Mymsw6x9ADzbjzzEyVY+aDgxx2ppPASMD7oEmg7pHjBVwp/BmLlE6Rxyc8fMfxc
ZbXDt2SCjfZzWaF/HSHYPWwPsNQwHwgpFdFzXP5YDbbUNzPC5POzGdrjTPaFFwt862dhcU7S
Kra3lkSF/DMvpZWctBERbaxhDnmm55vFU5yWo59yXY+rHEvjmb73JjQ3ynBF9SxiRCSlS45+
9EYnYwkZKvboKmZwOdE9ko//lNMHOJWfEk5fqiWxqvOYvDcBcWdYwG20FZ0feV1SSaqV+e5x
robiXxfRgfEONy5LUDB7ng7enaV4X/QvOKIxwy27mlSikACuMnTJTch8wH+dpI/Rkqaws7ky
D1VdXJSL3w0ZYLSHJO/UeoozzIuzc7Fcq3ZxwspyHxB7+A5YCMPBjyTVej7qywQ/XGBBtQ8N
93iUWGfwTTRELFRLJeLFd2a0nSb4yxTvFAKn8PnjwJe295nyzKeKQffcZc02wbi9HlYpn6Xf
l3w2/s7FfWDiC0S/D8jkg4E6ybQqyqp2TEiSAU/cI1PiQJT+tmV0AJ2wNpoxlF2ZB4/SQpy3
7pO/6YFkgANfjerEOyhuGF9UnQ07HmiLwbRonVuuDCkjyi9CU36vmw6RMD+UYAbRqr23WWyg
m26dv0T3ZZvAi9gylGsUoVqXKwWI2VUe2SX3THaGYMo2lSaixyzdo1yBdV2ZlMqoZQsKrDN+
DbI8tkBPvKJ/g4B5dRxcn23821kd2UPZFN2qeGTlN+Q5M5+Mtlynm83bypfBDlVHD4y0/nBW
VhbxmBtWi/kgSjVqedXuD960G6sWlTpGdc5BFvUHoEZDVLrnzswFl1E+H3wqzQZBSoeDtUJe
Cv6gONhYpABCtC+GerhZ+5UXMMcNP8KM33a23ldu9oFfYAfWWyiudQZvfJN1LmwZjDkvHNNZ
cnOHTpGjVlyHJpvobc+PTMmzAMbDVGsk6FBsX6/iRKlOzvQVCIL8ZqCJQ86HzojQZ0e+K0hg
PKntvM+ERjh+SzbhnR9xOlp/KhOPYiGtzlxo0m1508w1iF6YBAEWjchWgKOUVXrFir2/Q8NJ
aYSc1uMc9AiK4Dm0JOD999Jte42cdg9fFcwavHvPdSqdO5SwcMRVlPiKS5fByyvX/n72TYsu
FvxMXVRI802pwcrJwRU1ldYtgia9WXDhucH/trKuaF5yk7HCdIQpuXYYEq6UjB7QJdzv19rq
+zDuAZ7hEsZ2u+vcuI5Ih3+YuFI264fHyTTlPILA78SBwKz2sZIUfbAr7HFPofx93keCyGUV
iIHIbViL4fUMFI/bSuWjJwxFU0jgwjhszU/ODDK8zoHZ40cA6TtSA5XwGmC0rAfcQCSrrpSB
7r9ljEW5qFHpg9+7vkZm3ev5muakpwfCj48fcTe+x5B13VN17QxINEQhTPG9DE2W/VWX1BeK
DhtTCsf6zAJcE3HFiYoZtvfPy56D3RWv+JGA3t1mA3hSE6KOI6avIOSokaqmxr0QvZ0kpL6U
HUPqfSvIioBy0Zp4zLY32heccq4Dj/aFR5jFmnacWgwThIleYlxqu/mUcL5lvYr/vtAfeuFv
/LoTq2hUEbAj4noLCeCzGNrrZdQ+oH/FYhgnMsp8xAR6T3vrM6yy+ilwcdmmODAnWTrPhNSI
cj/zvpCEUTQ/EefPUnv5WsvsHT3IJB1OUOLqBu2DSutG/QmjOVX+LmbHeEXsLPmZXsCtn5hD
Eqq6ZcmHqp8w6JvonaYAQxkjAD3Bvc5jjX8m2qPSnPT9o5CumgEbci8axGwQ66JMbMDmnpoI
bxG/BXCu5rQX1Sdb76b4XbigaBbaYiBlSwI0g1r+wLZqNnWbygjZ+bvqNX7SVP7yRgkoBuOr
ahIxCg+Qbcumt5WCvspbiUBBoMzHwsCwdq3VIXFOt60+7l1LSWTKwRvicJii8un6RKW+5K3L
YIjGX8gnR7dTmPWEdTVbFworY7cKlE5gLSVRx/YcHROOwCf5K0rD8tr6ulhUPPFsXtyOa0wF
ZZZ3CeyHL2YFxGxyRgvqRN4jR/xNKZBsgL4qwhNbklNKG07O3QlSQSJDI8zRzBSKe3ERmN1k
3FHTZ2KxopRML3rDGS7JkLWlDqHuj+Mm3zod1az+PgHW3p6Ssn7lCf8hbFpJYVqWaW3GgyAl
f6NaMjSFGa3Klx7PCcyr5pLxhg+y9JsxzkirnszYkYsi5+cMtZM2ZADijAWQO8b3tWCBPAaR
vpYyaoc+Z8vGkSrGNs6FieKF+qOXHA6H63dUzSDSFPjC5a4PvTcu+blW6tigV3Rm3UI+d3rH
zotPh0WST15fzE5zTESf0DHIaThV8r5kzdIKmlHUKV0pcvWmc3HxszTALT5bmpT3LpO5rxN9
MAc+EUX4E4YX5GVeGfHGoBXbzCx5cKWRpp5E7KlgAro7/jxuFLOmuPLnl0N1e25FrkqApyAc
cZ28f63MCHILY1n+YwIbCDwzZgktTM2GXZOnpaVtmS3aSdG693Wg+xTgOPLZUvHieKQHPUdJ
GuTmjgcTVYrSB//VKJUk7UtLPHlLfv4UCa1WaWZQEInBMotuR/DLv34OQvdIglcRAYNwBuVy
66Q7S76E6L0ebzVNNn53Xisu7PnIECwEa2CBkenO71yaf+3eQR2yaFeg1bZlkY61Y7+PrV5V
G6yGfZV3rAHBG8sbaS7D/y3UWT15z729vJIk+p1d+eRZx1/P3LVRY2jzTPYvBVo8vDiLktkm
2706QyKXg3NAfiKtEuCzLN07ZFuQQgQ7NlozTcYRoMtIRoQsb20RHRl6C2l2JuPw0BRuQ8jU
PKcmjPvZaV5ouIvj89o+d9Lrqi7uOE0hN0P89iJgd3MQIdyBPBBgn/DfPVY2tpjpU4K7zSEc
U0IFilUo61wxzgFHSpRILwSKMFDkpDIzhkGl4d86ScY5RMUf15yhGpUg5BRDY6O5zWq07Fsn
wXAqoFwWkhp1IQK09EjPtLUmFdQrli2Fpos5bVlkKHrbkg3v9a85p2pMBZXqREoPjHAmOoSU
UOvh55PhyGMXSYnGhqCYYqUqKFx8i8DwZsAdcYy3UIWL5TGzeigUdI/uSZDNdeobBsceYh+p
siImDJJ246NLQSxijjN/ZP+3+ulsrss/VU54J3EOw6FRN8QD0qb5DOEfjtoIc5aOamdP0XAp
LYKclluV6GGPqh4QfnuAmBjj20xDFLbr0i/Mms6J3wnKGMVWs2vAwMnfkrURWqWKEooj9Iev
BmHTWv2GbB/0OumOqlRqjYxuSDiTzShbNhV9ob3wAE9WNsafZrKBAMNM/cUBXRbR+3XSb9RZ
SpLjDCLKF4yLq9TanEJzPEWDzLMUjhAC7o4Rp7e/jdMp8l9egbvfMRWqz/5WOBlItJUCn8Tu
qQGEeRCG3v36VoQB0uGWH5Ftox+sTeLmU0hgy2XD4ATUz+QzI6aHY4nRAFosLHaqeZ/d9f0T
AyJdisEQJGhdCWpGearGvCS0Jyso2zgsrB6YcqOLPeKy9LUF2Ta2QeZkihodNqw43AQ2xRbw
wFrP/y2ObJ+bK0bnAgDg7AwMAIP9hiqMzIoywxD8c97Pk+yK0dnmdtRXC14rULW87SntDRqy
kDpZVn2gAgD2V/Z9ujx/x/kaeTJxczG0mihif9Z1dVg6rUDVRHTeZ6RoqsUwOZvtskgz8k3+
XmmCTO9hj8sG8AM3Jc/7CJQrcPuKQ90TJozqhllVl04uHVWhi57U7k1FlV9Q3dzmsQjcU49M
c9e49Q6iSC3NBBsi68vZR/nSsVoS3whGS+/P0magzuAeq4O5qb3+nUSO0H3CDoYDLDvdL1MR
oB0kFzeryZx9Cc+YsG/15K3oG5QFAzOR3RPN8KegRVXHY9tafv035uwiVwz1yznNymRKiNBi
JwHncbTZRY+c8kiQY/3Ywdvgf2LA+3nddADMBK0UVQx3dGwZLKI9cgPLggb+OhOiYUdIfZXl
6ZUrl0mymd6N2+GIw8ZMLs9ZilnX+zByjpD+inLUSFRc6NxGyZUD1HhhPQuRz/E418/8OcSs
xwoHg9+2Gy40LyJBMZnvpVyzBxrknVhJAL06Wx1JF4Xmk8iiT4PtJnupDm89C+5pwE4s9xLA
g3RezJ+AR0ySeXq3LzUXyVZO7r7bzPN6Yqavi08Rb2Bi54mqWqwzMkpnhN7ROMw0rh6OLCWa
K0H2YCN5+gBbWGeudgdFB7Hx42esUkA+1myxBMpELPhH/20+XRsXnM4XYqgOFog3/wattdaX
eytayT7i2XGbL3rFF8zeAdja99Gl7nr5DGCqINyRqbqrBu4kqS4etZfBYLIAoT6ngD2/B3Br
q2oMkn8xGHG7LyYD4/CVrIQl9efQJMUc5lt7Jch7FnEb2jKbFtwhFmp5gZgZl/WQ8IhapkiY
c+elWF9Qbz48O4HIXVwBou9PZjQ2jDxQrMesX0R5v7AiXCWtLznn7zijTXL73UvvamITadMA
Hg9KVCsDLC/ls4gvwRdu+lqNEeLN1bJB6OSUFxVVxM9hvaWFkBYFB2jnL2c/7clxutWCmfUf
Tpz02ihikwi5j8ZnIfnLaRbt7UFfxRDUrmacaD31wIHTrMfly0+mL3OAs75PUs4VSMISl1hp
FM+84i7ADt+YPqNeBv1rf0NMX9HqQ8SGR1TVfGPK8phe2sCCmwFfGUINCm93CU77IIvrJdXs
pkRf5y/ZC35o3vbCl/v9F1SScvjuZv4ReYjFQcdn/DQLPYtKHvji9uoISZbRV/GupbrPMhwb
dSKH7MBtMYzxu5XG3pQ3QxmFuxRe0m1oWFDp0g9/kZtp1wIah2Ef0xZ1QsPTRwh48mf9yYNG
yAkRias0eZ2bm6SfhzOWoemrV8MdbTZsH9QFbY+Ftqkj6KiqEgYcIbr30bCHOOnxbQwZsSuL
8ouakLt3XRKOUXOzBtaZlEG7Diz0/oKel+xcb+2eFa0Gye4nV1h+7a5qDjCjSyTBysys8tXf
Kp5/cIZVSAEEZtxcW6rpsjh5eBFwVyI4Z3FI5bsJFDBrdmmhLMKRTRsgEEpZunMaCQBXkix6
SThqAhO2Z21Vh8iyyKbpc8U9Mas5yHhtX7zfAfudyeVGXDTfE2Hmymd7HnpGA5uXw/Ys6Pzf
bw7vZ/r9QToG2QRd8uVa4iaTYPPImRZOnAwPmhcp/v/RuplZAWe/XOv0zQwbHNc6LCfVhnbY
syPgCo4KRrmamGgvklLEW6T++ABtOhzcr/b+1u9p1fyUoaFNes6xU8TpN3NW7aV/v2FRpwg4
YBZkR7WtOUOw049FX7CsSpfZ2B+sfEu++0j0VXwLfxnURTzb6xS9gNKBrUvoi9HjwFxAPX7L
Gp60UxuUbGqdJg8bwH+UsGqmY9zSb7GNtGgp18SOT49zpPixN43D6pM/GlcEb626AWLE+N52
sI3SFQ5N7dibeSz6cMmtEq8H9x4WNocb9Qnk1PAgQGlh/ivh10O1IoZVSM4QY2GhqbyUWHvK
DDvPua0UWD6h4lkZWIZSCfx1RUK9I9oXnIu50KBgPaVnjI6V0k2MNMuWwECyZoO4YcKxM2IQ
8iX0RtY8iz5zGBceDY4Z8Lm4fVrlc8xVLW3vObOXm9hqldZqJiBAs2GaQAkm1bKXNR4S+HiI
jeO2cwMzjWHIuCsIE2Ejfv9tsSday/b6hJMmFJIW/tyh069rA645ZXUJ1PnA9L6dD1/uHfZe
IjVyy7sm4r55YjYxNVPDPPzqg0WavOgdmGp+ID7757Gbn7QaqgmMj7ZuwHtty1huuWUmGxDR
Ii/mRyXz9nzrK3bUL/rUwh9q1joq0GFW2U2xHpFAs3HuUOQQ4HSqGoV1SC0SKUNi9cyZOci6
0QjkApsFNcGb93ysFhGKof23kJ2rEu82zCvljOQLOPpFrs1YP2UFsuqwzg5WkALs/d7voxwn
9y1BVToBOfsyjpO0U0s2WJ88WM0ONseBMGuvAJqBv6pbZC+4Q9mbXchqGQmLvJ60yVly7Y33
UMS5odpJpufXsq4+Pt88DMKHD88kWubTDhyHW8jrK0VsOIuiB7M7DWDZGDWzgSuGBc/vH4C7
pJV23jklXKQLCyR8556AJN+r+75QpwK33enrApyS0KVUn5gthFelSNDdncG0DFEBvnQipwYp
MJ5mduwH1+IyGDAecNpZ8Aja10LVr3CDsUKPSysuSyYF8ycxTT3zpnWGxswprIzLFYajtu84
E/Sw/3T4L0J4YXTU6AUa4BAC9lUk5mJ+TXl2Vqkn2nss1oJ9q5BkztadM2XuMxC5J942Naca
31IibdzEZHMDJaRM6JtYrYY/PGUUhShX+GxeBmoo4FZ8yUyhIr1JqwBiroRNyQc0gfGTcKQJ
MJrdZEoMhN9iFESlFlzzy5MGcmINHfxjzGrhpPqp/C2pXEi3SXkWDQ4YGuJMsZoX1CX7Q+lE
x1tyxlcXl0fMfJaOS4DXeiT64WjssAF5P1DiV8e6mxEIv1jCfiyjOUmSrww2NdzgNJ81GkMX
nhPK1X7PQF3d12ihAx9wMbSTrRjrli9WPYgYhNDrkQfpQaMaZ15AChmfd1t2rhWYLblqYcmB
2PwsPcLnlV6/4QpN+50BWhRrOEJ4IEIck+tOdLsz7QmL5Vzzkdsewy1NbyiTb6+Hm9MAy+Eu
eYMJdbKpnXgfq+fl33eA+5ecLR9gzViWYGFnle6L3GXhOd14KbHVsjDYaS+xVBkAjuHm67FC
0ZwWlxkCUMNlOPVzV0TNCLNyOzFjoxs1qMBhsh6uELtpfJiBsDqI3qNe6ccGJzKbQHxBNDAY
1H0szUMUXze8rHaKSHS9DeUK7DgX1/5xTS5k5sz3wSbPwr4JVrk6tAnyWQJOxl9BJ+AsLQF3
xy5zXGtCIOyR3tAIN1CM0/eOMgLuehS/JNiW4tUyWn2u44UNyli2lTbDPnD2d+YDouynVc/v
n9qUQ2Gi2nWd2Ylbzn6iS6PfkfA+Pd8iSEh05OMjZZcEdNyHKndcAoeekv8uIIivy4GQ2Lig
Yw9tiZCXalKhF20GN4jQkPgyxYwIqJJ3YE7BmU1gqw6swkAzw6yzetzJv26X22XdbBNkA4/v
O7QiwwUYuyjogocUtvAu5QNp2FD2PxhJtLnfuD36Q7Q++VRL99yTiRaIlSptYPrEs+oxmxNV
EW8h+oEh2xTOGUThOgzt84OysSD0VKCI3cUI/P7IiGYGzmRDRQMWqkEijjzJztnyBMPCM5Cz
B+uGnlcqjOobZM06C/BMr4w9dAyD8vZ4R4gW3PYZhC5/DkxUGgLxq3AXkJzg2ROzQaZ9Wd42
QXgTQD/uD+mBMxGrVUB/rfi4/kT48kBuvpHAsiwrdeu3UXxYYJLZQEnb98iyWnmouQ1jqhSG
oCnmyIM6Lc3vCfgA9lkhKFLPWylANo2bmThXolAlw96d+SZyhTnvsQHTyGj+K2Ka4fdlusw8
N2jT9XEfCJQLvE0oaUesIESfJMzMLBGXE8hbK1f6ozo7sM3yxyjhUa0cHuU8jgiCK4tUq3zz
H6hwyzarVVi7wilXf912bBHwtK0KWDty0Hp85YZcDZAAJ33+pgSOs8hGTtZqKS7hGfuqDDlA
LbekMuRlsrXgUi2TT/w+DPJPxUyI5iSl0CU6FLKI4r1Fp1j8OiB0b1ukU5QbmVvVtl/RjU99
3ACnyfdLFxX+65/PrER1xnkhMKhmvE6yY1aKd4AZEUjxxXqz83TTtGyID2cd20otUzOXgjP3
IXMlS9XHsr8E4xRi2P/csyvGPIWVDSRyH+WsijXtuGN+ua8QghIsbtG1Gn4m0hf1R2CtkPIP
KycrFXq1YKw2ccTzyUntZSILG+SIePJ0G1xiU/dCwV+Ujzw1UfiWpUI3hSzccClp4+o1splS
4nVCkiTU35TWi9UILIBLgV28UACMO4GlQh4FZUdEjwgKbzBDK7zsfU1xaxhSJj5m9epSDUSV
F4kYI8DEJHp1kfYUpOIx42O55LhNB64TqpZdN5D8MBox23Te2H578qhVzFTyJgXg7yor9mWJ
YxFzX1SvRyMMHGVeJd0eeSBfwZ5orjyqg28y9uEF3RsGpQyU45b6SVrpeVZTeJhljsJlqpZM
AH8V1xJXVgUpl4C2rcoqC0+Lk3+SZqPSke6T2KXIndY5gEk/NVGGNr7HPeN/bURpyC/iX+EI
Ovt7ERSTcdFckZUER7LMQbQvRSF+mn0EIdAVxS3JSzs8Mf9mftHMoGKuQDnG9yGW2n7yrwaF
hfOUccJba99zNLQz6HYhEr+AFpADf+oreoLh5h90kobdzpkR2i4HoxwPu0RUAntFdciGNl6D
l1eVbws5RwXn5GR10haQ4ZKBVjmEMapbW+CB5gu9B724yDXT8fzJSQSf9gnVw0XhtmGqPxzF
fuheCMZPMtreX4tyIcULVVmUTQclFplHvdPoIgcjWvn6VKZ+C7PDpyAxCPQLel/ePZfCfCU9
UOnBR4Fd5FV8RUOUzRJOmjFWChA4aZYlFoIign0vaMmVm9sYxdtjAS8aYR++LPqgOM1JZwwz
omBqQQNyswBuHxMfbNzPPQWydeAR3oxRDM6ZMecInqU9VRY81T/Boo2MtfUdnX0pFfBpn01f
3LKn4WTe4dq5oo4kVJ2bJiyD2vfnfnUHxEGvwd5H9O2yC9vuqI9JAQuEc6bfMmGgU9qJEbDb
xWhjGAXjls5pqRLBGA8v8oRxvn4ow1yovR2hQ7HsCUwOGGcTah7tSbza63h3GBQtyNU6jtEw
Tegkg8C6FvzUtZZBDq05rzzLAmT/fK9xiCDWv6h2hqzpOpQD4uTmpaYEBhtTSKdPlDMzb7X4
2YIdEkZLbvC15hdURKufjIfaApqFMlX5xMG0aVTVDnASmildctzJEEZKzJFU2zXVr+kHELXL
3dbGCY3b6NmW18YZWzvtNyjdDPwp9hCfdhhv6vBmXwXADofsNNV5HUiCthBfXCUm/wGuQemQ
XIgL9acFpxdBIwq+yexHCVNmTmtzCohRQlQl1KfNgNQoD4tLai3RcLdvFbzRS6sWGOGrabHD
FXktXWNiR7POuuE7NlbDURTG2jyW2TLBxeql0v/XQfIqC4oK+2e99s7BC+UC4XNDnCDDTZ5H
Qje6obO5tPYDg3vtiM2ijTg08CR6pv9xN91nKzHZr93hvlk/fgpaBfrHWpY/r7FOUE8N2OT1
oS2HCc34GKQSxoE4pF8Lf+OkjzxpFymME52/YcUqHwnU7flvnTbl/xfWor1Mx6BWBc/2RGVR
jAF7oNf7MRCH7U9G5H+pFQKY8dxFAFENo6UJqajRLxMx95HRPlqGnUwUV3g+g0GHqS0pvLDE
QrPurxLGVe1f1Rl1ygJ7F3oGUE1CQ+53Hx5JtjV/+qSnNbcCa7DDwkHxvKQ9Wrj8ui3CwBVu
BYCKYReOL0PgM+kYfFscDBiZ64ENt730tkhgC8h6wCXp6vAb730Db3cd5sq1UxT060oNLYLn
Zf+7W8djx6wVaofJDyCBTn9upb0LinWwohfgs/g4g1IndqTKqOe65Laxs+9AQQt+zvzxE+nd
YLtCwaeZitX0gdJPuTXIR25D+v19sWXUtTQpc1h5gkO/d/LPxHNa36eCKLnl0PkXVpZTaf67
mw4n8L4tnoScJ1eMa0wJZT4hFgSmI2Xw9U2AuRHstJO5QeM/7yyfsy5E/l/INEW92tzypwFq
FZmWnLjwhJ9yJVoe6PNyxQotSIT/F0PYzn0DgFdbpTwuNw5J1CilJ55jvQzNS2TGpUkTnVBU
h35AAFrnjCy33p5XwZR7RXBlxf6Q+zQIgYXgGQTqlDs6PqS1/fgJMIAcQo9lUAAHvsRffGU5
rsChZ1kndF3fffglhU0OzIJgXNhE7zEMU1g6Gl4iJ7XJ6VL0LG4DpbTWAeOr+5tdNTtByyV6
Jf/xGpO/zPpfgYxFUVpcTumI0U+ZnH6ZnfYTZokyZRQAe5VvYck7MJyJNhf2TcwVtBDpu1RY
89DBi1ofpi/fZSkCYAiNA4/FqhugFjDqwawOsjOAWe3FJ2CLbKbcm50bCqqToxK5wvFiC51y
7p/qR6+WWt0tJvdxypZ/PubI4DDIkzuNHzZV4+EG3pt3KMTc5MvwmTBudbaLG5qKXJKflUlR
t9hiQqocGEtMh02wi9rTbX8fJ8B6KmqvHe5bm6Jwsrd63AT7BKyQSs2lmuQ6+jNJLZ/QD/p9
A7UjTfNZ/xoUYLs5FGwnVI5uFePctWEFeWGzMZUMVinFuGb03BHj0p9tz5TlohJtFxbQOrMw
+OuP8YMN01gMGVTwFSQ62pR6XX25S2RjHK/uDlKEtbo6gKl7yMjONLJHKLsRpm4zECgnW6rN
dgAOF0ttKQrDFVkKhpDaxd5h+5aZ2NR20/ZP6bCCKa82cdIwS7pMWhZAb/+MYqMhAXgXDl2j
rblpDOTwEEvoodSPruhgJAMa2yuB6KaPPzA+XI+MxXTODlLmWY5WStigKhBtIgPvBAF+h5Q+
dKT+kaCH5V3VpHGb5RN1GpvfeTUc8D+0jvaDsDOKVOGy7J0i81FFBPUiW2hseUGtJl0a2WGE
uw4xPER/V3+JYTuDrGeXh+jVinQVMaznJvP16fWAnrQja/dBRHAmBkgC/llGcN6Bg9x6WU8k
xdcu6sLzHBgOmWoRs2R9fRffommIPXGWXEbWZ+ueR5cdJxVKV/zGQY5nOd8O+raNR9Z4PVlc
6Tr0nIflERowZ+GKUVtyF8kcl4LKhciFImpjon+lsE/4zxL4BvFJbC5iIhfE/Oj9hoUD3GVw
rXtjceS0fxF+Hc1AoyWGs9IgTIWPhAsu8A5BqSxvSIuuYkFopQjwzqVP+dn0TYSnXaW5BP2w
oEZGvltGdj8U14IlYgYMkG1YHCGyG5gbNU0jbDPMMZDYFlavWR+7W3uP3QdqjX3vTZYsvTDv
QcZAA3rpsWCRkVwf5yB5XBSI5cgR8lh4Y7714yDWh1N5bCsyOU/xjtzhVBT0luLP+f4yZpk1
IiNNZEIm8MT+ZhCV/xUzMg1t8xkpi3kOVUREdciwiOUjF44+bxAaxfOB/VjNLY/9wMarA4cO
3OxieOVAmPL4KYRK5XyEJ2LAW35IrqLZWBijBlVRi205xVCQEpcflcJQQimnHoEY4k49Y7bL
SsvBeXkRGNgCX13AJwhC+Z2zuUm8w9O3Wv5pjV2JgMbBrpb8giGSXR96MZDoPCXT+vM6aNEC
0IsdmH+3GX4QCYBRCtPf/vRQr1VWkSg6IBaS/S2gM7/a3r/TS+X5l5wUe+GcGaDUiZCraYl0
Ymx1PGXlxKVynRly6RAMKgbgKbYoh3W22ajWBx9eJ2P0A8+uK1xUWhr0FnclKwRT/eiQ+0Gu
dL1DzzWwuxOidgR/Y4uqURUN0F+WQLfXiHJevcIzyZHdIeqHUrOsxHqVdsuxf/57xQw1YxaS
5gqXmrdhEcKuJTfV2poH5JjI97M7xX0Oa5PIa/J8YUj64+d0x64MDTrZJ8fQfgclJtjZzANn
DdamyN1hyqyzlcIiCsrM+wp/9/K31BAXKK3x/QKZS1CehcLZQqNci1SpEANn50sAcXB+4h0c
1Vs+8c+GwsskxGJ8sSKiQxaCNCfxeCmcmPepKhvq93x/F5wpe9anHuGdRitBDuP5+gSNbDgg
7rukcA2loWvSeBu/C0HTfHK5UtzWNYYTVGPtunIy2QqXswwaPBr+8itqL3Ti3picY2qJdRX4
7lzK2ZYU4k33Mv3zyCsa9zziL6jPiknn/gK/Rj/Tx5Fo+MKKmkBJj9jLYVocsGzmchmJSqHn
CUIfFj3HF0POv+8teczSwvHK9vOH7TrojoI4wK0UnvMCSzjj1MoHVmevkhhaSpJGL8ADq0bS
pgFOk+3mrnnu8FDGacj5I0uF562iovbM+YpVfUUzxZToEW8KkTtInNLkrIfLzM6vsaOMrueu
MnhdAcPqSBlP9p/YeUUM5PKF2dherGCGmTpL5KDHUTsimDE1kASfQENWfzuDNviEW9DXoseh
7Lgi/Tuk+l4cIilLu5hkLQDIJG6SIP5tG47LQuOf4zhojI/e9qQ0HNfNup8TV4ifaTk/teJp
jzZ/IzX8k+ySZyR9F9g54CAaorFURBxX7Vv9Umn/b5bDcI25gLTA2WmYLqoK3hm2ux5i7VdP
ntz+5g1Vj4x/sbITM2KFRXgAMTHBmVbf7xtSMNPXU9VZn6sY6qsBMaAifij0lYMDrttadWKc
Jnn5TOTGSULxTUB1k64uqSXhuHi0v+uTW01fCCHKO8sPkTtX57/h31N6hDn4h/F5TDIgi2iX
NtihwnmnYOv+tHSCg8yAQyOkkb5llOx/KCRxqfQ2SIFxnhZGT58oNLSRMW606P87xut+PKCO
ZEQtcic00YFbzZb6yy4ZmLiFz3COJjq+/qbmb7vdVFI0fEvAIWky+3ptHdVfFUBVUy243u18
psSJ1p8dO7d98ZzonK0qXMciVO2pfBBjKWRtEAZmbfbadcE7SnErNj6Q2FH6nZAoIoAJCQoW
uuaHGXWoXgM1vWHXg+VwqyhKphWC4K96gfp2S/u35dK95P2gJ3L1TIrLuocKEwp2WjeeOHcF
HRu2C6qcEcUeYYdWXP2+lMsIjmihjrg3VQwY5L9BIOD8xxXKuS7Gudx2Y3XMDyP647C2yJ6N
ozpexRcgQQTf7Os2cCWC7vRrTtHbJItfkc8wk4Tu+j+HT2ehpkJdQL3XEDvqzh+W8neKg6C0
bLsPvrkSallF/mr1IR+e8jOXZC+yuK5vEM8r1ycodWsdlJEtc7LO5jQJ4qaNE0a9L+sy869P
NdrelRI3nHu7x0S2OQsCpMdkjIdph8Y4xWKMKik7JHUUcGzkwdTl25FZK+PcdRAvPKWu13LN
RZvQd6oyLh41ePOZimguVw8dQW7l31fH6u2BF2vGl3Pj+Wh2Thcj0b697qXeIEhby7OkR2Uv
cDUqCgRUpspnG7SUH6BIacdps8Ax37qFUhazja4DL6jcLU0U8IZsEZaLWcXp3jVgsp+syB3Z
ZLnPChP1pab9JMviJd17ZhjinsKA1G/WC5/BUtCV9sDVbAoNQXzlAGa3E709nmd1IOFdXhy7
RTuovcfk9Acr29KI8V4zo1jSXeE07qkxk3ySP4iwYvj5AoKDfKO2E4yOeqUnwLks4M2KYfpr
8BzRvLzmPZ+AsxXEE9fUNVlt4+3O20JQOxf37mivaGMfI+qwEaJmWExGHietNKdCWDRYCLsh
EfsEqFbM9nVJuaBgVTeAEQdfhIvXnFnNTP5Zvb1AWzwRQ6EHkLTVc7gGxFFaIxobRO5rfd22
tHVdf4A8h876WFtXEebEOhg3lwr3LtDJuMK7r1rrehkqFG0DRYS/tRiZPLj+PiD69jcx2jvy
GHJJQS2MuPkCEjkIY6pkRQ626+trYJMwt5hxwcm18hnq54H6NX7Ae0qJ8XC4u1CWzMsBZAZW
sLEJJOn5PyqI9CXFtQ598xSVGzoBciF/BA5XPcU3dLmJU0IDIQH/Soya9qtl3VfliYpca+OM
DoZSajkpz6eTZMgeYh5Oxjm1PSLD6mNOhY8PGvtFmiJdKrWG1BRzTJwv2Lx+u7rCg7kYeR92
4L4c68oz3OvHE1ne226kv+CWZgdLEkUHvfnqAWnPYNqWm8lE8WmdcwlI6A54NGe0Yi1QZuEN
idxw1jz9cXbRF2uLRMc98hatZ/m5qqfVk1kZQAoLfGGoonegnA1F81xmGvBaEImoxdjYuqYc
w0vDOMzSs9u1oQFRahSIlFUFN17Ijo8NABa4eaPfKE7CCOfinUEC9u5NM3t2M86qc1j6eWXd
/v9QbdaC6XP0om6ihPcn9gsdFXNGNezXCIneEI44+Ouhy1IRAqFR113UwLh/IhrKtDwp0JPj
f/HrGQAzvlgM+J/J/LGLWFWmMpH6aNI3UFdgScx/Cy+TSbfzKFCwTE0LQy79zwrHUoQsudxp
gua7Y1QE0zOTuoySPiJ+RSIplEsBTE6mrLB3OmnUm9+0VdkFUBge42XDJr+ml3GuYaRQXq5g
Z2WyG2jay/05jdp7v6JBGSp8IsYVx+vf89azejlcSE4nh2vKMWjQwAMdXQizOnSArJT1dVj4
GcV06v27otJReJGrJSd97KBDp92kNANCKpa2bpzUom/zO4clqiWeQsy7TOKSQHFccp8aVoju
NmNlJT2itCrZ9PXFAmbGZbB/VK+igP61eze2qUABpBJHIbiyc0y/bt6nUfgFnTOBeJHcY46U
pY/lLKhN1qK+OeUE8c86Yij/2milVQ6mX1cQfdl/dHvmVksbGYwUJkxoqhTCUu5IbWcvnFTK
/6KkZBGtEYxsJZOeoDGn61tWf/OcWJG0nlNeiZJM3NXHux+lpOYdyNU1hNoyaepKX7ofdu/d
0ekVvZV/rs0YuZL1JWF2Aj2Ka26SmyGPbX4VbrKJi3HfRvQjEQJKXFwxmtBuwn3N2yd2kORg
dVhdtwrRXdEdNVyHtviTxZxqCmySzloWSuY5F5G12z+s/MinMFhPuXuRee38faL4dbeVPtT0
5hCTVq4KfvV32070nEpX0Atr0aYP2E7EmRN3DYvM43XRFPfhh0/tQsl5Br3iC77dz9UGjo7b
AejWHJB3ttJWW24a7tO1pO2Cl14MHwk9xZ08WHICqh4ttfNk6FcwC1D20YCmSLQ/AhPlcooZ
b0KdSy9Qq7XIbrgL9dFFE+46hdXyBgx6m7arE88ODMnT7pbf2YCt5yyEylBrmqTLEEb0Ad7D
djU/A3xMfrikB079eaGYbJkv9XvbeLoUdi5WbWeU/ks/VqheoTCgRYhYPgQT0FfSJ4vIQE+v
X6ZCO1y9Hzd39qmkStQUeJnvFVCT8CEnGCWAj9H/dJKOKVN533hAUghA3WtI6HDoQlgQmEtY
3ayxjINbu1einINceyzYFQL0X1FzpUXgsidXY7ZYcChR/4ljDd0EmDST2pd0erRqOSLhUknO
Epb7qBQk3fh4e2g/lypWPgKC64oInB57nLQJi9Q1pNJlpoJyiANPyPAblD7F7VXzRBJMBREc
rlUQqBvn0ALwz6ZuYoxpl1UevBtZ0/eZ4+8BTvOa98K6bPGzmaagaCch+dir4Fl6HAwZZpSR
nqWb5XYgkP+tt/TEXt07umrthGh23s7nEa1xTMONBFizX5O6jx8QNyTWfvn1Olc3lmdEB5ly
sH0jGl7LtFYECSGi6BHgn2kyLXBUitP4qrfDLRYFcSbyHqrbxCk47onKZTValMnLLn3mmSRB
ubuwnMqi5irea0HbYF9JiBFDrZJlmyF5UV0m3+PmabgC3P9MsFcGFoXSYujuWK/m2fEdVOEC
jrrNuzvTumvMSDuhrTb8TsZnkMmiojveSeWs8MfpVU1eCwcq02gxwr0bpP4FACA70M0Lu2/k
tKrIxhGvBE9CJzJcICPK9lrncd2byKJa+SZ3WjNdKiQ22ph0XIgS7rKrZJ0dXF7xjoZCMwOI
sLuyfIF5qKnGVFYgyCquqtEOvGObncE9WRsidVSPEjHjXYAiUA8SWn6jzE28CyHTLkA8XCWd
wNV9AsFIp4VJp2O+K/2oPFpct8xqbwlYS4Fn6J9ifn8q5jlofGEyZqeBqXUHq7HdgArv+qUk
DaI7aRzbQEVYWnvu6I1AQ2CTkdV7qrjm1Ih/Y/vBUkF4jFz5eDWJZvrq5WZ78FfSIObL4Yd/
1FVeUEL/7+Ytsl6pPTnXMPQCA+YtDYeIiA6TJUDy54RfnYFIT6ydNY8uNLi0Ka3dvAOHelxG
SK8mxbEWjzlA9ErtXEyLqYaV+8ZPY8Cz602qWOZIpR7kxfDOgPn8b5sN6QO2r437elpoUDon
zZdd8XqZRCpiF5wNcdhrM7uP1okxhbyPeDKeA7w7R18V4AUZHMZhnCyxRfzHJUrIGuboKao7
R8KwdGr2hi0XhBNybqenxd3x/lyqquUj+1n6D+K0ei/GFhlfHGIaMS6pZ5crxtu/JynNLFVB
4ykpzo9JUqAFETReIq4o4SBHTTqqauoxdG7Jwn7po6b600718R2oHv34t/JCdQlmYwb5ZwzR
+nLSTkc+pI/HQKDlrlhhhdJ4onzE7jin4BmiNpAf6ZeB4f8yEaTMA+QdEa7XXm7wZY8vKyWh
FEBJ1Uwzgam9hQnHoQYb4Y2/wz92t8USwZpCm7Dsk14Z+5Tc2PzwEwWuTIe1Lk3s+C2CWTse
DXCeu9Wdv9RO24Me1iTj4p15xg/kjekx7Qk9Z5vGJwADbps+M2fSxpN26l5uFBw49Vf3/tRh
uTFjchxXfUhG59v1gyX4oTNpTHgAALVD7uQoPPB5sMjA2tjPg5ygdn3nMJPGy+O1gOJbwN2J
tLkN3JU3aPPSMqodaan8CQ0tLLpd5yTBQUgHB3RqYxdRDLMFCkU7GOzyE1APwoDNFPGzQxpE
DSZ0hU2VXoLFNoKFtV23TxiOqD9nd/MxnVv7s5UUur29dtpTIkNq8T5UGpyxa3oBvhHVeAbu
CgdOy2RAOu3wXam/sybpg/oXqdbEMcAV1yuOOzO6XL9O85K9vud+FLnUcZFnIkBu8lRQEPlC
nNJsxA7io39gVgv7Ox6imQqXYHCf6HGN7jdz8OpxgzyIzCdrqF7n1OmyssG6zuYg94TFv5qH
FmwO5NaWgUDXCqqykNOdc6Vv6slDvEKgNbKt9qnYPqsk/NCUU3X+5PgvOLVAE+6uB+TN2y9Z
hhiG214soQaz4YN05YYyK5twnmhKwxykjpZ0ibL13huUg0m7QOIDLSxVUbwzYjqo1B82FgHn
CiQXm9jITbSS696wcqG9u+1NjOhKh7JWyG3R/xrbVtulzZS32V5x5oVChgBVq5/uMtuQpCoo
cH3gcCQdpchUyfEsVh7BhNMqBfdy3shkOiuAwILBN7nlIkFIN73JsCPMIyX9MtvnbNZtWXnC
BzxdXJNfi2uefQN0Mt9d2MVjTTb+t9KTAPY1ZpcVYei+lj/e2U7Oyz4R/O4vFXsaKbi+fEdl
1c5T11v6Z7XDI6PfWLOovTqnnsK+bt4M+N/ukqy4Vsl4bzNl/8vkvA4hVlS+w01qzMegTu01
3PsM2XitKw4495ladAaNITE4nd2wZDxVW2xQHeNsQ4f5aIWu7LH7j2UaLbX0brrjbrLAp/h6
k4MyOye3lSq3pDldETjELD93Js8+CJ9QLLtf/fnNp4gt05JSmzNd3nE/7G+BHapPpB67Aa/D
pBgxFN1ZtdmlikJwfI3Oy2mvG4MmJRgU1I2QXoYWkXTEFXniUGaiE68Iw0E6E9AZ+GVPE62n
yUjlpildq0GTe3Wa+5a9HrmZlBaFB5roPYPQ+saDzjDq+iloPIObbnEVGcFPsZ3hNyktE5yp
JSjHP+nxF7F29KVnjg9yAi691AUMTQvBk80Pz66Un/4+iiUUbvjiTSDqzO53dVqa5zfJP0b8
GHBMWWpz8I8tLzuLfcvL2IuqWvSmPcPYsnyBgfsecgcUWZx4oxzrTy35zxHFWG5wj3XcxW1Z
UBerylHElebIbf+8P254QVVTP1KxL4ANrTwk5Z/x+Lb2y+pgSjuLLWPLVhPMEmXq6UvSrP4p
xsvHvy+ydQi5uSOSdGY4JFmF8SpYKxdxlkQCkaxwcL26r+oqJ1Hc+Knt5V93IJ0LZpDUmQRT
0nEKNDo7bcUt2zSBge7H1ae/l5yUIbmw5GOD9KCLTuyCC/RNA+jhyPy6jDMwtFhSo7WnSyPg
u6rHicRw++eGCQj/qBfiOSjb6j57CwVTumhoHheboZBx821pOUwhELmSaxR2q5kfQd1hPCFM
69XM4KuHomF3Z006M3bDUxYUrnK5hKpQP1E/1HE9Mi3LxtaSYgbICVq3dsisCSnQPaNof4kk
+UEv8R2qgWRnkq9UOAsKLF9QpFkSywTW5cbZzCkkCSY13zvzcZ5Uw+7Z6AvFkI0Z34rwau8M
UBjI0G6U31E4nFXigitSV/5XCY6YuxNzqznb+p8dFqihd5UF+aeWBNEw7dW7jl/sR+rsQpIY
PrxH5K96jiMdx4r+yfUSK/eEY4klN58n4mPghhn8PocS9vtiNn67xWgYUDNdwuOHwOFI9W7T
o40UIY2hiwVvWeKVLjW/IWwn81TLxeKdwu5nR3pDLqhV7H9NfkdypDM3JhZvQXjy3Z8fs44l
fRiYr/+YWZnTC0XnxCVVR+NNuxBN46Vr0pCwKKKlDMwh4GikRwPjXZFGscQnh/V2il2kBsm2
nltlukKAHpzOLaxQdEeBcgjJd7wd+4yzs95ULEcU4Jh1rT/ORpWWWNH5JrE3Crd+ab1tFGHM
rKC7odvmqBaLz0t0lqddXTP+XiuASKff+UDaRSJjxrMcslC7mjs6tXYGtRamY8iqAiewDSwb
f+6VaJB3WK9Al6i8jBW23OIp4BDK13RyoI3ryiKZT/mW+57HIqfd+s6PduLP7HYozrDaTYC8
xIh5KB7lvVfioqN70Z4ZzF+T6JOK0wYFW5tMDeQHLdoBQUms6u/O0CD+tGKrVKO4lhhoQJjd
HTcoUOZVRF2yDr4WNmnPHd4/0MBBHnZsUowhrL3ekxUqWf3vZoUwB7axrNVaNRRz4eLYjyY7
fFsVg6RsUqpOSILVjXEPmNy+2ue9sgQeZqcqHEDQpoArOzfDpQKpIPl2+X2rV3645PL4bJas
rSYGAL7yFi5o54XxAhdOY2VK7NQa5qYWS/HX4mo/QHY8nxfL29DXilNh0D/6pJfgPKafm864
ivVOkKhVJbGOsPEgCI+nSHNNmJDO4IciXUd4BArxwt6nCUC65BNshRrGpJ2MTc0B2/EggzSg
hlOO1FbPFXiJaLgiEHddM0CDLcdldmyArmLe+cisCNyGsXyb+IAETlPfd3+kzfykz4bv4EGS
NUlyyYZrLrWJNrcm+7aeM4fvY81QKFxG16GN0+uZwyvSeT9j0U1/Kq+HmTKuNRqOnMq/T0JJ
Rj4skeFAGwyv4cW6BpeZn4mIGxUOmihVGRZIgD2NWGzDrRc/CW8tc8j63mpnGmzOBtM3gAae
1kRUDVjBbbeDqcKEenPOv5Z9mkm/T4J2qItzt+KTsYBxhA+JH0ysn3/VbYi7l8rLKzZWRzyO
GGwTQQ1aBTdx0kt7XH/XRKbPn5PqEDYgByNgTKSYgnDCtGdp9DB3goaUQsNFvfHJRcBPhp5Z
VK2QacmslDa+ZP2YXC9ReJBCoWjumRvfs5ioAX/LNNMrk2lzuma+lI07ZxNjkHQwryckVBUE
OeudxwdJJ8Z69+8a4QONIcuZSStQq6bOwMWV0hcIkKIAP96Cif8J6E91IGRPpliKxBnfVkfr
UtPb5gPYcncvNfRmGI+cYJyfxLu1GJyg1/RuvyMA9pfXoWpWrTR1xbDmibdo4c6LaJmlBKwE
Zt6xgWrDdIBn44769bunVwUO7NjhNg7X+ItVqUWocbJmT5OUJdCBL4qUdm7mQP8bH4zcOFMY
oUMbnPmW8KSm35GsEfHnTOnRFYfOJ1qxPxxw92NuDReL93EYv+ghDxrec/8QnzPesOTfwFJz
bCX4kw65BOM7Pmp7t7EdS1y3dlOce2dvffxlLi7KWpn0Cn5ThOEAHn+eej/CF5G1ku3pyQ5b
Ee2D+do5TEdDvCqxpT/4yezM20aQkWATQvGlhciKWOZTaDUzq9Jna9VnnU7IdaaTrl0AlDxa
ulE4qFvevaPdwxltL8Iot0YQ0ZOHYEki356/uabCJBLxpCex5BDNXaescE9XnSZfRG8W9uW7
sLuhcqZQOlRxpPHbMhUTSG9zNyAY6+rmj6aJLDmFCid0kW8BiRwvUTdJZjgWy5NKOHF/LuFQ
2UUTBhVzjSaRFKiSK6fgbfwf4gYUw5cwyzhRHijcLqpZD/+ezt8ypjptqCI0e7Js1Pt+59pG
T7nWAKiD4tzLEQjGnjQVTMQ3HFGs2UsppIV2ZclKoTEhGbAxPVUwf7ShqK4O0qMAsEIc5GyZ
76I1cPDhAO1+o7EQD1OQE7S0m+VhyScU1jvgXQnCFeUQvGKuTfB1HZL99R+XedsGOJF7/K/U
cEk0A6XoV8BWoWU2ywRXFOeGp2CrAh0glnXBAcN2EZLr0A3HT2atm8VA8fpvGMW4y/7s4MzD
vA96I+d2WTOfozx1GxbEzM9A+LhRRxpfoKFSkDOkiy6VdgD6GG3RvLL5EYgIHeolkf2eCJSY
QWLTqhFCB8BUvhOsg1xjCx0k8dNwUNvPLj/AXqoAaOaIGPu7wvzSdBjEjS1f65OFXGEFxHjQ
fW3ogI9NvxEote2HCUwi264DJLTUkiQLZ0NVmfVFthgNDP6eICuyQmPFh0NrCp0mxBpbDQTi
4N+SXYfCWF3XyKniuEa204EuDS4hAfpm6x6RwlfiFjQlXJDFZyvajPRzDsXnvJoBHDbQw4RR
XDpZwoCzWxc1KXgpiVR4mpVh65DRJugCYjoK/UtI8HvD1D16u7oTCR7mCnU0FO6Xd+Yh3VoS
oiNpJtcCsjIfpbX1lim2BtHY9BQsYbj2rYrELISYKoT5rKsDBJwIjqbNfub3B1EhIFJsrL5P
fS/3yYwIQfEFM15rGe54c6ek8BBXuqPYrh8KEgQOGv1BNIkri+TLQCUZp99YbrxppkF2LGrq
DrYCtZPbslSHOdZ2SEqsFX4TaWeqZ+unsQceXBc/1cVylWeCMMpG6tmMLWHXXaYEdkRKpo3O
LEDVkMBmaoCS64G8vHFBe6YSFSF4pbc63e47lqzfwXQ1a+bsXkfzjYhRY6dKyfWkqlyimX6X
R6sezToOxHh9gwdTwMLn8mpcmTHCsmi3newd3wU2tUoPY+hH5wtbmniXMpjwmvkzGQWMZ+0a
zayGQyVw6MBFRXWR7ygCToohk19FdFCUelpF7CN37xTQ4SCGqF1cRqriEkF4UHwSbpTQBjoX
ArUL9Jhs5eKZ5AfJn6XaqMBGpyCiWfCfxWP7j46tbgamGtqSMGdteAcqb2wtynudTbnxNDg7
xRRijJakkzTI1OmxuMarigKXwyIcc3cVz46kCn9LG8VdA97R1rsFvHwRcLKIH2HasjjuXyS1
1UtLt7HFhRdLbByGwNiBwjLIkiCFUrbEneT0Bp/feq3HRiAfhSLoedPq9i/SgZhWDg5x+RoE
b0jRGEFoH89Ew18Ve6cBZZVfkLLsNFtavWLNxSrY/Yv/Qvps8VCvCgOUcO6t6z2HYgVLdVw4
NOUbs8nTrLoDKAlcRfo3yMvcDnnc/dj8Lcsftbb3aixXFYrn3G57ykwIclJxjHhWz7OYGpmD
1x019qc2N2c1f2BspRgikRlEAREqo/SmkKPmRPxz0YQMg8/9RBLNcQSUo00EyT2PSaqelZh+
t6EXc4EWiQShQOOMCmtbmXGsl9lQsHRqXrcrrWlWwXCC1yLOGbWGv1O4GZcFuK6cmQhK2SdI
4ld1LbpvLSaF9onkaO6udI8aWrqFdpqzzK2w4NlJhvGDfupcArpsu4F4ByaDdLw7FTyA+Rtn
n3rcvdhEkrsJFeTMuLGnjQSZGwZ0rITGRUQm0TDLkC8tSl3SU5V9BNFj/WqFzHspNyZ1eSrg
NtVnj5aZrVjZhR72JT1dv8D+CwJUDhJFsQzakeiSCjvuKfvt0/R+KTIxvlY3nvzJVYOAanXd
Y1f882+Htnr50NrOOtRf0E3yfAyIaQUMexHfVOhdr+uQkO1cDjwCEaMt9F23cA0J728sNMSk
Yw40YeADu76w82GlafU3P7aZYTzq0TBw9E37sn4y8WKDaQr+OcZiDpZ/iDPt46eunaKJ7s2u
Cuk+4rVn0N6XsFL1JbBBfbEXwwqPwDyjpG1dlC00nolDGBqOUPZHloLp0CW3H40nDqqi9MEV
AXBb6wjG8xgFkTKExMah4pGp/aGpJa9dNmwRvFwBUtvXSxhixGkUVmp5xZ43oV+DcsViiUCB
je7iHmnGTPcCTuhFFTO3MdH5noJxZOeRSesVP7CSltDP0sfAI2wCHuAWA8b/sahzdTAZHiHl
8LN2p3ND0aahg2vPX56g4Pe8PnQfNUsLYoZ+QoCBSJ5FgCrOOzCO0J7M8lSOGDszKg4TAJ1X
IVoDpj0pGBTVsDL/zncloUB7PIaS8/hZgt8NL0TsQtKN38uUxUQ6HJQgCb39cPaRbPV2n6b3
3x9J5x57TdfGQuCLpbNo+USf0vk7PJJpyInOYJecUu9yuTAHIalJyQOGi9/qjAg4JSlEkfOo
dbXxVPeMq/xVEwCGwBJdqfJ54YBMDz73+LypdKmngVrAjHFcXvynRZNkH0iLbNgu9Z2avoIt
WPQ4SnpwuHf1vDtauApwLgSnFmllW0n571+W+bDjLY9wqrEIgChc9hnIvJ0zAWujPWkt1P4m
ZZTPjJIAUzMNrdXA90f2ZpG/U1A087dRDq5TEcSUJ2bLMP+87zzmRmMazkJuJvXj6G1fJ25b
HWzAk02TzZOlcjJ/P6A/8DxrLKS8PmIZxscP1c/kFBNW9ICLAXIi7MeINMssyI/xVl5XkKOu
uN4nVOHkHjIMVnagRGdB9CauyPR8ZEgym74A4jtvQqycgU58NoPg/caEiOs/4vzpF6MZqVRD
pfvWNmwU4ZMaW45E1ASzS/y4REX+WAzrGgtONkL001t7JsiSITcWLDyeym6fTNZcOMvRfgBi
OCf70S4nwAXe8bzU+M/yRyi2umYEh2KQYw8IKOk4D2DDba8sEkjQCjv4qcdaDFKUwjH75M08
921MK9OskBH1kXbdn7FMlZKn5YXXuce4wQb+IUPKTGJ9IfR5GJnmCwMziZRlx9vudQT9+43R
t8IM9KTODnnyOD5a2OHYpVB8HKrwcRgF3hqqcGX+E82RbJvbLROwo2t/jlTPa/xiNTGnBH3A
nVToztIUoP5h+ocxFtrNQrWAbkyWgSwJKyIzxr26d5+xdmeTRTTlUGZyrB7Hla/eVutGQ5qs
AbBVobQYszrz7VAhOHAvo0mm9O855M5D696GJFq8U3P1SokGDL9Kfchmj4SN3GCIktiAVcjR
ioVSAfJ6HctIQ8KIffvuZmrnmHNe7VIVu0e1ZnrPNyfL6r8eHNCg+ZgYpJOUkzlk7lkrmGKc
hinSQ+oXi3X+O5EbRey5cTDrwMujQhy/aLpTzWO2i42NP6q53u+DePNNn6z0WqKNQ5Cx0Yjn
QOgN7h3tnJ7QxmBPQqnSruu0SoSLwVGp9Gj8q2Pl9CQuCCAZ5i4VPMDxxR8/kpdult0yF/X7
gdvgag5t66XfzKQri3Poo7FGC6iOf1cap9JGTnTFRM6P/cFU+QXi5WaW71YhTFTego/4xPGl
tkoJWHdACuhtq/4Ny8aoHGfJo19qs126hFWuejbiwm5ipdMGALK0EAakXp72oYlr+8UsBcaB
eZnLNtYMvA0SFbXQTowwDika1cyMSFWd7OeunIdozaurK4mJplYb9EJpc5zBFrZaNeaQJOI+
JOJhh4EQR1qzGlymPQ4QrHat2QJf3FievmeKW90kAAAyOjHCFpuZtgAB5MID+OQbcERAxLHE
Z/sCAAAAAARZWg==

--eqp4TxRxnD4KrmFZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=kernel-selftests

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-8.3-kselftests-6628ddfec7580882f11fdc5c194a8ea781fdadfa
2021-04-19 18:11:25 mount --bind /lib/modules/5.12.0-rc6-00349-g6628ddfec758/kernel/lib /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-6628ddfec7580882f11fdc5c194a8ea781fdadfa/lib
2021-04-19 18:11:25 sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
source /lkp/lkp/src/lib/tests/kernel-selftests-ext.sh
LKP SKIP net.l2tp.sh
LKP SKIP net.tls
2021-04-19 18:11:26 /kselftests/run_kselftest.sh -c net
TAP version 13
1..47
# selftests: net: reuseport_bpf
# ---- IPv4 UDP ----
# Testing EBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing EBPF mod 20...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 10: 10
# Socket 11: 11
# Socket 12: 12
# Socket 13: 13
# Socket 14: 14
# Socket 15: 15
# Socket 16: 16
# Socket 17: 17
# Socket 18: 18
# Socket 19: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 10: 30
# Socket 11: 31
# Socket 12: 32
# Socket 13: 33
# Socket 14: 34
# Socket 15: 35
# Socket 16: 36
# Socket 17: 37
# Socket 18: 38
# Socket 19: 39
# Reprograming, testing mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 0: 30
# Socket 1: 31
# Socket 2: 32
# Socket 3: 33
# Socket 4: 34
# Socket 5: 35
# Socket 6: 36
# Socket 7: 37
# Socket 8: 38
# Socket 9: 39
# Testing CBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 20...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 10: 10
# Socket 11: 11
# Socket 12: 12
# Socket 13: 13
# Socket 14: 14
# Socket 15: 15
# Socket 16: 16
# Socket 17: 17
# Socket 18: 18
# Socket 19: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 10: 30
# Socket 11: 31
# Socket 12: 32
# Socket 13: 33
# Socket 14: 34
# Socket 15: 35
# Socket 16: 36
# Socket 17: 37
# Socket 18: 38
# Socket 19: 39
# Reprograming, testing mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 0: 30
# Socket 1: 31
# Socket 2: 32
# Socket 3: 33
# Socket 4: 34
# Socket 5: 35
# Socket 6: 36
# Socket 7: 37
# Socket 8: 38
# Socket 9: 39
# Testing too many filters...
# Testing filters on non-SO_REUSEPORT socket...
# ---- IPv6 UDP ----
# Testing EBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing EBPF mod 20...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 10: 10
# Socket 11: 11
# Socket 12: 12
# Socket 13: 13
# Socket 14: 14
# Socket 15: 15
# Socket 16: 16
# Socket 17: 17
# Socket 18: 18
# Socket 19: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 10: 30
# Socket 11: 31
# Socket 12: 32
# Socket 13: 33
# Socket 14: 34
# Socket 15: 35
# Socket 16: 36
# Socket 17: 37
# Socket 18: 38
# Socket 19: 39
# Reprograming, testing mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 0: 30
# Socket 1: 31
# Socket 2: 32
# Socket 3: 33
# Socket 4: 34
# Socket 5: 35
# Socket 6: 36
# Socket 7: 37
# Socket 8: 38
# Socket 9: 39
# Testing CBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 20...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 10: 10
# Socket 11: 11
# Socket 12: 12
# Socket 13: 13
# Socket 14: 14
# Socket 15: 15
# Socket 16: 16
# Socket 17: 17
# Socket 18: 18
# Socket 19: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 10: 30
# Socket 11: 31
# Socket 12: 32
# Socket 13: 33
# Socket 14: 34
# Socket 15: 35
# Socket 16: 36
# Socket 17: 37
# Socket 18: 38
# Socket 19: 39
# Reprograming, testing mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 0: 30
# Socket 1: 31
# Socket 2: 32
# Socket 3: 33
# Socket 4: 34
# Socket 5: 35
# Socket 6: 36
# Socket 7: 37
# Socket 8: 38
# Socket 9: 39
# Testing too many filters...
# Testing filters on non-SO_REUSEPORT socket...
# ---- IPv6 UDP w/ mapped IPv4 ----
# Testing EBPF mod 20...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 10: 10
# Socket 11: 11
# Socket 12: 12
# Socket 13: 13
# Socket 14: 14
# Socket 15: 15
# Socket 16: 16
# Socket 17: 17
# Socket 18: 18
# Socket 19: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 10: 30
# Socket 11: 31
# Socket 12: 32
# Socket 13: 33
# Socket 14: 34
# Socket 15: 35
# Socket 16: 36
# Socket 17: 37
# Socket 18: 38
# Socket 19: 39
# Reprograming, testing mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 0: 30
# Socket 1: 31
# Socket 2: 32
# Socket 3: 33
# Socket 4: 34
# Socket 5: 35
# Socket 6: 36
# Socket 7: 37
# Socket 8: 38
# Socket 9: 39
# Testing EBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 20...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 10: 10
# Socket 11: 11
# Socket 12: 12
# Socket 13: 13
# Socket 14: 14
# Socket 15: 15
# Socket 16: 16
# Socket 17: 17
# Socket 18: 18
# Socket 19: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 10: 30
# Socket 11: 31
# Socket 12: 32
# Socket 13: 33
# Socket 14: 34
# Socket 15: 35
# Socket 16: 36
# Socket 17: 37
# Socket 18: 38
# Socket 19: 39
# Reprograming, testing mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 0: 30
# Socket 1: 31
# Socket 2: 32
# Socket 3: 33
# Socket 4: 34
# Socket 5: 35
# Socket 6: 36
# Socket 7: 37
# Socket 8: 38
# Socket 9: 39
# ---- IPv4 TCP ----
# Testing EBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing too many filters...
# Testing filters on non-SO_REUSEPORT socket...
# ---- IPv6 TCP ----
# Testing EBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing too many filters...
# Testing filters on non-SO_REUSEPORT socket...
# ---- IPv6 TCP w/ mapped IPv4 ----
# Testing EBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing filter add without bind...
# SUCCESS
ok 1 selftests: net: reuseport_bpf
# selftests: net: reuseport_bpf_cpu
# ---- IPv4 UDP ----
# send cpu 0, receive socket 0
# send cpu 1, receive socket 1
# send cpu 2, receive socket 2
# send cpu 3, receive socket 3
# send cpu 3, receive socket 3
# send cpu 2, receive socket 2
# send cpu 1, receive socket 1
# send cpu 0, receive socket 0
# send cpu 0, receive socket 0
# send cpu 2, receive socket 2
# send cpu 1, receive socket 1
# send cpu 3, receive socket 3
# ---- IPv6 UDP ----
# send cpu 0, receive socket 0
# send cpu 1, receive socket 1
# send cpu 2, receive socket 2
# send cpu 3, receive socket 3
# send cpu 3, receive socket 3
# send cpu 2, receive socket 2
# send cpu 1, receive socket 1
# send cpu 0, receive socket 0
# send cpu 0, receive socket 0
# send cpu 2, receive socket 2
# send cpu 1, receive socket 1
# send cpu 3, receive socket 3
# ---- IPv4 TCP ----
# send cpu 0, receive socket 0
# send cpu 1, receive socket 1
# send cpu 2, receive socket 2
# send cpu 3, receive socket 3
# send cpu 3, receive socket 3
# send cpu 2, receive socket 2
# send cpu 1, receive socket 1
# send cpu 0, receive socket 0
# send cpu 0, receive socket 0
# send cpu 2, receive socket 2
# send cpu 1, receive socket 1
# send cpu 3, receive socket 3
# ---- IPv6 TCP ----
# send cpu 0, receive socket 0
# send cpu 1, receive socket 1
# send cpu 2, receive socket 2
# send cpu 3, receive socket 3
# send cpu 3, receive socket 3
# send cpu 2, receive socket 2
# send cpu 1, receive socket 1
# send cpu 0, receive socket 0
# send cpu 0, receive socket 0
# send cpu 2, receive socket 2
# send cpu 1, receive socket 1
# send cpu 3, receive socket 3
# SUCCESS
ok 2 selftests: net: reuseport_bpf_cpu
# selftests: net: reuseport_bpf_numa
# ---- IPv4 UDP ----
# send node 0, receive socket 0
# send node 0, receive socket 0
# ---- IPv6 UDP ----
# send node 0, receive socket 0
# send node 0, receive socket 0
# ---- IPv4 TCP ----
# send node 0, receive socket 0
# send node 0, receive socket 0
# ---- IPv6 TCP ----
# send node 0, receive socket 0
# send node 0, receive socket 0
# SUCCESS
ok 3 selftests: net: reuseport_bpf_numa
# selftests: net: reuseport_dualstack
# ---- UDP IPv4 created before IPv6 ----
# ---- UDP IPv6 created before IPv4 ----
# ---- UDP IPv4 created before IPv6 (large) ----
# ---- UDP IPv6 created before IPv4 (large) ----
# ---- TCP IPv4 created before IPv6 ----
# ---- TCP IPv6 created before IPv4 ----
# SUCCESS
ok 4 selftests: net: reuseport_dualstack
# selftests: net: reuseaddr_conflict
# Opening 127.0.0.1:9999
# Opening INADDR_ANY:9999
# bind: Address already in use
# Opening in6addr_any:9999
# Opening INADDR_ANY:9999
# bind: Address already in use
# Opening INADDR_ANY:9999 after closing ipv6 socket
# bind: Address already in use
# Successok 5 selftests: net: reuseaddr_conflict
# selftests: net: run_netsocktests
# --------------------
# running socket test
# --------------------
# [PASS]
ok 6 selftests: net: run_netsocktests
# selftests: net: run_afpackettests
# --------------------
# running psock_fanout test
# --------------------
# test: control single socket
# test: control multiple sockets
# test: control multiple sockets, max_num_members
# test: unique ids
# 
# test: datapath 0x0 ports 8000,8002
# info: count=0,0, expect=0,0
# info: count=20,0, expect=15,5
# warning: incorrect queue lengths
# info: count=20,0, expect=20,5
# warning: incorrect queue lengths
# info: trying alternate ports (20)
# 
# test: datapath 0x0 ports 8000,8003
# info: count=0,0, expect=0,0
# info: count=20,0, expect=15,5
# warning: incorrect queue lengths
# info: count=20,0, expect=20,5
# warning: incorrect queue lengths
# info: trying alternate ports (19)
# 
# test: datapath 0x0 ports 8000,8004
# info: count=0,0, expect=0,0
# info: count=20,0, expect=15,5
# warning: incorrect queue lengths
# info: count=20,0, expect=20,5
# warning: incorrect queue lengths
# info: trying alternate ports (18)
# 
# test: datapath 0x0 ports 8000,8005
# info: count=0,0, expect=0,0
# info: count=15,5, expect=15,5
# info: count=20,5, expect=20,5
# 
# test: datapath 0x1000 ports 8000,8005
# info: count=0,0, expect=0,0
# info: count=15,5, expect=15,5
# info: count=20,15, expect=20,15
# 
# test: datapath 0x1 ports 8000,8005
# info: count=0,0, expect=0,0
# info: count=10,10, expect=10,10
# info: count=17,18, expect=18,17
# 
# test: datapath 0x3 ports 8000,8005
# info: count=0,0, expect=0,0
# info: count=15,5, expect=15,5
# info: count=20,15, expect=20,15
# 
# test: datapath 0x6 ports 8000,8005
# info: count=0,0, expect=0,0
# info: count=5,15, expect=15,5
# info: count=20,15, expect=15,20
# 
# test: datapath 0x7 ports 8000,8005
# info: count=0,0, expect=0,0
# info: count=5,15, expect=15,5
# info: count=20,15, expect=15,20
# 
# test: datapath 0x2 ports 8000,8005
# info: count=0,0, expect=0,0
# info: count=20,0, expect=20,0
# info: count=20,0, expect=20,0
# 
# test: datapath 0x2 ports 8000,8005
# info: count=0,0, expect=0,0
# info: count=0,20, expect=0,20
# info: count=0,20, expect=0,20
# 
# test: datapath 0x2000 ports 8000,8005
# info: count=0,0, expect=0,0
# info: count=20,20, expect=20,20
# info: count=20,20, expect=20,20
# OK. All tests passed
# [PASS]
# --------------------
# running psock_tpacket test
# --------------------
# test: TPACKET_V1 with PACKET_RX_RING .................... 100 pkts (14200 bytes)
# test: TPACKET_V1 with PACKET_TX_RING .................... 100 pkts (14200 bytes)
# test: TPACKET_V2 with PACKET_RX_RING .................... 100 pkts (14200 bytes)
# test: TPACKET_V2 with PACKET_TX_RING .................... 100 pkts (14200 bytes)
# test: TPACKET_V3 with PACKET_RX_RING .................... 100 pkts (14200 bytes)
# test: TPACKET_V3 with PACKET_TX_RING .................... 100 pkts (14200 bytes)
# OK. All tests passed
# [PASS]
# --------------------
# running txring_overwrite test
# --------------------
# read: a (0x61)
# read: b (0x62)
# [PASS]
ok 7 selftests: net: run_afpackettests
# selftests: net: test_bpf.sh
# test_bpf: ok
ok 8 selftests: net: test_bpf.sh
# selftests: net: netdevice.sh
# SKIP: eth0: interface already up
# PASS: eth0: ethtool list features
# PASS: eth0: ethtool dump
# PASS: eth0: ethtool stats
# SKIP: eth0: interface kept up
ok 9 selftests: net: netdevice.sh
# selftests: net: rtnetlink.sh
# PASS: policy routing
# PASS: route get
# PASS: preferred_lft addresses have expired
# PASS: promote_secondaries complete
# PASS: tc htb hierarchy
# PASS: gre tunnel endpoint
# PASS: gretap
# PASS: ip6gretap
# PASS: erspan
# PASS: ip6erspan
# PASS: bridge setup
# PASS: ipv6 addrlabel
# PASS: set ifalias dd92e639-529c-4948-9fc7-f3f3dec29199 for test-dummy0
# PASS: vrf
# PASS: vxlan
# PASS: fou
# PASS: macsec
# PASS: ipsec
# PASS: ipsec_offload
# PASS: bridge fdb get
# PASS: neigh get
# Error: Unknown device type.
# Error: argument "test-bond0" is wrong: Device does not exist
# 
# Error: argument "test-bond0" is wrong: Device does not exist
# 
# Cannot find device "test-bond0"
# Cannot find device "test-bond0"
# FAIL: bridge_parent_id
not ok 10 selftests: net: rtnetlink.sh # exit=1
# selftests: net: xfrm_policy.sh
# PASS: policy before exception matches
# PASS: ping to .254 bypassed ipsec tunnel (exceptions)
# PASS: direct policy matches (exceptions)
# PASS: policy matches (exceptions)
# PASS: ping to .254 bypassed ipsec tunnel (exceptions and block policies)
# PASS: direct policy matches (exceptions and block policies)
# PASS: policy matches (exceptions and block policies)
#
not ok 11 selftests: net: xfrm_policy.sh # TIMEOUT 45 seconds
# selftests: net: test_blackhole_dev.sh
# test_blackhole_dev: ok
ok 12 selftests: net: test_blackhole_dev.sh
# selftests: net: fib_tests.sh
# 
# Single path route test
#     Start point
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
#     Nexthop device deleted
#     TEST: IPv4 fibmatch - no route                                      [ OK ]
#     TEST: IPv6 fibmatch - no route                                      [ OK ]
# 
# Multipath route test
#     Start point
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
#     One nexthop device deleted
#     TEST: IPv4 - multipath route removed on delete                      [ OK ]
#     TEST: IPv6 - multipath down to single path                          [ OK ]
#     Second nexthop device deleted
#     TEST: IPv6 - no route                                               [ OK ]
# 
# Single path, admin down
#     Start point
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
#     Route deleted on down
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
# 
# Admin down multipath
#     Verify start point
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
#     One device down, one up
#     TEST: IPv4 fibmatch on down device                                  [ OK ]
#     TEST: IPv6 fibmatch on down device                                  [ OK ]
#     TEST: IPv4 fibmatch on up device                                    [ OK ]
#     TEST: IPv6 fibmatch on up device                                    [ OK ]
#     TEST: IPv4 flags on down device                                     [ OK ]
#     TEST: IPv6 flags on down device                                     [ OK ]
#     TEST: IPv4 flags on up device                                       [ OK ]
#     TEST: IPv6 flags on up device                                       [ OK ]
#     Other device down and up
#     TEST: IPv4 fibmatch on down device                                  [ OK ]
#     TEST: IPv6 fibmatch on down device                                  [ OK ]
#     TEST: IPv4 fibmatch on up device                                    [ OK ]
#     TEST: IPv6 fibmatch on up device                                    [ OK ]
#     TEST: IPv4 flags on down device                                     [ OK ]
#     TEST: IPv6 flags on down device                                     [ OK ]
#     TEST: IPv4 flags on up device                                       [ OK ]
#     TEST: IPv6 flags on up device                                       [ OK ]
#     Both devices down
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
# 
# Local carrier tests - single path
#     Start point
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
#     TEST: IPv4 - no linkdown flag                                       [ OK ]
#     TEST: IPv6 - no linkdown flag                                       [ OK ]
#     Carrier off on nexthop
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
#     TEST: IPv4 - linkdown flag set                                      [ OK ]
#     TEST: IPv6 - linkdown flag set                                      [ OK ]
#     Route to local address with carrier down
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
#     TEST: IPv4 linkdown flag set                                        [ OK ]
#     TEST: IPv6 linkdown flag set                                        [ OK ]
# 
# Single path route carrier test
#     Start point
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
#     TEST: IPv4 no linkdown flag                                         [ OK ]
#     TEST: IPv6 no linkdown flag                                         [ OK ]
#     Carrier down
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
#     TEST: IPv4 linkdown flag set                                        [ OK ]
#     TEST: IPv6 linkdown flag set                                        [ OK ]
#     Second address added with carrier down
#     TEST: IPv4 fibmatch                                                 [ OK ]
#     TEST: IPv6 fibmatch                                                 [ OK ]
#     TEST: IPv4 linkdown flag set                                        [ OK ]
#     TEST: IPv6 linkdown flag set                                        [ OK ]
# 
# IPv4 nexthop tests
# <<< write me >>>
# 
# IPv6 nexthop tests
#     TEST: Directly connected nexthop, unicast address                   [ OK ]
#     TEST: Directly connected nexthop, unicast address with device       [ OK ]
#     TEST: Gateway is linklocal address                                  [ OK ]
#     TEST: Gateway is linklocal address, no device                       [ OK ]
#     TEST: Gateway can not be local unicast address                      [ OK ]
#     TEST: Gateway can not be local unicast address, with device         [ OK ]
#     TEST: Gateway can not be a local linklocal address                  [ OK ]
#     TEST: Gateway can be local address in a VRF                         [ OK ]
#     TEST: Gateway can be local address in a VRF, with device            [ OK ]
#     TEST: Gateway can be local linklocal address in a VRF               [ OK ]
#     TEST: Redirect to VRF lookup                                        [ OK ]
#     TEST: VRF route, gateway can be local address in default VRF        [ OK ]
#     TEST: VRF route, gateway can not be a local address                 [ OK ]
#     TEST: VRF route, gateway can not be a local addr with device        [ OK ]
# 
# FIB rule with suppress_prefixlength
#     TEST: FIB rule suppress test                                        [ OK ]
# 
# IPv6 route add / append tests
#     TEST: Attempt to add duplicate route - gw                           [ OK ]
#     TEST: Attempt to add duplicate route - dev only                     [ OK ]
#     TEST: Attempt to add duplicate route - reject route                 [ OK ]
#     TEST: Append nexthop to existing route - gw                         [ OK ]
#     TEST: Add multipath route                                           [ OK ]
#     TEST: Attempt to add duplicate multipath route                      [ OK ]
#     TEST: Route add with different metrics                              [ OK ]
#     TEST: Route delete with metric                                      [ OK ]
# 
# IPv6 route replace tests
#     TEST: Single path with single path                                  [ OK ]
#     TEST: Single path with multipath                                    [ OK ]
#     TEST: Single path with single path via multipath attribute          [ OK ]
#     TEST: Invalid nexthop                                               [ OK ]
#     TEST: Single path - replace of non-existent route                   [ OK ]
#     TEST: Multipath with multipath                                      [ OK ]
#     TEST: Multipath with single path                                    [ OK ]
#     TEST: Multipath with single path via multipath attribute            [ OK ]
#     TEST: Multipath with dev-only                                       [ OK ]
#     TEST: Multipath - invalid first nexthop                             [ OK ]
#     TEST: Multipath - invalid second nexthop                            [ OK ]
#     TEST: Multipath - replace of non-existent route                     [ OK ]
# 
# IPv4 route add / append tests
#     TEST: Attempt to add duplicate route - gw                           [ OK ]
#     TEST: Attempt to add duplicate route - dev only                     [ OK ]
#     TEST: Attempt to add duplicate route - reject route                 [ OK ]
#     TEST: Add new nexthop for existing prefix                           [ OK ]
#     TEST: Append nexthop to existing route - gw                         [ OK ]
#     TEST: Append nexthop to existing route - dev only                   [ OK ]
#     TEST: Append nexthop to existing route - reject route               [ OK ]
#     TEST: Append nexthop to existing reject route - gw                  [ OK ]
#     TEST: Append nexthop to existing reject route - dev only            [ OK ]
#     TEST: add multipath route                                           [ OK ]
#     TEST: Attempt to add duplicate multipath route                      [ OK ]
#     TEST: Route add with different metrics                              [ OK ]
#     TEST: Route delete with metric                                      [ OK ]
# 
# IPv4 route replace tests
#     TEST: Single path with single path                                  [ OK ]
#     TEST: Single path with multipath                                    [ OK ]
#     TEST: Single path with reject route                                 [ OK ]
#     TEST: Single path with single path via multipath attribute          [ OK ]
#     TEST: Invalid nexthop                                               [ OK ]
#     TEST: Single path - replace of non-existent route                   [ OK ]
#     TEST: Multipath with multipath                                      [ OK ]
#     TEST: Multipath with single path                                    [ OK ]
#     TEST: Multipath with single path via multipath attribute            [ OK ]
#     TEST: Multipath with reject route                                   [ OK ]
#     TEST: Multipath - invalid first nexthop                             [ OK ]
#     TEST: Multipath - invalid second nexthop                            [ OK ]
#     TEST: Multipath - replace of non-existent route                     [ OK ]
# 
# IPv6 prefix route tests
#     TEST: Default metric                                                [ OK ]
#     TEST: User specified metric on first device                         [ OK ]
#     TEST: User specified metric on second device                        [ OK ]
#     TEST: Delete of address on first device                             [ OK ]
#     TEST: Modify metric of address                                      [ OK ]
#     TEST: Prefix route removed on link down                             [ OK ]
#     TEST: Prefix route with metric on link up                           [ OK ]
#     TEST: Set metric with peer route on local side                      [ OK ]
#     TEST: Set metric with peer route on peer side                       [ OK ]
#     TEST: Modify metric and peer address on local side                  [ OK ]
#     TEST: Modify metric and peer address on peer side                   [ OK ]
# 
# IPv4 prefix route tests
#     TEST: Default metric                                                [ OK ]
#     TEST: User specified metric on first device                         [ OK ]
#     TEST: User specified metric on second device                        [ OK ]
#     TEST: Delete of address on first device                             [ OK ]
#     TEST: Modify metric of address                                      [ OK ]
#     TEST: Prefix route removed on link down                             [ OK ]
#     TEST: Prefix route with metric on link up                           [ OK ]
#     TEST: Modify metric of .0/24 address                                [ OK ]
#     TEST: Set metric of address with peer route                         [ OK ]
#     TEST: Modify metric and peer address for peer route                 [ OK ]
# 
# IPv6 routes with metrics
#     TEST: Single path route with mtu metric                             [ OK ]
#     TEST: Multipath route via 2 single routes with mtu metric on first  [ OK ]
#     TEST: Multipath route via 2 single routes with mtu metric on 2nd    [ OK ]
#     TEST:     MTU of second leg                                         [ OK ]
#     TEST: Multipath route with mtu metric                               [ OK ]
#     TEST: Using route with mtu metric                                   [ OK ]
#     TEST: Invalid metric (fails metric_convert)                         [ OK ]
# 
# IPv4 route add / append tests
#     TEST: Single path route with mtu metric                             [ OK ]
#     TEST: Multipath route with mtu metric                               [ OK ]
#     TEST: Using route with mtu metric                                   [ OK ]
#     TEST: Invalid metric (fails metric_convert)                         [ OK ]
# 
# IPv4 route with IPv6 gateway tests
#     TEST: Single path route with IPv6 gateway                           [ OK ]
#     TEST: Single path route with IPv6 gateway - ping                    [ OK ]
#     TEST: Single path route delete                                      [ OK ]
#     TEST: Multipath route add - v6 nexthop then v4                      [ OK ]
#     TEST:     Multipath route delete - nexthops in wrong order          [ OK ]
#     TEST:     Multipath route delete exact match                        [ OK ]
#     TEST: Multipath route add - v4 nexthop then v6                      [ OK ]
#     TEST:     Multipath route delete - nexthops in wrong order          [ OK ]
#     TEST:     Multipath route delete exact match                        [ OK ]
# 
# IPv4 rp_filter tests
#     TEST: rp_filter passes local packets                                [FAIL]
#     TEST: rp_filter passes loopback packets                             [FAIL]
# 
# IPv4 delete address route tests
#     TEST: Route removed from VRF when source address deleted            [ OK ]
#     TEST: Route in default VRF not removed                              [ OK ]
#     TEST: Route removed in default VRF when source address deleted      [ OK ]
#     TEST: Route in VRF is not removed by address delete                 [ OK ]
# 
# Tests passed: 163
# Tests failed:   2
not ok 13 selftests: net: fib_tests.sh # exit=1
# selftests: net: fib-onlink-tests.sh
# Error: ipv4: FIB table does not exist.
# Flush terminated
# Error: ipv6: FIB table does not exist.
# Flush terminated
# 
# ########################################
# Configuring interfaces
# 
# ######################################################################
# TEST SECTION: IPv4 onlink
# ######################################################################
# 
# #########################################
# TEST SUBSECTION: Valid onlink commands
# 
# #########################################
# TEST SUBSECTION: default VRF - main table
#     TEST: unicast connected                                   [ OK ]
#     TEST: unicast recursive                                   [ OK ]
# 
# #########################################
# TEST SUBSECTION: VRF lisa
#     TEST: unicast connected                                   [ OK ]
#     TEST: unicast recursive                                   [ OK ]
# 
# #########################################
# TEST SUBSECTION: VRF device, PBR table
#     TEST: unicast connected                                   [ OK ]
#     TEST: unicast recursive                                   [ OK ]
# 
# #########################################
# TEST SUBSECTION: default VRF - main table - multipath
#     TEST: unicast connected - multipath                       [ OK ]
#     TEST: unicast recursive - multipath                       [ OK ]
#     TEST: unicast connected - multipath onlink first only     [ OK ]
#     TEST: unicast connected - multipath onlink second only    [ OK ]
# 
# #########################################
# TEST SUBSECTION: Invalid onlink commands
#     TEST: Invalid gw - local unicast address                  [ OK ]
#     TEST: Invalid gw - local unicast address, VRF             [ OK ]
#     TEST: No nexthop device given                             [ OK ]
#     TEST: Gateway resolves to wrong nexthop device            [ OK ]
#     TEST: Gateway resolves to wrong nexthop device - VRF      [ OK ]
# 
# ######################################################################
# TEST SECTION: IPv6 onlink
# ######################################################################
# 
# #########################################
# TEST SUBSECTION: Valid onlink commands
# 
# #########################################
# TEST SUBSECTION: default VRF - main table
#     TEST: unicast connected                                   [ OK ]
#     TEST: unicast recursive                                   [ OK ]
#     TEST: v4-mapped                                           [ OK ]
# 
# #########################################
# TEST SUBSECTION: VRF lisa
#     TEST: unicast connected                                   [ OK ]
#     TEST: unicast recursive                                   [ OK ]
#     TEST: v4-mapped                                           [ OK ]
# 
# #########################################
# TEST SUBSECTION: VRF device, PBR table
#     TEST: unicast connected                                   [ OK ]
#     TEST: unicast recursive                                   [ OK ]
#     TEST: v4-mapped                                           [ OK ]
# 
# #########################################
# TEST SUBSECTION: default VRF - main table - multipath
#     TEST: unicast connected - multipath onlink                [ OK ]
#     TEST: unicast recursive - multipath onlink                [ OK ]
#     TEST: v4-mapped - multipath onlink                        [ OK ]
#     TEST: unicast connected - multipath onlink both nexthops  [ OK ]
#     TEST: unicast connected - multipath onlink first only     [ OK ]
#     TEST: unicast connected - multipath onlink second only    [ OK ]
# 
# #########################################
# TEST SUBSECTION: Invalid onlink commands
#     TEST: Invalid gw - local unicast address                  [ OK ]
#     TEST: Invalid gw - local linklocal address                [ OK ]
#     TEST: Invalid gw - multicast address                      [ OK ]
#     TEST: Invalid gw - local unicast address, VRF             [ OK ]
#     TEST: Invalid gw - local linklocal address, VRF           [ OK ]
#     TEST: Invalid gw - multicast address, VRF                 [ OK ]
#     TEST: No nexthop device given                             [ OK ]
#     TEST: Gateway resolves to wrong nexthop device - VRF      [ OK ]
# 
# Tests passed:  38
# Tests failed:   0
ok 14 selftests: net: fib-onlink-tests.sh
# selftests: net: pmtu.sh
# TEST: ipv4: PMTU exceptions                                         [ OK ]
# TEST: ipv4: PMTU exceptions - nexthop objects                       [ OK ]
# TEST: ipv6: PMTU exceptions                                         [ OK ]
# TEST: ipv6: PMTU exceptions - nexthop objects                       [ OK ]
# TEST: IPv4 over vxlan4: PMTU exceptions                             [ OK ]
# TEST: IPv4 over vxlan4: PMTU exceptions - nexthop objects           [ OK ]
# TEST: IPv6 over vxlan4: PMTU exceptions                             [ OK ]
# TEST: IPv6 over vxlan4: PMTU exceptions - nexthop objects           [ OK ]
# TEST: IPv4 over vxlan6: PMTU exceptions                             [ OK ]
# TEST: IPv4 over vxlan6: PMTU exceptions - nexthop objects           [ OK ]
# TEST: IPv6 over vxlan6: PMTU exceptions                             [ OK ]
# TEST: IPv6 over vxlan6: PMTU exceptions - nexthop objects           [ OK ]
# TEST: IPv4 over geneve4: PMTU exceptions                            [ OK ]
# TEST: IPv4 over geneve4: PMTU exceptions - nexthop objects          [ OK ]
# TEST: IPv6 over geneve4: PMTU exceptions                            [ OK ]
# TEST: IPv6 over geneve4: PMTU exceptions - nexthop objects          [ OK ]
# TEST: IPv4 over geneve6: PMTU exceptions                            [FAIL]
#   PMTU exception wasn't created after exceeding link layer MTU on geneve interface
# TEST: IPv4 over geneve6: PMTU exceptions - nexthop objects          [FAIL]
#   PMTU exception wasn't created after exceeding link layer MTU on geneve interface
# TEST: IPv6 over geneve6: PMTU exceptions                            [ OK ]
# TEST: IPv6 over geneve6: PMTU exceptions - nexthop objects          [ OK ]
# TEST: IPv4, bridged vxlan4: PMTU exceptions                         [ OK ]
# TEST: IPv4, bridged vxlan4: PMTU exceptions - nexthop objects       [ OK ]
# TEST: IPv6, bridged vxlan4: PMTU exceptions                         [ OK ]
# TEST: IPv6, bridged vxlan4: PMTU exceptions - nexthop objects       [ OK ]
# TEST: IPv4, bridged vxlan6: PMTU exceptions                         [ OK ]
# TEST: IPv4, bridged vxlan6: PMTU exceptions - nexthop objects       [ OK ]
# TEST: IPv6, bridged vxlan6: PMTU exceptions                         [ OK ]
# TEST: IPv6, bridged vxlan6: PMTU exceptions - nexthop objects       [ OK ]
#
not ok 15 selftests: net: pmtu.sh # TIMEOUT 45 seconds
# selftests: net: udpgso.sh
# ipv4 cmsg
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv4 tx:1 gso:0 
# ipv4 tx:1472 gso:0 
# ipv4 tx:1473 gso:0 (fail)
# ipv4 tx:1472 gso:1472 
# ipv4 tx:1473 gso:1472 
# ipv4 tx:2944 gso:1472 
# ipv4 tx:2945 gso:1472 
# ipv4 tx:64768 gso:1472 
# ipv4 tx:65507 gso:1472 
# ipv4 tx:65508 gso:1472 (fail)
# ipv4 tx:1 gso:1 
# ipv4 tx:2 gso:1 
# ipv4 tx:5 gso:2 
# ipv4 tx:36 gso:1 
# ipv4 tx:37 gso:1 (fail)
# OK
# ipv4 setsockopt
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv4 tx:1 gso:0 
# ipv4 tx:1472 gso:0 
# ipv4 tx:1473 gso:0 (fail)
# ipv4 tx:1472 gso:1472 
# ipv4 tx:1473 gso:1472 
# ipv4 tx:2944 gso:1472 
# ipv4 tx:2945 gso:1472 
# ipv4 tx:64768 gso:1472 
# ipv4 tx:65507 gso:1472 
# ipv4 tx:65508 gso:1472 (fail)
# ipv4 tx:1 gso:1 
# ipv4 tx:2 gso:1 
# ipv4 tx:5 gso:2 
# ipv4 tx:36 gso:1 
# ipv4 tx:37 gso:1 (fail)
# OK
# ipv6 cmsg
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv6 tx:1 gso:0 
# ipv6 tx:1452 gso:0 
# ipv6 tx:1453 gso:0 (fail)
# ipv6 tx:1452 gso:1452 
# ipv6 tx:1453 gso:1452 
# ipv6 tx:2904 gso:1452 
# ipv6 tx:2905 gso:1452 
# ipv6 tx:65340 gso:1452 
# ipv6 tx:65527 gso:1452 
# ipv6 tx:65528 gso:1452 (fail)
# ipv6 tx:1 gso:1 
# ipv6 tx:2 gso:1 
# ipv6 tx:5 gso:2 
# ipv6 tx:16 gso:1 
# ipv6 tx:17 gso:1 (fail)
# OK
# ipv6 setsockopt
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv6 tx:1 gso:0 
# ipv6 tx:1452 gso:0 
# ipv6 tx:1453 gso:0 (fail)
# ipv6 tx:1452 gso:1452 
# ipv6 tx:1453 gso:1452 
# ipv6 tx:2904 gso:1452 
# ipv6 tx:2905 gso:1452 
# ipv6 tx:65340 gso:1452 
# ipv6 tx:65527 gso:1452 
# ipv6 tx:65528 gso:1452 (fail)
# ipv6 tx:1 gso:1 
# ipv6 tx:2 gso:1 
# ipv6 tx:5 gso:2 
# ipv6 tx:16 gso:1 
# ipv6 tx:17 gso:1 (fail)
# OK
# ipv4 connected
# device mtu (orig): 65536
# device mtu (test): 1600
# route mtu (test): 1500
# path mtu (read):  1500
# ipv4 tx:1 gso:0 
# ipv4 tx:1472 gso:0 
# ipv4 tx:1473 gso:0 (fail)
# ipv4 tx:1472 gso:1472 
# ipv4 tx:1473 gso:1472 
# ipv4 tx:2944 gso:1472 
# ipv4 tx:2945 gso:1472 
# ipv4 tx:64768 gso:1472 
# ipv4 tx:65507 gso:1472 
# ipv4 tx:65508 gso:1472 (fail)
# ipv4 tx:1 gso:1 
# ipv4 tx:2 gso:1 
# ipv4 tx:5 gso:2 
# ipv4 tx:36 gso:1 
# ipv4 tx:37 gso:1 (fail)
# OK
# ipv4 msg_more
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv4 tx:1 gso:0 
# ipv4 tx:1472 gso:0 
# ipv4 tx:1473 gso:0 (fail)
# ipv4 tx:1472 gso:1472 
# ipv4 tx:1473 gso:1472 
# ipv4 tx:2944 gso:1472 
# ipv4 tx:2945 gso:1472 
# ipv4 tx:64768 gso:1472 
# ipv4 tx:65507 gso:1472 
# ipv4 tx:65508 gso:1472 (fail)
# ipv4 tx:1 gso:1 
# ipv4 tx:2 gso:1 
# ipv4 tx:5 gso:2 
# ipv4 tx:36 gso:1 
# ipv4 tx:37 gso:1 (fail)
# OK
# ipv6 msg_more
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv6 tx:1 gso:0 
# ipv6 tx:1452 gso:0 
# ipv6 tx:1453 gso:0 (fail)
# ipv6 tx:1452 gso:1452 
# ipv6 tx:1453 gso:1452 
# ipv6 tx:2904 gso:1452 
# ipv6 tx:2905 gso:1452 
# ipv6 tx:65340 gso:1452 
# ipv6 tx:65527 gso:1452 
# ipv6 tx:65528 gso:1452 (fail)
# ipv6 tx:1 gso:1 
# ipv6 tx:2 gso:1 
# ipv6 tx:5 gso:2 
# ipv6 tx:16 gso:1 
# ipv6 tx:17 gso:1 (fail)
# OK
ok 16 selftests: net: udpgso.sh
# selftests: net: ip_defrag.sh
# ipv4 defrag
# PASS
# seed = 1618856025
# ipv4 defrag with overlaps
# PASS
# seed = 1618856025
# ipv6 defrag
# PASS
# seed = 1618856029
# ipv6 defrag with overlaps
# PASS
# seed = 1618856029
# ipv6 nf_conntrack defrag
# PASS
# seed = 1618856034
# ipv6 nf_conntrack defrag with overlaps
# PASS
# seed = 1618856034
# all tests done
ok 17 selftests: net: ip_defrag.sh
# selftests: net: udpgso_bench.sh
# ipv4
# tcp
# tcp tx:   3312 MB/s    56177 calls/s  56177 msg/s
# tcp rx:   3314 MB/s    56188 calls/s
# tcp tx:   3272 MB/s    55503 calls/s  55503 msg/s
# tcp rx:   3275 MB/s    55546 calls/s
# tcp tx:   3258 MB/s    55268 calls/s  55268 msg/s
# tcp zerocopy
# tcp tx:   2381 MB/s    40387 calls/s  40387 msg/s
# tcp rx:   2382 MB/s    39941 calls/s
# tcp tx:   2381 MB/s    40396 calls/s  40396 msg/s
# tcp rx:   2384 MB/s    40313 calls/s
# tcp tx:   2394 MB/s    40609 calls/s  40609 msg/s
# udp
# udp rx:    161 MB/s   114903 calls/s
# udp tx:    161 MB/s   114912 calls/s   2736 msg/s
# udp tx:    162 MB/s   115752 calls/s   2756 msg/s
# udp rx:    162 MB/s   115867 calls/s
# udp tx:    162 MB/s   115920 calls/s   2760 msg/s
# udp gso
# udp rx:    908 MB/s   646910 calls/s
# udp tx:    910 MB/s    15444 calls/s  15444 msg/s
# udp rx:    912 MB/s   649930 calls/s
# udp tx:    911 MB/s    15461 calls/s  15461 msg/s
# udp rx:    910 MB/s   648850 calls/s
# udp tx:    909 MB/s    15434 calls/s  15434 msg/s
# udp gso zerocopy
# udp rx:    857 MB/s   611018 calls/s
# udp tx:    859 MB/s    14577 calls/s  14577 msg/s
# udp rx:    867 MB/s   618312 calls/s
# udp tx:    866 MB/s    14703 calls/s  14703 msg/s
# udp tx:    874 MB/s    14831 calls/s  14831 msg/s
# udp rx:    875 MB/s   623332 calls/s
# udp gso timestamp
# udp rx:    833 MB/s   593744 calls/s
# udp tx:    835 MB/s    14179 calls/s  14179 msg/s
# udp rx:    848 MB/s   604086 calls/s
# udp tx:    847 MB/s    14369 calls/s  14369 msg/s
# udp rx:    850 MB/s   605724 calls/s
# udp tx:    849 MB/s    14408 calls/s  14408 msg/s
# udp gso zerocopy audit
# udp rx:    859 MB/s   612362 calls/s
# udp tx:    862 MB/s    14622 calls/s  14622 msg/s
# udp rx:    870 MB/s   620390 calls/s
# udp tx:    870 MB/s    14759 calls/s  14759 msg/s
# udp rx:    870 MB/s   620208 calls/s
# udp tx:    869 MB/s    14751 calls/s  14751 msg/s
# Summary over 3.000 seconds...
# sum udp tx:    888 MB/s      44132 calls (14710/s)      44132 msgs (14710/s)
# Zerocopy acks:               44132
# udp gso timestamp audit
# udp rx:    834 MB/s   594663 calls/s
# udp tx:    837 MB/s    14201 calls/s  14201 msg/s
# udp rx:    844 MB/s   601373 calls/s
# udp tx:    843 MB/s    14305 calls/s  14305 msg/s
# udp rx:    845 MB/s   602148 calls/s
# udp tx:    844 MB/s    14323 calls/s  14323 msg/s
# Summary over 3.000 seconds...
# sum udp tx:    861 MB/s      42829 calls (14276/s)      42829 msgs (14276/s)
# Tx Timestamps:               42829 received                 0 errors
# udp gso zerocopy timestamp audit
# udp rx:    739 MB/s   526987 calls/s
# udp tx:    742 MB/s    12589 calls/s  12589 msg/s
# udp rx:    748 MB/s   533484 calls/s
# udp tx:    748 MB/s    12690 calls/s  12690 msg/s
# udp rx:    749 MB/s   534030 calls/s
# udp tx:    748 MB/s    12702 calls/s  12702 msg/s
# Summary over 3.000 seconds...
# sum udp tx:    764 MB/s      37981 calls (12660/s)      37981 msgs (12660/s)
# Tx Timestamps:               37981 received                 0 errors
# Zerocopy acks:               37981
# ipv6
# tcp
# tcp tx:   3210 MB/s    54445 calls/s  54445 msg/s
# tcp rx:   3212 MB/s    54443 calls/s
# tcp tx:   3274 MB/s    55541 calls/s  55541 msg/s
# tcp rx:   3279 MB/s    55592 calls/s
# tcp tx:   3265 MB/s    55385 calls/s  55385 msg/s
# tcp zerocopy
# tcp tx:   2376 MB/s    40299 calls/s  40299 msg/s
# tcp rx:   2377 MB/s    40284 calls/s
# tcp tx:   2407 MB/s    40841 calls/s  40841 msg/s
# tcp rx:   2410 MB/s    40861 calls/s
# tcp tx:   2403 MB/s    40766 calls/s  40766 msg/s
# udp
# udp rx:    133 MB/s    97368 calls/s
# udp tx:    133 MB/s    97481 calls/s   2267 msg/s
# udp rx:    138 MB/s   100831 calls/s
# udp tx:    138 MB/s   100749 calls/s   2343 msg/s
# udp tx:    138 MB/s   100964 calls/s   2348 msg/s
# udp gso
# udp rx:    895 MB/s   652800 calls/s
# udp tx:    897 MB/s    15222 calls/s  15222 msg/s
# udp rx:    901 MB/s   657664 calls/s
# udp tx:    901 MB/s    15283 calls/s  15283 msg/s
# udp rx:    905 MB/s   660736 calls/s
# udp tx:    904 MB/s    15348 calls/s  15348 msg/s
# udp gso zerocopy
# udp rx:    849 MB/s   619264 calls/s
# udp tx:    851 MB/s    14442 calls/s  14442 msg/s
# udp rx:    857 MB/s   625664 calls/s
# udp tx:    857 MB/s    14539 calls/s  14539 msg/s
# udp rx:    859 MB/s   626641 calls/s
# udp tx:    858 MB/s    14556 calls/s  14556 msg/s
# udp gso timestamp
# udp rx:    836 MB/s   609998 calls/s
# udp tx:    838 MB/s    14229 calls/s  14229 msg/s
# udp rx:    848 MB/s   618555 calls/s
# udp tx:    847 MB/s    14369 calls/s  14369 msg/s
# udp rx:    848 MB/s   618598 calls/s
# udp tx:    847 MB/s    14372 calls/s  14372 msg/s
#
not ok 18 selftests: net: udpgso_bench.sh # TIMEOUT 45 seconds
# selftests: net: fib_rule_tests.sh
# 
# ######################################################################
# TEST SECTION: IPv4 fib rule
# ######################################################################
# 
#     TEST: rule4 check: oif dummy0                             [ OK ]
# 
#     TEST: rule4 del by pref: oif dummy0                       [ OK ]
# net.ipv4.ip_forward = 1
# net.ipv4.conf.dummy0.rp_filter = 0
# 
#     TEST: rule4 check: from 192.51.100.3 iif dummy0           [ OK ]
# 
#     TEST: rule4 del by pref: from 192.51.100.3 iif dummy0     [ OK ]
# net.ipv4.ip_forward = 0
# 
#     TEST: rule4 check: tos 0x10                               [ OK ]
# 
#     TEST: rule4 del by pref: tos 0x10                         [ OK ]
# 
#     TEST: rule4 check: fwmark 0x64                            [ OK ]
# 
#     TEST: rule4 del by pref: fwmark 0x64                      [ OK ]
# 
#     TEST: rule4 check: uidrange 100-100                       [ OK ]
# 
#     TEST: rule4 del by pref: uidrange 100-100                 [ OK ]
# 
#     TEST: rule4 check: sport 666 dport 777                    [ OK ]
# 
#     TEST: rule4 del by pref: sport 666 dport 777              [ OK ]
# 
#     TEST: rule4 check: ipproto tcp                            [ OK ]
# 
#     TEST: rule4 del by pref: ipproto tcp                      [ OK ]
# 
#     TEST: rule4 check: ipproto icmp                           [ OK ]
# 
#     TEST: rule4 del by pref: ipproto icmp                     [ OK ]
# 
# ######################################################################
# TEST SECTION: IPv6 fib rule
# ######################################################################
# 
#     TEST: rule6 check: oif dummy0                             [ OK ]
# 
#     TEST: rule6 del by pref: oif dummy0                       [ OK ]
# 
#     TEST: rule6 check: from 2001:db8:1::3 iif dummy0          [ OK ]
# 
#     TEST: rule6 del by pref: from 2001:db8:1::3 iif dummy0    [ OK ]
# 
#     TEST: rule6 check: tos 0x10                               [ OK ]
# 
#     TEST: rule6 del by pref: tos 0x10                         [ OK ]
# 
#     TEST: rule6 check: fwmark 0x64                            [ OK ]
# 
#     TEST: rule6 del by pref: fwmark 0x64                      [ OK ]
# 
#     TEST: rule6 check: uidrange 100-100                       [ OK ]
# 
#     TEST: rule6 del by pref: uidrange 100-100                 [ OK ]
# 
#     TEST: rule6 check: sport 666 dport 777                    [ OK ]
# 
#     TEST: rule6 del by pref: sport 666 dport 777              [ OK ]
# 
#     TEST: rule6 check: ipproto tcp                            [ OK ]
# 
#     TEST: rule6 del by pref: ipproto tcp                      [ OK ]
# 
#     TEST: rule6 check: ipproto ipv6-icmp                      [ OK ]
# 
#     TEST: rule6 del by pref: ipproto ipv6-icmp                [ OK ]
# 
# Tests passed:  32
# Tests failed:   0
ok 19 selftests: net: fib_rule_tests.sh
# selftests: net: msg_zerocopy.sh
# ipv4 tcp -t 1
# tx=63418 (3957 MB) txc=0 zc=n
# rx=31710 (3957 MB)
# ipv4 tcp -z -t 1
# tx=49828 (3109 MB) txc=49828 zc=n
# rx=24915 (3109 MB)
# ok
# ipv6 tcp -t 1
# tx=52634 (3284 MB) txc=0 zc=n
# rx=26318 (3284 MB)
# ipv6 tcp -z -t 1
# tx=42575 (2656 MB) txc=42575 zc=n
# rx=21289 (2656 MB)
# ok
# ipv4 udp -t 1
# tx=70296 (4386 MB) txc=0 zc=n
# rx=70293 (4386 MB)
# ipv4 udp -z -t 1
# tx=51885 (3237 MB) txc=51885 zc=n
# rx=51849 (3235 MB)
# ok
# ipv6 udp -t 1
# tx=68014 (4244 MB) txc=0 zc=n
# rx=68011 (4244 MB)
# ipv6 udp -z -t 1
# tx=51422 (3208 MB) txc=51422 zc=n
# rx=51422 (3208 MB)
# ok
# OK. All tests passed
ok 20 selftests: net: msg_zerocopy.sh
# selftests: net: psock_snd.sh
# dgram
# tx: 128
# rx: 142
# rx: 100
# OK
# 
# dgram bind
# tx: 128
# rx: 142
# rx: 100
# OK
# 
# raw
# tx: 142
# rx: 142
# rx: 100
# OK
# 
# raw bind
# tx: 142
# rx: 142
# rx: 100
# OK
# 
# raw qdisc bypass
# tx: 142
# rx: 142
# rx: 100
# OK
# 
# raw vlan
# tx: 146
# rx: 100
# OK
# 
# raw vnet hdr
# tx: 152
# rx: 142
# rx: 100
# OK
# 
# raw csum_off
# tx: 152
# rx: 142
# rx: 100
# OK
# 
# raw csum_off with bad offset (expected to fail)
# ./psock_snd: write: Invalid argument
# raw min size
# tx: 42
# rx: 0
# OK
# 
# raw mtu size
# tx: 1514
# rx: 1472
# OK
# 
# raw mtu size + 1 (expected to fail)
# ./psock_snd: write: Message too long
# raw vlan mtu size + 1 (expected to fail)
# ./psock_snd: write: Message too long
# dgram mtu size
# tx: 1500
# rx: 1472
# OK
# 
# dgram mtu size + 1 (expected to fail)
# ./psock_snd: write: Message too long
# raw truncate hlen (expected to fail: does not arrive)
# tx: 14
# ./psock_snd: recv: Resource temporarily unavailable
# raw truncate hlen - 1 (expected to fail: EINVAL)
# ./psock_snd: write: Invalid argument
# raw gso min size
# tx: 1525
# rx: 1473
# OK
# 
# raw gso min size - 1 (expected to fail)
# tx: 1524
# rx: 1472
# OK
# 
not ok 21 selftests: net: psock_snd.sh # exit=1
# selftests: net: udpgro_bench.sh
# ipv4
# tcp - over veth touching data
# Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# tcp tx:    312 MB/s     5303 calls/s   5303 msg/s
# tcp rx:    313 MB/s     8226 calls/s
# tcp tx:    419 MB/s     7122 calls/s   7122 msg/s
# tcp rx:    420 MB/s    12619 calls/s
# tcp tx:    330 MB/s     5613 calls/s   5613 msg/s
# tcp rx:    331 MB/s    10536 calls/s
# tcp tx:    412 MB/s     7004 calls/s   7004 msg/s
# udp gso - over veth touching data
# Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# udp rx:    185 MB/s   131787 calls/s
# udp tx:    224 MB/s     3816 calls/s   3816 msg/s
# udp rx:    223 MB/s   159444 calls/s
# udp tx:    223 MB/s     3792 calls/s   3792 msg/s
# udp rx:    222 MB/s   158432 calls/s
# udp tx:    222 MB/s     3772 calls/s   3772 msg/s
# udp rx:    225 MB/s   160692 calls/s
# udp tx:    225 MB/s     3823 calls/s   3823 msg/s
# udp gso and gro - over veth touching data
# Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# udp rx:    337 MB/s     5696 calls/s
# udp tx:    398 MB/s     6766 calls/s   6766 msg/s
# udp rx:    393 MB/s     6633 calls/s
# udp tx:    395 MB/s     6705 calls/s   6705 msg/s
# udp rx:    492 MB/s     8062 calls/s
# udp tx:    482 MB/s     8189 calls/s   8189 msg/s
# udp rx:    370 MB/s     6277 calls/s
# udp tx:    368 MB/s     6244 calls/s   6244 msg/s
# ipv6
# tcp - over veth touching data
# Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# tcp tx:    341 MB/s     5791 calls/s   5791 msg/s
# tcp rx:    341 MB/s     4019 calls/s
# tcp tx:    416 MB/s     7057 calls/s   7057 msg/s
# tcp rx:    417 MB/s    13385 calls/s
# tcp tx:    346 MB/s     5876 calls/s   5876 msg/s
# tcp rx:    385 MB/s     4648 calls/s
# tcp tx:    417 MB/s     7084 calls/s   7084 msg/s
# udp gso - over veth touching data
# Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# udp rx:    205 MB/s   149604 calls/s
# udp tx:    251 MB/s     4268 calls/s   4268 msg/s
# udp rx:    248 MB/s   181300 calls/s
# udp tx:    245 MB/s     4164 calls/s   4164 msg/s
# udp rx:    230 MB/s   168028 calls/s
# udp tx:    230 MB/s     3903 calls/s   3903 msg/s
# udp rx:    230 MB/s   167755 calls/s
# udp tx:    229 MB/s     3899 calls/s   3899 msg/s
# udp gso and gro - over veth touching data
# Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# udp rx:    321 MB/s     5459 calls/s
# udp tx:    374 MB/s     6356 calls/s   6356 msg/s
# udp rx:    361 MB/s     6131 calls/s
# udp tx:    359 MB/s     6105 calls/s   6105 msg/s
# udp rx:    356 MB/s     6052 calls/s
# udp tx:    356 MB/s     6048 calls/s   6048 msg/s
# udp rx:    358 MB/s     6088 calls/s
# udp tx:    358 MB/s     6081 calls/s   6081 msg/s
ok 22 selftests: net: udpgro_bench.sh
# selftests: net: udpgro.sh
# ipv4
#  no GRO                                  Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
#  no GRO chk cmsg                         Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
#  GRO                                     Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
#  GRO chk cmsg                            Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
#  GRO with custom segment size            Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
#  GRO with custom segment size cmsg       Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
#  bad GRO lookup                          Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
#  multiple GRO socks                      Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
# ipv6
#  no GRO                                  Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
#  no GRO chk cmsg                         Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
#  GRO                                     Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
#  GRO chk cmsg                            Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
#  GRO with custom segment size            Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
#  GRO with custom segment size cmsg       Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
#  bad GRO lookup                          Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
#  multiple GRO socks                      Continuing without mounted eBPF fs. Too old kernel?
# 
# BTF debug data section '.BTF' rejected: Invalid argument (22)!
#  - Length:       549
# Verifier analysis:
# 
# magic: 0xeb9f
# version: 1
# flags: 0x0
# hdr_len: 24
# type_off: 0
# type_len: 268
# str_off: 268
# str_len: 257
# btf_total_size: 549
# [1] PTR (anon) type_id=2
# [2] STRUCT xdp_md size=24 vlen=6
# 	data type_id=3 bits_offset=0
# 	data_end type_id=3 bits_offset=32
# 	data_meta type_id=3 bits_offset=64
# 	ingress_ifindex type_id=3 bits_offset=96
# 	rx_queue_index type_id=3 bits_offset=128
# 	egress_ifindex type_id=3 bits_offset=160
# [3] TYPEDEF __u32 type_id=4
# [4] INT unsigned int size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [5] FUNC_PROTO (anon) return=6 args=(1 ctx)
# [6] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
# [7] FUNC xdp_dummy_prog type_id=5
# [8] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [9] ARRAY (anon) type_id=8 index_type_id=10 nr_elems=4
# [10] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
# [11] VAR _license type_id=9 linkage=1
# [12] DATASEC license size=0 vlen=1 size == 0
# 
# ok
ok 23 selftests: net: udpgro.sh
# selftests: net: test_vxlan_under_vrf.sh
# Checking HV connectivity                                           [ OK ]
# Check VM connectivity through VXLAN (underlay in the default VRF)  [ OK ]
# Check VM connectivity through VXLAN (underlay in a VRF)            [FAIL]
not ok 24 selftests: net: test_vxlan_under_vrf.sh # exit=1
# selftests: net: reuseport_addr_any.sh
# UDP IPv4 ... pass
# UDP IPv6 ... pass
# UDP IPv4 mapped to IPv6 ... pass
# TCP IPv4 ... pass
# TCP IPv6 ... pass
# TCP IPv4 mapped to IPv6 ... pass
# DCCP not supported: skipping DCCP tests
# SUCCESS
ok 25 selftests: net: reuseport_addr_any.sh
# selftests: net: test_vxlan_fdb_changelink.sh
# expected two remotes after fdb append	[ OK ]
# expected two remotes after link set	[ OK ]
ok 26 selftests: net: test_vxlan_fdb_changelink.sh
# selftests: net: so_txtime.sh
# 
# SO_TXTIME ipv6 clock monotonic
# payload:a delay:81 expected:0 (us)
# 
# SO_TXTIME ipv4 clock monotonic
# payload:a delay:54 expected:0 (us)
# 
# SO_TXTIME ipv6 clock monotonic
# payload:a delay:47 expected:0 (us)
# 
# SO_TXTIME ipv4 clock monotonic
# payload:a delay:62 expected:0 (us)
# 
# SO_TXTIME ipv6 clock monotonic
# payload:a delay:10065 expected:10000 (us)
# 
# SO_TXTIME ipv4 clock monotonic
# payload:a delay:10104 expected:10000 (us)
# 
# SO_TXTIME ipv6 clock monotonic
# payload:a delay:10069 expected:10000 (us)
# payload:b delay:20036 expected:20000 (us)
# 
# SO_TXTIME ipv4 clock monotonic
# payload:a delay:10100 expected:10000 (us)
# payload:b delay:20150 expected:20000 (us)
# 
# SO_TXTIME ipv6 clock monotonic
# payload:b delay:20350 expected:20000 (us)
# payload:a delay:20384 expected:20000 (us)
# 
# SO_TXTIME ipv4 clock monotonic
# payload:b delay:20351 expected:20000 (us)
# payload:a delay:20385 expected:20000 (us)
# 
# SO_TXTIME ipv6 clock tai
# send: pkt a at -1618856139102ms dropped: invalid txtime
# ./so_txtime: recv: timeout
# 
# SO_TXTIME ipv6 clock tai
# send: pkt a at 0ms dropped: invalid txtime
# ./so_txtime: recv: timeout
# 
# SO_TXTIME ipv6 clock tai
# payload:a delay:9663 expected:10000 (us)
# 
# SO_TXTIME ipv4 clock tai
# payload:a delay:9720 expected:10000 (us)
# 
# SO_TXTIME ipv6 clock tai
# payload:a delay:9806 expected:10000 (us)
# payload:b delay:19756 expected:20000 (us)
# 
# SO_TXTIME ipv4 clock tai
# payload:a delay:9640 expected:10000 (us)
# payload:b delay:19644 expected:20000 (us)
# 
# SO_TXTIME ipv6 clock tai
# payload:b delay:9664 expected:10000 (us)
# payload:a delay:19743 expected:20000 (us)
# 
# SO_TXTIME ipv4 clock tai
# payload:b delay:9655 expected:10000 (us)
# payload:a delay:19688 expected:20000 (us)
# OK. All tests passed
ok 27 selftests: net: so_txtime.sh
# selftests: net: ipv6_flowlabel.sh
# TEST management
# [OK]   !(flowlabel_get(fd, 1, 255, 0))
# [OK]   !(flowlabel_put(fd, 1))
# [OK]   !(flowlabel_get(fd, 0x1FFFFF, 255, 1))
# [OK]   flowlabel_get(fd, 1, 255, 1)
# [OK]   flowlabel_get(fd, 1, 255, 0)
# [OK]   flowlabel_get(fd, 1, 255, 1)
# [OK]   !(flowlabel_get(fd, 1, 255, 1 | 2))
# [OK]   flowlabel_put(fd, 1)
# [OK]   flowlabel_put(fd, 1)
# [OK]   flowlabel_put(fd, 1)
# [OK]   !(flowlabel_put(fd, 1))
# [OK]   flowlabel_get(fd, 2, 1, 1)
# [OK]   !(flowlabel_get(fd, 2, 255, 1))
# [OK]   !(flowlabel_get(fd, 2, 1, 1))
# [OK]   flowlabel_put(fd, 2)
# [OK]   flowlabel_get(fd, 3, 3, 1)
# [OK]   !(flowlabel_get(fd, 3, 255, 0))
# [OK]   !(flowlabel_get(fd, 3, 1, 0))
# [OK]   flowlabel_get(fd, 3, 3, 0)
# [OK]   flowlabel_get(fd, 3, 3, 0)
# [OK]   !(flowlabel_get(fd, 3, 3, 0))
# [OK]   flowlabel_get(fd, 4, 2, 1)
# [OK]   flowlabel_get(fd, 4, 2, 0)
# [OK]   !(flowlabel_get(fd, 4, 2, 0))
# TEST datapath
# send no label: recv no label (auto off)
# sent without label
# recv without label
# send label
# sent with label 1
# recv with label 1
# TEST datapath (with auto-flowlabels)
# send no label: recv auto flowlabel
# sent without label
# recv with label 177325
# send label
# sent with label 1
# recv with label 1
# OK. All tests passed
ok 28 selftests: net: ipv6_flowlabel.sh
# selftests: net: tcp_fastopen_backup_key.sh
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# all tests done
ok 29 selftests: net: tcp_fastopen_backup_key.sh
# selftests: net: fcnal-test.sh
# 'nettest' command not found; skipping tests
ok 30 selftests: net: fcnal-test.sh
# selftests: net: traceroute.sh
# SKIP: Could not run IPV6 test without traceroute6
# SKIP: Could not run IPV4 test without traceroute
# 
# Tests passed:   0
# Tests failed:   0
ok 31 selftests: net: traceroute.sh
# selftests: net: fin_ack_lat.sh
# server port: 59901
# test done
ok 32 selftests: net: fin_ack_lat.sh
# selftests: net: fib_nexthop_multiprefix.sh
# TEST: IPv4: host 0 to host 1, mtu 1300                              [ OK ]
# TEST: IPv6: host 0 to host 1, mtu 1300                              [FAIL]
# 
# TEST: IPv4: host 0 to host 2, mtu 1350                              [ OK ]
# TEST: IPv6: host 0 to host 2, mtu 1350                              [FAIL]
# 
# TEST: IPv4: host 0 to host 3, mtu 1400                              [ OK ]
# TEST: IPv6: host 0 to host 3, mtu 1400                              [FAIL]
# 
# TEST: IPv4: host 0 to host 1, mtu 1300                              [ OK ]
# TEST: IPv6: host 0 to host 1, mtu 1300                              [FAIL]
# 
# TEST: IPv4: host 0 to host 2, mtu 1350                              [ OK ]
# TEST: IPv6: host 0 to host 2, mtu 1350                              [FAIL]
# 
# TEST: IPv4: host 0 to host 3, mtu 1400                              [ OK ]
# TEST: IPv6: host 0 to host 3, mtu 1400                              [FAIL]
ok 33 selftests: net: fib_nexthop_multiprefix.sh
# selftests: net: fib_nexthops.sh
# 
# Basic functional tests
# ----------------------
# TEST: List with nothing defined                                     [ OK ]
# TEST: Nexthop get on non-existent id                                [ OK ]
# TEST: Nexthop with no device or gateway                             [ OK ]
# TEST: Nexthop with down device                                      [ OK ]
# TEST: Nexthop with device that is linkdown                          [ OK ]
# TEST: Nexthop with device only                                      [ OK ]
# TEST: Nexthop with duplicate id                                     [ OK ]
# TEST: Blackhole nexthop                                             [ OK ]
# TEST: Blackhole nexthop with other attributes                       [ OK ]
# TEST: Blackhole nexthop with loopback device down                   [ OK ]
# TEST: Create group                                                  [ OK ]
# TEST: Create group with blackhole nexthop                           [ OK ]
# TEST: Create multipath group where 1 path is a blackhole            [ OK ]
# TEST: Multipath group can not have a member replaced by blackhole   [ OK ]
# TEST: Create group with non-existent nexthop                        [ OK ]
# TEST: Create group with same nexthop multiple times                 [ OK ]
# TEST: Replace nexthop with nexthop group                            [ OK ]
# TEST: Replace nexthop group with nexthop                            [ OK ]
# TEST: Nexthop group and device                                      [ OK ]
# TEST: Test proto flush                                              [ OK ]
# TEST: Nexthop group and blackhole                                   [ OK ]
# 
# IPv4 functional
# ----------------------
# TEST: Create nexthop with id, gw, dev                               [ OK ]
# TEST: Get nexthop by id                                             [ OK ]
# TEST: Delete nexthop by id                                          [ OK ]
# TEST: Create nexthop - gw only                                      [ OK ]
# TEST: Create nexthop - invalid gw+dev combination                   [ OK ]
# TEST: Create nexthop - gw+dev and onlink                            [ OK ]
# TEST: Nexthops removed on admin down                                [ OK ]
# 
# IPv4 groups functional
# ----------------------
# TEST: Create nexthop group with single nexthop                      [ OK ]
# TEST: Get nexthop group by id                                       [ OK ]
# TEST: Delete nexthop group by id                                    [ OK ]
# TEST: Nexthop group with multiple nexthops                          [ OK ]
# TEST: Nexthop group updated when entry is deleted                   [ OK ]
# TEST: Nexthop group with weighted nexthops                          [ OK ]
# TEST: Weighted nexthop group updated when entry is deleted          [ OK ]
# TEST: Nexthops in groups removed on admin down                      [ OK ]
# TEST: Multiple groups with same nexthop                             [ OK ]
# TEST: Nexthops in group removed on admin down - mixed group         [ OK ]
# TEST: Nexthop group can not have a group as an entry                [ OK ]
# TEST: Nexthop group with a blackhole entry                          [ OK ]
# TEST: Nexthop group can not have a blackhole and another nexthop    [ OK ]
# TEST: IPv6 nexthop with IPv4 route                                  [ OK ]
# TEST: IPv6 nexthop with IPv4 route                                  [ OK ]
# TEST: IPv4 route with IPv6 gateway                                  [ OK ]
# TEST: IPv4 route with invalid IPv6 gateway                          [ OK ]
# 
# IPv4 functional runtime
# -----------------------
# TEST: Route add                                                     [ OK ]
# TEST: Route delete                                                  [ OK ]
# TEST: Route add - scope conflict with nexthop                       [ OK ]
# TEST: Nexthop replace with invalid scope for existing route         [ OK ]
# TEST: Basic ping                                                    [ OK ]
# TEST: Ping - multipath                                              [ OK ]
# TEST: Ping - multiple default routes, nh first                      [ OK ]
# TEST: Ping - multiple default routes, nh second                     [ OK ]
# TEST: Ping - blackhole                                              [ OK ]
# TEST: Ping - blackhole replaced with gateway                        [ OK ]
# TEST: Ping - gateway replaced by blackhole                          [ OK ]
# TEST: Ping - group with blackhole                                   [ OK ]
# TEST: Ping - group blackhole replaced with gateways                 [ OK ]
# TEST: IPv4 route with device only nexthop                           [ OK ]
# TEST: IPv4 multipath route with nexthop mix - dev only + gw         [ OK ]
# TEST: IPv6 nexthop with IPv4 route                                  [ OK ]
# TEST: IPv4 route with mixed v4-v6 multipath route                   [ OK ]
# TEST: IPv6 nexthop with IPv4 route                                  [ OK ]
# TEST: IPv4 route with IPv6 gateway                                  [ OK ]
# TEST: IPv4 default route with IPv6 gateway                          [ OK ]
# TEST: IPv4 route with MPLS encap                                    [ OK ]
# TEST: IPv4 route with MPLS encap - check                            [ OK ]
# TEST: IPv4 route with MPLS encap and v6 gateway                     [ OK ]
# TEST: IPv4 route with MPLS encap, v6 gw - check                     [ OK ]
# 
# IPv4 large groups (x32)
# ---------------------
# TEST: Dump large (x32) ecmp groups                                  [ OK ]
# 
# IPv4 nexthop api compat mode
# ----------------------------
# TEST: IPv4 default nexthop compat mode check                        [ OK ]
# TEST: IPv4 compat mode on - route add notification                  [ OK ]
# TEST: IPv4 compat mode on - route dump                              [ OK ]
# TEST: IPv4 compat mode on - nexthop change                          [ OK ]
# TEST: IPv4 set compat mode - 0                                      [ OK ]
# TEST: IPv4 compat mode off - route add notification                 [ OK ]
# TEST: IPv4 compat mode off - route dump                             [ OK ]
# TEST: IPv4 compat mode off - nexthop change                         [ OK ]
# TEST: IPv4 compat mode off - nexthop delete                         [ OK ]
# TEST: IPv4 set compat mode - 1                                      [ OK ]
# 
# IPv4 fdb groups functional
# --------------------------
# TEST: Fdb Nexthop group with multiple nexthops                      [ OK ]
# TEST: Get Fdb nexthop group by id                                   [ OK ]
# TEST: Fdb Nexthop group with non-fdb nexthops                       [ OK ]
# TEST: Non-Fdb Nexthop group with fdb nexthops                       [ OK ]
# TEST: Fdb Nexthop with blackhole                                    [ OK ]
# TEST: Fdb Nexthop with oif                                          [ OK ]
# TEST: Fdb Nexthop with onlink                                       [ OK ]
# TEST: Fdb Nexthop with encap                                        [ OK ]
# TEST: Fdb mac add with nexthop group                                [ OK ]
# TEST: Fdb mac add with nexthop                                      [ OK ]
# TEST: Route add with fdb nexthop                                    [ OK ]
# TEST: Route add with fdb nexthop group                              [ OK ]
# TEST: Fdb entry after deleting a single nexthop                     [ OK ]
# TEST: Fdb nexthop delete                                            [ OK ]
# TEST: Fdb entry after deleting a nexthop group                      [ OK ]
# 
# IPv4 runtime torture
# --------------------
# SKIP: Could not run test; need mausezahn tool
# 
# IPv6
# ----------------------
# TEST: Create nexthop with id, gw, dev                               [ OK ]
# TEST: Get nexthop by id                                             [ OK ]
# TEST: Delete nexthop by id                                          [ OK ]
# TEST: Create nexthop - gw only                                      [ OK ]
# TEST: Create nexthop - invalid gw+dev combination                   [ OK ]
# TEST: Create nexthop - gw+dev and onlink                            [ OK ]
# TEST: Nexthops removed on admin down                                [ OK ]
# 
# IPv6 groups functional
# ----------------------
# TEST: Create nexthop group with single nexthop                      [ OK ]
# TEST: Get nexthop group by id                                       [ OK ]
# TEST: Delete nexthop group by id                                    [ OK ]
# TEST: Nexthop group with multiple nexthops                          [ OK ]
# TEST: Nexthop group updated when entry is deleted                   [ OK ]
# TEST: Nexthop group with weighted nexthops                          [ OK ]
# TEST: Weighted nexthop group updated when entry is deleted          [ OK ]
# TEST: Nexthops in groups removed on admin down                      [ OK ]
# TEST: Multiple groups with same nexthop                             [ OK ]
# TEST: Nexthops in group removed on admin down - mixed group         [ OK ]
# TEST: Nexthop group can not have a group as an entry                [ OK ]
# TEST: Nexthop group with a blackhole entry                          [ OK ]
# TEST: Nexthop group can not have a blackhole and another nexthop    [ OK ]
# 
# IPv6 functional runtime
# -----------------------
# TEST: Route add                                                     [ OK ]
# TEST: Route delete                                                  [ OK ]
# TEST: Ping with nexthop                                             [ OK ]
# TEST: Ping - multipath                                              [ OK ]
# TEST: Ping - blackhole                                              [ OK ]
# TEST: Ping - blackhole replaced with gateway                        [ OK ]
# TEST: Ping - gateway replaced by blackhole                          [ OK ]
# TEST: Ping - group with blackhole                                   [ OK ]
# TEST: Ping - group blackhole replaced with gateways                 [ OK ]
# TEST: IPv6 route with device only nexthop                           [ OK ]
# TEST: IPv6 multipath route with nexthop mix - dev only + gw         [ OK ]
# TEST: IPv6 route can not have a v4 gateway                          [ OK ]
# TEST: Nexthop replace - v6 route, v4 nexthop                        [ OK ]
# TEST: Nexthop replace of group entry - v6 route, v4 nexthop         [ OK ]
# TEST: IPv6 route can not have a group with v4 and v6 gateways       [ OK ]
# TEST: IPv6 route can not have a group with v4 and v6 gateways       [ OK ]
# TEST: IPv6 route using a group after removing v4 gateways           [ OK ]
# TEST: IPv6 route can not have a group with v4 and v6 gateways       [ OK ]
# TEST: IPv6 route can not have a group with v4 and v6 gateways       [ OK ]
# TEST: IPv6 route using a group after replacing v4 gateways          [ OK ]
# TEST: Nexthop with default route and rpfilter                       [ OK ]
# TEST: Nexthop with multipath default route and rpfilter             [ OK ]
# 
# IPv6 large groups (x32)
# ---------------------
# TEST: Dump large (x32) ecmp groups                                  [ OK ]
# 
# IPv6 nexthop api compat mode test
# --------------------------------
# TEST: IPv6 default nexthop compat mode check                        [ OK ]
# TEST: IPv6 compat mode on - route add notification                  [ OK ]
# TEST: IPv6 compat mode on - route dump                              [ OK ]
# TEST: IPv6 compat mode on - nexthop change                          [ OK ]
# TEST: IPv6 set compat mode - 0                                      [ OK ]
# TEST: IPv6 compat mode off - route add notification                 [ OK ]
# TEST: IPv6 compat mode off - route dump                             [ OK ]
# TEST: IPv6 compat mode off - nexthop change                         [ OK ]
# TEST: IPv6 compat mode off - nexthop delete                         [ OK ]
# TEST: IPv6 set compat mode - 1                                      [ OK ]
# 
# IPv6 fdb groups functional
# --------------------------
# TEST: Fdb Nexthop group with multiple nexthops                      [ OK ]
# TEST: Get Fdb nexthop group by id                                   [ OK ]
# TEST: Fdb Nexthop group with non-fdb nexthops                       [ OK ]
# TEST: Non-Fdb Nexthop group with fdb nexthops                       [ OK ]
# TEST: Fdb Nexthop with blackhole                                    [ OK ]
# TEST: Fdb Nexthop with oif                                          [ OK ]
# TEST: Fdb Nexthop with onlink                                       [ OK ]
# TEST: Fdb Nexthop with encap                                        [ OK ]
# TEST: Fdb mac add with nexthop group                                [ OK ]
# TEST: Fdb mac add with nexthop                                      [ OK ]
# TEST: Route add with fdb nexthop                                    [ OK ]
# TEST: Route add with fdb nexthop group                              [ OK ]
# TEST: Fdb entry after deleting a single nexthop                     [ OK ]
# TEST: Fdb nexthop delete                                            [ OK ]
# TEST: Fdb entry after deleting a nexthop group                      [ OK ]
# 
# IPv6 runtime torture
# --------------------
# SKIP: Could not run test; need mausezahn tool
# 
# Tests passed: 163
# Tests failed:   0
ok 34 selftests: net: fib_nexthops.sh
# selftests: net: altnames.sh
# SKIP: jq not installed
not ok 35 selftests: net: altnames.sh # exit=1
# selftests: net: icmp_redirect.sh
# 
# ###########################################################################
# Legacy routing
# ###########################################################################
# 
# TEST: IPv4: redirect exception                                      [ OK ]
# TEST: IPv6: redirect exception                                      [FAIL]
# TEST: IPv4: redirect exception plus mtu                             [ OK ]
# TEST: IPv6: redirect exception plus mtu                             [FAIL]
# TEST: IPv4: routing reset                                           [ OK ]
# TEST: IPv6: routing reset                                           [ OK ]
# TEST: IPv4: mtu exception                                           [ OK ]
# TEST: IPv6: mtu exception                                           [ OK ]
# TEST: IPv4: mtu exception plus redirect                             [ OK ]
# TEST: IPv6: mtu exception plus redirect                             [FAIL]
# 
# ###########################################################################
# Legacy routing with VRF
# ###########################################################################
# 
# TEST: IPv4: redirect exception                                      [ OK ]
# TEST: IPv6: redirect exception                                      [FAIL]
# TEST: IPv4: redirect exception plus mtu                             [ OK ]
# TEST: IPv6: redirect exception plus mtu                             [FAIL]
# TEST: IPv4: routing reset                                           [ OK ]
# TEST: IPv6: routing reset                                           [ OK ]
# TEST: IPv4: mtu exception                                           [ OK ]
# TEST: IPv6: mtu exception                                           [ OK ]
# TEST: IPv4: mtu exception plus redirect                             [ OK ]
# TEST: IPv6: mtu exception plus redirect                             [FAIL]
# 
# ###########################################################################
# Routing with nexthop objects
# ###########################################################################
# 
# TEST: IPv4: redirect exception                                      [ OK ]
# TEST: IPv6: redirect exception                                      [FAIL]
# TEST: IPv4: redirect exception plus mtu                             [ OK ]
# TEST: IPv6: redirect exception plus mtu                             [FAIL]
# TEST: IPv4: routing reset                                           [ OK ]
# TEST: IPv6: routing reset                                           [ OK ]
# TEST: IPv4: mtu exception                                           [ OK ]
# TEST: IPv6: mtu exception                                           [ OK ]
# TEST: IPv4: mtu exception plus redirect                             [ OK ]
# TEST: IPv6: mtu exception plus redirect                             [FAIL]
# 
# ###########################################################################
# Routing with nexthop objects and VRF
# ###########################################################################
# 
# TEST: IPv4: redirect exception                                      [ OK ]
# TEST: IPv6: redirect exception                                      [FAIL]
# TEST: IPv4: redirect exception plus mtu                             [ OK ]
# TEST: IPv6: redirect exception plus mtu                             [FAIL]
# TEST: IPv4: routing reset                                           [ OK ]
# TEST: IPv6: routing reset                                           [ OK ]
# TEST: IPv4: mtu exception                                           [ OK ]
# TEST: IPv6: mtu exception                                           [ OK ]
# TEST: IPv4: mtu exception plus redirect                             [ OK ]
# TEST: IPv6: mtu exception plus redirect                             [FAIL]
# 
# Tests passed:  28
# Tests failed:  12
not ok 36 selftests: net: icmp_redirect.sh # exit=1
# selftests: net: ip6_gre_headroom.sh
# TEST: ip6gretap headroom                                            [PASS]
# TEST: ip6erspan headroom                                            [PASS]
ok 37 selftests: net: ip6_gre_headroom.sh
# selftests: net: route_localnet.sh
# run arp_announce test
# net.ipv4.conf.veth0.route_localnet = 1
# net.ipv4.conf.veth1.route_localnet = 1
# net.ipv4.conf.veth0.arp_announce = 2
# net.ipv4.conf.veth1.arp_announce = 2
# PING 127.25.3.14 (127.25.3.14) from 127.25.3.4 veth0: 56(84) bytes of data.
# 64 bytes from 127.25.3.14: icmp_seq=1 ttl=64 time=0.066 ms
# 64 bytes from 127.25.3.14: icmp_seq=2 ttl=64 time=0.052 ms
# 64 bytes from 127.25.3.14: icmp_seq=3 ttl=64 time=0.045 ms
# 64 bytes from 127.25.3.14: icmp_seq=4 ttl=64 time=0.044 ms
# 64 bytes from 127.25.3.14: icmp_seq=5 ttl=64 time=0.046 ms
# 
# --- 127.25.3.14 ping statistics ---
# 5 packets transmitted, 5 received, 0% packet loss, time 138ms
# rtt min/avg/max/mdev = 0.044/0.050/0.066/0.011 ms
# ok
# run arp_ignore test
# net.ipv4.conf.veth0.route_localnet = 1
# net.ipv4.conf.veth1.route_localnet = 1
# net.ipv4.conf.veth0.arp_ignore = 3
# net.ipv4.conf.veth1.arp_ignore = 3
# PING 127.25.3.14 (127.25.3.14) from 127.25.3.4 veth0: 56(84) bytes of data.
# 64 bytes from 127.25.3.14: icmp_seq=1 ttl=64 time=0.070 ms
# 64 bytes from 127.25.3.14: icmp_seq=2 ttl=64 time=0.046 ms
# 64 bytes from 127.25.3.14: icmp_seq=3 ttl=64 time=0.047 ms
# 64 bytes from 127.25.3.14: icmp_seq=4 ttl=64 time=0.045 ms
# 64 bytes from 127.25.3.14: icmp_seq=5 ttl=64 time=0.055 ms
# 
# --- 127.25.3.14 ping statistics ---
# 5 packets transmitted, 5 received, 0% packet loss, time 123ms
# rtt min/avg/max/mdev = 0.045/0.052/0.070/0.012 ms
# ok
ok 38 selftests: net: route_localnet.sh
# selftests: net: reuseaddr_ports_exhausted.sh
# TAP version 13
# 1..3
# # Starting 3 tests from 1 test cases.
# #  RUN           global.reuseaddr_ports_exhausted_unreusable ...
# #            OK  global.reuseaddr_ports_exhausted_unreusable
# ok 1 global.reuseaddr_ports_exhausted_unreusable
# #  RUN           global.reuseaddr_ports_exhausted_reusable_same_euid ...
# #            OK  global.reuseaddr_ports_exhausted_reusable_same_euid
# ok 2 global.reuseaddr_ports_exhausted_reusable_same_euid
# #  RUN           global.reuseaddr_ports_exhausted_reusable_different_euid ...
# #            OK  global.reuseaddr_ports_exhausted_reusable_different_euid
# ok 3 global.reuseaddr_ports_exhausted_reusable_different_euid
# # PASSED: 3 / 3 tests passed.
# # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
# tests done
ok 39 selftests: net: reuseaddr_ports_exhausted.sh
# selftests: net: txtimestamp.sh
# protocol:     TCP
# payload:      10
# server port:  9000
# 
# family:       INET 
# test SND
#     USR: 1618856276 s 399083 us (seq=0, len=0)
#     SND: 1618856276 s 400550 us (seq=9, len=10)  (USR +1467 us)
#     USR: 1618856276 s 449317 us (seq=0, len=0)
#     SND: 1618856276 s 450337 us (seq=19, len=10)  (USR +1019 us)
#     USR: 1618856276 s 499478 us (seq=0, len=0)
#     SND: 1618856276 s 500531 us (seq=29, len=10)  (USR +1053 us)
#     USR: 1618856276 s 549767 us (seq=0, len=0)
#     SND: 1618856276 s 550847 us (seq=39, len=10)  (USR +1080 us)
#     USR-SND: count=4, avg=1155 us, min=1019 us, max=1467 us
# test ENQ
#     USR: 1618856276 s 706738 us (seq=0, len=0)
#     ENQ: 1618856276 s 706796 us (seq=9, len=10)  (USR +57 us)
#     USR: 1618856276 s 756958 us (seq=0, len=0)
#     ENQ: 1618856276 s 756971 us (seq=19, len=10)  (USR +13 us)
#     USR: 1618856276 s 807197 us (seq=0, len=0)
#     ENQ: 1618856276 s 807222 us (seq=29, len=10)  (USR +24 us)
#     USR: 1618856276 s 857632 us (seq=0, len=0)
#     ENQ: 1618856276 s 857667 us (seq=39, len=10)  (USR +35 us)
#     USR-ENQ: count=4, avg=32 us, min=13 us, max=57 us
# test ENQ + SND
#     USR: 1618856277 s 19202 us (seq=0, len=0)
#     ENQ: 1618856277 s 19231 us (seq=9, len=10)  (USR +28 us)
#     SND: 1618856277 s 20250 us (seq=9, len=10)  (USR +1047 us)
#     USR: 1618856277 s 69689 us (seq=0, len=0)
#     ENQ: 1618856277 s 69710 us (seq=19, len=10)  (USR +21 us)
#     SND: 1618856277 s 70756 us (seq=19, len=10)  (USR +1066 us)
#     USR: 1618856277 s 120059 us (seq=0, len=0)
#     ENQ: 1618856277 s 120093 us (seq=29, len=10)  (USR +34 us)
#     SND: 1618856277 s 121105 us (seq=29, len=10)  (USR +1046 us)
#     USR: 1618856277 s 170421 us (seq=0, len=0)
#     ENQ: 1618856277 s 170441 us (seq=39, len=10)  (USR +19 us)
#     SND: 1618856277 s 171453 us (seq=39, len=10)  (USR +1031 us)
#     USR-ENQ: count=4, avg=25 us, min=19 us, max=34 us
#     USR-SND: count=4, avg=1047 us, min=1031 us, max=1066 us
# 
# test ACK
#     USR: 1618856277 s 327673 us (seq=0, len=0)
#     ACK: 1618856277 s 333850 us (seq=9, len=10)  (USR +6177 us)
#     USR: 1618856277 s 378073 us (seq=0, len=0)
# ERROR: 17264 us expected between 6000 and 6500
#     ACK: 1618856277 s 395337 us (seq=19, len=10)  (USR +17263 us)
#     USR: 1618856277 s 428489 us (seq=0, len=0)
#     ACK: 1618856277 s 434731 us (seq=29, len=10)  (USR +6241 us)
#     USR: 1618856277 s 478725 us (seq=0, len=0)
# ERROR: 17259 us expected between 6000 and 6500
#     ACK: 1618856277 s 495984 us (seq=39, len=10)  (USR +17259 us)
#     USR-ACK: count=4, avg=11735 us, min=6177 us, max=17263 us
# 
# test SND + ACK
#     USR: 1618856277 s 635412 us (seq=0, len=0)
#     SND: 1618856277 s 636460 us (seq=9, len=10)  (USR +1048 us)
#     ACK: 1618856277 s 641562 us (seq=9, len=10)  (USR +6149 us)
#     USR: 1618856277 s 685671 us (seq=0, len=0)
#     SND: 1618856277 s 686747 us (seq=19, len=10)  (USR +1076 us)
#     ACK: 1618856277 s 691931 us (seq=19, len=10)  (USR +6259 us)
#     USR: 1618856277 s 735907 us (seq=0, len=0)
#     SND: 1618856277 s 736956 us (seq=29, len=10)  (USR +1049 us)
#     ACK: 1618856277 s 742118 us (seq=29, len=10)  (USR +6211 us)
#     USR: 1618856277 s 786360 us (seq=0, len=0)
#     SND: 1618856277 s 787390 us (seq=39, len=10)  (USR +1030 us)
#     ACK: 1618856277 s 792546 us (seq=39, len=10)  (USR +6185 us)
#     USR-SND: count=4, avg=1051 us, min=1030 us, max=1076 us
#     USR-ACK: count=4, avg=6201 us, min=6149 us, max=6259 us
# 
# test ENQ + SND + ACK
#     USR: 1618856277 s 948662 us (seq=0, len=0)
#     ENQ: 1618856277 s 948683 us (seq=9, len=10)  (USR +20 us)
#     SND: 1618856277 s 949703 us (seq=9, len=10)  (USR +1040 us)
#     ACK: 1618856277 s 954821 us (seq=9, len=10)  (USR +6158 us)
#     USR: 1618856277 s 999138 us (seq=0, len=0)
#     ENQ: 1618856277 s 999158 us (seq=19, len=10)  (USR +20 us)
#     SND: 1618856278 s 183 us (seq=19, len=10)  (USR +1045 us)
#     ACK: 1618856278 s 5323 us (seq=19, len=10)  (USR +6185 us)
#     USR: 1618856278 s 49459 us (seq=0, len=0)
#     ENQ: 1618856278 s 49479 us (seq=29, len=10)  (USR +19 us)
#     SND: 1618856278 s 50504 us (seq=29, len=10)  (USR +1044 us)
# ERROR: 18740 us expected between 6000 and 6500
#     ACK: 1618856278 s 68199 us (seq=29, len=10)  (USR +18740 us)
#     USR: 1618856278 s 99944 us (seq=0, len=0)
#     ENQ: 1618856278 s 99964 us (seq=39, len=10)  (USR +19 us)
#     SND: 1618856278 s 100990 us (seq=39, len=10)  (USR +1045 us)
# ERROR: 18970 us expected between 6000 and 6500
#     ACK: 1618856278 s 118914 us (seq=39, len=10)  (USR +18969 us)
#     USR-ENQ: count=4, avg=20 us, min=19 us, max=20 us
#     USR-SND: count=4, avg=1043 us, min=1040 us, max=1045 us
#     USR-ACK: count=4, avg=12513 us, min=6158 us, max=18969 us
not ok 40 selftests: net: txtimestamp.sh # exit=1
# selftests: net: vrf-xfrm-tests.sh
# 
# No qdisc on VRF device
# TEST: IPv4 no xfrm policy                                           [ OK ]
# TEST: IPv6 no xfrm policy                                           [ OK ]
# TEST: IPv4 xfrm policy based on address                             [ OK ]
# TEST: IPv6 xfrm policy based on address                             [ OK ]
# TEST: IPv6 xfrm policy with VRF in selector                         [ OK ]
# Error: Unknown device type.
# Cannot find device "xfrm0"
# Cannot find device "xfrm0"
# Cannot find device "xfrm0"
# TEST: IPv4 xfrm policy with xfrm device                             [FAIL]
# TEST: IPv6 xfrm policy with xfrm device                             [FAIL]
# Cannot find device "xfrm0"
# 
# netem qdisc on VRF device
# TEST: IPv4 no xfrm policy                                           [ OK ]
# TEST: IPv6 no xfrm policy                                           [ OK ]
# TEST: IPv4 xfrm policy based on address                             [ OK ]
# TEST: IPv6 xfrm policy based on address                             [ OK ]
# TEST: IPv6 xfrm policy with VRF in selector                         [ OK ]
# Error: Unknown device type.
# Cannot find device "xfrm0"
# Cannot find device "xfrm0"
# Cannot find device "xfrm0"
# TEST: IPv4 xfrm policy with xfrm device                             [FAIL]
# TEST: IPv6 xfrm policy with xfrm device                             [FAIL]
# Cannot find device "xfrm0"
# 
# Tests passed:  10
# Tests failed:   4
not ok 41 selftests: net: vrf-xfrm-tests.sh # exit=1
# selftests: net: rxtimestamp.sh
# Testing ip...
# Starting testcase 0 over ipv4...
# Starting testcase 0 over ipv6...
# Starting testcase 1 over ipv4...
# Starting testcase 1 over ipv6...
# Starting testcase 2 over ipv4...
# Starting testcase 2 over ipv6...
# Starting testcase 3 over ipv4...
# Starting testcase 3 over ipv6...
# Starting testcase 4 over ipv4...
# Starting testcase 4 over ipv6...
# Starting testcase 5 over ipv4...
# Starting testcase 5 over ipv6...
# Starting testcase 6 over ipv4...
# ./rxtimestamp: Expected swtstamp to not be set.
# FAILURE in testcase 6 over ipv4 sockopts { SO_TIMESTAMPING: { SOF_TIMESTAMPING_SOFTWARE |}} expected cmsgs: {}
# Starting testcase 6 over ipv6...
# ./rxtimestamp: Expected swtstamp to not be set.
# FAILURE in testcase 6 over ipv6 sockopts { SO_TIMESTAMPING: { SOF_TIMESTAMPING_SOFTWARE |}} expected cmsgs: {}
# Starting testcase 7 over ipv4...
# Starting testcase 7 over ipv6...
# Starting testcase 8 over ipv4...
# Starting testcase 8 over ipv6...
# Starting testcase 9 over ipv4...
# Starting testcase 9 over ipv6...
# Testing udp...
# Starting testcase 0 over ipv4...
# Starting testcase 0 over ipv6...
# Starting testcase 1 over ipv4...
# Starting testcase 1 over ipv6...
# Starting testcase 2 over ipv4...
# Starting testcase 2 over ipv6...
# Starting testcase 3 over ipv4...
# Starting testcase 3 over ipv6...
# Starting testcase 4 over ipv4...
# Starting testcase 4 over ipv6...
# Starting testcase 5 over ipv4...
# Starting testcase 5 over ipv6...
# Starting testcase 6 over ipv4...
# ./rxtimestamp: Expected swtstamp to not be set.
# FAILURE in testcase 6 over ipv4 sockopts { SO_TIMESTAMPING: { SOF_TIMESTAMPING_SOFTWARE |}} expected cmsgs: {}
# Starting testcase 6 over ipv6...
# ./rxtimestamp: Expected swtstamp to not be set.
# FAILURE in testcase 6 over ipv6 sockopts { SO_TIMESTAMPING: { SOF_TIMESTAMPING_SOFTWARE |}} expected cmsgs: {}
# Starting testcase 7 over ipv4...
# Starting testcase 7 over ipv6...
# Starting testcase 8 over ipv4...
# Starting testcase 8 over ipv6...
# Starting testcase 9 over ipv4...
# Starting testcase 9 over ipv6...
# Testing tcp...
# Starting testcase 0 over ipv4...
# Starting testcase 0 over ipv6...
# Starting testcase 1 over ipv4...
# Starting testcase 1 over ipv6...
# Starting testcase 2 over ipv4...
# Starting testcase 2 over ipv6...
# Starting testcase 3 over ipv4...
# Starting testcase 3 over ipv6...
# Starting testcase 4 over ipv4...
# Starting testcase 4 over ipv6...
# Starting testcase 5 over ipv4...
# Starting testcase 5 over ipv6...
# Starting testcase 6 over ipv4...
# ./rxtimestamp: Expected swtstamp to not be set.
# FAILURE in testcase 6 over ipv4 sockopts { SO_TIMESTAMPING: { SOF_TIMESTAMPING_SOFTWARE |}} expected cmsgs: {}
# Starting testcase 6 over ipv6...
# ./rxtimestamp: Expected swtstamp to not be set.
# FAILURE in testcase 6 over ipv6 sockopts { SO_TIMESTAMPING: { SOF_TIMESTAMPING_SOFTWARE |}} expected cmsgs: {}
# Starting testcase 7 over ipv4...
# Starting testcase 7 over ipv6...
# Starting testcase 8 over ipv4...
# Starting testcase 8 over ipv6...
# Starting testcase 9 over ipv4...
# Starting testcase 9 over ipv6...
# PASSED.
ok 42 selftests: net: rxtimestamp.sh
# selftests: net: devlink_port_split.py
# Traceback (most recent call last):
#   File "./devlink_port_split.py", line 277, in <module>
#     main()
#   File "./devlink_port_split.py", line 242, in main
#     dev = list(devs.keys())[0]
# IndexError: list index out of range
not ok 43 selftests: net: devlink_port_split.py # exit=1
# selftests: net: drop_monitor_tests.sh
# SKIP: Could not run test without tshark tool
ok 44 selftests: net: drop_monitor_tests.sh # SKIP
# selftests: net: vrf_route_leaking.sh
# 
# ###########################################################################
# IPv4 (sym route): VRF ICMP ttl error route lookup ping
# ###########################################################################
# 
# TEST: Basic IPv4 connectivity                                       [ OK ]
# TEST: Ping received ICMP ttl exceeded                               [ OK ]
# 
# ###########################################################################
# IPv4 (sym route): VRF ICMP error route lookup traceroute
# ###########################################################################
# 
# SKIP: Could not run IPV4 test without traceroute
# 
# ###########################################################################
# IPv4 (sym route): VRF ICMP fragmentation error route lookup ping
# ###########################################################################
# 
# TEST: Basic IPv4 connectivity                                       [ OK ]
# TEST: Ping received ICMP Frag needed                                [ OK ]
# 
# ###########################################################################
# IPv4 (asym route): VRF ICMP ttl error route lookup ping
# ###########################################################################
# 
# TEST: Basic IPv4 connectivity                                       [ OK ]
# TEST: Ping received ICMP ttl exceeded                               [ OK ]
# 
# ###########################################################################
# IPv4 (asym route): VRF ICMP error route lookup traceroute
# ###########################################################################
# 
# SKIP: Could not run IPV4 test without traceroute
# 
# ###########################################################################
# IPv6 (sym route): VRF ICMP ttl error route lookup ping
# ###########################################################################
# 
# TEST: Basic IPv6 connectivity                                       [ OK ]
# TEST: Ping received ICMP Hop limit                                  [ OK ]
# 
# ###########################################################################
# IPv6 (sym route): VRF ICMP error route lookup traceroute
# ###########################################################################
# 
# SKIP: Could not run IPV6 test without traceroute6
# 
# ###########################################################################
# IPv6 (sym route): VRF ICMP fragmentation error route lookup ping
# ###########################################################################
# 
# TEST: Basic IPv6 connectivity                                       [ OK ]
# TEST: Ping received ICMP Packet too big                             [FAIL]
# 
# ###########################################################################
# IPv6 (asym route): VRF ICMP ttl error route lookup ping
# ###########################################################################
# 
# TEST: Basic IPv6 connectivity                                       [ OK ]
# TEST: Ping received ICMP Hop limit                                  [ OK ]
# 
# ###########################################################################
# IPv6 (asym route): VRF ICMP error route lookup traceroute
# ###########################################################################
# 
# SKIP: Could not run IPV6 test without traceroute6
# 
# Tests passed:  11
# Tests failed:   1
not ok 45 selftests: net: vrf_route_leaking.sh # exit=1
# selftests: net: bareudp.sh
# TEST: IPv4 packets over UDPv4                                       [ OK ]
# TEST: IPv4 packets over UDPv6                                       [ OK ]
# TEST: IPv6 packets over UDPv4                                       [ OK ]
# TEST: IPv6 packets over UDPv6                                       [ OK ]
# TEST: IPv4 packets over UDPv4 (multiproto mode)                     [ OK ]
# TEST: IPv6 packets over UDPv4 (multiproto mode)                     [ OK ]
# TEST: IPv4 packets over UDPv6 (multiproto mode)                     [ OK ]
# TEST: IPv6 packets over UDPv6 (multiproto mode)                     [ OK ]
# TEST: Unicast MPLS packets over UDPv4                               [ OK ]
# TEST: Unicast MPLS packets over UDPv6                               [ OK ]
ok 46 selftests: net: bareudp.sh
# selftests: net: unicast_extensions.sh
# ###########################################################################
# Unicast address extensions tests (behavior of reserved IPv4 addresses)
# ###########################################################################
# TEST: assign and ping within 240/4 (1 of 2) (is allowed)            [ OK ]
# TEST: assign and ping within 240/4 (2 of 2) (is allowed)            [ OK ]
# TEST: assign and ping within 0/8 (1 of 2) (is allowed)              [ OK ]
# TEST: assign and ping within 0/8 (2 of 2) (is allowed)              [ OK ]
# TEST: assign and ping inside 255.255/16 (is allowed)                [ OK ]
# TEST: assign and ping inside 255.255.255/24 (is allowed)            [ OK ]
# TEST: route between 240.5.6/24 and 255.1.2/24 (is allowed)          [ OK ]
# TEST: route between 0.200/16 and 245.99/16 (is allowed)             [ OK ]
# TEST: assigning 0.0.0.0 (is forbidden)                              [ OK ]
# TEST: assigning 255.255.255.255 (is forbidden)                      [ OK ]
# TEST: assign and ping inside 127/8 (is forbidden)                   [ OK ]
# TEST: assign and ping lowest address (is forbidden)                 [ OK ]
# TEST: routing using lowest address (is forbidden)                   [ OK ]
# TEST: assign and ping class D address (is forbidden)                [ OK ]
# TEST: routing using class D (is forbidden)                          [ OK ]
# TEST: routing using 127/8 (is forbidden)                            [ OK ]
ok 47 selftests: net: unicast_extensions.sh

--eqp4TxRxnD4KrmFZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/kernel-selftests-bm.yaml
suite: kernel-selftests
testcase: kernel-selftests
category: functional
kconfig: x86_64-rhel-8.3-kselftests
kernel-selftests:
  group: net
job_origin: kernel-selftests-bm.yaml

#! queue options
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-skl-d06
tbox_group: lkp-skl-d06
submit_id: 607bcf9bfe6df98ddd12c1b8
job_file: "/lkp/jobs/scheduled/lkp-skl-d06/kernel-selftests-net-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-6628ddfec7580882f11fdc5c194a8ea781fdadfa-20210418-36317-1y3lgpp-0.yaml"
id: 488bea509d29f50fa3c70340da5c9b574e9391c2
queuer_version: "/lkp-src"

#! hosts/lkp-skl-d06
model: Skylake
nr_cpu: 4
memory: 16G
nr_ssd_partitions: 1
nr_hdd_partitions: 4
hdd_partitions: "/dev/disk/by-id/ata-WDC_WD10EARS-00Y5B1_WD-WCAV5F059074-part*"
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2BB012T4_BTWD422402M81P2GGN-part2"
rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2BB012T4_BTWD422402M81P2GGN-part1"
brand: Intel(R) Xeon(R) CPU E3-1225 v5 @ 3.30GHz

#! include/category/functional
kmsg: 
heartbeat: 
meminfo: 

#! include/queue/cyclic
commit: 6628ddfec7580882f11fdc5c194a8ea781fdadfa

#! include/testbox/lkp-skl-d06
need_kconfig_hw:
- CONFIG_E1000E=y
- CONFIG_SATA_AHCI
ucode: '0xe2'

#! include/kernel-selftests
need_linux_headers: true
need_linux_selftests: true
need_kselftests: true
need_kconfig:
- CONFIG_USER_NS=y
- CONFIG_BPF_SYSCALL=y
- CONFIG_TEST_BPF=m
- CONFIG_NUMA=y ~ ">= v5.6-rc1"
- CONFIG_NET_VRF=y ~ ">= v4.3-rc1"
- CONFIG_NET_L3_MASTER_DEV=y ~ ">= v4.4-rc1"
- CONFIG_IPV6=y
- CONFIG_IPV6_MULTIPLE_TABLES=y
- CONFIG_VETH=y
- CONFIG_NET_IPVTI=m
- CONFIG_IPV6_VTI=m
- CONFIG_DUMMY=y
- CONFIG_BRIDGE=y
- CONFIG_VLAN_8021Q=y
- CONFIG_IFB=y
- CONFIG_NETFILTER=y
- CONFIG_NETFILTER_ADVANCED=y
- CONFIG_NF_CONNTRACK=m
- CONFIG_NF_NAT=m ~ ">= v5.1-rc1"
- CONFIG_IP6_NF_IPTABLES=m
- CONFIG_IP_NF_IPTABLES=m
- CONFIG_IP6_NF_NAT=m
- CONFIG_IP_NF_NAT=m
- CONFIG_NF_TABLES=m
- CONFIG_NF_TABLES_IPV6=y ~ ">= v4.17-rc1"
- CONFIG_NF_TABLES_IPV4=y ~ ">= v4.17-rc1"
- CONFIG_NFT_CHAIN_NAT_IPV6=m ~ "<= v5.0"
- CONFIG_NFT_CHAIN_NAT_IPV4=m ~ "<= v5.0"
- CONFIG_NET_SCH_FQ=m
- CONFIG_NET_SCH_ETF=m ~ ">= v4.19-rc1"
- CONFIG_NET_SCH_NETEM=y
- CONFIG_TEST_BLACKHOLE_DEV=m ~ ">= v5.3-rc1"
- CONFIG_KALLSYMS=y
- CONFIG_BAREUDP=m ~ ">= v5.7-rc1"
- CONFIG_MPLS_ROUTING=m ~ ">= v4.1-rc1"
- CONFIG_MPLS_IPTUNNEL=m ~ ">= v4.3-rc1"
- CONFIG_NET_SCH_INGRESS=y ~ ">= v4.19-rc1"
- CONFIG_NET_CLS_FLOWER=m ~ ">= v4.2-rc1"
- CONFIG_NET_ACT_TUNNEL_KEY=m ~ ">= v4.9-rc1"
- CONFIG_NET_ACT_MIRRED=m ~ ">= v5.11-rc1"
enqueue_time: 2021-04-18 14:20:11.801399118 +08:00
_id: 607bcf9bfe6df98ddd12c1b8
_rt: "/result/kernel-selftests/net-ucode=0xe2/lkp-skl-d06/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/6628ddfec7580882f11fdc5c194a8ea781fdadfa"

#! schedule options
user: lkp
compiler: gcc-9
LKP_SERVER: internal-lkp-server
head_commit: e242eeab609680685a735f61f42eda2902d346fd
base_commit: d434405aaab7d0ebc516b68a8fc4100922d7f5ef
branch: linux-devel/devel-hourly-20210417-185942
rootfs: debian-10.4-x86_64-20200603.cgz
result_root: "/result/kernel-selftests/net-ucode=0xe2/lkp-skl-d06/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/6628ddfec7580882f11fdc5c194a8ea781fdadfa/0"
scheduler_version: "/lkp/lkp/.src-20210417-193648"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-skl-d06/kernel-selftests-net-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-6628ddfec7580882f11fdc5c194a8ea781fdadfa-20210418-36317-1y3lgpp-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3-kselftests
- branch=linux-devel/devel-hourly-20210417-185942
- commit=6628ddfec7580882f11fdc5c194a8ea781fdadfa
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/6628ddfec7580882f11fdc5c194a8ea781fdadfa/vmlinuz-5.12.0-rc6-00349-g6628ddfec758
- max_uptime=2100
- RESULT_ROOT=/result/kernel-selftests/net-ucode=0xe2/lkp-skl-d06/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/6628ddfec7580882f11fdc5c194a8ea781fdadfa/0
- LKP_SERVER=internal-lkp-server
- nokaslr
- selinux=0
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw
modules_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/6628ddfec7580882f11fdc5c194a8ea781fdadfa/modules.cgz"
linux_headers_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/6628ddfec7580882f11fdc5c194a8ea781fdadfa/linux-headers.cgz"
linux_selftests_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/6628ddfec7580882f11fdc5c194a8ea781fdadfa/linux-selftests.cgz"
kselftests_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/6628ddfec7580882f11fdc5c194a8ea781fdadfa/kselftests.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/kernel-selftests_20210406.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/kernel-selftests-x86_64-cf9ae1bd-1_20210401.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20210222.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20210417-193648/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 5.12.0-rc7

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/6628ddfec7580882f11fdc5c194a8ea781fdadfa/vmlinuz-5.12.0-rc6-00349-g6628ddfec758"
dequeue_time: 2021-04-18 14:50:56.431045799 +08:00
job_state: finished
loadavg: 0.49 0.86 0.51 1/146 18560
start_time: '1618728755'
end_time: '1618729192'
version: "/lkp/lkp/.src-20210417-193744:c99f84f0:3a5ccfeea"

--eqp4TxRxnD4KrmFZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

mount --bind /lib/modules/5.12.0-rc6-00349-g6628ddfec758/kernel/lib /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-6628ddfec7580882f11fdc5c194a8ea781fdadfa/lib
sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
/kselftests/run_kselftest.sh -c net

--eqp4TxRxnD4KrmFZ--
