Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1AC3FE37A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 21:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240444AbhIAT7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 15:59:17 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:37127 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbhIAT7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 15:59:14 -0400
Received: from leknes.fjasle.eu ([92.116.70.90]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M1HqM-1mIlDi0VIo-002pWJ; Wed, 01 Sep 2021 21:58:12 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id F1FC63C07C; Wed,  1 Sep 2021 21:58:09 +0200 (CEST)
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH] fscache: re-match MODULE_PARM_DESC() calls to module parameters
Date:   Wed,  1 Sep 2021 21:57:59 +0200
Message-Id: <20210901195759.2166674-1-nicolas@fjasle.eu>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:rDCCjeLjAJM3z5VvVIexmAD/bY3AKKzjqSzuTrUTtirjUuMw1eC
 wwLNRcAtKKm7PqL6iqdIFFIiT7O+AeLSqfPbhrZBS0Ko9k/aYxeztZGZxxiBzVNctz6b88B
 VrxpIoDzGQUs106nftIu3h/TmWYMCtwBFEEV52+5szAi+pdcD1wT+7QUmuftM7tiXkCbLPr
 ynHb5pnVv+e/9PMAInveQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tXDixzSUFrk=:HfRr3slyXCLkUhXFDjNLEH
 Frdyh9BcrtfDG4xBvvSGMSXWBfAK+cDMOxGBO9RDpn2uHVykxSjgJl983n5cUrbf/YfoGovG3
 Dgl8JvQgMweTVqThPUfTob+6Omf2JshyXkn1tGXJ4srEuUc8NOghI33iDFJghxncW7bcik1rU
 kmEtnT52Vmkqmvs2GdO+5+XVLeLI4YYhA+gmRIpoocFhUkgIvJUVsRcPXOjFTr+cuINwlfZ4H
 UrgBNAyI4BXOjKq8M2LH+/lDUwHwfI4+l9eJhZK0wRHU2UBVG6hAsXf45akgndJaJi0/H5fjY
 brBNe8LDtJHmWDZdxU8QTCEjRvvyStA72LsAZd18GXsAQhSd2AwRAU7m0rBedRGQQ9TRfXHTP
 S8Ymah0Kgo1crxMhU5sRXCPnFwUZwm5w8p7O+/iVKNDIo1tkQU2cQ7L5e3gsPNCvxwo09mgjK
 vtqlKgQkKlnpNaYNIzfuGMwjlndMP0KgLD2xWQNQI2/AR84WWdvYc01IUVRJws0kER7CucSA1
 iImyO+oYNTOYksOsxfVm2iZPr/4+dKjS3Io4tEp6+FuAYDpZYzVtgGq1V4EUkya4la7iCx6IT
 gq7CCwkGtLatInwTXsTihw4fD75WkaIT/iyFVcEI5wQKa/bloiA6enNACD5sqnQmIEcCpC8d4
 AbZszZk7UlSQ3irG7dWRUflJY5jQvwit2iu9fEFp1FCZWQWjKfm2lApaqztDd2K6uUzqkRBRB
 /h26KMjHs5tBmj6MDVDaF77WDMkHCpj+mrULVg==
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

