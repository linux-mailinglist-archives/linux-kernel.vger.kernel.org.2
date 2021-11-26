Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86CDD45E44E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 03:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344451AbhKZCVK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 25 Nov 2021 21:21:10 -0500
Received: from mga06.intel.com ([134.134.136.31]:15418 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244262AbhKZCTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 21:19:09 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="296397431"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="296397431"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 18:15:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="650863628"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga001.fm.intel.com with ESMTP; 25 Nov 2021 18:15:53 -0800
Received: from shsmsx603.ccr.corp.intel.com (10.109.6.143) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 25 Nov 2021 18:15:50 -0800
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 SHSMSX603.ccr.corp.intel.com (10.109.6.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 26 Nov 2021 10:15:48 +0800
Received: from shsmsx601.ccr.corp.intel.com ([10.109.6.141]) by
 SHSMSX601.ccr.corp.intel.com ([10.109.6.141]) with mapi id 15.01.2242.012;
 Fri, 26 Nov 2021 10:15:48 +0800
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
CC:     "mst@redhat.com" <mst@redhat.com>,
        "stefanha@redhat.com" <stefanha@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "asias@redhat.com" <asias@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH] virtio/vsock: fix the transport to work with
 VMADDR_CID_ANY
Thread-Topic: [PATCH] virtio/vsock: fix the transport to work with
 VMADDR_CID_ANY
Thread-Index: AQHX4daqV2Omz/OJfUqBSDdTk17B0qwT+K9Q//+PVgCAAXxRUA==
Date:   Fri, 26 Nov 2021 02:15:48 +0000
Message-ID: <97be1440032248a29b5eb75619f8ac4d@intel.com>
References: <20211125071554.16969-1-wei.w.wang@intel.com>
 <7992566c682b46dc9ec2502e44a2fb04@intel.com>
 <20211125104046.wxupkn6uogvohioi@steredhat>
In-Reply-To: <20211125104046.wxupkn6uogvohioi@steredhat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, November 25, 2021 6:41 PM, Stefano Garzarella wrote:
> On Thu, Nov 25, 2021 at 09:27:40AM +0000, Wang, Wei W wrote:
> >On Thursday, November 25, 2021 3:16 PM, Wang, Wei W wrote:
> >> -	/* Update CID in case it has changed after a transport reset event */
> >> -	vsk->local_addr.svm_cid = dst.svm_cid;
> >> -
> >>  	if (space_available)
> >>  		sk->sk_write_space(sk);
> >>
> >
> >Not sure if anybody knows how this affects the transport reset.
> 
> I believe the primary use case is when a guest is migrated.
> 
> After the migration, the transport gets a reset event from the hypervisor and
> all connected sockets are closed. The ones in listen remain open though.
> 
> Also the guest's CID may have changed after migration. So if an application has
> open listening sockets, bound to the old CID, this should ensure that the socket
> continues to be usable.

OK, thanks for sharing the background.

> 
> The patch would then change this behavior.
> 
> So maybe to avoid problems, we could update the CID only if it is different
> from VMADDR_CID_ANY:
> 
> 	if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
> 		vsk->local_addr.svm_cid = dst.svm_cid;
> 
> 
> When this code was written, a guest only supported a single transport, so it
> could only have one CID assigned, so that wasn't a problem.
> For that reason I'll add this Fixes tag:
> Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")

Sounds good to me.

Thanks,
Wei
