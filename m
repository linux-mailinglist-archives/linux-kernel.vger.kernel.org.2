Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8213AE4B1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 10:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhFUIY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 04:24:28 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:47278 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229618AbhFUIY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 04:24:26 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15L8C6XW002932;
        Mon, 21 Jun 2021 08:21:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=rsBsyzNSoz0GNqEab3e2cU6lY3mRx3ISkb2b1vS63A0=;
 b=vuzqs3Hg1Q8F6MGm4vft/aEJ4vbL5XaH36E2YmEfM8Owj74Qza44gsEWjmQREH36VNXd
 FJFKrHxaaHC5eat+NFyrdVjjBRvFIG0fQSTSPNzBoSq9rHaM0x8YOly0F9V3P2bRmjHD
 ASriCiI5f1d3kpj/DHvd0PrTCEWW6+yJ+0xQ2h3b7QSOGS582lY8IdKQSbAGntiaD4KI
 7vTp8eiOPiyK7c6vlOIT2N1cMZURReapI978n6tXxQbjdhkjA743qI+eGrvPbrBjidbX
 WrIkXnxxRee9TFIPe+G/dHkaeuL+mMrMeEjLvHU7OaTt/dxOkllw56K7e7MCikWmsogx tQ== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39acyq8qwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 08:21:52 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 15L8GIf3039192;
        Mon, 21 Jun 2021 08:21:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 399tbqpk6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 08:21:51 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15L8HwgH042250;
        Mon, 21 Jun 2021 08:21:51 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 399tbqpk5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 08:21:51 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15L8Leic010812;
        Mon, 21 Jun 2021 08:21:43 GMT
Received: from kadam (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Jun 2021 01:21:40 -0700
Date:   Mon, 21 Jun 2021 11:21:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ojaswin Mujoo <ojaswin98@gmail.com>
Cc:     nsaenz@kernel.org, gregkh@linuxfoundation.org,
        stefan.wahren@i2se.com, arnd@arndb.de, phil@raspberrypi.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] staging: vchiq: Refactor vchiq cdev code
Message-ID: <20210621082132.GC1901@kadam>
References: <cover.1624185152.git.ojaswin98@gmail.com>
 <e786f8c7f92561065b840490c32959932526dac6.1624185152.git.ojaswin98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e786f8c7f92561065b840490c32959932526dac6.1624185152.git.ojaswin98@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: Cd10xYLrEn5jIVPHNS36QE2PbaANv26K
X-Proofpoint-ORIG-GUID: Cd10xYLrEn5jIVPHNS36QE2PbaANv26K
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20, 2021 at 06:25:46PM +0530, Ojaswin Mujoo wrote:
>  	vchiq_debugfs_init();
>  
>  	vchiq_log_info(vchiq_arm_log_level,
> -		"vchiq: initialised - version %d (min %d), device %d.%d",
> -		VCHIQ_VERSION, VCHIQ_VERSION_MIN,
> -		MAJOR(vchiq_devid), MINOR(vchiq_devid));
> +		       "vchiq: platform initialised - version %d (min %d)",
> +		       VCHIQ_VERSION, VCHIQ_VERSION_MIN);
> +
> +	/*
> +	 * We don't handle error here since the function handles
> +	 * cleanup in cases of failure. Further, we can proceed
> +	 * even if this function fails.
> +	 */
> +	vchiq_register_chrdev(&pdev->dev);

I feel like ignoring errors and just continuing seems helpful, but it's
actually doing the users a disservice.  If it's an error during, boot
that's different, in that case it's better to get some kind of minimally
useful boot so the user can debug the problem.  But if the error isn't
going to prevent the system from booting then it's better to just return
an error so they can fix the problem and try again.

regards,
dan carpenter

