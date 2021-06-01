Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34633396B0D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 04:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbhFAC0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 22:26:20 -0400
Received: from mga18.intel.com ([134.134.136.126]:63410 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232635AbhFAC0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 22:26:16 -0400
IronPort-SDR: OSQn5ojsfol2U0RckXNSrW/8f2P1yejXG5I7r7fF9KJ3VSvH8cZunKvtrRkRT+XkGcGOezNoFh
 toWtOgYzj2nw==
X-IronPort-AV: E=McAfee;i="6200,9189,10001"; a="190814552"
X-IronPort-AV: E=Sophos;i="5.83,239,1616482800"; 
   d="xz'?yaml'?scan'208";a="190814552"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 19:24:34 -0700
IronPort-SDR: z6mlgYYYvm9jBp3+NZKCIKEwBPdEgTHsKYNLXrDDWbNDvyzwDIvIBdLXMzpU5vGnsk42eqUYBr
 cH3J5aPJDcJQ==
X-IronPort-AV: E=Sophos;i="5.83,239,1616482800"; 
   d="xz'?yaml'?scan'208";a="479096767"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.41])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 19:24:29 -0700
Date:   Tue, 1 Jun 2021 10:41:01 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Taehee Yoo <ap420073@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: [mld]  020ef930b8:
 kernel-selftests.net.pmtu.sh.ipv6_cleanup_of_cached_exceptions_-_nexthop_objects.fail
Message-ID: <20210601024101.GA26304@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



Greeting,

FYI, we noticed the following commit (built with gcc-9):

commit: 020ef930b826d21c5446fdc9db80fd72a791bc21 ("mld: fix panic in mld_ne=
wpack()")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


in testcase: kernel-selftests
version: kernel-selftests-x86_64-0d95472a-1_20210507
with following parameters:

	group: net
	ucode: 0xe2

test-description: The kernel contains a set of "self tests" under the tools=
/testing/selftests/ directory. These are intended to be small unit tests to=
 exercise individual code paths in the kernel.
test-url: https://www.kernel.org/doc/Documentation/kselftest.txt


on test machine: 8 threads Intel(R) Core(TM) i7-6770HQ CPU @ 2.60GHz with 3=
2G memory

caused below changes (please refer to attached dmesg/kmsg for entire log/ba=
cktrace):




If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-8=
=2E3-kselftests-020ef930b826d21c5446fdc9db80fd72a791bc21
2021-05-29 21:15:23 mount --bind /lib/modules/5.12.0-15091-g020ef930b826/ke=
rnel/lib /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-020ef930b826d21=
c5446fdc9db80fd72a791bc21/lib
2021-05-29 21:15:23 sed -i s/default_timeout=3D45/default_timeout=3D300/ ks=
elftest/runner.sh
2021-05-29 21:15:23 sed -i s/default_timeout=3D45/default_timeout=3D300/ /k=
selftests/kselftest/runner.sh
source /lkp/lkp/src/lib/tests/kernel-selftests-ext.sh
LKP SKIP net.l2tp.sh
LKP SKIP net.tls
2021-05-29 21:15:24 /kselftests/run_kselftest.sh -c net
TAP version 13
1..49
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
# send cpu 4, receive socket 4
# send cpu 5, receive socket 5
# send cpu 6, receive socket 6
# send cpu 7, receive socket 7
# send cpu 7, receive socket 7
# send cpu 6, receive socket 6
# send cpu 5, receive socket 5
# send cpu 4, receive socket 4
# send cpu 3, receive socket 3
# send cpu 2, receive socket 2
# send cpu 1, receive socket 1
# send cpu 0, receive socket 0
# send cpu 0, receive socket 0
# send cpu 2, receive socket 2
# send cpu 4, receive socket 4
# send cpu 6, receive socket 6
# send cpu 1, receive socket 1
# send cpu 3, receive socket 3
# send cpu 5, receive socket 5
# send cpu 7, receive socket 7
# ---- IPv6 UDP ----
# send cpu 0, receive socket 0
# send cpu 1, receive socket 1
# send cpu 2, receive socket 2
# send cpu 3, receive socket 3
# send cpu 4, receive socket 4
# send cpu 5, receive socket 5
# send cpu 6, receive socket 6
# send cpu 7, receive socket 7
# send cpu 7, receive socket 7
# send cpu 6, receive socket 6
# send cpu 5, receive socket 5
# send cpu 4, receive socket 4
# send cpu 3, receive socket 3
# send cpu 2, receive socket 2
# send cpu 1, receive socket 1
# send cpu 0, receive socket 0
# send cpu 0, receive socket 0
# send cpu 2, receive socket 2
# send cpu 4, receive socket 4
# send cpu 6, receive socket 6
# send cpu 1, receive socket 1
# send cpu 3, receive socket 3
# send cpu 5, receive socket 5
# send cpu 7, receive socket 7
# ---- IPv4 TCP ----
# send cpu 0, receive socket 0
# send cpu 1, receive socket 1
# send cpu 2, receive socket 2
# send cpu 3, receive socket 3
# send cpu 4, receive socket 4
# send cpu 5, receive socket 5
# send cpu 6, receive socket 6
# send cpu 7, receive socket 7
# send cpu 7, receive socket 7
# send cpu 6, receive socket 6
# send cpu 5, receive socket 5
# send cpu 4, receive socket 4
# send cpu 3, receive socket 3
# send cpu 2, receive socket 2
# send cpu 1, receive socket 1
# send cpu 0, receive socket 0
# send cpu 0, receive socket 0
# send cpu 2, receive socket 2
# send cpu 4, receive socket 4
# send cpu 6, receive socket 6
# send cpu 1, receive socket 1
# send cpu 3, receive socket 3
# send cpu 5, receive socket 5
# send cpu 7, receive socket 7
# ---- IPv6 TCP ----
# send cpu 0, receive socket 0
# send cpu 1, receive socket 1
# send cpu 2, receive socket 2
# send cpu 3, receive socket 3
# send cpu 4, receive socket 4
# send cpu 5, receive socket 5
# send cpu 6, receive socket 6
# send cpu 7, receive socket 7
# send cpu 7, receive socket 7
# send cpu 6, receive socket 6
# send cpu 5, receive socket 5
# send cpu 4, receive socket 4
# send cpu 3, receive socket 3
# send cpu 2, receive socket 2
# send cpu 1, receive socket 1
# send cpu 0, receive socket 0
# send cpu 0, receive socket 0
# send cpu 2, receive socket 2
# send cpu 4, receive socket 4
# send cpu 6, receive socket 6
# send cpu 1, receive socket 1
# send cpu 3, receive socket 3
# send cpu 5, receive socket 5
# send cpu 7, receive socket 7
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
#=20
# test: datapath 0x0 ports 8000,8002
# info: count=3D0,0, expect=3D0,0
# info: count=3D20,0, expect=3D15,5
# warning: incorrect queue lengths
# info: count=3D20,0, expect=3D20,5
# warning: incorrect queue lengths
# info: trying alternate ports (20)
#=20
# test: datapath 0x0 ports 8000,8003
# info: count=3D0,0, expect=3D0,0
# info: count=3D15,5, expect=3D15,5
# info: count=3D20,5, expect=3D20,5
#=20
# test: datapath 0x1000 ports 8000,8003
# info: count=3D0,0, expect=3D0,0
# info: count=3D15,5, expect=3D15,5
# info: count=3D20,15, expect=3D20,15
#=20
# test: datapath 0x1 ports 8000,8003
# info: count=3D0,0, expect=3D0,0
# info: count=3D10,10, expect=3D10,10
# info: count=3D17,18, expect=3D18,17
#=20
# test: datapath 0x3 ports 8000,8003
# info: count=3D0,0, expect=3D0,0
# info: count=3D15,5, expect=3D15,5
# info: count=3D20,15, expect=3D20,15
#=20
# test: datapath 0x6 ports 8000,8003
# info: count=3D0,0, expect=3D0,0
# info: count=3D5,15, expect=3D15,5
# info: count=3D20,15, expect=3D15,20
#=20
# test: datapath 0x7 ports 8000,8003
# info: count=3D0,0, expect=3D0,0
# info: count=3D5,15, expect=3D15,5
# info: count=3D20,15, expect=3D15,20
#=20
# test: datapath 0x2 ports 8000,8003
# info: count=3D0,0, expect=3D0,0
# info: count=3D20,0, expect=3D20,0
# info: count=3D20,0, expect=3D20,0
#=20
# test: datapath 0x2 ports 8000,8003
# info: count=3D0,0, expect=3D0,0
# info: count=3D0,20, expect=3D0,20
# info: count=3D0,20, expect=3D0,20
#=20
# test: datapath 0x2000 ports 8000,8003
# info: count=3D0,0, expect=3D0,0
# info: count=3D20,20, expect=3D20,20
# info: count=3D20,20, expect=3D20,20
# OK. All tests passed
# [PASS]
# --------------------
# running psock_tpacket test
# --------------------
# test: TPACKET_V1 with PACKET_RX_RING .................... 100 pkts (14200=
 bytes)
# test: TPACKET_V1 with PACKET_TX_RING .................... 100 pkts (14200=
 bytes)
# test: TPACKET_V2 with PACKET_RX_RING .................... 100 pkts (14200=
 bytes)
# test: TPACKET_V2 with PACKET_TX_RING .................... 100 pkts (14200=
 bytes)
# test: TPACKET_V3 with PACKET_RX_RING .................... 100 pkts (14200=
 bytes)
# test: TPACKET_V3 with PACKET_TX_RING .................... 100 pkts (14200=
 bytes)
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
# PASS: set ifalias 93795cf0-4a8d-4cf3-a2be-77b18a91305c for test-dummy0
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
#=20
# Error: argument "test-bond0" is wrong: Device does not exist
#=20
# Cannot find device "test-bond0"
# Cannot find device "test-bond0"
# FAIL: bridge_parent_id
not ok 10 selftests: net: rtnetlink.sh # exit=3D1
# selftests: net: xfrm_policy.sh
# PASS: policy before exception matches
# PASS: ping to .254 bypassed ipsec tunnel (exceptions)
# PASS: direct policy matches (exceptions)
# PASS: policy matches (exceptions)
# PASS: ping to .254 bypassed ipsec tunnel (exceptions and block policies)
# PASS: direct policy matches (exceptions and block policies)
# PASS: policy matches (exceptions and block policies)
# PASS: ping to .254 bypassed ipsec tunnel (exceptions and block policies a=
fter hresh changes)
# PASS: direct policy matches (exceptions and block policies after hresh ch=
anges)
# PASS: policy matches (exceptions and block policies after hresh changes)
# PASS: ping to .254 bypassed ipsec tunnel (exceptions and block policies a=
fter hthresh change in ns3)
# PASS: direct policy matches (exceptions and block policies after hthresh =
change in ns3)
# PASS: policy matches (exceptions and block policies after hthresh change =
in ns3)
# PASS: ping to .254 bypassed ipsec tunnel (exceptions and block policies a=
fter htresh change to normal)
# PASS: direct policy matches (exceptions and block policies after htresh c=
hange to normal)
# PASS: policy matches (exceptions and block policies after htresh change t=
o normal)
# PASS: policies with repeated htresh change
# PASS: policies inserted in random order
ok 11 selftests: net: xfrm_policy.sh
# selftests: net: test_blackhole_dev.sh
# test_blackhole_dev: ok
ok 12 selftests: net: test_blackhole_dev.sh
# selftests: net: fib_tests.sh
#=20
# Single path route test
#     Start point
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     Nexthop device deleted
#     TEST: IPv4 fibmatch - no route                                      [=
 OK ]
#     TEST: IPv6 fibmatch - no route                                      [=
 OK ]
#=20
# Multipath route test
#     Start point
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     One nexthop device deleted
#     TEST: IPv4 - multipath route removed on delete                      [=
 OK ]
#     TEST: IPv6 - multipath down to single path                          [=
 OK ]
#     Second nexthop device deleted
#     TEST: IPv6 - no route                                               [=
 OK ]
#=20
# Single path, admin down
#     Start point
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     Route deleted on down
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#=20
# Admin down multipath
#     Verify start point
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     One device down, one up
#     TEST: IPv4 fibmatch on down device                                  [=
 OK ]
#     TEST: IPv6 fibmatch on down device                                  [=
 OK ]
#     TEST: IPv4 fibmatch on up device                                    [=
 OK ]
#     TEST: IPv6 fibmatch on up device                                    [=
 OK ]
#     TEST: IPv4 flags on down device                                     [=
 OK ]
#     TEST: IPv6 flags on down device                                     [=
 OK ]
#     TEST: IPv4 flags on up device                                       [=
 OK ]
#     TEST: IPv6 flags on up device                                       [=
 OK ]
#     Other device down and up
#     TEST: IPv4 fibmatch on down device                                  [=
 OK ]
#     TEST: IPv6 fibmatch on down device                                  [=
 OK ]
#     TEST: IPv4 fibmatch on up device                                    [=
 OK ]
#     TEST: IPv6 fibmatch on up device                                    [=
 OK ]
#     TEST: IPv4 flags on down device                                     [=
 OK ]
#     TEST: IPv6 flags on down device                                     [=
 OK ]
#     TEST: IPv4 flags on up device                                       [=
 OK ]
#     TEST: IPv6 flags on up device                                       [=
 OK ]
#     Both devices down
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#=20
# Local carrier tests - single path
#     Start point
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     TEST: IPv4 - no linkdown flag                                       [=
 OK ]
#     TEST: IPv6 - no linkdown flag                                       [=
 OK ]
#     Carrier off on nexthop
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     TEST: IPv4 - linkdown flag set                                      [=
 OK ]
#     TEST: IPv6 - linkdown flag set                                      [=
 OK ]
#     Route to local address with carrier down
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     TEST: IPv4 linkdown flag set                                        [=
 OK ]
#     TEST: IPv6 linkdown flag set                                        [=
 OK ]
#=20
# Single path route carrier test
#     Start point
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     TEST: IPv4 no linkdown flag                                         [=
 OK ]
#     TEST: IPv6 no linkdown flag                                         [=
 OK ]
#     Carrier down
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     TEST: IPv4 linkdown flag set                                        [=
 OK ]
#     TEST: IPv6 linkdown flag set                                        [=
 OK ]
#     Second address added with carrier down
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     TEST: IPv4 linkdown flag set                                        [=
 OK ]
#     TEST: IPv6 linkdown flag set                                        [=
 OK ]
#=20
# IPv4 nexthop tests
# <<< write me >>>
#=20
# IPv6 nexthop tests
#     TEST: Directly connected nexthop, unicast address                   [=
 OK ]
#     TEST: Directly connected nexthop, unicast address with device       [=
 OK ]
#     TEST: Gateway is linklocal address                                  [=
 OK ]
#     TEST: Gateway is linklocal address, no device                       [=
 OK ]
#     TEST: Gateway can not be local unicast address                      [=
 OK ]
#     TEST: Gateway can not be local unicast address, with device         [=
 OK ]
#     TEST: Gateway can not be a local linklocal address                  [=
 OK ]
#     TEST: Gateway can be local address in a VRF                         [=
 OK ]
#     TEST: Gateway can be local address in a VRF, with device            [=
 OK ]
#     TEST: Gateway can be local linklocal address in a VRF               [=
 OK ]
#     TEST: Redirect to VRF lookup                                        [=
 OK ]
#     TEST: VRF route, gateway can be local address in default VRF        [=
 OK ]
#     TEST: VRF route, gateway can not be a local address                 [=
 OK ]
#     TEST: VRF route, gateway can not be a local addr with device        [=
 OK ]
#=20
# FIB rule with suppress_prefixlength
#     TEST: FIB rule suppress test                                        [=
 OK ]
#=20
# IPv6 route add / append tests
#     TEST: Attempt to add duplicate route - gw                           [=
 OK ]
#     TEST: Attempt to add duplicate route - dev only                     [=
 OK ]
#     TEST: Attempt to add duplicate route - reject route                 [=
 OK ]
#     TEST: Append nexthop to existing route - gw                         [=
 OK ]
#     TEST: Add multipath route                                           [=
 OK ]
#     TEST: Attempt to add duplicate multipath route                      [=
 OK ]
#     TEST: Route add with different metrics                              [=
 OK ]
#     TEST: Route delete with metric                                      [=
 OK ]
#=20
# IPv6 route replace tests
#     TEST: Single path with single path                                  [=
 OK ]
#     TEST: Single path with multipath                                    [=
 OK ]
#     TEST: Single path with single path via multipath attribute          [=
 OK ]
#     TEST: Invalid nexthop                                               [=
 OK ]
#     TEST: Single path - replace of non-existent route                   [=
 OK ]
#     TEST: Multipath with multipath                                      [=
 OK ]
#     TEST: Multipath with single path                                    [=
 OK ]
#     TEST: Multipath with single path via multipath attribute            [=
 OK ]
#     TEST: Multipath with dev-only                                       [=
 OK ]
#     TEST: Multipath - invalid first nexthop                             [=
 OK ]
#     TEST: Multipath - invalid second nexthop                            [=
 OK ]
#     TEST: Multipath - replace of non-existent route                     [=
 OK ]
#=20
# IPv4 route add / append tests
#     TEST: Attempt to add duplicate route - gw                           [=
 OK ]
#     TEST: Attempt to add duplicate route - dev only                     [=
 OK ]
#     TEST: Attempt to add duplicate route - reject route                 [=
 OK ]
#     TEST: Add new nexthop for existing prefix                           [=
 OK ]
#     TEST: Append nexthop to existing route - gw                         [=
 OK ]
#     TEST: Append nexthop to existing route - dev only                   [=
 OK ]
#     TEST: Append nexthop to existing route - reject route               [=
 OK ]
#     TEST: Append nexthop to existing reject route - gw                  [=
 OK ]
#     TEST: Append nexthop to existing reject route - dev only            [=
 OK ]
#     TEST: add multipath route                                           [=
 OK ]
#     TEST: Attempt to add duplicate multipath route                      [=
 OK ]
#     TEST: Route add with different metrics                              [=
 OK ]
#     TEST: Route delete with metric                                      [=
 OK ]
#=20
# IPv4 route replace tests
#     TEST: Single path with single path                                  [=
 OK ]
#     TEST: Single path with multipath                                    [=
 OK ]
#     TEST: Single path with reject route                                 [=
 OK ]
#     TEST: Single path with single path via multipath attribute          [=
 OK ]
#     TEST: Invalid nexthop                                               [=
 OK ]
#     TEST: Single path - replace of non-existent route                   [=
 OK ]
#     TEST: Multipath with multipath                                      [=
 OK ]
#     TEST: Multipath with single path                                    [=
 OK ]
#     TEST: Multipath with single path via multipath attribute            [=
 OK ]
#     TEST: Multipath with reject route                                   [=
 OK ]
#     TEST: Multipath - invalid first nexthop                             [=
 OK ]
#     TEST: Multipath - invalid second nexthop                            [=
 OK ]
#     TEST: Multipath - replace of non-existent route                     [=
 OK ]
#=20
# IPv6 prefix route tests
#     TEST: Default metric                                                [=
 OK ]
#     TEST: User specified metric on first device                         [=
 OK ]
#     TEST: User specified metric on second device                        [=
 OK ]
#     TEST: Delete of address on first device                             [=
 OK ]
#     TEST: Modify metric of address                                      [=
 OK ]
#     TEST: Prefix route removed on link down                             [=
 OK ]
#     TEST: Prefix route with metric on link up                           [=
 OK ]
#     TEST: Set metric with peer route on local side                      [=
 OK ]
#     TEST: Set metric with peer route on peer side                       [=
 OK ]
#     TEST: Modify metric and peer address on local side                  [=
 OK ]
#     TEST: Modify metric and peer address on peer side                   [=
 OK ]
#=20
# IPv4 prefix route tests
#     TEST: Default metric                                                [=
 OK ]
#     TEST: User specified metric on first device                         [=
 OK ]
#     TEST: User specified metric on second device                        [=
 OK ]
#     TEST: Delete of address on first device                             [=
 OK ]
#     TEST: Modify metric of address                                      [=
 OK ]
#     TEST: Prefix route removed on link down                             [=
 OK ]
#     TEST: Prefix route with metric on link up                           [=
 OK ]
#     TEST: Modify metric of .0/24 address                                [=
 OK ]
#     TEST: Set metric of address with peer route                         [=
 OK ]
#     TEST: Modify metric and peer address for peer route                 [=
 OK ]
#=20
# IPv6 routes with metrics
#     TEST: Single path route with mtu metric                             [=
 OK ]
#     TEST: Multipath route via 2 single routes with mtu metric on first  [=
 OK ]
#     TEST: Multipath route via 2 single routes with mtu metric on 2nd    [=
 OK ]
#     TEST:     MTU of second leg                                         [=
 OK ]
#     TEST: Multipath route with mtu metric                               [=
 OK ]
#     TEST: Using route with mtu metric                                   [=
 OK ]
#     TEST: Invalid metric (fails metric_convert)                         [=
 OK ]
#=20
# IPv4 route add / append tests
#     TEST: Single path route with mtu metric                             [=
 OK ]
#     TEST: Multipath route with mtu metric                               [=
 OK ]
#     TEST: Using route with mtu metric                                   [=
 OK ]
#     TEST: Invalid metric (fails metric_convert)                         [=
 OK ]
#=20
# IPv4 route with IPv6 gateway tests
#     TEST: Single path route with IPv6 gateway                           [=
 OK ]
#     TEST: Single path route with IPv6 gateway - ping                    [=
 OK ]
#     TEST: Single path route delete                                      [=
 OK ]
#     TEST: Multipath route add - v6 nexthop then v4                      [=
 OK ]
#     TEST:     Multipath route delete - nexthops in wrong order          [=
 OK ]
#     TEST:     Multipath route delete exact match                        [=
 OK ]
#     TEST: Multipath route add - v4 nexthop then v6                      [=
 OK ]
#     TEST:     Multipath route delete - nexthops in wrong order          [=
 OK ]
#     TEST:     Multipath route delete exact match                        [=
 OK ]
#=20
# IPv4 rp_filter tests
#     TEST: rp_filter passes local packets                                [=
FAIL]
#     TEST: rp_filter passes loopback packets                             [=
FAIL]
#=20
# IPv4 delete address route tests
#     TEST: Route removed from VRF when source address deleted            [=
 OK ]
#     TEST: Route in default VRF not removed                              [=
 OK ]
#     TEST: Route removed in default VRF when source address deleted      [=
 OK ]
#     TEST: Route in VRF is not removed by address delete                 [=
 OK ]
