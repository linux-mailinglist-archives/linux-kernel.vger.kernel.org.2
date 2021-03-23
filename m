Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6A83461B5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 15:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbhCWOpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 10:45:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:24410 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232272AbhCWOom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 10:44:42 -0400
IronPort-SDR: e7vIaYgQkYeu4XopdFj5IWReMoeLCzYWdX2+xNUt4qoEeEghJn+rr8OvZS3wQzfLRG6/4j8Z6r
 4dfa8bAGQM/w==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="177613466"
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="scan'208";a="177613466"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 07:44:34 -0700
IronPort-SDR: Qbg4TbCdz3qTmD41A4pi6lDDlNVPckD8Tw3EY5/45peH8XlYeYaYR9diw+EC8JLOwhRmLTxrAz
 PiRBxjzbT5CA==
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="scan'208";a="415017430"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 07:44:29 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 23 Mar 2021 16:44:26 +0200
Date:   Tue, 23 Mar 2021 16:44:26 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     lyl2019@mail.ustc.edu.cn
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] thunderbolt: Fix a double put in tb_cfg_read_raw
Message-ID: <20210323144426.GY2542@lahna.fi.intel.com>
References: <20210323031512.12234-1-lyl2019@mail.ustc.edu.cn>
 <20210323140647.GV2542@lahna.fi.intel.com>
 <4ff4aeb5.e6c7.1785f7e4edc.Coremail.lyl2019@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ff4aeb5.e6c7.1785f7e4edc.Coremail.lyl2019@mail.ustc.edu.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 10:30:16PM +0800, lyl2019@mail.ustc.edu.cn wrote:
> 
> 
> 
> > -----原始邮件-----
> > 发件人: "Mika Westerberg" <mika.westerberg@linux.intel.com>
> > 发送时间: 2021-03-23 22:06:47 (星期二)
> > 收件人: "Lv Yunlong" <lyl2019@mail.ustc.edu.cn>
> > 抄送: andreas.noever@gmail.com, michael.jamet@intel.com, YehezkelShB@gmail.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
> > 主题: Re: [PATCH] thunderbolt: Fix a double put in tb_cfg_read_raw
> > 
> > Hi,
> > 
> > On Mon, Mar 22, 2021 at 08:15:12PM -0700, Lv Yunlong wrote:
> > > In tb_cfg_read_raw, req is allocated by tb_cfg_request_alloc()
> > > with an initial reference. Before calling tb_cfg_request_sync(),
> > > there is no refcount inc operation. tb_cfg_request_sync()
> > > calls tb_cfg_request(..,req,..) and if the callee failed,
> > > the initial reference of req is dropped and req is freed.
> > > 
> > > Later in tb_cfg_read_raw before the err check,
> > > tb_cfg_request_put(req) is called again. It may cause error
> > > in race.
> > 
> > Hmm, tb_cfg_request() does tb_cfg_request_get() too and in case of error
> > it does tb_cfg_request_put(). So the refcount should be fine. What am I
> > missing?
> > 
> > > 
> > > My patch puts tb_cfg_request_put(req) after the err check
> > > finished to avoid unexpected result.
> > > 
> > > Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> > > ---
> > >  drivers/thunderbolt/ctl.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/thunderbolt/ctl.c b/drivers/thunderbolt/ctl.c
> > > index f1aeaff9f368..bb60269c89ab 100644
> > > --- a/drivers/thunderbolt/ctl.c
> > > +++ b/drivers/thunderbolt/ctl.c
> > > @@ -890,11 +890,11 @@ struct tb_cfg_result tb_cfg_read_raw(struct tb_ctl *ctl, void *buffer,
> > >  
> > >  		res = tb_cfg_request_sync(ctl, req, timeout_msec);
> > >  
> > > -		tb_cfg_request_put(req);
> > > -
> > >  		if (res.err != -ETIMEDOUT)
> > >  			break;
> > >  
> > > +		tb_cfg_request_put(req);
> > > +
> > >  		/* Wait a bit (arbitrary time) until we send a retry */
> > >  		usleep_range(10, 100);
> > >  	}
> > > -- 
> > > 2.25.1
> > > 
> 
> I'm very sorry, i was ashamed that i had missed the tb_cfg_request_get() in tb_cfg_request().

It happens, no worries :)
