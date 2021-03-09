Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA73332CFE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 18:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhCIRNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 12:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbhCIRNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 12:13:23 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D40FC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 09:13:23 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v15so17169316wrx.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 09:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=4E4B2xlaHTkAbKCLQY2tzB0M/UIewZVxgvZlKvBiH3c=;
        b=RVsnzzQTkYEgUiAsEVrcRaREJuZFvSe4TRwZIDnUXyIkpZK49/ZplAaPJC7OfFBVq2
         Z2IMQVsOZmxMf4GKRU0ZhAyP1m4Xw6WaNYixtf9mTvY5XNqsgc8Lyf2skbyUga2Tazxj
         5cbaY85hQ+NFkOLU9Cs8W0y0s5OWQnAQrGXWxk3gYfPV/4fUE55OFJ8LFWTDid1Zn2Cb
         aMr22NDluvqyYBd1hEjx6/o7l5yXk5pYNZhW2l/RXHx9iHo3Thpwt78EyVxuxkTRRtF6
         wgXEBShh1YZvfuzOgf7m22JRcpvybK7LcVtUYJ78S0Gki1CNNvnftxipXzzMg4na1rvK
         DQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=4E4B2xlaHTkAbKCLQY2tzB0M/UIewZVxgvZlKvBiH3c=;
        b=DsnrO43DJuMB0lshd578EW2wBPSywaTOgGahxDHPR2Tc6kow5FjBehTl0XSUdejakO
         hvGejA7E3vi5WrilIMySmGP/oSUlNIefZErnt1NnapQ24PTvftIRauyrkcwQSbvcD3Qg
         qCB6p9Vm7xrmrUM4vLAty/Z03R5BAxyP40afe7xyYy7Qaf5cuG38arURFKvSYPf7uDjS
         exO2gPvn/9aa30MHSXxqXM6F0ph2yAmN9rzkY3kyc+Emn3c9wChPspJfexEqek22bUBU
         Z2GGXGTSvCaPii6XibwEqm5FCZFcILkkP0AFcdDBAFiAIpCaMaOLKBaCLf6CLeQDlrt5
         8yBA==
X-Gm-Message-State: AOAM532Uh3YXW3usuBNCq6JJ7fbZHM/1XRQIYuskFZjSN9HW+Y60wuH7
        b/x7TrMniqEPyVX67YjACmoi5g==
X-Google-Smtp-Source: ABdhPJzCiTPqXsdBsijJuz9fKcjPAaAFMc1RGe6N/8X9SFcamHDYHh/oNSfb6gjkDrGMgryfSvxGJQ==
X-Received: by 2002:a5d:548c:: with SMTP id h12mr29519223wrv.46.1615310002233;
        Tue, 09 Mar 2021 09:13:22 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id f7sm4751268wmh.39.2021.03.09.09.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 09:13:21 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Artem Lapkin <email2tema@gmail.com>
Cc:     jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        christianshewitt@gmail.com, art@khadas.com, nick@khadas.com,
        gouwa@khadas.com
Subject: Re: [PATCH] drm: meson_drv add shutdown function
In-Reply-To: <e033540e-3a4f-3dd7-a1b0-d5a0241e845a@baylibre.com>
References: <20210302042202.3728113-1-art@khadas.com>
 <e033540e-3a4f-3dd7-a1b0-d5a0241e845a@baylibre.com>
Date:   Tue, 09 Mar 2021 09:13:18 -0800
Message-ID: <7h35x42qtt.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 02/03/2021 05:22, Artem Lapkin wrote:
>> Problem: random stucks on reboot stage about 1/20 stuck/reboots
>> // debug kernel log
>> [    4.496660] reboot: kernel restart prepare CMD:(null)
>> [    4.498114] meson_ee_pwrc c883c000.system-controller:power-controller: shutdown begin
>> [    4.503949] meson_ee_pwrc c883c000.system-controller:power-controller: shutdown domain 0:VPU...
>> ...STUCK...
>> 
>> Solution: add shutdown function to meson_drm driver 
>> // debug kernel log
>> [    5.231896] reboot: kernel restart prepare CMD:(null)
>> [    5.246135] [drm:meson_drv_shutdown]
>> ...
>> [    5.259271] meson_ee_pwrc c883c000.system-controller:power-controller: shutdown begin
>> [    5.274688] meson_ee_pwrc c883c000.system-controller:power-controller: shutdown domain 0:VPU...
>> [    5.338331] reboot: Restarting system
>> [    5.358293] psci: PSCI_0_2_FN_SYSTEM_RESET reboot_mode:0 cmd:(null)
>> bl31 reboot reason: 0xd
>> bl31 reboot reason: 0x0
>> system cmd  1.
>> ...REBOOT...
>> 
>> Tested: on VIM1 VIM2 VIM3 VIM3L khadas sbcs - 1000+ successful reboots
>> and Odroid boards, WeTek Play2 (GXBB)
>> 
>> Tested-by: Christian Hewitt <christianshewitt@gmail.com>
>> Signed-off-by: Artem Lapkin <art@khadas.com>
>> 
>> ---
>>  drivers/gpu/drm/meson/meson_drv.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>> 
>> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
>> index 42c5d3246..693bb1293 100644
>> --- a/drivers/gpu/drm/meson/meson_drv.c
>> +++ b/drivers/gpu/drm/meson/meson_drv.c
>> @@ -482,6 +482,16 @@ static int meson_probe_remote(struct platform_device *pdev,
>>  	return count;
>>  }
>>  
>> +static void meson_drv_shutdown(struct platform_device *pdev)
>> +{
>> +	struct meson_drm *priv = dev_get_drvdata(&pdev->dev);
>> +	struct drm_device *drm = priv->drm;
>> +
>> +	DRM_DEBUG_DRIVER("\n");
>> +	drm_kms_helper_poll_fini(drm);
>> +	drm_atomic_helper_shutdown(drm);
>> +}
>> +
>>  static int meson_drv_probe(struct platform_device *pdev)
>>  {
>>  	struct component_match *match = NULL;
>> @@ -553,6 +563,7 @@ static const struct dev_pm_ops meson_drv_pm_ops = {
>>  
>>  static struct platform_driver meson_drm_platform_driver = {
>>  	.probe      = meson_drv_probe,
>> +	.shutdown   = meson_drv_shutdown,
>>  	.driver     = {
>>  		.name	= "meson-drm",
>>  		.of_match_table = dt_match,
>> 
>
> Applied to drm-misc-fixes,

Could you submit this as a fix to stable (v5.10+) also?

Thanks,

Kevin
