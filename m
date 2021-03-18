Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDFDE340E41
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 20:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbhCRTaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 15:30:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59824 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbhCRT3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 15:29:40 -0400
Message-Id: <20210318192646.868059483@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616095779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jnzTKz6TRa2nSDZ4cL2nXKRo/e9AGKRmelEE61NVE2Y=;
        b=4ijDLOkIh3pldMWQFNytYNdWuPASH5PA/0DPc3n1FVgiydMCTuG92EWyHigOG0yq9QTuam
        gKLT/Mq3Fr1fFKfNkV8hpBQqB2nvTTJZPYmncF4aESu7OFLcmArfVDyggw1/99uSDUfCT1
        FQW1i+rDNvqSu+jS6RS/SqP3cW2xErihQPGoQsFGhREnzrIoKdWKkEfhJGFixUrS4ZJijU
        gHqD83WbnIapTHjUZA2jmKVjba62U2JbHXZO7Db7O7fm4COuRJMGEnmql3Pi5akHQBibe/
        WJB6j+qLfDJS6dJLYW46919VAmOKhDsu6EYWggqNxfSioPt/fMF9/a0JCjaHgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616095779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jnzTKz6TRa2nSDZ4cL2nXKRo/e9AGKRmelEE61NVE2Y=;
        b=QdS1VIGMaZeP3BYL8mbdrCc1ridoAcZsihIovpgrmHj2Q19v0ZaMKzbOvnsq8bWff0NsUV
        uJ1qLciUleDIBGDg==
Date:   Thu, 18 Mar 2021 20:26:46 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [patch 0/2] x86/ioapic: Restore the ignore IRQ2 routing entry logic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q3VyZSBmb3IgdGhlIElSUTIgaWdub3JlIGxvZ2ljIHdoaWNoIGdvdCBsb3N0IGR1cmluZyB0aGUg
aXJxZG9tYWluCmNvbnZlcnNpb24gYW5kIGEgcmVsYXRlZCBzYW5pdHkgY2hlY2suCgpUaGFua3Ms
CgoJdGdseAoKCg==
