Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA4C348B32
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 09:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbhCYIIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 04:08:39 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37902 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhCYIIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 04:08:21 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12P85YDa076540;
        Thu, 25 Mar 2021 08:08:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=T562ARBgsvx8K9smQMgZiG3Spgn51OCIZ9kebvNzq+Y=;
 b=UYLJ/TUGdB2lJguTI5eoK7Ij5dpbT+j9Kj2WQLh3gv4JjpvHeXTmOtOzamNK3Pb1UuhB
 px8UA4G5p0Az7FDLL1hg0TbAsDVldfNW9vgELke01Lh/ULpOA1fCM3OMJddnEUToYgHw
 DklIUVTvr1vIMNzNQhW7JU/bBr4Nj0rRoQxI/OISV9+au/v9dtmWwlCrVwajjjEDrK9u
 p7gf2xsT0Tt881Pkoe7AF//dAP2ovmfuRDBbYgaswFb2q26hkI+RIeCq8OYqlJvKajzE
 cf6JAaJzmODIco2IcMFHPAcUVv38wJ7jmv0v0xarwOM5KbwoM06SwdrSDt1FK24orEPt bw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 37d90mnavn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 08:08:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12P86T6Z016554;
        Thu, 25 Mar 2021 08:08:12 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 37dty1k9qv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 08:08:12 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 12P88B0k026550;
        Thu, 25 Mar 2021 08:08:11 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 25 Mar 2021 08:08:11 +0000
Date:   Thu, 25 Mar 2021 11:08:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kael_w@yeah.net
Subject: Re: [PATCH] [v3] drivers: staging: _adapter is declared twice
Message-ID: <20210325080803.GV1717@kadam>
References: <20210325080050.861273-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325080050.861273-1-wanjiabing@vivo.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103250061
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=982 suspectscore=0 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103250061
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 04:00:46PM +0800, Wan Jiabing wrote:
> struct _adapter has been declared at 23rd line.
> Remove the duplicate.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
> Changelog:
> v3:
> - Delete trailing whitespace.
> 
> v2:
> - Delete the blank line.

Bingo!  :)  Well done.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

