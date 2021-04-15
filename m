Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 301FC360192
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 07:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhDOF1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 01:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhDOF1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 01:27:23 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8998C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 22:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
        :Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=FMTd8I8cM7ZBmOYcdPGq5q1CD9LHK5h6uuZ0K6Eod94=; b=gs7eGgnMpOvl7mf1Md8+Hgyu+u
        zr9W8DMqYp0bX7sUfA2mOC5r0JWxkLSSkGLLFzsELCUJrw/Sy5VCu402GbwsSVA1s+G6GqXw/l6MD
        bPXN+rM5fIz8fb9gYZm2mFSHXlJgZCDe27CCACKBAROSr3xUUrdRCKr0S/omkGV7gNFZ61YbksKfh
        g149DSC4YV4TUBEtZSEunvbW4/Dcu8k/DoIbVGQgeruIungJF7d+C9Kwff19mwKeh4IZWp5IYD+Wt
        /pKbSICrXfRHe4rtHeX0qynsueOPE3/yfVkKWCrCKrJj2G9ZBNaW3A0Qba7bp/BwD7XVhK9UaF0IO
        UnIN2Vxg==;
Received: from [2601:1c0:6280:3f0::df68] (helo=smtpauth.infradead.org)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lWuWi-00Eu5H-3E; Thu, 15 Apr 2021 05:26:54 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Anton Yakovlev <anton.yakovlev@opensynergy.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org,
        alsa-devel@alsa-project.org
Subject: [PATCH] sound: virtio: correct the function name in kernel-doc comment
Date:   Wed, 14 Apr 2021 22:26:45 -0700
Message-Id: <20210415052645.14465-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kernel-doc warning that the wrong function name is used in a
kernel-doc comment:

../sound/virtio/virtio_ctl_msg.c:70: warning: expecting prototype for virtsnd_ctl_msg_request(). Prototype was for virtsnd_ctl_msg_response() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org
Cc: alsa-devel@alsa-project.org
---
 sound/virtio/virtio_ctl_msg.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20210414.orig/sound/virtio/virtio_ctl_msg.c
+++ linux-next-20210414/sound/virtio/virtio_ctl_msg.c
@@ -61,7 +61,7 @@ void *virtsnd_ctl_msg_request(struct vir
 }
 
 /**
- * virtsnd_ctl_msg_request() - Get a pointer to the response header.
+ * virtsnd_ctl_msg_response() - Get a pointer to the response header.
  * @msg: Control message.
  *
  * Context: Any context.
