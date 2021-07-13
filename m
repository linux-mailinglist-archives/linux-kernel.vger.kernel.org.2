Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864733C7998
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 00:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236466AbhGMW1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 18:27:54 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:30069 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234665AbhGMW1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 18:27:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626215102; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=NrfFoaUg+uge8R5c62DK9xqyU2a37Zv+qz0iccvChbU=;
 b=jWiDnzpJS4NklBGzmeLN2n9RRkm26vIyWRyxxzlRwjQFogM4iJnmHTd/Pb7yrnSY55bScCJI
 lN4TipKVxGKdsFOGSCe/NqlpBz9cpAMNcVFr2xHb01kKCogRjGjSrWNEgAzeBlcMbaLIVPLd
 d2RUFK+9xXuSQWOeoBdVMAhGiFY=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 60ee12bddc4628fe7e4a26e3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 13 Jul 2021 22:25:01
 GMT
Sender: khsieh=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1EA62C433F1; Tue, 13 Jul 2021 22:25:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: khsieh)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 18AD7C433D3;
        Tue, 13 Jul 2021 22:24:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 13 Jul 2021 15:24:58 -0700
From:   khsieh@codeaurora.org
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     robdclark@gmail.com, sean@poorly.run, swboyd@chromium.org,
        lyude@redhat.com, abhinavk@codeaurora.org, aravindh@codeaurora.org,
        rsubbia@codeaurora.org, rnayak@codeaurora.org,
        freedreno@lists.freedesktop.org, airlied@linux.ie, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/dp_mst: Fix return code on sideband message
 failure
In-Reply-To: <87zguy7c5a.fsf@intel.com>
References: <1625585434-9562-1-git-send-email-khsieh@codeaurora.org>
 <87zguy7c5a.fsf@intel.com>
Message-ID: <a514c19f712a6feeddf854dc17cb8eb5@codeaurora.org>
X-Sender: khsieh@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-07-07 01:37, Jani Nikula wrote:
> On Tue, 06 Jul 2021, Kuogee Hsieh <khsieh@codeaurora.org> wrote:
>> From: Rajkumar Subbiah <rsubbia@codeaurora.org>
>> 
>> Commit 2f015ec6eab6 ("drm/dp_mst: Add sideband down request tracing +
>> selftests") added some debug code for sideband message tracing. But
>> it seems to have unintentionally changed the behavior on sideband 
>> message
>> failure. It catches and returns failure only if DRM_UT_DP is enabled.
>> Otherwise it ignores the error code and returns success. So on an MST
>> unplug, the caller is unaware that the clear payload message failed 
>> and
>> ends up waiting for 4 seconds for the response. Fixes the issue by
>> returning the proper error code.
>> 
>> Changes in V2:
>> -- Revise commit text as review comment
>> -- add Fixes text
>> 
>> Changes in V3:
>> -- remove "unlikely" optimization
>> 
>> Fixes: 2f015ec6eab6 ("drm/dp_mst: Add sideband down request tracing + 
>> selftests")
>> 
>> Signed-off-by: Rajkumar Subbiah <rsubbia@codeaurora.org>
>> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
>> 
>> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> 
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>
> 
> 
>> ---
Lyude,
Any comments from you?
Thanks,

>>  drivers/gpu/drm/drm_dp_mst_topology.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c 
>> b/drivers/gpu/drm/drm_dp_mst_topology.c
>> index 1590144..df91110 100644
>> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
>> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
>> @@ -2887,11 +2887,13 @@ static int process_single_tx_qlock(struct 
>> drm_dp_mst_topology_mgr *mgr,
>>  	idx += tosend + 1;
>> 
>>  	ret = drm_dp_send_sideband_msg(mgr, up, chunk, idx);
>> -	if (unlikely(ret) && drm_debug_enabled(DRM_UT_DP)) {
>> -		struct drm_printer p = drm_debug_printer(DBG_PREFIX);
>> +	if (ret) {
>> +		if (drm_debug_enabled(DRM_UT_DP)) {
>> +			struct drm_printer p = drm_debug_printer(DBG_PREFIX);
>> 
>> -		drm_printf(&p, "sideband msg failed to send\n");
>> -		drm_dp_mst_dump_sideband_msg_tx(&p, txmsg);
>> +			drm_printf(&p, "sideband msg failed to send\n");
>> +			drm_dp_mst_dump_sideband_msg_tx(&p, txmsg);
>> +		}
>>  		return ret;
>>  	}
