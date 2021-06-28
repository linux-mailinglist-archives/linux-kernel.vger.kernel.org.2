Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279D03B598D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 09:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbhF1HO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 03:14:29 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:20585 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229998AbhF1HOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 03:14:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624864319; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=9HKLPt6UmZAYVg6hKZ4VhL+vXXYRIrBvxsOr/NJnZ2g=;
 b=UUQXVkkJwZbLr58lvu12vFqMnucv/M2uk6YKTQ2Ab4y2XfruxK4nUIiUJhVMeKbkyN9/JAFc
 D0Xf4ydhyXbXFHvgVbnNT4BsNHEYdAIkiDzR2ZACCpA+P8qPUfQoneRL04wDrbcpeA+zWrwd
 fbj8NGuGLj89kZs+pwYn09fM8VU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 60d97633d2559fe3925f0a1a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 28 Jun 2021 07:11:47
 GMT
Sender: cang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7242AC43146; Mon, 28 Jun 2021 07:11:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8AD33C433D3;
        Mon, 28 Jun 2021 07:11:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 28 Jun 2021 15:11:45 +0800
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
In-Reply-To: <77b92c6e-2e1c-c799-f6ac-04467175f96a@acm.org>
References: <1624433711-9339-1-git-send-email-cang@codeaurora.org>
 <1624433711-9339-3-git-send-email-cang@codeaurora.org>
 <77b92c6e-2e1c-c799-f6ac-04467175f96a@acm.org>
Message-ID: <aa01ddf1b91cb06a989bb47e001134ce@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-25 01:35, Bart Van Assche wrote:
> On 6/23/21 12:35 AM, Can Guo wrote:
>> @@ -9141,6 +9143,8 @@ static int ufshcd_suspend(struct ufs_hba *hba)
>> 
>>  	if (!hba->is_powered)
>>  		return 0;
>> +
>> +	hba->pm_op_in_progress = true;
>>  	/*
>>  	 * Disable the host irq as host controller as there won't be any
>>  	 * host controller transaction expected till resume.
>> @@ -9160,6 +9164,7 @@ static int ufshcd_suspend(struct ufs_hba *hba)
>>  	ufshcd_vreg_set_lpm(hba);
>>  	/* Put the host controller in low power mode if possible */
>>  	ufshcd_hba_vreg_set_lpm(hba);
>> +	hba->pm_op_in_progress = false;
>>  	return ret;
>>  }
>> 
>> @@ -9179,6 +9184,7 @@ static int ufshcd_resume(struct ufs_hba *hba)
>>  	if (!hba->is_powered)
>>  		return 0;
>> 
>> +	hba->pm_op_in_progress = true;
>>  	ufshcd_hba_vreg_set_hpm(hba);
>>  	ret = ufshcd_vreg_set_hpm(hba);
>>  	if (ret)
>> @@ -9198,6 +9204,7 @@ static int ufshcd_resume(struct ufs_hba *hba)
>>  out:
>>  	if (ret)
>>  		ufshcd_update_evt_hist(hba, UFS_EVT_RESUME_ERR, (u32)ret);
>> +	hba->pm_op_in_progress = false;
>>  	return ret;
>>  }
> 
> Has it been considered to check dev->power.runtime_status instead of
> introducing the pm_op_in_progress variable?

ufshcd_resume() is also used by system resume, while runtime_status only
tells about runtime resume. So does ufshcd_suspend().

Thanks,

Can Guo.

> 
> Thanks,
> 
> Bart.
