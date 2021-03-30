Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2348234EC97
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 17:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbhC3Pe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 11:34:56 -0400
Received: from mengyan1223.wang ([89.208.246.23]:33038 "EHLO mengyan1223.wang"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232374AbhC3Pef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 11:34:35 -0400
Received: from xry111-X57S1.. (unknown [IPv6:240e:35a:1037:8a00:70b2:e35d:833c:af3e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@mengyan1223.wang)
        by mengyan1223.wang (Postfix) with ESMTPSA id 536386594D;
        Tue, 30 Mar 2021 11:34:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mengyan1223.wang;
        s=mail; t=1617118474;
        bh=E9uzJ2n1hFC18R1jMFthKg1gWzK5bofu21stYTwkJoo=;
        h=From:To:Cc:Subject:Date:From;
        b=1S7zq7qygFhaboB0wDdtkxcOCCrRWc5zG0DVbbjctvEIh2YPWGepr16K+DKQ34QtO
         vZSvzH2VaHuHvjBxj7zcRVXhBgXzh1+PmbhnayfNvWzih1l8VDztADbPCX3uG1ybP8
         X8HnU/OJPhli25bFWf2SZVE+U9XL1e28LecLCmY8ugdt7pB05IzVhYV1eG/zkWDH5v
         wNv58IpgrCL4B65Jthj8YqUnuccF7a4HxI2/ECrXnZXer38PDq5+MUzmuyjkjZ0esv
         FwXABm/1Uu1V9BtG2JWXIJpRgzeaWEsm23FAGerbK03jKG0HKuXKC6kcRnqay4c9+Y
         cte5a3GQ2R+Nw==
From:   =?UTF-8?q?X=E2=84=B9=20Ruoyao?= <xry111@mengyan1223.wang>
To:     amd-gfx@lists.freedesktop.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        =?UTF-8?q?Dan=20Hor=C3=A1k?= <dan@danny.cz>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        =?UTF-8?q?X=E2=84=B9=20Ruoyao?= <xry111@mengyan1223.wang>
Subject: [PATCH 0/2] ensure alignment on CPU page for bo mapping
Date:   Tue, 30 Mar 2021 23:33:32 +0800
Message-Id: <20210330153334.44570-1-xry111@mengyan1223.wang>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In AMDGPU driver, the bo mapping should always align to CPU page or
the page table is corrupted.

The first patch is cherry-picked from Loongson community, which sets a
suitable dev_info.gart_page_size so Mesa will handle the alignment
correctly.

The second patch is added to ensure an ioctl with unaligned parameter to
be rejected -EINVAL, instead of causing page table corruption.

The patches should be applied for drm-next.

Huacai Chen (1):
  drm/amdgpu: Set a suitable dev_info.gart_page_size

Xℹ Ruoyao (1):
  drm/amdgpu: check alignment on CPU page for bo map

 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)


base-commit: a0c8b193bfe81cc8e9c7c162bb8d777ba12596f0
-- 
2.31.1

