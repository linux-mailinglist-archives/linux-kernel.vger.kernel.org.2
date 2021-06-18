Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523113AC72A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 11:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhFRJQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 05:16:09 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:2574 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229523AbhFRJQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 05:16:07 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15I9DkAa003290;
        Fri, 18 Jun 2021 04:13:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=BpBbG72V8ocso804x2RNUBVkws4dvofFXnOI8T/yoFc=;
 b=m1ELhi4TlnZiAlyQAIFjR1qPXRNvb0taeMwBEOa6kxWYiOzGL6A1DKj0x0dNi6ilxLhd
 /qbfWRoR5gZIdVrRa14yXN826/LT4iqM+9+MGkCGrVpAdGwyuzSo7e2EZfRdurSNdFD6
 OAQmJUTDykwoAMwMdkhiyKnZDcsrsKQA4ZDBfaE9DrBxfu9k80tFju42UiYHiTAVss7i
 AsIn+BQDzyv4Pe+TgGJcGHZDeLQfVFUWKDtpnc0JUVEvvXeGcoFEGUQOELEyOjL/L4h/
 6ywVLJroEFB9g4EIgG0CRF1/Hb49fTcumglT7P/TPqVF1pPyXD9HHWSgXneKxVCtGc4S 6g== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 398qj8g2sy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 18 Jun 2021 04:13:46 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 18 Jun
 2021 10:13:44 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Fri, 18 Jun 2021 10:13:43 +0100
Received: from [10.0.2.15] (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.68])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A57882B2;
        Fri, 18 Jun 2021 09:13:43 +0000 (UTC)
Subject: Re: [PATCH] soundwire: stream: Use polling for DP Prepare completion
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <sanyog.r.kale@intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20210617153410.27922-1-rf@opensource.cirrus.com>
 <1d340be7-2f21-73a5-bcc3-91372976dfb9@linux.intel.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <a8115cc6-8e4e-575f-9e63-f640854b7018@opensource.cirrus.com>
Date:   Fri, 18 Jun 2021 10:13:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <1d340be7-2f21-73a5-bcc3-91372976dfb9@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 2uSioFnmfBXiNNyKzEZa-C4tX4lWtCiO
X-Proofpoint-ORIG-GUID: 2uSioFnmfBXiNNyKzEZa-C4tX4lWtCiO
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 spamscore=0 adultscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106180053
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/2021 17:53, Pierre-Louis Bossart wrote:
> Thanks Richard for the patch, very interesting.
>   
>> sdw_prep_deprep_slave_ports() cannot use the port interrupt to signal
>> CP_SM completion because it is called while holding the bus lock, which
>> blocks the alert handler from running.
>>
>> Change to polling the PREPARESTATUS register and remove the
>> infrastructure that was implemented for the previous interrupt waiting.
> 
> I am afraid the entire PORT_READY support is completely untested at the moment: all the existing codecs use the simpler state machine, e.g. 		
> 
> dpn[i].simple_ch_prep_sm = true;
> 
> So my main question is: how did you test this change? Is this on a platform already supported upstream? yes/no answer is fine, no details necessary.
> 

No, it isn't upstream yet, but it doesn't support Simplified_CP_SM.

> I am also not fully clear on the locking issue.
> 
> Is the problem that sdw_handle_slave_status() uses a mutex_lock(&bus->bus_lock), which is already held in sdw_prepare_stream
> 

Yes

> so dealing with an ALERT status while doing pre-deprep would cause a self-inflicted deadlock?
> 

Not strictly a deadlock, but the ALERT handling will be delayed until
the sdw_prepare_stream() has released the bus lock. Of course, by then
the wait_for_completion() has timed out.

There is another bug in the original code. After wait_for_completion()
times out, there is a read of the PREPARESTATUS register. But the test

	if (!time_left || val)

will always treat a timeout as a failure even if the port is now
reporting successful prepare.

I can do a fix for that bug so that full CP_SM devices will prepare
successfully after the wait_for_completion() times out.

> If yes, that's a more general problem that would need to be fixed. this lock is taken in ALL stream operations, not just prepare/deprepare.
> 
> If e.g. a jack detection was signaled during any stream reconfiguration, we would also not be able to deal with the information, would we?
> 

The ALERT would be delayed until after the stream reconfig has ended.

> the purpose of the lock in sdw_handle_slave_status() was to check if devices attach or fall-off the bus before handling their status. The command/control protocol is always operational so nothing prevents the interrupt from being handled.
> 
> There's also something odd about directly polling on the status bits. The status bits will be used to signal the ALERT condition which is transmitted to the host during PING frames. This solution would result in the host noticing an interrupt: host controllers typically have a sticky status where all changes in PING frames are detected and used as a trigger for interrupt processing. In this case the interrupt would still be handled, but the sdw_handle_slave_status() would be deferred until the stream prepare is complete, and at that point the interrupt processing would not see any sources. It's not illegal but it's a bit odd to cause empty interrupts to be handled.
> 
> It might be a better solution to fix conflicts between stream reconfiguration and interrupts. I don't have a turn-key proposal but the suggested patch feels like a work-around.
> maybe using mutex_is_locked()?
> 

Possibly but I am very reluctant to rewrite bus locking, as I don't have
the ability to test a wide range of hardware configurations.

> If we can't figure something out, then at least the PORT_READY mask should not be set, i.e. this code would need to be removed:
> 
> ...
>> A new configuration field 'ch_prep_poll_us' is added to struct
>> sdw_dpn_prop so that the peripheral driver may select a polling interval.
>> If this is left at zero a default interval of 500 usec is used.
> 
> we already have a 'ch_prep_timeout' that's defined, do you need to redefine a new field?

The new field is how often to poll, so the driver can select a slower
poll rate if it knows its CP_SM takes longer.

> why not just read once at the end of that timeout? It's a prepare operation, there's no requirement to be fast, is there?

That is broken in the current code, as noted above. But I could make a
patch only to fix that bug.

