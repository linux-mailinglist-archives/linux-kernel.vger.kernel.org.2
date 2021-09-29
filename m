Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B0441BD78
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 05:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244027AbhI2DdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 23:33:00 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:32597 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244005AbhI2Dc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 23:32:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632886279; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=CoZyHdEs+PveTvKhyIyzpXsUxE/2MwN2b0M04LT0gio=;
 b=lPnDxp7cayOrYN+jw8/Xc7dmfZsuD43DOUzu51+4KElw9UBvdxRGnmmtQF+JPL4yhqqwQ1Va
 0KxKYvLdi2MdFL8aCD60wlDU5BYEYDzxhNCO6U3SJK6fI/WYBqTJBMf4HfgZbWiwYTlArhJp
 xCQQHB6DO/7lcAgtl+/pWctGlGI=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 6153de06713d5d6f9692e915 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 29 Sep 2021 03:31:18
 GMT
Sender: cang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 62214C43619; Wed, 29 Sep 2021 03:31:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8A1A1C4338F;
        Wed, 29 Sep 2021 03:31:16 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 29 Sep 2021 11:31:16 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, ziqichen@codeaurora.org,
        linux-scsi@vger.kernel.org, kernel-team@android.com,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bean Huo <beanhuo@micron.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: ufs: Fix a possible dead lock in clock scaling
In-Reply-To: <cc9cb9e7-68bd-3bfa-9310-5fbf99a86544@acm.org>
References: <1631843521-2863-1-git-send-email-cang@codeaurora.org>
 <cc9cb9e7-68bd-3bfa-9310-5fbf99a86544@acm.org>
Message-ID: <fbc4d03a07f03fe4fbe697813111471f@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

On 2021-09-18 01:27, Bart Van Assche wrote:
> On 9/16/21 6:51 PM, Can Guo wrote:
>> Assume a scenario where task A and B call ufshcd_devfreq_scale()
>> simultaneously. After task B calls downgrade_write() [1], but before 
>> it
>> calls down_read() [3], if task A calls down_write() [2], when task B 
>> calls
>> down_read() [3], it will lead to dead lock.
> 
> Something is wrong with the above description. The downgrade_write() 
> call is
> not followed by down_read() but by up_read(). Additionally, I don't see 
> how
> concurrent calls of ufshcd_devfreq_scale() could lead to a deadlock.

As mentioned in the commit msg, the down_read() [3] is from 
ufshcd_wb_ctrl().

Task A -
down_write [2]
ufshcd_clock_scaling_prepare
ufshcd_devfreq_scale
ufshcd_clkscale_enable_store

Task B -
down_read [3]
ufshcd_exec_dev_cmd
ufshcd_query_flag
ufshcd_wb_ctrl
downgrade_write [1]
ufshcd_devfreq_scale
ufshcd_devfreq_target
devfreq_set_target
update_devfreq
devfreq_performance_handler
governor_store


> If one thread calls downgrade_write() and another thread calls 
> down_write()
> immediately, that down_write() call will block until the other thread 
> has called up_read()
> without triggering a deadlock.

Since the down_write() caller is blocked, the down_read() caller, which 
comes after
down_write(), is blocked too, no? downgrade_write() keeps lock owner as 
it is, but
it does not change the fact that readers and writers can be blocked by 
each other.

> 
> Thanks,
> 
> Bart.

Thanks,

Can.
