Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3F73B42D7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 14:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhFYMHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 08:07:19 -0400
Received: from mga11.intel.com ([192.55.52.93]:4690 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229712AbhFYMHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 08:07:18 -0400
IronPort-SDR: cGhrQqWhXZU/jHcopf1DyjVet2n0rREfNBrUSfcw4UUW1GL4HYYyNx0J6YAj43q2uOgL+nT//g
 UN5VLTB32LtA==
X-IronPort-AV: E=McAfee;i="6200,9189,10025"; a="204648585"
X-IronPort-AV: E=Sophos;i="5.83,298,1616482800"; 
   d="scan'208";a="204648585"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 05:04:57 -0700
IronPort-SDR: DAF6+CR1DyvSP2HVwrs3aLS+hehpzfNDtjJdkT3sXpO7rqNd6CetVsZctJdgsOuPgm1McTpVfY
 1e6VMHejvUfg==
X-IronPort-AV: E=Sophos;i="5.83,298,1616482800"; 
   d="scan'208";a="455419730"
Received: from slahiri1-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.213.179.195])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 05:04:55 -0700
Message-ID: <6df0600b755ca067a6c4ff82af47297feafa088a.camel@intel.com>
Subject: Re: [PATCH v2] x86/sgx: Add missing xa_destroy() when virtual EPC
 is destroyed
From:   Kai Huang <kai.huang@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, linux-sgx@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, seanjc@google.com,
        dave.hansen@intel.com, tglx@linutronix.de, mingo@redhat.com,
        Yang Zhong <yang.zhong@intel.com>
Date:   Sat, 26 Jun 2021 00:04:53 +1200
In-Reply-To: <YNWR+oSGfulOWziI@zn.tnic>
References: <20210616003634.320206-1-kai.huang@intel.com>
         <20210623132844.heleuoxogrpz3cpm@kernel.org>
         <925090f035b8e749ea7aca8c857690c8afba7349.camel@intel.com>
         <YNWR+oSGfulOWziI@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.1 (3.40.1-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-06-25 at 10:22 +0200, Borislav Petkov wrote:
> On Fri, Jun 25, 2021 at 01:45:35PM +1200, Kai Huang wrote:
> > Should we consider to get this into 5.13, since it is a fix?
> 
> We have considered it, have queued it, you're on Cc on the tip-bot
> notification:
> 
> https://lkml.kernel.org/r/162377378414.19906.6678244614782222506.tip-bot2@tip-bot2
> 
> In the meantime, that fix landed upstream and will be in 5.13:
> 
> 4692bc775d21 ("x86/sgx: Add missing xa_destroy() when virtual EPC is destroyed")
> 

Oh sorry I thought the patch would go via x86/sgx branch, and I didn't monitor
the tip-bot2 mail which was moved to my local x86 folder.  Thanks!

