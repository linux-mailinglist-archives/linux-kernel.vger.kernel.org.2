Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD644365B7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 17:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbhJUPR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 11:17:59 -0400
Received: from mga02.intel.com ([134.134.136.20]:40075 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232125AbhJUPRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 11:17:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10144"; a="216224942"
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="216224942"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 08:14:32 -0700
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="444837642"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.41])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 08:14:29 -0700
Date:   Thu, 21 Oct 2021 23:34:21 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, mptcp@lists.01.org
Subject: Re: [veth]  9d3684c24a: kernel-selftests.net/mptcp.mptcp_join.sh.fail
Message-ID: <20211021153421.GD16330@xsang-OptiPlex-9020>
References: <20210907142758.GD17617@xsang-OptiPlex-9020>
 <ade152d7877b21adfd3b9680d729c185ef701bb9.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ade152d7877b21adfd3b9680d729c185ef701bb9.camel@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paolo Abeni,

On Tue, Sep 07, 2021 at 04:35:47PM +0200, Paolo Abeni wrote:
> Hello,
> 
> On Tue, 2021-09-07 at 22:27 +0800, kernel test robot wrote:
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> It's not entirelly clear to me which are the relevant "changes" ???
> 
> [...]
> 
> > # 36 add multiple addresses IPv6          syn[ ok ] - synack[ ok ] - ack[ ok ]
> > #                                         add[ ok ] - echo  [fail] got 1 ADD_ADDR echo[s] expected 2
> > # 
> > # Server ns stats
> > # MPTcpExtMPCapableSYNRX          1                  0.0
> > # MPTcpExtMPCapableACKRX          1                  0.0
> > # MPTcpExtMPJoinSynRx             2                  0.0
> > # MPTcpExtMPJoinAckRx             2                  0.0
> > # MPTcpExtEchoAdd                 1                  0.0
> > # Client ns stats
> > # MPTcpExtMPCapableSYNTX          1                  0.0
> > # MPTcpExtMPCapableSYNACKRX       1                  0.0
> > # MPTcpExtMPJoinSynAckRx          2                  0.0
> > # MPTcpExtAddAddr                 2                  0.0
> 
> is the referred change is the above self-test failure?
> 
> I belive this is unrelated to the mentioned commit (which behave as no-
> op in this scenario). We are working to make our self-tests as stable
> as possible, but there are still some sporadic failures. 
> 
> I could not reproduce this failure locally.

sorry for late. we tested it again, right, what we captured is just
above failure.
now we found by more runs, we could also reproduce on parent, though
the rate is very low.
at the same time, always fail on this commit.

4752eeb3d891c279 9d3684c24a5232c2d7ea8f8a3e6
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
          1:8          100%           9:10    kernel-selftests.net/mptcp.mptcp_join.sh.fail
          7:8          -88%            :10    kernel-selftests.net/mptcp.mptcp_join.sh.pass


anyway, since reproduced on parent, this seems a false positive.
sorry for inconvenience.

> 
> Cheers,
> 
> Paolo
> 
