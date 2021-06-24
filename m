Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A963B24BA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 04:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhFXCKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 22:10:15 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:27666 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhFXCKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 22:10:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624500475; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=6atE1ASy+KdwLOEiHKmOOplUQomy6HEtQ2ed88jbMqY=;
 b=Ylo4yQfC6H8qsRwb5ToYf/SP33yXbNDyZevs/lktIHFV0vTJAiKG7qwNWtfYeC+MWGTUMbrL
 Lh9pXVFq6nZVH3ka06whOFmy2EWeHOgbPRaRXox+HsYXj7e/BJTIFSUhsmnl9XNrwipGBEoy
 YYaNKF+UoPURmqDq7VpOSh50tGU=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 60d3e8f3638039e997e45acd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 24 Jun 2021 02:07:47
 GMT
Sender: cang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D7335C43144; Thu, 24 Jun 2021 02:07:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0BE80C433F1;
        Thu, 24 Jun 2021 02:07:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 24 Jun 2021 10:07:45 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, ziqichen@codeaurora.org,
        linux-scsi@vger.kernel.org, kernel-team@android.com,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Satya Tangirala <satyat@google.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 02/10] scsi: ufs: Add flags pm_op_in_progress and
 is_sys_suspended
In-Reply-To: <e728719d-8e43-0e5a-af7a-14196dafa2a9@acm.org>
References: <1624433711-9339-1-git-send-email-cang@codeaurora.org>
 <1624433711-9339-3-git-send-email-cang@codeaurora.org>
 <e728719d-8e43-0e5a-af7a-14196dafa2a9@acm.org>
Message-ID: <fba43980b0a50bd09e70eaa8a4fea49d@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-24 04:59, Bart Van Assche wrote:
> On 6/23/21 12:35 AM, Can Guo wrote:
>> diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
>> index 93aeeb3..1e7fe73 100644
>> --- a/drivers/scsi/ufs/ufshcd.h
>> +++ b/drivers/scsi/ufs/ufshcd.h
>> @@ -754,6 +754,8 @@ struct ufs_hba {
>>  	struct device_attribute spm_lvl_attr;
>>  	/* A flag to tell whether __ufshcd_wl_suspend/resume() is in 
>> progress */
>>  	bool wlu_pm_op_in_progress;
>> +	/* A flag to tell whether ufshcd_suspend/resume() is in progress */
>> +	bool pm_op_in_progress;
>> 
>>  	/* Auto-Hibernate Idle Timer register value */
>>  	u32 ahit;
>> @@ -841,6 +843,8 @@ struct ufs_hba {
>>  	struct ufs_clk_scaling clk_scaling;
>>  	/* A flag to tell whether the UFS device W-LU is system suspended */
>>  	bool is_wlu_sys_suspended;
>> +	/* A flag to tell whether hba is system suspended */
>> +	bool is_sys_suspended;
>> 
>>  	enum bkops_status urgent_bkops_lvl;
>>  	bool is_urgent_bkops_lvl_checked;
> 
> It is not yet clear to me whether we really need these new member
> variables. If these are retained, please rename pm_op_in_progress into
> platform_pm_op_in_progress and is_sys_suspended into
> platform_is_sys_suspended.

Hi Bart,

These flags are informative when we debug some UFS issues and they
are used by later changes. Sure, I will modify the namings.

Thanks,

Can Guo.

> 
> Thanks,
> 
> Bart.
