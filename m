Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7CE939436C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 15:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbhE1Nf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 09:35:57 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:17450 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229653AbhE1Nft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 09:35:49 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14SDKU0Q001860;
        Fri, 28 May 2021 13:33:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=HLUSfFNsvepNfOshN0c8ooQ73thlVw/e2Bq6VxGepJc=;
 b=MGZhgWhg95roXsJDEqHHYCO9dXvFbeEACtvc4AUZmGaH/OSA0LptpxmiGBe9HiKzfOuB
 YeqeRyzqFi25xsZT5aQ3FOhnWGlLt5uF5NloiM9oXt+ULCe8FAdpqzrntKJgscO9QCOH
 YDl9a1v08Bv1PpLyUKvafDTaM4Vov8lOuuHrbMftKkgASkEFVfs4aT6U02D2CDAFhC3o
 kdKM8/mz3eYEV16T+dEpVDrW3rKwyopsI86aaD4ra84Pv1UVUv2ELT77xelkgdmdI5cb
 CsQdHYjjXtv1cEkjK1TWIANUF2JFS73YioYCpsa/1SXfwRMYXPKfRqLmSsjTWisDGZq7 PA== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 38sn3yrwmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 May 2021 13:33:27 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14SDLxuX117567;
        Fri, 28 May 2021 13:33:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 38rehkyxhp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 May 2021 13:33:26 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14SDXPtD194449;
        Fri, 28 May 2021 13:33:25 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 38rehkyxh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 May 2021 13:33:25 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 14SDXISv026221;
        Fri, 28 May 2021 13:33:23 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 May 2021 06:33:17 -0700
Date:   Fri, 28 May 2021 16:33:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        syzbot+08a7d8b51ea048a74ffb@syzkaller.appspotmail.com
Subject: Re: [PATCH] ALSA: control led: fix memory leak in
 snd_ctl_led_register
Message-ID: <20210528133309.GR24442@kadam>
References: <20210528131757.2269989-1-mudongliangabcd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528131757.2269989-1-mudongliangabcd@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: UVSJdCaZHlkVip_h0yaymPkF8ZNnex7o
X-Proofpoint-ORIG-GUID: UVSJdCaZHlkVip_h0yaymPkF8ZNnex7o
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 09:17:57PM +0800, Dongliang Mu wrote:
> The snd_ctl_led_sysfs_add and snd_ctl_led_sysfs_remove should contain
> the refcount operations in pair. However, snd_ctl_led_sysfs_remove fails
> to decrease the refcount to zero, which causes device_release never to
> be invoked. This leads to memory leak to some resources, like struct
> device_private.
> 
> Fix this by calling put_device at the end of snd_ctl_led_sysfs_remove
> 
> Reported-by: syzbot+08a7d8b51ea048a74ffb@syzkaller.appspotmail.com
> Fixes: a135dfb5de1 ("ALSA: led control - add sysfs kcontrol LED marking layer")
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
>  sound/core/control_led.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/sound/core/control_led.c b/sound/core/control_led.c
> index 25f57c14f294..fff2688b5019 100644
> --- a/sound/core/control_led.c
> +++ b/sound/core/control_led.c
> @@ -371,6 +371,10 @@ static void snd_ctl_led_disconnect(struct snd_card *card)
>  	snd_ctl_led_refresh();
>  }
>  
> +static void snd_ctl_led_release(struct device *dev)
> +{
> +}

Whatever you're trying to do, adding a dummy function is never the
answer.

regards,
dan carpenter

