Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556023B14F2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 09:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhFWHmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 03:42:38 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:53958 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229844AbhFWHmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 03:42:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624434020; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=lBX5unMybaFyS0NZwXntXNHhSNdvRWM2tuSic26viZU=;
 b=GnjhKPTp0NB4KT37FD4IsLz4FaBm+FJjYtc9bjvUsJnA4OXpd+f5GayriQWSvHfTuV+F7C7e
 6CDykXDywVqjDSQHrtLRg4/tefJf2pu5CYO8LN5Fz0+uvakkA5PVa5QNAL0imFrkibFx7pG/
 I4yfpronEMZJvPpKDPiQhECUg7g=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 60d2e5455d0d101e38792fe8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 23 Jun 2021 07:39:49
 GMT
Sender: cang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 55C3BC43146; Wed, 23 Jun 2021 07:39:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 97362C43144;
        Wed, 23 Jun 2021 07:39:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 23 Jun 2021 15:39:46 +0800
From:   Can Guo <cang@codeaurora.org>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, ziqichen@codeaurora.org,
        linux-scsi@vger.kernel.org, kernel-team@android.com,
        cang@codeaurora.org
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/10] scsi: ufs: Complete the cmd before returning in
 queuecommand
In-Reply-To: <1624433711-9339-6-git-send-email-cang@codeaurora.org>
References: <1624433711-9339-1-git-send-email-cang@codeaurora.org>
 <1624433711-9339-6-git-send-email-cang@codeaurora.org>
Message-ID: <b9a95d55856c0530659cb2f364e5a525@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, please ignore this change, it is wrongly sent out along with this 
series...

On 2021-06-23 15:35, Can Guo wrote:
> Commit 7a7e66c65d4148fc3f23b058405bc9f102414fcb ("scsi: ufs: Fix a race
> condition between ufshcd_abort() and eh_work()") forgot to complete the
> cmd, which takes an occupied lrb, before returning in queuecommand. 
> This
> change adds the missing codes.
> 
> Fixes: 7a7e66c65d414 ("scsi: ufs: Fix a race condition between
> ufshcd_abort() and eh_work()")
> Signed-off-by: Can Guo <cang@codeaurora.org>
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 5f837c4..7fbc63e 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -2758,6 +2758,16 @@ static int ufshcd_queuecommand(struct Scsi_Host
> *host, struct scsi_cmnd *cmd)
>  		goto out;
>  	}
> 
> +	if (unlikely(test_bit(tag, &hba->outstanding_reqs))) {
> +		if (hba->wlu_pm_op_in_progress) {
> +			set_host_byte(cmd, DID_BAD_TARGET);
> +			cmd->scsi_done(cmd);
> +		} else {
> +			err = SCSI_MLQUEUE_HOST_BUSY;
> +		}
> +		goto out;
> +	}
> +
>  	hba->req_abort_count = 0;
> 
>  	err = ufshcd_hold(hba, true);
> @@ -2768,15 +2778,6 @@ static int ufshcd_queuecommand(struct Scsi_Host
> *host, struct scsi_cmnd *cmd)
>  	WARN_ON(ufshcd_is_clkgating_allowed(hba) &&
>  		(hba->clk_gating.state != CLKS_ON));
> 
> -	if (unlikely(test_bit(tag, &hba->outstanding_reqs))) {
> -		if (hba->wlu_pm_op_in_progress)
> -			set_host_byte(cmd, DID_BAD_TARGET);
> -		else
> -			err = SCSI_MLQUEUE_HOST_BUSY;
> -		ufshcd_release(hba);
> -		goto out;
> -	}
> -
>  	lrbp = &hba->lrb[tag];
>  	WARN_ON(lrbp->cmd);
>  	lrbp->cmd = cmd;