#=20
# IPv4 mangling tests
# socat command not found. Skipping test
#=20
# IPv6 mangling tests
# socat command not found. Skipping test
#=20
# Tests passed: 163
# Tests failed:   2
not ok 13 selftests: net: fib_tests.sh # exit=3D1
# selftests: net: fib-onlink-tests.sh
# Error: ipv4: FIB table does not exist.
# Flush terminated
# Error: ipv6: FIB table does not exist.
# Flush terminated
#=20
# ########################################
# Configuring interfaces
#=20
# ######################################################################
# TEST SECTION: IPv4 onlink
# ######################################################################
#=20
# #########################################
# TEST SUBSECTION: Valid onlink commands
#=20
# #########################################
# TEST SUBSECTION: default VRF - main table
#     TEST: unicast connected                                   [ OK ]
#     TEST: unicast recursive                                   [ OK ]
#=20
# #########################################
# TEST SUBSECTION: VRF lisa
#     TEST: unicast connected                                   [ OK ]
#     TEST: unicast recursive                                   [ OK ]
#=20
# #########################################
# TEST SUBSECTION: VRF device, PBR table
#     TEST: unicast connected                                   [ OK ]
#     TEST: unicast recursive                                   [ OK ]
#=20
# #########################################
# TEST SUBSECTION: default VRF - main table - multipath
#     TEST: unicast connected - multipath                       [ OK ]
#     TEST: unicast recursive - multipath                       [ OK ]
#     TEST: unicast connected - multipath onlink first only     [ OK ]
#     TEST: unicast connected - multipath onlink second only    [ OK ]
#=20
# #########################################
# TEST SUBSECTION: Invalid onlink commands
#     TEST: Invalid gw - local unicast address                  [ OK ]
#     TEST: Invalid gw - local unicast address, VRF             [ OK ]
#     TEST: No nexthop device given                             [ OK ]
#     TEST: Gateway resolves to wrong nexthop device            [ OK ]
#     TEST: Gateway resolves to wrong nexthop device - VRF      [ OK ]
#=20
# ######################################################################
# TEST SECTION: IPv6 onlink
# ######################################################################
#=20
# #########################################
# TEST SUBSECTION: Valid onlink commands
#=20
# #########################################
# TEST SUBSECTION: default VRF - main table
#     TEST: unicast connected                                   [ OK ]
#     TEST: unicast recursive                                   [ OK ]
#     TEST: v4-mapped                                           [ OK ]
#=20
# #########################################
# TEST SUBSECTION: VRF lisa
#     TEST: unicast connected                                   [ OK ]
#     TEST: unicast recursive                                   [ OK ]
#     TEST: v4-mapped                                           [ OK ]
#=20
# #########################################
# TEST SUBSECTION: VRF device, PBR table
#     TEST: unicast connected                                   [ OK ]
#     TEST: unicast recursive                                   [ OK ]
#     TEST: v4-mapped                                           [ OK ]
#=20
# #########################################
# TEST SUBSECTION: default VRF - main table - multipath
#     TEST: unicast connected - multipath onlink                [ OK ]
#     TEST: unicast recursive - multipath onlink                [ OK ]
#     TEST: v4-mapped - multipath onlink                        [ OK ]
#     TEST: unicast connected - multipath onlink both nexthops  [ OK ]
#     TEST: unicast connected - multipath onlink first only     [ OK ]
#     TEST: unicast connected - multipath onlink second only    [ OK ]
#=20
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
#=20
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
# TEST: IPv4 over geneve6: PMTU exceptions                            [ OK ]
# TEST: IPv4 over geneve6: PMTU exceptions - nexthop objects          [ OK ]
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
# TEST: IPv4, bridged geneve4: PMTU exceptions                        [ OK ]
# TEST: IPv4, bridged geneve4: PMTU exceptions - nexthop objects      [ OK ]
# TEST: IPv6, bridged geneve4: PMTU exceptions                        [ OK ]
# TEST: IPv6, bridged geneve4: PMTU exceptions - nexthop objects      [ OK ]
# TEST: IPv4, bridged geneve6: PMTU exceptions                        [ OK ]
# TEST: IPv4, bridged geneve6: PMTU exceptions - nexthop objects      [ OK ]
# TEST: IPv6, bridged geneve6: PMTU exceptions                        [ OK ]
# TEST: IPv6, bridged geneve6: PMTU exceptions - nexthop objects      [ OK ]
#   ovs_bridge not supported
# TEST: IPv4, OVS vxlan4: PMTU exceptions                             [SKIP]
#   ovs_bridge not supported
# TEST: IPv6, OVS vxlan4: PMTU exceptions                             [SKIP]
#   ovs_bridge not supported
# TEST: IPv4, OVS vxlan6: PMTU exceptions                             [SKIP]
#   ovs_bridge not supported
# TEST: IPv6, OVS vxlan6: PMTU exceptions                             [SKIP]
#   ovs_bridge not supported
# TEST: IPv4, OVS geneve4: PMTU exceptions                            [SKIP]
#   ovs_bridge not supported
# TEST: IPv6, OVS geneve4: PMTU exceptions                            [SKIP]
#   ovs_bridge not supported
# TEST: IPv4, OVS geneve6: PMTU exceptions                            [SKIP]
#   ovs_bridge not supported
# TEST: IPv6, OVS geneve6: PMTU exceptions                            [SKIP]
# TEST: IPv4 over fou4: PMTU exceptions                               [ OK ]
# TEST: IPv4 over fou4: PMTU exceptions - nexthop objects             [ OK ]
# TEST: IPv6 over fou4: PMTU exceptions                               [ OK ]
# TEST: IPv6 over fou4: PMTU exceptions - nexthop objects             [ OK ]
# TEST: IPv4 over fou6: PMTU exceptions                               [ OK ]
# TEST: IPv4 over fou6: PMTU exceptions - nexthop objects             [ OK ]
# TEST: IPv6 over fou6: PMTU exceptions                               [ OK ]
# TEST: IPv6 over fou6: PMTU exceptions - nexthop objects             [ OK ]
# TEST: IPv4 over gue4: PMTU exceptions                               [ OK ]
# TEST: IPv4 over gue4: PMTU exceptions - nexthop objects             [ OK ]
# TEST: IPv6 over gue4: PMTU exceptions                               [ OK ]
# TEST: IPv6 over gue4: PMTU exceptions - nexthop objects             [ OK ]
# TEST: IPv4 over gue6: PMTU exceptions                               [ OK ]
# TEST: IPv4 over gue6: PMTU exceptions - nexthop objects             [ OK ]
# TEST: IPv6 over gue6: PMTU exceptions                               [ OK ]
# TEST: IPv6 over gue6: PMTU exceptions - nexthop objects             [ OK ]
# TEST: IPv4 over IPv4: PMTU exceptions                               [ OK ]
# TEST: IPv4 over IPv4: PMTU exceptions - nexthop objects             [ OK ]
# TEST: IPv6 over IPv4: PMTU exceptions                               [ OK ]
# TEST: IPv6 over IPv4: PMTU exceptions - nexthop objects             [ OK ]
# TEST: IPv4 over IPv6: PMTU exceptions                               [ OK ]
# TEST: IPv4 over IPv6: PMTU exceptions - nexthop objects             [ OK ]
# TEST: IPv6 over IPv6: PMTU exceptions                               [ OK ]
# TEST: IPv6 over IPv6: PMTU exceptions - nexthop objects             [ OK ]
# TEST: vti6: PMTU exceptions                                         [ OK ]
# TEST: vti4: PMTU exceptions                                         [ OK ]
# TEST: vti4: default MTU assignment                                  [ OK ]
# TEST: vti6: default MTU assignment                                  [ OK ]
# TEST: vti4: MTU setting on link creation                            [ OK ]
# TEST: vti6: MTU setting on link creation                            [ OK ]
# TEST: vti6: MTU changes on link changes                             [ OK ]
# TEST: ipv4: cleanup of cached exceptions                            [ OK ]
# TEST: ipv4: cleanup of cached exceptions - nexthop objects          [ OK ]
# TEST: ipv6: cleanup of cached exceptions                            [ OK ]
# TEST: ipv6: cleanup of cached exceptions - nexthop objects          [FAIL]
#   can't delete veth device in a timely manner, PMTU dst likely leaked
# TEST: ipv4: list and flush cached exceptions                        [ OK ]
# TEST: ipv4: list and flush cached exceptions - nexthop objects      [ OK ]
# TEST: ipv6: list and flush cached exceptions                        [ OK ]
# TEST: ipv6: list and flush cached exceptions - nexthop objects      [ OK ]
# TEST: ipv4: PMTU exception w/route replace                          [ OK ]
# TEST: ipv4: PMTU exception w/route replace - nexthop objects        [ OK ]
# TEST: ipv6: PMTU exception w/route replace                          [ OK ]
# TEST: ipv6: PMTU exception w/route replace - nexthop objects        [ OK ]
ok 15 selftests: net: pmtu.sh
# selftests: net: udpgso.sh
# ipv4 cmsg
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv4 tx:1 gso:0=20
# ipv4 tx:1472 gso:0=20
# ipv4 tx:1473 gso:0 (fail)
# ipv4 tx:1472 gso:1472=20
# ipv4 tx:1473 gso:1472=20
# ipv4 tx:2944 gso:1472=20
# ipv4 tx:2945 gso:1472=20
# ipv4 tx:64768 gso:1472=20
# ipv4 tx:65507 gso:1472=20
# ipv4 tx:65508 gso:1472 (fail)
# ipv4 tx:1 gso:1=20
# ipv4 tx:2 gso:1=20
# ipv4 tx:5 gso:2=20
# ipv4 tx:36 gso:1=20
# ipv4 tx:37 gso:1 (fail)
# OK
# ipv4 setsockopt
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv4 tx:1 gso:0=20
# ipv4 tx:1472 gso:0=20
# ipv4 tx:1473 gso:0 (fail)
# ipv4 tx:1472 gso:1472=20
# ipv4 tx:1473 gso:1472=20
# ipv4 tx:2944 gso:1472=20
# ipv4 tx:2945 gso:1472=20
# ipv4 tx:64768 gso:1472=20
# ipv4 tx:65507 gso:1472=20
# ipv4 tx:65508 gso:1472 (fail)
# ipv4 tx:1 gso:1=20
# ipv4 tx:2 gso:1=20
# ipv4 tx:5 gso:2=20
# ipv4 tx:36 gso:1=20
# ipv4 tx:37 gso:1 (fail)
# OK
# ipv6 cmsg
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv6 tx:1 gso:0=20
# ipv6 tx:1452 gso:0=20
# ipv6 tx:1453 gso:0 (fail)
# ipv6 tx:1452 gso:1452=20
# ipv6 tx:1453 gso:1452=20
# ipv6 tx:2904 gso:1452=20
# ipv6 tx:2905 gso:1452=20
# ipv6 tx:65340 gso:1452=20
# ipv6 tx:65527 gso:1452=20
# ipv6 tx:65528 gso:1452 (fail)
# ipv6 tx:1 gso:1=20
# ipv6 tx:2 gso:1=20
# ipv6 tx:5 gso:2=20
# ipv6 tx:16 gso:1=20
# ipv6 tx:17 gso:1 (fail)
# OK
# ipv6 setsockopt
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv6 tx:1 gso:0=20
# ipv6 tx:1452 gso:0=20
# ipv6 tx:1453 gso:0 (fail)
# ipv6 tx:1452 gso:1452=20
# ipv6 tx:1453 gso:1452=20
# ipv6 tx:2904 gso:1452=20
# ipv6 tx:2905 gso:1452=20
# ipv6 tx:65340 gso:1452=20
# ipv6 tx:65527 gso:1452=20
# ipv6 tx:65528 gso:1452 (fail)
# ipv6 tx:1 gso:1=20
# ipv6 tx:2 gso:1=20
# ipv6 tx:5 gso:2=20
# ipv6 tx:16 gso:1=20
# ipv6 tx:17 gso:1 (fail)
# OK
# ipv4 connected
# device mtu (orig): 65536
# device mtu (test): 1600
# route mtu (test): 1500
# path mtu (read):  1500
# ipv4 tx:1 gso:0=20
# ipv4 tx:1472 gso:0=20
# ipv4 tx:1473 gso:0 (fail)
# ipv4 tx:1472 gso:1472=20
# ipv4 tx:1473 gso:1472=20
# ipv4 tx:2944 gso:1472=20
# ipv4 tx:2945 gso:1472=20
# ipv4 tx:64768 gso:1472=20
# ipv4 tx:65507 gso:1472=20
# ipv4 tx:65508 gso:1472 (fail)
# ipv4 tx:1 gso:1=20
# ipv4 tx:2 gso:1=20
# ipv4 tx:5 gso:2=20
# ipv4 tx:36 gso:1=20
# ipv4 tx:37 gso:1 (fail)
# OK
# ipv4 msg_more
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv4 tx:1 gso:0=20
# ipv4 tx:1472 gso:0=20
# ipv4 tx:1473 gso:0 (fail)
# ipv4 tx:1472 gso:1472=20
# ipv4 tx:1473 gso:1472=20
# ipv4 tx:2944 gso:1472=20
# ipv4 tx:2945 gso:1472=20
# ipv4 tx:64768 gso:1472=20
# ipv4 tx:65507 gso:1472=20
# ipv4 tx:65508 gso:1472 (fail)
# ipv4 tx:1 gso:1=20
# ipv4 tx:2 gso:1=20
# ipv4 tx:5 gso:2=20
# ipv4 tx:36 gso:1=20
# ipv4 tx:37 gso:1 (fail)
# OK
# ipv6 msg_more
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv6 tx:1 gso:0=20
# ipv6 tx:1452 gso:0=20
# ipv6 tx:1453 gso:0 (fail)
# ipv6 tx:1452 gso:1452=20
# ipv6 tx:1453 gso:1452=20
# ipv6 tx:2904 gso:1452=20
# ipv6 tx:2905 gso:1452=20
# ipv6 tx:65340 gso:1452=20
# ipv6 tx:65527 gso:1452=20
# ipv6 tx:65528 gso:1452 (fail)
# ipv6 tx:1 gso:1=20
# ipv6 tx:2 gso:1=20
# ipv6 tx:5 gso:2=20
# ipv6 tx:16 gso:1=20
# ipv6 tx:17 gso:1 (fail)
# OK
ok 16 selftests: net: udpgso.sh
# selftests: net: ip_defrag.sh
# ipv4 defrag
# PASS
# seed =3D 1622323436
# ipv4 defrag with overlaps
# PASS
# seed =3D 1622323436
# ipv6 defrag
# PASS
# seed =3D 1622323441
# ipv6 defrag with overlaps
# PASS
# seed =3D 1622323441
# ipv6 nf_conntrack defrag
# PASS
# seed =3D 1622323445
# ipv6 nf_conntrack defrag with overlaps
# PASS
# seed =3D 1622323446
# all tests done
ok 17 selftests: net: ip_defrag.sh
# selftests: net: udpgso_bench.sh
# ipv4
# tcp
# tcp tx:   1220 MB/s    20698 calls/s  20698 msg/s
# tcp rx:   1220 MB/s    20669 calls/s
# tcp tx:   1215 MB/s    20612 calls/s  20612 msg/s
# tcp rx:   1216 MB/s    20616 calls/s
# tcp tx:   1179 MB/s    20012 calls/s  20012 msg/s
# tcp zerocopy
# tcp tx:    893 MB/s    15153 calls/s  15153 msg/s
# tcp rx:    893 MB/s    15072 calls/s
# tcp tx:   1370 MB/s    23245 calls/s  23245 msg/s
# tcp rx:   1372 MB/s    23268 calls/s
# tcp tx:   1272 MB/s    21588 calls/s  21588 msg/s
# udp
# udp rx:     64 MB/s    45877 calls/s
# udp tx:     64 MB/s    46116 calls/s   1098 msg/s
# udp rx:     63 MB/s    45066 calls/s
# udp tx:     63 MB/s    44982 calls/s   1071 msg/s
# udp rx:     59 MB/s    42340 calls/s
# udp tx:     59 MB/s    42336 calls/s   1008 msg/s
# udp gso
# udp rx:    388 MB/s   276980 calls/s
# udp tx:    391 MB/s     6634 calls/s   6634 msg/s
# udp rx:    404 MB/s   288082 calls/s
# udp tx:    403 MB/s     6852 calls/s   6852 msg/s
# udp rx:    377 MB/s   269224 calls/s
# udp tx:    377 MB/s     6401 calls/s   6401 msg/s
# udp gso zerocopy
# udp rx:    284 MB/s   203000 calls/s
# udp tx:    285 MB/s     4849 calls/s   4849 msg/s
# udp rx:    428 MB/s   305460 calls/s
# udp tx:    428 MB/s     7276 calls/s   7276 msg/s
# udp rx:    327 MB/s   233070 calls/s
# udp tx:    327 MB/s     5548 calls/s   5548 msg/s
# udp gso timestamp
# udp rx:    398 MB/s   283668 calls/s
# udp tx:    399 MB/s     6772 calls/s   6772 msg/s
# udp rx:    450 MB/s   321220 calls/s
# udp tx:    452 MB/s     7676 calls/s   7676 msg/s
# udp rx:    341 MB/s   243474 calls/s
# udp tx:    340 MB/s     5770 calls/s   5770 msg/s
# udp gso zerocopy audit
# udp rx:    259 MB/s   185056 calls/s
# udp tx:    261 MB/s     4429 calls/s   4429 msg/s
# udp rx:    264 MB/s   188288 calls/s
# udp tx:    266 MB/s     4527 calls/s   4527 msg/s
# udp rx:    307 MB/s   218789 calls/s
# udp tx:    308 MB/s     5240 calls/s   5240 msg/s
# Summary over 3.000 seconds...
# sum udp tx:    285 MB/s      14196 calls (4732/s)      14196 msgs (4732/s)
# Zerocopy acks:               14196
# udp gso timestamp audit
# udp rx:    277 MB/s   197793 calls/s
# udp tx:    278 MB/s     4729 calls/s   4729 msg/s
# udp rx:    303 MB/s   216282 calls/s
# udp tx:    304 MB/s     5161 calls/s   5161 msg/s
# udp rx:    301 MB/s   214990 calls/s
# udp tx:    300 MB/s     5102 calls/s   5102 msg/s
# Summary over 3.000 seconds...
# sum udp tx:    301 MB/s      14992 calls (4997/s)      14992 msgs (4997/s)
# Tx Timestamps:               14992 received                 0 errors
# udp gso zerocopy timestamp audit
# udp rx:    257 MB/s   183476 calls/s
# udp tx:    258 MB/s     4386 calls/s   4386 msg/s
# udp rx:    255 MB/s   181947 calls/s
# udp tx:    255 MB/s     4331 calls/s   4331 msg/s
# udp rx:    252 MB/s   180012 calls/s
# udp tx:    252 MB/s     4283 calls/s   4283 msg/s
# Summary over 3.000 seconds...
# sum udp tx:    261 MB/s      13000 calls (4333/s)      13000 msgs (4333/s)
# Tx Timestamps:               13000 received                 0 errors
# Zerocopy acks:               13000
# ipv6
# tcp
# tcp tx:   1233 MB/s    20913 calls/s  20913 msg/s
# tcp rx:   1234 MB/s    20925 calls/s
# tcp tx:   1359 MB/s    23060 calls/s  23060 msg/s
# tcp rx:   1361 MB/s    23093 calls/s
# tcp tx:   1330 MB/s    22559 calls/s  22559 msg/s
# tcp zerocopy
# tcp tx:    910 MB/s    15446 calls/s  15446 msg/s
# tcp rx:    911 MB/s    15150 calls/s
# tcp tx:   1143 MB/s    19388 calls/s  19388 msg/s
# tcp rx:   1143 MB/s    19162 calls/s
# tcp tx:    815 MB/s    13829 calls/s  13829 msg/s
# udp
# udp rx:     44 MB/s    32563 calls/s
# udp tx:     44 MB/s    32809 calls/s    763 msg/s
# udp rx:     54 MB/s    40105 calls/s
# udp tx:     55 MB/s    40119 calls/s    933 msg/s
# udp rx:     54 MB/s    39821 calls/s
# udp tx:     54 MB/s    39775 calls/s    925 msg/s
# udp gso
# udp rx:    273 MB/s   199424 calls/s
# udp tx:    275 MB/s     4678 calls/s   4678 msg/s
# udp rx:    288 MB/s   210346 calls/s
# udp tx:    293 MB/s     4975 calls/s   4975 msg/s
# udp rx:    272 MB/s   199049 calls/s
# udp tx:    273 MB/s     4634 calls/s   4634 msg/s
# udp gso zerocopy
# udp rx:    264 MB/s   192612 calls/s
# udp tx:    266 MB/s     4514 calls/s   4514 msg/s
# udp rx:    267 MB/s   194967 calls/s
# udp tx:    266 MB/s     4526 calls/s   4526 msg/s
# udp rx:    265 MB/s   193406 calls/s
# udp tx:    264 MB/s     4491 calls/s   4491 msg/s
# udp gso timestamp
# udp rx:    260 MB/s   190014 calls/s
# udp tx:    260 MB/s     4425 calls/s   4425 msg/s
# udp rx:    282 MB/s   205732 calls/s
# udp tx:    282 MB/s     4783 calls/s   4783 msg/s
# udp tx:    268 MB/s     4547 calls/s   4547 msg/s
# udp gso zerocopy audit
# udp rx:    293 MB/s   214016 calls/s
# udp tx:    295 MB/s     5004 calls/s   5004 msg/s
# udp rx:    305 MB/s   223125 calls/s
# udp tx:    306 MB/s     5192 calls/s   5192 msg/s
# udp rx:    290 MB/s   211600 calls/s
# udp tx:    292 MB/s     4966 calls/s   4966 msg/s
# Summary over 3.000 seconds...
# sum udp tx:    305 MB/s      15162 calls (5054/s)      15162 msgs (5054/s)
# Zerocopy acks:               15162
# udp gso timestamp audit
# udp rx:    273 MB/s   199265 calls/s
# udp tx:    275 MB/s     4676 calls/s   4676 msg/s
# udp rx:    302 MB/s   220810 calls/s
# udp tx:    302 MB/s     5131 calls/s   5131 msg/s
# udp rx:    308 MB/s   225105 calls/s
# udp tx:    308 MB/s     5233 calls/s   5233 msg/s
# Summary over 3.000 seconds...
# sum udp tx:    302 MB/s      15040 calls (5013/s)      15040 msgs (5013/s)
# Tx Timestamps:               15040 received                 0 errors
# udp gso zerocopy timestamp audit
# udp rx:    288 MB/s   210356 calls/s
# udp tx:    290 MB/s     4920 calls/s   4920 msg/s
# udp rx:    245 MB/s   178751 calls/s
# udp tx:    244 MB/s     4146 calls/s   4146 msg/s
# udp rx:    244 MB/s   178493 calls/s
# udp tx:    244 MB/s     4148 calls/s   4148 msg/s
# Summary over 3.000 seconds...
# sum udp tx:    265 MB/s      13214 calls (4404/s)      13214 msgs (4404/s)
# Tx Timestamps:               13214 received                 0 errors
# Zerocopy acks:               13214
# udpgso_bench.sh: PASS=3D18 SKIP=3D0 FAIL=3D0
# udpgso_bench.sh: =1B[0;92mPASS=1B[0m
ok 18 selftests: net: udpgso_bench.sh
# selftests: net: fib_rule_tests.sh
#=20
# ######################################################################
# TEST SECTION: IPv4 fib rule
# ######################################################################
#=20
#     TEST: rule4 check: oif dummy0                             [ OK ]
#=20
#     TEST: rule4 del by pref: oif dummy0                       [ OK ]
# net.ipv4.ip_forward =3D 1
# net.ipv4.conf.dummy0.rp_filter =3D 0
#=20
#     TEST: rule4 check: from 192.51.100.3 iif dummy0           [ OK ]
#=20
#     TEST: rule4 del by pref: from 192.51.100.3 iif dummy0     [ OK ]
# net.ipv4.ip_forward =3D 0
#=20
#     TEST: rule4 check: tos 0x10                               [ OK ]
#=20
#     TEST: rule4 del by pref: tos 0x10                         [ OK ]
#=20
#     TEST: rule4 check: fwmark 0x64                            [ OK ]
#=20
#     TEST: rule4 del by pref: fwmark 0x64                      [ OK ]
#=20
#     TEST: rule4 check: uidrange 100-100                       [ OK ]
#=20
#     TEST: rule4 del by pref: uidrange 100-100                 [ OK ]
#=20
#     TEST: rule4 check: sport 666 dport 777                    [ OK ]
#=20
#     TEST: rule4 del by pref: sport 666 dport 777              [ OK ]
#=20
#     TEST: rule4 check: ipproto tcp                            [ OK ]
#=20
#     TEST: rule4 del by pref: ipproto tcp                      [ OK ]
#=20
#     TEST: rule4 check: ipproto icmp                           [ OK ]
#=20
#     TEST: rule4 del by pref: ipproto icmp                     [ OK ]
#=20
# ######################################################################
# TEST SECTION: IPv6 fib rule
# ######################################################################
#=20
#     TEST: rule6 check: oif dummy0                             [ OK ]
#=20
#     TEST: rule6 del by pref: oif dummy0                       [ OK ]
#=20
#     TEST: rule6 check: from 2001:db8:1::3 iif dummy0          [ OK ]
#=20
#     TEST: rule6 del by pref: from 2001:db8:1::3 iif dummy0    [ OK ]
#=20
#     TEST: rule6 check: tos 0x10                               [ OK ]
#=20
#     TEST: rule6 del by pref: tos 0x10                         [ OK ]
#=20
#     TEST: rule6 check: fwmark 0x64                            [ OK ]
#=20
#     TEST: rule6 del by pref: fwmark 0x64                      [ OK ]
#=20
#     TEST: rule6 check: uidrange 100-100                       [ OK ]
#=20
#     TEST: rule6 del by pref: uidrange 100-100                 [ OK ]
#=20
#     TEST: rule6 check: sport 666 dport 777                    [ OK ]
#=20
#     TEST: rule6 del by pref: sport 666 dport 777              [ OK ]
#=20
#     TEST: rule6 check: ipproto tcp                            [ OK ]
#=20
#     TEST: rule6 del by pref: ipproto tcp                      [ OK ]
#=20
#     TEST: rule6 check: ipproto ipv6-icmp                      [ OK ]
#=20
#     TEST: rule6 del by pref: ipproto ipv6-icmp                [ OK ]
#=20
# Tests passed:  32
# Tests failed:   0
ok 19 selftests: net: fib_rule_tests.sh
# selftests: net: msg_zerocopy.sh
# ipv4 tcp -t 1
# tx=3D28334 (1768 MB) txc=3D0 zc=3Dn
# rx=3D14168 (1768 MB)
# ipv4 tcp -z -t 1
# tx=3D30436 (1899 MB) txc=3D30436 zc=3Dn
# rx=3D15219 (1899 MB)
# ok
# ipv6 tcp -t 1
# tx=3D20235 (1262 MB) txc=3D0 zc=3Dn
# rx=3D10119 (1262 MB)
# ipv6 tcp -z -t 1
# tx=3D25757 (1607 MB) txc=3D25757 zc=3Dn
# rx=3D12879 (1607 MB)
# ok
# ipv4 udp -t 1
# tx=3D20413 (1273 MB) txc=3D0 zc=3Dn
# rx=3D20406 (1273 MB)
# ipv4 udp -z -t 1
# tx=3D26721 (1667 MB) txc=3D26721 zc=3Dn
# rx=3D26721 (1667 MB)
# ok
# ipv6 udp -t 1
# tx=3D24706 (1541 MB) txc=3D0 zc=3Dn
# rx=3D24706 (1541 MB)
# ipv6 udp -z -t 1
# tx=3D25760 (1607 MB) txc=3D25760 zc=3Dn
# rx=3D25760 (1607 MB)
# ok
# OK. All tests passed
ok 20 selftests: net: msg_zerocopy.sh
# selftests: net: psock_snd.sh
# dgram
# tx: 128
# rx: 142
# rx: 100
# OK
#=20
# dgram bind
# tx: 128
# rx: 142
# rx: 100
# OK
#=20
# raw
# tx: 142
# rx: 142
# rx: 100
# OK
#=20
# raw bind
# tx: 142
# rx: 142
# rx: 100
# OK
#=20
# raw qdisc bypass
# tx: 142
# rx: 142
# rx: 100
# OK
#=20
# raw vlan
# tx: 146
# rx: 100
# OK
#=20
# raw vnet hdr
# tx: 152
# rx: 142
# rx: 100
# OK
#=20
# raw csum_off
# tx: 152
# rx: 142
# rx: 100
# OK
#=20
# raw csum_off with bad offset (expected to fail)
# ./psock_snd: write: Invalid argument
# raw min size
# tx: 42
# rx: 0
# OK
#=20
# raw mtu size
# tx: 1514
# rx: 1472
# OK
#=20
# raw mtu size + 1 (expected to fail)
# ./psock_snd: write: Message too long
# raw vlan mtu size + 1 (expected to fail)
# ./psock_snd: write: Message too long
# dgram mtu size
# tx: 1500
# rx: 1472
# OK
#=20
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
#=20
# raw gso min size - 1 (expected to fail)
# tx: 1524
# rx: 1472
# OK
#=20
not ok 21 selftests: net: psock_snd.sh # exit=3D1
# selftests: net: udpgro_bench.sh
# Missing xdp_dummy helper. Build bpf selftest first
not ok 22 selftests: net: udpgro_bench.sh # exit=3D255
# selftests: net: udpgro.sh
# Missing xdp_dummy helper. Build bpf selftest first
not ok 23 selftests: net: udpgro.sh # exit=3D255
# selftests: net: test_vxlan_under_vrf.sh
# Checking HV connectivity                                           [ OK ]
# Check VM connectivity through VXLAN (underlay in the default VRF)  [ OK ]
# Check VM connectivity through VXLAN (underlay in a VRF)            [FAIL]
not ok 24 selftests: net: test_vxlan_under_vrf.sh # exit=3D1
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
#=20
# SO_TXTIME ipv4 clock monotonic
# payload:a delay:225 expected:0 (us)
#=20
# SO_TXTIME ipv6 clock monotonic
# payload:a delay:184 expected:0 (us)
#=20
# SO_TXTIME ipv6 clock monotonic
# payload:a delay:10059 expected:10000 (us)
#=20
# SO_TXTIME ipv4 clock monotonic
# payload:a delay:10182 expected:10000 (us)
# payload:b delay:20094 expected:20000 (us)
#=20
# SO_TXTIME ipv6 clock monotonic
# payload:b delay:20191 expected:20000 (us)
# payload:a delay:20302 expected:20000 (us)
#=20
# SO_TXTIME ipv4 clock tai
# send: pkt a at -1622323534411ms dropped: invalid txtime
# ./so_txtime: recv: timeout: Resource temporarily unavailable
#=20
# SO_TXTIME ipv6 clock tai
# send: pkt a at 0ms dropped: invalid txtime
# ./so_txtime: recv: timeout: Resource temporarily unavailable
#=20
# SO_TXTIME ipv6 clock tai
# payload:a delay:9822 expected:10000 (us)
#=20
# SO_TXTIME ipv4 clock tai
# payload:a delay:9843 expected:10000 (us)
# payload:b delay:19707 expected:20000 (us)
#=20
# SO_TXTIME ipv6 clock tai
# payload:b delay:9834 expected:10000 (us)
# payload:a delay:19700 expected:20000 (us)
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
# recv with label 326205
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
#=20
# #########################################################################=
##
# IPv4 ping
# #########################################################################=
##
#=20
#=20
# #################################################################
# No VRF
#=20
# SYSCTL: net.ipv4.raw_l3mdev_accept=3D0
#=20
# TEST: ping out - ns-B IP                                                 =
     [ OK ]
