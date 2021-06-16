Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0EB3A9521
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 10:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhFPIh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 04:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbhFPIhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 04:37:25 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD58C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 01:35:18 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id nd37so2551089ejc.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 01:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gp4U6YSCPwVtPXy/TVoR1GhhUWzSE9Eyi0KJRY31j3A=;
        b=LMKCPgyRy7f+knB/klKU3hvRqWPJ9Y4i8wY8aRC34ehMg7JPePoxmFFDo4GjUxtJXG
         XUe+fbVJi2OhfNzXbmI+FKOsFmAmZ9ABXQIA6OBNt45tl5htz3gOW+J05wmyy2NFpL0v
         ROUEyzt41iE4721eZBRsaw3htpcZYxACpyax6D6IQ0oor+wFIzwQdIn5zFpw5tIowLav
         CcsPrhdsEb3qWUYdh/XgPzEWk4GhzMIWlsloD/0tfsX1eniyUkH4eunVSIPpfKuSBEjK
         usNjdWaiDQNE/dhrDC4/DyxR1aUDO3ljnQRCQr3U3GcELfWetABOKV3b81CcfL8mQh6Z
         MIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gp4U6YSCPwVtPXy/TVoR1GhhUWzSE9Eyi0KJRY31j3A=;
        b=lh5DfM84T+G23g6Y9i1DrTn1JdQwWtZ3nqGnairWiR2DP4x4rWPP3th672Ok5iLBzl
         66ABTGcvHvrThjjONgBeOSjq/yaReGEfXin+cNI04OO2yu0i+1On5YIa9nPnErNDGQjz
         W+A2V7JeHRJmEwcOlnP5PVkI1hyWLNbzbkZIJ6GXDyEKD4DkgBATZN3uMDlRQJK+thIm
         FpmF3m0pieNgl73V6FNPOuc2L9eMOnc63aeAWtEp3F4QszLWiNHpKiKPdNCeLRz2gbw+
         WgRXInNfjrigwzEW2GrM9WSYYq7B3fA5Ha5WJhwAkkmosR+gR7ND82qErI4CQgThmkj0
         Iueg==
X-Gm-Message-State: AOAM533RlkVmsBvA1jc4XivRjgu2PjLN9fv1ttV6zuY/iYWOaGGtIWb4
        rky6PTaJNeyv6Y7cwunGi4p4LpqdjkVojiMluW/9
X-Google-Smtp-Source: ABdhPJxfB9bTRfOoTYC2AOEheM8QNpLoI4xIS22CZKj+x+O7PQjTS/OOugJwSPwSvND/NzxJI/HxWaY3FpAzXIKugMQ=
X-Received: by 2002:a17:906:b84f:: with SMTP id ga15mr4071921ejb.372.1623832517360;
 Wed, 16 Jun 2021 01:35:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210615104810.151-1-xieyongji@bytedance.com> <20210615112612-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210615112612-mutt-send-email-mst@kernel.org>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Wed, 16 Jun 2021 16:35:06 +0800
Message-ID: <CACycT3u-ZUQUDVvJZEck+j0F4VZ8H62_Zo-QPDs_97aWrvgL=A@mail.gmail.com>
Subject: Re: Re: [PATCH v2] virtio-blk: Add validation for block size in
 config space
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 11:27 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Jun 15, 2021 at 06:48:10PM +0800, Xie Yongji wrote:
> > This ensures that we will not use an invalid block size
> > in config space (might come from an untrusted device).
> >
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
>
> I'd say if device presents an unreasonable value,
> and we want to ignore that, then we should not
> negotiate VIRTIO_BLK_F_BLK_SIZE so that host knows.
>
> So maybe move the logic to validate_features.
>

Looks good to me. Will do it in v3.

Thanks,
Yongji
