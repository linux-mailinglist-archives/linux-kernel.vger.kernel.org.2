Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69EFB3A65E5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 13:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236743AbhFNLoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 07:44:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45686 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbhFNLhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 07:37:21 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15EBYAqb065243;
        Mon, 14 Jun 2021 11:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=tpxItPxD79i/QAY2x5Bbh4wo+vTKY0MzDCdkSRZoFM8=;
 b=IMy4wnSt0t8I1juhnAOQAc3mw/B6EIgQW9qaq/KFvaDva1pS7y2x7BBd8ecKWyC3dEa8
 SCDAJD7iVEgozQj0jR+HAWPfYefRH+pkYSPZRTCHxrAOLojysB/4eVXEp5brVO5nXexI
 W3TaCUD62yzBsK1R75dQ9asOLbbLxnP5ZKtADguyi8V2/hXIs7wx2z9J2oayLLRVflYq
 HKvdhUxb4GswZhpLrpRQV5Hdx71Ppb2UKWIu45hruzM3G/61UClpu7D2IvEtHUu806V2
 3GCSyu/WYbmHwXOussrsgv3CBAZVSFUEjx5/NQOhtZdlDErnXojxlEVOnid7l30YWleJ PQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 394mvnb3ss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 11:35:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15EBYu1U193282;
        Mon, 14 Jun 2021 11:35:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 394mr6970s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 11:35:02 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15EBZ0IU194171;
        Mon, 14 Jun 2021 11:35:00 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 394mr696qa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 11:35:00 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 15EBYk7E001613;
        Mon, 14 Jun 2021 11:34:46 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 14 Jun 2021 11:34:45 +0000
Date:   Mon, 14 Jun 2021 14:34:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] staging: rtl8188eu: remove RT_TRACE and DBG_88E
 prints from usb_intf.c
Message-ID: <20210614113439.GM1955@kadam>
References: <20210612180019.20387-1-martin@kaiser.cx>
 <20210612180019.20387-6-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210612180019.20387-6-martin@kaiser.cx>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: ttSQkChxyfAqucEoy4wdIV8hanVw9u_K
X-Proofpoint-GUID: ttSQkChxyfAqucEoy4wdIV8hanVw9u_K
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10014 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=999 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106140081
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 12, 2021 at 08:00:19PM +0200, Martin Kaiser wrote:
> These prints are disabled by default.
> 

Not, just by default.  There is literally no way to enable them.

> Replace the print after dev_alloc_name with proper error handling.
> 

Ugh...  :(  This part really needs to be done first and in a separate
patch.  You can delete the RT_TRACE() from that one call site since it's
on the same line but the subject of the patch needs to say something
like "check for allocation failure".  It can't be "remove RT_TRACE and
DBG_88E prints".

The first five of these patch look good though.

regards,
dan carpenter

