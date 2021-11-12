Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA1C44E3A6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 10:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbhKLJNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 04:13:39 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:16696 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbhKLJNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 04:13:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1636708246; x=1668244246;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nBm8KL50rPBclGGcQhaFKFJmx/7KYwhmoc+YLXPGjzI=;
  b=YWPOe6nT5G4pKGiMXDRydsk6ieIEu9XD663dmde6TzYKQ+mWxNX2Y6gK
   5Ns4EL4v7lrWhVhUEwcfdhsDbZWMjUOqhvv54WuY4vVFnIEueujMkcY2S
   Psnwa8FqX108eEQk0xcQ2WeCRnb3bPmdYJvPTJHqhWRMq1MVENhgr1pq2
   4=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 12 Nov 2021 01:10:46 -0800
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2021 01:10:45 -0800
Received: from jinlmao-gv.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 12 Nov 2021 01:10:42 -0800
Date:   Fri, 12 Nov 2021 17:10:38 +0800
From:   Jinlong <quic_jinlmao@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Tao Zhang <quic_taozha@quicinc.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        "Leo Yan" <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>
Subject: Re: [PATCH 05/10] Coresight: Add interface for TPDM BC subunit
Message-ID: <20211112091034.GA28079@jinlmao-gv.ap.qualcomm.com>
References: <1634801936-15080-1-git-send-email-quic_taozha@quicinc.com>
 <1634801936-15080-6-git-send-email-quic_taozha@quicinc.com>
 <20211104180106.GD491267@p14s>
 <20211105082625.GE25738@jinlmao-gv.ap.qualcomm.com>
 <20211112084228.GA24524@jinlmao-gv.ap.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211112084228.GA24524@jinlmao-gv.ap.qualcomm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 04:42:31PM +0800, Jinlong wrote:
> [....]
> 
> > >  	&tpdm_attr_grp,
> > > > +	&tpdm_bc_attr_grp,
> > > 
> > > It is quite tedious to review all these options at the same time as the core
> > > drivers.  I suggest to concentrate on the base functionality for now.  When that
> > > is merged we can add configuration options such as these.
> > > 
> > > I am out of time for this patchset and as such will not review the remaining
> > > patches - those will have to wait for another iteration.
> > > 
> > > Thanks,
> > > Mathieu
> > 
> > 
> > Thank your for all the comments.
> > We will update the patches.
> > 
> > Thanks
> > Jinlong Mao 
> > 
>

Correct the typo.

 Hi Mathieu,
 
 We will reduce the code changes.
 There will be code changes below for next version:
 
 1. coresight: add support to enable more coresight paths
 2. Basic function for TPDM(only enable/disable functions)
 3. TPDA driver
 
 Is that ok for you ?
> 
> > > 
> > > >  	NULL,
> > > >  };
> > > >  
> > > > -- 
> > > > 2.17.1
> > > > 
