Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A947636CFFB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 02:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238236AbhD1A2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 20:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhD1A15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 20:27:57 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B83FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 17:27:11 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id z23so23739921lji.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 17:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2a4y88/F8W7qUoEwL5UNyDw7aPSVIQ4F7yZZlcOOYM8=;
        b=HaEd5IVFmRBlWEGN2OKvouixEKl8O4cOmn9sjZ16iCZMBhMBTb/8hTEWv3vcfrg9V3
         GSTO7KXJTl0M/ClGPkiRNrjkMlcF25Pul2TK+um4uf/geHFKoZRmzaiA1kCZOJ1TWtGm
         VocidabqBjm2Tzgp2nKgm+xe/krglqpHpwy9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2a4y88/F8W7qUoEwL5UNyDw7aPSVIQ4F7yZZlcOOYM8=;
        b=MNWWnxvJFLveN8Ib1S63gXXyP8Gf6rkKUJJOdsFX+zmTNF8rSAR48ApNx0ozznBRnD
         irsXGNMp8gH7BJamAQdkv1BxW7KMi1EApczNKWee/W372nr6QtS05rYAhFVmzCRQyIVn
         yGXaUmev49brRWWxA+0ke3ht617A0lrLtCrqFCC2ENgqtec6Va1OQws3ZRpvVqJafmYm
         CWSwSBYaLxAautj5gsI3oz9RhcmeiXPNooqawHPPih8MGWl4saJGoFYGAVx0cfgGu450
         S0O90VuKFQkfmrwVW9MRxAda++PDdG6CZovbjpskGYs5f/I6HLfkV12y+T8mkzVYLPfr
         R4YQ==
X-Gm-Message-State: AOAM532Ki4suq9OFB/D6Ml1EsWLLY37rXipDqy4TMhv6fnqjQR07q1Ax
        eCSQLRgRdGsJXBruw5mAtJp84r0Tl0cl2RJv
X-Google-Smtp-Source: ABdhPJxg6GN8T/2nCDJRNXhz1faS0hbSdTeKN/YAqnIwSOG4GTkpPIe70OkQJB8PjefIS+mXZAK1bw==
X-Received: by 2002:a2e:b4ba:: with SMTP id q26mr18152237ljm.223.1619569629690;
        Tue, 27 Apr 2021 17:27:09 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id b9sm310403lfb.67.2021.04.27.17.27.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 17:27:09 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id z13so15389219lft.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 17:27:09 -0700 (PDT)
X-Received: by 2002:ac2:51ae:: with SMTP id f14mr13482160lfk.377.1619569629081;
 Tue, 27 Apr 2021 17:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tyKdGHyiRLDooKrMf=02GtNn8U4YfF4dJtXdabnVAGdXQ@mail.gmail.com>
 <CAHk-=whOOVBBuQceJ9D9uZrv-QOUWGMQ4aZe2K+2X24o7xA8cg@mail.gmail.com>
In-Reply-To: <CAHk-=whOOVBBuQceJ9D9uZrv-QOUWGMQ4aZe2K+2X24o7xA8cg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 27 Apr 2021 17:26:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=whZN6zfnOTYmrUvur-+Mw8UOBpQxuhCJQ-R7J9zwsGwBA@mail.gmail.com>
Message-ID: <CAHk-=whZN6zfnOTYmrUvur-+Mw8UOBpQxuhCJQ-R7J9zwsGwBA@mail.gmail.com>
Subject: Re: New warnings with gcc-11
To:     Dave Airlie <airlied@gmail.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 4:43 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I think I will make the argument type to intel_print_wm_latency() be
> just "const u16 wm[]" for now, just to avoid seeing a ton of silly
> warnings.

After fixing the trivial ones, this one remains:

  drivers/gpu/drm/i915/display/intel_dp.c: In function
=E2=80=98intel_dp_check_mst_status=E2=80=99:
  drivers/gpu/drm/i915/display/intel_dp.c:4554:22: warning:
=E2=80=98drm_dp_channel_eq_ok=E2=80=99 reading 6 bytes from a region of siz=
e 4
[-Wstringop-overread]
   4554 |                     !drm_dp_channel_eq_ok(&esi[10],
intel_dp->lane_count)) {
        |
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/gpu/drm/i915/display/intel_dp.c:4554:22: note: referencing
argument 1 of type =E2=80=98const u8 *=E2=80=99 {aka =E2=80=98const unsigne=
d char *=E2=80=99}
  In file included from drivers/gpu/drm/i915/display/intel_dp.c:38:
  ./include/drm/drm_dp_helper.h:1459:6: note: in a call to function
=E2=80=98drm_dp_channel_eq_ok=E2=80=99
   1459 | bool drm_dp_channel_eq_ok(const u8 link_status[DP_LINK_STATUS_SIZ=
E],
        |      ^~~~~~~~~~~~~~~~~~~~

and I'm not fixing that one, because it actually looks like a valid
warning, and doesn't have an obvious fix.

That "esi[]" array is 14 bytes in size (DP_DPRX_ESI_LEN). So when it
does that "&esi[10]" and passes it in as an argument, then only 4
bytes remain of the array.

And drm_dp_channel_eq_ok() supposedly takes a "const u8
link_status[DP_LINK_STATUS_SIZE]", which is 6 bytes.

There may be some reason this is ok, but it does look a bit fishy, and
the compiler warning is appropriate.

            Linus
