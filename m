Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3AC3943C0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 16:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236334AbhE1OHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 10:07:42 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:14036 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229740AbhE1OHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 10:07:39 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14SE1a2x025614;
        Fri, 28 May 2021 14:05:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=x0Z6u2+quld8a1ogwAHqK5j1nZAVx8Hl57Fvz5MNvCM=;
 b=FkqoxiNfanOAAUlH6X3v7JHncE0SulON8luwQMcmns8XLzdr6BJdpWbJnfmH7OTNvMmc
 L8SqUOu2wmSmgxxiI/sABhd2hxA7UxOAEvYMjsxv6cxV7H2vnBrS80yFXtz18WBBym+1
 uD54X5G2Q0/w64/nWruE87YaK7R8i7K3Q5OREfNc901HlgBYX7G1cMaXqSGROdVsXsTI
 TTFetJvtBY3uD6WOFAjmn2pZnLpviaC3CTAfz4Xq3qvWF3/5NqnjOQPztJB8THVntB2E
 CCnWXN6fYDXa3WhJhDSdFN+Cdfzlhwg/9QrEfAkIwJvJHNkr8rpQndz1Cu1o/OLR6wke 7Q== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 38u1meg07p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 May 2021 14:05:15 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14SDuGWQ184141;
        Fri, 28 May 2021 14:05:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 38pr0eksnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 May 2021 14:05:15 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14SE1wai002270;
        Fri, 28 May 2021 14:05:14 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 38pr0eksng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 May 2021 14:05:14 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 14SE57lC014288;
        Fri, 28 May 2021 14:05:12 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 May 2021 07:05:07 -0700
Date:   Fri, 28 May 2021 17:05:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzbot+08a7d8b51ea048a74ffb@syzkaller.appspotmail.com
Subject: Re: [PATCH] ALSA: control led: fix memory leak in
 snd_ctl_led_register
Message-ID: <20210528140500.GS24442@kadam>
References: <20210528131757.2269989-1-mudongliangabcd@gmail.com>
 <20210528133309.GR24442@kadam>
 <CAD-N9QVWcEJjoziA6HVoQiUueVaKqAJS5Et60zvCvuUE7e6=gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD-N9QVWcEJjoziA6HVoQiUueVaKqAJS5Et60zvCvuUE7e6=gg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: kGEkvuh53fm-bW_P-RF8g9Ks8iyeQjRF
X-Proofpoint-ORIG-GUID: kGEkvuh53fm-bW_P-RF8g9Ks8iyeQjRF
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 09:50:49PM +0800, Dongliang Mu wrote:
>
> Can you please give some advise on how to fix this WARN issue?

But it feels like it spoils the fun if I write the commit...  Anyway:

regards,
dan carpenter

diff --git a/sound/core/control_led.c b/sound/core/control_led.c
index 25f57c14f294..dd357abc1b58 100644
--- a/sound/core/control_led.c
+++ b/sound/core/control_led.c
@@ -740,6 +740,7 @@ static int __init snd_ctl_led_init(void)
 			for (; group > 0; group--) {
 				led = &snd_ctl_leds[group - 1];
 				device_del(&led->dev);
+				device_put(&led->dev);
 			}
 			device_del(&snd_ctl_led_dev);
 			return -ENOMEM;
@@ -768,6 +769,7 @@ static void __exit snd_ctl_led_exit(void)
 	for (group = 0; group < MAX_LED; group++) {
 		led = &snd_ctl_leds[group];
 		device_del(&led->dev);
+		device_put(&led->dev);
 	}
 	device_del(&snd_ctl_led_dev);
 	snd_ctl_led_clean(NULL);
