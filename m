Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D0D4346E1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 10:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhJTIah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 04:30:37 -0400
Received: from mga07.intel.com ([134.134.136.100]:21131 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229864AbhJTIaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 04:30:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10142"; a="292188374"
X-IronPort-AV: E=Sophos;i="5.87,166,1631602800"; 
   d="scan'208";a="292188374"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 01:28:17 -0700
X-IronPort-AV: E=Sophos;i="5.87,166,1631602800"; 
   d="scan'208";a="483629458"
Received: from carel.sh.intel.com (HELO linux.intel.com) ([10.239.158.26])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 01:28:16 -0700
Date:   Wed, 20 Oct 2021 16:27:13 +0800
From:   Carel Si <beibei.si@intel.com>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Philip Li <philip.li@intel.com>, Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [LKP] Re: [selftests/tls] e506342a03:
 kernel-selftests.net.tls.fail
Message-ID: <20211020082711.GA17084@linux.intel.com>
References: <20211016135922.GB10051@xsang-OptiPlex-9020>
 <1c328ca1-457f-8946-02f4-09c600685ed4@linux.alibaba.com>
 <YWzhDhWPD5/Bf2Lp@rli9-dbox>
 <c8907aec-de04-fbc0-e186-a4997fea77c9@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8907aec-de04-fbc0-e186-a4997fea77c9@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tianjia,

On Mon, Oct 18, 2021 at 02:44:15PM +0800, Tianjia Zhang wrote:
> Hi Philip,
> 
> On 10/18/21 10:50 AM, Philip Li wrote:
> > On Mon, Oct 18, 2021 at 10:40:13AM +0800, Tianjia Zhang wrote:
> > > Hi,
> > > 
> > > This test needs to enable the SM4 algorithm, and the config file you
> > > provided does not enable this algorithm.
> > thanks for the info, we will recheck this. And how about adding
> > this kconfig requirement to tools/testing/selftests/net/config file?
> > 
> 
> I fixed this problem and sent you an email, thanks for your test.

We tested kselftest net-tls again, all subtests passed, thanks!

> 
> Best regards,
> Tianjia
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org
