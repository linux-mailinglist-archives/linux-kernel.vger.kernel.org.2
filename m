Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C3F3BD86E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 16:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbhGFOlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 10:41:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54204 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232378AbhGFOkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 10:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625582284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=KjCstSouDZkw7Bqtv4k/PxEoOLOmqdR6D9R+ZD8bKSg=;
        b=LUSy9DaGD0DakqVcp9uKO9ZNQpU31Z0AGjDiZoJ8pzxtNxeZOEDAzFTHVKJRhh3UXR6hbO
        /7iOVHT/k3f25K3lrsd38B0FmcM/MMbC4OsHEd/lGqLoHxwyjRT53Umn/DqmdDfHL3WYeH
        kIze1LvAZ8rtrsqzGCtIko9teqBoPv4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-3K1ssg56Mmm2C-jJyGK8MQ-1; Tue, 06 Jul 2021 10:26:42 -0400
X-MC-Unique: 3K1ssg56Mmm2C-jJyGK8MQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF307800D62;
        Tue,  6 Jul 2021 14:26:40 +0000 (UTC)
Received: from eperezma.remote.csb (ovpn-113-20.ams2.redhat.com [10.36.113.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F08B860583;
        Tue,  6 Jul 2021 14:26:35 +0000 (UTC)
From:   =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To:     mst@redhat.com, linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Jason Wang <jasowang@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Yunsheng Lin <linyunsheng@huawei.com>
Subject: [PATCH 0/2] tools/virtio: fix compilation
Date:   Tue,  6 Jul 2021 16:26:30 +0200
Message-Id: <20210706142632.670483-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Virtio testing tools cannot build. Fixing.=0D
=0D
Comments are welcome, specially in case I missed use of stub lockdep.h.=0D
=0D
I couldn't try some of the tools, that already did not compile on 5.13:=0D
gpio, liblockdep, selftests, bpf, tracing.=0D
=0D
Eugenio P=C3=A9rez (2):=0D
  tools: Remove lockdep.h and its include from spinlock.h=0D
  vringh: Include spinlock.h=0D
=0D
 include/linux/vringh.h                   |  1 +=0D
 tools/include/linux/spinlock.h           |  2 --=0D
 tools/testing/radix-tree/linux/lockdep.h | 11 -----------=0D
 3 files changed, 1 insertion(+), 13 deletions(-)=0D
 delete mode 100644 tools/testing/radix-tree/linux/lockdep.h=0D
=0D
-- =0D
2.27.0=0D
=0D

