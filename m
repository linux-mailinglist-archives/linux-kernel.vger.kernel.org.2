Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493E333796E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhCKQcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:32:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34863 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229723AbhCKQcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:32:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615480327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AjxBPEuos0//xANR8jHyBwhDFQYV47gI0GQ1JZxlt9U=;
        b=dpHPYqs4ZSeJYDptuMlb7Xxg/Fe4LFZCxYC2OSW3SUJnfUPb//oVXljVKtnze8acV7Sf8c
        jVIb69HCfrCCy5w5ZWZleX10tKlKDamB5uvfvt8Z+VkXJuZuQocB1yvD52io4Bbee1IHYZ
        kYGkIXPWpEjeSVlH/zYvTJBzwdj3C90=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-RBFRbwVrOwWTOD4pUyAFhQ-1; Thu, 11 Mar 2021 11:32:01 -0500
X-MC-Unique: RBFRbwVrOwWTOD4pUyAFhQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90C2694DC8;
        Thu, 11 Mar 2021 16:31:59 +0000 (UTC)
Received: from [10.36.115.26] (ovpn-115-26.ams2.redhat.com [10.36.115.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AFB9D60C21;
        Thu, 11 Mar 2021 16:31:41 +0000 (UTC)
Subject: Re: [RFC 0/2] virtio-pmem: Asynchronous flush
To:     Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, mst@redhat.com, jmoyer@redhat.com,
        pankaj.gupta@cloud.ionos.com
References: <20200420131947.41991-1-pankaj.gupta.linux@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <7e55abc4-5c91-efb8-1b32-87570dde62cc@redhat.com>
Date:   Thu, 11 Mar 2021 17:31:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20200420131947.41991-1-pankaj.gupta.linux@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.04.20 15:19, Pankaj Gupta wrote:
>   Jeff reported preflush order issue with the existing implementation
>   of virtio pmem preflush. Dan suggested[1] to implement asynchronous flush
>   for virtio pmem using work queue as done in md/RAID. This patch series
>   intends to solve the preflush ordering issue and also makes the flush
>   asynchronous from the submitting thread POV.
> 
>   Submitting this patch series for feeback and is in WIP. I have
>   done basic testing and currently doing more testing.
> 
> Pankaj Gupta (2):
>    pmem: make nvdimm_flush asynchronous
>    virtio_pmem: Async virtio-pmem flush
> 
>   drivers/nvdimm/nd_virtio.c   | 66 ++++++++++++++++++++++++++----------
>   drivers/nvdimm/pmem.c        | 15 ++++----
>   drivers/nvdimm/region_devs.c |  3 +-
>   drivers/nvdimm/virtio_pmem.c |  9 +++++
>   drivers/nvdimm/virtio_pmem.h | 12 +++++++
>   5 files changed, 78 insertions(+), 27 deletions(-)
> 
> [1] https://marc.info/?l=linux-kernel&m=157446316409937&w=2
> 

Just wondering, was there any follow up of this or are we still waiting 
for feedback? :)

-- 
Thanks,

David / dhildenb

