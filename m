Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E5C42C084
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 14:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhJMMtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 08:49:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53485 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232772AbhJMMtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 08:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634129226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wp+/d0F+qzlGdrrSoGXSKcXwbRm7uRB50CWJ1pV00sA=;
        b=QTfNvJnvYCHpzqE66sRusuz1zu12vlFMJtnztwxJHUwYBkzKknvA73NKrPHeLAR6PxCJTg
        2fxmvvWIR5fhtgBlTzAE95BoM6uDoBfkrPptCOyftCexUSTcji9m2zSfP/5ina8dZ921fx
        r/UCLKppOJOSg2SEdosYUbsOHpEX+W0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-ZdFkUILBMeWVCeZNhw2YPg-1; Wed, 13 Oct 2021 08:47:05 -0400
X-MC-Unique: ZdFkUILBMeWVCeZNhw2YPg-1
Received: by mail-wr1-f71.google.com with SMTP id r21-20020adfa155000000b001608162e16dso1863593wrr.15
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 05:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wp+/d0F+qzlGdrrSoGXSKcXwbRm7uRB50CWJ1pV00sA=;
        b=urjxiPDCg1EnfF29M7A7l5l0CDsRCbqvhbBVIUa7XmgxhOsvpcsCMR4Gk1xjcZTUeO
         sfEs+/nesAeQg3pzYCtWVcYatOsKs80/zyVa3X0fEQ0eLDk2PHf7ITkyhu1eDw0Dq+Mg
         MlD7VzrD+3zmL6ikZy0t+GRnOfVdM1BXTxLCXOzafHt5uIyCYk1aPz9zSavJUpg0tg8t
         p6zLKg+oa+WmNRw2HWG7+P8AYWVGGNQhv6MPqIH8MA4geOAdz+D2b7y4yhFqr8ybfCqp
         qOnIK235JGOYdBc7jFb76yzX7ZMmfIi4+nX0qJ5Ys7CdT0dJYf95LPnQI7XsRfkyrALu
         niXw==
X-Gm-Message-State: AOAM530AcdCSjMDkioh4vb5q1vuIQ97SQAa9fwmxw+Y1Yz7oR/p32EwQ
        c9DQ4FZ34zoKDGGAKldiLAos7QeAjT3msYpw2Zm3SIpKq6N/1HY+KehOPqrz9rfLmrarg5D6VIl
        Q+maw8FtXEc54GdSoFNo29XND
X-Received: by 2002:a7b:c258:: with SMTP id b24mr12306404wmj.160.1634129224183;
        Wed, 13 Oct 2021 05:47:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3bu0Nu2sTQ0+QNSDdqXyjCUIauFl76JolUN+8aoRczJi/YTb07iDFPZNwrmi/5HPNNvtB6A==
X-Received: by 2002:a7b:c258:: with SMTP id b24mr12306384wmj.160.1634129223978;
        Wed, 13 Oct 2021 05:47:03 -0700 (PDT)
Received: from redhat.com ([2.55.30.112])
        by smtp.gmail.com with ESMTPSA id b190sm5299164wmd.25.2021.10.13.05.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 05:47:03 -0700 (PDT)
Date:   Wed, 13 Oct 2021 08:46:59 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        markver@us.ibm.com, Cornelia Huck <cohuck@redhat.com>,
        linux-s390@vger.kernel.org, stefanha@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        qemu-devel@nongnu.org
Subject: Re: [PATCH v3 1/1] virtio: write back F_VERSION_1 before validate
Message-ID: <20211013084640-mutt-send-email-mst@kernel.org>
References: <20211011053921.1198936-1-pasic@linux.ibm.com>
 <20211013060923-mutt-send-email-mst@kernel.org>
 <96561e29-e0d6-9a4d-3657-999bad59914e@de.ibm.com>
 <20211013081836-mutt-send-email-mst@kernel.org>
 <20211013144408.2812d9bd.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013144408.2812d9bd.pasic@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 02:44:08PM +0200, Halil Pasic wrote:
> On Wed, 13 Oct 2021 08:24:53 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > > > OK this looks good! How about a QEMU patch to make it spec compliant on
> > > > BE?  
> > > 
> > > Who is going to do that? Halil? you? Conny?  
> > 
> > Halil said he'll do it... Right, Halil?
> 
> I can do it but not right away. Maybe in a couple of weeks. I have some
> other bugs to hunt down, before proceeding to this. If somebody else
> wants to do it, I'm fine with that as well.
> 
> Regards,
> Halil

Couple of weeks is ok I think.

-- 
MST