# TEST: ping out, device bind - ns-B IP                                    =
     [ OK ]
# TEST: ping out, address bind - ns-B IP                                   =
     [ OK ]
# TEST: ping out - ns-B loopback IP                                        =
     [ OK ]
# TEST: ping out, device bind - ns-B loopback IP                           =
     [ OK ]
# TEST: ping out, address bind - ns-B loopback IP                          =
     [ OK ]
# TEST: ping in - ns-A IP                                                  =
     [ OK ]
# TEST: ping in - ns-A loopback IP                                         =
     [ OK ]
# TEST: ping local - ns-A IP                                               =
     [ OK ]
# TEST: ping local - ns-A loopback IP                                      =
     [ OK ]
# TEST: ping local - loopback                                              =
     [ OK ]
# TEST: ping local, device bind - ns-A IP                                  =
     [ OK ]
# TEST: ping local, device bind - ns-A loopback IP                         =
     [ OK ]
# TEST: ping local, device bind - loopback                                 =
     [ OK ]
# TEST: ping out, blocked by rule - ns-B loopback IP                       =
     [ OK ]
# TEST: ping in, blocked by rule - ns-A loopback IP                        =
     [ OK ]
# TEST: ping out, blocked by route - ns-B loopback IP                      =
     [ OK ]
# TEST: ping in, blocked by route - ns-A loopback IP                       =
     [ OK ]
# TEST: ping out, unreachable default route - ns-B loopback IP             =
     [ OK ]
# SYSCTL: net.ipv4.raw_l3mdev_accept=3D1
#=20
# TEST: ping out - ns-B IP                                                 =
     [ OK ]
# TEST: ping out, device bind - ns-B IP                                    =
     [ OK ]
# TEST: ping out, address bind - ns-B IP                                   =
     [ OK ]
# TEST: ping out - ns-B loopback IP                                        =
     [ OK ]
# TEST: ping out, device bind - ns-B loopback IP                           =
     [ OK ]
# TEST: ping out, address bind - ns-B loopback IP                          =
     [ OK ]
# TEST: ping in - ns-A IP                                                  =
     [ OK ]
# TEST: ping in - ns-A loopback IP                                         =
     [ OK ]
# TEST: ping local - ns-A IP                                               =
     [ OK ]
# TEST: ping local - ns-A loopback IP                                      =
     [ OK ]
# TEST: ping local - loopback                                              =
     [ OK ]
# TEST: ping local, device bind - ns-A IP                                  =
     [ OK ]
# TEST: ping local, device bind - ns-A loopback IP                         =
     [ OK ]
# TEST: ping local, device bind - loopback                                 =
     [ OK ]
# TEST: ping out, blocked by rule - ns-B loopback IP                       =
     [ OK ]
# TEST: ping in, blocked by rule - ns-A loopback IP                        =
     [ OK ]
# TEST: ping out, blocked by route - ns-B loopback IP                      =
     [ OK ]
# TEST: ping in, blocked by route - ns-A loopback IP                       =
     [ OK ]
# TEST: ping out, unreachable default route - ns-B loopback IP             =
     [ OK ]
#=20
# #################################################################
# With VRF
#=20
# SYSCTL: net.ipv4.raw_l3mdev_accept=3D1
#=20
# TEST: ping out, VRF bind - ns-B IP                                       =
     [ OK ]
# TEST: ping out, device bind - ns-B IP                                    =
     [ OK ]
# TEST: ping out, vrf device + dev address bind - ns-B IP                  =
     [ OK ]
# TEST: ping out, vrf device + vrf address bind - ns-B IP                  =
     [ OK ]
# TEST: ping out, VRF bind - ns-B loopback IP                              =
     [ OK ]
# TEST: ping out, device bind - ns-B loopback IP                           =
     [ OK ]
# TEST: ping out, vrf device + dev address bind - ns-B loopback IP         =
     [ OK ]
# TEST: ping out, vrf device + vrf address bind - ns-B loopback IP         =
     [ OK ]
# TEST: ping in - ns-A IP                                                  =
     [ OK ]
# TEST: ping in - VRF IP                                                   =
     [ OK ]
# TEST: ping local, VRF bind - ns-A IP                                     =
     [ OK ]
# TEST: ping local, VRF bind - VRF IP                                      =
     [ OK ]
# TEST: ping local, VRF bind - loopback                                    =
     [ OK ]
# TEST: ping local, device bind - ns-A IP                                  =
     [ OK ]
# TEST: ping local, device bind - VRF IP                                   =
     [ OK ]
# TEST: ping local, device bind - loopback                                 =
     [ OK ]
# TEST: ping out, vrf bind, blocked by rule - ns-B loopback IP             =
     [ OK ]
# TEST: ping out, device bind, blocked by rule - ns-B loopback IP          =
     [ OK ]
# TEST: ping in, blocked by rule - ns-A loopback IP                        =
     [ OK ]
# TEST: ping out, vrf bind, unreachable route - ns-B loopback IP           =
     [ OK ]
# TEST: ping out, device bind, unreachable route - ns-B loopback IP        =
     [ OK ]
# TEST: ping in, unreachable route - ns-A loopback IP                      =
     [ OK ]
#=20
# #########################################################################=
##
# IPv4/TCP
# #########################################################################=
##
#=20
#=20
# #################################################################
# No VRF
#=20
#=20
# #################################################################
# tcp_l3mdev_accept disabled
#=20
# SYSCTL: net.ipv4.tcp_l3mdev_accept=3D0
#=20
# TEST: Global server - ns-A IP                                            =
     [ OK ]
# TEST: Global server - ns-A loopback IP                                   =
     [ OK ]
# TEST: Device server - ns-A IP                                            =
     [ OK ]
# TEST: No server - ns-A IP                                                =
     [ OK ]
# TEST: No server - ns-A loopback IP                                       =
     [ OK ]
# TEST: Client - ns-B IP                                                   =
     [ OK ]
# TEST: Client, device bind - ns-B IP                                      =
     [ OK ]
# TEST: No server, unbound client - ns-B IP                                =
     [ OK ]
# TEST: No server, device client - ns-B IP                                 =
     [ OK ]
# TEST: Client - ns-B loopback IP                                          =
     [ OK ]
# TEST: Client, device bind - ns-B loopback IP                             =
     [ OK ]
# TEST: No server, unbound client - ns-B loopback IP                       =
     [ OK ]
# TEST: No server, device client - ns-B loopback IP                        =
     [ OK ]
# TEST: Global server, local connection - ns-A IP                          =
     [ OK ]
# TEST: Global server, local connection - ns-A loopback IP                 =
     [ OK ]
# TEST: Global server, local connection - loopback                         =
     [ OK ]
# TEST: Device server, unbound client, local connection - ns-A IP          =
     [ OK ]
# TEST: Device server, unbound client, local connection - ns-A loopback IP =
     [ OK ]
# TEST: Device server, unbound client, local connection - loopback         =
     [ OK ]
# TEST: Global server, device client, local connection - ns-A IP           =
     [ OK ]
# TEST: Global server, device client, local connection - ns-A loopback IP  =
     [ OK ]
# TEST: Global server, device client, local connection - loopback          =
     [ OK ]
# TEST: Device server, device client, local connection - ns-A IP           =
     [ OK ]
# TEST: No server, device client, local conn - ns-A IP                     =
     [ OK ]
# TEST: MD5: Single address config                                         =
     [ OK ]
# TEST: MD5: Server no config, client uses password                        =
     [ OK ]
# TEST: MD5: Client uses wrong password                                    =
     [ OK ]
# TEST: MD5: Client address does not match address configured with password=
     [ OK ]
# TEST: MD5: Prefix config                                                 =
     [ OK ]
# TEST: MD5: Prefix config, client uses wrong password                     =
     [ OK ]
# TEST: MD5: Prefix config, client address not in configured prefix        =
     [ OK ]
#=20
# #################################################################
# tcp_l3mdev_accept enabled
#=20
# SYSCTL: net.ipv4.tcp_l3mdev_accept=3D1
#=20
# TEST: Global server - ns-A IP                                            =
     [ OK ]
# TEST: Global server - ns-A loopback IP                                   =
     [ OK ]
# TEST: Device server - ns-A IP                                            =
     [ OK ]
# TEST: No server - ns-A IP                                                =
     [ OK ]
# TEST: No server - ns-A loopback IP                                       =
     [ OK ]
# TEST: Client - ns-B IP                                                   =
     [ OK ]
# TEST: Client, device bind - ns-B IP                                      =
     [ OK ]
# TEST: No server, unbound client - ns-B IP                                =
     [ OK ]
# TEST: No server, device client - ns-B IP                                 =
     [ OK ]
# TEST: Client - ns-B loopback IP                                          =
     [ OK ]
# TEST: Client, device bind - ns-B loopback IP                             =
     [ OK ]
# TEST: No server, unbound client - ns-B loopback IP                       =
     [ OK ]
# TEST: No server, device client - ns-B loopback IP                        =
     [ OK ]
# TEST: Global server, local connection - ns-A IP                          =
     [ OK ]
# TEST: Global server, local connection - ns-A loopback IP                 =
     [ OK ]
