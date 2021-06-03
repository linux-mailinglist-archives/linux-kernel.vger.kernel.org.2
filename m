Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310F539AEB9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 01:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhFCXet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 19:34:49 -0400
Received: from mga01.intel.com ([192.55.52.88]:61135 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFCXer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 19:34:47 -0400
IronPort-SDR: aACU/vHrmMuvBhCVVvIjYpiyCN9AujtYh5Wbqx0vPrjwOD20MJ87T3OgPK1PAT4/AlsUNWSj4h
 8SwLawDUN2WQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="225488691"
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="225488691"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 16:33:00 -0700
IronPort-SDR: qAh/G4h1oAVmxnpXqZzvzXCuEocjpQVTLKofsVYdH1zoxAHAjOZW/w7M8EFkVDo5EB13y1/Kmd
 5P5MI2NAPGSw==
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="550880326"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.7.237]) ([10.209.7.237])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 16:32:59 -0700
Subject: Re: [PATCH v1 1/8] virtio: Force only split mode with protected guest
To:     Andy Lutomirski <luto@kernel.org>, mst@redhat.com
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org,
        the arch/x86 maintainers <x86@kernel.org>,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-2-ak@linux.intel.com>
 <cc5c8265-83f7-aeb1-bc30-3367fe68bc97@kernel.org>
 <a0e66b4c-cec5-2a26-9431-d5a21e22c8f2@linux.intel.com>
 <2b2dec75-a0c1-4013-ac49-a49f30d5ac3c@www.fastmail.com>
 <3159e1f4-77cd-e071-b6f2-a2bb83cfc69a@linux.intel.com>
 <b8b39b76-8d07-4e4a-804a-746269787b61@www.fastmail.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <884f34e0-fcd2-bb82-9e9e-4269823fa9b2@linux.intel.com>
Date:   Thu, 3 Jun 2021 16:32:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <b8b39b76-8d07-4e4a-804a-746269787b61@www.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> We do not need an increasing pile of kludges

Do you mean disabling features is a kludge?

If yes I disagree with that characterization.


> to make TDX and SEV “secure”.  We need the actual loaded driver to be secure.  The virtio architecture is full of legacy nonsense,
> and there is no good reason for SEV and TDX to be a giant special case.

I don't know where you see a "giant special case". Except for the 
limited feature negotiation all the changes are common, and the 
disabling of features (which is not new BTW, but already done e.g. with 
forcing DMA API in some cases) can be of course used by all these other 
technologies too. But it just cannot be done by default for everything 
because it would break compatibility. So every technology with such 
requirements has to explicitly opt-in.


>
> As I said before, real PCIe (Thunderbolt/USB-C or anything else) has the exact same problem.  The fact that TDX has encrypted memory is, at best, a poor proxy for the actual condition.  The actual condition is that the host does not trust the device to implement the virtio protocol correctly.

Right they can do similar limitations of feature sets. But again it 
cannot be default.


>
>>
>> TDX and SEV use the arch hook to enforce DMA API, so that part is also
>> solved.
>>
> Can you point me to the code you’re referring to?

See 4/8 in this patch kit. It uses an existing hook which is already 
used in tree by s390.


-Andi



