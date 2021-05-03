Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A535371479
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 13:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbhECLsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 07:48:42 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60506 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhECLsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 07:48:41 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 143Be57A034791;
        Mon, 3 May 2021 11:47:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=3LU+RyL7kTip8VIs9Qb+M6AcIcVpUWyfB1BfSe/oyJ8=;
 b=u3urmJFltsdy1z04f+ib9983aOm3/ZLdEPXqAkbnD9gSist1LE6DD0x61aTDnB/TlodS
 4x30k2yKWDRju5qycLgchcacG+tL8CYWzdp8Z8I85iHHoF23ZC8jWNZZ0E3dQqlSelDs
 feQCzVcHB0S9r4KEH2e/HXXsACKUCZPuRUkeox3aMjFSIdfrAKVyCHLDphJ2HAlOaoC1
 y54ywddakE0k+e5xlx1I895aWR51fTyK4cyRgBqwHHAD/CBvDdeFdAbd19SX7mlLKWa7
 einmKa4C57hnnL2oWe/WV63M0fECgGJW3woLbXrnXgbczmOecPlOF0+/FWmvS/As4wAG 2Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 388xdrubwm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 11:47:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 143BeAIA080269;
        Mon, 3 May 2021 11:47:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 388xt29004-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 11:47:43 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 143Blhgk106397;
        Mon, 3 May 2021 11:47:43 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 388xt28yyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 11:47:43 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 143Blf3O002426;
        Mon, 3 May 2021 11:47:41 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 May 2021 11:47:41 +0000
Date:   Mon, 3 May 2021 14:47:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Rijo Thomas <Rijo-john.Thomas@amd.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Mythri Pandeshwara krishna <mythri.pandeshwarakrishna@amd.com>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tee: amdtee: unload TA only when its refcount becomes
 0
Message-ID: <20210503114734.GI21598@kadam>
References: <5057c53afb568fa70234de2f23b0ffeff75af426.1618421014.git.Rijo-john.Thomas@amd.com>
 <5072c20c-7912-4307-6e04-caa1fe54bf1a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5072c20c-7912-4307-6e04-caa1fe54bf1a@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: nfhNTJKI4wzokKXGUKd1gUadF5aOC-M-
X-Proofpoint-GUID: nfhNTJKI4wzokKXGUKd1gUadF5aOC-M-
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9972 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030081
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2021 at 09:04:35AM +0530, Rijo Thomas wrote:
> 
> 
> On 14/04/21 11:08 pm, Rijo Thomas wrote:
> > Same Trusted Application (TA) can be loaded in multiple TEE contexts.
> > 
> > If it is a single instance TA, the TA should not get unloaded from AMD
> > Secure Processor, while it is still in use in another TEE context.
> > 
> > Therefore reference count TA and unload it when the count becomes zero.
> > 
> > Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
> > Reviewed-by: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
> > Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
> 
> Hi Dan,
> 
> Can you please give an Ack if you are okay with this patch.
> I have incorporated your review comments for v2.
> 

Oh, Sorry.  Thanks!

Acked-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

