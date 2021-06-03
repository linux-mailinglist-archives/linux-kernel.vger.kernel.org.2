Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86FE399851
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 04:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbhFCC6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 22:58:32 -0400
Received: from mga11.intel.com ([192.55.52.93]:63948 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbhFCC6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 22:58:31 -0400
IronPort-SDR: IIikFKecjC+6z97tdqhCzWo5oDccEMgJAloYAT1jtqp2LVtA/WARxl12oPhFBc+hhlqQ71B8tk
 Fz+mj9I18vJw==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="200937747"
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="200937747"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 19:56:47 -0700
IronPort-SDR: KhRXtgngnmgKjM5HGekGuKCGTxqbA99N9UtERxN/h391vZaKc5WUL0tyOCjFA2/qjOiV0+JkOX
 pLjDWqoLDQ8g==
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="550535335"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.87.193]) ([10.209.87.193])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 19:56:47 -0700
Subject: Re: [PATCH v1 1/8] virtio: Force only split mode with protected guest
To:     Jason Wang <jasowang@redhat.com>, mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, x86@kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-2-ak@linux.intel.com>
 <28c8302b-6833-10b4-c0eb-67456e7c4069@redhat.com>
 <09e17c7f-ce51-1a46-72c4-12223bee4e3a@linux.intel.com>
 <1c08bc42-7448-351e-78bf-fcf68d2b2561@redhat.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <5a2d0d70-fa6b-f08d-f222-5c00cf5f9d44@linux.intel.com>
Date:   Wed, 2 Jun 2021 19:56:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <1c08bc42-7448-351e-78bf-fcf68d2b2561@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>
> I agree, but I want to know why indirect descriptor needs to be 
> disabled. The table can't be wrote by the device since it's not 
> coherent swiotlb mapping.

I had all kinds of problems with uninitialized entries in the indirect 
table. So I gave up on it and concluded it would be too difficult to secure.


-Andi


