Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8473B438A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 14:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhFYMqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 08:46:33 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:32900 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229470AbhFYMqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 08:46:31 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15PCaaTK013370;
        Fri, 25 Jun 2021 12:44:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=q239hJZG+3xusjjBHEwLJoFljzdGc4ysmifaTAXDUws=;
 b=dBcblZceGskReFASeX5ba2VkBQMWqeWzKLljAelF/fTWzipHQoT7NLwOjq3t5QLondUz
 ePL7G7yiPu9GPqwV0qJYUgjs+3rjBFsDiyO2fw5scEgHcWuYf5XB1k1JrPjKOqRUaitq
 GbgSZPmLceLH4ah98zFVGyh+O6fv7Xr8EdPDlbk3jNRpWzstpd7SrF/Pd+gZ9aL6+fES
 k8Qe5T3Y9/uqw4JqQr/kZ8aCKEZaiH1GC02n0FQKdLuROtoV41R2GBt0jOiAOaqluVxW
 zGvZ0nrHtTvfgHYtpSGmobydt3mki9r5p/HL4MpAV8A45YUbpxT/yRHEyB+xvDkju/4p NQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39d27es8s4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 12:44:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15PCZbID149254;
        Fri, 25 Jun 2021 12:44:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 39d243ewda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 12:44:05 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15PCeNWC161160;
        Fri, 25 Jun 2021 12:44:04 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 39d243ewcr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 12:44:04 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15PCi3A3017546;
        Fri, 25 Jun 2021 12:44:03 GMT
Received: from kadam (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Jun 2021 12:44:03 +0000
Date:   Fri, 25 Jun 2021 15:43:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 00/23] staging: rtl8188eu: remove include/rtw_debug.h
Message-ID: <20210625124356.GJ2040@kadam>
References: <20210625000756.6313-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625000756.6313-1-phil@philpotter.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: YTRnOzOuSGkjMlNifZcsDgOhhpe4bv-L
X-Proofpoint-ORIG-GUID: YTRnOzOuSGkjMlNifZcsDgOhhpe4bv-L
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good.

I feel like the kbuild warnings could be addressed in later patches.

It seems as if some of the error handling in this driver is "pretend to
print an error message (but it's actually dead code)".  Which is
probably not the correct way to handle errors...  :/  But that's not
something introduced by this patch.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

