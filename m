Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDDA38F7A3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 03:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhEYBmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 21:42:01 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:45584 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhEYBl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 21:41:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1621906828; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=s8u2/Kix6jXxz+HUY/6HOx+UcJEOLKMF3abFsbJQwRc=;
 b=ZPdSKhhZQD0WfIYR7Qct33+hsvGlwbvZ8gdG2EeC1sbNKNg1ABUJFh8fN9gDMFZ4S0GJCYDP
 YBQCQq+4PprgMBWE9JxcJrlZSvAHe+NEU9FK0xlawwfhlZPVEpMJ4XgkBT8NvPXKmh40O5om
 b4NGwtNRo32EV97pRZM5KeJ+fCQ=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 60ac5585ceebd0e932c7a841 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 25 May 2021 01:40:21
 GMT
Sender: cang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1E629C43144; Tue, 25 May 2021 01:40:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D2500C433F1;
        Tue, 25 May 2021 01:40:18 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 25 May 2021 09:40:18 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, Stanley Chu <stanley.chu@mediatek.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bean Huo <beanhuo@micron.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Satya Tangirala <satyat@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v1 2/3] scsi: ufs: Optimize host lock on transfer requests
 send/compl paths
In-Reply-To: <41a08b3e-122d-4f1a-abbd-4b5730f880b2@acm.org>
References: <1621845419-14194-1-git-send-email-cang@codeaurora.org>
 <1621845419-14194-3-git-send-email-cang@codeaurora.org>
 <41a08b3e-122d-4f1a-abbd-4b5730f880b2@acm.org>
Message-ID: <0cfbf580e340073ff972be493a59dbe7@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021-05-25 04:10, Bart Van Assche wrote:
> On 5/24/21 1:36 AM, Can Guo wrote:
>> Current UFS IRQ handler is completely wrapped by host lock, and 
>> because
>> ufshcd_send_command() is also protected by host lock, when IRQ handler
>> fires, not only the CPU running the IRQ handler cannot send new 
>> requests,
>> the rest CPUs can neither. Move the host lock wrapping the IRQ handler 
>> into
>> specific branches, i.e., ufshcd_uic_cmd_compl(), 
>> ufshcd_check_errors(),
>> ufshcd_tmc_handler() and ufshcd_transfer_req_compl(). Meanwhile, to 
>> further
>> reduce occpuation of host lock in ufshcd_transfer_req_compl(), host 
>> lock is
>> no longer required to call __ufshcd_transfer_req_compl(). As per test, 
>> the
>> optimization can bring considerable gain to random read/write 
>> performance.
> 
> Hi Can,
> 
> Using the host lock to serialize the completion path against the
> submission path was a common practice 11 years ago, before the host 
> lock
> push-down (see also
> https://linux-scsi.vger.kernel.narkive.com/UEmGgwAc/rfc-patch-scsi-host-lock-push-down).
> Modern SCSI LLDs should not use the SCSI host lock. Please consider
> introducing one or more new synchronization objects in struct ufs_hba
> and to use these instead of the SCSI host lock. That will save multiple
> pointer dereferences in the hot path since hba->host->host_lock will
> become hba->new_spin_lock.
> 
> An additional question is whether it is necessary for v3.0 UFS devices
> to serialize the submission path against the completion path? Multiple
> high-performance SCSI LLDs support hardware with separate submission 
> and
> completion queues and hence do not need any serialization between the
> submission and the completion path. I'm asking this because it is 
> likely
> that sooner or later multiqueue support will be added in the UFS
> specification. Benefiting from multiqueue support will require to 
> rework
> locking in the UFS driver anyway.
> 

Hi Bart,

Agree with all above, and what you ask is right what we are doing in the
3rd change - get rid of host lock on dispatch and completion paths.

I agree with using dedicated spin locks for dedicated purposes in UFS 
driver,
e.g., clk gating has its own gating_lock and clk scaling has its own 
scaling_lock.
But this specific series is only for improving performance. We will take 
your
comments into consideration and address it in future.

Thanks,

Can Guo.

> Thanks,
> 
> Bart.
