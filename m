Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3113AE69D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 11:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbhFUJ7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 05:59:18 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:23456 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229618AbhFUJ7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 05:59:16 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15L9lFvI032056;
        Mon, 21 Jun 2021 09:56:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=mDih/Tohy9BJ2FHtJbBx96tVg1gTKaEe5PoqIwmeJ1Q=;
 b=bqj8RdJ9BojWL4sZCAvGBnxhSSGbPm+owyq3MtWFD9NJ0ID2BK6CA6nvqh0mAh6liQzD
 ZHC/uLSsb+KNpZ03cOM0Sc30rMUxA14GzuwA1c98liZD47GOjvp8jOkUPwf1ivM2UbSU
 +cXMJnu1VdYiKdnPvh9k6vkmDag3vG8l1etrgSpBm+lULQ9DJ1RvsS5yqEdykMbOKNFU
 krAQjq245gZP4J89wul2u4KFRbDNfn0fh2J8F5L/K/h0V40Tzgye83X65d+Ud2ElhTlq
 iuN1YsczvARU6pDvhRCGe37LsjmXVbOO6ojr9P2nNufwkm4xd1ov+mZh9K/O7Z4mDV8X Mg== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39aqqvr3sm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 09:56:46 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 15L9tt1T047447;
        Mon, 21 Jun 2021 09:56:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3996mbq8tc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 09:56:45 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15L9uhWK049186;
        Mon, 21 Jun 2021 09:56:45 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 3996mbq8sx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 09:56:45 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15L9ucgl030064;
        Mon, 21 Jun 2021 09:56:39 GMT
Received: from kadam (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Jun 2021 02:56:38 -0700
Date:   Mon, 21 Jun 2021 12:56:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ojaswin Mujoo <ojaswin98@gmail.com>
Cc:     nsaenz@kernel.org, gregkh@linuxfoundation.org,
        stefan.wahren@i2se.com, arnd@arndb.de, phil@raspberrypi.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] staging: vchiq: Move vchiq char driver to its own
 file
Message-ID: <20210621095631.GF1901@kadam>
References: <cover.1624185152.git.ojaswin98@gmail.com>
 <8cd9b5899f82eaf2efdc9caa8d07f719a592a94d.1624185152.git.ojaswin98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cd9b5899f82eaf2efdc9caa8d07f719a592a94d.1624185152.git.ojaswin98@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: G6_zLgsXTLyGm259Pe6rBQ7ab93rpC5v
X-Proofpoint-GUID: G6_zLgsXTLyGm259Pe6rBQ7ab93rpC5v
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20, 2021 at 06:26:34PM +0530, Ojaswin Mujoo wrote:
> +/* read a user pointer value from an array pointers in user space */
> +static inline int vchiq_get_user_ptr(void __user **buf, void __user *ubuf, int index)
> +{
> +	int ret;
> +
> +	if (in_compat_syscall()) {
> +		compat_uptr_t ptr32;
> +
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
When I'm reviewing these sorts of patches then what I'm trying to verify
is that you are not a UMN "researcher" trying to change the code without
anyone noticing.  In the orignal code, there was no blank line here

> +		compat_uptr_t __user *uptr = ubuf;

but there was a blank line here.

> +		ret = get_user(ptr32, uptr + index);
> +		*buf = compat_ptr(ptr32);
> +	} else {

These sorts of minor white space changes make it hard to verify the code
in an automated way.

> +		uintptr_t ptr, __user *uptr = ubuf;
> +
> +		ret = get_user(ptr, uptr + index);
> +		*buf = (void __user *)ptr;
> +	}
> +
> +	return ret;
> +}
> +

regards,
dan carpenter

