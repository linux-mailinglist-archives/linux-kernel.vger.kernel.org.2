Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39EE36DD86
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 18:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241328AbhD1Qvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 12:51:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22155 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241260AbhD1Qvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 12:51:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619628661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=E/fqWNE7LQ7FhXknXyJchDB3GzeF4lW6wfnQ7hJxAE0=;
        b=Jrra77pJwDeHosjadApfF3izkQTS6WJgyyxts3Gae4g71xe0pOfTO5VS8jFdnQdPOjCGMH
        7B2KSDgCjIQZuczFdLjHfNcd5y9tK8VQkY1xjpYkhstg6fYk+n+xDsXft7U6MSCS5uSG90
        3rQ67ZIQ6Vmvxh0/0SsjY+3SK4hp910=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171--qo-T9cBO96lHXeEvi4-qw-1; Wed, 28 Apr 2021 12:50:57 -0400
X-MC-Unique: -qo-T9cBO96lHXeEvi4-qw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F32A8031FA;
        Wed, 28 Apr 2021 16:50:50 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-128.rdu2.redhat.com [10.10.116.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C74981007610;
        Wed, 28 Apr 2021 16:50:49 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 50E2C220BCF; Wed, 28 Apr 2021 12:50:49 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com,
        dan.j.williams@intel.com
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, jack@suse.cz,
        willy@infradead.org, slp@redhat.com
Subject: [PATCH v5 0/3] dax: Fix missed wakeup in put_unlocked_entry()
Date:   Wed, 28 Apr 2021 12:50:37 -0400
Message-Id: <20210428165040.1856202-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is V5 of patches. Posted V4 here.

https://lore.kernel.org/linux-fsdevel/20210423130723.1673919-1-vgoyal@redhat.com/

Changes since V4:

- Changed order of WAKE_NEXT and WAKE_ALL entries in enum. (Matthew Wilcox).

Thanks
Vivek

Vivek Goyal (3):
  dax: Add an enum for specifying dax wakup mode
  dax: Add a wakeup mode parameter to put_unlocked_entry()
  dax: Wake up all waiters after invalidating dax entry

 fs/dax.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

-- 
2.25.4

