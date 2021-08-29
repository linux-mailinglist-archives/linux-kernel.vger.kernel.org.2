Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40FBE3FACEE
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 17:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235798AbhH2Pyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 11:54:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58968 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235738AbhH2Pyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 11:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630252431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=/jaF7jZC8q/DpP5yyhldi4uUkfv/Q/aJYUDR7M+5EQ4=;
        b=KQ5pApz2n835EnrAHbjDNq7xPjwus8ZD101vYJNGvXRMLvulWiaf8mVeuPZMHq6+AQO5ch
        c9xoLFKy3bVcxgSodg644ttoFoCrDgdoJ1fNwMfRW9zJeJEJAiVxPv4Z6lcIcyxbfl1iwH
        mSghjA0MFslE7+6mWMMF7+gOQopzx6A=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-gH4yxyq6Nnmvk27sUQu0Nw-1; Sun, 29 Aug 2021 11:53:50 -0400
X-MC-Unique: gH4yxyq6Nnmvk27sUQu0Nw-1
Received: by mail-ej1-f72.google.com with SMTP id ga42-20020a1709070c2a00b005dc8c1cc3a1so189281ejc.17
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 08:53:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=/jaF7jZC8q/DpP5yyhldi4uUkfv/Q/aJYUDR7M+5EQ4=;
        b=DKJlpAAQfOlkMVwfVBeTIveKG8kkAcXpUxnZm/D1pd2XV2ZX0+8i/JmuDFjivE+FVg
         03fN+WNWTpXvvs4TtFLKhB0dxo92gbhw8i8pPnVNl9wcocAuO2RkGXnyO0GiPQZlqMSq
         yOTe7vsBVRK/+20xMlxeS7Tall0QvV1Kkk7GyuwqOLh1nj+6TZMmGrx5H6nhevR3Fted
         t12keR/E6fWMfdAQgkuew96yk1IVXUrJnrOi8WevHDuPPE8WJpa2OpunnZM+3hx3bZBf
         UqIP5+ClUv1xJSEgZy0fiowbrVtfa6TE6k6x5Kxw+1XfGyEgJ6rIP78XSKs9YXvUeUjD
         btYQ==
X-Gm-Message-State: AOAM532psd2lZPACWWJrkJEup/6mRS7xUHoaPddGC2SolETFDjtGZ/oN
        SCtIDR54F+WNPSpbfvwC2p0oi0eL/3ZZNdmjUTB8HBnNJanZt7niWUuq9tsTTSPfbWFfn3NFh3D
        uHnUa+8zVJvyNmSOTwJIVqrgu
X-Received: by 2002:a17:907:212e:: with SMTP id qo14mr19145563ejb.501.1630252427534;
        Sun, 29 Aug 2021 08:53:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzobXz3Ef1GROPF3oUnWQrRnebrjXnwnoH6TBBe6U6SyFAGgXQrD00rBwtykUugZTIDZOQ8Lw==
X-Received: by 2002:a17:907:212e:: with SMTP id qo14mr19145554ejb.501.1630252427363;
        Sun, 29 Aug 2021 08:53:47 -0700 (PDT)
Received: from redhat.com ([2.55.137.4])
        by smtp.gmail.com with ESMTPSA id s3sm5652608ejm.49.2021.08.29.08.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 08:53:46 -0700 (PDT)
Date:   Sun, 29 Aug 2021 11:53:43 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, dan.carpenter@oracle.com,
        david@redhat.com, jasowang@redhat.com, mst@redhat.com,
        torvalds@linux-foundation.org
Subject: [GIT PULL] virtio: a last minute fix
Message-ID: <20210829115343-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Donnu if it's too late - was on vacation and this only arrived
Wednesday. Seems to be necessary to avoid introducing a regression
in virtio-mem.

The following changes since commit e22ce8eb631bdc47a4a4ea7ecf4e4ba499db4f93:

  Linux 5.14-rc7 (2021-08-22 14:24:56 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 816ff7595135948efde558221c8551bdd1869243:

  virtio-mem: fix sleeping in RCU read side section in virtio_mem_online_page_cb() (2021-08-29 11:50:04 -0400)

----------------------------------------------------------------
virtio: a last minute fix

Fix a regression in virtio-mem.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
David Hildenbrand (1):
      virtio-mem: fix sleeping in RCU read side section in virtio_mem_online_page_cb()

 drivers/virtio/virtio_mem.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

