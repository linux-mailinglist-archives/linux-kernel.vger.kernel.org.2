Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCDD398CD0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 16:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhFBOe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 10:34:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:57146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230072AbhFBOez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 10:34:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 92CF4613BA;
        Wed,  2 Jun 2021 14:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622644392;
        bh=s/wgIaVQR6lDrLW+qk98jfRJCvEVrPpqAZJQ/3YepTE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lTgtmJarvMZZybwLukK6PkwBeTne57J7M3C/bNoUX6yUc4ZKI4an1IfPVNeumgHfa
         7rMYD3UQKVg1seGl9/JEHWg5WgF9iV/CdpptXqb+kVGHWVNJutlV7yO7CaWuliH1K5
         Zo9/w5xnDLUi1av2bW/LDvUkzYj2NJl5sOpdjeYF3G/aw/4X7deuMNPStW+6LA/68g
         JX4xBjIvZcHnC/dpJJi+QFdpmsUOl34yK1iOiC9XHDlD/hrcJByJCMZjeFjbsTRjj0
         b0ooYMOhxUjz08eMSLtRacGyJoKTaGypG9oNm3IcfPhhCxp2HKvpUKr1hLJiCpFAhF
         cRmywPXrtpidA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Documentation: tracing: Add per-group/all events enablement desciption
Date:   Wed,  2 Jun 2021 23:33:09 +0900
Message-Id: <162264438901.302580.10697703336929432947.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162264438005.302580.12019174481201855444.stgit@devnote2>
References: <162264438005.302580.12019174481201855444.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ftrace.event.<GROUP>.enable and ftrace.event.enable bootconfig
description in the boot-time tracing document.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Documentation/trace/boottime-trace.rst |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/trace/boottime-trace.rst b/Documentation/trace/boottime-trace.rst
index 89b64334929b..8053898cfeb4 100644
--- a/Documentation/trace/boottime-trace.rst
+++ b/Documentation/trace/boottime-trace.rst
@@ -99,6 +99,12 @@ These options are setting per-event options.
 ftrace.[instance.INSTANCE.]event.GROUP.EVENT.enable
    Enable GROUP:EVENT tracing.
 
+ftrace.[instance.INSTANCE.]event.GROUP.enable
+   Enable all event tracing within GROUP.
+
+ftrace.[instance.INSTANCE.]event.enable
+   Enable all event tracing.
+
 ftrace.[instance.INSTANCE.]event.GROUP.EVENT.filter = FILTER
    Set FILTER rule to the GROUP:EVENT.
 

