Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7AE834FBE9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 10:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbhCaIui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 04:50:38 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50466 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234349AbhCaIu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 04:50:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12V8o751184531;
        Wed, 31 Mar 2021 08:50:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=etggik+6nyW56bNpiaKLu/fEPgt6EYeuNCnDSjwetdw=;
 b=gjfzl0EKRsjgpWsiTAiOLBkceU/t5krLRgV11xlpnIwRcmjPz8/Qcd/UWpApB6T/zy2o
 tXYRzuUJDqTHEjfmIusq0XnUf5CUmZbfXOFPH/eNDGILiw+tuXoWGxwqZocYD1GqAX75
 kj2uQKc5aOgpRLYhqPfA37n2Fnp5kP0iwVtACLPcnglxT0fWsIHCVHArk5ITe/dVHkjv
 JorEDrlzkSJQpUN63Nc9ef9xFKo3rR5xW2laP0u5fjmtQ3aSXwks0Hdjva/06Ud1R4JD
 bnD7HNDtr13n+v7MWj+1ECibzsUukkHzUB9TGjpjRbmh1mR5mdj+Ni3A/HkNTVUuA4G4 7A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 37mabqsgp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 08:50:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12V8eqY7181513;
        Wed, 31 Mar 2021 08:50:10 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 37mac8d55e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 08:50:10 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 12V8o936010009;
        Wed, 31 Mar 2021 08:50:09 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 31 Mar 2021 01:50:09 -0700
Date:   Wed, 31 Mar 2021 11:49:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Xu Jia <xujia39@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ross Schmidt <ross.schm.dev@gmail.com>,
        Amarjargal Gundjalam <amarjargal16@gmail.com>,
        Jason Yan <yanaijie@huawei.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] staging: rtl8723bs: core: Remove unused variable
 'res'
Message-ID: <20210331084959.GH2065@kadam>
References: <1617178363-34193-1-git-send-email-xujia39@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617178363-34193-1-git-send-email-xujia39@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103310063
X-Proofpoint-ORIG-GUID: c1BmgHjkHjmPqhY6O_AWiJVv0XSe3goY
X-Proofpoint-GUID: c1BmgHjkHjmPqhY6O_AWiJVv0XSe3goY
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 spamscore=0 clxscore=1011 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103310064
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've been rejecting these patches until someone updates the callers to
check the return.  This patch just silences the warning but the code is
still totally buggy.

regards,
dan carpenter

