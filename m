Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75724458900
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 06:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhKVFiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 00:38:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42400 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229994AbhKVFiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 00:38:51 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AM5M8hQ040045;
        Mon, 22 Nov 2021 05:35:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=CA6Crhw+Oip7jycciQON200J8boSzFiIqMvQJcBLKHg=;
 b=dZjAv2kFlagRMr5jxjJ7UkJ5x8mL1Pb5KzbtL8aWURqPiyc0x4Y7c7/MPYI56dMp6cMs
 HiCaAoov2M0lV3jvFm18b+OdSQXRmYYD9RPSv6Y0/EIgd/RGKmwt2c+m5LwlcqzjGJWG
 3SYtheUVFjhB5N1YyNUrjhHP+o4qSP66pVqVOWEjMFcub0nU7Z8KWY7eujOGzwN+JBIz
 /+E/vVVQ3xfaV0UBKYVljHaocgXFG4F2zMI5hJn3Q9tNZURepoXzBn2wJp/fHKxG+RXq
 9gaU6rzGaBJj+CUFdUOGTEq2h//zmQja9QAeZHUWEipcEK6uq3yKSK/tIuy2Vnri68ow jQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cg50e870r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Nov 2021 05:35:28 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AM5MImP000359;
        Mon, 22 Nov 2021 05:35:27 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cg50e86yk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Nov 2021 05:35:27 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AM5SxdM005367;
        Mon, 22 Nov 2021 05:35:25 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3cerna9nu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Nov 2021 05:35:24 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AM5SEAG57803162
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Nov 2021 05:28:14 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 94FB911C050;
        Mon, 22 Nov 2021 05:35:22 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 174CD11C05B;
        Mon, 22 Nov 2021 05:35:22 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.46.196])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon, 22 Nov 2021 05:35:22 +0000 (GMT)
Date:   Mon, 22 Nov 2021 06:35:18 +0100
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
Message-ID: <20211122063518.37929c01.pasic@linux.ibm.com>
In-Reply-To: <CACGkMEtja2TPC=ujgMrpaPmdsy+zHowbBTvPj8k7nm_+zB8vig@mail.gmail.com>
References: <20211027022107.14357-1-jasowang@redhat.com>
        <20211027022107.14357-2-jasowang@redhat.com>
        <20211119160951.5f2294c8.pasic@linux.ibm.com>
        <CACGkMEtja2TPC=ujgMrpaPmdsy+zHowbBTvPj8k7nm_+zB8vig@mail.gmail.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: V4C_OskBSbepen78rjZZGECX7_Yw4rxj
X-Proofpoint-GUID: Jnkjo_3UdBCABnrwb6QknnBSd76yB_ST
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-22_01,2021-11-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111220028
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2021 11:51:09 +0800
Jason Wang <jasowang@redhat.com> wrote:

> On Fri, Nov 19, 2021 at 11:10 PM Halil Pasic <pasic@linux.ibm.com> wrote:
> >
> > On Wed, 27 Oct 2021 10:21:04 +0800
> > Jason Wang <jasowang@redhat.com> wrote:
> >  
> > > This patch validate the used buffer length provided by the device
> > > before trying to use it. This is done by record the in buffer length
> > > in a new field in desc_state structure during virtqueue_add(), then we
> > > can fail the virtqueue_get_buf() when we find the device is trying to
> > > give us a used buffer length which is greater than the in buffer
> > > length.
> > >
> > > Since some drivers have already done the validation by themselves,
> > > this patch tries to makes the core validation optional. For the driver
> > > that doesn't want the validation, it can set the
> > > suppress_used_validation to be true (which could be overridden by
> > > force_used_validation module parameter). To be more efficient, a
> > > dedicate array is used for storing the validate used length, this
> > > helps to eliminate the cache stress if validation is done by the
> > > driver.
> > >
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>  
> >
> > Hi Jason!
> >
> > Our CI has detected, that virtio-vsock became unusable with this
> > patch on s390x. I didn't test on x86 yet. The guest kernel says
> > something like:
> > vmw_vsock_virtio_transport virtio1: tx: used len 44 is larger than in buflen 0
> >
> > Did you, or anybody else, see something like this on platforms other that
> > s390x?  
> 
> Adding Stefan and Stefano.
> 
> I think it should be a common issue, looking at
> vhost_vsock_handle_tx_kick(), it did:
> 
> len += sizeof(pkt->hdr);
> vhost_add_used(vq, head, len);
> 
> which looks like a violation of the spec since it's TX.

I'm not sure the lines above look like a violation of the spec. If you
examine vhost_vsock_alloc_pkt() I believe that you will agree that:
len == pkt->len == pkt->hdr.len
which makes sense since according to the spec both tx and rx messages
are hdr+payload. And I believe hdr.len is the size of the payload,
although that does not seem to be properly documented by the spec.

On the other hand tx messages are stated to be device read-only (in the
spec) so if the device writes stuff, that is certainly wrong.

If that is what happens. 

Looking at virtqueue_get_buf_ctx_split() I'm not sure that is what
happens. My hypothesis is that we just a last descriptor is an 'in'
type descriptor (i.e. a device writable one). For tx that assumption
would be wrong.

I will have another look at this today and send a fix patch if my
suspicion is confirmed.


> 
> >
> > I had a quick look at this code, and I speculate that it probably
> > uncovers a pre-existig bug, rather than introducing a new one.  
> 
> I agree.
> 

:) I'm not so sure any more myself.

> >
> > If somebody is already working on this please reach out to me.  
> 
> AFAIK, no. 

Thanks for the info! Then I will dig a little deeper. I asked in order
to avoid doing the debugging and fixing just to see that somebody was
faster :D

> I think the plan is to fix both the device and drive side
> (but I'm not sure we need a new feature for this if we stick to the
> validation).
> 
> Thanks
> 

Thank you!

Regards,
Halil
