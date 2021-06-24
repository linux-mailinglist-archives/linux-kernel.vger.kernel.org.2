Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088B83B329A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 17:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbhFXPcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 11:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhFXPcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 11:32:48 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CBFC061756
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 08:30:28 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id y13so3135653plc.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 08:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GKu79Jy0wP/pVLbay2WCl0HQlTcf+F7A2KNkIRNIJy4=;
        b=Fyky1i94qfhy+kdxE5taKryG8XZa+NEyCr/pmvB1UvjRhgxQ5anKy+S/BMvAF+/Z23
         W1+VH7Q1K80RYPmz8sYHF70V4Lmz9tDCOoh+pi6oae8vHOLj9ul80KCyrJn+MmdL3c40
         lzJ8Jy520/8FvCYxQJgE6WNiBO1te5XzJT7V9Mi3dx6SazdsPEspuX5U4l0DHcSgYGOv
         zv/91rGmkvwGYZeNHydZqrsKuYYR1q1CDPt0pkjiMXzxBLKs+0Iwd+9fI+wC5+8gau/N
         H3c/rijIC5sh5XwBHvZHhLdZH8JsYVtqycxO6gmj0jC8OvuYIYe/nUnK2RGXmfIm05TH
         YHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GKu79Jy0wP/pVLbay2WCl0HQlTcf+F7A2KNkIRNIJy4=;
        b=kk9nJ4EPDQlwRb3kLUJhg5RmxqYEmYNwaHu4frIuDvZJtK+n80+lG+b8sQUc/qk5rF
         jVtJENEGCvc8a1nW+4OCurWJ5chtM+8HXlXVUuTCwcPKyc2K5tfz9TYdmoyEiTxKkZij
         AdNDu8ijYhEDHlQ+XeqFyPsKBSIK6eM4aTjTDnSbxC8bZueJ34KWXFbuoaRfDJjZ3Lez
         l/BySWZCqAEpzZxNV4SUx2wKYEOtgJrpHGTj6VMnT2KL3KaN5aoI4Leqb1QK7e0Ak7Cq
         4fPhm+Nxz/lsPkDdFc3vzH/dALk/NjjDc0xeEQ348Dn6jsKRirVK8AOjNQl/zBG2yfNj
         lBBw==
X-Gm-Message-State: AOAM532Ih9bm3q+ZDyRqFJnqLd24xIzXk/3e0xhG2sUO0NjDc2U4sMW6
        FD6hkcDN5qL36o0AyCuZF2fyomCn7M3Fe+p7ndmf4w==
X-Google-Smtp-Source: ABdhPJyuUEdd3ounqqk/N9c8OldDL7cnuqef1j4apMAbjh4tkOrLl8eDwvYu7gh3xfYp0RkvOYlNT9O4FCc0aYAczeE=
X-Received: by 2002:a17:90a:640b:: with SMTP id g11mr6201944pjj.18.1624548628083;
 Thu, 24 Jun 2021 08:30:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210621161616.77524-1-manivannan.sadhasivam@linaro.org>
 <20210621161616.77524-5-manivannan.sadhasivam@linaro.org> <YNSN6Yjk/P05ql8G@kroah.com>
In-Reply-To: <YNSN6Yjk/P05ql8G@kroah.com>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Thu, 24 Jun 2021 17:39:58 +0200
Message-ID: <CAMZdPi9=F0agD=5eSmVngmDRXNhb7TstQzgMSXFoJzkuRVFtjQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] bus: mhi: Add inbound buffers allocation flag
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Hemant Kumar <hemantk@codeaurora.org>,
        Bhaumik Bhatt <bbhatt@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thu, 24 Jun 2021 at 15:51, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jun 21, 2021 at 09:46:12PM +0530, Manivannan Sadhasivam wrote:
> > From: Loic Poulain <loic.poulain@linaro.org>
> >
> > Currently, the MHI controller driver defines which channels should
> > have their inbound buffers allocated and queued. But ideally, this is
> > something that should be decided by the MHI device driver instead,
> > which actually deals with that buffers.
> >
> > Add a flag parameter to mhi_prepare_for_transfer allowing to specify
> > if buffers have to be allocated and queued by the MHI stack.
> >
> > Keep auto_queue flag for now, but should be removed at some point.
> >
> > Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> > Tested-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> > Reviewed-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> > Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Acked-by: Jakub Kicinski <kuba@kernel.org>
> > Link: https://lore.kernel.org/r/1621603519-16773-1-git-send-email-loic.poulain@linaro.org
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
[...]
> > +/**
> > + * enum mhi_chan_flags - MHI channel flags
> > + * @MHI_CH_INBOUND_ALLOC_BUFS: Automatically allocate and queue inbound buffers
> > + */
> > +enum mhi_chan_flags {
> > +     MHI_CH_INBOUND_ALLOC_BUFS = BIT(0),
>
> Why is an enumerated type a bitfield?
>
> Please just use integers for enumerated types.

This 'trick' for listing flags is used in other places like drm,
mac80211, etc...: grep -r "BIT(0)," ./include/

I don't understand why it would not be right? should we simply use
a list of defines for this?

Regards,
Loic
