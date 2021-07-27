Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFE03D794F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 17:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbhG0PGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 11:06:22 -0400
Received: from mail.efficios.com ([167.114.26.124]:36086 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbhG0PGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 11:06:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B73133502D2;
        Tue, 27 Jul 2021 11:06:20 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id whENm3jvRaBu; Tue, 27 Jul 2021 11:06:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id F1690350511;
        Tue, 27 Jul 2021 11:06:19 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com F1690350511
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1627398380;
        bh=Lz6Hpv4foaj4KQ0Olzz8ooNau8kUo8pmCGLVypEbW74=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=FH2wYV24F/N/C4IdwYDB3NrNd5P5YhFIzg1SOAHZ9TKbfv1cftNTaZR1Y6eAAknjW
         woj7MDVwHBIyy/aH0L+sJv8vp5LhIxlVno6URuzr5RttOQM8nkUgKWomXjrJXKRGkf
         NrPT0n9YG/U6CN89GPSWjG265MQtzQW1KNCLLZBBpfpUVF6E0fYwETpb04vn1YjsbA
         wq1MmbVV8CvhxuDa0rDm3zSCwoc8r44cemMKMOCNWgvBYQjmNHfGu0X5IZJDMs9DUr
         n8gqvcXS1M6J3Ccz5uW0k+UKz+nw8F5AHWJVZd4/hw/hsAVL5CXs4ECBHo+sEIbeUw
         UXvAOwFK56Ukw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EpEzu3AW7yNU; Tue, 27 Jul 2021 11:06:19 -0400 (EDT)
Received: from thinkos.etherlink (192-222-188-69.qc.cable.ebox.net [192.222.188.69])
        by mail.efficios.com (Postfix) with ESMTPSA id ABB1E35021D;
        Tue, 27 Jul 2021 11:06:19 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stefan Metzmacher <metze@samba.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH 0/3] tracepoint static call fixes
Date:   Tue, 27 Jul 2021 11:06:10 -0400
Message-Id: <20210727150613.20886-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is an RFC series (compiled-tested only) attempting to fix issues
that arise with back-to-back static call updates.

Feedback is welcome,

Thanks,

Mathieu


Mathieu Desnoyers (3):
  Fix: tracepoint: static call: compare data on transition from 2->1
    callees
  Fix: tracepoint: static call function vs data state mismatch
  Fix: tracepoint: rcu get state and cond sync for static call updates

 kernel/tracepoint.c | 165 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 145 insertions(+), 20 deletions(-)

--=20
2.20.1

