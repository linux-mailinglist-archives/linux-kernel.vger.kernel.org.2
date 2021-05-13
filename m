Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22B437F0DD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 03:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbhEMBQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 21:16:34 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:14060 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbhEMBQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 21:16:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620868520; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=0HUdi3RVnrIz9MP5yZUO5pEKm9r054S5adp5gghHIuo=;
 b=EbdiAVMnDiO5yVvbKQu+q17RWHTIudBNPcvvJnAInVzu1cAe3QLtgjDq0WuZN/MDMEt/eiw7
 4dxbjlTM7y0MqUlxC1N/AVEc1SJfIN9ftgowDVmRpSPNDuCSFgDBK593v84YnC2Wfe0Dulmh
 DhfmhRJofLCcD4IuAqMMUEWGJZM=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 609c7da1938a1a6b8f70dd91 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 13 May 2021 01:15:13
 GMT
Sender: cang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 24EDCC359F4; Thu, 13 May 2021 01:15:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0EE32C35960;
        Thu, 13 May 2021 01:15:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 13 May 2021 09:15:09 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Bean Huo <huobean@gmail.com>
Cc:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Satya Tangirala <satyat@google.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] scsi: ufs: Introduce hba performance monitor sysfs
 nodes
In-Reply-To: <cb32c4e786ac73681b80b8af556543f08f076687.camel@gmail.com>
References: <1619058521-35307-1-git-send-email-cang@codeaurora.org>
 <1619058521-35307-2-git-send-email-cang@codeaurora.org>
 <cb32c4e786ac73681b80b8af556543f08f076687.camel@gmail.com>
Message-ID: <638d9eb678db15e95317c16f2313ea19@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-05-13 04:21, Bean Huo wrote:
> On Wed, 2021-04-21 at 19:28 -0700, Can Guo wrote:
>> +
>> 
>> +static DEVICE_ATTR_RW(monitor_enable);
>> 
>> +static DEVICE_ATTR_RW(monitor_chunk_size);
>> 
>> +static DEVICE_ATTR_RO(read_total_sectors);
>> 
>> +static DEVICE_ATTR_RO(read_total_busy);
>> 
>> +static DEVICE_ATTR_RO(read_nr_requests);
>> 
>> +static DEVICE_ATTR_RO(read_req_latency_avg);
>> 
>> +static DEVICE_ATTR_RO(read_req_latency_max);
>> 
>> +static DEVICE_ATTR_RO(read_req_latency_min);
>> 
>> +static DEVICE_ATTR_RO(read_req_latency_sum);
>> 
>> +static DEVICE_ATTR_RO(write_total_sectors);
>> 
>> +static DEVICE_ATTR_RO(write_total_busy);
>> 
>> +static DEVICE_ATTR_RO(write_nr_requests);
>> 
>> +static DEVICE_ATTR_RO(write_req_latency_avg);
>> 
>> +static DEVICE_ATTR_RO(write_req_latency_max);
>> 
>> +static DEVICE_ATTR_RO(write_req_latency_min);
>> 
>> +static DEVICE_ATTR_RO(write_req_latency_sum);
> 
> Can,
> 
> I like this series of patches, which can help me monitor UFS
> performance online. I have a suggestion,  how do you think that we add
> this to ufs-debugfs. Then we don't need to poll each parameter one by
> one, just one interface.
> 
> Bean

Hi Bean,

Thanks for your suggestion, put it into debugfs is also an option.
But on Android, debugfs is not mounted by default (the requirement
from Google). So it is convenient to have it in sysfs, and one can
use below cmd (as I listed in the cover letter) to poll all parameters
at once : "grep ^ /dev/null *".

Thanks,
Can Guo.
