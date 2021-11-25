Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816DF45D66B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 09:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353462AbhKYItO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 03:49:14 -0500
Received: from mga02.intel.com ([134.134.136.20]:57869 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350047AbhKYIrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 03:47:13 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="222698566"
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; 
   d="scan'208";a="222698566"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 00:44:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; 
   d="scan'208";a="571796921"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga004.fm.intel.com with ESMTP; 25 Nov 2021 00:44:00 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 25 Nov 2021 00:43:59 -0800
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 25 Nov 2021 00:43:57 -0800
Received: from shsmsx601.ccr.corp.intel.com ([10.109.6.141]) by
 SHSMSX601.ccr.corp.intel.com ([10.109.6.141]) with mapi id 15.01.2242.012;
 Thu, 25 Nov 2021 16:43:55 +0800
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     "Michael S. Tsirkin" <mst@redhat.com>,
        "sgarzare@redhat.com" <sgarzare@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "srutherford@google.com" <srutherford@google.com>,
        "erdemaktas@google.com" <erdemaktas@google.com>
Subject: RE: [RFC] hypercall-vsock: add a new vsock transport
Thread-Topic: [RFC] hypercall-vsock: add a new vsock transport
Thread-Index: AdfR7PQwhDKKIu84SJaS6/iA/MsV5gD8LVgAADoZqGACr3WnAAAUmcgA
Date:   Thu, 25 Nov 2021 08:43:55 +0000
Message-ID: <58911901bd7b4bc3a99642214106bc2f@intel.com>
References: <71d7b0463629471e9d4887d7fcef1d8d@intel.com>
 <20211110054121-mutt-send-email-mst@kernel.org>
 <dcaf10bed215456ab689956275d4b998@intel.com>
 <CACGkMEsY_XkRo_P+R=ipQ1iYm-AimvLvfXUwEy40Nn4f1D_suA@mail.gmail.com>
In-Reply-To: <CACGkMEsY_XkRo_P+R=ipQ1iYm-AimvLvfXUwEy40Nn4f1D_suA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1cnNkYXksIE5vdmVtYmVyIDI1LCAyMDIxIDI6MzggUE0sIEphc29uIFdhbmcgd3JvdGU6
DQo+ID4gV2UgdGhvdWdodCBhYm91dCB2aXJ0aW8tbW1pby4gVGhlcmUgYXJlIHNvbWUgYmFycmll
cnM6DQo+ID4gMSkgSXQgd2Fzbid0IG9yaWdpbmFsbHkgaW50ZW5kZWQgZm9yIHg4NiBtYWNoaW5l
cy4gVGhlIG9ubHkgbWFjaGluZQ0KPiA+IHR5cGUgaW4gUUVNVSB0aGF0IHN1cHBvcnRzIGl0ICh0
byBydW4gb24geDg2KSBpcyBtaWNyb3ZtLiBCdXQNCj4gPiAibWljcm92bSIgZG9lc27igJl0IHN1
cHBvcnQgVERYIGN1cnJlbnRseSwgYW5kIGFkZGluZyB0aGlzIHN1cHBvcnQgbWlnaHQNCj4gbmVl
ZCBsYXJnZXIgZWZmb3J0Lg0KPiANCj4gQ2FuIHlvdSBleHBsYWluIHdoeSBtaWNyb3ZtIG5lZWRz
IGxhcmdlciBlZmZvcnQ/IEl0IGxvb2tzIHRvIG1lIGl0IGZpdHMgZm9yIFREWA0KPiBwZXJmZWN0
bHkgc2luY2UgaXQgaGFzIGxlc3MgYXR0YWNrIHN1cmZhY2UuDQoNClRoZSBtYWluIHRoaW5nIGlz
IFREVkYgZG9lc27igJl0IHN1cHBvcnQgbWljcm92bSBzbyBmYXIgKHRoZSBiYXNlZCBPVk1GDQpz
dXBwb3J0IGZvciBtaWNyb3ZtIGlzIHN0aWxsIHVuZGVyIHRoZWlyIGNvbW11bml0eSBkaXNjdXNz
aW9uKS4NCg0KRG8geW91IGd1eXMgdGhpbmsgaXQgaXMgcG9zc2libGUgdG8gYWRkIHZpcnRpby1t
bWlvIHN1cHBvcnQgZm9yIHEzNT8NCihlLmcuIGNyZWF0ZSBhIHNwZWNpYWwgcGxhdGZvcm0gYnVz
IGluIHNvbWUgZmFzaGlvbiBmb3IgbWVtb3J5IG1hcHBlZCBkZXZpY2VzKQ0KTm90IHN1cmUgaWYg
dGhlIGVmZm9ydCB3b3VsZCBiZSBsYXJnZXIuDQoNClRoYW5rcywNCldlaQ0KDQoNCg0K
