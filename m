Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B820437F554
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 12:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbhEMKHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 06:07:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:37546 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232824AbhEMKET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 06:04:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620900187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j+l5tq5M/f1kECXbl74yHxqhOUkbjQkUE4NZC677IzI=;
        b=muXNug23i8D8WshIzxtjKc3x9GnLaAOKXKGlzsXTDl/23evlPFNCHKHd4a4SVRdSANqXEp
        icn4g/Bx1ghMjx9o1JXTxQFB4zJLnEvn3Te0fnTR9PVC/fhKkMdndGrcacL/hxHOGrnzad
        pwoTCoUMnAz3BRbea9XDOTFJf6ozUQ4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0DC46B15E;
        Thu, 13 May 2021 10:03:07 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH 8/8] xen/hvc: replace BUG_ON() with negative return value
Date:   Thu, 13 May 2021 12:03:02 +0200
Message-Id: <20210513100302.22027-9-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210513100302.22027-1-jgross@suse.com>
References: <20210513100302.22027-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xen frontends shouldn't BUG() in case of illegal data received from
their backends. So replace the BUG_ON()s when reading illegal data from
the ring page with negative return values.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/tty/hvc/hvc_xen.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/hvc/hvc_xen.c b/drivers/tty/hvc/hvc_xen.c
index 92c9a476defc..30d7ffb1e04c 100644
--- a/drivers/tty/hvc/hvc_xen.c
+++ b/drivers/tty/hvc/hvc_xen.c
@@ -86,6 +86,11 @@ static int __write_console(struct xencons_info *xencons,
 	cons = intf->out_cons;
 	prod = intf->out_prod;
 	mb();			/* update queue values before going on */
+
+	if (WARN_ONCE((prod - cons) > sizeof(intf->out),
+		      "Illegal ring page indices"))
+		return -EINVAL;
+
 	BUG_ON((prod - cons) > sizeof(intf->out));
 
 	while ((sent < len) && ((prod - cons) < sizeof(intf->out)))
@@ -114,7 +119,10 @@ static int domU_write_console(uint32_t vtermno, const char *data, int len)
 	 */
 	while (len) {
 		int sent = __write_console(cons, data, len);
-		
+
+		if (sent < 0)
+			return sent;
+
 		data += sent;
 		len -= sent;
 
@@ -138,7 +146,10 @@ static int domU_read_console(uint32_t vtermno, char *buf, int len)
 	cons = intf->in_cons;
 	prod = intf->in_prod;
 	mb();			/* get pointers before reading ring */
-	BUG_ON((prod - cons) > sizeof(intf->in));
+
+	if (WARN_ONCE((prod - cons) > sizeof(intf->in),
+		      "Illegal ring page indices"))
+		return -EINVAL;
 
 	while (cons != prod && recv < len)
 		buf[recv++] = intf->in[MASK_XENCONS_IDX(cons++, intf->in)];
-- 
2.26.2

