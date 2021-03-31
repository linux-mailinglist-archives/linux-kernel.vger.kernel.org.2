Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D10A34F85D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 07:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbhCaFp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 01:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbhCaFpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 01:45:40 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E91AC061574;
        Tue, 30 Mar 2021 22:45:40 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id x9so13662274qto.8;
        Tue, 30 Mar 2021 22:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ENJQTuGpOg2PGuhIpBvjiq5shyNy6TTKOL1C0EyRUZE=;
        b=C0pfEXeNRT+k078MHEQsTSqcE/ZuSIlGsqUNBOJ3zZKnmYB7CQdBhzj9Rb2My1vo3Z
         Ib1h60SwM+E42oulLXbGe/Zn9DQM0oDAhECJilU8/FGZZ/giC/gGmw8kWAb3dhCs0Qso
         Wx+YXUWjWH+qGrVV57j/pNYrsFx7Xq+WKKvtiRaRttG9n0DArV5+5Oxive+wgpvRqN24
         4PAcJvfKm5G8gSE61b8ONE7GZIV2RQGHqesMXHCpojY9hLc3U5DuvsegobJw+P4UW3Fl
         bicJIJZZA9lt5AQmgdv3nuammoSMGHVg5MeUY7jY14fh+F2vq3zRSwKAGNJOvgopMk0X
         iICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ENJQTuGpOg2PGuhIpBvjiq5shyNy6TTKOL1C0EyRUZE=;
        b=gpIxeNpwi76ADhYvowonFKCTWVcwyPGo9kLOslJvU5/UeptOWo9NauhA0ZVhdIvzQx
         QgP2N3zsdCAkf7M43uwOzlTEeu5dp4A5EGAi/6sxyKCDrLKHUIl2cmfdhlAntiLVQ1HK
         9MgjLUQDkVjT3heQcmSukQmeY3tixHDtfhiTWw1Lst0UVUknv47zhh27uzHEZn4sGziY
         pOmfHFqwpNyXmoMh3XXcNAVcXwz8KdRegF3bS+Nm92fkNXRdVjlW2KudGXQN22sE7bYm
         g8bqw0IDjArO69u26//gqNRi7tqFJeAfueVpTHRZjg1cSQ4/rwu28bUJ9FTs+OhHjclb
         O+8A==
X-Gm-Message-State: AOAM5314heafCJ9/SGC15EKrDhX7uyZ0ffJTktw9onLJHDG91D5FnEXV
        ryLraHg08W4n05rnkg1xewDlg7yND8xEpVzetHA=
X-Google-Smtp-Source: ABdhPJyxE9ZLstaujwX5hCSI7d9qGQogybWrt0htcuF5gPVOhU10hvBHbEuoP3RBuW5fOUJXa1Ogwz+9M3BUJX4SrtQ=
X-Received: by 2002:a05:622a:34b:: with SMTP id r11mr1068920qtw.121.1617169539224;
 Tue, 30 Mar 2021 22:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <1617085972-6094-1-git-send-email-shengjiu.wang@nxp.com> <20210330150521.GD4976@sirena.org.uk>
In-Reply-To: <20210330150521.GD4976@sirena.org.uk>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Wed, 31 Mar 2021 13:45:28 +0800
Message-ID: <CAA+D8AP-LC=zmd+5uMG_Q371pg3RrQPrJkURCx4=f0juUpHrFA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ASoC: ak5558: Add support for ak5552
To:     Mark Brown <broonie@kernel.org>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 11:06 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Mar 30, 2021 at 02:32:51PM +0800, Shengjiu Wang wrote:
>
> > +static const struct snd_kcontrol_new ak5552_snd_controls[] = {
> > +     SOC_ENUM("AK5552 Monaural Mode", ak5552_mono_enum[0]),
> > +     SOC_ENUM("AK5552 Digital Filter", ak5558_adcset_enum[0]),
> > +};
>
> It's a bit weird to have AK5552 in the control name - any reason for
> that?

Just to distinguish ak5558 and ak5552, but I think it can be removed.
will update it in v2

Best regards
wang shengjiu
