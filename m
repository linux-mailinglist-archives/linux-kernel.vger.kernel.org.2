Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A4541470C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 12:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbhIVK5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 06:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235227AbhIVK5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 06:57:15 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18EFC061767
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 03:55:44 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id 72so8062865qkk.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 03:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I8zcL6nY0+S2zQ/flZQgnXdO6GpvOWsWm7Eprv1C6rM=;
        b=HsK5+T+5NiocJxZTEW3N/XramKMpMNQuu76QOp9NGobkhAE2N0Cv5g+XDh5/UlkoHL
         CNV/16gkAdEYhqSUknmsDD4406TfYBYi2Kh+kuenfEBMSZGSFSFYhfAbkvT27XuGwkpa
         JZU3r45NTWRPE7+nnB59nluY9wqvvpcM4HBUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I8zcL6nY0+S2zQ/flZQgnXdO6GpvOWsWm7Eprv1C6rM=;
        b=vAtXf67DkwNj0A9oZCdS3RsppEMplYGjemjEfHNBb/BfJ/i6Or02CFHxdbHbss055F
         N7Liu5sIFvA+elaRnR+9UTsdGhgO95xAKD4cs5701WNbPKA8a6VbcKjJ/aXWbL5Jjbds
         yUceXPotMRMaq6OBpEfLR1cF6IqsSVnJ9e4oLbS7rOQsislkShfzvITAHGVy+Yzi+MKT
         SDbGWFI/OwVw/dkNaQiEL+dFEDHq7ezR1Cj2LD7CgrtJfDAqGX/fvg2dSkwK+t++bFEo
         pqI1cmf6p/37HY2ms/kAJPTLT1NZ8vs+IpQ1V8+shEN5DG9WCX8tlVdBwMxocGJrYPNR
         OP+g==
X-Gm-Message-State: AOAM530iiUYy4LBOLhXMbOkEkA2afAY/doaxRAfWUZNFeBLAFu6ju9hF
        h0HM2G6HHnr3aBZITZrozQ3/XgNz6ruNpAWkIdOhKQ==
X-Google-Smtp-Source: ABdhPJzs+vwMocpzUvUcIGLb5DK8Kc3T2mlVtSzlw6e38p1m8St8Lut8ffp79zvdu2OshJ1/XqdqXNj4ts8E34fQMec=
X-Received: by 2002:a37:6896:: with SMTP id d144mr11935563qkc.387.1632308144127;
 Wed, 22 Sep 2021 03:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210916014632.2662612-1-pmalani@chromium.org>
 <f6860aa6-b541-b03d-da8d-333661a8322f@collabora.com> <YUoWgdK2+t8d11oq@google.com>
 <f3c7dde6-c82e-4cae-c5b2-9e0c37b6fe2f@collabora.com>
