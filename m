Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495F532363F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 04:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbhBXDuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 22:50:15 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:42984 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233704AbhBXDuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 22:50:03 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614138579; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Gz/nJPrGJP7gB6ntnx6Dmk5y7Vmp4Se23+LdipuUkhg=;
 b=jAVtrrZubaFGLsXJPCAQaYs8BG6gkEEgrfJxfL0dAHUBJDzBcAz27zZj84gHkmzJYz2/7Bqp
 ab7Hu0t8f8+XKGstdTxSd2vpFX6HIFqaR5hmt99bcHrECbrZQV4/8BYENnWJVBpfp3HVYfPL
 Bw3gI6aS25f/e37ff6KPdD9axgw=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 6035ccb0e87943df308e77ac (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 24 Feb 2021 03:49:04
 GMT
Sender: kgunda=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C295AC43463; Wed, 24 Feb 2021 03:49:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kgunda)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 44506C433C6;
        Wed, 24 Feb 2021 03:49:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 24 Feb 2021 09:19:03 +0530
From:   kgunda@codeaurora.org
To:     Pavel Machek <pavel@ucw.cz>
Cc:     bjorn.andersson@linaro.org, jingoohan1@gmail.com,
        lee.jones@linaro.org, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, daniel.thompson@linaro.org,
        jacek.anaszewski@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V1 0/2] Fix WLED FSC Sync and brightness Sync settings
In-Reply-To: <20210219180839.GB8596@duo.ucw.cz>
References: <1613743659-4726-1-git-send-email-kgunda@codeaurora.org>
 <20210219180839.GB8596@duo.ucw.cz>
Message-ID: <1fcacbe5de8dd7d3a0df2b6108d734f6@codeaurora.org>
X-Sender: kgunda@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-19 23:38, Pavel Machek wrote:
> Hi!
> 
>> The FSC (Full scale current) setting is not updated properly due to 
>> the
>> wrong register toggling for WLED5. Also the ILED_SYNC toggle and 
>> MOD_SYNC
>> toggle sequence is updated as per the hardware team recommendation to 
>> fix
>> the FSC update and brightness update issue.
> 
> If this is phone hardware, it might make sense to cc:
> phone-devel@vger...
> 
Yes. it is for phone hardware. Will cc the email.
> Best regards,
> 									Pavel
