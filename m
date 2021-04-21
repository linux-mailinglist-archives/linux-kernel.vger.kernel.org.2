Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD76A366F45
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 17:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244034AbhDUPex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 11:34:53 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:33534 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236008AbhDUPev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 11:34:51 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13LFLMSa006596;
        Wed, 21 Apr 2021 15:33:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=v2NMq5440v5VTI++iKP4cKmxc5nBmtej/HrseiaM7+w=;
 b=Mp43XrtCuRD5mLxQGa1h+eBKPkGeP2nKFuzhpXyl2L5nZZGFIrM7UMA6N/CEuC2/ci2F
 VtT6bLFPHT/zWjfXyuHBgrXI7K8120AqOOfytJH6rnstp+GQZUdEjQoRFQPbGPIlMUvs
 mAjOohKj1x7tXg4i1rkXDonwb2bRJzLKfeOBZgMyMuAGZCJZQOCshM0E/DoIOS+dlYcl
 aHRIAbodKvX89cYWFXwW2VXAvGn6eNueyLuG8UmM3zy0u2eaoRxwkdUrJEK00gUGMhrU
 FaxNRGc9/MrEzGalrIbRUYrJrgt7okOjsOxPfv/84wLgojyg4Mj9bOAhp4TgvDHphRZe Tw== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 381bjn8rav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 15:33:09 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13LFLQA4093744;
        Wed, 21 Apr 2021 15:33:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3809m0scyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 15:33:08 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13LFLlod095079;
        Wed, 21 Apr 2021 15:33:07 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 3809m0scyc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 15:33:07 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13LFX61d031675;
        Wed, 21 Apr 2021 15:33:06 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Apr 2021 15:33:05 +0000
Date:   Wed, 21 Apr 2021 18:32:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>,
        Mark Gross <mgross@linux.intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] platform/x86: intel_pmc_core: re-write copy in
 pmc_core_lpm_latch_mode_write()
Message-ID: <20210421153258.GK1959@kadam>
References: <YH/xicL9RXjH2pvD@mwanda>
 <87e61d84-e23e-1ccc-c4ed-57ffa0ed95fb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87e61d84-e23e-1ccc-c4ed-57ffa0ed95fb@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: jnEBN2semP3al3cIZqXWTdPHWgv9sb4P
X-Proofpoint-ORIG-GUID: jnEBN2semP3al3cIZqXWTdPHWgv9sb4P
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 04:11:15PM +0200, Hans de Goede wrote:
> This should fix that however, while sticking with simple_write_to_buffer():

I really want to get rid of the simple_write_to_buffer().  Using it
would make sense if we wanted the user to be able to seek to the middle
of buf[] but that would just be an info leak.

regards,
dan carpenter

