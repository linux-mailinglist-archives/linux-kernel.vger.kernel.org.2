Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33BF36F985
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 13:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbhD3Ln5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 07:43:57 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33856 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhD3Lnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 07:43:55 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13UBe3xB180347;
        Fri, 30 Apr 2021 11:42:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=q2xPT9aYNv3n8ZfbCyQkPK3lG0v/KfOw17OG2y43ouA=;
 b=ck81vHbwT+kff9rhvQxC8WfN0IuhY8ecu+MlA/uIllxtfrX1rskcEhCMY3Z2UVXXHfdX
 FtnqPQgrgCxUrptSWVpe2MiNOi8tKbZ9GABCONUvQv1aGCEZ4TZ+39W5VdGpMORCBo5f
 I99hYDFuvgayYoIdl05ZTUBrmqiie66uIX/UR3jSfXos0Vl2TI/hetDVGozBtmfmC8Yy
 xlr4tSKJSpiinPzzVrdks/S4Y6xWBBn04pE6BbHNNw6dh/l1Dzu94TLMgeawr1UQYKUv
 /5VcYs0Ag3SVPDhXPZiVjNFzTDgQcC33I+/QW7AKsfDMdVOh/Lfa8l5gw5pEQtfA6mbC eg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 385ahbydpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Apr 2021 11:42:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13UBexpU108326;
        Fri, 30 Apr 2021 11:42:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3874d4ujk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Apr 2021 11:42:57 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13UBfSF3109448;
        Fri, 30 Apr 2021 11:42:57 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 3874d4ujjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Apr 2021 11:42:57 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 13UBgtDo010320;
        Fri, 30 Apr 2021 11:42:56 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 30 Apr 2021 11:42:55 +0000
Date:   Fri, 30 Apr 2021 14:42:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH v2 0/2] Remove set but unused variables
Message-ID: <20210430114248.GG1981@kadam>
References: <20210430095319.23226-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430095319.23226-1-fmdefrancesco@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: 7jt3cVUlJhaSTyRYOjhOLylwtiAP5GYz
X-Proofpoint-ORIG-GUID: 7jt3cVUlJhaSTyRYOjhOLylwtiAP5GYz
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9969 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1031 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104300085
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

