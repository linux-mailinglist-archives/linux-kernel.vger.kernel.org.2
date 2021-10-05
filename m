Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA78421F3B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 09:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbhJEHGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 03:06:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42804 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230526AbhJEHGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 03:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633417453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=MwInSBtYmEyMyAif3gbAt3an+xVu0NUGoBdgjgo4es8=;
        b=aviES+LSZU74pNRgHy9HsyS9dzeaQ1OufFAFdur7ZvIHUblc7fDTo9mU3yBlH4mswtf/r/
        jrwZ2ph6ubxbwu8sGzIGAo8c3+qlxNXuIzRUYSfv/wRqtAJmOCOC7DoSZEIxW84X1mYE6t
        bI6h4UZXotDVvgp8JEyZ+cPjsIeU7+8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-xQ1OqefrOZOSsJQC-3aJOg-1; Tue, 05 Oct 2021 03:04:12 -0400
X-MC-Unique: xQ1OqefrOZOSsJQC-3aJOg-1
Received: by mail-ed1-f70.google.com with SMTP id c30-20020a50f61e000000b003daf3955d5aso5152575edn.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 00:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=MwInSBtYmEyMyAif3gbAt3an+xVu0NUGoBdgjgo4es8=;
        b=TGzUCjsQvo+rLoNBttgVGl8plWTv2eyZiWySMhSEDRkkcKwIY0/e3s0cnDa2acm/HN
         pnc/mV6kc31aj4mGodJ/nqbnja+DPWYs8uYHRR6Sn/qCISwAbs7c35DqBibcVa2y4rVV
         joZFXRCQImoykg8YND5agMiAi4qDW4EJb5k8lmmGB3l++/icHBnvc4RFbcntIresbOF7
         5eSIBli6odZRCKB8OgTEeOM0xiprc+5pJt8GGcTiqrUocG06AgDlDP5IFDCVBaXjUGGz
         MhVoBiv3DlpAhz0vr41LxAfBi8merFy/YkAKwrB6gO9zTNoYfIKMwvLHhq88VKTJT0Sd
         GvJA==
X-Gm-Message-State: AOAM532zafALWoefKnQOyAjkff5lA0Wb9qkbeZeEMUeEWXx5u318a1Ly
        vDbAROlwuz+lJBMnEOfoXdht7mvW+t/7s1KFVcEogVf62B/iSiqwNOu23CylkDszS8P1MvHaRDt
        NiV+opXAI6XjEpIMKbetc0oArmmUR4/Daz7vJy+TazFDDn3fnrqMx0/Qsz07DkoRVS4lwGA==
X-Received: by 2002:a05:6402:1b8a:: with SMTP id cc10mr23533879edb.313.1633417450621;
        Tue, 05 Oct 2021 00:04:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzY7TKGubb0zmZNFzLoIzxm3WkaPK9JNBr5tNNxLovtIG5E0rgMolF1pMxF4SXqmvMM/BQpOA==
X-Received: by 2002:a05:6402:1b8a:: with SMTP id cc10mr23533849edb.313.1633417450387;
        Tue, 05 Oct 2021 00:04:10 -0700 (PDT)
Received: from redhat.com ([2.55.147.134])
        by smtp.gmail.com with ESMTPSA id a1sm7729375edu.43.2021.10.05.00.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 00:04:09 -0700 (PDT)
Date:   Tue, 5 Oct 2021 03:04:07 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH] virtio_console: break out of buf poll on remove
Message-ID: <20211005070354.265164-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A common pattern for device reset is currently:
vdev->config->reset(vdev);
.. cleanup ..

reset prevents new interrupts from arriving and waits for interrupt
handlers to finish.

However if - as is common - the handler queues a work request which is
flushed during the cleanup stage, we have code adding buffers / trying
to get buffers while device is reset. Not good.

This was reproduced by running
	modprobe virtio_console
	modprobe -r virtio_console
in a loop.

Fixing this comprehensively needs some thought, and new APIs.
Let's at least handle the specific case of virtio_console
removal that was reported in the field.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1786239
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/char/virtio_console.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 7eaf303a7a86..c852ce0b4d56 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1956,6 +1956,12 @@ static void virtcons_remove(struct virtio_device *vdev)
 	list_del(&portdev->list);
 	spin_unlock_irq(&pdrvdata_lock);
 
+	/* Device is going away, exit any polling for buffers */
+	virtio_break_device(vdev);
+	if (use_multiport(portdev))
+		flush_work(&portdev->control_work);
+	else
+		flush_work(&portdev->config_work);
 	/* Disable interrupts for vqs */
 	vdev->config->reset(vdev);
 	/* Finish up work that's lined up */
-- 
MST

