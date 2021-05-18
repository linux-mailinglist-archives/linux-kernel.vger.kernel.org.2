Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887BA3875C1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 11:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243629AbhERJxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 05:53:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20636 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241006AbhERJxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 05:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621331539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wpPMT42uZ3XKwYbpKRRNEkfka2lbaP+NlbXhy36ElV8=;
        b=V3t/ZodcfBfFXCpswXXkYT005XsYmenGj1Hqddav+Y+Ngbj/tYPDSxxhSs2F6uur+P9+Ee
        0dWuce1LVBSKKyAGzkvqAGgHQSW3cy1pW1oKclz4NPf/xS4whcbhnPr6N7FRK0revGLnRf
        lczHaTV3x0V7+UTnvjMio1nHrHmMImk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-QyV5Mb7GOuibcrF8JjsSLQ-1; Tue, 18 May 2021 05:52:15 -0400
X-MC-Unique: QyV5Mb7GOuibcrF8JjsSLQ-1
Received: by mail-wr1-f71.google.com with SMTP id p11-20020adfc38b0000b0290111f48b8adfso1860607wrf.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 02:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wpPMT42uZ3XKwYbpKRRNEkfka2lbaP+NlbXhy36ElV8=;
        b=dVuJBb1fRNKceDH7Tyuu7jLQTPpsLkimUlBUF8eRP23nOlLqkuTZb4M7fc3yOUlvg8
         1y7Fz+DOGyegYK5p3Imbc9kOPpbmiVI2YzVXvrZuBV/wuVbPaajjFtXdougjAH9O3D0B
         MnvZ7HHUmx6R9bkgBkvvMeODcGiQzM35Tf0Avc5aJN8RBc5ihonDQObaw8VHuemVcQV4
         517Bm2kOzo22rvrXmyOJPd6r1QrwOHmeyVklmxyxTkBDGbw7XZ8XIkwr4XT0PCVezyoV
         aySYsyhtyQMzdAfZ/R4BhqAG888JEzGxlUs7cW9uFdsxpr4npp7qvAvnIlbHWHkp+tbX
         Pa1A==
X-Gm-Message-State: AOAM531O7qsB/2ZLTAiln4zcmn+jKDAdJu2gg6DhBFOpE3JOn5Cnwc1/
        WUXIYlfSRtOP+0liJ2K2LeZgcA7qhBfBg+mXYHvGa0dzi1kBhrfDNPWQBNSyJd8Xl4FpQIIrVPn
        lkeBrgzXGulPhkUp8NcRD2v1f
X-Received: by 2002:a7b:c346:: with SMTP id l6mr4432802wmj.109.1621331534864;
        Tue, 18 May 2021 02:52:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNe6REZyWEUQAC/cEKXhdXB7zAamd7/DPuJpFs/VMosfB95RFwzY1oPYC6rBh2UxA9yWMWXg==
X-Received: by 2002:a7b:c346:: with SMTP id l6mr4432777wmj.109.1621331534660;
        Tue, 18 May 2021 02:52:14 -0700 (PDT)
Received: from redhat.com ([2a10:800c:1fa6:0:3809:fe0c:bb87:250e])
        by smtp.gmail.com with ESMTPSA id b17sm21100441wrt.71.2021.05.18.02.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 02:52:13 -0700 (PDT)
Date:   Tue, 18 May 2021 05:52:10 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, amit@kernel.org,
        arei.gonglei@huawei.com, airlied@linux.ie, kraxel@redhat.com,
        dan.j.williams@intel.com,
        Johannes Berg <johannes@sipsolutions.net>,
        Ohad Ben Cohen <ohad@wizery.com>, bjorn.andersson@linaro.org,
        David Hildenbrand <david@redhat.com>, vgoyal@redhat.com,
        miklos@szeredi.hu, Stefano Garzarella <sgarzare@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Re: [RFC PATCH 00/17] Add validation for used length
Message-ID: <20210518055146-mutt-send-email-mst@kernel.org>
References: <20210517090836.533-1-xieyongji@bytedance.com>
 <20210517193912-mutt-send-email-mst@kernel.org>
 <CACycT3uWexPNTiroO5EBT9q8YOorvvVaY_kymapWkLZ078J7aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACycT3uWexPNTiroO5EBT9q8YOorvvVaY_kymapWkLZ078J7aQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 04:29:44PM +0800, Yongji Xie wrote:
> On Tue, May 18, 2021 at 7:40 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, May 17, 2021 at 05:08:19PM +0800, Xie Yongji wrote:
> > > Current virtio device drivers may trust the used length returned
> > > in virtqueue_get_buf()/virtqueue_get_buf_ctx(). But the used length
> > > might come from an untrusted device when VDUSE[1] is enabled. To
> > > protect this case, this series tries to add validation for the
> > > used length.
> > >
> > > Since many legacy devices will also set the used length incorrectly,
> > > we did not add the validation unconditionally. Instead, we will do
> > > the validation only when the device driver needs the used length.
> > > A NULL len passed to virtqueue_get_buf()/virtqueue_get_buf_ctx()
> > > will mean the used length is not needed by the device driver.
> >
> > Can we be more specific? Which drivers have problems when used len
> > is incorrect? Maybe there's an easier way like validating the length
> > in the driver ...
> >
> 
> It's ok to me. But this means all future new drivers need to remember
> to do the validation.
> 
> Now only virtio-net and virtio-console drivers have this problem. I
> can send some patches to fix it.
> 
> Thanks,
> Yongji

I'd say let's just document the requirement for now.

-- 
MST