In-Reply-To: <f3c7dde6-c82e-4cae-c5b2-9e0c37b6fe2f@collabora.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Wed, 22 Sep 2021 03:55:32 -0700
Message-ID: <CACeCKadbGRerfeArjtpAtSt7Me=V3TJaa5d8JhXN4wNuaa7N9w@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_proto: Fix check_features ret val
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On Wed, Sep 22, 2021 at 2:12 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Prashant,
>
> On 21/9/21 19:29, Prashant Malani wrote:
> > Hi Enric,
> >
> > Thanks for reviewing the patch.
> >
> > On Tue, Sep 21, 2021 at 01:42:04PM +0200, Enric Balletbo i Serra wrote:
> >> Hi Prashant,
> >>
> >> Thank you for the patch. Just one comment below ...
> >>
> >> On 16/9/21 3:46, Prashant Malani wrote:
> >>> The kerneldoc for cros_ec_check_features() states that it returns 1 or 0
> >>> depedending on whether a feature is supported or not, but it instead
> >>> returns a negative error number in one case, and a non-1 bitmask in
> >>> other cases.
> >>>
> >>> Since all call-sites only check for a 1 or 0 return value, update
> >>> the function to return boolean values.
> >>>
> >>> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> >>> ---
> >>>  drivers/platform/chrome/cros_ec_proto.c     | 12 +++++++-----
> >>>  include/linux/platform_data/cros_ec_proto.h |  2 +-
> >>>  2 files changed, 8 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> >>> index a7404d69b2d3..a34cf58c5ef7 100644
> >>> --- a/drivers/platform/chrome/cros_ec_proto.c
> >>> +++ b/drivers/platform/chrome/cros_ec_proto.c
> >>> @@ -808,9 +808,9 @@ EXPORT_SYMBOL(cros_ec_get_host_event);
> >>>   *
> >>>   * Call this function to test whether the ChromeOS EC supports a feature.
> >>>   *
> >>> - * Return: 1 if supported, 0 if not
> >>> + * Return: true if supported, false if not (or if an error was encountered).
> >>>   */
> >>> -int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
> >>> +bool cros_ec_check_features(struct cros_ec_dev *ec, int feature)
> >>>  {
> >>>     struct cros_ec_command *msg;
> >>>     int ret;
> >>> @@ -818,8 +818,10 @@ int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
> >>>     if (ec->features[0] == -1U && ec->features[1] == -1U) {
> >>>             /* features bitmap not read yet */
> >>>             msg = kzalloc(sizeof(*msg) + sizeof(ec->features), GFP_KERNEL);
> >>> -           if (!msg)
> >>> -                   return -ENOMEM;
> >>> +           if (!msg) {
> >>> +                   dev_err(ec->dev, "failed to allocate memory to get EC features\n");
> >>
> >> In case of failure you will be noticed by the allocator, prints after
> >> [k|v][m|z|c]alloc() functions are not needed, so I think you can just return
> >> false here.
> >>>
> >
> > Makes sense; I can make the change, but I had one question:
> >
> > If we solely return false, how will we tell from the logs that the
> > allocation error message was associated with this driver? Only returning
> > false means the driver probe (e.g cros-ec-typec) will continue (just assuming a certain feature
> > is not present). Wouldn't having this error message make this clear?
> >
>
> So I tried to find some doc about this without luck. But I think it has been an
> unwritten rule that GFP_KERNEL allocations for small allocations will never
> fail.

That might be the case, but kzalloc() still returns the error value,
so even if it is very unlikely, we
still need to handle that error.

If you system fails to allocate that small amount of memory you probably
> have bigger problems to solve and the above message is not really useful, even
> confusing, as the focus, likely, shouldn't be in this driver to solve the problem.

I don't know if I necessarily concur with that rationale ("if it
fails, there are likely bigger issues").
There could be situations (hypothetical) where a series of allocations
might lead to a failure (or this might be a transient allocation
failure),
and it might be useful to know which driver is contributing the alloc
that finally precipitates the failure.

Also, although it is very unlikely, returning true without an error
can mean the typec driver silently continues to function
wrongly assuming a feature flag to be set a certain way. That is
something we need to flag through the logs.
I certainly can't see the log message as confusing the reader of a log
any further.

>
> Thinking a bit more about this change, and after your question, I don't really
> like functions not returning an error in the unlikely case that fails. On the
> other hand, I like this function return a bool as is a bit more clear IMO, so
> I'm wondering if wouldn't be better don't use dynamic memory here (I know that
> this is not really related to your patch)

That sounds right to me. Can I make that change as a follow up patch?
I'd like to contain the scope
of this patch to just fix the return value.

>
> And another thing that I detected, now that you're returning a bool is that in
> drivers/platform/chrome/cros_ec_typec.c there is:
>
>    typec->typec_cmd_supported = !!cros_ec_check_features(ec_dev,
>    typec->needs_mux_ack = !!cros_ec_check_features(ec_dev,
>
> I think that you can remove the !! now. That could be in another patch.

Yes, I was planning on doing that in a later patch.

Best regards,
