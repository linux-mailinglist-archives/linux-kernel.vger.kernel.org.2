Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E21397F18
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 04:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhFBCbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 22:31:38 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:23818 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhFBCbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 22:31:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1622600994; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=mrS8FjuiuckPwfzV6XWwylgTgo9N2E/xkBAnOaFFiqY=;
 b=YOJEbPbBe2WrDutFM8QeXU9Gn6Jn/D/LlGJ4YasjSEGDy3WnqDTRSJ9ZsTt+yJdpvb5yrHpP
 Bpz/zyBkSf0TqdgjQlzjeOG3d2dCQYP5jXKTnkTe28Jehfm4bIV966DFvhcLjctdfI1kPKfo
 eZnA45K0garAfa6HRVETsYadHS0=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 60b6ed1de27c0cc77f058797 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Jun 2021 02:29:49
 GMT
Sender: cang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 36F05C43217; Wed,  2 Jun 2021 02:29:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1E64AC43460;
        Wed,  2 Jun 2021 02:29:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 02 Jun 2021 10:29:47 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Bean Huo <huobean@gmail.com>
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] scsi: ufs: Use UPIU query trace in devman_upiu_cmd
In-Reply-To: <20210531104308.391842-5-huobean@gmail.com>
References: <20210531104308.391842-1-huobean@gmail.com>
 <20210531104308.391842-5-huobean@gmail.com>
Message-ID: <7689e5022787716596534e9123fdc295@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bean,

On 2021-05-31 18:43, Bean Huo wrote:
> From: Bean Huo <beanhuo@micron.com>
> 
> Since devman_upiu_cmd is not COMMAND UPIU, and doesn't have
> CDB, it is better to use UPIU query trace, which provides more
> helpful information for issue shooting.
> 
> Signed-off-by: Bean Huo <beanhuo@micron.com>
> ---
>  drivers/scsi/ufs/ufshcd.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index c84bd8e045f6..deb9e232b349 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -6701,6 +6701,7 @@ static int ufshcd_issue_devman_upiu_cmd(struct
> ufs_hba *hba,
> 
>  	hba->dev_cmd.complete = &wait;
> 
> +	ufshcd_add_query_upiu_trace(hba, UFS_QUERY_SEND, lrbp->ucd_req_ptr);
>  	/* Make sure descriptors are ready before ringing the doorbell */
>  	wmb();
>  	spin_lock_irqsave(hba->host->host_lock, flags);
> @@ -6732,6 +6733,8 @@ static int ufshcd_issue_devman_upiu_cmd(struct
> ufs_hba *hba,
>  			err = -EINVAL;
>  		}
>  	}
> +	ufshcd_add_query_upiu_trace(hba, err ? UFS_QUERY_ERR : 
> UFS_QUERY_COMP,
> +				    (struct utp_upiu_req *)lrbp->ucd_rsp_ptr);
> 
>  out:
>  	blk_put_request(req);

What about ufshcd_exec_dev_cmd()?

Thanks,
Can Guo.
