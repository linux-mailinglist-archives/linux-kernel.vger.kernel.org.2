Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E19932C974
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 02:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356018AbhCDBEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 20:04:00 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:10467 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348096AbhCDA1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:27:40 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614817639; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=DQuJwU+yBVNVJcwr5yhLqN2EijKkTbjs9TDNvZZto8Q=;
 b=gcu3zBEL6r6gk9Q1jTPKeBaVVcGqeeV333MUWH3X1ZFIzqibiWJNmRdvcy0JSGIVKYhbaOQ4
 Fnz8hZ5SJIdPHrFm/TMugFAoKx/F5g3RV+MQvEp/8tWWb2W6vX/v9oXfqLmNbH7OdZiLvwXk
 7QNE/hFVPStUKVdRAG9o6jqaTZg=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 6040294acb774affa9819efa (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 04 Mar 2021 00:26:50
 GMT
Sender: abhinavk=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4B1ABC53835; Thu,  4 Mar 2021 00:26:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: abhinavk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DC6DEC53834;
        Thu,  4 Mar 2021 00:26:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 03 Mar 2021 16:26:47 -0800
From:   abhinavk@codeaurora.org
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, Chandan Uddaraju <chandanu@codeaurora.org>,
        lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Vara Reddy <varar@codeaurora.org>,
        Tanmay Shah <tanmay@codeaurora.org>,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        Guenter Roeck <groeck@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: drivers/gpu/drm/msm/dp/dp_hpd.c:37 dp_hpd_connect() error: we
 previously assumed 'hpd_priv->dp_cb' could be null (see line 37)
In-Reply-To: <20210301070235.GM2087@kadam>
References: <20210301070235.GM2087@kadam>
Message-ID: <3e209334ecda37998ba7bc0982b1a463@codeaurora.org>
X-Sender: abhinavk@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan

Thanks for reporting this, will submit a change to fix this.

Abhinav

On 2021-02-28 23:02, Dan Carpenter wrote:
> tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> master
> head:   fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8
> commit: c943b4948b5848fc0e07f875edbd35a973879e22 drm/msm/dp: add
> displayPort driver support
> config: arm64-randconfig-m031-20210301 (attached as .config)
> compiler: aarch64-linux-gcc (GCC) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> drivers/gpu/drm/msm/dp/dp_hpd.c:37 dp_hpd_connect() error: we
> previously assumed 'hpd_priv->dp_cb' could be null (see line 37)
> drivers/gpu/drm/msm/dp/dp_power.c:203 dp_power_clk_enable() warn:
> inconsistent indenting
> 
> vim +37 drivers/gpu/drm/msm/dp/dp_hpd.c
> 
> c943b4948b5848 Chandan Uddaraju 2020-08-27  27  static int
> dp_hpd_connect(struct dp_usbpd *dp_usbpd, bool hpd)
> c943b4948b5848 Chandan Uddaraju 2020-08-27  28  {
> c943b4948b5848 Chandan Uddaraju 2020-08-27  29  	int rc = 0;
> c943b4948b5848 Chandan Uddaraju 2020-08-27  30  	struct dp_hpd_private
> *hpd_priv;
> c943b4948b5848 Chandan Uddaraju 2020-08-27  31
> c943b4948b5848 Chandan Uddaraju 2020-08-27  32  	hpd_priv =
> container_of(dp_usbpd, struct dp_hpd_private,
> c943b4948b5848 Chandan Uddaraju 2020-08-27  33  					dp_usbpd);
> c943b4948b5848 Chandan Uddaraju 2020-08-27  34
> c943b4948b5848 Chandan Uddaraju 2020-08-27  35  	dp_usbpd->hpd_high = 
> hpd;
> c943b4948b5848 Chandan Uddaraju 2020-08-27  36
> c943b4948b5848 Chandan Uddaraju 2020-08-27 @37  	if (!hpd_priv->dp_cb
> && !hpd_priv->dp_cb->configure
> 
> ^^^^^^^^^^^^^^^^    ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Probably || was intended instead of &&.  If "hpd_priv->dp_cb" is NULL
> this will Oops.
> 
> c943b4948b5848 Chandan Uddaraju 2020-08-27  38  				&&
> !hpd_priv->dp_cb->disconnect) {
> c943b4948b5848 Chandan Uddaraju 2020-08-27  39  		pr_err("hpd dp_cb
> not initialized\n");
> c943b4948b5848 Chandan Uddaraju 2020-08-27  40  		return -EINVAL;
> c943b4948b5848 Chandan Uddaraju 2020-08-27  41  	}
> c943b4948b5848 Chandan Uddaraju 2020-08-27  42  	if (hpd)
> c943b4948b5848 Chandan Uddaraju 2020-08-27  43
> 		hpd_priv->dp_cb->configure(hpd_priv->dev);
> c943b4948b5848 Chandan Uddaraju 2020-08-27  44  	else
> c943b4948b5848 Chandan Uddaraju 2020-08-27  45
> 		hpd_priv->dp_cb->disconnect(hpd_priv->dev);
> c943b4948b5848 Chandan Uddaraju 2020-08-27  46
> c943b4948b5848 Chandan Uddaraju 2020-08-27  47  	return rc;
> c943b4948b5848 Chandan Uddaraju 2020-08-27  48  }
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
