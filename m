Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79160459609
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 21:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240484AbhKVU1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 15:27:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49874 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240446AbhKVU1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 15:27:15 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AMJMVb8017526;
        Mon, 22 Nov 2021 20:24:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=MwNyb4w+R/d8EtV9aihbf4r5tx39o8Q9yAG6zIx7bms=;
 b=YYtfqiko0PiaSh1uvoC/pIyAd6elLGemZnfcVTuu9MmxRXXX24Uu1jjLchk9zBRdWhJO
 Xd++e/ao0xT11oDoyXATdmOBZ1i2iqWvUC97mn+TStbEfmEyvDcmG/IWgOV5qatElRRQ
 O+2/SYOQ05Jy73de1geP89qCOZZVXALaXUh4Lj4OM5PECMh912bI03UL0UTRpHWa6czd
 KjjX+XEUNXfz79ixddBviK89BLnht72imE6EAIxiYq195ghC6spDn09A2BAMK0r+sdMd
 UC3TG+iajw6DOnupnghs6H4C2BEqTmIqY5LeZJDvtRyIULcsZQdCMpbcpkgaFl42r/P0 Kg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cghad170n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Nov 2021 20:24:01 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AMKO0A0018824;
        Mon, 22 Nov 2021 20:24:00 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cghad16yu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Nov 2021 20:24:00 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AMKIEu5006171;
        Mon, 22 Nov 2021 20:23:58 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 3cern9guxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Nov 2021 20:23:58 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AMKNt4g524902
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Nov 2021 20:23:55 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B516DAE053;
        Mon, 22 Nov 2021 20:23:55 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31113AE045;
        Mon, 22 Nov 2021 20:23:55 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.37.164])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon, 22 Nov 2021 20:23:55 +0000 (GMT)
Date:   Mon, 22 Nov 2021 21:23:52 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        "Hetzelt, Felicitas" <f.hetzelt@tu-berlin.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "kaplan, david" <david.kaplan@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH V5 1/4] virtio_ring: validate used buffer length
Message-ID: <20211122212352.4a76232d.pasic@linux.ibm.com>
In-Reply-To: <CACGkMEu+9FvMsghyi55Ee5BxetP-YK9wh2oaT8OgLiY5+tV0QQ@mail.gmail.com>
References: <20211027022107.14357-1-jasowang@redhat.com>
        <20211027022107.14357-2-jasowang@redhat.com>
        <20211119160951.5f2294c8.pasic@linux.ibm.com>
        <CACGkMEtja2TPC=ujgMrpaPmdsy+zHowbBTvPj8k7nm_+zB8vig@mail.gmail.com>
        <20211122063518.37929c01.pasic@linux.ibm.com>
        <20211122064922.51b3678e.pasic@linux.ibm.com>
        <CACGkMEu+9FvMsghyi55Ee5BxetP-YK9wh2oaT8OgLiY5+tV0QQ@mail.gmail.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7AQryhX7SQZAdr9DZYYQXJXLGjwkaT5q
X-Proofpoint-ORIG-GUID: huq3D1BIhtTlCvp50DrEFc2c_YMPCZl6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-22_08,2021-11-22_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111220100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2021 14:25:26 +0800
Jason Wang <jasowang@redhat.com> wrote:

> I think the fixes are:
> 
> 1) fixing the vhost vsock
> 2) use suppress_used_validation=true to let vsock driver to validate
> the in buffer length
> 3) probably a new feature so the driver can only enable the validation
> when the feature is enabled.

I'm not sure, I would consider a F_DEV_Y_FIXED_BUG_X a perfectly good
feature. Frankly the set of such bugs is device implementation
specific and it makes little sense to specify a feature bit
that says the device implementation claims to adhere to some
aspect of the specification. Also what would be the semantic
of not negotiating F_DEV_Y_FIXED_BUG_X?

On the other hand I see no other way to keep the validation
permanently enabled for fixed implementations, and get around the problem
with broken implementations. So we could have something like
VHOST_USED_LEN_STRICT.

Maybe, we can also think of 'warn and don't alter behavior' instead of
'warn' and alter behavior. Or maybe even not having such checks on in
production, but only when testing.

Regards,
Halil
