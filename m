Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8CCC365EFE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 20:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbhDTSEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 14:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbhDTSE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 14:04:28 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD9DC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 11:03:56 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id n138so62958929lfa.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 11:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gE/xHk8gIJnXC0D1s5Jzn/r/flDjnavjc9ly70d96xQ=;
        b=oXhXKDYZUSYbojnBLgqcHutqlf+Or0uZisHWYxrNl0Y3lfhT3S7vZy3E1Atqtdn21p
         78nYnQOeuB5UOOOiL21d1v7CDLztCAwcH5M8BlSrn1bjHNWMslE2RN4R5ydrskECgb+h
         HcfJma6chMr/8AqnrS0hQMGHW6baBYd2M21uyOi0i/C98ClR5oo9fy1uZswQgvm0facT
         6j1epsmjE1awoH5v5jYg0TFtkibhb6By4tbBvT2p33ZP9szz4oAiZNL5SqraYFzknIMO
         wRfNAEtqzlwpPRMrHzJuP8uKHbLnirxl9QeLmc6jAq21wqNApcGhMxFMqBqppXmYosYP
         inRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gE/xHk8gIJnXC0D1s5Jzn/r/flDjnavjc9ly70d96xQ=;
        b=aO/AZB49CSxMY/IDuY4CssHQAaCFDoGh/lsEOAPD/oXI7ja6dQTDgOPvvNDthrFfU5
         ObndMHm2P5Ea6U/qN+MD+HP55YglFKoPtaVAZNYFBcezbNKnn5M/GnCjFwpB1iZHNZme
         /xMnNgvXQM900osFYBYez1QMlhJw71ZNmRm/wZ/DHW35YXt9QqGR7im4D/o4sgPMeFkS
         IGNe5fMd2B/Bfp6r5wt+PC4EReqdXb3zExK3lzK3rSXTnrPaJMd5IYqaNlqrid4Uj6lA
         owINNn41xVGjkycnewT3AMO8l2wIG1MvsW6WLwnwalb7t6CmlUewB+ZIU7n5lvzt1Z06
         VdFg==
X-Gm-Message-State: AOAM533v02HUn9FrtOp/qZzoPeVEtBVwHdibhVEM0IPazrqoozj7XIt5
        sY4eVWUEKagTozZFQpGu+7eU6wy7KwU+OpwhGTI=
X-Google-Smtp-Source: ABdhPJyYpQQcBUd+x0BFgbdil+6Mis6ubke0BeQX4Eg4XvA8gbr42vmqTL2Fv2E4by3ywdzXQT37RfpITxsJWZbE0nE=
X-Received: by 2002:a05:6512:308d:: with SMTP id z13mr3925433lfd.130.1618941835264;
 Tue, 20 Apr 2021 11:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsOifMk4+VHi4bnHCL2L_tT+Tm_Rz+KxD3ZQOowx1xms4g@mail.gmail.com>
 <293189a2-3a6b-1e50-7607-33917743b9d8@amd.com> <CABXGCsMMUa=0+GAHxfVdOOFO0Lx=tCa4+ongHN8rF4TAR9nVmg@mail.gmail.com>
 <66f5fdcb-d414-603d-bdb8-70579335b4a2@gmail.com>
In-Reply-To: <66f5fdcb-d414-603d-bdb8-70579335b4a2@gmail.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Tue, 20 Apr 2021 23:03:44 +0500
Message-ID: <CABXGCsP+qjMuPpi7o=mnuvcuRyViYxiT8qEsqS2kHwMSEs835A@mail.gmail.com>
Subject: Re: [BUG] VAAPI encoder cause kernel panic if encoded video in 4K
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2021 at 11:48, Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> >> commit f63da9ae7584280582cbc834b20cc18bfb203b14
> >> Author: Philip Yang <Philip.Yang@amd.com>
> >> Date:   Thu Apr 1 00:22:23 2021 -0400
> >>
> >>       drm/amdgpu: reserve fence slot to update page table
> >>
>
> That is expected behavior, the application is just buggy and causing a
> page fault on the GPU.
>
> The kernel should just not crash with a backtrace.
>

Any chance to see this commit to be backported to 5.12?
I plan to submit a bug report to OBS devs and don't want my system to
hang again and again when I would test their patches.

--=20
Best Regards,
Mike Gavrilov.
