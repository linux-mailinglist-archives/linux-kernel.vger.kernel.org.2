Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A3D44E36A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 09:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbhKLIph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 03:45:37 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:4634 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbhKLIpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 03:45:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1636706566; x=1668242566;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z5YT7JwoMnVTlURkFgk//zNhZAPqfJNsg3VO4Kc51N4=;
  b=SGh2/vTlitFEcKYdW5gQn44Qawyf/PZieSW5PgQ8G8HB6e2Sp/MjJrMT
   FxtabEv4dWEEe3eeUXPVPUxn+c6YclPjj0NYWylN6ZuzxckF0iAze59dh
   at0g22k+t5YGYlxEDqpf71oIntMotDbqwEAiNv2+o1c3uTh8/qYweOgwU
   o=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 12 Nov 2021 00:42:45 -0800
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2021 00:42:43 -0800
Received: from jinlmao-gv.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 12 Nov 2021 00:42:38 -0800
Date:   Fri, 12 Nov 2021 16:42:33 +0800
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
Message-ID: <20211112084228.GA24524@jinlmao-gv.ap.qualcomm.com>
References: <1634801936-15080-1-git-send-email-quic_taozha@quicinc.com>
 <1634801936-15080-6-git-send-email-quic_taozha@quicinc.com>
 <20211104180106.GD491267@p14s>
 <20211105082625.GE25738@jinlmao-gv.ap.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211105082625.GE25738@jinlmao-gv.ap.qualcomm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[....]

> >  	&tpdm_attr_grp,
> > > +	&tpdm_bc_attr_grp,
> > 
> > It is quite tedious to review all these options at the same time as the core
> > drivers.  I suggest to concentrate on the base functionality for now.  When that
> > is merged we can add configuration options such as these.
> > 
> > I am out of time for this patchset and as such will not review the remaining
> > patches - those will have to wait for another iteration.
> > 
> > Thanks,
> > Mathieu
> 
> 
> Thank your for all the comments.
> We will update the patches.
> 
> Thanks
> Jinlong Mao 
> 

Hi Mathieu,

We will reduce the code changes.
There will be code changes below for next version:

1. coresight: add support to enable more coresight paths
2. Basic function for TPDM(only enable/disable functions)
3. TPDA driver

Is that ok for your ?

> > 
> > >  	NULL,
> > >  };
> > >  
> > > -- 
> > > 2.17.1
> > > 
