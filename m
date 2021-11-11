Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3204444D2DB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 09:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbhKKIFZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 11 Nov 2021 03:05:25 -0500
Received: from mga05.intel.com ([192.55.52.43]:25985 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229674AbhKKIFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 03:05:22 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="319071596"
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="319071596"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 00:02:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="602524452"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga004.jf.intel.com with ESMTP; 11 Nov 2021 00:02:32 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 11 Nov 2021 00:02:31 -0800
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 11 Nov 2021 00:02:30 -0800
Received: from shsmsx601.ccr.corp.intel.com ([10.109.6.141]) by
 SHSMSX601.ccr.corp.intel.com ([10.109.6.141]) with mapi id 15.01.2242.012;
 Thu, 11 Nov 2021 16:02:28 +0800
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
CC:     "sgarzare@redhat.com" <sgarzare@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "mst@redhat.com" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        "Sergio Lopez Pascual" <slp@redhat.com>
Subject: RE: [RFC] hypercall-vsock: add a new vsock transport
Thread-Topic: [RFC] hypercall-vsock: add a new vsock transport
Thread-Index: AdfR7PQwhDKKIu84SJaS6/iA/MsV5gD5igUAADxATEA=
Date:   Thu, 11 Nov 2021 08:02:27 +0000
Message-ID: <03b779ac2f504fa989559f16e75817d3@intel.com>
References: <71d7b0463629471e9d4887d7fcef1d8d@intel.com>
 <YYuSKEqj3UMLNAfw@stefanha-x1.localdomain>
In-Reply-To: <YYuSKEqj3UMLNAfw@stefanha-x1.localdomain>
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

> From: Stefan Hajnoczi <stefanha@redhat.com>
On Wednesday, November 10, 2021 5:35 PM, Stefan Hajnoczi wrote:
> AF_VSOCK is designed to allow multiple transports, so why not. There is a cost
> to developing and maintaining a vsock transport though.

Yes. The effort could be reduced via simplifying the design as much as possible:
e.g. no ring operations - guest just sends a packet each time for the host to read.
(this transport isn't targeting for high performance)

> 
> I think Amazon Nitro enclaves use virtio-vsock and I've CCed Andra in case she
> has thoughts on the pros/cons and how to minimize the trusted computing
> base.

Thanks for adding more related person to the discussion loop.

> 
> If simplicity is the top priority then VIRTIO's MMIO transport without indirect
> descriptors and using the packed virtqueue layout reduces the size of the
> implementation:
> https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/virtio-v1.1-cs01.html#x1-1
> 440002

I listed some considerations for virtio-mmio in the response to Michael.
Please have a check if any different thoughts.

Thanks,
Wei
