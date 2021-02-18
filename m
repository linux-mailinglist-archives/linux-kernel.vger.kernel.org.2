Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614D731EB9E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 16:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbhBRPh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 10:37:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:56116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230212AbhBRNVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 08:21:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A296064E28;
        Thu, 18 Feb 2021 13:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613653783;
        bh=gfYkmkhLZG1sHJLvYtToiSD0wlhkavd6f//Yy/6TLvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R6s7V5LwvH+km1pA7RyhI+AuhuJ5D5On9paZo/nMh8hyB7A8eojYr4WTu/1ysVgIj
         S0ry2RLprtvyR0VkB++zDyGrFQcrxX7x7XvCilQxoNT7HnrEnlKxOiFEzcA8XVA5Mf
         NJRedGAHD7OFWqWzITcr3GCH6iKFvhrHNaDULf22/46kMQMTv9NVM8VZpJC+EZp8L5
         oPCfhoeGeA2yQExdDlucxBu8beUG6D/WtHfCNDOljEqI14AcIe2vXmU81PIRTNypum
         aFnk1U5tmoxMW5b6ZZmgrDEoPAzsbnhjE3KpmuK9Zumwhs2meL1p/K0F1HmHW6R0rl
         gj9uLdfrVNBqw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6FE3A40CD9; Thu, 18 Feb 2021 10:09:41 -0300 (-03)
Date:   Thu, 18 Feb 2021 10:09:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     John Garry <john.garry@huawei.com>,
        "will@kernel.org" <will@kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kjain@linux.ibm.com" <kjain@linux.ibm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 0/4] tools: perf: Add JSON metrics for i.MX8M platforms
Message-ID: <YC5nFfHJkJER8cP8@kernel.org>
References: <20210127105734.12198-1-qiangqing.zhang@nxp.com>
 <83775741-8b38-0182-38af-71c60cee1292@huawei.com>
 <DB8PR04MB67955CC8940C664F4F609690E6859@DB8PR04MB6795.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB8PR04MB67955CC8940C664F4F609690E6859@DB8PR04MB6795.eurprd04.prod.outlook.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 18, 2021 at 10:14:29AM +0000, Joakim Zhang escreveu:
> 
> Gentle pinging...

Thanks, applied.

- Arnaldo

 
> Best Regards,
> Joakim Zhang
> 
> > -----Original Message-----
> > From: John Garry <john.garry@huawei.com>
> > Sent: 2021年1月27日 22:14
> > To: Joakim Zhang <qiangqing.zhang@nxp.com>; will@kernel.org;
> > mathieu.poirier@linaro.org; leo.yan@linaro.org; peterz@infradead.org;
> > mingo@redhat.com; acme@kernel.org; mark.rutland@arm.com;
> > alexander.shishkin@linux.intel.com; jolsa@redhat.com;
> > namhyung@kernel.org; shawnguo@kernel.org; s.hauer@pengutronix.de
> > Cc: kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx
> > <linux-imx@nxp.com>; kjain@linux.ibm.com;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH V3 0/4] tools: perf: Add JSON metrics for i.MX8M
> > platforms
> > 
> > On 27/01/2021 10:57, Joakim Zhang wrote:
> > > Add JSON metrics for i.MX8M platforms.
> > >
> > > ChangeLogs:
> > > V1->V2:
> > > 	* remove board level metrics (bandwidth metrics).
> > > V2->V3:
> > > 	* Add the missing "ScaleUnit".
> > >
> > > Joakim Zhang (4):
> > >    perf vendor events: Fix indentation of brackets in imx8mm metrics
> > >    perf vendor events: Add JSON metrics for imx8mn DDR Perf
> > >    perf vendor events: Add JSON metrics for imx8mq DDR Perf
> > >    perf vendor events: Add JSON metrics for imx8mp DDR Perf
> > 
> > For the series:
> > Reviewed-by: John Garry <john.garry@huawei.com>

-- 

- Arnaldo
