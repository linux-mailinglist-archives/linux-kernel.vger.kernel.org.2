Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC58F31A014
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 14:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbhBLNw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 08:52:59 -0500
Received: from esa8.hc324-48.eu.iphmx.com ([207.54.65.242]:30743 "EHLO
        esa8.hc324-48.eu.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231330AbhBLNw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 08:52:57 -0500
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Feb 2021 08:52:56 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1613137976; x=1644673976;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=J+akSlpo0DdfFqm/q8TZ4Fyg9LyVL5Nsn3YPQ1SmhsU=;
  b=Jnan0D7gI6f5IG8bYVLEFeUsXWs99dL/kjEDpz68JClQK1FsJ9vMb7u1
   OlYR/5g4oFh+/KVVyW52rZnOORqu0hVHA+svYT4T3Q2ZrImuuzillq/N+
   wC3g1O2B4Yb+gjXBjZAEq4p3elCaCPWcOM5oNTY43jfy3Yvl19uYXHArb
   M=;
Received: from esagw3.bmwgroup.com (HELO esagw3.muc) ([160.46.252.35]) by
 esa8.hc324-48.eu.iphmx.com with ESMTP/TLS; 12 Feb 2021 14:44:31 +0100
Received: from esabb2.muc ([160.50.100.34])  by esagw3.muc with ESMTP/TLS;
 12 Feb 2021 14:44:31 +0100
Received: from smucm10m.bmwgroup.net (HELO smucm10m.europe.bmw.corp) ([160.48.96.49])
 by esabb2.muc with ESMTP/TLS; 12 Feb 2021 14:44:31 +0100
Received: from greenhouse.bmw-carit.intra (192.168.221.37) by smucm10m.europe.bmw.corp
 (160.48.96.49) with Microsoft SMTP Server (TLS;
 Fri, 12 Feb 2021 14:44:30 +0100
From:   Viktor Rosendahl <Viktor.Rosendahl@bmw.de>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <Viktor.Rosendahl@bmw.de>
Subject: [PATCH v12 0/1] Add the latency-collector to tools
Date:   Fri, 12 Feb 2021 14:44:20 +0100
Message-ID: <20210212134421.172750-1-Viktor.Rosendahl@bmw.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SMUCM29L.europe.bmw.corp (160.46.167.43) To
 smucm10m.europe.bmw.corp (160.48.96.49)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v11
 * I added a .gitignore in the tools/tracing/latency directory.

Changes since v10
 * Using libtracefs to control ftrace and find /sys/kernel/tracing
 * New options to list available tracers, select the tracer and other
   ftrace parameters
 * A signal handler to restore the ftrace state when the program terminates
 * Cleaned up the commit message a bit, removed example output etc.



Viktor Rosendahl (1):
  Add the latency-collector to tools

 tools/Makefile                            |   14 +-
 tools/tracing/Makefile                    |   19 +
 tools/tracing/latency/.gitignore          |    2 +
 tools/tracing/latency/Makefile            |   24 +
 tools/tracing/latency/latency-collector.c | 2108 +++++++++++++++++++++
 5 files changed, 2161 insertions(+), 6 deletions(-)
 create mode 100644 tools/tracing/Makefile
 create mode 100644 tools/tracing/latency/.gitignore
 create mode 100644 tools/tracing/latency/Makefile
 create mode 100644 tools/tracing/latency/latency-collector.c

-- 
2.25.1

