Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C2940B0F2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbhINOgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:36:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:57474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233831AbhINOeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:34:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9927761151;
        Tue, 14 Sep 2021 14:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631629970;
        bh=12noMMOjbT9qU8R4s1OT5UR157DRXTbaB8hZL999iBE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kxlk5khQWo/WwROtPW5NavugwrXrH9TcYc+D3uLZIQU2DIAYIBVVYHnqf2JaahZli
         ABeGyIqxWB1F4ayuop7LRnY/Jw9CYY1EcWN0404Ht1pYv2KHpFdbzDQo5K0IZt79Yr
         J6DhtJmiRL4LK3I9iCXVxO0oael6tadHH3VXWh9RjZjgJDVkbZig/TsAQvXk9Tpz6y
         57ZZqItg5FddSr1XP42Nju+dIPVEBzCWWOZpO6kK8qWaJeoYaTqo9cuPMi/RB9SnIB
         WbJ4cy79Ke5iYqjv59xIR5phSvALNDSGSr+bojID2QOc6Fd5AB6EmaT7YApeF9Oozi
         a51YTO3cYPc8g==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQ9UO-000KlQ-6j; Tue, 14 Sep 2021 16:32:48 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, Peter Rosin <peda@axentia.se>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 19/29] ABI: sysfs-class-mux: use wildcards on What definitions
Date:   Tue, 14 Sep 2021 16:32:34 +0200
Message-Id: <2949241c7c5ad171cf6f4d115e4da7bd7915b024.1631629496.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631629496.git.mchehab+huawei@kernel.org>
References: <cover.1631629496.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An "N" upper letter is not a wildcard, nor can easily be identified
by script, specially since the USB sysfs define things like.
bNumInterfaces. Use, instead, <N>, in order to let script/get_abi.pl
to convert it into a Regex.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/testing/sysfs-class-mux | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-mux b/Documentation/ABI/testing/sysfs-class-mux
index 8715f9c7bd4f..c58b7b6e1aa6 100644
--- a/Documentation/ABI/testing/sysfs-class-mux
+++ b/Documentation/ABI/testing/sysfs-class-mux
@@ -7,7 +7,7 @@ Description:
 		Framework and provides a sysfs interface for using MUX
 		controllers.
 
-What:		/sys/class/mux/muxchipN/
+What:		/sys/class/mux/muxchip<N>/
 Date:		April 2017
 KernelVersion:	4.13
 Contact:	Peter Rosin <peda@axentia.se>
-- 
2.31.1