#
not ok 30 selftests: net: fcnal-test.sh # TIMEOUT 300 seconds
# selftests: net: traceroute.sh
# SKIP: Could not run IPV6 test without traceroute6
# SKIP: Could not run IPV4 test without traceroute
#=20
# Tests passed:   0
# Tests failed:   0
ok 31 selftests: net: traceroute.sh
# selftests: net: fin_ack_lat.sh
# server port: 49849
# test done
ok 32 selftests: net: fin_ack_lat.sh
# selftests: net: fib_nexthop_multiprefix.sh
# TEST: IPv4: host 0 to host 1, mtu 1300                              [ OK ]
# TEST: IPv6: host 0 to host 1, mtu 1300                              [FAIL]
#=20
# TEST: IPv4: host 0 to host 2, mtu 1350                              [ OK ]
# TEST: IPv6: host 0 to host 2, mtu 1350                              [FAIL]
#=20
# TEST: IPv4: host 0 to host 3, mtu 1400                              [ OK ]
# TEST: IPv6: host 0 to host 3, mtu 1400                              [FAIL]
#=20
# TEST: IPv4: host 0 to host 1, mtu 1300                              [ OK ]
# TEST: IPv6: host 0 to host 1, mtu 1300                              [FAIL]
#=20
# TEST: IPv4: host 0 to host 2, mtu 1350                              [ OK ]
# TEST: IPv6: host 0 to host 2, mtu 1350                              [FAIL]
#=20
# TEST: IPv4: host 0 to host 3, mtu 1400                              [ OK ]
# TEST: IPv6: host 0 to host 3, mtu 1400                              [FAIL]
ok 33 selftests: net: fib_nexthop_multiprefix.sh
# selftests: net: fib_nexthops.sh
#=20
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
# TEST: Large scale nexthop flushing                                  [ OK ]
#=20
# Basic resilient nexthop group functional tests
# ----------------------------------------------
# TEST: Add a nexthop group with default parameters                   [ OK ]
# TEST: Get a nexthop group with default parameters                   [ OK ]
# TEST: Get a nexthop group with non-default parameters               [ OK ]
# TEST: Add a nexthop group with 0 buckets                            [ OK ]
# TEST: Replace nexthop group parameters                              [ OK ]
# TEST: Get a nexthop group after replacing parameters                [ OK ]
# TEST: Replace idle timer                                            [ OK ]
# TEST: Get a nexthop group after replacing idle timer                [ OK ]
# TEST: Replace unbalanced timer                                      [ OK ]
# TEST: Get a nexthop group after replacing unbalanced timer          [ OK ]
# TEST: Replace with no parameters                                    [ OK ]
# TEST: Get a nexthop group after replacing no parameters             [ OK ]
# TEST: Replace nexthop group type - implicit                         [ OK ]
# TEST: Replace nexthop group type - explicit                         [ OK ]
# TEST: Replace number of nexthop buckets                             [ OK ]
# TEST: Get a nexthop group after replacing with invalid parameters   [ OK ]
# TEST: Dump all nexthop buckets                                      [ OK ]
# TEST: Dump all nexthop buckets in a group                           [ OK ]
# TEST: All nexthop buckets report a positive near-zero idle time     [ OK ]
# TEST: Dump all nexthop buckets with a specific nexthop device       [ OK ]
# TEST: Dump all nexthop buckets with a specific nexthop identifier   [ OK ]
# TEST: Dump all nexthop buckets in a non-existent group              [ OK ]
# TEST: Dump all nexthop buckets in a non-resilient group             [ OK ]
# TEST: Dump all nexthop buckets using a non-existent device          [ OK ]
# TEST: Dump all nexthop buckets with invalid 'groups' keyword        [ OK ]
# TEST: Dump all nexthop buckets with invalid 'fdb' keyword           [ OK ]
# TEST: Get a valid nexthop bucket                                    [ OK ]
# TEST: Get a nexthop bucket with valid group, but invalid index      [ OK ]
# TEST: Get a nexthop bucket from a non-resilient group               [ OK ]
# TEST: Get a nexthop bucket from a non-existent group                [ OK ]
# TEST: Initial bucket allocation                                     [ OK ]
# TEST: Bucket allocation after replace                               [ OK ]
# TEST: Buckets migrated after idle timer change                      [ OK ]
#=20
# IPv4 functional
# ----------------------
# TEST: Create nexthop with id, gw, dev                               [ OK ]
# TEST: Get nexthop by id                                             [ OK ]
# TEST: Delete nexthop by id                                          [ OK ]
# TEST: Create nexthop - gw only                                      [ OK ]
# TEST: Create nexthop - invalid gw+dev combination                   [ OK ]
# TEST: Create nexthop - gw+dev and onlink                            [ OK ]
# TEST: Nexthops removed on admin down                                [ OK ]
#=20
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
#=20
# IPv4 resilient groups functional
# --------------------------------
# TEST: Nexthop group updated when entry is deleted                   [ OK ]
# TEST: Nexthop buckets updated when entry is deleted                 [ OK ]
# TEST: Nexthop group updated after replace                           [ OK ]
# TEST: Nexthop buckets updated after replace                         [ OK ]
# TEST: Nexthop group updated when entry is deleted - nECMP           [ OK ]
# TEST: Nexthop buckets updated when entry is deleted - nECMP         [ OK ]
# TEST: Nexthop group updated after replace - nECMP                   [ OK ]
# TEST: Nexthop buckets updated after replace - nECMP                 [ OK ]
# TEST: IPv6 nexthop with IPv4 route                                  [ OK ]
# TEST: IPv6 nexthop with IPv4 route                                  [ OK ]
# TEST: IPv4 route with IPv6 gateway                                  [ OK ]
# TEST: IPv4 route with invalid IPv6 gateway                          [ OK ]
#=20
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
#=20
# IPv4 large groups (x32)
# ---------------------
# TEST: Dump large (x32) ecmp groups                                  [ OK ]
#=20
# IPv4 large resilient group (128k buckets)
# -----------------------------------------
# TEST: Dump large (x131072) nexthop buckets                          [ OK ]
#=20
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
#=20
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
#=20
# IPv4 runtime torture
# --------------------
# SKIP: Could not run test; need mausezahn tool
#=20
# IPv4 runtime resilient nexthop group torture
# --------------------------------------------
# SKIP: Could not run test; need mausezahn tool
#=20
# IPv6
# ----------------------
# TEST: Create nexthop with id, gw, dev                               [ OK ]
# TEST: Get nexthop by id                                             [ OK ]
# TEST: Delete nexthop by id                                          [ OK ]
# TEST: Create nexthop - gw only                                      [ OK ]
# TEST: Create nexthop - invalid gw+dev combination                   [ OK ]
# TEST: Create nexthop - gw+dev and onlink                            [ OK ]
# TEST: Nexthops removed on admin down                                [ OK ]
#=20
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
#=20
# IPv6 resilient groups functional
# --------------------------------
# TEST: Nexthop group updated when entry is deleted                   [ OK ]
# TEST: Nexthop buckets updated when entry is deleted                 [ OK ]
# TEST: Nexthop group updated after replace                           [ OK ]
# TEST: Nexthop buckets updated after replace                         [ OK ]
# TEST: Nexthop group updated when entry is deleted - nECMP           [ OK ]
# TEST: Nexthop buckets updated when entry is deleted - nECMP         [ OK ]
# TEST: Nexthop group updated after replace - nECMP                   [ OK ]
# TEST: Nexthop buckets updated after replace - nECMP                 [ OK ]
#=20
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
#=20
# IPv6 large groups (x32)
# ---------------------
# TEST: Dump large (x32) ecmp groups                                  [ OK ]
#=20
# IPv6 large resilient group (128k buckets)
# -----------------------------------------
# TEST: Dump large (x131072) nexthop buckets                          [ OK ]
#=20
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
#=20
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
#=20
# IPv6 runtime torture
# --------------------
# SKIP: Could not run test; need mausezahn tool
#=20
# IPv6 runtime resilient nexthop group torture
# --------------------------------------------
# SKIP: Could not run test; need mausezahn tool
#=20
# Tests passed: 215
# Tests failed:   0
ok 34 selftests: net: fib_nexthops.sh
# selftests: net: altnames.sh
# SKIP: mausezahn not installed
not ok 35 selftests: net: altnames.sh # exit=3D1
# selftests: net: icmp_redirect.sh
#=20
# #########################################################################=
##
# Legacy routing
# #########################################################################=
##
#=20
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
#=20
# #########################################################################=
##
# Legacy routing with VRF
# #########################################################################=
##
#=20
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
#=20
# #########################################################################=
##
# Routing with nexthop objects
# #########################################################################=
##
#=20
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
#=20
# #########################################################################=
##
# Routing with nexthop objects and VRF
# #########################################################################=
##
#=20
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
#=20
# Tests passed:  28
# Tests failed:  12
not ok 36 selftests: net: icmp_redirect.sh # exit=3D1
# selftests: net: ip6_gre_headroom.sh
# TEST: ip6gretap headroom                                            [PASS]
# TEST: ip6erspan headroom                                            [PASS]
ok 37 selftests: net: ip6_gre_headroom.sh
# selftests: net: route_localnet.sh
# run arp_announce test
# net.ipv4.conf.veth0.route_localnet =3D 1
# net.ipv4.conf.veth1.route_localnet =3D 1
# net.ipv4.conf.veth0.arp_announce =3D 2
# net.ipv4.conf.veth1.arp_announce =3D 2
# PING 127.25.3.14 (127.25.3.14) from 127.25.3.4 veth0: 56(84) bytes of dat=
a.
# 64 bytes from 127.25.3.14: icmp_seq=3D1 ttl=3D64 time=3D0.091 ms
# 64 bytes from 127.25.3.14: icmp_seq=3D2 ttl=3D64 time=3D0.047 ms
# 64 bytes from 127.25.3.14: icmp_seq=3D3 ttl=3D64 time=3D0.064 ms
# 64 bytes from 127.25.3.14: icmp_seq=3D4 ttl=3D64 time=3D0.049 ms
# 64 bytes from 127.25.3.14: icmp_seq=3D5 ttl=3D64 time=3D0.063 ms
#=20
# --- 127.25.3.14 ping statistics ---
# 5 packets transmitted, 5 received, 0% packet loss, time 137ms
# rtt min/avg/max/mdev =3D 0.047/0.062/0.091/0.018 ms
# ok
# run arp_ignore test
# net.ipv4.conf.veth0.route_localnet =3D 1
# net.ipv4.conf.veth1.route_localnet =3D 1
# net.ipv4.conf.veth0.arp_ignore =3D 3
# net.ipv4.conf.veth1.arp_ignore =3D 3
# PING 127.25.3.14 (127.25.3.14) from 127.25.3.4 veth0: 56(84) bytes of dat=
a.
# 64 bytes from 127.25.3.14: icmp_seq=3D1 ttl=3D64 time=3D0.090 ms
# 64 bytes from 127.25.3.14: icmp_seq=3D2 ttl=3D64 time=3D0.049 ms
# 64 bytes from 127.25.3.14: icmp_seq=3D3 ttl=3D64 time=3D0.048 ms
# 64 bytes from 127.25.3.14: icmp_seq=3D4 ttl=3D64 time=3D0.050 ms
# 64 bytes from 127.25.3.14: icmp_seq=3D5 ttl=3D64 time=3D0.063 ms
#=20
# --- 127.25.3.14 ping statistics ---
# 5 packets transmitted, 5 received, 0% packet loss, time 111ms
# rtt min/avg/max/mdev =3D 0.048/0.060/0.090/0.015 ms
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
# #  RUN           global.reuseaddr_ports_exhausted_reusable_different_euid=
 ...
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
#=20
# family:       INET=20
# test SND
#     USR: 1622324051 s 523537 us (seq=3D0, len=3D0)
#     SND: 1622324051 s 524799 us (seq=3D9, len=3D10)  (USR +1262 us)
#     USR: 1622324051 s 573779 us (seq=3D0, len=3D0)
#     SND: 1622324051 s 574814 us (seq=3D19, len=3D10)  (USR +1035 us)
#     USR: 1622324051 s 623959 us (seq=3D0, len=3D0)
#     SND: 1622324051 s 625001 us (seq=3D29, len=3D10)  (USR +1041 us)
#     USR: 1622324051 s 674143 us (seq=3D0, len=3D0)
#     SND: 1622324051 s 675180 us (seq=3D39, len=3D10)  (USR +1036 us)
#     USR-SND: count=3D4, avg=3D1093 us, min=3D1035 us, max=3D1262 us
# test ENQ
#     USR: 1622324051 s 830875 us (seq=3D0, len=3D0)
#     ENQ: 1622324051 s 830927 us (seq=3D9, len=3D10)  (USR +52 us)
#     USR: 1622324051 s 881104 us (seq=3D0, len=3D0)
#     ENQ: 1622324051 s 881157 us (seq=3D19, len=3D10)  (USR +53 us)
#     USR: 1622324051 s 931395 us (seq=3D0, len=3D0)
#     ENQ: 1622324051 s 931416 us (seq=3D29, len=3D10)  (USR +21 us)
#     USR: 1622324051 s 981585 us (seq=3D0, len=3D0)
#     ENQ: 1622324051 s 981619 us (seq=3D39, len=3D10)  (USR +34 us)
#     USR-ENQ: count=3D4, avg=3D40 us, min=3D21 us, max=3D53 us
# test ENQ + SND
#     USR: 1622324052 s 138384 us (seq=3D0, len=3D0)
#     ENQ: 1622324052 s 138425 us (seq=3D9, len=3D10)  (USR +40 us)
#     SND: 1622324052 s 139437 us (seq=3D9, len=3D10)  (USR +1052 us)
#     USR: 1622324052 s 188696 us (seq=3D0, len=3D0)
#     ENQ: 1622324052 s 188729 us (seq=3D19, len=3D10)  (USR +33 us)
#     SND: 1622324052 s 189782 us (seq=3D19, len=3D10)  (USR +1085 us)
#     USR: 1622324052 s 238992 us (seq=3D0, len=3D0)
#     ENQ: 1622324052 s 239054 us (seq=3D29, len=3D10)  (USR +62 us)
#     SND: 1622324052 s 240083 us (seq=3D29, len=3D10)  (USR +1090 us)
#     USR: 1622324052 s 289315 us (seq=3D0, len=3D0)
#     ENQ: 1622324052 s 289364 us (seq=3D39, len=3D10)  (USR +49 us)
#     SND: 1622324052 s 290390 us (seq=3D39, len=3D10)  (USR +1075 us)
#     USR-ENQ: count=3D4, avg=3D46 us, min=3D33 us, max=3D62 us
#     USR-SND: count=3D4, avg=3D1076 us, min=3D1052 us, max=3D1090 us
#=20
# test ACK
#     USR: 1622324052 s 446332 us (seq=3D0, len=3D0)
#     ACK: 1622324052 s 452551 us (seq=3D9, len=3D10)  (USR +6219 us)
#     USR: 1622324052 s 496611 us (seq=3D0, len=3D0)
#     ACK: 1622324052 s 502782 us (seq=3D19, len=3D10)  (USR +6171 us)
#     USR: 1622324052 s 546902 us (seq=3D0, len=3D0)
#     ACK: 1622324052 s 553174 us (seq=3D29, len=3D10)  (USR +6272 us)
#     USR: 1622324052 s 597188 us (seq=3D0, len=3D0)
#     ACK: 1622324052 s 603476 us (seq=3D39, len=3D10)  (USR +6287 us)
#     USR-ACK: count=3D4, avg=3D6237 us, min=3D6171 us, max=3D6287 us
#=20
# test SND + ACK
#     USR: 1622324052 s 754400 us (seq=3D0, len=3D0)
#     SND: 1622324052 s 755434 us (seq=3D9, len=3D10)  (USR +1034 us)
#     ACK: 1622324052 s 760555 us (seq=3D9, len=3D10)  (USR +6155 us)
#     USR: 1622324052 s 804683 us (seq=3D0, len=3D0)
#     SND: 1622324052 s 805747 us (seq=3D19, len=3D10)  (USR +1064 us)
#     ACK: 1622324052 s 810911 us (seq=3D19, len=3D10)  (USR +6227 us)
#     USR: 1622324052 s 855006 us (seq=3D0, len=3D0)
#     SND: 1622324052 s 856081 us (seq=3D29, len=3D10)  (USR +1074 us)
#     ACK: 1622324052 s 861258 us (seq=3D29, len=3D10)  (USR +6251 us)
#     USR: 1622324052 s 905313 us (seq=3D0, len=3D0)
#     SND: 1622324052 s 906380 us (seq=3D39, len=3D10)  (USR +1066 us)
#     ACK: 1622324052 s 911515 us (seq=3D39, len=3D10)  (USR +6202 us)
#     USR-SND: count=3D4, avg=3D1060 us, min=3D1034 us, max=3D1074 us
#     USR-ACK: count=3D4, avg=3D6209 us, min=3D6155 us, max=3D6251 us
#=20
# test ENQ + SND + ACK
#     USR: 1622324053 s 72117 us (seq=3D0, len=3D0)
#     ENQ: 1622324053 s 72150 us (seq=3D9, len=3D10)  (USR +32 us)
#     SND: 1622324053 s 73159 us (seq=3D9, len=3D10)  (USR +1042 us)
# ERROR: 13962 us expected between 6000 and 6500
#     ACK: 1622324053 s 86079 us (seq=3D9, len=3D10)  (USR +13962 us)
#     USR: 1622324053 s 122430 us (seq=3D0, len=3D0)
#     ENQ: 1622324053 s 122476 us (seq=3D19, len=3D10)  (USR +46 us)
#     SND: 1622324053 s 123511 us (seq=3D19, len=3D10)  (USR +1081 us)
# ERROR: 25421 us expected between 6000 and 6500
#     ACK: 1622324053 s 147851 us (seq=3D19, len=3D10)  (USR +25421 us)
#     USR: 1622324053 s 172967 us (seq=3D0, len=3D0)
#     ENQ: 1622324053 s 172989 us (seq=3D29, len=3D10)  (USR +21 us)
#     SND: 1622324053 s 174004 us (seq=3D29, len=3D10)  (USR +1036 us)
#     ACK: 1622324053 s 179098 us (seq=3D29, len=3D10)  (USR +6130 us)
#     USR: 1622324053 s 223166 us (seq=3D0, len=3D0)
#     ENQ: 1622324053 s 223181 us (seq=3D39, len=3D10)  (USR +15 us)
#     SND: 1622324053 s 224194 us (seq=3D39, len=3D10)  (USR +1028 us)
#     ACK: 1622324053 s 229282 us (seq=3D39, len=3D10)  (USR +6115 us)
#     USR-ENQ: count=3D4, avg=3D29 us, min=3D15 us, max=3D46 us
#     USR-SND: count=3D4, avg=3D1047 us, min=3D1028 us, max=3D1081 us
#     USR-ACK: count=3D4, avg=3D12907 us, min=3D6115 us, max=3D25421 us
not ok 40 selftests: net: txtimestamp.sh # exit=3D1
# selftests: net: vrf-xfrm-tests.sh
#=20
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
#=20
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
#=20
# Tests passed:  10
# Tests failed:   4
not ok 41 selftests: net: vrf-xfrm-tests.sh # exit=3D1
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
# FAILURE in testcase 6 over ipv4 sockopts { SO_TIMESTAMPING: { SOF_TIMESTA=
MPING_SOFTWARE |}} expected cmsgs: {}
# Starting testcase 6 over ipv6...
# ./rxtimestamp: Expected swtstamp to not be set.
# FAILURE in testcase 6 over ipv6 sockopts { SO_TIMESTAMPING: { SOF_TIMESTA=
MPING_SOFTWARE |}} expected cmsgs: {}
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
# FAILURE in testcase 6 over ipv4 sockopts { SO_TIMESTAMPING: { SOF_TIMESTA=
MPING_SOFTWARE |}} expected cmsgs: {}
# Starting testcase 6 over ipv6...
# ./rxtimestamp: Expected swtstamp to not be set.
# FAILURE in testcase 6 over ipv6 sockopts { SO_TIMESTAMPING: { SOF_TIMESTA=
MPING_SOFTWARE |}} expected cmsgs: {}
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
# FAILURE in testcase 6 over ipv4 sockopts { SO_TIMESTAMPING: { SOF_TIMESTA=
MPING_SOFTWARE |}} expected cmsgs: {}
# Starting testcase 6 over ipv6...
# ./rxtimestamp: Expected swtstamp to not be set.
# FAILURE in testcase 6 over ipv6 sockopts { SO_TIMESTAMPING: { SOF_TIMESTA=
MPING_SOFTWARE |}} expected cmsgs: {}
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
#     dev =3D list(devs.keys())[0]
# IndexError: list index out of range
not ok 43 selftests: net: devlink_port_split.py # exit=3D1
# selftests: net: drop_monitor_tests.sh
# SKIP: Could not run test without tshark tool
ok 44 selftests: net: drop_monitor_tests.sh # SKIP
# selftests: net: vrf_route_leaking.sh
#=20
# #########################################################################=
##
# IPv4 (sym route): VRF ICMP ttl error route lookup ping
# #########################################################################=
##
#=20
# TEST: Basic IPv4 connectivity                                       [ OK ]
# TEST: Ping received ICMP ttl exceeded                               [ OK ]
#=20
# #########################################################################=
##
# IPv4 (sym route): VRF ICMP error route lookup traceroute
# #########################################################################=
##
#=20
# SKIP: Could not run IPV4 test without traceroute
#=20
# #########################################################################=
##
# IPv4 (sym route): VRF ICMP fragmentation error route lookup ping
# #########################################################################=
##
#=20
# TEST: Basic IPv4 connectivity                                       [ OK ]
# TEST: Ping received ICMP Frag needed                                [ OK ]
#=20
# #########################################################################=
##
# IPv4 (asym route): VRF ICMP ttl error route lookup ping
# #########################################################################=
##
#=20
# TEST: Basic IPv4 connectivity                                       [ OK ]
# TEST: Ping received ICMP ttl exceeded                               [ OK ]
#=20
# #########################################################################=
##
# IPv4 (asym route): VRF ICMP error route lookup traceroute
# #########################################################################=
##
#=20
# SKIP: Could not run IPV4 test without traceroute
#=20
# #########################################################################=
##
# IPv6 (sym route): VRF ICMP ttl error route lookup ping
# #########################################################################=
##
#=20
# TEST: Basic IPv6 connectivity                                       [ OK ]
# TEST: Ping received ICMP Hop limit                                  [ OK ]
#=20
# #########################################################################=
##
# IPv6 (sym route): VRF ICMP error route lookup traceroute
# #########################################################################=
##
#=20
# SKIP: Could not run IPV6 test without traceroute6
#=20
# #########################################################################=
##
# IPv6 (sym route): VRF ICMP fragmentation error route lookup ping
# #########################################################################=
##
#=20
# TEST: Basic IPv6 connectivity                                       [ OK ]
# TEST: Ping received ICMP Packet too big                             [FAIL]
#=20
# #########################################################################=
##
# IPv6 (asym route): VRF ICMP ttl error route lookup ping
# #########################################################################=
##
#=20
# TEST: Basic IPv6 connectivity                                       [ OK ]
# TEST: Ping received ICMP Hop limit                                  [ OK ]
#=20
# #########################################################################=
##
# IPv6 (asym route): VRF ICMP error route lookup traceroute
# #########################################################################=
##
#=20
# SKIP: Could not run IPV6 test without traceroute6
#=20
# Tests passed:  11
# Tests failed:   1
not ok 45 selftests: net: vrf_route_leaking.sh # exit=3D1
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
# #########################################################################=
##
# Unicast address extensions tests (behavior of reserved IPv4 addresses)
# #########################################################################=
##
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
# selftests: net: udpgro_fwd.sh
# IPv4
# ./udpgro_fwd.sh: 90: local: -r: bad variable name
# ./udpgro_fwd.sh: 22: local: -r: bad variable name
not ok 48 selftests: net: udpgro_fwd.sh # exit=3D2
# selftests: net: veth.sh
# Missing xdp_dummy helper. Build bpf selftest first
# ./veth.sh: 111: exit: Illegal number: -1
# ./veth.sh: 21: local: -r: bad variable name
not ok 49 selftests: net: veth.sh # exit=3D2



To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install                job.yaml  # job file is attached in =
this email
        bin/lkp split-job --compatible job.yaml  # generate the yaml file f=
or lkp run
        bin/lkp run                    generated-yaml-file



---
0DAY/LKP+ Test Infrastructure                   Open Source Technology Cent=
er
https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporati=
on

Thanks,
Oliver Sang


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.12.0-15091-g020ef930b826"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.12.0 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-22) 9.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23502
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

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
# CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
# CONFIG_BPF_PRELOAD is not set
# CONFIG_BPF_LSM is not set
# end of BPF subsystem

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
# CONFIG_CGROUP_MISC is not set
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
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
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
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y

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
# CONFIG_X86_SGX_KVM is not set
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
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
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
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
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
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
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
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
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
CONFIG_IO_MAPPING=y
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
CONFIG_NF_LOG_SYSLOG=m
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
CONFIG_NETFILTER_XTABLES_COMPAT=y

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
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
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
# CONFIG_CAN_ETAS_ES58X is not set
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
# CONFIG_BT_AOSPEXT is not set
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
# CONFIG_BT_VIRTIO is not set
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
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y

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
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
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
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
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
CONFIG_IGC=y
CONFIG_NET_VENDOR_MICROSOFT=y
# CONFIG_MICROSOFT_MANA is not set
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
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
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
# CONFIG_WWAN is not set
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
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK_GT=m
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
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
# CONFIG_I2C_CP2615 is not set
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
# CONFIG_SPI_ALTERA_CORE is not set
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
# CONFIG_BATTERY_GOLDFISH is not set
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
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_BPA_RS600 is not set
# CONFIG_SENSORS_FSP_3Y is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR36021 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
# CONFIG_SENSORS_MAX15301 is not set
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
# CONFIG_SENSORS_STPDDC60 is not set
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
# CONFIG_INTEL_TCC_COOLING is not set
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
# CONFIG_MFD_ATC260X_I2C is not set
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
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
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
# CONFIG_DRM_XEN_FRONTEND is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_GUD is not set
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
# CONFIG_HID_FT260 is not set
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
# CONFIG_RTC_DRV_GOLDFISH is not set
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
CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS=y
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
# CONFIG_COMEDI is not set
CONFIG_STAGING=y
# CONFIG_PRISM2_USB is not set
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
# CONFIG_FIELDBUS_DEV is not set
# CONFIG_KPC2000 is not set
# CONFIG_QLGE is not set
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
# CONFIG_GIGABYTE_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMC is not set
# CONFIG_ADV_SWBUTTON is not set
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
CONFIG_NETFS_SUPPORT=m
# CONFIG_NETFS_STATS is not set
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
# CONFIG_SECURITY_LANDLOCK is not set
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
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"

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
# CONFIG_CRYPTO_ECDSA is not set
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
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
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
CONFIG_CRYPTO_SHA512=m
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
# CONFIG_SYSTEM_REVOCATION_LIST is not set
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

CONFIG_ASN1_ENCODER=y

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
# CONFIG_VMLINUX_MAP is not set
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
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
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
# CONFIG_TEST_DIV64 is not set
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
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--3V7upXqbjpZ4EhLz
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
	export testbox='lkp-skl-nuc2'
	export tbox_group='lkp-skl-nuc2'
	export submit_id='60b299bbdf30166674b12c85'
	export job_file='/lkp/jobs/scheduled/lkp-skl-nuc2/kernel-selftests-net-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-020ef930b826d21c5446fdc9db80fd72a791bc21-20210530-91764-wucc25-5.yaml'
	export id='6d51bb8600b817c8b36f970a96012ddc6658321b'
	export queuer_version='/lkp-src'
	export model='Skylake'
	export nr_cpu=8
	export memory='32G'
	export nr_sdd_partitions=1
	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSCKKF480H6_CVLY6296001Z480F-part1'
	export swap_partitions=
	export rootfs_partition='/dev/disk/by-id/ata-INTEL_SSDSCKKF480H6_CVLY6296001Z480F-part2'
	export brand='Intel(R) Core(TM) i7-6770HQ CPU @ 2.60GHz'
	export commit='020ef930b826d21c5446fdc9db80fd72a791bc21'
	export netconsole_port=6675
	export ucode='0xe2'
	export need_kconfig_hw='CONFIG_E1000E=y
