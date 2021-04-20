Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3F6365715
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 13:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhDTLFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 07:05:01 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:64722 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231415AbhDTLE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 07:04:59 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13KAuvAJ017452;
        Tue, 20 Apr 2021 11:03:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=LtV7CncGgWbczJ5pJS0aGf6xtVkvJ4n6Wcq3KI7t+hs=;
 b=kp7saIAdK7NOIsggePDlhd5CGL274IiUz/IQRMpHsfAJ+vrAEpQ1tTiqgwTGddbaEqah
 21h9NK4melT/Bei/pbn/KsO435G58VPBUUhj8d9EzULc4OYCODpGdNQgZw+IYWEACQQ7
 hHU6FwHnELr4p55HpEZI+/zsYoRPIbtr3n4wHApviXnPmabQACAbvuOkz0IIfrwSoAuc
 cO8utFjhOvpF+9b+VqRoQC28o476a0JhSiirFbpwWZbrKwnVIPkrfA7oP2PTfspM51Dz
 H2yR2zD5PyckJWSPrIIOxkobh19625cZXx1spLZPxpxCh/aBmYSTljw7deNWjO6LtR7D Ow== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 381dum85tx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Apr 2021 11:03:59 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13KB3wIi139551;
        Tue, 20 Apr 2021 11:03:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 3809esejed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Apr 2021 11:03:58 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13KB2xcZ136786;
        Tue, 20 Apr 2021 11:03:57 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 3809esejdk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Apr 2021 11:03:57 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13KB3uTl016024;
        Tue, 20 Apr 2021 11:03:56 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 20 Apr 2021 11:03:55 +0000
Date:   Tue, 20 Apr 2021 14:03:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        hello@bryanbrattlof.com, hdegoede@redhat.com,
        saurav.girepunje@google.com, john.oldman@polehill.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com
Subject: Re: [PATCH] staging: rtl8723bs: os_dep: remove multiple return
Message-ID: <20210420110348.GC1981@kadam>
References: <20210418173233.GA59153@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210418173233.GA59153@user>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: CeLZ5r5Xrtp8QxoMCXPX-79OtMGQyNj4
X-Proofpoint-GUID: CeLZ5r5Xrtp8QxoMCXPX-79OtMGQyNj4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 18, 2021 at 11:02:33PM +0530, Saurav Girepunje wrote:
> on sdio_intf.c rtw_sdio_suspend call we have multiple
> return which can replace by goto exit. As in all the places
> return value is 0.
> 

Why?

Do nothing gotos just make the code harder to read and introduce forgot
to set the error code bugs.

regards,
dan carpenter

