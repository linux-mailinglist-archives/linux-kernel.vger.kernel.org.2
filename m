Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957E3430DF9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 04:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345031AbhJRCwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 22:52:31 -0400
Received: from mga12.intel.com ([192.55.52.136]:39004 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235713AbhJRCwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 22:52:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10140"; a="208262398"
X-IronPort-AV: E=Sophos;i="5.85,381,1624345200"; 
   d="scan'208";a="208262398"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2021 19:50:19 -0700
X-IronPort-AV: E=Sophos;i="5.85,381,1624345200"; 
   d="scan'208";a="482546927"
Received: from rli9-dbox.sh.intel.com (HELO rli9-dbox) ([10.239.159.115])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2021 19:50:16 -0700
Date:   Mon, 18 Oct 2021 10:50:54 +0800
From:   Philip Li <philip.li@intel.com>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [selftests/tls] e506342a03: kernel-selftests.net.tls.fail
Message-ID: <YWzhDhWPD5/Bf2Lp@rli9-dbox>
References: <20211016135922.GB10051@xsang-OptiPlex-9020>
 <1c328ca1-457f-8946-02f4-09c600685ed4@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c328ca1-457f-8946-02f4-09c600685ed4@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 10:40:13AM +0800, Tianjia Zhang wrote:
> Hi,
> 
> This test needs to enable the SM4 algorithm, and the config file you
> provided does not enable this algorithm.
thanks for the info, we will recheck this. And how about adding
this kconfig requirement to tools/testing/selftests/net/config file?

> 
> Best regards,
> Tianjia
> 
> On 10/16/21 9:59 PM, kernel test robot wrote:
> > 
> > 
> > Greeting,
> > 
> > FYI, we noticed the following commit (built with gcc-9):
> > 
> > commit: e506342a03c777a8d56389ff2764617648562bcf ("selftests/tls: add SM4 GCM/CCM to tls selftests")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > 
> > 
> > in testcase: kernel-selftests
> > version: kernel-selftests-x86_64-c8c9111a-1_20210929
> > with following parameters:
> > 
> > 	group: net
> > 	test: tls
> > 	ucode: 0xe2
> > 
> > test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
> > test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
> > 
> > 
> > on test machine: 4 threads Intel(R) Xeon(R) CPU E3-1225 v5 @ 3.30GHz with 16G memory
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > 
> > 
> > 
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > 
> > TAP version 13
> > 1..1
> > # selftests: net: tls
> > # TAP version 13
> > # 1..273
> > # # Starting 273 tests from 8 test cases.
> > # #  RUN           global.non_established ...
> > # #            OK  global.non_established
> > # ok 1 global.non_established
> > # #  RUN           global.keysizes ...
> > # #            OK  global.keysizes
> > ...
> > # ok 182 tls.13_chacha.shutdown_unsent
> > # #  RUN           tls.13_chacha.shutdown_reuse ...
> > # #            OK  tls.13_chacha.shutdown_reuse
> > # ok 183 tls.13_chacha.shutdown_reuse
> > # #  RUN           tls.13_sm4_gcm.sendfile ...
> > # # tls.c:239:sendfile:Expected ret (-1) == 0 (0)
> > # # sendfile: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_gcm.sendfile
> > # not ok 184 tls.13_sm4_gcm.sendfile
> > # #  RUN           tls.13_sm4_gcm.send_then_sendfile ...
> > # # tls.c:239:send_then_sendfile:Expected ret (-1) == 0 (0)
> > # # send_then_sendfile: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_gcm.send_then_sendfile
> > # not ok 185 tls.13_sm4_gcm.send_then_sendfile
> > # #  RUN           tls.13_sm4_gcm.multi_chunk_sendfile ...
> > # # tls.c:239:multi_chunk_sendfile:Expected ret (-1) == 0 (0)
> > # # multi_chunk_sendfile: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_gcm.multi_chunk_sendfile
> > # not ok 186 tls.13_sm4_gcm.multi_chunk_sendfile
> > # #  RUN           tls.13_sm4_gcm.recv_max ...
> > # # tls.c:239:recv_max:Expected ret (-1) == 0 (0)
> > # # recv_max: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_gcm.recv_max
> > # not ok 187 tls.13_sm4_gcm.recv_max
> > # #  RUN           tls.13_sm4_gcm.recv_small ...
> > # # tls.c:239:recv_small:Expected ret (-1) == 0 (0)
> > # # recv_small: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_gcm.recv_small
> > # not ok 188 tls.13_sm4_gcm.recv_small
> > # #  RUN           tls.13_sm4_gcm.msg_more ...
> > # # tls.c:239:msg_more:Expected ret (-1) == 0 (0)
> > # # msg_more: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_gcm.msg_more
> > # not ok 189 tls.13_sm4_gcm.msg_more
> > # #  RUN           tls.13_sm4_gcm.msg_more_unsent ...
> > # # tls.c:239:msg_more_unsent:Expected ret (-1) == 0 (0)
> > # # msg_more_unsent: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_gcm.msg_more_unsent
> > # not ok 190 tls.13_sm4_gcm.msg_more_unsent
> > # #  RUN           tls.13_sm4_gcm.sendmsg_single ...
> > # # tls.c:239:sendmsg_single:Expected ret (-1) == 0 (0)
> > # # sendmsg_single: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_gcm.sendmsg_single
> > # not ok 191 tls.13_sm4_gcm.sendmsg_single
> > # #  RUN           tls.13_sm4_gcm.sendmsg_fragmented ...
> > # # tls.c:239:sendmsg_fragmented:Expected ret (-1) == 0 (0)
> > # # sendmsg_fragmented: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_gcm.sendmsg_fragmented
> > # not ok 192 tls.13_sm4_gcm.sendmsg_fragmented
> > # #  RUN           tls.13_sm4_gcm.sendmsg_large ...
> > # # tls.c:239:sendmsg_large:Expected ret (-1) == 0 (0)
> > # # sendmsg_large: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_gcm.sendmsg_large
> > # not ok 193 tls.13_sm4_gcm.sendmsg_large
> > # #  RUN           tls.13_sm4_gcm.sendmsg_multiple ...
> > # # tls.c:239:sendmsg_multiple:Expected ret (-1) == 0 (0)
> > # # sendmsg_multiple: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_gcm.sendmsg_multiple
> > # not ok 194 tls.13_sm4_gcm.sendmsg_multiple
> > # #  RUN           tls.13_sm4_gcm.sendmsg_multiple_stress ...
> > # # tls.c:239:sendmsg_multiple_stress:Expected ret (-1) == 0 (0)
> > # # sendmsg_multiple_stress: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_gcm.sendmsg_multiple_stress
> > # not ok 195 tls.13_sm4_gcm.sendmsg_multiple_stress
> > # #  RUN           tls.13_sm4_gcm.splice_from_pipe ...
> > # # tls.c:239:splice_from_pipe:Expected ret (-1) == 0 (0)
> > # # splice_from_pipe: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_gcm.splice_from_pipe
> > # not ok 196 tls.13_sm4_gcm.splice_from_pipe
> > # #  RUN           tls.13_sm4_gcm.splice_from_pipe2 ...
> > # # tls.c:239:splice_from_pipe2:Expected ret (-1) == 0 (0)
> > # # splice_from_pipe2: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_gcm.splice_from_pipe2
> > # not ok 197 tls.13_sm4_gcm.splice_from_pipe2
> > # #  RUN           tls.13_sm4_gcm.send_and_splice ...
> > # # tls.c:239:send_and_splice:Expected ret (-1) == 0 (0)
> > # # send_and_splice: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_gcm.send_and_splice
> > # not ok 198 tls.13_sm4_gcm.send_and_splice
> > # #  RUN           tls.13_sm4_gcm.splice_to_pipe ...
> > # # tls.c:239:splice_to_pipe:Expected ret (-1) == 0 (0)
> > # # splice_to_pipe: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_gcm.splice_to_pipe
> > # not ok 199 tls.13_sm4_gcm.splice_to_pipe
> > # #  RUN           tls.13_sm4_gcm.recvmsg_single ...
> > # # tls.c:239:recvmsg_single:Expected ret (-1) == 0 (0)
> > # # recvmsg_single: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_gcm.recvmsg_single
> > # not ok 200 tls.13_sm4_gcm.recvmsg_single
> > # #  RUN           tls.13_sm4_gcm.recvmsg_single_max ...
> > # # tls.c:239:recvmsg_single_max:Expected ret (-1) == 0 (0)
> > # # recvmsg_single_max: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_gcm.recvmsg_single_max
> > # not ok 201 tls.13_sm4_gcm.recvmsg_single_max
> > # #  RUN           tls.13_sm4_gcm.recvmsg_multiple ...
> > # # tls.c:239:recvmsg_multiple:Expected ret (-1) == 0 (0)
> > # # recvmsg_multiple: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_gcm.recvmsg_multiple
> > # not ok 202 tls.13_sm4_gcm.recvmsg_multiple
> > # #  RUN           tls.13_sm4_gcm.single_send_multiple_recv ...
> > # # tls.c:239:single_send_multiple_recv:Expected ret (-1) == 0 (0)
> > # # single_send_multiple_recv: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_gcm.single_send_multiple_recv
> > # not ok 203 tls.13_sm4_gcm.single_send_multiple_recv
> > # #  RUN           tls.13_sm4_gcm.multiple_send_single_recv ...
> > # # tls.c:239:multiple_send_single_recv:Expected ret (-1) == 0 (0)
> > # # multiple_send_single_recv: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_gcm.multiple_send_single_recv
> > # not ok 204 tls.13_sm4_gcm.multiple_send_single_recv
> > # #  RUN           tls.13_sm4_gcm.single_send_multiple_recv_non_align ...
> > # # tls.c:239:single_send_multiple_recv_non_align:Expected ret (-1) == 0 (0)
> > # # single_send_multiple_recv_non_align: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_gcm.single_send_multiple_recv_non_align
> > # not ok 205 tls.13_sm4_gcm.single_send_multiple_recv_non_align
> > # #  RUN           tls.13_sm4_gcm.recv_partial ...
> > # # tls.c:239:recv_partial:Expected ret (-1) == 0 (0)
> > # # recv_partial: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_gcm.recv_partial
> > # not ok 206 tls.13_sm4_gcm.recv_partial
> > # #  RUN           tls.13_sm4_gcm.recv_nonblock ...
> > # # tls.c:239:recv_nonblock:Expected ret (-1) == 0 (0)
> > # # recv_nonblock: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_gcm.recv_nonblock
> > # not ok 207 tls.13_sm4_gcm.recv_nonblock
> > # #  RUN           tls.13_sm4_gcm.recv_peek ...
> > # # tls.c:239:recv_peek:Expected ret (-1) == 0 (0)
> > # # recv_peek: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_gcm.recv_peek
> > # not ok 208 tls.13_sm4_gcm.recv_peek
> > # #  RUN           tls.13_sm4_gcm.recv_peek_multiple ...
> > # # tls.c:239:recv_peek_multiple:Expected ret (-1) == 0 (0)
> > # # recv_peek_multiple: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_gcm.recv_peek_multiple
> > # not ok 209 tls.13_sm4_gcm.recv_peek_multiple
> > # #  RUN           tls.13_sm4_gcm.recv_peek_multiple_records ...
> > # # tls.c:239:recv_peek_multiple_records:Expected ret (-1) == 0 (0)
> > # # recv_peek_multiple_records: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_gcm.recv_peek_multiple_records
> > # not ok 210 tls.13_sm4_gcm.recv_peek_multiple_records
> > # #  RUN           tls.13_sm4_gcm.recv_peek_large_buf_mult_recs ...
> > # # tls.c:239:recv_peek_large_buf_mult_recs:Expected ret (-1) == 0 (0)
> > # # recv_peek_large_buf_mult_recs: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_gcm.recv_peek_large_buf_mult_recs
> > # not ok 211 tls.13_sm4_gcm.recv_peek_large_buf_mult_recs
> > # #  RUN           tls.13_sm4_gcm.recv_lowat ...
> > # # tls.c:239:recv_lowat:Expected ret (-1) == 0 (0)
> > # # recv_lowat: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_gcm.recv_lowat
> > # not ok 212 tls.13_sm4_gcm.recv_lowat
> > # #  RUN           tls.13_sm4_gcm.bidir ...
> > # # tls.c:239:bidir:Expected ret (-1) == 0 (0)
> > # # bidir: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_gcm.bidir
> > # not ok 213 tls.13_sm4_gcm.bidir
> > # #  RUN           tls.13_sm4_gcm.pollin ...
> > # # tls.c:239:pollin:Expected ret (-1) == 0 (0)
> > # # pollin: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_gcm.pollin
> > # not ok 214 tls.13_sm4_gcm.pollin
> > # #  RUN           tls.13_sm4_gcm.poll_wait ...
> > # # tls.c:239:poll_wait:Expected ret (-1) == 0 (0)
> > # # poll_wait: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_gcm.poll_wait
> > # not ok 215 tls.13_sm4_gcm.poll_wait
> > # #  RUN           tls.13_sm4_gcm.poll_wait_split ...
> > # # tls.c:239:poll_wait_split:Expected ret (-1) == 0 (0)
> > # # poll_wait_split: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_gcm.poll_wait_split
> > # not ok 216 tls.13_sm4_gcm.poll_wait_split
> > # #  RUN           tls.13_sm4_gcm.blocking ...
> > # # tls.c:239:blocking:Expected ret (-1) == 0 (0)
> > # # blocking: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_gcm.blocking
> > # not ok 217 tls.13_sm4_gcm.blocking
> > # #  RUN           tls.13_sm4_gcm.nonblocking ...
> > # # tls.c:239:nonblocking:Expected ret (-1) == 0 (0)
> > # # nonblocking: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_gcm.nonblocking
> > # not ok 218 tls.13_sm4_gcm.nonblocking
> > # #  RUN           tls.13_sm4_gcm.mutliproc_even ...
> > # # tls.c:239:mutliproc_even:Expected ret (-1) == 0 (0)
> > # # mutliproc_even: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_gcm.mutliproc_even
> > # not ok 219 tls.13_sm4_gcm.mutliproc_even
> > # #  RUN           tls.13_sm4_gcm.mutliproc_readers ...
> > # # tls.c:239:mutliproc_readers:Expected ret (-1) == 0 (0)
> > # # mutliproc_readers: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_gcm.mutliproc_readers
> > # not ok 220 tls.13_sm4_gcm.mutliproc_readers
> > # #  RUN           tls.13_sm4_gcm.mutliproc_writers ...
> > # # tls.c:239:mutliproc_writers:Expected ret (-1) == 0 (0)
> > # # mutliproc_writers: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_gcm.mutliproc_writers
> > # not ok 221 tls.13_sm4_gcm.mutliproc_writers
> > # #  RUN           tls.13_sm4_gcm.mutliproc_sendpage_even ...
> > # # tls.c:239:mutliproc_sendpage_even:Expected ret (-1) == 0 (0)
> > # # mutliproc_sendpage_even: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_gcm.mutliproc_sendpage_even
> > # not ok 222 tls.13_sm4_gcm.mutliproc_sendpage_even
> > # #  RUN           tls.13_sm4_gcm.mutliproc_sendpage_readers ...
> > # # tls.c:239:mutliproc_sendpage_readers:Expected ret (-1) == 0 (0)
> > # # mutliproc_sendpage_readers: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_gcm.mutliproc_sendpage_readers
> > # not ok 223 tls.13_sm4_gcm.mutliproc_sendpage_readers
> > # #  RUN           tls.13_sm4_gcm.mutliproc_sendpage_writers ...
> > # # tls.c:239:mutliproc_sendpage_writers:Expected ret (-1) == 0 (0)
> > # # mutliproc_sendpage_writers: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_gcm.mutliproc_sendpage_writers
> > # not ok 224 tls.13_sm4_gcm.mutliproc_sendpage_writers
> > # #  RUN           tls.13_sm4_gcm.control_msg ...
> > # # tls.c:239:control_msg:Expected ret (-1) == 0 (0)
> > # # control_msg: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_gcm.control_msg
> > # not ok 225 tls.13_sm4_gcm.control_msg
> > # #  RUN           tls.13_sm4_gcm.shutdown ...
> > # # tls.c:239:shutdown:Expected ret (-1) == 0 (0)
> > # # shutdown: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_gcm.shutdown
> > # not ok 226 tls.13_sm4_gcm.shutdown
> > # #  RUN           tls.13_sm4_gcm.shutdown_unsent ...
> > # # tls.c:239:shutdown_unsent:Expected ret (-1) == 0 (0)
> > # # shutdown_unsent: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_gcm.shutdown_unsent
> > # not ok 227 tls.13_sm4_gcm.shutdown_unsent
> > # #  RUN           tls.13_sm4_gcm.shutdown_reuse ...
> > # # tls.c:239:shutdown_reuse:Expected ret (-1) == 0 (0)
> > # # shutdown_reuse: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_gcm.shutdown_reuse
> > # not ok 228 tls.13_sm4_gcm.shutdown_reuse
> > # #  RUN           tls.13_sm4_ccm.sendfile ...
> > # # tls.c:239:sendfile:Expected ret (-1) == 0 (0)
> > # # sendfile: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_ccm.sendfile
> > # not ok 229 tls.13_sm4_ccm.sendfile
> > # #  RUN           tls.13_sm4_ccm.send_then_sendfile ...
> > # # tls.c:239:send_then_sendfile:Expected ret (-1) == 0 (0)
> > # # send_then_sendfile: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_ccm.send_then_sendfile
> > # not ok 230 tls.13_sm4_ccm.send_then_sendfile
> > # #  RUN           tls.13_sm4_ccm.multi_chunk_sendfile ...
> > # # tls.c:239:multi_chunk_sendfile:Expected ret (-1) == 0 (0)
> > # # multi_chunk_sendfile: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_ccm.multi_chunk_sendfile
> > # not ok 231 tls.13_sm4_ccm.multi_chunk_sendfile
> > # #  RUN           tls.13_sm4_ccm.recv_max ...
> > # # tls.c:239:recv_max:Expected ret (-1) == 0 (0)
> > # # recv_max: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_ccm.recv_max
> > # not ok 232 tls.13_sm4_ccm.recv_max
> > # #  RUN           tls.13_sm4_ccm.recv_small ...
> > # # tls.c:239:recv_small:Expected ret (-1) == 0 (0)
> > # # recv_small: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_ccm.recv_small
> > # not ok 233 tls.13_sm4_ccm.recv_small
> > # #  RUN           tls.13_sm4_ccm.msg_more ...
> > # # tls.c:239:msg_more:Expected ret (-1) == 0 (0)
> > # # msg_more: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_ccm.msg_more
> > # not ok 234 tls.13_sm4_ccm.msg_more
> > # #  RUN           tls.13_sm4_ccm.msg_more_unsent ...
> > # # tls.c:239:msg_more_unsent:Expected ret (-1) == 0 (0)
> > # # msg_more_unsent: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_ccm.msg_more_unsent
> > # not ok 235 tls.13_sm4_ccm.msg_more_unsent
> > # #  RUN           tls.13_sm4_ccm.sendmsg_single ...
> > # # tls.c:239:sendmsg_single:Expected ret (-1) == 0 (0)
> > # # sendmsg_single: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_ccm.sendmsg_single
> > # not ok 236 tls.13_sm4_ccm.sendmsg_single
> > # #  RUN           tls.13_sm4_ccm.sendmsg_fragmented ...
> > # # tls.c:239:sendmsg_fragmented:Expected ret (-1) == 0 (0)
> > # # sendmsg_fragmented: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_ccm.sendmsg_fragmented
> > # not ok 237 tls.13_sm4_ccm.sendmsg_fragmented
> > # #  RUN           tls.13_sm4_ccm.sendmsg_large ...
> > # # tls.c:239:sendmsg_large:Expected ret (-1) == 0 (0)
> > # # sendmsg_large: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_ccm.sendmsg_large
> > # not ok 238 tls.13_sm4_ccm.sendmsg_large
> > # #  RUN           tls.13_sm4_ccm.sendmsg_multiple ...
> > # # tls.c:239:sendmsg_multiple:Expected ret (-1) == 0 (0)
> > # # sendmsg_multiple: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_ccm.sendmsg_multiple
> > # not ok 239 tls.13_sm4_ccm.sendmsg_multiple
> > # #  RUN           tls.13_sm4_ccm.sendmsg_multiple_stress ...
> > # # tls.c:239:sendmsg_multiple_stress:Expected ret (-1) == 0 (0)
> > # # sendmsg_multiple_stress: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_ccm.sendmsg_multiple_stress
> > # not ok 240 tls.13_sm4_ccm.sendmsg_multiple_stress
> > # #  RUN           tls.13_sm4_ccm.splice_from_pipe ...
> > # # tls.c:239:splice_from_pipe:Expected ret (-1) == 0 (0)
> > # # splice_from_pipe: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_ccm.splice_from_pipe
> > # not ok 241 tls.13_sm4_ccm.splice_from_pipe
> > # #  RUN           tls.13_sm4_ccm.splice_from_pipe2 ...
> > # # tls.c:239:splice_from_pipe2:Expected ret (-1) == 0 (0)
> > # # splice_from_pipe2: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_ccm.splice_from_pipe2
> > # not ok 242 tls.13_sm4_ccm.splice_from_pipe2
> > # #  RUN           tls.13_sm4_ccm.send_and_splice ...
> > # # tls.c:239:send_and_splice:Expected ret (-1) == 0 (0)
> > # # send_and_splice: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_ccm.send_and_splice
> > # not ok 243 tls.13_sm4_ccm.send_and_splice
> > # #  RUN           tls.13_sm4_ccm.splice_to_pipe ...
> > # # tls.c:239:splice_to_pipe:Expected ret (-1) == 0 (0)
> > # # splice_to_pipe: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_ccm.splice_to_pipe
> > # not ok 244 tls.13_sm4_ccm.splice_to_pipe
> > # #  RUN           tls.13_sm4_ccm.recvmsg_single ...
> > # # tls.c:239:recvmsg_single:Expected ret (-1) == 0 (0)
> > # # recvmsg_single: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_ccm.recvmsg_single
> > # not ok 245 tls.13_sm4_ccm.recvmsg_single
> > # #  RUN           tls.13_sm4_ccm.recvmsg_single_max ...
> > # # tls.c:239:recvmsg_single_max:Expected ret (-1) == 0 (0)
> > # # recvmsg_single_max: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_ccm.recvmsg_single_max
> > # not ok 246 tls.13_sm4_ccm.recvmsg_single_max
> > # #  RUN           tls.13_sm4_ccm.recvmsg_multiple ...
> > # # tls.c:239:recvmsg_multiple:Expected ret (-1) == 0 (0)
> > # # recvmsg_multiple: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_ccm.recvmsg_multiple
> > # not ok 247 tls.13_sm4_ccm.recvmsg_multiple
> > # #  RUN           tls.13_sm4_ccm.single_send_multiple_recv ...
> > # # tls.c:239:single_send_multiple_recv:Expected ret (-1) == 0 (0)
> > # # single_send_multiple_recv: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_ccm.single_send_multiple_recv
> > # not ok 248 tls.13_sm4_ccm.single_send_multiple_recv
> > # #  RUN           tls.13_sm4_ccm.multiple_send_single_recv ...
> > # # tls.c:239:multiple_send_single_recv:Expected ret (-1) == 0 (0)
> > # # multiple_send_single_recv: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_ccm.multiple_send_single_recv
> > # not ok 249 tls.13_sm4_ccm.multiple_send_single_recv
> > # #  RUN           tls.13_sm4_ccm.single_send_multiple_recv_non_align ...
> > # # tls.c:239:single_send_multiple_recv_non_align:Expected ret (-1) == 0 (0)
> > # # single_send_multiple_recv_non_align: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_ccm.single_send_multiple_recv_non_align
> > # not ok 250 tls.13_sm4_ccm.single_send_multiple_recv_non_align
> > # #  RUN           tls.13_sm4_ccm.recv_partial ...
> > # # tls.c:239:recv_partial:Expected ret (-1) == 0 (0)
> > # # recv_partial: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_ccm.recv_partial
> > # not ok 251 tls.13_sm4_ccm.recv_partial
> > # #  RUN           tls.13_sm4_ccm.recv_nonblock ...
> > # # tls.c:239:recv_nonblock:Expected ret (-1) == 0 (0)
> > # # recv_nonblock: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_ccm.recv_nonblock
> > # not ok 252 tls.13_sm4_ccm.recv_nonblock
> > # #  RUN           tls.13_sm4_ccm.recv_peek ...
> > # # tls.c:239:recv_peek:Expected ret (-1) == 0 (0)
> > # # recv_peek: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_ccm.recv_peek
> > # not ok 253 tls.13_sm4_ccm.recv_peek
> > # #  RUN           tls.13_sm4_ccm.recv_peek_multiple ...
> > # # tls.c:239:recv_peek_multiple:Expected ret (-1) == 0 (0)
> > # # recv_peek_multiple: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_ccm.recv_peek_multiple
> > # not ok 254 tls.13_sm4_ccm.recv_peek_multiple
> > # #  RUN           tls.13_sm4_ccm.recv_peek_multiple_records ...
> > # # tls.c:239:recv_peek_multiple_records:Expected ret (-1) == 0 (0)
> > # # recv_peek_multiple_records: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_ccm.recv_peek_multiple_records
> > # not ok 255 tls.13_sm4_ccm.recv_peek_multiple_records
> > # #  RUN           tls.13_sm4_ccm.recv_peek_large_buf_mult_recs ...
> > # # tls.c:239:recv_peek_large_buf_mult_recs:Expected ret (-1) == 0 (0)
> > # # recv_peek_large_buf_mult_recs: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_ccm.recv_peek_large_buf_mult_recs
> > # not ok 256 tls.13_sm4_ccm.recv_peek_large_buf_mult_recs
> > # #  RUN           tls.13_sm4_ccm.recv_lowat ...
> > # # tls.c:239:recv_lowat:Expected ret (-1) == 0 (0)
> > # # recv_lowat: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_ccm.recv_lowat
> > # not ok 257 tls.13_sm4_ccm.recv_lowat
> > # #  RUN           tls.13_sm4_ccm.bidir ...
> > # # tls.c:239:bidir:Expected ret (-1) == 0 (0)
> > # # bidir: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_ccm.bidir
> > # not ok 258 tls.13_sm4_ccm.bidir
> > # #  RUN           tls.13_sm4_ccm.pollin ...
> > # # tls.c:239:pollin:Expected ret (-1) == 0 (0)
> > # # pollin: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_ccm.pollin
> > # not ok 259 tls.13_sm4_ccm.pollin
> > # #  RUN           tls.13_sm4_ccm.poll_wait ...
> > # # tls.c:239:poll_wait:Expected ret (-1) == 0 (0)
> > # # poll_wait: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_ccm.poll_wait
> > # not ok 260 tls.13_sm4_ccm.poll_wait
> > # #  RUN           tls.13_sm4_ccm.poll_wait_split ...
> > # # tls.c:239:poll_wait_split:Expected ret (-1) == 0 (0)
> > # # poll_wait_split: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_ccm.poll_wait_split
> > # not ok 261 tls.13_sm4_ccm.poll_wait_split
> > # #  RUN           tls.13_sm4_ccm.blocking ...
> > # # tls.c:239:blocking:Expected ret (-1) == 0 (0)
> > # # blocking: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_ccm.blocking
> > # not ok 262 tls.13_sm4_ccm.blocking
> > # #  RUN           tls.13_sm4_ccm.nonblocking ...
> > # # tls.c:239:nonblocking:Expected ret (-1) == 0 (0)
> > # # nonblocking: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_ccm.nonblocking
> > # not ok 263 tls.13_sm4_ccm.nonblocking
> > # #  RUN           tls.13_sm4_ccm.mutliproc_even ...
> > # # tls.c:239:mutliproc_even:Expected ret (-1) == 0 (0)
> > # # mutliproc_even: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_ccm.mutliproc_even
> > # not ok 264 tls.13_sm4_ccm.mutliproc_even
> > # #  RUN           tls.13_sm4_ccm.mutliproc_readers ...
> > # # tls.c:239:mutliproc_readers:Expected ret (-1) == 0 (0)
> > # # mutliproc_readers: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_ccm.mutliproc_readers
> > # not ok 265 tls.13_sm4_ccm.mutliproc_readers
> > # #  RUN           tls.13_sm4_ccm.mutliproc_writers ...
> > # # tls.c:239:mutliproc_writers:Expected ret (-1) == 0 (0)
> > # # mutliproc_writers: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_ccm.mutliproc_writers
> > # not ok 266 tls.13_sm4_ccm.mutliproc_writers
> > # #  RUN           tls.13_sm4_ccm.mutliproc_sendpage_even ...
> > # # tls.c:239:mutliproc_sendpage_even:Expected ret (-1) == 0 (0)
> > # # mutliproc_sendpage_even: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_ccm.mutliproc_sendpage_even
> > # not ok 267 tls.13_sm4_ccm.mutliproc_sendpage_even
> > # #  RUN           tls.13_sm4_ccm.mutliproc_sendpage_readers ...
> > # # tls.c:239:mutliproc_sendpage_readers:Expected ret (-1) == 0 (0)
> > # # mutliproc_sendpage_readers: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_ccm.mutliproc_sendpage_readers
> > # not ok 268 tls.13_sm4_ccm.mutliproc_sendpage_readers
> > # #  RUN           tls.13_sm4_ccm.mutliproc_sendpage_writers ...
> > # # tls.c:239:mutliproc_sendpage_writers:Expected ret (-1) == 0 (0)
> > # # mutliproc_sendpage_writers: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_ccm.mutliproc_sendpage_writers
> > # not ok 269 tls.13_sm4_ccm.mutliproc_sendpage_writers
> > # #  RUN           tls.13_sm4_ccm.control_msg ...
> > # # tls.c:239:control_msg:Expected ret (-1) == 0 (0)
> > # # control_msg: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_ccm.control_msg
> > # not ok 270 tls.13_sm4_ccm.control_msg
> > # #  RUN           tls.13_sm4_ccm.shutdown ...
> > # # tls.c:239:shutdown:Expected ret (-1) == 0 (0)
> > # # shutdown: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_ccm.shutdown
> > # not ok 271 tls.13_sm4_ccm.shutdown
> > # #  RUN           tls.13_sm4_ccm.shutdown_unsent ...
> > # # tls.c:239:shutdown_unsent:Expected ret (-1) == 0 (0)
> > # # shutdown_unsent: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_ccm.shutdown_unsent
> > # not ok 272 tls.13_sm4_ccm.shutdown_unsent
> > # #  RUN           tls.13_sm4_ccm.shutdown_reuse ...
> > # # tls.c:239:shutdown_reuse:Expected ret (-1) == 0 (0)
> > # # shutdown_reuse: Test terminated by assertion
> > # #          FAIL  tls.13_sm4_ccm.shutdown_reuse
> > # not ok 273 tls.13_sm4_ccm.shutdown_reuse
> > # # FAILED: 183 / 273 tests passed.
> > # # Totals: pass:183 fail:90 xfail:0 xpass:0 skip:0 error:0
> > not ok 1 selftests: net: tls # exit=1
> > 
> > 
> > 
> > To reproduce:
> > 
> >          git clone https://github.com/intel/lkp-tests.git
> >          cd lkp-tests
> >          sudo bin/lkp install job.yaml           # job file is attached in this email
> >          bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
> >          sudo bin/lkp run generated-yaml-file
> > 
> >          # if come across any failure that blocks the test,
> >          # please remove ~/.lkp and /lkp dir to run from a clean state.
> > 
> > 
> > 
> > ---
> > 0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
> > https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation
> > 
> > Thanks,
> > Oliver Sang
> > 
