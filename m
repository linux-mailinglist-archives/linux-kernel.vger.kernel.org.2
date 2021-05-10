Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821E537824C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 12:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbhEJKdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:33:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:60482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231422AbhEJKaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:30:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C452A6187E;
        Mon, 10 May 2021 10:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620642443;
        bh=jePJiKnUrenmcW2bcjH1VDz5dQntzoSjJz/YCuEOB5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sZb3fpeaIaz6xP2ffLsHONOIdChglXwMqn4Mp99CgdzlAoBoo87X0TYYGiFwrFPri
         yCKrxAEHLRF5exsbRhI10yNNcG9EUUpgKqWBQ1yWbmvTo8AwzWFqUwvEKXxAmGMqSl
         zHayVXjU0lHxnbr0nEUWPyovwzpC+3cum7Sb3cLzQ1rnlhchaiCSm2QUKJ3iq7rljT
         9n4Gyu+ngNtJSaeN/nkq+z+wR2I4P2NRGu1KCzwJoNGqNNubqr6CV//f67MHQoZqir
         3qGNEq3Zip+zOvn/HsgSuaYLig6H9MX7EjhHuryEguirFLExJKKQjUV+Qzt8nfmylP
         0cIuHmcadtEDw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lg38C-000UOR-Cu; Mon, 10 May 2021 12:27:20 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 02/53] docs: ABI: remove a meaningless UTF-8 character
Date:   Mon, 10 May 2021 12:26:14 +0200
Message-Id: <6cd3f0b47568fecb7889fd18d1d744c3aaf73866.1620641727.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620641727.git.mchehab+huawei@kernel.org>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those two files have this character:
	- U+00ac ('¬'): NOT SIGN

at the end of the first line, apparently for no reason. Drop them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/obsolete/sysfs-kernel-fadump_registered  | 2 +-
 Documentation/ABI/obsolete/sysfs-kernel-fadump_release_mem | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/obsolete/sysfs-kernel-fadump_registered b/Documentation/ABI/obsolete/sysfs-kernel-fadump_registered
index 0360be39c98e..dae880b1a5d5 100644
--- a/Documentation/ABI/obsolete/sysfs-kernel-fadump_registered
+++ b/Documentation/ABI/obsolete/sysfs-kernel-fadump_registered
@@ -1,4 +1,4 @@
-This ABI is renamed and moved to a new location /sys/kernel/fadump/registered.¬
+This ABI is renamed and moved to a new location /sys/kernel/fadump/registered.
 
 What:		/sys/kernel/fadump_registered
 Date:		Feb 2012
diff --git a/Documentation/ABI/obsolete/sysfs-kernel-fadump_release_mem b/Documentation/ABI/obsolete/sysfs-kernel-fadump_release_mem
index 6ce0b129ab12..ca2396edb5f1 100644
--- a/Documentation/ABI/obsolete/sysfs-kernel-fadump_release_mem
+++ b/Documentation/ABI/obsolete/sysfs-kernel-fadump_release_mem
@@ -1,4 +1,4 @@
-This ABI is renamed and moved to a new location /sys/kernel/fadump/release_mem.¬
+This ABI is renamed and moved to a new location /sys/kernel/fadump/release_mem.
 
 What:		/sys/kernel/fadump_release_mem
 Date:		Feb 2012
-- 
2.30.2

