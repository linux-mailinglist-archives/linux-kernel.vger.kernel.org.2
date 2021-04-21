Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1532E3671A0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 19:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244891AbhDURoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 13:44:23 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:56736 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244878AbhDURoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 13:44:20 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1619027027; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=CWCU93Btsi4cuKG948kieS4I2OHLPnaZxfWhEqB9jME=;
 b=YvKydmHnhOIanICOm7OrjHcIRX7omlmR3xBGkslExcK+ul+iq9uTrDtjT0lkkEzHILUFzX2u
 zvSNnXdOG5wPSaZeVmD432KqSfnSqzGXqQ+NcPziEzOc2kKN7scjSZLIu4EqdCdZsosRkIBp
 2LgCJsOranjbGFTlm0D8snROJek=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 60806451853c0a2c461727d4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 21 Apr 2021 17:43:44
 GMT
Sender: khsieh=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 41FC6C43144; Wed, 21 Apr 2021 17:43:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: khsieh)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A9130C4338A;
        Wed, 21 Apr 2021 17:43:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 21 Apr 2021 10:43:42 -0700
From:   khsieh@codeaurora.org
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     robdclark@gmail.com, sean@poorly.run, abhinavk@codeaurora.org,
        aravindh@codeaurora.org, airlied@linux.ie, daniel@ffwll.ch,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] drm/msm/dp: check main link status before start
 aux read
In-Reply-To: <161896193053.46595.7590816467281538002@swboyd.mtv.corp.google.com>
References: <1618594731-556-1-git-send-email-khsieh@codeaurora.org>
 <161896193053.46595.7590816467281538002@swboyd.mtv.corp.google.com>
Message-ID: <4da92917bb65490f500faf7bf9b7003f@codeaurora.org>
X-Sender: khsieh@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-04-20 16:38, Stephen Boyd wrote:
> Quoting Kuogee Hsieh (2021-04-16 10:38:51)
>> Maybe when the cable is disconnected the DP phy should be shutdown and
>> some bit in the phy could effectively "cut off" the aux channel and 
>> then
>> NAKs would start coming through here in the DP controller I/O register
>> space. This patch have DP aux channel read/write to return NAK 
>> immediately
>> if DP controller connection status is in unplugged state.
>> 
>> Changes in V3:
>> -- check core_initialized before handle irq_hpd
>> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
>> ---
>>  drivers/gpu/drm/msm/dp/dp_aux.c     |  5 +++++
>>  drivers/gpu/drm/msm/dp/dp_display.c | 14 ++++++++++----
>>  drivers/gpu/drm/msm/dp/dp_link.c    | 20 +++++++++++++++-----
>>  3 files changed, 30 insertions(+), 9 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c 
>> b/drivers/gpu/drm/msm/dp/dp_aux.c
>> index 7c22bfe..fae3806 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_aux.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_aux.c
>> @@ -343,6 +343,11 @@ static ssize_t dp_aux_transfer(struct drm_dp_aux 
>> *dp_aux,
>> 
>>         mutex_lock(&aux->mutex);
>> 
>> +       if (!dp_catalog_link_is_connected(aux->catalog)) {
>> +               ret = -ETIMEDOUT;
>> +               goto unlock_exit;
>> +       }
>> +
> 
> This still makes me concerned. Any possibility to not do this and have
> the phy cut the connection off and have this transfer timeout
> immediately?
no, we have to wait hardware AUX_NACK timeout.
only this or the abort flag used last time.
Last time you have kernel crash because of service irq_hpd while clock 
is turned off.
I have add core_initialized checking wiinin irq_hpd to prevent this.
I think abort flag approach is safer.

> 
>>         aux->native = msg->request & (DP_AUX_NATIVE_WRITE & 
>> DP_AUX_NATIVE_READ);
>> 
>>         /* Ignore address only message */
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c 
>> b/drivers/gpu/drm/msm/dp/dp_display.c
>> index 1784e11..db3f45e 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -571,7 +571,7 @@ static int dp_hpd_plug_handle(struct 
>> dp_display_private *dp, u32 data)
>>                 dp->hpd_state = ST_DISCONNECTED;
>> 
>>                 if (ret == -ECONNRESET) { /* cable unplugged */
>> -                       dp->core_initialized = false;
>> +                       DRM_ERROR("dongle unplugged = %d\n", ret);
> 
> Is this a debug message?
> 
>>                 }
>> 
>>         } else {
>> @@ -711,9 +711,15 @@ static int dp_irq_hpd_handle(struct 
>> dp_display_private *dp, u32 data)
>>                 return 0;
>>         }
>> 
>> -       ret = dp_display_usbpd_attention_cb(&dp->pdev->dev);
>> -       if (ret == -ECONNRESET) { /* cable unplugged */
>> -               dp->core_initialized = false;
>> +       /*
>> +        * dp core (ahb/aux clks) must be initialized before
>> +        * irq_hpd be handled
>> +        */
>> +       if (dp->core_initialized) {
>> +               ret = dp_display_usbpd_attention_cb(&dp->pdev->dev);
>> +               if (ret == -ECONNRESET) { /* cable unplugged */
>> +                       DRM_ERROR("dongle unplugged = %d\n", ret);
> 
> Another debug message?
> 
>> +               }
>>         }
>> 
>>         mutex_unlock(&dp->event_mutex);
>> diff --git a/drivers/gpu/drm/msm/dp/dp_link.c 
>> b/drivers/gpu/drm/msm/dp/dp_link.c
>> index be986da..53ecae6 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_link.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_link.c
>> @@ -737,18 +737,25 @@ static int dp_link_parse_sink_count(struct 
>> dp_link *dp_link)
>>         return 0;
>>  }
>> 
>> -static void dp_link_parse_sink_status_field(struct dp_link_private 
>> *link)
>> +static int dp_link_parse_sink_status_field(struct dp_link_private 
>> *link)
>>  {
>>         int len = 0;
>> 
>>         link->prev_sink_count = link->dp_link.sink_count;
>> -       dp_link_parse_sink_count(&link->dp_link);
>> +       len = dp_link_parse_sink_count(&link->dp_link);
>> +       if (len < 0) {
>> +               DRM_ERROR("DP parse sink count failed\n");
>> +               return len;
>> +       }
>> 
>>         len = drm_dp_dpcd_read_link_status(link->aux,
>>                 link->link_status);
>> -       if (len < DP_LINK_STATUS_SIZE)
>> +       if (len < DP_LINK_STATUS_SIZE) {
>>                 DRM_ERROR("DP link status read failed\n");
>> -       dp_link_parse_request(link);
>> +               return len;
>> +       }
>> +
>> +       return dp_link_parse_request(link);
>>  }
>> 
>>  /**
>> @@ -1032,7 +1039,10 @@ int dp_link_process_request(struct dp_link 
>> *dp_link)
>> 
>>         dp_link_reset_data(link);
>> 
>> -       dp_link_parse_sink_status_field(link);
>> +       ret = dp_link_parse_sink_status_field(link);
>> +       if (ret) {
>> +               return ret;
>> +       }
>> 
>>         if (link->request.test_requested == DP_TEST_LINK_EDID_READ) {
>>                 dp_link->sink_request |= DP_TEST_LINK_EDID_READ;
>> --
> 
> Can you split this part off into another patch? It seems to stand on 
> its
> own as it makes the code more robust to transfer errors in the sink
> parsing code.