CONFIG_SATA_AHCI'
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
	export enqueue_time='2021-05-30 03:44:59 +0800'
	export _id='60b299c0df30166674b12c89'
	export _rt='/result/kernel-selftests/net-ucode=0xe2/lkp-skl-nuc2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/020ef930b826d21c5446fdc9db80fd72a791bc21'
	export user='lkp'
	export compiler='gcc-9'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='97ca22aa4ae0c286be5bc7c5e42f545bc1ed6a45'
	export base_commit='c4681547bcce777daf576925a966ffa824edd09d'
	export branch='linus/master'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export result_root='/result/kernel-selftests/net-ucode=0xe2/lkp-skl-nuc2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/020ef930b826d21c5446fdc9db80fd72a791bc21/3'
	export scheduler_version='/lkp/lkp/.src-20210528-200739'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-skl-nuc2/kernel-selftests-net-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-020ef930b826d21c5446fdc9db80fd72a791bc21-20210530-91764-wucc25-5.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3-kselftests
branch=linus/master
commit=020ef930b826d21c5446fdc9db80fd72a791bc21
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/020ef930b826d21c5446fdc9db80fd72a791bc21/vmlinuz-5.12.0-15091-g020ef930b826
max_uptime=2100
RESULT_ROOT=/result/kernel-selftests/net-ucode=0xe2/lkp-skl-nuc2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/020ef930b826d21c5446fdc9db80fd72a791bc21/3
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/020ef930b826d21c5446fdc9db80fd72a791bc21/modules.cgz'
	export linux_headers_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/020ef930b826d21c5446fdc9db80fd72a791bc21/linux-headers.cgz'
	export linux_selftests_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/020ef930b826d21c5446fdc9db80fd72a791bc21/linux-selftests.cgz'
	export kselftests_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/020ef930b826d21c5446fdc9db80fd72a791bc21/kselftests.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/kernel-selftests_20210507.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/kernel-selftests-x86_64-0d95472a-1_20210507.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20210222.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.13.0-rc3'
	export repeat_to=6
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/020ef930b826d21c5446fdc9db80fd72a791bc21/vmlinuz-5.12.0-15091-g020ef930b826'
	export dequeue_time='2021-05-30 05:11:13 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-skl-nuc2/kernel-selftests-net-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-020ef930b826d21c5446fdc9db80fd72a791bc21-20210530-91764-wucc25-5.cgz'

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

--3V7upXqbjpZ4EhLz
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=kernel-selftests
Content-Transfer-Encoding: quoted-printable

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-8=
=2E3-kselftests-020ef930b826d21c5446fdc9db80fd72a791bc21
2021-05-29 21:15:23 mount --bind /lib/modules/5.12.0-15091-g020ef930b826/ke=
rnel/lib /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-020ef930b826d21=
c5446fdc9db80fd72a791bc21/lib
2021-05-29 21:15:23 sed -i s/default_timeout=3D45/default_timeout=3D300/ ks=
elftest/runner.sh
2021-05-29 21:15:23 sed -i s/default_timeout=3D45/default_timeout=3D300/ /k=
selftests/kselftest/runner.sh
source /lkp/lkp/src/lib/tests/kernel-selftests-ext.sh
LKP SKIP net.l2tp.sh
LKP SKIP net.tls
2021-05-29 21:15:24 /kselftests/run_kselftest.sh -c net
TAP version 13
1..49
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
# send cpu 4, receive socket 4
# send cpu 5, receive socket 5
# send cpu 6, receive socket 6
# send cpu 7, receive socket 7
# send cpu 7, receive socket 7
# send cpu 6, receive socket 6
# send cpu 5, receive socket 5
# send cpu 4, receive socket 4
# send cpu 3, receive socket 3
# send cpu 2, receive socket 2
# send cpu 1, receive socket 1
# send cpu 0, receive socket 0
# send cpu 0, receive socket 0
# send cpu 2, receive socket 2
# send cpu 4, receive socket 4
# send cpu 6, receive socket 6
# send cpu 1, receive socket 1
# send cpu 3, receive socket 3
# send cpu 5, receive socket 5
# send cpu 7, receive socket 7
# ---- IPv6 UDP ----
# send cpu 0, receive socket 0
# send cpu 1, receive socket 1
# send cpu 2, receive socket 2
# send cpu 3, receive socket 3
# send cpu 4, receive socket 4
# send cpu 5, receive socket 5
# send cpu 6, receive socket 6
# send cpu 7, receive socket 7
# send cpu 7, receive socket 7
# send cpu 6, receive socket 6
# send cpu 5, receive socket 5
# send cpu 4, receive socket 4
# send cpu 3, receive socket 3
# send cpu 2, receive socket 2
# send cpu 1, receive socket 1
# send cpu 0, receive socket 0
# send cpu 0, receive socket 0
# send cpu 2, receive socket 2
# send cpu 4, receive socket 4
# send cpu 6, receive socket 6
# send cpu 1, receive socket 1
# send cpu 3, receive socket 3
# send cpu 5, receive socket 5
# send cpu 7, receive socket 7
# ---- IPv4 TCP ----
# send cpu 0, receive socket 0
# send cpu 1, receive socket 1
# send cpu 2, receive socket 2
# send cpu 3, receive socket 3
# send cpu 4, receive socket 4
# send cpu 5, receive socket 5
# send cpu 6, receive socket 6
# send cpu 7, receive socket 7
# send cpu 7, receive socket 7
# send cpu 6, receive socket 6
# send cpu 5, receive socket 5
# send cpu 4, receive socket 4
# send cpu 3, receive socket 3
# send cpu 2, receive socket 2
# send cpu 1, receive socket 1
# send cpu 0, receive socket 0
# send cpu 0, receive socket 0
# send cpu 2, receive socket 2
# send cpu 4, receive socket 4
# send cpu 6, receive socket 6
# send cpu 1, receive socket 1
# send cpu 3, receive socket 3
# send cpu 5, receive socket 5
# send cpu 7, receive socket 7
# ---- IPv6 TCP ----
# send cpu 0, receive socket 0
# send cpu 1, receive socket 1
# send cpu 2, receive socket 2
# send cpu 3, receive socket 3
# send cpu 4, receive socket 4
# send cpu 5, receive socket 5
# send cpu 6, receive socket 6
# send cpu 7, receive socket 7
# send cpu 7, receive socket 7
# send cpu 6, receive socket 6
# send cpu 5, receive socket 5
# send cpu 4, receive socket 4
# send cpu 3, receive socket 3
# send cpu 2, receive socket 2
# send cpu 1, receive socket 1
# send cpu 0, receive socket 0
# send cpu 0, receive socket 0
# send cpu 2, receive socket 2
# send cpu 4, receive socket 4
# send cpu 6, receive socket 6
# send cpu 1, receive socket 1
# send cpu 3, receive socket 3
# send cpu 5, receive socket 5
# send cpu 7, receive socket 7
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
#=20
# test: datapath 0x0 ports 8000,8002
# info: count=3D0,0, expect=3D0,0
# info: count=3D20,0, expect=3D15,5
# warning: incorrect queue lengths
# info: count=3D20,0, expect=3D20,5
# warning: incorrect queue lengths
# info: trying alternate ports (20)
#=20
# test: datapath 0x0 ports 8000,8003
# info: count=3D0,0, expect=3D0,0
# info: count=3D15,5, expect=3D15,5
# info: count=3D20,5, expect=3D20,5
#=20
# test: datapath 0x1000 ports 8000,8003
# info: count=3D0,0, expect=3D0,0
# info: count=3D15,5, expect=3D15,5
# info: count=3D20,15, expect=3D20,15
#=20
# test: datapath 0x1 ports 8000,8003
# info: count=3D0,0, expect=3D0,0
# info: count=3D10,10, expect=3D10,10
# info: count=3D17,18, expect=3D18,17
#=20
# test: datapath 0x3 ports 8000,8003
# info: count=3D0,0, expect=3D0,0
# info: count=3D15,5, expect=3D15,5
# info: count=3D20,15, expect=3D20,15
#=20
# test: datapath 0x6 ports 8000,8003
# info: count=3D0,0, expect=3D0,0
# info: count=3D5,15, expect=3D15,5
# info: count=3D20,15, expect=3D15,20
#=20
# test: datapath 0x7 ports 8000,8003
# info: count=3D0,0, expect=3D0,0
# info: count=3D5,15, expect=3D15,5
# info: count=3D20,15, expect=3D15,20
#=20
# test: datapath 0x2 ports 8000,8003
# info: count=3D0,0, expect=3D0,0
# info: count=3D20,0, expect=3D20,0
# info: count=3D20,0, expect=3D20,0
#=20
# test: datapath 0x2 ports 8000,8003
# info: count=3D0,0, expect=3D0,0
# info: count=3D0,20, expect=3D0,20
# info: count=3D0,20, expect=3D0,20
#=20
# test: datapath 0x2000 ports 8000,8003
# info: count=3D0,0, expect=3D0,0
# info: count=3D20,20, expect=3D20,20
# info: count=3D20,20, expect=3D20,20
# OK. All tests passed
# [PASS]
# --------------------
# running psock_tpacket test
# --------------------
# test: TPACKET_V1 with PACKET_RX_RING .................... 100 pkts (14200=
 bytes)
# test: TPACKET_V1 with PACKET_TX_RING .................... 100 pkts (14200=
 bytes)
# test: TPACKET_V2 with PACKET_RX_RING .................... 100 pkts (14200=
 bytes)
# test: TPACKET_V2 with PACKET_TX_RING .................... 100 pkts (14200=
 bytes)
# test: TPACKET_V3 with PACKET_RX_RING .................... 100 pkts (14200=
 bytes)
# test: TPACKET_V3 with PACKET_TX_RING .................... 100 pkts (14200=
 bytes)
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
# PASS: set ifalias 93795cf0-4a8d-4cf3-a2be-77b18a91305c for test-dummy0
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
#=20
# Error: argument "test-bond0" is wrong: Device does not exist
#=20
# Cannot find device "test-bond0"
# Cannot find device "test-bond0"
# FAIL: bridge_parent_id
not ok 10 selftests: net: rtnetlink.sh # exit=3D1
# selftests: net: xfrm_policy.sh
# PASS: policy before exception matches
# PASS: ping to .254 bypassed ipsec tunnel (exceptions)
# PASS: direct policy matches (exceptions)
# PASS: policy matches (exceptions)
# PASS: ping to .254 bypassed ipsec tunnel (exceptions and block policies)
# PASS: direct policy matches (exceptions and block policies)
# PASS: policy matches (exceptions and block policies)
# PASS: ping to .254 bypassed ipsec tunnel (exceptions and block policies a=
fter hresh changes)
# PASS: direct policy matches (exceptions and block policies after hresh ch=
anges)
# PASS: policy matches (exceptions and block policies after hresh changes)
# PASS: ping to .254 bypassed ipsec tunnel (exceptions and block policies a=
fter hthresh change in ns3)
# PASS: direct policy matches (exceptions and block policies after hthresh =
change in ns3)
# PASS: policy matches (exceptions and block policies after hthresh change =
in ns3)
# PASS: ping to .254 bypassed ipsec tunnel (exceptions and block policies a=
fter htresh change to normal)
# PASS: direct policy matches (exceptions and block policies after htresh c=
hange to normal)
# PASS: policy matches (exceptions and block policies after htresh change t=
o normal)
# PASS: policies with repeated htresh change
# PASS: policies inserted in random order
ok 11 selftests: net: xfrm_policy.sh
# selftests: net: test_blackhole_dev.sh
# test_blackhole_dev: ok
ok 12 selftests: net: test_blackhole_dev.sh
# selftests: net: fib_tests.sh
#=20
# Single path route test
#     Start point
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     Nexthop device deleted
#     TEST: IPv4 fibmatch - no route                                      [=
 OK ]
#     TEST: IPv6 fibmatch - no route                                      [=
 OK ]
#=20
# Multipath route test
#     Start point
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     One nexthop device deleted
#     TEST: IPv4 - multipath route removed on delete                      [=
 OK ]
#     TEST: IPv6 - multipath down to single path                          [=
 OK ]
#     Second nexthop device deleted
#     TEST: IPv6 - no route                                               [=
 OK ]
#=20
# Single path, admin down
#     Start point
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     Route deleted on down
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#=20
# Admin down multipath
#     Verify start point
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     One device down, one up
#     TEST: IPv4 fibmatch on down device                                  [=
 OK ]
#     TEST: IPv6 fibmatch on down device                                  [=
 OK ]
#     TEST: IPv4 fibmatch on up device                                    [=
 OK ]
#     TEST: IPv6 fibmatch on up device                                    [=
 OK ]
#     TEST: IPv4 flags on down device                                     [=
 OK ]
#     TEST: IPv6 flags on down device                                     [=
 OK ]
#     TEST: IPv4 flags on up device                                       [=
 OK ]
#     TEST: IPv6 flags on up device                                       [=
 OK ]
#     Other device down and up
#     TEST: IPv4 fibmatch on down device                                  [=
 OK ]
#     TEST: IPv6 fibmatch on down device                                  [=
 OK ]
#     TEST: IPv4 fibmatch on up device                                    [=
 OK ]
#     TEST: IPv6 fibmatch on up device                                    [=
 OK ]
#     TEST: IPv4 flags on down device                                     [=
 OK ]
#     TEST: IPv6 flags on down device                                     [=
 OK ]
#     TEST: IPv4 flags on up device                                       [=
 OK ]
#     TEST: IPv6 flags on up device                                       [=
 OK ]
#     Both devices down
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#=20
# Local carrier tests - single path
#     Start point
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     TEST: IPv4 - no linkdown flag                                       [=
 OK ]
#     TEST: IPv6 - no linkdown flag                                       [=
 OK ]
#     Carrier off on nexthop
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     TEST: IPv4 - linkdown flag set                                      [=
 OK ]
#     TEST: IPv6 - linkdown flag set                                      [=
 OK ]
#     Route to local address with carrier down
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     TEST: IPv4 linkdown flag set                                        [=
 OK ]
#     TEST: IPv6 linkdown flag set                                        [=
 OK ]
#=20
# Single path route carrier test
#     Start point
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     TEST: IPv4 no linkdown flag                                         [=
 OK ]
#     TEST: IPv6 no linkdown flag                                         [=
 OK ]
#     Carrier down
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     TEST: IPv4 linkdown flag set                                        [=
 OK ]
#     TEST: IPv6 linkdown flag set                                        [=
 OK ]
#     Second address added with carrier down
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     TEST: IPv4 linkdown flag set                                        [=
 OK ]
#     TEST: IPv6 linkdown flag set                                        [=
 OK ]
#=20
# IPv4 nexthop tests
# <<< write me >>>
#=20
# IPv6 nexthop tests
#     TEST: Directly connected nexthop, unicast address                   [=
 OK ]
#     TEST: Directly connected nexthop, unicast address with device       [=
 OK ]
#     TEST: Gateway is linklocal address                                  [=
 OK ]
#     TEST: Gateway is linklocal address, no device                       [=
 OK ]
#     TEST: Gateway can not be local unicast address                      [=
 OK ]
#     TEST: Gateway can not be local unicast address, with device         [=
 OK ]
#     TEST: Gateway can not be a local linklocal address                  [=
 OK ]
#     TEST: Gateway can be local address in a VRF                         [=
 OK ]
#     TEST: Gateway can be local address in a VRF, with device            [=
 OK ]
#     TEST: Gateway can be local linklocal address in a VRF               [=
 OK ]
#     TEST: Redirect to VRF lookup                                        [=
 OK ]
#     TEST: VRF route, gateway can be local address in default VRF        [=
 OK ]
#     TEST: VRF route, gateway can not be a local address                 [=
 OK ]
#     TEST: VRF route, gateway can not be a local addr with device        [=
 OK ]
#=20
# FIB rule with suppress_prefixlength
#     TEST: FIB rule suppress test                                        [=
 OK ]
#=20
# IPv6 route add / append tests
#     TEST: Attempt to add duplicate route - gw                           [=
 OK ]
#     TEST: Attempt to add duplicate route - dev only                     [=
 OK ]
#     TEST: Attempt to add duplicate route - reject route                 [=
 OK ]
#     TEST: Append nexthop to existing route - gw                         [=
 OK ]
#     TEST: Add multipath route                                           [=
 OK ]
#     TEST: Attempt to add duplicate multipath route                      [=
 OK ]
#     TEST: Route add with different metrics                              [=
 OK ]
#     TEST: Route delete with metric                                      [=
 OK ]
#=20
# IPv6 route replace tests
#     TEST: Single path with single path                                  [=
 OK ]
#     TEST: Single path with multipath                                    [=
 OK ]
#     TEST: Single path with single path via multipath attribute          [=
 OK ]
#     TEST: Invalid nexthop                                               [=
 OK ]
#     TEST: Single path - replace of non-existent route                   [=
 OK ]
#     TEST: Multipath with multipath                                      [=
 OK ]
#     TEST: Multipath with single path                                    [=
 OK ]
#     TEST: Multipath with single path via multipath attribute            [=
 OK ]
#     TEST: Multipath with dev-only                                       [=
 OK ]
#     TEST: Multipath - invalid first nexthop                             [=
 OK ]
#     TEST: Multipath - invalid second nexthop                            [=
 OK ]
#     TEST: Multipath - replace of non-existent route                     [=
 OK ]
#=20
# IPv4 route add / append tests
#     TEST: Attempt to add duplicate route - gw                           [=
 OK ]
#     TEST: Attempt to add duplicate route - dev only                     [=
 OK ]
#     TEST: Attempt to add duplicate route - reject route                 [=
 OK ]
#     TEST: Add new nexthop for existing prefix                           [=
 OK ]
#     TEST: Append nexthop to existing route - gw                         [=
 OK ]
#     TEST: Append nexthop to existing route - dev only                   [=
 OK ]
#     TEST: Append nexthop to existing route - reject route               [=
 OK ]
#     TEST: Append nexthop to existing reject route - gw                  [=
 OK ]
#     TEST: Append nexthop to existing reject route - dev only            [=
 OK ]
#     TEST: add multipath route                                           [=
 OK ]
#     TEST: Attempt to add duplicate multipath route                      [=
 OK ]
#     TEST: Route add with different metrics                              [=
 OK ]
#     TEST: Route delete with metric                                      [=
 OK ]
#=20
# IPv4 route replace tests
#     TEST: Single path with single path                                  [=
 OK ]
#     TEST: Single path with multipath                                    [=
 OK ]
#     TEST: Single path with reject route                                 [=
 OK ]
#     TEST: Single path with single path via multipath attribute          [=
 OK ]
#     TEST: Invalid nexthop                                               [=
 OK ]
#     TEST: Single path - replace of non-existent route                   [=
 OK ]
#     TEST: Multipath with multipath                                      [=
 OK ]
#     TEST: Multipath with single path                                    [=
 OK ]
#     TEST: Multipath with single path via multipath attribute            [=
 OK ]
#     TEST: Multipath with reject route                                   [=
 OK ]
#     TEST: Multipath - invalid first nexthop                             [=
 OK ]
#     TEST: Multipath - invalid second nexthop                            [=
 OK ]
#     TEST: Multipath - replace of non-existent route                     [=
 OK ]
#=20
# IPv6 prefix route tests
#     TEST: Default metric                                                [=
 OK ]
#     TEST: User specified metric on first device                         [=
 OK ]
#     TEST: User specified metric on second device                        [=
 OK ]
#     TEST: Delete of address on first device                             [=
 OK ]
#     TEST: Modify metric of address                                      [=
 OK ]
#     TEST: Prefix route removed on link down                             [=
 OK ]
#     TEST: Prefix route with metric on link up                           [=
 OK ]
#     TEST: Set metric with peer route on local side                      [=
 OK ]
#     TEST: Set metric with peer route on peer side                       [=
 OK ]
#     TEST: Modify metric and peer address on local side                  [=
 OK ]
#     TEST: Modify metric and peer address on peer side                   [=
 OK ]
#=20
# IPv4 prefix route tests
#     TEST: Default metric                                                [=
 OK ]
#     TEST: User specified metric on first device                         [=
 OK ]
#     TEST: User specified metric on second device                        [=
 OK ]
#     TEST: Delete of address on first device                             [=
 OK ]
#     TEST: Modify metric of address                                      [=
 OK ]
#     TEST: Prefix route removed on link down                             [=
 OK ]
#     TEST: Prefix route with metric on link up                           [=
 OK ]
#     TEST: Modify metric of .0/24 address                                [=
 OK ]
#     TEST: Set metric of address with peer route                         [=
 OK ]
#     TEST: Modify metric and peer address for peer route                 [=
 OK ]
#=20
# IPv6 routes with metrics
#     TEST: Single path route with mtu metric                             [=
 OK ]
#     TEST: Multipath route via 2 single routes with mtu metric on first  [=
 OK ]
#     TEST: Multipath route via 2 single routes with mtu metric on 2nd    [=
 OK ]
#     TEST:     MTU of second leg                                         [=
 OK ]
#     TEST: Multipath route with mtu metric                               [=
 OK ]
#     TEST: Using route with mtu metric                                   [=
 OK ]
#     TEST: Invalid metric (fails metric_convert)                         [=
 OK ]
#=20
# IPv4 route add / append tests
#     TEST: Single path route with mtu metric                             [=
 OK ]
#     TEST: Multipath route with mtu metric                               [=
 OK ]
#     TEST: Using route with mtu metric                                   [=
 OK ]
#     TEST: Invalid metric (fails metric_convert)                         [=
 OK ]
#=20
# IPv4 route with IPv6 gateway tests
#     TEST: Single path route with IPv6 gateway                           [=
 OK ]
#     TEST: Single path route with IPv6 gateway - ping                    [=
 OK ]
#     TEST: Single path route delete                                      [=
 OK ]
#     TEST: Multipath route add - v6 nexthop then v4                      [=
 OK ]
#     TEST:     Multipath route delete - nexthops in wrong order          [=
 OK ]
#     TEST:     Multipath route delete exact match                        [=
 OK ]
#     TEST: Multipath route add - v4 nexthop then v6                      [=
 OK ]
#     TEST:     Multipath route delete - nexthops in wrong order          [=
 OK ]
#     TEST:     Multipath route delete exact match                        [=
 OK ]
#=20
# IPv4 rp_filter tests
#     TEST: rp_filter passes local packets                                [=
FAIL]
#     TEST: rp_filter passes loopback packets                             [=
FAIL]
#=20
# IPv4 delete address route tests
#     TEST: Route removed from VRF when source address deleted            [=
 OK ]
#     TEST: Route in default VRF not removed                              [=
 OK ]
#     TEST: Route removed in default VRF when source address deleted      [=
 OK ]
#     TEST: Route in VRF is not removed by address delete                 [=
 OK ]
