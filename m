Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7729935E821
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 23:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348394AbhDMVTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 17:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348385AbhDMVTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 17:19:44 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697DDC061756
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 14:19:23 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id r22so10284767ljc.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 14:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=enhHLE/5y2NdlKSskcLj+WinLbXmD8cGKb9xuV9HkB4=;
        b=qm6O8dQlxP59p9QcAZiByLt63o4HMtrvUwK4K7w+mg/kjx1MDaUSkRFQxesDbVuqMv
         1FamQg6A5/GAWF9nGEc3wYe+WOHEzmNmiV4cjGyfUB7IwDEUGfXxm8amD+4JiQKcpAQ8
         +ZTnAwV2HMKiYn668R6ks1ipSrCz1f/q5DpYwzrXqJcxOgLxQzZ9KupwfpGqow0ubBMj
         oltz1HVOgSo0QiIlYRR5fEafkO5Tn5JCFCVIJwefl5LuPJ7Poc9QQmftvwstzPs3tnpV
         N5Szl4MgcCe8oLevRieOedY0ITVCRdeLg362XbXiA4MJWLHxcu8OhADgW8ndw7qQYDjg
         guOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=enhHLE/5y2NdlKSskcLj+WinLbXmD8cGKb9xuV9HkB4=;
        b=ppzRuPQA+5hnv/r+npapnLG0DNNUqHcpDZS6jGlFwyP+MY/YL7HkN1xs6uWJf9XRup
         3oWL0QZqLxhcWSLj0ppQ5ylZVUcv433Z5deahYU5Rw16bagq7J7VYpE4UvzFY6bC/rKt
         Rx+qH49hdb6OybSe4aHyy8GVyRjqUFdYYki5LTempvB0w+YssaVkPOwCfBG1aJpEgQc5
         hxYeJJVfIsyIqsE3Fp39KiHt6AEJJqiPv/lkebDiFJtoCKG05tROSi8uAmF2A23ZcC+K
         7rEWgvRziuB0ljMpdipTyeLHde7GEBoXvm1siJi0dXjjjgW4rZIO4ZUu/Xqwpef+fLDG
         72YQ==
X-Gm-Message-State: AOAM530Aha5sAMiP34iGo0XAYxIRll3D7oh8Foleg519S3Hsb/HHqFXk
        v5pipSbj5VwOEF8eNn2mu3rZBRVrbUr9vlVUVSs=
X-Google-Smtp-Source: ABdhPJwI9aKukGojq9kC2CBk6o4jWbmOxwHYprh8RiEyyePFzry2DSR3tbtouB3Vg1GcGTVEnF34BMeI7SJYF6LkkPk=
X-Received: by 2002:a05:651c:312:: with SMTP id a18mr11403270ljp.52.1618348761852;
 Tue, 13 Apr 2021 14:19:21 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsOifMk4+VHi4bnHCL2L_tT+Tm_Rz+KxD3ZQOowx1xms4g@mail.gmail.com>
 <293189a2-3a6b-1e50-7607-33917743b9d8@amd.com>
In-Reply-To: <293189a2-3a6b-1e50-7607-33917743b9d8@amd.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Wed, 14 Apr 2021 02:19:10 +0500
Message-ID: <CABXGCsMMUa=0+GAHxfVdOOFO0Lx=tCa4+ongHN8rF4TAR9nVmg@mail.gmail.com>
Subject: Re: [BUG] VAAPI encoder cause kernel panic if encoded video in 4K
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Apr 2021 at 12:29, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
>
> Hi Mikhail,
>
> the crash is a known issue and should be fixed by:
>
> commit f63da9ae7584280582cbc834b20cc18bfb203b14
> Author: Philip Yang <Philip.Yang@amd.com>
> Date:   Thu Apr 1 00:22:23 2021 -0400
>
>      drm/amdgpu: reserve fence slot to update page table
>

Unfortunately, this commit couldn't fix the initial problem.
1. Result video is jerky if it grabbed and encoded with ffmpeg
(h264_vaapi codec).
2. OBS still crashed if I try to record or stream video.
3. In the kernel log still appears the message "amdgpu: [mmhub] page
fault (src_id:0 ring:0 vmid:4 pasid:32770, for process obs" if I tried
to record or stream video by OBS.

--=20
Best Regards,
Mike Gavrilov.
