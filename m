Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDECC42F6A0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 17:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240764AbhJOPK1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 15 Oct 2021 11:10:27 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:23477 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240676AbhJOPKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 11:10:18 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-71Xn5vDvOb-d7BmYsdFUgA-1; Fri, 15 Oct 2021 11:08:04 -0400
X-MC-Unique: 71Xn5vDvOb-d7BmYsdFUgA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00CCE80365C;
        Fri, 15 Oct 2021 15:08:03 +0000 (UTC)
Received: from x1.com (unknown [10.22.9.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 18CCE5D740;
        Fri, 15 Oct 2021 15:07:57 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] trace: osnoise and timerlat fixes
Date:   Fri, 15 Oct 2021 17:07:47 +0200
Message-Id: <cover.1634308385.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bristot@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

This is a series of minor fixes to the timerlat and osnoise tracers.

It includes a review of the timerlat tracer documentation, the addition of
the migrate disabled field to the timerlat and osnoise headers, and a
fix of a typo in the ifdef config comment in arch/x86/kernel/trace.c.

No functional changes.

Daniel Bristot de Oliveira (4):
  trace/osnoise: Fix an ifdef comment
  tracing/doc: Fix typos on the timerlat tracer documentation
  trace/osnoise: Add migrate-disabled field to the osnoise header
  trace/timerlat: Add migrate-disabled field to the timerlat header

 Documentation/trace/timerlat-tracer.rst | 24 ++++++++++++------------
 arch/x86/kernel/trace.c                 |  2 +-
 kernel/trace/trace_osnoise.c            | 25 +++++++++++++------------
 3 files changed, 26 insertions(+), 25 deletions(-)

-- 
2.31.1

