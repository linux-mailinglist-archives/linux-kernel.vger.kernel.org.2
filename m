Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789B23F21A1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 22:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235878AbhHSU3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 16:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235352AbhHSU3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 16:29:07 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4042CC061292
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 13:28:29 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id x16so6598710pfh.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 13:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7BmMwB56/tf81QYzz1dJjsAP+TKJKa73m/kJUppNO1k=;
        b=H0khrC27nefPi4TPO+akLEMsfICTGJ38sMGOl7fqtkLK6QbwzwnhFHh77LKo9BQo97
         uB0SEQHqI9AmDe3O+VOwR88+YBHkJsnOaL0wV27bHHsKFZ7+P8wd18jMD6EO4wV1O2nz
         LkvnmtujEWffW91OzJuNnovndzRXD6PAb3FUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7BmMwB56/tf81QYzz1dJjsAP+TKJKa73m/kJUppNO1k=;
        b=Nqbltn9ULYxGmXX+ye7FXmo3ddE6caqAv/7g6z1ubyfAqvfru6y6uUceB3OSTuIAgU
         NmVt+jZtmh8mbBka7EtaxIJr2yD0HAGDctcUDgxCHNNznZAs3PHWu34AleNmiBcSq6zZ
         h/HszVvr2Ar63YU32TQwdotLI/ipvBEpPaMkcmT0LN3wkG1QhZey5VtlCG411lk9Gs9Z
         Gfkc9iUS813HAYCdVvhZgAXVaa4ti66GZjZTk6X2t0kw5hz24ivpTLkgULOuEubj7TsP
         6CJkQljb8Lw85GcW8+vR0ku8OMZwdgVzoYYPoCMKwTp2LADwJtwZEaQ3KkyQ4g8tRCUs
         phRA==
X-Gm-Message-State: AOAM530qbPOto2UWWuastOm2Fmxo5omK5oFfJBZcQYL59DzsFJ9Scplg
        oCfVZdGEEgp7JH307QD/4HIupA==
X-Google-Smtp-Source: ABdhPJwBwTwati1bY3MTycSie0IRt5wIeaqOaw59+Eej05BsSQ9Odxt7CVzlngkJjZjCO/3shrUcGA==
X-Received: by 2002:a05:6a00:2d6:b0:3e2:da0e:30c8 with SMTP id b22-20020a056a0002d600b003e2da0e30c8mr11210539pft.5.1629404909344;
        Thu, 19 Aug 2021 13:28:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b6sm4701800pgs.94.2021.08.19.13.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 13:28:28 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     netdev@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Stanislav Yakovlev <stas.yakovlev@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-rdma@vger.kernel.org,
        bpf@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 0/3] net: Cleanups for FORTIFY_SOURCE
Date:   Thu, 19 Aug 2021 13:28:22 -0700
Message-Id: <20210819202825.3545692-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=939; h=from:subject; bh=xu51d0uSjF8p/6CmPlqDJce+9b/KxPieOk/fd0W2RNE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHr7oeuE5Hk6ttR0/276Ucq7WsZ1PJMejfCZIJ5ja WFAOar6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYR6+6AAKCRCJcvTf3G3AJi+vD/ 9PovNPdpG3KfYLjfa5Wq+Rx9PVxGTCcy8753xHYa5slO0mAcBbC9pctQ8SY/YQP4YIge5P0eBw3pEe Fmzjuf/yYx64lXiW62yPeozuyn4ezJe1S8tR5aFxb4YeZ3ndkEOcMmsNpuUhUzkkaaaa0L6EAqNfE2 H2ChsbDgszgE+3ji28i8SwAMIkYxZCoFRNT7zbfBSx2lBo3cxvduLgc25RUNpthYSphnn/Qc9r7boC gkWajXv9KXoerNH+LppmWDoFXO2FcD5rcuPhaVyofU9uUNidQGngqO6Y2a1W6UgZcA/Cc8BpHbnp0m Texen5JXiaNQAL8BA+uIPno6vD7G0wU/WIkbpwty3i6wnX1cQHnyHr0F0A/BGZ933ULETe4Qqy/Eov nT6Bu9R9PnhhL0GBig3IMlH7uxy+U/VCqw+bKVEzZhoBaV95QZomrezc2zUgo4vDwc5zr9a58XZEu3 dF3lctzDEHYAxjbFAZzjkANlyu1BBon3zwmKfw624SPm83iEVq+0+JA3fYd2segeAsHibt47VJ5I7t PQHEYWVwP2Ct/ogy38i1brMBdiERunX7r7TH7H804gT8IRt0/w4jyx5rFzgJa2g+quhCC1TD/ksBb3 vv9I7tId+0F4eLs0eAIhA6OtFKaHYUF18hkmFt178s/TR9TunNXNNC2VKSWQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally writing across neighboring fields.

These three changes have been living in my memcpy() series[1], but have
no external dependencies. It's probably better to have these go via
netdev.

Thanks!

-Kees

[1] https://lore.kernel.org/lkml/20210818060533.3569517-1-keescook@chromium.org/

Kees Cook (3):
  ipw2x00: Avoid field-overflowing memcpy()
  net/mlx5e: Avoid field-overflowing memcpy()
  pcmcia: ray_cs: Split memcpy() to avoid bounds check warning

 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  4 +-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  4 +-
 .../net/wireless/intel/ipw2x00/libipw_rx.c    | 56 ++++++-------------
 drivers/net/wireless/ray_cs.c                 |  4 +-
 4 files changed, 25 insertions(+), 43 deletions(-)

-- 
2.30.2

