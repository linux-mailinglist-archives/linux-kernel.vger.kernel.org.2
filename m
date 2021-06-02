Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34CDE39812F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 08:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhFBGib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 02:38:31 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:34018 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229711AbhFBGia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 02:38:30 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1526YhjH014970;
        Wed, 2 Jun 2021 06:36:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=+gOexGANZZS/oRgP/lTbcgKz1yPXMtQU2iZfikPHFaM=;
 b=Gezj5ThDljD/iCcK+OwqhPtV9mwHPE1NNSD1g4TyGeFKHDHSR7mTKZRR3HnARmaOG9zB
 AD17ZQ6hbpV9plez57LQxwtZySLKRbR+EYVasm62cBud1IxPaVPUlUSKh8gn3ihr+koR
 1rGp6AALyBEK/eOuA+4jEkW77Lu1t6Y9wtOdntdVQ3b24WnE1X0pMeM7Tw0WFHKOCv0U
 yMYopfZNzktSvM0HzdEkyrVt10BH+DA4ncJNQyfPJ9+65vaXgO6V4HpMRQMXaWQJ70GC
 /w56rymUKBMX0Sq1tk/bS9Yi8PLqnZZzKxj88zfnuQ3+aXwWFVDlW/dQBJHe3xGcF1On 1g== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 38wx9fr3q5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Jun 2021 06:36:01 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 1526a0B3168714;
        Wed, 2 Jun 2021 06:36:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 38udeayrnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Jun 2021 06:36:00 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1526Zxo6168609;
        Wed, 2 Jun 2021 06:35:59 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 38udeayrkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Jun 2021 06:35:59 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 1526Zo7V020192;
        Wed, 2 Jun 2021 06:35:55 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Jun 2021 23:35:50 -0700
Date:   Wed, 2 Jun 2021 09:35:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        syzbot+08a7d8b51ea048a74ffb@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] ALSA: control led: fix memory leak in
 snd_ctl_led_register
Message-ID: <20210602063543.GB10983@kadam>
References: <20210602034136.2762497-1-mudongliangabcd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602034136.2762497-1-mudongliangabcd@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: lZx4N9uLYLfLPXlB1XU0SPq9KH3jp0Eq
X-Proofpoint-ORIG-GUID: lZx4N9uLYLfLPXlB1XU0SPq9KH3jp0Eq
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 11:41:36AM +0800, Dongliang Mu wrote:
> The snd_ctl_led_sysfs_add and snd_ctl_led_sysfs_remove should contain
> the refcount operations in pair. However, snd_ctl_led_sysfs_remove fails
> to decrease the refcount to zero, which causes device_release never to
> be invoked. This leads to memory leak to some resources, like struct
> device_private. In addition, we also free some other similar memory
> leaks in snd_ctl_led_init/snd_ctl_led_exit.
> 
> Fix this by replacing device_del to device_unregister
> in snd_ctl_led_sysfs_remove/snd_ctl_led_init/snd_ctl_led_exit.
> 
> Note that, when CONFIG_DEBUG_KOBJECT_RELEASE is enabled, put_device will
> call kobject_release and delay the release of kobject, which will cause
> use-after-free when the memory backing the kobject is freed at once.

(Hopefully it's clear to everyone that this is in the original code and
fixed in your patch).

> 
> Reported-by: syzbot+08a7d8b51ea048a74ffb@syzkaller.appspotmail.com
> Fixes: a135dfb5de1 ("ALSA: led control - add sysfs kcontrol LED marking layer")
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---

Looks perfect to me!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

