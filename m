Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5F73954B1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 06:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhEaEjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 00:39:18 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:15882 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230118AbhEaEjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 00:39:09 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14V4a6qN021685;
        Mon, 31 May 2021 04:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=sCqnewwt/DX8w8J3kiZ2oxDa1Mc5rzPvqsknjikinPk=;
 b=AbVh2tgi6Qde3n9QyrTdZZhC8KEhjp4IvzFRVM5/qiUtydofRhvEOPYjREDXf1OrbBP6
 gqlxex9jvzcI5yDtTT76t8Zz4c5voP5dZlxbAbcuPQj29VBEdLjqnE0jz1/WxnqrBKrs
 i2PODgNTMNZYkr8f8P9WVj2B8lwQcDm+C6gE+luBf4iFeLgCj+5C89xAbzzqznX7FsX8
 RDszVNr4Ji6ICr/Nk8pJew21lTsDlRaa2gF7WlXyqHPLuB9T4I+a+3GQWY6pRuaZb4D+
 70+K7SnQVCx3jC0P10tV/9WKIz3xsaMuLTwnoUhASGeC5y2reQY2IfBb82HjQf7LxH0h zg== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 38vmrgr1w5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 May 2021 04:36:42 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14V4ag0N189374;
        Mon, 31 May 2021 04:36:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 38uycq28yy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 May 2021 04:36:41 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14V4afNT189362;
        Mon, 31 May 2021 04:36:41 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 38uycq28yr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 May 2021 04:36:41 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 14V4aZco001554;
        Mon, 31 May 2021 04:36:37 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 30 May 2021 21:36:35 -0700
Date:   Mon, 31 May 2021 07:36:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     =?utf-8?B?5oWV5Yas5Lqu?= <mudongliangabcd@gmail.com>
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzbot+08a7d8b51ea048a74ffb@syzkaller.appspotmail.com
Subject: Re: [PATCH] ALSA: control led: fix memory leak in
 snd_ctl_led_register
Message-ID: <20210531043619.GT24442@kadam>
References: <20210528131757.2269989-1-mudongliangabcd@gmail.com>
 <20210528133309.GR24442@kadam>
 <CAD-N9QVWcEJjoziA6HVoQiUueVaKqAJS5Et60zvCvuUE7e6=gg@mail.gmail.com>
 <20210528140500.GS24442@kadam>
 <A622EB84-DC4A-47A4-A828-CE6D25DC92EB@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A622EB84-DC4A-47A4-A828-CE6D25DC92EB@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: 9D0pHIc77iIltRKv_2B-a4zmGEoR2hwM
X-Proofpoint-ORIG-GUID: 9D0pHIc77iIltRKv_2B-a4zmGEoR2hwM
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29, 2021 at 05:35:22AM +0800, 慕冬亮 wrote:
> > diff --git a/sound/core/control_led.c b/sound/core/control_led.c
> > index 25f57c14f294..dd357abc1b58 100644
> > --- a/sound/core/control_led.c
> > +++ b/sound/core/control_led.c
> > @@ -740,6 +740,7 @@ static int __init snd_ctl_led_init(void)
> > 			for (; group > 0; group--) {
> > 				led = &snd_ctl_leds[group - 1];
> > 				device_del(&led->dev);
> > +				device_put(&led->dev);
> > 			}
> > 			device_del(&snd_ctl_led_dev);
> > 			return -ENOMEM;
> > @@ -768,6 +769,7 @@ static void __exit snd_ctl_led_exit(void)
> > 	for (group = 0; group < MAX_LED; group++) {
> > 		led = &snd_ctl_leds[group];
> > 		device_del(&led->dev);
> > +		device_put(&led->dev);
> > 	}
> > 	device_del(&snd_ctl_led_dev);
> > 	snd_ctl_led_clean(NULL);
> 
> Does this patch mean I should add device_put in the init and exit
> function other than snd_ctl_led_sysfs_remove? This will cause
> device_release bypass the release method checking?

Please fix your email client to line wrap your emails.

I'm not sure what release method checking you're refering to.

regards,
dan carpenter

