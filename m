Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A62319C19
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 10:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhBLJrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 04:47:31 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:56260 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbhBLJrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 04:47:11 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11C9YeU1042176;
        Fri, 12 Feb 2021 09:46:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=NfvQ9ws4X6o6uCqH9n7aJ5xoug6FquVYBUBrDnHRfIs=;
 b=YyVrTzZVY5mUcCFWXKVwRBy1zWRfjVu1uH/Gw85kQSK6zFoEysQx9YF+uEHDQEbKcSU/
 mlsRidkS56WJeDsXsYxLKE43ysysW/lJupyuYa5aiKf24qAdaQaZcQSzZCPl/FjUsPdJ
 LfjRXl1z6fA6jZ1jaRKyRwj9mzXfwODWHMI7J5ayb83r1ZQywJ72TBzFcUboHEeQbmSv
 g3iYBYNECBw4AbrJ5zTvpVJaEe39Bzp6wLeS34GjPqDfkBbm8aJH7RLrjpsH/0FILzrQ
 FMfDTTZORtC2KQbHz+l69KxErMNgZhfxTFnfSH+aWMfscD4BViMT/kvVHWZLOhrLdAZM ag== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 36mv9dvrvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 09:46:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11C9TaWl087880;
        Fri, 12 Feb 2021 09:46:11 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 36j5159h25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 09:46:11 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 11C9k67g006243;
        Fri, 12 Feb 2021 09:46:06 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 12 Feb 2021 01:46:05 -0800
Date:   Fri, 12 Feb 2021 12:45:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     karthik alapati <mail@karthek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] staging: rtl8723bs: remove obsolete commented out
 code
Message-ID: <20210212094558.GJ2696@kadam>
References: <cover.1613048573.git.mail@karthek.com>
 <485415dbafc32710f1a8e3f7c951868f7738efe9.1613048573.git.mail@karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <485415dbafc32710f1a8e3f7c951868f7738efe9.1613048573.git.mail@karthek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9892 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102120074
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9892 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0
 mlxscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102120074
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 06:36:04PM +0530, karthik alapati wrote:
> There is a bunch of messy, commented out code.  Just delete it.
> 
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: karthik alapati <mail@karthek.com>

Perfect, thanks.  Greg already merged this as well so good job.

regards,
dan carepnter

