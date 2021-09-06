Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2820E401A4A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 13:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235004AbhIFLCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 07:02:01 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:43741 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbhIFLCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 07:02:00 -0400
Received: from leknes.fjasle.eu ([92.116.67.85]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M6YEz-1mKiSF16Gf-006wug; Mon, 06 Sep 2021 13:00:46 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id B0DE03C06F; Mon,  6 Sep 2021 13:00:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1630926041; bh=+zY/N666dI+j+8Q++GxUyEvKFTQg7EkmGQw6oq0CEOw=;
        h=Date:From:To:Cc:Subject:From;
        b=DXVXIseC82m9Q874yyzN7Epsxcg9sQHv1ywmgXB+MAd0FKsF+luoTlpwVygTtmpj0
         CgeQ8Z9LszBwo2xh4GhWRhQ+CciTBxmrsMKgra0/KhZ2YBTHx9n6cv+mJT8Y5NJUaP
         kjF2Pm/CJwO8EcMa8VfgkrLHTbPH55Qkq0JVEIoc=
Date:   Mon, 6 Sep 2021 13:00:41 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH] [RESEND] fscache: re-match MODULE_PARM_DESC() calls to
 module parameters
Message-ID: <YTX02eiVawkpTquX@fjasle.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.30.1
X-Provags-ID: V03:K1:/H9DjLa+mnADC9aIrzArNFSQHwrOlJWq7UziF01SrgtYKe3fyS4
 w8n/RCNKHDOjWJPKrESZshtcxMIdjp2GnubrLLAls0AC2rx+JM7YLGNgOjeWfPVgCluiG3I
 c7TPivoD7ytkwANCCZPZkV23ovGWnpgnip6vi38nQkrBEdaqEgoGo77/fKRVMO8jgohNe54
 AKv7WbI5NQ8xV0E6H+Iig==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rJuJ/9MTm2k=:Cc1uw+93Nk28J9in4EW46Z
 oSQ9x1kyGNjy64Uv8x3FrAQ9SAkwOH5eziVP/vJFVlOglQXkAxSPrUeDy22B1iq9t89l27z5C
 VfZa6DCO6nSPSSE2DXZcIW/m+1S0/BLTM9BWsS9K6e6sKe5HOdwOV2ni4S5jNb0YIUyozvspl
 kLzo7g6n81x2JhRuSQkspIsTI1yep2MQcq0o2iM/BQRLIRYtZMi+o1/hw+KC2R1JBsDIEJ4+g
 NQNjwk4BpRb2ZSOvUUOVvlduMNzxf3Wvlx66kDnuHeGLNYnH2e3GzEdYJoWxqgxWSGmpSN5R4
 CFrAsfS7oOWlYvxS7xUaYqrTlgIa8cWW2c5jjGkV62N81kTIJpU6+to4OHNfG1huncEPTvxkO
 pGoV8Ns41uQs2uRJCzoEHdL2ev9HSveyxq/y0fKiTw71FGaZCp2BLGQYi2LcMYeMuzt6BkdrY
 wy92yoKZueubbRzlmxae3In1HmYwvdCoa4Okz7ItUDKmYmro5Lj4SYEHIDBEW6xR1OCMjtRae
 H09qevX485aX/dshUFb2HN1ISC7CepU5b9suTdhLmS+g5uxSqPa60x3yDmnEsYy4+gZ2CDy/f
 1yimwlZoYnpFkerxPC9EM89MvOKWM5+J0x7lb+f69nBCZxrA0XEZXjEU+q5KSYYHsvSdbDDxM
 XhP2TQx1ZuB1UGvVJXDYpum8+fc+M+HSE+2VTeFjn/ved34ToyB07jZ/GMUMqgRnmBcWP6J5N
 tyytnFWbHC1Lqrs3KxjhsByyxnAckYu/tVIUfA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix calls of MODULE_PARM_DESC() such that the first argument matches the
actual module parameter name.  This changes the 'parm' section in the
output of `modinfo fscache` from:

    parm: defer_lookup:uint
    parm: fscache_defer_lookup:Defer cookie lookup to background thread
    parm: defer_create:uint
    parm: fscache_defer_create:Defer cookie creation to background thread
    parm: debug:uint
    parm: fscache_debug:FS-Cache debugging mask

into:

    parm: defer_lookup:Defer cookie lookup to background thread (uint)
    parm: defer_create:Defer cookie creation to background thread (uint)
    parm: debug:FS-Cache debugging mask (uint)
.

Signed-off-by: Nicolas Schier <nicolas@fjasle.eu>
---
 fs/fscache/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--
Resend unmodified as list approval for linux-cachefs@r.c timed out.

diff --git a/fs/fscache/main.c b/fs/fscache/main.c
index c1e6cc9091aa..ccb06dc0a6e9 100644
--- a/fs/fscache/main.c
+++ b/fs/fscache/main.c
@@ -22,19 +22,19 @@ MODULE_LICENSE("GPL");
 unsigned fscache_defer_lookup = 1;
 module_param_named(defer_lookup, fscache_defer_lookup, uint,
 		   S_IWUSR | S_IRUGO);
-MODULE_PARM_DESC(fscache_defer_lookup,
+MODULE_PARM_DESC(defer_lookup,
 		 "Defer cookie lookup to background thread");
 
 unsigned fscache_defer_create = 1;
 module_param_named(defer_create, fscache_defer_create, uint,
 		   S_IWUSR | S_IRUGO);
-MODULE_PARM_DESC(fscache_defer_create,
+MODULE_PARM_DESC(defer_create,
 		 "Defer cookie creation to background thread");
 
 unsigned fscache_debug;
 module_param_named(debug, fscache_debug, uint,
 		   S_IWUSR | S_IRUGO);
-MODULE_PARM_DESC(fscache_debug,
+MODULE_PARM_DESC(debug,
 		 "FS-Cache debugging mask");
 
 struct kobject *fscache_root;
-- 
2.30.1
