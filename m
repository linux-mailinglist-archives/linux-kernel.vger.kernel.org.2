Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D6E3878B4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 14:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349087AbhERM3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 08:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348933AbhERM3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 08:29:38 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F372EC061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 05:28:19 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id t15so10872302edr.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 05:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cIO15K4boOS4+KtDlelyPibZ4OKmBT2WMEC6lvOdqVk=;
        b=sZR3B+8mtYAeUsl4P4FEBEpIrLxrlUvxyznT3bm1ii4PwtKlm15XZICaKIaPjqiSvs
         iC4Wj8q1JYiw2m75OVc9uR/CbLPnjvkHOXKU5wNtPKhtX/OYZKlymKl2IQlwrC7cPaCx
         2SHY/hafoPL0I1GfG5vDMJ00vtC1Lyvh00NIq/Tq3AakM9G2N7d22uiqWXpHXORgEOTs
         60wJ8HZbH+p5yTR3U1Rit30YMvLtPg9Tw/TKRKs8B8IwcRvPXAcHuvmpC7Y1c5gfsnY+
         VyeTx4r/gYh2EM3JHltTKXrXEshB2GyOkcQktKoVDvr0Jci8a77of6W1BvnzOjRrwdeS
         ExBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cIO15K4boOS4+KtDlelyPibZ4OKmBT2WMEC6lvOdqVk=;
        b=nmnBoEIgN3rbYQdECAD6ftdilln+xzCjRWddFFJNr3RGxVXHPIIojXSkmUS7X7j1Dq
         aDnrNFVoV1yiRY6OkIwFbGksKTIso7OqT7Fu6CmedV8VOpNUZp3ecmQoCzZkqBX2gFb3
         NlchOidCykWPnitP58MHYZQbdx7e1EJQ0rigcP6l4LW+8jWAcMl/+9V+v4Hmpiw0n5Jx
         1NlOpUPxF2C5EG1n9zqkt/s05g7071oVxRoNbulK6Mx7c1iEC3P3ZgaY3XL3poEsKKWK
         aXmm3TfwV0LY9nVYRmNSpkzdfukEvpKAGaBmPR9t+cNA0J1uT8mUx7RYBCg4mtcZ//mQ
         80Nw==
X-Gm-Message-State: AOAM5324Z47XFPP8LeU5PDbhLy/GQnIfnUHqVnhVGuKcnEITvVAVhVBw
        w7LpB0RzG2Kd8G+e8J7MwG2Te9zLBZL1TeLAJ7nb
X-Google-Smtp-Source: ABdhPJwaoVnHMDhD9VnG00fk5I9tkH7x+/QuSSWqtfXMKep8Me87vAqOzxlHW5hko9I/o+hmhsegF1UAOoRzv47OCkk=
X-Received: by 2002:a05:6402:22fa:: with SMTP id dn26mr6610198edb.5.1621340898033;
 Tue, 18 May 2021 05:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210517090836.533-1-xieyongji@bytedance.com> <20210517193912-mutt-send-email-mst@kernel.org>
 <CACycT3uWexPNTiroO5EBT9q8YOorvvVaY_kymapWkLZ078J7aQ@mail.gmail.com> <20210518055146-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210518055146-mutt-send-email-mst@kernel.org>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Tue, 18 May 2021 20:28:07 +0800
Message-ID: <CACycT3spqEvPP0X9xNd3USm6DVt9JBSyiukzikpiwqQpNRfhzA@mail.gmail.com>
Subject: Re: Re: Re: [RFC PATCH 00/17] Add validation for used length
To:     "Michael S. Tsirkin" <mst@redhat.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 5:52 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, May 18, 2021 at 04:29:44PM +0800, Yongji Xie wrote:
> > On Tue, May 18, 2021 at 7:40 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Mon, May 17, 2021 at 05:08:19PM +0800, Xie Yongji wrote:
> > > > Current virtio device drivers may trust the used length returned
> > > > in virtqueue_get_buf()/virtqueue_get_buf_ctx(). But the used length
> > > > might come from an untrusted device when VDUSE[1] is enabled. To
> > > > protect this case, this series tries to add validation for the
> > > > used length.
> > > >
> > > > Since many legacy devices will also set the used length incorrectly,
> > > > we did not add the validation unconditionally. Instead, we will do
> > > > the validation only when the device driver needs the used length.
> > > > A NULL len passed to virtqueue_get_buf()/virtqueue_get_buf_ctx()
> > > > will mean the used length is not needed by the device driver.
> > >
> > > Can we be more specific? Which drivers have problems when used len
> > > is incorrect? Maybe there's an easier way like validating the length
> > > in the driver ...
> > >
> >
> > It's ok to me. But this means all future new drivers need to remember
> > to do the validation.
> >
> > Now only virtio-net and virtio-console drivers have this problem. I
> > can send some patches to fix it.
> >
> > Thanks,
> > Yongji
>
> I'd say let's just document the requirement for now.
>

It's fine with me.

Thanks,
Yongji