#=20
# IPv4 mangling tests
# socat command not found. Skipping test
#=20
# IPv6 mangling tests
# socat command not found. Skipping test
#=20
# Tests passed: 163
# Tests failed:   2
not ok 13 selftests: net: fib_tests.sh # exit=3D1
# selftests: net: fib-onlink-tests.sh
# Error: ipv4: FIB table does not exist.
# Flush terminated
# Error: ipv6: FIB table does not exist.
# Flush terminated
#=20
# ########################################
# Configuring interfaces
#=20
# ######################################################################
# TEST SECTION: IPv4 onlink
# ######################################################################
#=20
# #########################################
# TEST SUBSECTION: Valid onlink commands
#=20
# #########################################
# TEST SUBSECTION: default VRF - main table
#     TEST: unicast connected                                   [ OK ]
#     TEST: unicast recursive                                   [ OK ]
#=20
# #########################################
# TEST SUBSECTION: VRF lisa
#     TEST: unicast connected                                   [ OK ]
#     TEST: unicast recursive                                   [ OK ]
#=20
# #########################################
# TEST SUBSECTION: VRF device, PBR table
#     TEST: unicast connected                                   [ OK ]
#     TEST: unicast recursive                                   [ OK ]
#=20
# #########################################
# TEST SUBSECTION: default VRF - main table - multipath
#     TEST: unicast connected - multipath                       [ OK ]
#     TEST: unicast recursive - multipath                       [ OK ]
#     TEST: unicast connected - multipath onlink first only     [ OK ]
#     TEST: unicast connected - multipath onlink second only    [ OK ]
#=20
# #########################################
# TEST SUBSECTION: Invalid onlink commands
#     TEST: Invalid gw - local unicast address                  [ OK ]
#     TEST: Invalid gw - local unicast address, VRF             [ OK ]
#     TEST: No nexthop device given                             [ OK ]
#     TEST: Gateway resolves to wrong nexthop device            [ OK ]
#     TEST: Gateway resolves to wrong nexthop device - VRF      [ OK ]
#=20
# ######################################################################
# TEST SECTION: IPv6 onlink
# ######################################################################
#=20
# #########################################
# TEST SUBSECTION: Valid onlink commands
#=20
# #########################################
# TEST SUBSECTION: default VRF - main table
#     TEST: unicast connected                                   [ OK ]
#     TEST: unicast recursive                                   [ OK ]
#     TEST: v4-mapped                                           [ OK ]
#=20
# #########################################
# TEST SUBSECTION: VRF lisa
#     TEST: unicast connected                                   [ OK ]
#     TEST: unicast recursive                                   [ OK ]
#     TEST: v4-mapped                                           [ OK ]
#=20
# #########################################
# TEST SUBSECTION: VRF device, PBR table
#     TEST: unicast connected                                   [ OK ]
#     TEST: unicast recursive                                   [ OK ]
#     TEST: v4-mapped                                           [ OK ]
#=20
# #########################################
# TEST SUBSECTION: default VRF - main table - multipath
#     TEST: unicast connected - multipath onlink                [ OK ]
#     TEST: unicast recursive - multipath onlink                [ OK ]
#     TEST: v4-mapped - multipath onlink                        [ OK ]
#     TEST: unicast connected - multipath onlink both nexthops  [ OK ]
#     TEST: unicast connected - multipath onlink first only     [ OK ]
#     TEST: unicast connected - multipath onlink second only    [ OK ]
#=20
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
#=20
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
# TEST: IPv4 over geneve6: PMTU exceptions                            [ OK ]
# TEST: IPv4 over geneve6: PMTU exceptions - nexthop objects          [ OK ]
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
# TEST: IPv4, bridged geneve4: PMTU exceptions                        [ OK ]
# TEST: IPv4, bridged geneve4: PMTU exceptions - nexthop objects      [ OK ]
# TEST: IPv6, bridged geneve4: PMTU exceptions                        [ OK ]
# TEST: IPv6, bridged geneve4: PMTU exceptions - nexthop objects      [ OK ]
# TEST: IPv4, bridged geneve6: PMTU exceptions                        [ OK ]
# TEST: IPv4, bridged geneve6: PMTU exceptions - nexthop objects      [ OK ]
# TEST: IPv6, bridged geneve6: PMTU exceptions                        [ OK ]
# TEST: IPv6, bridged geneve6: PMTU exceptions - nexthop objects      [ OK ]
#   ovs_bridge not supported
# TEST: IPv4, OVS vxlan4: PMTU exceptions                             [SKIP]
#   ovs_bridge not supported
# TEST: IPv6, OVS vxlan4: PMTU exceptions                             [SKIP]
#   ovs_bridge not supported
# TEST: IPv4, OVS vxlan6: PMTU exceptions                             [SKIP]
#   ovs_bridge not supported
# TEST: IPv6, OVS vxlan6: PMTU exceptions                             [SKIP]
#   ovs_bridge not supported
# TEST: IPv4, OVS geneve4: PMTU exceptions                            [SKIP]
#   ovs_bridge not supported
# TEST: IPv6, OVS geneve4: PMTU exceptions                            [SKIP]
#   ovs_bridge not supported
# TEST: IPv4, OVS geneve6: PMTU exceptions                            [SKIP]
#   ovs_bridge not supported
# TEST: IPv6, OVS geneve6: PMTU exceptions                            [SKIP]
# TEST: IPv4 over fou4: PMTU exceptions                               [ OK ]
# TEST: IPv4 over fou4: PMTU exceptions - nexthop objects             [ OK ]
# TEST: IPv6 over fou4: PMTU exceptions                               [ OK ]
# TEST: IPv6 over fou4: PMTU exceptions - nexthop objects             [ OK ]
# TEST: IPv4 over fou6: PMTU exceptions                               [ OK ]
# TEST: IPv4 over fou6: PMTU exceptions - nexthop objects             [ OK ]
# TEST: IPv6 over fou6: PMTU exceptions                               [ OK ]
# TEST: IPv6 over fou6: PMTU exceptions - nexthop objects             [ OK ]
# TEST: IPv4 over gue4: PMTU exceptions                               [ OK ]
# TEST: IPv4 over gue4: PMTU exceptions - nexthop objects             [ OK ]
# TEST: IPv6 over gue4: PMTU exceptions                               [ OK ]
# TEST: IPv6 over gue4: PMTU exceptions - nexthop objects             [ OK ]
# TEST: IPv4 over gue6: PMTU exceptions                               [ OK ]
# TEST: IPv4 over gue6: PMTU exceptions - nexthop objects             [ OK ]
# TEST: IPv6 over gue6: PMTU exceptions                               [ OK ]
# TEST: IPv6 over gue6: PMTU exceptions - nexthop objects             [ OK ]
# TEST: IPv4 over IPv4: PMTU exceptions                               [ OK ]
# TEST: IPv4 over IPv4: PMTU exceptions - nexthop objects             [ OK ]
# TEST: IPv6 over IPv4: PMTU exceptions                               [ OK ]
# TEST: IPv6 over IPv4: PMTU exceptions - nexthop objects             [ OK ]
# TEST: IPv4 over IPv6: PMTU exceptions                               [ OK ]
# TEST: IPv4 over IPv6: PMTU exceptions - nexthop objects             [ OK ]
# TEST: IPv6 over IPv6: PMTU exceptions                               [ OK ]
# TEST: IPv6 over IPv6: PMTU exceptions - nexthop objects             [ OK ]
# TEST: vti6: PMTU exceptions                                         [ OK ]
# TEST: vti4: PMTU exceptions                                         [ OK ]
# TEST: vti4: default MTU assignment                                  [ OK ]
# TEST: vti6: default MTU assignment                                  [ OK ]
# TEST: vti4: MTU setting on link creation                            [ OK ]
# TEST: vti6: MTU setting on link creation                            [ OK ]
# TEST: vti6: MTU changes on link changes                             [ OK ]
# TEST: ipv4: cleanup of cached exceptions                            [ OK ]
# TEST: ipv4: cleanup of cached exceptions - nexthop objects          [ OK ]
# TEST: ipv6: cleanup of cached exceptions                            [ OK ]
# TEST: ipv6: cleanup of cached exceptions - nexthop objects          [FAIL]
#   can't delete veth device in a timely manner, PMTU dst likely leaked
# TEST: ipv4: list and flush cached exceptions                        [ OK ]
# TEST: ipv4: list and flush cached exceptions - nexthop objects      [ OK ]
# TEST: ipv6: list and flush cached exceptions                        [ OK ]
# TEST: ipv6: list and flush cached exceptions - nexthop objects      [ OK ]
# TEST: ipv4: PMTU exception w/route replace                          [ OK ]
# TEST: ipv4: PMTU exception w/route replace - nexthop objects        [ OK ]
# TEST: ipv6: PMTU exception w/route replace                          [ OK ]
# TEST: ipv6: PMTU exception w/route replace - nexthop objects        [ OK ]
ok 15 selftests: net: pmtu.sh
# selftests: net: udpgso.sh
# ipv4 cmsg
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv4 tx:1 gso:0=20
# ipv4 tx:1472 gso:0=20
# ipv4 tx:1473 gso:0 (fail)
# ipv4 tx:1472 gso:1472=20
# ipv4 tx:1473 gso:1472=20
# ipv4 tx:2944 gso:1472=20
# ipv4 tx:2945 gso:1472=20
# ipv4 tx:64768 gso:1472=20
# ipv4 tx:65507 gso:1472=20
# ipv4 tx:65508 gso:1472 (fail)
# ipv4 tx:1 gso:1=20
# ipv4 tx:2 gso:1=20
# ipv4 tx:5 gso:2=20
# ipv4 tx:36 gso:1=20
# ipv4 tx:37 gso:1 (fail)
# OK
# ipv4 setsockopt
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv4 tx:1 gso:0=20
# ipv4 tx:1472 gso:0=20
# ipv4 tx:1473 gso:0 (fail)
# ipv4 tx:1472 gso:1472=20
# ipv4 tx:1473 gso:1472=20
# ipv4 tx:2944 gso:1472=20
# ipv4 tx:2945 gso:1472=20
# ipv4 tx:64768 gso:1472=20
# ipv4 tx:65507 gso:1472=20
# ipv4 tx:65508 gso:1472 (fail)
# ipv4 tx:1 gso:1=20
# ipv4 tx:2 gso:1=20
# ipv4 tx:5 gso:2=20
# ipv4 tx:36 gso:1=20
# ipv4 tx:37 gso:1 (fail)
# OK
# ipv6 cmsg
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv6 tx:1 gso:0=20
# ipv6 tx:1452 gso:0=20
# ipv6 tx:1453 gso:0 (fail)
# ipv6 tx:1452 gso:1452=20
# ipv6 tx:1453 gso:1452=20
# ipv6 tx:2904 gso:1452=20
# ipv6 tx:2905 gso:1452=20
# ipv6 tx:65340 gso:1452=20
# ipv6 tx:65527 gso:1452=20
# ipv6 tx:65528 gso:1452 (fail)
# ipv6 tx:1 gso:1=20
# ipv6 tx:2 gso:1=20
# ipv6 tx:5 gso:2=20
# ipv6 tx:16 gso:1=20
# ipv6 tx:17 gso:1 (fail)
# OK
# ipv6 setsockopt
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv6 tx:1 gso:0=20
# ipv6 tx:1452 gso:0=20
# ipv6 tx:1453 gso:0 (fail)
# ipv6 tx:1452 gso:1452=20
# ipv6 tx:1453 gso:1452=20
# ipv6 tx:2904 gso:1452=20
# ipv6 tx:2905 gso:1452=20
# ipv6 tx:65340 gso:1452=20
# ipv6 tx:65527 gso:1452=20
# ipv6 tx:65528 gso:1452 (fail)
# ipv6 tx:1 gso:1=20
# ipv6 tx:2 gso:1=20
# ipv6 tx:5 gso:2=20
# ipv6 tx:16 gso:1=20
# ipv6 tx:17 gso:1 (fail)
# OK
# ipv4 connected
# device mtu (orig): 65536
# device mtu (test): 1600
# route mtu (test): 1500
# path mtu (read):  1500
# ipv4 tx:1 gso:0=20
# ipv4 tx:1472 gso:0=20
# ipv4 tx:1473 gso:0 (fail)
# ipv4 tx:1472 gso:1472=20
# ipv4 tx:1473 gso:1472=20
# ipv4 tx:2944 gso:1472=20
# ipv4 tx:2945 gso:1472=20
# ipv4 tx:64768 gso:1472=20
# ipv4 tx:65507 gso:1472=20
# ipv4 tx:65508 gso:1472 (fail)
# ipv4 tx:1 gso:1=20
# ipv4 tx:2 gso:1=20
# ipv4 tx:5 gso:2=20
# ipv4 tx:36 gso:1=20
# ipv4 tx:37 gso:1 (fail)
# OK
# ipv4 msg_more
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv4 tx:1 gso:0=20
# ipv4 tx:1472 gso:0=20
# ipv4 tx:1473 gso:0 (fail)
# ipv4 tx:1472 gso:1472=20
# ipv4 tx:1473 gso:1472=20
# ipv4 tx:2944 gso:1472=20
# ipv4 tx:2945 gso:1472=20
# ipv4 tx:64768 gso:1472=20
# ipv4 tx:65507 gso:1472=20
# ipv4 tx:65508 gso:1472 (fail)
# ipv4 tx:1 gso:1=20
# ipv4 tx:2 gso:1=20
# ipv4 tx:5 gso:2=20
# ipv4 tx:36 gso:1=20
# ipv4 tx:37 gso:1 (fail)
# OK
# ipv6 msg_more
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv6 tx:1 gso:0=20
# ipv6 tx:1452 gso:0=20
# ipv6 tx:1453 gso:0 (fail)
# ipv6 tx:1452 gso:1452=20
# ipv6 tx:1453 gso:1452=20
# ipv6 tx:2904 gso:1452=20
# ipv6 tx:2905 gso:1452=20
# ipv6 tx:65340 gso:1452=20
# ipv6 tx:65527 gso:1452=20
# ipv6 tx:65528 gso:1452 (fail)
# ipv6 tx:1 gso:1=20
# ipv6 tx:2 gso:1=20
# ipv6 tx:5 gso:2=20
# ipv6 tx:16 gso:1=20
# ipv6 tx:17 gso:1 (fail)
# OK
ok 16 selftests: net: udpgso.sh
# selftests: net: ip_defrag.sh
# ipv4 defrag
# PASS
# seed =3D 1622323436
# ipv4 defrag with overlaps
# PASS
# seed =3D 1622323436
# ipv6 defrag
# PASS
# seed =3D 1622323441
# ipv6 defrag with overlaps
# PASS
# seed =3D 1622323441
# ipv6 nf_conntrack defrag
# PASS
# seed =3D 1622323445
# ipv6 nf_conntrack defrag with overlaps
# PASS
# seed =3D 1622323446
# all tests done
ok 17 selftests: net: ip_defrag.sh
# selftests: net: udpgso_bench.sh
# ipv4
# tcp
# tcp tx:   1220 MB/s    20698 calls/s  20698 msg/s
# tcp rx:   1220 MB/s    20669 calls/s
# tcp tx:   1215 MB/s    20612 calls/s  20612 msg/s
# tcp rx:   1216 MB/s    20616 calls/s
# tcp tx:   1179 MB/s    20012 calls/s  20012 msg/s
# tcp zerocopy
# tcp tx:    893 MB/s    15153 calls/s  15153 msg/s
# tcp rx:    893 MB/s    15072 calls/s
# tcp tx:   1370 MB/s    23245 calls/s  23245 msg/s
# tcp rx:   1372 MB/s    23268 calls/s
# tcp tx:   1272 MB/s    21588 calls/s  21588 msg/s
# udp
# udp rx:     64 MB/s    45877 calls/s
# udp tx:     64 MB/s    46116 calls/s   1098 msg/s
# udp rx:     63 MB/s    45066 calls/s
# udp tx:     63 MB/s    44982 calls/s   1071 msg/s
# udp rx:     59 MB/s    42340 calls/s
# udp tx:     59 MB/s    42336 calls/s   1008 msg/s
# udp gso
# udp rx:    388 MB/s   276980 calls/s
# udp tx:    391 MB/s     6634 calls/s   6634 msg/s
# udp rx:    404 MB/s   288082 calls/s
# udp tx:    403 MB/s     6852 calls/s   6852 msg/s
# udp rx:    377 MB/s   269224 calls/s
# udp tx:    377 MB/s     6401 calls/s   6401 msg/s
# udp gso zerocopy
# udp rx:    284 MB/s   203000 calls/s
# udp tx:    285 MB/s     4849 calls/s   4849 msg/s
# udp rx:    428 MB/s   305460 calls/s
# udp tx:    428 MB/s     7276 calls/s   7276 msg/s
# udp rx:    327 MB/s   233070 calls/s
# udp tx:    327 MB/s     5548 calls/s   5548 msg/s
# udp gso timestamp
# udp rx:    398 MB/s   283668 calls/s
# udp tx:    399 MB/s     6772 calls/s   6772 msg/s
# udp rx:    450 MB/s   321220 calls/s
# udp tx:    452 MB/s     7676 calls/s   7676 msg/s
# udp rx:    341 MB/s   243474 calls/s
# udp tx:    340 MB/s     5770 calls/s   5770 msg/s
# udp gso zerocopy audit
# udp rx:    259 MB/s   185056 calls/s
# udp tx:    261 MB/s     4429 calls/s   4429 msg/s
# udp rx:    264 MB/s   188288 calls/s
# udp tx:    266 MB/s     4527 calls/s   4527 msg/s
# udp rx:    307 MB/s   218789 calls/s
# udp tx:    308 MB/s     5240 calls/s   5240 msg/s
# Summary over 3.000 seconds...
# sum udp tx:    285 MB/s      14196 calls (4732/s)      14196 msgs (4732/s)
# Zerocopy acks:               14196
# udp gso timestamp audit
# udp rx:    277 MB/s   197793 calls/s
# udp tx:    278 MB/s     4729 calls/s   4729 msg/s
# udp rx:    303 MB/s   216282 calls/s
# udp tx:    304 MB/s     5161 calls/s   5161 msg/s
# udp rx:    301 MB/s   214990 calls/s
# udp tx:    300 MB/s     5102 calls/s   5102 msg/s
# Summary over 3.000 seconds...
# sum udp tx:    301 MB/s      14992 calls (4997/s)      14992 msgs (4997/s)
# Tx Timestamps:               14992 received                 0 errors
# udp gso zerocopy timestamp audit
# udp rx:    257 MB/s   183476 calls/s
# udp tx:    258 MB/s     4386 calls/s   4386 msg/s
# udp rx:    255 MB/s   181947 calls/s
# udp tx:    255 MB/s     4331 calls/s   4331 msg/s
# udp rx:    252 MB/s   180012 calls/s
# udp tx:    252 MB/s     4283 calls/s   4283 msg/s
# Summary over 3.000 seconds...
# sum udp tx:    261 MB/s      13000 calls (4333/s)      13000 msgs (4333/s)
# Tx Timestamps:               13000 received                 0 errors
# Zerocopy acks:               13000
# ipv6
# tcp
# tcp tx:   1233 MB/s    20913 calls/s  20913 msg/s
# tcp rx:   1234 MB/s    20925 calls/s
# tcp tx:   1359 MB/s    23060 calls/s  23060 msg/s
# tcp rx:   1361 MB/s    23093 calls/s
# tcp tx:   1330 MB/s    22559 calls/s  22559 msg/s
# tcp zerocopy
# tcp tx:    910 MB/s    15446 calls/s  15446 msg/s
# tcp rx:    911 MB/s    15150 calls/s
# tcp tx:   1143 MB/s    19388 calls/s  19388 msg/s
# tcp rx:   1143 MB/s    19162 calls/s
# tcp tx:    815 MB/s    13829 calls/s  13829 msg/s
# udp
# udp rx:     44 MB/s    32563 calls/s
# udp tx:     44 MB/s    32809 calls/s    763 msg/s
# udp rx:     54 MB/s    40105 calls/s
# udp tx:     55 MB/s    40119 calls/s    933 msg/s
# udp rx:     54 MB/s    39821 calls/s
# udp tx:     54 MB/s    39775 calls/s    925 msg/s
# udp gso
# udp rx:    273 MB/s   199424 calls/s
# udp tx:    275 MB/s     4678 calls/s   4678 msg/s
# udp rx:    288 MB/s   210346 calls/s
# udp tx:    293 MB/s     4975 calls/s   4975 msg/s
# udp rx:    272 MB/s   199049 calls/s
# udp tx:    273 MB/s     4634 calls/s   4634 msg/s
# udp gso zerocopy
# udp rx:    264 MB/s   192612 calls/s
# udp tx:    266 MB/s     4514 calls/s   4514 msg/s
# udp rx:    267 MB/s   194967 calls/s
# udp tx:    266 MB/s     4526 calls/s   4526 msg/s
# udp rx:    265 MB/s   193406 calls/s
# udp tx:    264 MB/s     4491 calls/s   4491 msg/s
# udp gso timestamp
# udp rx:    260 MB/s   190014 calls/s
# udp tx:    260 MB/s     4425 calls/s   4425 msg/s
# udp rx:    282 MB/s   205732 calls/s
# udp tx:    282 MB/s     4783 calls/s   4783 msg/s
# udp tx:    268 MB/s     4547 calls/s   4547 msg/s
# udp gso zerocopy audit
# udp rx:    293 MB/s   214016 calls/s
# udp tx:    295 MB/s     5004 calls/s   5004 msg/s
# udp rx:    305 MB/s   223125 calls/s
# udp tx:    306 MB/s     5192 calls/s   5192 msg/s
# udp rx:    290 MB/s   211600 calls/s
# udp tx:    292 MB/s     4966 calls/s   4966 msg/s
# Summary over 3.000 seconds...
# sum udp tx:    305 MB/s      15162 calls (5054/s)      15162 msgs (5054/s)
# Zerocopy acks:               15162
# udp gso timestamp audit
# udp rx:    273 MB/s   199265 calls/s
# udp tx:    275 MB/s     4676 calls/s   4676 msg/s
# udp rx:    302 MB/s   220810 calls/s
# udp tx:    302 MB/s     5131 calls/s   5131 msg/s
# udp rx:    308 MB/s   225105 calls/s
# udp tx:    308 MB/s     5233 calls/s   5233 msg/s
# Summary over 3.000 seconds...
# sum udp tx:    302 MB/s      15040 calls (5013/s)      15040 msgs (5013/s)
# Tx Timestamps:               15040 received                 0 errors
# udp gso zerocopy timestamp audit
# udp rx:    288 MB/s   210356 calls/s
# udp tx:    290 MB/s     4920 calls/s   4920 msg/s
# udp rx:    245 MB/s   178751 calls/s
# udp tx:    244 MB/s     4146 calls/s   4146 msg/s
# udp rx:    244 MB/s   178493 calls/s
# udp tx:    244 MB/s     4148 calls/s   4148 msg/s
# Summary over 3.000 seconds...
# sum udp tx:    265 MB/s      13214 calls (4404/s)      13214 msgs (4404/s)
# Tx Timestamps:               13214 received                 0 errors
# Zerocopy acks:               13214
# udpgso_bench.sh: PASS=3D18 SKIP=3D0 FAIL=3D0
# udpgso_bench.sh: =1B[0;92mPASS=1B[0m
ok 18 selftests: net: udpgso_bench.sh
# selftests: net: fib_rule_tests.sh
#=20
# ######################################################################
# TEST SECTION: IPv4 fib rule
# ######################################################################
#=20
#     TEST: rule4 check: oif dummy0                             [ OK ]
#=20
#     TEST: rule4 del by pref: oif dummy0                       [ OK ]
# net.ipv4.ip_forward =3D 1
# net.ipv4.conf.dummy0.rp_filter =3D 0
#=20
#     TEST: rule4 check: from 192.51.100.3 iif dummy0           [ OK ]
#=20
#     TEST: rule4 del by pref: from 192.51.100.3 iif dummy0     [ OK ]
# net.ipv4.ip_forward =3D 0
#=20
#     TEST: rule4 check: tos 0x10                               [ OK ]
#=20
#     TEST: rule4 del by pref: tos 0x10                         [ OK ]
#=20
#     TEST: rule4 check: fwmark 0x64                            [ OK ]
#=20
#     TEST: rule4 del by pref: fwmark 0x64                      [ OK ]
#=20
#     TEST: rule4 check: uidrange 100-100                       [ OK ]
#=20
#     TEST: rule4 del by pref: uidrange 100-100                 [ OK ]
#=20
#     TEST: rule4 check: sport 666 dport 777                    [ OK ]
#=20
#     TEST: rule4 del by pref: sport 666 dport 777              [ OK ]
#=20
#     TEST: rule4 check: ipproto tcp                            [ OK ]
#=20
#     TEST: rule4 del by pref: ipproto tcp                      [ OK ]
#=20
#     TEST: rule4 check: ipproto icmp                           [ OK ]
#=20
#     TEST: rule4 del by pref: ipproto icmp                     [ OK ]
#=20
# ######################################################################
# TEST SECTION: IPv6 fib rule
# ######################################################################
#=20
#     TEST: rule6 check: oif dummy0                             [ OK ]
#=20
#     TEST: rule6 del by pref: oif dummy0                       [ OK ]
#=20
#     TEST: rule6 check: from 2001:db8:1::3 iif dummy0          [ OK ]
#=20
#     TEST: rule6 del by pref: from 2001:db8:1::3 iif dummy0    [ OK ]
#=20
#     TEST: rule6 check: tos 0x10                               [ OK ]
#=20
#     TEST: rule6 del by pref: tos 0x10                         [ OK ]
#=20
#     TEST: rule6 check: fwmark 0x64                            [ OK ]
#=20
#     TEST: rule6 del by pref: fwmark 0x64                      [ OK ]
#=20
#     TEST: rule6 check: uidrange 100-100                       [ OK ]
#=20
#     TEST: rule6 del by pref: uidrange 100-100                 [ OK ]
#=20
#     TEST: rule6 check: sport 666 dport 777                    [ OK ]
#=20
#     TEST: rule6 del by pref: sport 666 dport 777              [ OK ]
#=20
#     TEST: rule6 check: ipproto tcp                            [ OK ]
#=20
#     TEST: rule6 del by pref: ipproto tcp                      [ OK ]
#=20
#     TEST: rule6 check: ipproto ipv6-icmp                      [ OK ]
#=20
#     TEST: rule6 del by pref: ipproto ipv6-icmp                [ OK ]
#=20
# Tests passed:  32
# Tests failed:   0
ok 19 selftests: net: fib_rule_tests.sh
# selftests: net: msg_zerocopy.sh
# ipv4 tcp -t 1
# tx=3D28334 (1768 MB) txc=3D0 zc=3Dn
# rx=3D14168 (1768 MB)
# ipv4 tcp -z -t 1
# tx=3D30436 (1899 MB) txc=3D30436 zc=3Dn
# rx=3D15219 (1899 MB)
# ok
# ipv6 tcp -t 1
# tx=3D20235 (1262 MB) txc=3D0 zc=3Dn
# rx=3D10119 (1262 MB)
# ipv6 tcp -z -t 1
# tx=3D25757 (1607 MB) txc=3D25757 zc=3Dn
# rx=3D12879 (1607 MB)
# ok
# ipv4 udp -t 1
# tx=3D20413 (1273 MB) txc=3D0 zc=3Dn
# rx=3D20406 (1273 MB)
# ipv4 udp -z -t 1
# tx=3D26721 (1667 MB) txc=3D26721 zc=3Dn
# rx=3D26721 (1667 MB)
# ok
# ipv6 udp -t 1
# tx=3D24706 (1541 MB) txc=3D0 zc=3Dn
# rx=3D24706 (1541 MB)
# ipv6 udp -z -t 1
# tx=3D25760 (1607 MB) txc=3D25760 zc=3Dn
# rx=3D25760 (1607 MB)
# ok
# OK. All tests passed
ok 20 selftests: net: msg_zerocopy.sh
# selftests: net: psock_snd.sh
# dgram
# tx: 128
# rx: 142
# rx: 100
# OK
#=20
# dgram bind
# tx: 128
# rx: 142
# rx: 100
# OK
#=20
# raw
# tx: 142
# rx: 142
# rx: 100
# OK
#=20
# raw bind
# tx: 142
# rx: 142
# rx: 100
# OK
#=20
# raw qdisc bypass
# tx: 142
# rx: 142
# rx: 100
# OK
#=20
# raw vlan
# tx: 146
# rx: 100
# OK
#=20
# raw vnet hdr
# tx: 152
# rx: 142
# rx: 100
# OK
#=20
# raw csum_off
# tx: 152
# rx: 142
# rx: 100
# OK
#=20
# raw csum_off with bad offset (expected to fail)
# ./psock_snd: write: Invalid argument
# raw min size
# tx: 42
# rx: 0
# OK
#=20
# raw mtu size
# tx: 1514
# rx: 1472
# OK
#=20
# raw mtu size + 1 (expected to fail)
# ./psock_snd: write: Message too long
# raw vlan mtu size + 1 (expected to fail)
# ./psock_snd: write: Message too long
# dgram mtu size
# tx: 1500
# rx: 1472
# OK
#=20
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
#=20
# raw gso min size - 1 (expected to fail)
# tx: 1524
# rx: 1472
# OK
#=20
not ok 21 selftests: net: psock_snd.sh # exit=3D1
# selftests: net: udpgro_bench.sh
# Missing xdp_dummy helper. Build bpf selftest first
not ok 22 selftests: net: udpgro_bench.sh # exit=3D255
# selftests: net: udpgro.sh
# Missing xdp_dummy helper. Build bpf selftest first
not ok 23 selftests: net: udpgro.sh # exit=3D255
# selftests: net: test_vxlan_under_vrf.sh
# Checking HV connectivity                                           [ OK ]
# Check VM connectivity through VXLAN (underlay in the default VRF)  [ OK ]
# Check VM connectivity through VXLAN (underlay in a VRF)            [FAIL]
not ok 24 selftests: net: test_vxlan_under_vrf.sh # exit=3D1
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
#=20
# SO_TXTIME ipv4 clock monotonic
# payload:a delay:225 expected:0 (us)
#=20
# SO_TXTIME ipv6 clock monotonic
# payload:a delay:184 expected:0 (us)
#=20
# SO_TXTIME ipv6 clock monotonic
# payload:a delay:10059 expected:10000 (us)
#=20
# SO_TXTIME ipv4 clock monotonic
# payload:a delay:10182 expected:10000 (us)
# payload:b delay:20094 expected:20000 (us)
#=20
# SO_TXTIME ipv6 clock monotonic
# payload:b delay:20191 expected:20000 (us)
# payload:a delay:20302 expected:20000 (us)
#=20
# SO_TXTIME ipv4 clock tai
# send: pkt a at -1622323534411ms dropped: invalid txtime
# ./so_txtime: recv: timeout: Resource temporarily unavailable
#=20
# SO_TXTIME ipv6 clock tai
# send: pkt a at 0ms dropped: invalid txtime
# ./so_txtime: recv: timeout: Resource temporarily unavailable
#=20
# SO_TXTIME ipv6 clock tai
# payload:a delay:9822 expected:10000 (us)
#=20
# SO_TXTIME ipv4 clock tai
# payload:a delay:9843 expected:10000 (us)
# payload:b delay:19707 expected:20000 (us)
#=20
# SO_TXTIME ipv6 clock tai
# payload:b delay:9834 expected:10000 (us)
# payload:a delay:19700 expected:20000 (us)
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
# recv with label 326205
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
#=20
# #########################################################################=
##
# IPv4 ping
# #########################################################################=
##
#=20
#=20
# #################################################################
# No VRF
#=20
# SYSCTL: net.ipv4.raw_l3mdev_accept=3D0
#=20
# TEST: ping out - ns-B IP                                                 =
     [ OK ]
