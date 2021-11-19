Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD2C457172
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 16:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbhKSPNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 10:13:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47922 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231835AbhKSPNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 10:13:30 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AJEBsuM004293;
        Fri, 19 Nov 2021 15:10:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=0MP0TcvzjP8SfMirHVdpCIcpMxsE5ZR81uig9gebZSg=;
 b=N3/PYHEZiSUfBuxeuUjtBpqfv4C5w5du1/uSC2hY+4XPbssPtcM8brqBzodE/b4+YxAk
 oQUVOfY3J7YSPO+Io2L4mcQFegw9rlhwz+1e2L34cI2L7a1hUAnlfU0ACtaJDQYup9Ew
 87ErWNum2KuMpjWbNk8cACpsxecJl7zl/SVy9JmkPzywNtZpijml3gs0FQI6bSuJ7Z4U
 3V74xieHLPq8RzkvxGhz3Z9oC4zVcugL5TMXk04eT4ydhLdjg3rbwKmUFO3GoqL2q8VD
 YLmwpC+MHGkjWZlr+HuBsiq+KS6CegKQDwLNtW/5SFtkpS8z/oBCiRsY57RSP2UqACij IA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cec0kk6ts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 15:10:16 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AJEC34W005179;
        Fri, 19 Nov 2021 15:10:16 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cec0kk6ss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 15:10:16 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AJF3VqE012380;
        Fri, 19 Nov 2021 15:10:14 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3ca4mksy31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 15:10:13 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AJF38hD60686658
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Nov 2021 15:03:08 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5BF4FAE068;
        Fri, 19 Nov 2021 15:10:11 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0BD0AE055;
        Fri, 19 Nov 2021 15:10:10 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.32.96])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri, 19 Nov 2021 15:10:10 +0000 (GMT)
Date:   Fri, 19 Nov 2021 16:09:51 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        f.hetzelt@tu-berlin.de, linux-kernel@vger.kernel.org,
        david.kaplan@amd.com, konrad.wilk@oracle.com,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH V5 1/4] virtio_ring: validate used buffer length
Message-ID: <20211119160951.5f2294c8.pasic@linux.ibm.com>
In-Reply-To: <20211027022107.14357-2-jasowang@redhat.com>
References: <20211027022107.14357-1-jasowang@redhat.com>
        <20211027022107.14357-2-jasowang@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: W2LqPQDNQ3Yv7uyJXxNO4ROVIPAicV5n
X-Proofpoint-GUID: XpNAgGaEGisJ6W2H3HhA84DWCLUvvQRA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-19_09,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 clxscore=1011
 spamscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111190084
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2021 10:21:04 +0800
Jason Wang <jasowang@redhat.com> wrote:

> This patch validate the used buffer length provided by the device
> before trying to use it. This is done by record the in buffer length
> in a new field in desc_state structure during virtqueue_add(), then we
> can fail the virtqueue_get_buf() when we find the device is trying to
> give us a used buffer length which is greater than the in buffer
> length.
> 
> Since some drivers have already done the validation by themselves,
> this patch tries to makes the core validation optional. For the driver
> that doesn't want the validation, it can set the
> suppress_used_validation to be true (which could be overridden by
> force_used_validation module parameter). To be more efficient, a
> dedicate array is used for storing the validate used length, this
> helps to eliminate the cache stress if validation is done by the
> driver.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Hi Jason!

Our CI has detected, that virtio-vsock became unusable with this
patch on s390x. I didn't test on x86 yet. The guest kernel says
something like:
vmw_vsock_virtio_transport virtio1: tx: used len 44 is larger than in buflen 0

Did you, or anybody else, see something like this on platforms other that
s390x?

I had a quick look at this code, and I speculate that it probably
uncovers a pre-existig bug, rather than introducing a new one.

If somebody is already working on this please reach out to me.

Regards,
Halil
