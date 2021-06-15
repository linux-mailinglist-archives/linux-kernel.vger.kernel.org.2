Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 130DA3A7E58
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 14:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhFOMoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 08:44:32 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46804 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhFOMob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 08:44:31 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15FCYO6r033863;
        Tue, 15 Jun 2021 12:42:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=c4Q3LYTxO4R3Kx561zlbUETpLST5nzuW9o7He1UxTrg=;
 b=mm63tv+IvgEeQazNGJoBzZW6ryas7GcDvM7Nb2baWR9qdXu9l9ksDrJw32sNCKWl4+Cg
 wAt9c4V0wjW6XQUvTrjFtZsZc7IGQmEg1Lo0PjSo4on6uHBXg47xjxwrnHZ06lq52NjC
 3GHsHgmBDUgw3Axl0OKjS+Dcn3rfENNr9g9UqOl1DTny81eu2aB1/888bS38Xq9XzqEc
 cFz6EKiYOlKf97Hxx985sxt9vwom3K2ov5zayHstTYqpi1DBWhLWOJ5aZVqiWoWAUF7J
 D3zHqisIxeYBECTaeKO5zViFNeCWPzoZgSlKhOCsBAni5scFZvdVV1P/yiNdRalFEk2D VQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 394mvne3g9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jun 2021 12:42:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15FCZ2Z3029884;
        Tue, 15 Jun 2021 12:42:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 394mr8x3fv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jun 2021 12:42:09 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15FCZ5jQ030735;
        Tue, 15 Jun 2021 12:42:08 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 394mr8x3ey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jun 2021 12:42:08 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 15FCg6TO031553;
        Tue, 15 Jun 2021 12:42:06 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Jun 2021 05:42:05 -0700
Date:   Tue, 15 Jun 2021 15:41:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 22/28] staging: rtl8188eu: remove all DBG_88E calls from
 hal/usb_halinit.c
Message-ID: <20210615124159.GB1861@kadam>
References: <20210615001507.1171-1-phil@philpotter.co.uk>
 <20210615001507.1171-23-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615001507.1171-23-phil@philpotter.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: SwWkYI6zip7K8FuYF_Y-wVb51jSqzkxk
X-Proofpoint-GUID: SwWkYI6zip7K8FuYF_Y-wVb51jSqzkxk
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10015 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=999 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106150082
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 01:15:01AM +0100, Phillip Potter wrote:
> @@ -1685,8 +1658,6 @@ void rtw_hal_set_hwreg(struct adapter *Adapter, u8 variable, u8 *val)
>  					if (!(usb_read32(Adapter, REG_RXPKT_NUM) & RXDMA_IDLE))
>  						break;
>  				} while (trycnt--);
> -				if (trycnt == 0)
> -					DBG_88E("Stop RX DMA failed......\n");

Not related to your patch but this loop will exit with trycnt == -1 not
0.

There should be a Smatch warning for this.  Also Smatch doesn't handle
while count down loops very well...  It takes the short cut of
assuming that all do while loops have a break statement.

regards,
dan carpenter

>  
>  				/* RQPN Load 0 */
>  				usb_write16(Adapter, REG_RQPN_NPQ, 0x0);

