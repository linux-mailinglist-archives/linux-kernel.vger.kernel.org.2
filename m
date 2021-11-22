Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98044458926
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 06:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbhKVFw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 00:52:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8912 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229870AbhKVFw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 00:52:58 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AM5fbaa029690;
        Mon, 22 Nov 2021 05:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=F9O+V+kt17lgGUHVNesGojFNZS39jaURNh2TGEF8Ci0=;
 b=TgXB/AXOP3Ku54H3OYiNFmlqJgpTfK6oluqBnNqUkUbOSK7ke8Cbme26pPt2inKNk3TD
 0APzKUSBtYM2jyv8Hjmd4uknueEzTNBS8ZvvSyMNKAfwccDPAOOmAlP7n//jHAGxjNvg
 uGCJPFuiLYu8kUxu4QW+Mq3jNlffrhFe2InLp+2HCZTxnM8NZvKBgUkYI+6FhCJYhghH
 O+4nm+M9D6GGIf9i+3quCgMscnktEfeOz6HD0UD2CsCUZhPUNbyliU2NTLCuZ8BAvqaF
 4MlVsH6h2iBCRgxTwC/XPDsTgOmS+8g7vZCPEazhtdT0sb2rexL8Vr02WcfW8VUZCmxo HA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cg59er3m7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Nov 2021 05:49:45 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AM5hlPf033550;
        Mon, 22 Nov 2021 05:49:44 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cg59er3ks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Nov 2021 05:49:44 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AM5cmqX018433;
        Mon, 22 Nov 2021 05:49:43 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3cern9hrd8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Nov 2021 05:49:42 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AM5neLn32178540
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Nov 2021 05:49:40 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1D3C4C040;
        Mon, 22 Nov 2021 05:49:40 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18E764C046;
        Mon, 22 Nov 2021 05:49:40 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.46.196])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon, 22 Nov 2021 05:49:40 +0000 (GMT)
Date:   Mon, 22 Nov 2021 06:49:22 +0100
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
Message-ID: <20211122064922.51b3678e.pasic@linux.ibm.com>
In-Reply-To: <20211122063518.37929c01.pasic@linux.ibm.com>
References: <20211027022107.14357-1-jasowang@redhat.com>
        <20211027022107.14357-2-jasowang@redhat.com>
        <20211119160951.5f2294c8.pasic@linux.ibm.com>
        <CACGkMEtja2TPC=ujgMrpaPmdsy+zHowbBTvPj8k7nm_+zB8vig@mail.gmail.com>
        <20211122063518.37929c01.pasic@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Or5FsZTqwydFQL6_bxk6t6saQ2A-dUUh
X-Proofpoint-ORIG-GUID: Z0ya8A4jcWy5XM4o6jvpeKHvk5I-GvoC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-22_01,2021-11-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxscore=0 spamscore=0 phishscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111220028
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2021 06:35:18 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> > I think it should be a common issue, looking at
> > vhost_vsock_handle_tx_kick(), it did:
> > 
> > len += sizeof(pkt->hdr);
> > vhost_add_used(vq, head, len);
> > 
> > which looks like a violation of the spec since it's TX.  
> 
> I'm not sure the lines above look like a violation of the spec. If you
> examine vhost_vsock_alloc_pkt() I believe that you will agree that:
> len == pkt->len == pkt->hdr.len
> which makes sense since according to the spec both tx and rx messages
> are hdr+payload. And I believe hdr.len is the size of the payload,
> although that does not seem to be properly documented by the spec.
> 
> On the other hand tx messages are stated to be device read-only (in the
> spec) so if the device writes stuff, that is certainly wrong.
> 
> If that is what happens. 
> 
> Looking at virtqueue_get_buf_ctx_split() I'm not sure that is what
> happens. My hypothesis is that we just a last descriptor is an 'in'
> type descriptor (i.e. a device writable one). For tx that assumption
> would be wrong.
> 
> I will have another look at this today and send a fix patch if my
> suspicion is confirmed.

If my suspicion is right something like:

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 00f64f2f8b72..efb57898920b 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -764,6 +764,7 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
        struct vring_virtqueue *vq = to_vvq(_vq);
        void *ret;
        unsigned int i;
+       bool has_in;
        u16 last_used;
 
        START_USE(vq);
@@ -787,6 +788,9 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
                        vq->split.vring.used->ring[last_used].id);
        *len = virtio32_to_cpu(_vq->vdev,
                        vq->split.vring.used->ring[last_used].len);
+       has_in = virtio16_to_cpu(_vq->vdev,
+                       vq->split.vring.used->ring[last_used].flags)
+                               & VRING_DESC_F_WRITE;
 
        if (unlikely(i >= vq->split.vring.num)) {
                BAD_RING(vq, "id %u out of range\n", i);
@@ -796,7 +800,7 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
                BAD_RING(vq, "id %u is not a head!\n", i);
                return NULL;
        }
-       if (vq->buflen && unlikely(*len > vq->buflen[i])) {
+       if (has_in && q->buflen && unlikely(*len > vq->buflen[i])) {
                BAD_RING(vq, "used len %d is larger than in buflen %u\n",
                        *len, vq->buflen[i]);
                return NULL;

would fix the problem for split. I will try that out and let you know
later.

Regards,
Halil