# TEST: ping out, device bind - ns-B IP                                    =
     [ OK ]
# TEST: ping out, address bind - ns-B IP                                   =
     [ OK ]
# TEST: ping out - ns-B loopback IP                                        =
     [ OK ]
# TEST: ping out, device bind - ns-B loopback IP                           =
     [ OK ]
# TEST: ping out, address bind - ns-B loopback IP                          =
     [ OK ]
# TEST: ping in - ns-A IP                                                  =
     [ OK ]
# TEST: ping in - ns-A loopback IP                                         =
     [ OK ]
# TEST: ping local - ns-A IP                                               =
     [ OK ]
# TEST: ping local - ns-A loopback IP                                      =
     [ OK ]
# TEST: ping local - loopback                                              =
     [ OK ]
# TEST: ping local, device bind - ns-A IP                                  =
     [ OK ]
# TEST: ping local, device bind - ns-A loopback IP                         =
     [ OK ]
# TEST: ping local, device bind - loopback                                 =
     [ OK ]
# TEST: ping out, blocked by rule - ns-B loopback IP                       =
     [ OK ]
# TEST: ping in, blocked by rule - ns-A loopback IP                        =
     [ OK ]
# TEST: ping out, blocked by route - ns-B loopback IP                      =
     [ OK ]
# TEST: ping in, blocked by route - ns-A loopback IP                       =
     [ OK ]
# TEST: ping out, unreachable default route - ns-B loopback IP             =
     [ OK ]
# SYSCTL: net.ipv4.raw_l3mdev_accept=3D1
#=20
# TEST: ping out - ns-B IP                                                 =
     [ OK ]
# TEST: ping out, device bind - ns-B IP                                    =
     [ OK ]
# TEST: ping out, address bind - ns-B IP                                   =
     [ OK ]
# TEST: ping out - ns-B loopback IP                                        =
     [ OK ]
# TEST: ping out, device bind - ns-B loopback IP                           =
     [ OK ]
# TEST: ping out, address bind - ns-B loopback IP                          =
     [ OK ]
# TEST: ping in - ns-A IP                                                  =
     [ OK ]
# TEST: ping in - ns-A loopback IP                                         =
     [ OK ]
# TEST: ping local - ns-A IP                                               =
     [ OK ]
# TEST: ping local - ns-A loopback IP                                      =
     [ OK ]
# TEST: ping local - loopback                                              =
     [ OK ]
# TEST: ping local, device bind - ns-A IP                                  =
     [ OK ]
# TEST: ping local, device bind - ns-A loopback IP                         =
     [ OK ]
# TEST: ping local, device bind - loopback                                 =
     [ OK ]
# TEST: ping out, blocked by rule - ns-B loopback IP                       =
     [ OK ]
# TEST: ping in, blocked by rule - ns-A loopback IP                        =
     [ OK ]
# TEST: ping out, blocked by route - ns-B loopback IP                      =
     [ OK ]
# TEST: ping in, blocked by route - ns-A loopback IP                       =
     [ OK ]
# TEST: ping out, unreachable default route - ns-B loopback IP             =
     [ OK ]
#=20
# #################################################################
# With VRF
#=20
# SYSCTL: net.ipv4.raw_l3mdev_accept=3D1
#=20
# TEST: ping out, VRF bind - ns-B IP                                       =
     [ OK ]
# TEST: ping out, device bind - ns-B IP                                    =
     [ OK ]
# TEST: ping out, vrf device + dev address bind - ns-B IP                  =
     [ OK ]
# TEST: ping out, vrf device + vrf address bind - ns-B IP                  =
     [ OK ]
# TEST: ping out, VRF bind - ns-B loopback IP                              =
     [ OK ]
# TEST: ping out, device bind - ns-B loopback IP                           =
     [ OK ]
# TEST: ping out, vrf device + dev address bind - ns-B loopback IP         =
     [ OK ]
# TEST: ping out, vrf device + vrf address bind - ns-B loopback IP         =
     [ OK ]
# TEST: ping in - ns-A IP                                                  =
     [ OK ]
# TEST: ping in - VRF IP                                                   =
     [ OK ]
# TEST: ping local, VRF bind - ns-A IP                                     =
     [ OK ]
# TEST: ping local, VRF bind - VRF IP                                      =
     [ OK ]
# TEST: ping local, VRF bind - loopback                                    =
     [ OK ]
# TEST: ping local, device bind - ns-A IP                                  =
     [ OK ]
# TEST: ping local, device bind - VRF IP                                   =
     [ OK ]
# TEST: ping local, device bind - loopback                                 =
     [ OK ]
# TEST: ping out, vrf bind, blocked by rule - ns-B loopback IP             =
     [ OK ]
# TEST: ping out, device bind, blocked by rule - ns-B loopback IP          =
     [ OK ]
# TEST: ping in, blocked by rule - ns-A loopback IP                        =
     [ OK ]
# TEST: ping out, vrf bind, unreachable route - ns-B loopback IP           =
     [ OK ]
# TEST: ping out, device bind, unreachable route - ns-B loopback IP        =
     [ OK ]
# TEST: ping in, unreachable route - ns-A loopback IP                      =
     [ OK ]
#=20
# #########################################################################=
##
# IPv4/TCP
# #########################################################################=
##
#=20
#=20
# #################################################################
# No VRF
#=20
#=20
# #################################################################
# tcp_l3mdev_accept disabled
#=20
# SYSCTL: net.ipv4.tcp_l3mdev_accept=3D0
#=20
# TEST: Global server - ns-A IP                                            =
     [ OK ]
# TEST: Global server - ns-A loopback IP                                   =
     [ OK ]
# TEST: Device server - ns-A IP                                            =
     [ OK ]
# TEST: No server - ns-A IP                                                =
     [ OK ]
# TEST: No server - ns-A loopback IP                                       =
     [ OK ]
# TEST: Client - ns-B IP                                                   =
     [ OK ]
# TEST: Client, device bind - ns-B IP                                      =
     [ OK ]
# TEST: No server, unbound client - ns-B IP                                =
     [ OK ]
# TEST: No server, device client - ns-B IP                                 =
     [ OK ]
# TEST: Client - ns-B loopback IP                                          =
     [ OK ]
# TEST: Client, device bind - ns-B loopback IP                             =
     [ OK ]
# TEST: No server, unbound client - ns-B loopback IP                       =
     [ OK ]
# TEST: No server, device client - ns-B loopback IP                        =
     [ OK ]
# TEST: Global server, local connection - ns-A IP                          =
     [ OK ]
# TEST: Global server, local connection - ns-A loopback IP                 =
     [ OK ]
# TEST: Global server, local connection - loopback                         =
     [ OK ]
# TEST: Device server, unbound client, local connection - ns-A IP          =
     [ OK ]
# TEST: Device server, unbound client, local connection - ns-A loopback IP =
     [ OK ]
# TEST: Device server, unbound client, local connection - loopback         =
     [ OK ]
# TEST: Global server, device client, local connection - ns-A IP           =
     [ OK ]
# TEST: Global server, device client, local connection - ns-A loopback IP  =
     [ OK ]
# TEST: Global server, device client, local connection - loopback          =
     [ OK ]
# TEST: Device server, device client, local connection - ns-A IP           =
     [ OK ]
# TEST: No server, device client, local conn - ns-A IP                     =
     [ OK ]
# TEST: MD5: Single address config                                         =
     [ OK ]
# TEST: MD5: Server no config, client uses password                        =
     [ OK ]
# TEST: MD5: Client uses wrong password                                    =
     [ OK ]
# TEST: MD5: Client address does not match address configured with password=
     [ OK ]
# TEST: MD5: Prefix config                                                 =
     [ OK ]
# TEST: MD5: Prefix config, client uses wrong password                     =
     [ OK ]
# TEST: MD5: Prefix config, client address not in configured prefix        =
     [ OK ]
#=20
# #################################################################
# tcp_l3mdev_accept enabled
#=20
# SYSCTL: net.ipv4.tcp_l3mdev_accept=3D1
#=20
# TEST: Global server - ns-A IP                                            =
     [ OK ]
# TEST: Global server - ns-A loopback IP                                   =
     [ OK ]
# TEST: Device server - ns-A IP                                            =
     [ OK ]
# TEST: No server - ns-A IP                                                =
     [ OK ]
# TEST: No server - ns-A loopback IP                                       =
     [ OK ]
# TEST: Client - ns-B IP                                                   =
     [ OK ]
# TEST: Client, device bind - ns-B IP                                      =
     [ OK ]
# TEST: No server, unbound client - ns-B IP                                =
     [ OK ]
# TEST: No server, device client - ns-B IP                                 =
     [ OK ]
# TEST: Client - ns-B loopback IP                                          =
     [ OK ]
# TEST: Client, device bind - ns-B loopback IP                             =
     [ OK ]
# TEST: No server, unbound client - ns-B loopback IP                       =
     [ OK ]
# TEST: No server, device client - ns-B loopback IP                        =
     [ OK ]
# TEST: Global server, local connection - ns-A IP                          =
     [ OK ]
# TEST: Global server, local connection - ns-A loopback IP                 =
     [ OK ]
