Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E706645D72D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 10:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351389AbhKYJc4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 25 Nov 2021 04:32:56 -0500
Received: from mga05.intel.com ([192.55.52.43]:16836 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353977AbhKYJay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 04:30:54 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="321715480"
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; 
   d="scan'208";a="321715480"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 01:27:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; 
   d="scan'208";a="475587501"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga002.jf.intel.com with ESMTP; 25 Nov 2021 01:27:43 -0800
Received: from shsmsx602.ccr.corp.intel.com (10.109.6.142) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 25 Nov 2021 01:27:42 -0800
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 SHSMSX602.ccr.corp.intel.com (10.109.6.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 25 Nov 2021 17:27:40 +0800
Received: from shsmsx601.ccr.corp.intel.com ([10.109.6.141]) by
 SHSMSX601.ccr.corp.intel.com ([10.109.6.141]) with mapi id 15.01.2242.012;
 Thu, 25 Nov 2021 17:27:40 +0800
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     "mst@redhat.com" <mst@redhat.com>,
        "stefanha@redhat.com" <stefanha@redhat.com>,
        "sgarzare@redhat.com" <sgarzare@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "asias@redhat.com" <asias@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH] virtio/vsock: fix the transport to work with
 VMADDR_CID_ANY
Thread-Topic: [PATCH] virtio/vsock: fix the transport to work with
 VMADDR_CID_ANY
Thread-Index: AQHX4daqV2Omz/OJfUqBSDdTk17B0qwT+K9Q
Date:   Thu, 25 Nov 2021 09:27:40 +0000
Message-ID: <7992566c682b46dc9ec2502e44a2fb04@intel.com>
References: <20211125071554.16969-1-wei.w.wang@intel.com>
In-Reply-To: <20211125071554.16969-1-wei.w.wang@intel.com>
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

On Thursday, November 25, 2021 3:16 PM, Wang, Wei W wrote:
> -	/* Update CID in case it has changed after a transport reset event */
> -	vsk->local_addr.svm_cid = dst.svm_cid;
> -
>  	if (space_available)
>  		sk->sk_write_space(sk);
> 

Not sure if anybody knows how this affects the transport reset.

Thanks,
Wei
