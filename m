Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF733A3EBE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 11:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhFKJNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 05:13:19 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:63330 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230248AbhFKJNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 05:13:16 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15B9233W003696;
        Fri, 11 Jun 2021 09:10:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=bGanNVUBgNjd1eZt2e98FlPpYQ8940Oh/K0u9giUnv0=;
 b=m4DHDOaUX5covrDCV4e7TTBrRgemnEA++KEikMN1vIc9PfJqDW318lBsWrjNicreJH9X
 PsOXTcF4yXQkVeCvpLu0hTX6Iw2P92eYd0nD2iFgF5jATfbmcGtU9dyZeJ7PYKe/Sp3B
 Ln7Nklp8sxXknTpRVxucvoiWnnOrIlNlVN/gzXF5TOy+Kf1wlwUXe7xuR6EDsRBggVOF
 Bp/MYkX53KMT22pnPYWZQCDdaCJD2YYNPirGrBwmnLU4xatNE1/OOfJ1kJ0n+EAQUPWC
 82Rjx+NIv/uHZ6jlwvD5rO1VdLRc7phcYL7lxt9IyJZEykp78XDhdK2zF/lNs4bbn7OM ZA== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 392yvb8qkm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Jun 2021 09:10:24 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 15B97NEn081162;
        Fri, 11 Jun 2021 09:10:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 3922x1wumt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Jun 2021 09:10:23 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15B9629N073920;
        Fri, 11 Jun 2021 09:10:22 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 3922x1wuk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Jun 2021 09:10:22 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 15B9AKaa002888;
        Fri, 11 Jun 2021 09:10:20 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 11 Jun 2021 02:10:20 -0700
Date:   Fri, 11 Jun 2021 12:10:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, kaixuxia@tencent.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        liushixin2@huawei.com, unixbhaskar@gmail.com,
        gustavoars@kernel.org, martin@kaiser.cx, bkkarthik@pesu.pes.edu
Subject: Re: [PATCH 0/6] staging: rtl8188eu: remove hal/odm_debug.h
Message-ID: <20210611091010.GE10983@kadam>
References: <20210611002504.166405-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611002504.166405-1-phil@philpotter.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: 6NkT5LD6oX42U-iImRoBumv2XmkAEoGa
X-Proofpoint-GUID: 6NkT5LD6oX42U-iImRoBumv2XmkAEoGa
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 01:24:58AM +0100, Phillip Potter wrote:
> This series removes hal/odm_debug.h, which contains various preprocessor
> definitions, as well as an unwieldy ODM_RT_TRACE macro which is not best
> practice. It also removes all uses of this macro, and the associated
> fields in struct odm_dm_struct which are only used by this macro.
> 
> This makes the code cleaner, thus moving it closer to getting out of
> staging.

Looks good.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

