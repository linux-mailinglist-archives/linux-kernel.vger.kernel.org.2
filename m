Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381E133CE19
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 07:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbhCPGsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 02:48:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52332 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbhCPGsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 02:48:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12G6i5Ew142077;
        Tue, 16 Mar 2021 06:48:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=0egzDSH2z3u1DhfuSB6BBjeSwqI3MsOZjiDXmD94e6k=;
 b=GFb204IgUH/i3I80fPuP7gjfTxtv4ArpjTwspHEckyPeCiXD5CGD7zaASHa2vTgFuG7l
 zyaciqNEcNWciBmwEkuFHoyTfON5J7BDXFKEGPc2P09vYEZFs6GPB650CEqq3GhHAhp9
 RydPUBlDuYnS/q6h2KS+FWK4XhXBWTT7g+tCf15P2MfzDmh3yvQj236cOfql0LyUael2
 wHC5w5YHl+rbCO6q5KRDTpDXcT3r3atggeAIVU55FYFNIFkfgpSZMb/tUJGcwy24wg3r
 TqJB35xEZQ6Gky4Nv4WjxIgtQ5fJqdTEC1XQoRkxnV9vt5d+M9jL1Pc2XsavCA6WK+hp rg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 378p1npevk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Mar 2021 06:48:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12G6jqDv177680;
        Tue, 16 Mar 2021 06:48:07 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 3797aynp59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Mar 2021 06:48:07 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 12G6m5J5006373;
        Tue, 16 Mar 2021 06:48:05 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Mar 2021 23:48:04 -0700
Date:   Tue, 16 Mar 2021 09:47:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     zhaoxiao <zhaoxiao@uniontech.com>
Cc:     gregkh@linuxfoundation.org, straube.linux@gmail.com, lu@pplo.net,
        serrazimone@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8192u: remove extra lines
Message-ID: <20210316064756.GQ21246@kadam>
References: <20210316024410.24609-1-zhaoxiao@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316024410.24609-1-zhaoxiao@uniontech.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9924 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103160045
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9924 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 adultscore=0
 spamscore=0 clxscore=1011 phishscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103160045
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 10:44:10AM +0800, zhaoxiao wrote:
> Remove extra lines in many functions in r8192U_wx.c.
> 
> Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
> ---
>  drivers/staging/rtl8192u/r8192U_wx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
                   ^^^^^^^^^^^^
The commit message says you're removing lines but you're also adding
them.  :P

regards,
dan carpenter