#
not ok 30 selftests: net: fcnal-test.sh # TIMEOUT 300 seconds
# selftests: net: traceroute.sh
# SKIP: Could not run IPV6 test without traceroute6
# SKIP: Could not run IPV4 test without traceroute
#=20
# Tests passed:   0
# Tests failed:   0
ok 31 selftests: net: traceroute.sh
# selftests: net: fin_ack_lat.sh
# server port: 49849
# test done
ok 32 selftests: net: fin_ack_lat.sh
# selftests: net: fib_nexthop_multiprefix.sh
# TEST: IPv4: host 0 to host 1, mtu 1300                              [ OK ]
# TEST: IPv6: host 0 to host 1, mtu 1300                              [FAIL]
#=20
# TEST: IPv4: host 0 to host 2, mtu 1350                              [ OK ]
# TEST: IPv6: host 0 to host 2, mtu 1350                              [FAIL]
#=20
# TEST: IPv4: host 0 to host 3, mtu 1400                              [ OK ]
# TEST: IPv6: host 0 to host 3, mtu 1400                              [FAIL]
#=20
# TEST: IPv4: host 0 to host 1, mtu 1300                              [ OK ]
# TEST: IPv6: host 0 to host 1, mtu 1300                              [FAIL]
#=20
# TEST: IPv4: host 0 to host 2, mtu 1350                              [ OK ]
# TEST: IPv6: host 0 to host 2, mtu 1350                              [FAIL]
#=20
# TEST: IPv4: host 0 to host 3, mtu 1400                              [ OK ]
# TEST: IPv6: host 0 to host 3, mtu 1400                              [FAIL]
ok 33 selftests: net: fib_nexthop_multiprefix.sh
# selftests: net: fib_nexthops.sh
#=20
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
# TEST: Large scale nexthop flushing                                  [ OK ]
#=20
# Basic resilient nexthop group functional tests
# ----------------------------------------------
# TEST: Add a nexthop group with default parameters                   [ OK ]
# TEST: Get a nexthop group with default parameters                   [ OK ]
# TEST: Get a nexthop group with non-default parameters               [ OK ]
# TEST: Add a nexthop group with 0 buckets                            [ OK ]
# TEST: Replace nexthop group parameters                              [ OK ]
# TEST: Get a nexthop group after replacing parameters                [ OK ]
# TEST: Replace idle timer                                            [ OK ]
# TEST: Get a nexthop group after replacing idle timer                [ OK ]
# TEST: Replace unbalanced timer                                      [ OK ]
# TEST: Get a nexthop group after replacing unbalanced timer          [ OK ]
# TEST: Replace with no parameters                                    [ OK ]
# TEST: Get a nexthop group after replacing no parameters             [ OK ]
# TEST: Replace nexthop group type - implicit                         [ OK ]
# TEST: Replace nexthop group type - explicit                         [ OK ]
# TEST: Replace number of nexthop buckets                             [ OK ]
# TEST: Get a nexthop group after replacing with invalid parameters   [ OK ]
# TEST: Dump all nexthop buckets                                      [ OK ]
# TEST: Dump all nexthop buckets in a group                           [ OK ]
# TEST: All nexthop buckets report a positive near-zero idle time     [ OK ]
# TEST: Dump all nexthop buckets with a specific nexthop device       [ OK ]
# TEST: Dump all nexthop buckets with a specific nexthop identifier   [ OK ]
# TEST: Dump all nexthop buckets in a non-existent group              [ OK ]
# TEST: Dump all nexthop buckets in a non-resilient group             [ OK ]
# TEST: Dump all nexthop buckets using a non-existent device          [ OK ]
# TEST: Dump all nexthop buckets with invalid 'groups' keyword        [ OK ]
# TEST: Dump all nexthop buckets with invalid 'fdb' keyword           [ OK ]
# TEST: Get a valid nexthop bucket                                    [ OK ]
# TEST: Get a nexthop bucket with valid group, but invalid index      [ OK ]
# TEST: Get a nexthop bucket from a non-resilient group               [ OK ]
# TEST: Get a nexthop bucket from a non-existent group                [ OK ]
# TEST: Initial bucket allocation                                     [ OK ]
# TEST: Bucket allocation after replace                               [ OK ]
# TEST: Buckets migrated after idle timer change                      [ OK ]
#=20
# IPv4 functional
# ----------------------
# TEST: Create nexthop with id, gw, dev                               [ OK ]
# TEST: Get nexthop by id                                             [ OK ]
# TEST: Delete nexthop by id                                          [ OK ]
# TEST: Create nexthop - gw only                                      [ OK ]
# TEST: Create nexthop - invalid gw+dev combination                   [ OK ]
# TEST: Create nexthop - gw+dev and onlink                            [ OK ]
# TEST: Nexthops removed on admin down                                [ OK ]
#=20
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
#=20
# IPv4 resilient groups functional
# --------------------------------
# TEST: Nexthop group updated when entry is deleted                   [ OK ]
# TEST: Nexthop buckets updated when entry is deleted                 [ OK ]
# TEST: Nexthop group updated after replace                           [ OK ]
# TEST: Nexthop buckets updated after replace                         [ OK ]
# TEST: Nexthop group updated when entry is deleted - nECMP           [ OK ]
# TEST: Nexthop buckets updated when entry is deleted - nECMP         [ OK ]
# TEST: Nexthop group updated after replace - nECMP                   [ OK ]
# TEST: Nexthop buckets updated after replace - nECMP                 [ OK ]
# TEST: IPv6 nexthop with IPv4 route                                  [ OK ]
# TEST: IPv6 nexthop with IPv4 route                                  [ OK ]
# TEST: IPv4 route with IPv6 gateway                                  [ OK ]
# TEST: IPv4 route with invalid IPv6 gateway                          [ OK ]
#=20
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
#=20
# IPv4 large groups (x32)
# ---------------------
# TEST: Dump large (x32) ecmp groups                                  [ OK ]
#=20
# IPv4 large resilient group (128k buckets)
# -----------------------------------------
# TEST: Dump large (x131072) nexthop buckets                          [ OK ]
#=20
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
#=20
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
#=20
# IPv4 runtime torture
# --------------------
# SKIP: Could not run test; need mausezahn tool
#=20
# IPv4 runtime resilient nexthop group torture
# --------------------------------------------
# SKIP: Could not run test; need mausezahn tool
#=20
# IPv6
# ----------------------
# TEST: Create nexthop with id, gw, dev                               [ OK ]
# TEST: Get nexthop by id                                             [ OK ]
# TEST: Delete nexthop by id                                          [ OK ]
# TEST: Create nexthop - gw only                                      [ OK ]
# TEST: Create nexthop - invalid gw+dev combination                   [ OK ]
# TEST: Create nexthop - gw+dev and onlink                            [ OK ]
# TEST: Nexthops removed on admin down                                [ OK ]
#=20
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
#=20
# IPv6 resilient groups functional
# --------------------------------
# TEST: Nexthop group updated when entry is deleted                   [ OK ]
# TEST: Nexthop buckets updated when entry is deleted                 [ OK ]
# TEST: Nexthop group updated after replace                           [ OK ]
# TEST: Nexthop buckets updated after replace                         [ OK ]
# TEST: Nexthop group updated when entry is deleted - nECMP           [ OK ]
# TEST: Nexthop buckets updated when entry is deleted - nECMP         [ OK ]
# TEST: Nexthop group updated after replace - nECMP                   [ OK ]
# TEST: Nexthop buckets updated after replace - nECMP                 [ OK ]
#=20
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
#=20
# IPv6 large groups (x32)
# ---------------------
# TEST: Dump large (x32) ecmp groups                                  [ OK ]
#=20
# IPv6 large resilient group (128k buckets)
# -----------------------------------------
# TEST: Dump large (x131072) nexthop buckets                          [ OK ]
#=20
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
#=20
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
#=20
# IPv6 runtime torture
# --------------------
# SKIP: Could not run test; need mausezahn tool
#=20
# IPv6 runtime resilient nexthop group torture
# --------------------------------------------
# SKIP: Could not run test; need mausezahn tool
#=20
# Tests passed: 215
# Tests failed:   0
ok 34 selftests: net: fib_nexthops.sh
# selftests: net: altnames.sh
# SKIP: mausezahn not installed
not ok 35 selftests: net: altnames.sh # exit=3D1
# selftests: net: icmp_redirect.sh
#=20
# #########################################################################=
##
# Legacy routing
# #########################################################################=
##
#=20
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
#=20
# #########################################################################=
##
# Legacy routing with VRF
# #########################################################################=
##
#=20
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
#=20
# #########################################################################=
##
# Routing with nexthop objects
# #########################################################################=
##
#=20
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
#=20
# #########################################################################=
##
# Routing with nexthop objects and VRF
# #########################################################################=
##
#=20
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
#=20
# Tests passed:  28
# Tests failed:  12
not ok 36 selftests: net: icmp_redirect.sh # exit=3D1
# selftests: net: ip6_gre_headroom.sh
# TEST: ip6gretap headroom                                            [PASS]
# TEST: ip6erspan headroom                                            [PASS]
ok 37 selftests: net: ip6_gre_headroom.sh
# selftests: net: route_localnet.sh
# run arp_announce test
# net.ipv4.conf.veth0.route_localnet =3D 1
# net.ipv4.conf.veth1.route_localnet =3D 1
# net.ipv4.conf.veth0.arp_announce =3D 2
# net.ipv4.conf.veth1.arp_announce =3D 2
# PING 127.25.3.14 (127.25.3.14) from 127.25.3.4 veth0: 56(84) bytes of dat=
a.
# 64 bytes from 127.25.3.14: icmp_seq=3D1 ttl=3D64 time=3D0.091 ms
# 64 bytes from 127.25.3.14: icmp_seq=3D2 ttl=3D64 time=3D0.047 ms
# 64 bytes from 127.25.3.14: icmp_seq=3D3 ttl=3D64 time=3D0.064 ms
# 64 bytes from 127.25.3.14: icmp_seq=3D4 ttl=3D64 time=3D0.049 ms
# 64 bytes from 127.25.3.14: icmp_seq=3D5 ttl=3D64 time=3D0.063 ms
#=20
# --- 127.25.3.14 ping statistics ---
# 5 packets transmitted, 5 received, 0% packet loss, time 137ms
# rtt min/avg/max/mdev =3D 0.047/0.062/0.091/0.018 ms
# ok
# run arp_ignore test
# net.ipv4.conf.veth0.route_localnet =3D 1
# net.ipv4.conf.veth1.route_localnet =3D 1
# net.ipv4.conf.veth0.arp_ignore =3D 3
# net.ipv4.conf.veth1.arp_ignore =3D 3
# PING 127.25.3.14 (127.25.3.14) from 127.25.3.4 veth0: 56(84) bytes of dat=
a.
# 64 bytes from 127.25.3.14: icmp_seq=3D1 ttl=3D64 time=3D0.090 ms
# 64 bytes from 127.25.3.14: icmp_seq=3D2 ttl=3D64 time=3D0.049 ms
# 64 bytes from 127.25.3.14: icmp_seq=3D3 ttl=3D64 time=3D0.048 ms
# 64 bytes from 127.25.3.14: icmp_seq=3D4 ttl=3D64 time=3D0.050 ms
# 64 bytes from 127.25.3.14: icmp_seq=3D5 ttl=3D64 time=3D0.063 ms
#=20
# --- 127.25.3.14 ping statistics ---
# 5 packets transmitted, 5 received, 0% packet loss, time 111ms
# rtt min/avg/max/mdev =3D 0.048/0.060/0.090/0.015 ms
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
# #  RUN           global.reuseaddr_ports_exhausted_reusable_different_euid=
 ...
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
#=20
# family:       INET=20
# test SND
#     USR: 1622324051 s 523537 us (seq=3D0, len=3D0)
#     SND: 1622324051 s 524799 us (seq=3D9, len=3D10)  (USR +1262 us)
#     USR: 1622324051 s 573779 us (seq=3D0, len=3D0)
#     SND: 1622324051 s 574814 us (seq=3D19, len=3D10)  (USR +1035 us)
#     USR: 1622324051 s 623959 us (seq=3D0, len=3D0)
#     SND: 1622324051 s 625001 us (seq=3D29, len=3D10)  (USR +1041 us)
#     USR: 1622324051 s 674143 us (seq=3D0, len=3D0)
#     SND: 1622324051 s 675180 us (seq=3D39, len=3D10)  (USR +1036 us)
#     USR-SND: count=3D4, avg=3D1093 us, min=3D1035 us, max=3D1262 us
# test ENQ
#     USR: 1622324051 s 830875 us (seq=3D0, len=3D0)
#     ENQ: 1622324051 s 830927 us (seq=3D9, len=3D10)  (USR +52 us)
#     USR: 1622324051 s 881104 us (seq=3D0, len=3D0)
#     ENQ: 1622324051 s 881157 us (seq=3D19, len=3D10)  (USR +53 us)
#     USR: 1622324051 s 931395 us (seq=3D0, len=3D0)
#     ENQ: 1622324051 s 931416 us (seq=3D29, len=3D10)  (USR +21 us)
#     USR: 1622324051 s 981585 us (seq=3D0, len=3D0)
#     ENQ: 1622324051 s 981619 us (seq=3D39, len=3D10)  (USR +34 us)
#     USR-ENQ: count=3D4, avg=3D40 us, min=3D21 us, max=3D53 us
# test ENQ + SND
#     USR: 1622324052 s 138384 us (seq=3D0, len=3D0)
#     ENQ: 1622324052 s 138425 us (seq=3D9, len=3D10)  (USR +40 us)
#     SND: 1622324052 s 139437 us (seq=3D9, len=3D10)  (USR +1052 us)
#     USR: 1622324052 s 188696 us (seq=3D0, len=3D0)
#     ENQ: 1622324052 s 188729 us (seq=3D19, len=3D10)  (USR +33 us)
#     SND: 1622324052 s 189782 us (seq=3D19, len=3D10)  (USR +1085 us)
#     USR: 1622324052 s 238992 us (seq=3D0, len=3D0)
#     ENQ: 1622324052 s 239054 us (seq=3D29, len=3D10)  (USR +62 us)
#     SND: 1622324052 s 240083 us (seq=3D29, len=3D10)  (USR +1090 us)
#     USR: 1622324052 s 289315 us (seq=3D0, len=3D0)
#     ENQ: 1622324052 s 289364 us (seq=3D39, len=3D10)  (USR +49 us)
#     SND: 1622324052 s 290390 us (seq=3D39, len=3D10)  (USR +1075 us)
#     USR-ENQ: count=3D4, avg=3D46 us, min=3D33 us, max=3D62 us
#     USR-SND: count=3D4, avg=3D1076 us, min=3D1052 us, max=3D1090 us
#=20
# test ACK
#     USR: 1622324052 s 446332 us (seq=3D0, len=3D0)
#     ACK: 1622324052 s 452551 us (seq=3D9, len=3D10)  (USR +6219 us)
#     USR: 1622324052 s 496611 us (seq=3D0, len=3D0)
#     ACK: 1622324052 s 502782 us (seq=3D19, len=3D10)  (USR +6171 us)
#     USR: 1622324052 s 546902 us (seq=3D0, len=3D0)
#     ACK: 1622324052 s 553174 us (seq=3D29, len=3D10)  (USR +6272 us)
#     USR: 1622324052 s 597188 us (seq=3D0, len=3D0)
#     ACK: 1622324052 s 603476 us (seq=3D39, len=3D10)  (USR +6287 us)
#     USR-ACK: count=3D4, avg=3D6237 us, min=3D6171 us, max=3D6287 us
#=20
# test SND + ACK
#     USR: 1622324052 s 754400 us (seq=3D0, len=3D0)
#     SND: 1622324052 s 755434 us (seq=3D9, len=3D10)  (USR +1034 us)
#     ACK: 1622324052 s 760555 us (seq=3D9, len=3D10)  (USR +6155 us)
#     USR: 1622324052 s 804683 us (seq=3D0, len=3D0)
#     SND: 1622324052 s 805747 us (seq=3D19, len=3D10)  (USR +1064 us)
#     ACK: 1622324052 s 810911 us (seq=3D19, len=3D10)  (USR +6227 us)
#     USR: 1622324052 s 855006 us (seq=3D0, len=3D0)
#     SND: 1622324052 s 856081 us (seq=3D29, len=3D10)  (USR +1074 us)
#     ACK: 1622324052 s 861258 us (seq=3D29, len=3D10)  (USR +6251 us)
#     USR: 1622324052 s 905313 us (seq=3D0, len=3D0)
#     SND: 1622324052 s 906380 us (seq=3D39, len=3D10)  (USR +1066 us)
#     ACK: 1622324052 s 911515 us (seq=3D39, len=3D10)  (USR +6202 us)
#     USR-SND: count=3D4, avg=3D1060 us, min=3D1034 us, max=3D1074 us
#     USR-ACK: count=3D4, avg=3D6209 us, min=3D6155 us, max=3D6251 us
#=20
# test ENQ + SND + ACK
#     USR: 1622324053 s 72117 us (seq=3D0, len=3D0)
#     ENQ: 1622324053 s 72150 us (seq=3D9, len=3D10)  (USR +32 us)
#     SND: 1622324053 s 73159 us (seq=3D9, len=3D10)  (USR +1042 us)
# ERROR: 13962 us expected between 6000 and 6500
#     ACK: 1622324053 s 86079 us (seq=3D9, len=3D10)  (USR +13962 us)
#     USR: 1622324053 s 122430 us (seq=3D0, len=3D0)
#     ENQ: 1622324053 s 122476 us (seq=3D19, len=3D10)  (USR +46 us)
#     SND: 1622324053 s 123511 us (seq=3D19, len=3D10)  (USR +1081 us)
# ERROR: 25421 us expected between 6000 and 6500
#     ACK: 1622324053 s 147851 us (seq=3D19, len=3D10)  (USR +25421 us)
#     USR: 1622324053 s 172967 us (seq=3D0, len=3D0)
#     ENQ: 1622324053 s 172989 us (seq=3D29, len=3D10)  (USR +21 us)
#     SND: 1622324053 s 174004 us (seq=3D29, len=3D10)  (USR +1036 us)
#     ACK: 1622324053 s 179098 us (seq=3D29, len=3D10)  (USR +6130 us)
#     USR: 1622324053 s 223166 us (seq=3D0, len=3D0)
#     ENQ: 1622324053 s 223181 us (seq=3D39, len=3D10)  (USR +15 us)
#     SND: 1622324053 s 224194 us (seq=3D39, len=3D10)  (USR +1028 us)
#     ACK: 1622324053 s 229282 us (seq=3D39, len=3D10)  (USR +6115 us)
#     USR-ENQ: count=3D4, avg=3D29 us, min=3D15 us, max=3D46 us
#     USR-SND: count=3D4, avg=3D1047 us, min=3D1028 us, max=3D1081 us
#     USR-ACK: count=3D4, avg=3D12907 us, min=3D6115 us, max=3D25421 us
not ok 40 selftests: net: txtimestamp.sh # exit=3D1
# selftests: net: vrf-xfrm-tests.sh
#=20
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
#=20
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
#=20
# Tests passed:  10
# Tests failed:   4
not ok 41 selftests: net: vrf-xfrm-tests.sh # exit=3D1
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
# FAILURE in testcase 6 over ipv4 sockopts { SO_TIMESTAMPING: { SOF_TIMESTA=
MPING_SOFTWARE |}} expected cmsgs: {}
# Starting testcase 6 over ipv6...
# ./rxtimestamp: Expected swtstamp to not be set.
# FAILURE in testcase 6 over ipv6 sockopts { SO_TIMESTAMPING: { SOF_TIMESTA=
MPING_SOFTWARE |}} expected cmsgs: {}
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
# FAILURE in testcase 6 over ipv4 sockopts { SO_TIMESTAMPING: { SOF_TIMESTA=
MPING_SOFTWARE |}} expected cmsgs: {}
# Starting testcase 6 over ipv6...
# ./rxtimestamp: Expected swtstamp to not be set.
# FAILURE in testcase 6 over ipv6 sockopts { SO_TIMESTAMPING: { SOF_TIMESTA=
MPING_SOFTWARE |}} expected cmsgs: {}
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
# FAILURE in testcase 6 over ipv4 sockopts { SO_TIMESTAMPING: { SOF_TIMESTA=
MPING_SOFTWARE |}} expected cmsgs: {}
# Starting testcase 6 over ipv6...
# ./rxtimestamp: Expected swtstamp to not be set.
# FAILURE in testcase 6 over ipv6 sockopts { SO_TIMESTAMPING: { SOF_TIMESTA=
MPING_SOFTWARE |}} expected cmsgs: {}
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
#     dev =3D list(devs.keys())[0]
# IndexError: list index out of range
not ok 43 selftests: net: devlink_port_split.py # exit=3D1
# selftests: net: drop_monitor_tests.sh
# SKIP: Could not run test without tshark tool
ok 44 selftests: net: drop_monitor_tests.sh # SKIP
# selftests: net: vrf_route_leaking.sh
#=20
# #########################################################################=
##
# IPv4 (sym route): VRF ICMP ttl error route lookup ping
# #########################################################################=
##
#=20
# TEST: Basic IPv4 connectivity                                       [ OK ]
# TEST: Ping received ICMP ttl exceeded                               [ OK ]
#=20
# #########################################################################=
##
# IPv4 (sym route): VRF ICMP error route lookup traceroute
# #########################################################################=
##
#=20
# SKIP: Could not run IPV4 test without traceroute
#=20
# #########################################################################=
##
# IPv4 (sym route): VRF ICMP fragmentation error route lookup ping
# #########################################################################=
##
#=20
# TEST: Basic IPv4 connectivity                                       [ OK ]
# TEST: Ping received ICMP Frag needed                                [ OK ]
#=20
# #########################################################################=
##
# IPv4 (asym route): VRF ICMP ttl error route lookup ping
# #########################################################################=
##
#=20
# TEST: Basic IPv4 connectivity                                       [ OK ]
# TEST: Ping received ICMP ttl exceeded                               [ OK ]
#=20
# #########################################################################=
##
# IPv4 (asym route): VRF ICMP error route lookup traceroute
# #########################################################################=
##
#=20
# SKIP: Could not run IPV4 test without traceroute
#=20
# #########################################################################=
##
# IPv6 (sym route): VRF ICMP ttl error route lookup ping
# #########################################################################=
##
#=20
# TEST: Basic IPv6 connectivity                                       [ OK ]
# TEST: Ping received ICMP Hop limit                                  [ OK ]
#=20
# #########################################################################=
##
# IPv6 (sym route): VRF ICMP error route lookup traceroute
# #########################################################################=
##
#=20
# SKIP: Could not run IPV6 test without traceroute6
#=20
# #########################################################################=
##
# IPv6 (sym route): VRF ICMP fragmentation error route lookup ping
# #########################################################################=
##
#=20
# TEST: Basic IPv6 connectivity                                       [ OK ]
# TEST: Ping received ICMP Packet too big                             [FAIL]
#=20
# #########################################################################=
##
# IPv6 (asym route): VRF ICMP ttl error route lookup ping
# #########################################################################=
##
#=20
# TEST: Basic IPv6 connectivity                                       [ OK ]
# TEST: Ping received ICMP Hop limit                                  [ OK ]
#=20
# #########################################################################=
##
# IPv6 (asym route): VRF ICMP error route lookup traceroute
# #########################################################################=
##
#=20
# SKIP: Could not run IPV6 test without traceroute6
#=20
# Tests passed:  11
# Tests failed:   1
not ok 45 selftests: net: vrf_route_leaking.sh # exit=3D1
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
# #########################################################################=
##
# Unicast address extensions tests (behavior of reserved IPv4 addresses)
# #########################################################################=
##
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
# selftests: net: udpgro_fwd.sh
# IPv4
# ./udpgro_fwd.sh: 90: local: -r: bad variable name
# ./udpgro_fwd.sh: 22: local: -r: bad variable name
not ok 48 selftests: net: udpgro_fwd.sh # exit=3D2
# selftests: net: veth.sh
# Missing xdp_dummy helper. Build bpf selftest first
# ./veth.sh: 111: exit: Illegal number: -1
# ./veth.sh: 21: local: -r: bad variable name
not ok 49 selftests: net: veth.sh # exit=3D2

--3V7upXqbjpZ4EhLz
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
testbox: lkp-skl-nuc2
tbox_group: lkp-skl-nuc2
submit_id: 60ae2c6be66e5ad7efc57475
job_file: "/lkp/jobs/scheduled/lkp-skl-nuc2/kernel-selftests-net-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-020ef930b826d21c5446fdc9db80fd72a791bc21-20210526-55279-lt5pae-0.yaml"
id: 26c54e6b213af6b31271546a1cc3a622eb131d93
queuer_version: "/lkp-src"

#! hosts/lkp-skl-nuc2
model: Skylake
nr_cpu: 8
memory: 32G
nr_sdd_partitions: 1
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSCKKF480H6_CVLY6296001Z480F-part1"
swap_partitions: 
rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSCKKF480H6_CVLY6296001Z480F-part2"
brand: Intel(R) Core(TM) i7-6770HQ CPU @ 2.60GHz

#! include/category/functional
kmsg: 
heartbeat: 
meminfo: 

#! include/queue/cyclic
commit: 020ef930b826d21c5446fdc9db80fd72a791bc21

#! include/testbox/lkp-skl-nuc2
netconsole_port: 6675
ucode: '0xe2'
need_kconfig_hw:
- CONFIG_E1000E=y
- CONFIG_SATA_AHCI

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
enqueue_time: 2021-05-26 19:09:32.100293498 +08:00
_id: 60ae2c6be66e5ad7efc57475
_rt: "/result/kernel-selftests/net-ucode=0xe2/lkp-skl-nuc2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/020ef930b826d21c5446fdc9db80fd72a791bc21"

#! schedule options
user: lkp
compiler: gcc-9
LKP_SERVER: internal-lkp-server
head_commit: 1eba8ced516e7269c5dff393323be7903a791dab
base_commit: c4681547bcce777daf576925a966ffa824edd09d
branch: internal-devel/devel-hourly-20210525-070257
rootfs: debian-10.4-x86_64-20200603.cgz
result_root: "/result/kernel-selftests/net-ucode=0xe2/lkp-skl-nuc2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/020ef930b826d21c5446fdc9db80fd72a791bc21/0"
scheduler_version: "/lkp/lkp/.src-20210526-133529"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-skl-nuc2/kernel-selftests-net-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-020ef930b826d21c5446fdc9db80fd72a791bc21-20210526-55279-lt5pae-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3-kselftests
- branch=internal-devel/devel-hourly-20210525-070257
- commit=020ef930b826d21c5446fdc9db80fd72a791bc21
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/020ef930b826d21c5446fdc9db80fd72a791bc21/vmlinuz-5.12.0-15091-g020ef930b826
- max_uptime=2100
- RESULT_ROOT=/result/kernel-selftests/net-ucode=0xe2/lkp-skl-nuc2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/020ef930b826d21c5446fdc9db80fd72a791bc21/0
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/020ef930b826d21c5446fdc9db80fd72a791bc21/modules.cgz"
linux_headers_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/020ef930b826d21c5446fdc9db80fd72a791bc21/linux-headers.cgz"
linux_selftests_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/020ef930b826d21c5446fdc9db80fd72a791bc21/linux-selftests.cgz"
kselftests_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/020ef930b826d21c5446fdc9db80fd72a791bc21/kselftests.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/kernel-selftests_20210507.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/kernel-selftests-x86_64-0d95472a-1_20210507.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20210222.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20210525-113336/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 5.13.0-rc3-wt-ath-04913-g23e3dcd2c0f0

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/020ef930b826d21c5446fdc9db80fd72a791bc21/vmlinuz-5.12.0-15091-g020ef930b826"
dequeue_time: 2021-05-26 19:12:27.354288803 +08:00

#! /lkp/lkp/.src-20210526-133529/include/site/inn
job_state: finished
loadavg: 0.89 0.77 0.81 1/184 9183
start_time: '1622027751'
end_time: '1622029023'
version: "/lkp/lkp/.src-20210526-133600:04939e1d-dirty:65c2e6d5c"

--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

mount --bind /lib/modules/5.12.0-15091-g020ef930b826/kernel/lib /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-020ef930b826d21c5446fdc9db80fd72a791bc21/lib
sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
sed -i s/default_timeout=45/default_timeout=300/ /kselftests/kselftest/runner.sh
/kselftests/run_kselftest.sh -c net

--3V7upXqbjpZ4EhLz--
