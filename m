Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4673714FA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 14:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbhECMDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 08:03:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233847AbhECMB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 08:01:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A92B56135F;
        Mon,  3 May 2021 12:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620043266;
        bh=pXUEDcWhibUjxVw0FrtdRnk9h/zPgVPVi1p0eh0J+DI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eXil3EOpOhHhdBxUMFD74Bb+WqGLsodpjQqt/H6qfZOuNr4W5F1wggW5nZv4MMEf7
         xGMvElcxOZtuiOu+AGRomOUYzYRv3SoNES3pLn4bNzr7QCeu1XuSv2Rk+aCuF7nFS8
         CFfBsIaOCRlxI5YMu5uTekwCkdrKe63hRehMj/UY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH 37/69] ALSA: usx2y: check for failure of usb_alloc_urb()
Date:   Mon,  3 May 2021 13:57:04 +0200
Message-Id: <20210503115736.2104747-38-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
References: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While it is almost impossible to hit an error calling usb_alloc_urb(),
to make systems like syzbot which does error injection, and some static
analysis tools happy, properly handle errors on this path by unwinding
the previously allocated urbs and freeing them.

Cc: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/usx2y/usb_stream.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/sound/usb/usx2y/usb_stream.c b/sound/usb/usx2y/usb_stream.c
index 6bba17bf689a..1091ea96a29a 100644
--- a/sound/usb/usx2y/usb_stream.c
+++ b/sound/usb/usx2y/usb_stream.c
@@ -88,18 +88,35 @@ static int init_urbs(struct usb_stream_kernel *sk, unsigned use_packsize,
 					sizeof(struct usb_stream_packet) *
 					s->inpackets;
 	int			u;
+	int			i;
+	int			err = -ENOMEM;
 
 	for (u = 0; u < USB_STREAM_NURBS; ++u) {
+		sk->outurb[u] = NULL;
 		sk->inurb[u] = usb_alloc_urb(sk->n_o_ps, GFP_KERNEL);
+		if (!sk->inurb[u])
+			goto error;
 		sk->outurb[u] = usb_alloc_urb(sk->n_o_ps, GFP_KERNEL);
+		if (!sk->outurb[u])
+			goto error;
 	}
+	u--;
 
 	if (init_pipe_urbs(sk, use_packsize, sk->inurb, indata, dev, in_pipe) ||
 	    init_pipe_urbs(sk, use_packsize, sk->outurb, sk->write_page, dev,
-			   out_pipe))
-		return -EINVAL;
+			   out_pipe)) {
+		err = -EINVAL;
+		goto error;
+	}
 
 	return 0;
+
+error:
+	for (i = 0; i <= u; ++i) {
+		usb_free_urb(sk->inurb[i]);
+		usb_free_urb(sk->outurb[i]);
+	}
+	return err;
 }
 
 
-- 
2.31.1

