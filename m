Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B0F3D22B1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 13:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbhGVKqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 06:46:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55981 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231694AbhGVKqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 06:46:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626953226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tlwSP3E+o6dACUexqN1lCWWtUA1ZS2/frtL2qurgSS8=;
        b=RL1MC3tDoHNfOgbwCurTIkbXO0X1cbV7qaml1NGgnks3XesS2Zqv/Deng4azpF1eTZzNb/
        60vj/36mjWgXeuDcYXLt0BZHeQZnqm6Bwq91tiw6SscThgo4os+DHFWvK/hoYzIGGxUi/U
        ECWChQBhLBJdWU7b2nW9OTSpRYaIDfU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-TXg5LJprPxKeYAsU7j2vnQ-1; Thu, 22 Jul 2021 07:27:05 -0400
X-MC-Unique: TXg5LJprPxKeYAsU7j2vnQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD732E7B47;
        Thu, 22 Jul 2021 11:26:39 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-106.ams2.redhat.com [10.36.114.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E64F6A056;
        Thu, 22 Jul 2021 11:26:38 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id B0EE018000B2; Thu, 22 Jul 2021 13:26:36 +0200 (CEST)
Date:   Thu, 22 Jul 2021 13:26:36 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     "Wang, Zhi A" <zhi.a.wang@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: refactor the i915 GVT support
Message-ID: <20210722112636.wj277vqhg4dez5ug@sirius.home.kraxel.org>
References: <20210721155355.173183-1-hch@lst.de>
 <DM4PR11MB55496531B246A4604FC86998CAE49@DM4PR11MB5549.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR11MB55496531B246A4604FC86998CAE49@DM4PR11MB5549.namprd11.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> https://github.com/intel/gvt-linux/blob/topic/gvt-xengt/drivers/gpu/drm/i915/gvt/xengt.c

> But it's hard for some customers to contribute their own "hypervisor"
> module to the upstream Linux kernel. I am thinking what would be a
> better solution here? The MPT layer in the kernel helps a lot for
> customers, but only one open-source "hypervisor" module is there in
> the kernel. That can confuse people which don't know the story.  One
> thing I was thinking is to put a document about the background and
> more description in the MPT headers. So it won't confuse more people. 

Getting the xengt module linked above merged into mainline
would also nicely explain why there are hypervisor modules.

take care,
  Gerd

