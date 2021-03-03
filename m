Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB68C32BDC1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbhCCQau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 11:30:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43448 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355587AbhCCLzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 06:55:41 -0500
Message-Id: <20210303114511.927078317@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614772457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=SMmXc8oGX4HFR1KV48AJv4bf9czvvz5dk+o1LhH8yuI=;
        b=wiRXIrB+TV127+1s7pwJlIkwgFBagQsFu+PRM8tjnUDw2QpsMwse1bkqRx7jnR9kUTf2e1
        JwDQs2Lxkp1vjkEJ+6WWsZ4uG606TwUYjVwtjC4dhr5oAOT8LDsWduEmc75ETNHFzXXiO7
        7emUviIdpeb0gYHCqOmfXmnZdd4B7rGv+PptdMScyrwRDsxHQggRs5ek0ePvvQ1FrkjCI/
        a/gOaWgaoRhcWswM3S4n2gqsNvuj/E+g8izB6xXx9pGSAseejNGh4ggT5hVKNVAkSQmZPI
        s1alMrge2ZfBTBKNb7QrzeuVf6jUEkK2laHhMM+4OQset2aappCbUxMLPbXPEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614772457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=SMmXc8oGX4HFR1KV48AJv4bf9czvvz5dk+o1LhH8yuI=;
        b=za6dPs1AgAeEmI8GfeI75Qpe8gw5mzvfb7bFBKLt1xQNxG5yB/r4pa8a/Ol8w+wD//aBoK
        kZADcFtCsgp2+SDw==
Date:   Wed, 03 Mar 2021 12:45:11 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Subject: [patch 0/2] highmem/ARM: kmap_atomic cleanups
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGxhc3QgdXNlcnMgb2Yga21hcF9hdG9taWNfcGZuKCkgYXJlIGluIGFyY2gvYXJtIGFuZCBu
b25lIG9mIHRoZW0KcmVxdWlyZXMgdGhlIGttYXBfYXRvbWljIHNlbWFudGljcy4gUmVwbGFjZSB0
aGVtIHdpdGgga21hcF9sb2NhbF9wZm4oKSBhbmQKcmVtb3ZlIGttYXBfYXRvbWljX3BmbigpLgoK
VGhhbmtzLAoKCXRnbHgK
