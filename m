Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9AE0382893
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236124AbhEQJnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235911AbhEQJm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:42:59 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC14C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:41:43 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id u21so8140972ejo.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8pYgAXiZa+BnA6s1rKpT2ICCtz3mX7f+0PiWB9FL4d0=;
        b=OZ6QdEuR5g78nXb8PzWFtKsgO7gmorD5lMiUCRiC0DoWEWtX5H/GcKK5JVv58J793b
         QUMCZDt+/S+1Iyz54moB31WSXL/mSXhs+x5Li1ZmFBfkF1yyrtO9K8uNFt3H1pLUlDX8
         kWzlwo+expvI7vtSHl8WBDiB+HkISzoKjoQ+s89SLlr3XpQv+9lGu2F1JypMaR+E9oqu
         4BlYFyHEKbvjinLufb4IG6o447FO7R7jNp0296Thybj+shGUxy1xUCiogF7/TuLsdQlj
         vjISLw/mL9zSiWPK6UP2c1C000pq0xijcjk6rkECkLONfHzdCQis0XjzEBcjMyqnL48q
         HgPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8pYgAXiZa+BnA6s1rKpT2ICCtz3mX7f+0PiWB9FL4d0=;
        b=RZBNDMRkxwpt5kJKu4pVw0g62LVwVdXDgZ4lCLQam10B/MpEx3qJeAkDBDbMkBSsfR
         rZueGwHPeHfyThIiWugf3QWkMIqOtsyjHtqZ4bcRcxCkF0j8AdyPYFVCvgnJblTIf4U4
         TaK9EW/8tsEsakd/T7Fk32bI95LlH0lu/9kUesJfhHdVwEwZOjj2IaxBaIsS26VpfPiE
         hMpIL2v7Y4uu0VqMIJxN91VxgPHX1PcSRKOnewd4rktmdRp4PKniFJ4thGZ7ONQOltPI
         M06dJEUG659O0At85ZRyDsmjJv27BS8pZgAMJfIvTHcoqciY8QH5a0KebYnTqI643VEq
         zRLw==
X-Gm-Message-State: AOAM533v5jyCPIjQOZaOlBk/lQ10jRoUloWIeXkel50neHvzeoiyug73
        w//KINp+kVL6ubMoaPZwxsNvpcCRZq3CKygzUVuy
X-Google-Smtp-Source: ABdhPJx04C5W7AO5NaqhKBnbi5PfjeGW0WSCVrnvgaLbgaZw4hpbAwdxir+oVD6Lqvj9U82kZ2AbENJdo7C2WNcKo0c=
X-Received: by 2002:a17:906:c211:: with SMTP id d17mr26469843ejz.247.1621244502454;
 Mon, 17 May 2021 02:41:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210517090836.533-1-xieyongji@bytedance.com> <20210517090836.533-2-xieyongji@bytedance.com>
 <1f8289f84cd4dd9f440705d3ebab2c8a3e2e6a2c.camel@sipsolutions.net>
In-Reply-To: <1f8289f84cd4dd9f440705d3ebab2c8a3e2e6a2c.camel@sipsolutions.net>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 17 May 2021 17:41:31 +0800
Message-ID: <CACycT3vO53+GGZ+Lw2_ervZFk-J647gmGb+G6DFL6mpfk4+gbQ@mail.gmail.com>
Subject: Re: Re: [RFC PATCH 01/17] virtio_ring: Avoid reading unneeded used length
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, amit@kernel.org,
        arei.gonglei@huawei.com, airlied@linux.ie, kraxel@redhat.com,
        dan.j.williams@intel.com, Ohad Ben Cohen <ohad@wizery.com>,
        bjorn.andersson@linaro.org, david@redhat.com, vgoyal@redhat.com,
        miklos@szeredi.hu, Stefano Garzarella <sgarzare@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 5:12 PM Johannes Berg <johannes@sipsolutions.net> w=
rote:
>
> On Mon, 2021-05-17 at 17:08 +0800, Xie Yongji wrote:
> > If device driver doesn't need used length, it can pass a NULL
> > len in virtqueue_get_buf()/virtqueue_get_buf_ctx().
> >
>
> Well, actually, it can't right now?
>

Yes.

> You should probably rephrase this, saying something like
>
>    Allow passing NULL to len in ... if the device driver doesn't need
>    the length, and don't read it in that case.
>
> or so?
>

Looks good to me.

> >  Then
> > we can avoid reading and validating the len value in used
> > ring entries.
>
> Not sure what that "validating" is about, I only see reading?
>

The =E2=80=9Cvalidating" is actually done in the last patch of this series.
Will remove it.

Thanks,
Yongji
