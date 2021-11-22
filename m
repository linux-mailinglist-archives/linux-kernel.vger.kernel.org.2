Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830224593C5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 18:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240225AbhKVRR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 12:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239983AbhKVRRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 12:17:22 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3C5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 09:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=xE7VZKOoFqaqqv3dHzDb2qtJps42NbPnCo4LDvVB574=; b=hDgaL+ebKd+sFdooXJtICVNeY0
        he0XZBqgK15EACDb76IVn1jIqbxq9Zs6V5EaOP6MF7KUiNm70TMv3W0wlvqMznOEMT+W7OPRCGXzn
        VCLh1RT128gF1mYZ4Z12QXmFVQJV59hqwxBOEII0JjRFl5SxKRhu+0pZc2qk1iXOKEBkZi9JzTbeq
        jdurhqbQwESqF4Hwii7HeXFcXTuHMLfaCWQ5UhjeO7ViRLp5VFyAEO8G+IvXtY3UFsiancb5jPUB6
        duofegcJwbP9FVDMMy1rErx6AakYXTqOMvUGF7PP0NgsO8vrOtyiji6sTqvSnYfndfr2P4LWC5wCn
        QYcajaTA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpCtF-00HWQL-ST; Mon, 22 Nov 2021 17:14:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 001D0300129;
        Mon, 22 Nov 2021 18:13:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E47DC2B8B7A82; Mon, 22 Nov 2021 18:13:58 +0100 (CET)
Message-ID: <20211122170301.764232470@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 22 Nov 2021 18:03:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com
Subject: [RFC][PATCH 0/6] x86: Kernel IBT beginnings
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

So I hacked this up on Friday night / Saturday morning and spend all of today
cleaning it up.

It is the very bare beginnings of kernel IBT support. Since I'm lacking any
sort of actual hardware it even lacks fun things like code to write to the MSRs
to enable the IBT tracker etc..

However, it should have most of the ENDBR instructions in the right place -- I
hope :-) That said; I would *really* like compiler support for this stuff to be
improved, the amount of fixups done by objtool is obscene.

The end result still boots on ancient x86-64 hardware, for whatever that's
worth (when built with the below turd included that is).

Enjoy!

---

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 5cdd9bc5c385..1d180bbe7b28 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -142,6 +142,11 @@ objtool_link()
 		info OBJTOOL ${1}
 		tools/objtool/objtool ${objtoolcmd} ${objtoolopt} ${1}
 	fi
+
+	if [ "${CONFIG_X86_IBT}" = "y" ]; then
+		# XXX less ugleh
+		tools/objtool/objtool check --no-fp --retpoline --uaccess --vmlinux --duplicate --ibt --ibt-fix-direct --ibt-seal ${1}
+	fi
 }
 
 # Link of vmlinux

