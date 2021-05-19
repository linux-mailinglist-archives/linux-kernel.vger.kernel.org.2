Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72CE6388994
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 10:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245605AbhESImF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 04:42:05 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:50722 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245518AbhESImE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 04:42:04 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14J8e0ZI015483;
        Wed, 19 May 2021 08:40:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=/mZiErNBoyzN3umssfH3gOPEDtVZgaX6Jvuu78Gwv2I=;
 b=HoGCojdDEW/wA8l97yac42ps/7wadpyHLAEM/yr6/qNo4eD57XG2Uc+SRwB2dMeU4oU9
 L6KZyBX36NNKITAKGoyXz45jCxdloAPSLsI3fDjaK2vcDOEW3RBRe0rFhPrxgtRYQzyA
 7YUPxS8pj7EgFY1eJ0J/8fvtigiwZPggDU0DbhQPccNvFjW7Voe/z7n+va21xP3QUfJY
 NDFJskEA4MxRCYJAcoyZXq6tFeZSLgvKMRZV1TP5d57XRkhCOgCCrS+IUhMmFxqC/x93
 BTDJuBd1al01eNAPIgAAQck7g0Iuu79liIdhmITH67JOo2Bl9m7if8AKGm6sewsFZJkN yQ== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 38kh0h91x9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 08:40:41 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14J8eexw119045;
        Wed, 19 May 2021 08:40:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 38msw18cjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 08:40:40 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14J8edVP119032;
        Wed, 19 May 2021 08:40:39 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 38msw18cjg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 08:40:39 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 14J8eXex015950;
        Wed, 19 May 2021 08:40:33 GMT
Received: from mwanda (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 May 2021 01:40:32 -0700
Date:   Wed, 19 May 2021 11:40:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     ztong0001@gmail.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        open list <linux-kernel@vger.kernel.org>
Subject: re: [PATCH v3] misc: alcor_pci: fix null-ptr-deref when there is no
 PCI bridge
Message-ID: <YKTO+xuM/Ly+8Vwf@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513040732.1310159-1-ztong0001@gmail.com>
X-Proofpoint-GUID: SbxvM9rnKVsbnX_j00taO6xd2JIsvsxq
X-Proofpoint-ORIG-GUID: SbxvM9rnKVsbnX_j00taO6xd2JIsvsxq
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tong Zhang,

This is a semi-automatic email about new static checker warnings.

The patch 3ce3e45cc333: "misc: alcor_pci: fix null-ptr-deref when
there is no PCI bridge" from May 13, 2021, leads to the following
Smatch complaint:

    drivers/misc/cardreader/alcor_pci.c:149 alcor_pci_init_check_aspm()
    error: we previously assumed 'priv->parent_pdev' could be null (see line 147)

drivers/misc/cardreader/alcor_pci.c
   142          /*
   143           * A device might be attached to root complex directly and
   144           * priv->parent_pdev will be NULL. In this case we don't check its
   145           * capability and disable ASPM completely.
   146           */
   147		if (!priv->parent_pdev)
                    ^^^^^^^^^^^^^^^^^^

   148			priv->parent_cap_off = alcor_pci_find_cap_offset(priv,
   149								 priv->parent_pdev);
                                                                 ^^^^^^^^^^^^^^^^^^
It will just crash inside the function call.  Is the if statement
reversed?

   150	
   151		if ((priv->pdev_cap_off == 0) || (priv->parent_cap_off == 0)) {

regards,
dan carpenter
