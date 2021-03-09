Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF9B332D93
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 18:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbhCIRvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 12:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbhCIRu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 12:50:59 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5455FC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 09:50:59 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id l12so17383684wry.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 09:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=PSGONzx2Ya+di7nElWWfqOMSTg8+wvD3eIGbn+Kjutk=;
        b=xQYm8NA5H7xR0Mb/UnWTUAqPBBTN8AGqoPttojus/GNCJws2+bpQ9yNGNu/0AxSNO+
         0wui42n9GgfEW2bMQ4prZM6EsW6SXP7mibj9cP7VwgB4Jds2ts9cLMwU7R3cjLsUcEXv
         msZCftTl2tT4sLHrTfVYUbPfWTGrNfqzzrte2A9RpIuM1xJAiu2IDWLkL1fvIO+mlZ6f
         5ztWF0gqafsJpHa4+pN4cbYnKaEbh3rCzehR9f+8Iue4sA8+NKHwkYmchYy5ELF//4UR
         39mzQUbHx88gsoAdqKuQ3qPLus/cUYbLrksvGevzTafRuN3TxGqYjk/+tL6qrQKaRXTl
         ikrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=PSGONzx2Ya+di7nElWWfqOMSTg8+wvD3eIGbn+Kjutk=;
        b=bDcoLFpchgRSFFdDybLsVwp2+vs0cFdNGIw66Zisb08EmmGIL49Qr8k2JHIIUqcs0C
         St/O9r99LVdTDrOOAaaOsOo+eiw0SX5ht8/9fVFi+F7MUBbNuI6fLQ8Zl9s2U+mbhCmw
         UitvbUrPqbIzli6vWodu5xjUZd4Tr+kjwc1ciENdne6BP/OJh2uLL98cYXOaJVXYuPqU
         TGRboeqrh9ihFqk1eD0K4yf6q64r2zh4DVneQZsBcym4RdKerEKYUVrdu5aaMkAAKyQ6
         Yubk2WydgmEvfy4y4X3rvZbTnFUvRiwQBM2n43zVyMqBw3x9Kx6SVv/afB4NlO3aQrd8
         yW2w==
X-Gm-Message-State: AOAM531RBjKEmmyi34n/qW7UIWfgNCOKWGNFeTCsbUUVgZuGoPCriWHL
        wtOQoE3YaX1zr2qd9iHa9OdR7Q==
X-Google-Smtp-Source: ABdhPJx6O1YNb6LTVAzGe9AUvxoHuTLhAIagg8uSiEpnK4QkbVPjoX9N4aSrcaXhp0uzi/qs8arR6g==
X-Received: by 2002:adf:de92:: with SMTP id w18mr29187690wrl.217.1615312258048;
        Tue, 09 Mar 2021 09:50:58 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id u23sm5155822wmn.26.2021.03.09.09.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 09:50:57 -0800 (PST)
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
In-Reply-To: <875c606f-baf9-f92a-4820-39d3d7312607@baylibre.com>
References: <20210302042202.3728113-1-art@khadas.com>
 <e033540e-3a4f-3dd7-a1b0-d5a0241e845a@baylibre.com>
 <7h35x42qtt.fsf@baylibre.com>
 <875c606f-baf9-f92a-4820-39d3d7312607@baylibre.com>
Date:   Tue, 09 Mar 2021 09:50:55 -0800
Message-ID: <7hsg541aio.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 09/03/2021 18:13, Kevin Hilman wrote:
>> Hi Neil,
>> 
>> Neil Armstrong <narmstrong@baylibre.com> writes:
>> 
>>> On 02/03/2021 05:22, Artem Lapkin wrote:
>>>> Problem: random stucks on reboot stage about 1/20 stuck/reboots
>>>> // debug kernel log
>>>> [    4.496660] reboot: kernel restart prepare CMD:(null)
>>>> [    4.498114] meson_ee_pwrc c883c000.system-controller:power-controller: shutdown begin
>>>> [    4.503949] meson_ee_pwrc c883c000.system-controller:power-controller: shutdown domain 0:VPU...
>>>> ...STUCK...
>>>>
>>>> Solution: add shutdown function to meson_drm driver 
>>>> // debug kernel log
>>>> [    5.231896] reboot: kernel restart prepare CMD:(null)
>>>> [    5.246135] [drm:meson_drv_shutdown]
>>>> ...
>>>> [    5.259271] meson_ee_pwrc c883c000.system-controller:power-controller: shutdown begin
>>>> [    5.274688] meson_ee_pwrc c883c000.system-controller:power-controller: shutdown domain 0:VPU...
>>>> [    5.338331] reboot: Restarting system
>>>> [    5.358293] psci: PSCI_0_2_FN_SYSTEM_RESET reboot_mode:0 cmd:(null)
>>>> bl31 reboot reason: 0xd
>>>> bl31 reboot reason: 0x0
>>>> system cmd  1.
>>>> ...REBOOT...
>>>>
>>>> Tested: on VIM1 VIM2 VIM3 VIM3L khadas sbcs - 1000+ successful reboots
>>>> and Odroid boards, WeTek Play2 (GXBB)
>>>>
>>>> Tested-by: Christian Hewitt <christianshewitt@gmail.com>
>>>> Signed-off-by: Artem Lapkin <art@khadas.com>
>>>>
>>>> ---
>>>>  drivers/gpu/drm/meson/meson_drv.c | 11 +++++++++++
>>>>  1 file changed, 11 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
>>>> index 42c5d3246..693bb1293 100644
>>>> --- a/drivers/gpu/drm/meson/meson_drv.c
>>>> +++ b/drivers/gpu/drm/meson/meson_drv.c
>>>> @@ -482,6 +482,16 @@ static int meson_probe_remote(struct platform_device *pdev,
>>>>  	return count;
>>>>  }
>>>>  
>>>> +static void meson_drv_shutdown(struct platform_device *pdev)
>>>> +{
>>>> +	struct meson_drm *priv = dev_get_drvdata(&pdev->dev);
>>>> +	struct drm_device *drm = priv->drm;
>>>> +
>>>> +	DRM_DEBUG_DRIVER("\n");
>>>> +	drm_kms_helper_poll_fini(drm);
>>>> +	drm_atomic_helper_shutdown(drm);
>>>> +}
>>>> +
>>>>  static int meson_drv_probe(struct platform_device *pdev)
>>>>  {
>>>>  	struct component_match *match = NULL;
>>>> @@ -553,6 +563,7 @@ static const struct dev_pm_ops meson_drv_pm_ops = {
>>>>  
>>>>  static struct platform_driver meson_drm_platform_driver = {
>>>>  	.probe      = meson_drv_probe,
>>>> +	.shutdown   = meson_drv_shutdown,
>>>>  	.driver     = {
>>>>  		.name	= "meson-drm",
>>>>  		.of_match_table = dt_match,
>>>>
>>>
>>> Applied to drm-misc-fixes,
>> 
>> Could you submit this as a fix to stable (v5.10+) also?
>
> It should be done automagically since I added the Fixes tag

Oh, I didn't see the fixes tag, sorry.

Thanks!

Kevin
