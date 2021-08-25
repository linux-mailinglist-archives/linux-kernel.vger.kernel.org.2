Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FA03F735A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239888AbhHYKeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237180AbhHYKeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:34:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B14EC061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 03:33:15 -0700 (PDT)
Message-ID: <20210825101857.420032248@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629887591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=YkpXqDU83Msa/uxVAAE3N5oeaHHSDQRBIHShC05HRzM=;
        b=tv8Qq2Q399nFaIOBHHvEcg/UmIidm1eS8KfqMtRMdFLBY1BfSuyAaksdgWWhaB91fAg+Fg
        ZhKFJj4pVaEbj9xP0UlpV59M7GYtEIfmPg2pO9v2uTbtNOhKacPYD7RjwP9boo3yUiuWor
        8lHN8ZBbESEkTr8OWmjhfp1vmMFKMONjSgi/iGL50rVhQcZP5DdZP4syiWwbArwOS5kvdI
        vQBRvBIbyPOeOJmqERI4IxQBlSzkswMTZ46Hs9dJDDbwyynPgcKyGc/eFGf3JpgOyYrmgf
        gF/Tf+/Ew3hgfYDTua0Z+AQU/icCx+OiMl3lklG5L2v3K98m/vUqnCk8MY2JmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629887591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=YkpXqDU83Msa/uxVAAE3N5oeaHHSDQRBIHShC05HRzM=;
        b=7NMKwUvdLpwWNTRheN/+04f/Dio3vA8x0u3mi+BcWuD0dtBZBOep9Wr7LBR13/UfVNRf5a
        N451qlcHzSmq2xDg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [patch 0/2] locking/rtmutex: Cure two subtle bugs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Wed, 25 Aug 2021 12:33:11 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIHJlY2VudCB1cGRhdGVzIHRvIHJ0bXV0ZXggaW50cm9kdWNlZCB0d28gc3VidGxlIGJ1Z3M6
CgogIDEpIFRoZSBzcGlud2FpdCBtZWNoYW5pc20gYWRkZWQgYSBVQUYgd2hpY2ggdHJpZ2dlcnMg
YSBCVUdfT04oKQoKICAyKSBUaGUgd3dfbXV0ZXggYWRkaXRpb24gbGVhdmVzIGEgd2FpdGVyIHF1
ZXVlZCBpbiB0aGUgZXJyb3IgZXhpdCBwYXRoCiAgICAgcmVzdWx0aW5nIGluIHJiIHRyZWUgY29y
cnVwdGlvbgoKVGhlIGZpeGVzIGFyZSBzdHJhaWdodCBmb3J3YXJkLCBidXQgdGhlIHJ0bXV0ZXgg
YmFzZWQgd3dfbXV0ZXgKaW1wbGVtZW50YXRpb24gc3RpbGwgaGFzIHNvbWUgbW9yZSByb3VnaCBl
Z2RlcyB3aGljaCBuZWVkIHRvIGJlIGlyb25lZCBvdXQuCgpUaGFua3MsCgoJdGdseAotLS0KIHJ0
bXV0ZXguYyAgICAgICAgfCAgIDEyICsrKysrKysrKy0tLQogcnRtdXRleF9jb21tb24uaCB8ICAg
MTMgKysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQo=
