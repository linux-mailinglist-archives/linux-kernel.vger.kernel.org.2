Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7638E3926A9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 06:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234649AbhE0E65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 00:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbhE0E6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 00:58:53 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EAFC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 21:57:20 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id j10so4163953edw.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 21:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YJ0dWA2LN7YqfF1ySTSNQvt81ovDnTZhfscP6j/isLs=;
        b=gKB8fvK0cCWN4lEkm4wDH6rz4Sa0FsxRwsg5F16JeFZeSk5+GIGcIQz76DqI7jCKna
         1n5SBDwT2tPkv3xz9FZpqyHuntur92hGyhaJqhPLvrxOpxjMAwWwnzEI+ond1RyDNj2M
         hSKTWiLfyXawwcHjtm/qvhYeQS3O4ky+w5QeGyceqwSLyP/TheaH2Ne18IVUbd8qIt3/
         KCdb3Z51nRn7l+3Pmv10fGurtavWFZ1jh73TQbyQtJqZwO5c78iH8kmQAAcbOJ6mGvgX
         3uDqtsAOrG8BYjKnqsMxPZMs+PQNCK4Ce6nPSunMJjOob1tFMqZxwaa9xuHBoDSMyEVR
         hSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YJ0dWA2LN7YqfF1ySTSNQvt81ovDnTZhfscP6j/isLs=;
        b=bb7cEf1FaTM4JsnQ3/mcJryus1p+9BwhFM1up/kusmdrDsBOh5bkatVWL327wgqlcn
         4YgwLhlz6J4WatKLksmUpqedp8AA07+9iuyywxt1xSJPKDWIIfP8M7pT51jGIsNryBNM
         vfkRzKQ455WBjpeYwoaDZLtdV5m6MVy3oe2MJqGQuPmYHwAsOQWJ3WstVb1pWeo7ugb1
         LtGv1dmLUCtnfuzSCo+FY1wIHBG2LBBl2EvceQwRzk1oW7UNu/dSfJmS10wPyc+9Je2X
         0XPOlLCizXxxvKOhC8GqezIPrmjLAUgTGD5rmU67kCSz2AdvubeaOCxXLBMRMEy2Ion9
         gYSg==
X-Gm-Message-State: AOAM5330m/DMsghVmipfJpNjSro2Fx/a69mDyFNVTXiVj0ry6w02BNvT
        1JybXURshPvc2zaZJBt9ligjTpz4yZ4p7aS7g8cB
X-Google-Smtp-Source: ABdhPJz7HIu5MQLRpH/FbPdTqRTue+3JMybVC+vY85i/I/de3bl/zvWYSVdjNKEUlXy6fDXCcVP8dUSaDhAFYIw47Ng=
X-Received: by 2002:a05:6402:4252:: with SMTP id g18mr1953908edb.195.1622091439123;
 Wed, 26 May 2021 21:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210517095513.850-1-xieyongji@bytedance.com> <20210517095513.850-12-xieyongji@bytedance.com>
 <3740c7eb-e457-07f3-5048-917c8606275d@redhat.com>
In-Reply-To: <3740c7eb-e457-07f3-5048-917c8606275d@redhat.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Thu, 27 May 2021 12:57:08 +0800
Message-ID: <CACycT3uAqa6azso_8MGreh+quj-JXO1piuGnrV8k2kTfc34N2g@mail.gmail.com>
Subject: Re: Re: [PATCH v7 11/12] vduse: Introduce VDUSE - vDPA Device in Userspace
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Parav Pandit <parav@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <christian.brauner@canonical.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, bcrl@kvack.org,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>,
        Dan Carpenter <dan.carpenter@oracle.com>, joro@8bytes.org,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev@vger.kernel.org, kvm <kvm@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 12:13 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> =E5=9C=A8 2021/5/17 =E4=B8=8B=E5=8D=885:55, Xie Yongji =E5=86=99=E9=81=93=
:
> > +
> > +static int vduse_dev_msg_sync(struct vduse_dev *dev,
> > +                           struct vduse_dev_msg *msg)
> > +{
> > +     init_waitqueue_head(&msg->waitq);
> > +     spin_lock(&dev->msg_lock);
> > +     vduse_enqueue_msg(&dev->send_list, msg);
> > +     wake_up(&dev->waitq);
> > +     spin_unlock(&dev->msg_lock);
> > +     wait_event_killable(msg->waitq, msg->completed);
>
>
> What happens if the userspace(malicous) doesn't give a response forever?
>
> It looks like a DOS. If yes, we need to consider a way to fix that.
>

How about using wait_event_killable_timeout() instead?

Thanks,
Yongji
