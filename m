Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E884018C6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 11:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241251AbhIFJZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 05:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241099AbhIFJZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 05:25:52 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CD5C061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 02:24:47 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so3925656pjr.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 02:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NwdCNWqp/8zAEGF+5OwEhs1ib4G6yzVfOIoz8pTEB7Y=;
        b=e84lNCzyd+PW4HxXXmPasndLCPcEZSCWlR0LGnAyOhewIoDjVGBoCVmX6evNQs8vmX
         unRXiAB3WJUfQDI1GG4D+psEjt/Qr3MA4SQlOGdS+7GCQ1IVtUa6r2ZzfjJbhKX3sqiI
         amW7dAgBluYZz+uimd5j+LBAm3ZqcZkUG3I9MlStpWBwc5Pr8s67sanSj3PB8xTrAWgN
         JUqXK5uUqCpNgoPoUYtI6WYnuC8HaAqwKuvodhz1Fi+MNl5jJusgitEJuEETL0u9LZ5q
         +Wz09wr3UvrtwP97rZJibMZ1KB3bRfqHbZGqNKS6/yKyoN4BeO0QdHCRDVVBGTorj4oM
         tLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NwdCNWqp/8zAEGF+5OwEhs1ib4G6yzVfOIoz8pTEB7Y=;
        b=Rc5CFLExV5YmPXrkV3f3TDQu6zsBY7FKpq2yErYHUyHHhaTbF9JCNo2W0zCEqx051Q
         ZfJSWDVLdiKzJVHJo4nUOKjSJ3673VvQ1/er1+rRPpDQrwxjVS721QMC2DAdfKjXXXkS
         UttCdcYyAxnQbhHpU+e1Ik8dLCHmKQAWuqFpPtGcXgjEo4WFlnSA3DxWhs9XWpYV6HNQ
         mtHlf35JT5BdwmMxwJpW92enKRRm05q8y4szLJ63Nk5OeOCAq7xkJz7ewyLzVu2Wl5ta
         mXOL/MDJrdJBTaG7cKnn92PzucSLbzk98dow93mILZTkIo7HmXi/OlkOYdLzgdOJrpR0
         RuyQ==
X-Gm-Message-State: AOAM533JUfwGTNJGRwVNAQWYxpn84rCC3yTgya3QXuwPL+34sFhsHlHt
        P2y7e9hm692UQ4GJAyYcgf3FkIUdTtRZjK5qEENBVg==
X-Google-Smtp-Source: ABdhPJyiCLLtKc2cERsKXRPkct5X9fvC9j2mbvvObPXU7qIvIq7eaSn5zAPJNmp1pNCTU8I0qckoqj1CtuLdCo2NcmY=
X-Received: by 2002:a17:90b:357:: with SMTP id fh23mr12911407pjb.140.1630920287318;
 Mon, 06 Sep 2021 02:24:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210903213011.1319-1-phil@philpotter.co.uk> <YTXSZ0HNd+vVJW+0@infradead.org>
In-Reply-To: <YTXSZ0HNd+vVJW+0@infradead.org>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Mon, 6 Sep 2021 10:24:36 +0100
Message-ID: <CAA=Fs0k71=LW3iPQw7TCSY2WfWGYxaM28SyvQXHCRrGFCS46dQ@mail.gmail.com>
Subject: Re: [PATCH] cdrom: update uniform CD-ROM maintainership in
 MAINTAINERS file
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Sept 2021 at 09:34, Christoph Hellwig <hch@infradead.org> wrote:
>
> Can you please also add the linux-block list to the entry?  I think we
> should have all the CD-ROM bits on this list instead of disappearing
> into the linux-kernel void.

Dear Christoph,

Certainly, will do after work this evening and reissue patch.

Regards,
Phil
