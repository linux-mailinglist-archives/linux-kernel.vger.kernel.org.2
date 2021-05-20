Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3366A38B034
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 15:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238623AbhETNnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 09:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235990AbhETNm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 09:42:29 -0400
X-Greylist: delayed 88 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 20 May 2021 06:41:07 PDT
Received: from forwardcorp1j.mail.yandex.net (forwardcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BCDC061574;
        Thu, 20 May 2021 06:41:07 -0700 (PDT)
Received: from sas1-ec30c78b6c5b.qloud-c.yandex.net (sas1-ec30c78b6c5b.qloud-c.yandex.net [IPv6:2a02:6b8:c14:2704:0:640:ec30:c78b])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id C5B8A2E165E;
        Thu, 20 May 2021 16:39:35 +0300 (MSK)
Received: from sas2-d40aa8807eff.qloud-c.yandex.net (sas2-d40aa8807eff.qloud-c.yandex.net [2a02:6b8:c08:b921:0:640:d40a:a880])
        by sas1-ec30c78b6c5b.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id AgEdTKRXvS-dY1CE8Tu;
        Thu, 20 May 2021 16:39:35 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1621517975; bh=2/j+rJoNFJovtIB7ILHwwzCaflRG/GkxqtbR3VsPtu8=;
        h=Message-Id:Date:Subject:To:From:Cc;
        b=lixh3qXJ/jZMB3RKuNFxIikAfsdNm+Nfj7tNcnPSkMrOV2ZYSWmONbg8fvlccvT00
         m+/6iSwWIhczGZfk4Vf0DGwJXbWlwSV5jxnSngOKlY2kbL7PTwmh1RcUjgEiOINtYu
         dr3FkvUCPx4ne8hMt7eH8N/jpHUgb4F6zccuymk0=
Authentication-Results: sas1-ec30c78b6c5b.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from 172.31.109.104-vpn.dhcp.yndx.net (172.31.109.104-vpn.dhcp.yndx.net [172.31.109.104])
        by sas2-d40aa8807eff.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id kx0LBZ7Ldj-dYoC4gTE;
        Thu, 20 May 2021 16:39:34 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Yury Kamenev <damtev@yandex-team.ru>
To:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, axboe@kernel.dk,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yury Kamenev <damtev@yandex-team.ru>
Subject: [PATCH 0/1] virtio: disable partitions scanning for no partitions block
Date:   Thu, 20 May 2021 16:39:07 +0300
Message-Id: <20210520133908.98891-1-damtev@yandex-team.ru>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some virtio blocks definitely have no partitions and should not be scanned.

Yury Kamenev (1):
  virtio: disable partitions scanning for no partitions block

 drivers/block/virtio_blk.c      | 6 ++++++
 include/uapi/linux/virtio_blk.h | 1 +
 2 files changed, 7 insertions(+)

-- 
2.24.3 (Apple Git-128)

