Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36EC73FEB93
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 11:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343681AbhIBJuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 05:50:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42658 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245600AbhIBJtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 05:49:49 -0400
Message-ID: <20210902093755.087908334@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630576128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=mwn8Pcxfah6XbA2Ih4rwQ9OV8ysXQiiJYA3NbgdXSbY=;
        b=jDvVBHo3YjBTluic8UA/BRzNtV4sIF4+6as6rVZc8XJ6WAF3w2KX8pPHtaGlsclQhAqzaV
        +DYJ2jaOgTMdzmhWps7hN074RXrpMe6OPjsKdtgThNC7CrTOPrb+xL1o65iCvlvMHXajap
        0e+wxl1Q+tdQZ3joM6wNlUxRiddtf6BEynqbTaliwoaBjS8weAwdCAh6u6HeOoCf8WVAcP
        UoUY1OhKoiCj24AvYSp7cVoHylMecdnsyx2QT6NP4n5bUTsrv2hKuGPBwpS14SCMcghxER
        RwoEkJxkxHOrqYFODlAYFlkys31AfMmkULwFGEEXMDCQd+VqyzG0kqYr/eYpzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630576128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=mwn8Pcxfah6XbA2Ih4rwQ9OV8ysXQiiJYA3NbgdXSbY=;
        b=osf4NeJp1TwMwF1rcxrNmk+8VBdBrhVKTrGtBtfTZtfaVfpr6lAqZiyqNN42iv7nadSj4Y
        v4ufl/VXZBcUFODQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Darren Hart <dvhart@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch 0/3] futex: Prevent inconsistent state and exit race
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Thu,  2 Sep 2021 11:48:47 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIHJlY2VudCByZXF1ZXVlIFBJIGNoYW5nZXMgaW50cm9kdWNlZCBhIGNvbmRpdGlvbiB3aGVy
ZSBhIHdhaXRlciBjYW4KZXNjYXBlIHRvIHVzZXIgc3BhY2Ugd2l0aCBpbmNvbnNpc3RlbnQgc3Rh
dGUgYW5kIGluIHRoZSB3b3JzdCBjYXNlIGV4aXQKYmVmb3JlIHN0YXRlIGhhcyBiZWVuIG1hZGUg
Y29ycmVjdC4KClRoZSBmb2xsb3dpbmcgc2VyaWVzIGFkZHJlc3NlcyB0aGlzLgoKQXBwbGllcyBv
biB0b3Agb2YKCiAgIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dp
dC90aXAvdGlwLmdpdCBsb2NraW5nL3VyZ2VudAoKVGhhbmtzLAoKCXRnbHgKLS0tCiBmdXRleC5j
IHwgIDE4NSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTA5IGluc2VydGlvbnMoKyksIDc2IGRl
bGV0aW9ucygtKQo=
