Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09EA235FEC0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 02:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhDOAM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 20:12:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229889AbhDOAMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 20:12:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A158A611CC;
        Thu, 15 Apr 2021 00:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618445523;
        bh=AFaP1cECYuCNfUUhp3uFLuG+0Mh8ODMJZ3NF7lAq+EE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z8Ml/OhKGvvEDqO+NfsqI0H29VTDSaMbHOAy/K8+ZSdhyKDgvwsfJA4NFPppkjXn7
         3NskXSK8/mxdGEbNuJyMWZCvIwNyIGmXjhLPM8lHWqjQEBOnToPCDc4+pmLhYLIIJz
         sO6fozEF4MfHVjiHw5nxkg1/mAWSbFmjf/C7i+PuT5p7S5wvb0Wn7CtVpbBC5IwQaK
         0nFgv4+FsIxIAvJy5lFjTXlkcudzKWfmK6ZkPvPHcC0gvKMcFHCQgMeVpHSbCESHAa
         QWKghN2BuLcfbx5PVv19uqpVX911exlXGh2WjA3QcDqa9ZE1GJqfbYGi/qA3GwDY14
         Tr4IVDqMYpHhQ==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 2/2] perf/amd/uncore: Fix sysfs type mismatch
Date:   Wed, 14 Apr 2021 17:11:12 -0700
Message-Id: <20210415001112.3024673-2-nathan@kernel.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a5
In-Reply-To: <20210415001112.3024673-1-nathan@kernel.org>
References: <20210415001112.3024673-1-nathan@kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_attr_show() calls the __uncore_*_show() functions via an indirect
call but their type does not currently match the type of the show()
member in 'struct device_attribute', resulting in a Control Flow
Integrity violation.

$ cat /sys/devices/amd_l3/format/umask
config:8-15

$ dmesg | grep "CFI failure"
[ 1258.174653] CFI failure (target: __uncore_umask_show...):

Update the type in the DEFINE_UNCORE_FORMAT_ATTR macro to match
'struct device_attribute' so that there is no more CFI violation.

Link: https://github.com/ClangBuiltLinux/linux/issues/1350
Fixes: 06f2c24584f3 ("perf/amd/uncore: Prepare to scale for more attributes that vary per family")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/x86/events/amd/uncore.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 7f014d450bc2..582c0ffb5e98 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -275,14 +275,14 @@ static struct attribute_group amd_uncore_attr_group = {
 };
 
 #define DEFINE_UNCORE_FORMAT_ATTR(_var, _name, _format)			\
-static ssize_t __uncore_##_var##_show(struct kobject *kobj,		\
-				struct kobj_attribute *attr,		\
+static ssize_t __uncore_##_var##_show(struct device *dev,		\
+				struct device_attribute *attr,		\
 				char *page)				\
 {									\
 	BUILD_BUG_ON(sizeof(_format) >= PAGE_SIZE);			\
 	return sprintf(page, _format "\n");				\
 }									\
-static struct kobj_attribute format_attr_##_var =			\
+static struct device_attribute format_attr_##_var =			\
 	__ATTR(_name, 0444, __uncore_##_var##_show, NULL)
 
 DEFINE_UNCORE_FORMAT_ATTR(event12,	event,		"config:0-7,32-35");
-- 
2.31.1.272.g89b43f80a5

