Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9CA31E16E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 22:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbhBQVc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 16:32:58 -0500
Received: from mail.efficios.com ([167.114.26.124]:47986 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbhBQVb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 16:31:58 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 54AA63248C4;
        Wed, 17 Feb 2021 16:31:16 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id jDVzzbGFUpv3; Wed, 17 Feb 2021 16:31:16 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 17A82324A9D;
        Wed, 17 Feb 2021 16:31:16 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 17A82324A9D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1613597476;
        bh=mJpONF+ppVXjDyfJehbKJcFUvKUnYB/SI7ginxxJvX8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ZbcI3CuqyPiWuPbIUw0uCoHSO0RGiIY6d223PfPyH7TpJqI+p43KTXs+E3TmgVkPA
         f/AAC8eY0ljO3kt6bUQdvP7BKTEg1Xy8ZsoSDmMn1g3/SxXFP4cRLItaYyiBK6ZkL2
         hXA6mUbHF7w8gPT67Yjf3MPKVZGw2Rd0N5Y1tLYMz0FTuZk3AHllYm9P4DtdmNwcIC
         2apQmZnXKS55mLFo2mKv3WrHko1EHlcL+SdgcMuZJOT/SMXiACy1lBcpqUHz+sE47p
         SiEaMh55DaKrinAIbHnGqEWPyJAamH8Xo0i+nPZX7AYAm8fZbO1DQfOWsuni//39SY
         rMudcPD+lOORg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SVC0oEEzfjxs; Wed, 17 Feb 2021 16:31:16 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 08276324B30;
        Wed, 17 Feb 2021 16:31:16 -0500 (EST)
Date:   Wed, 17 Feb 2021 16:31:15 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     lttng-dev@lists.lttng.org,
        diamon-discuss@lists.linuxfoundation.org,
        linux-trace-users@vger.kernel.org, lwn@lwn.net,
        linux-kernel@vger.kernel.org
Message-ID: <2047339870.25949.1613597475930.JavaMail.zimbra@efficios.com>
Subject: [RELEASE] LTTng-modules 2.11.8 and 2.12.5 (Linux kernel tracer)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF85 (Linux)/8.8.15_GA_3996)
Thread-Index: ddylPrE4mnqbB+Gwtqxi1jBzmDJ0lA==
Thread-Topic: LTTng-modules 2.11.8 and 2.12.5 (Linux kernel tracer)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a release announcement for the 2.11.8 and 2.12.5 releases of the
LTTng kernel tracer.

New and noteworthy in these releases:

* Support for Linux kernel 5.11,
* Deal with stable kernel version overflow (sublevel >= 256),
* Prepare for Ubuntu, SLES, RHEL, and RT release version overflows (which should come sooner
  or later),
* Writeback instrumentation: fix out-of-bound read of block device name beyond terminating
  '\0' character,
* Writeback instrumentation: fix a crash in wb_workfn when a device disappears when memcg
  is in use,
* aarch64: blacklist gcc compiler prior to version 5.1, because they perform unsafe access
  to deallocated stack.

Thanks,

Mathieu

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
