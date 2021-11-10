Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92DBC44C0AA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbhKJMFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:05:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:51858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231670AbhKJMFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:05:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8C596115A;
        Wed, 10 Nov 2021 12:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636545742;
        bh=7MgLyEqQs0tsTjzVsvVzeXDQT4IirjoXUmST78bHbTA=;
        h=From:To:Cc:Subject:Date:From;
        b=B/GepwNww4Qm4HiRT8hda+8Fh7FbxwlruM6NufVWoZ8ONVpBJmiT0k36DDd4refYr
         01cjA149P8jumHXpbIpYKfZQqLAiWFOA6S/fOg6l83GhGpAM70NYzcq/OiZN8PWJkZ
         RBUkYTpV6qRqMa1fBWdHh6+3zKbh9w9a1+3EkWj9q8KAHsV+TQnw/i5UwjFk2yFjVU
         N2gvG4OFqK6xb6iJqiDJVPKNLmEws70eE/Ny8sSsNAuUXeToT2OJQHLo+jcaSQ40v5
         FYTCKAk78lsI+wYq36lULZqcbQVW6NpMG+Bxq7Z707kIwtu4ZqGMznKDSpX4vfgPn0
         iwdNnHqsRMQAg==
From:   alexs@kernel.org
Cc:     Alex Shi <alexs@kernel.org>, Xinyong Wang <wang.xy.chn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] doc/zh_CN: fix a translation error in management-style
Date:   Wed, 10 Nov 2021 20:02:13 +0800
Message-Id: <20211110120213.134313-1-alexs@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Shi <alexs@kernel.org>

'The name of the game' means the most important part of an activity, so
we should translate it by the meaning instead of the words.

Suggested-by: Xinyong Wang <wang.xy.chn@gmail.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net> 
Cc: linux-doc@vger.kernel.org 
Cc: linux-kernel@vger.kernel.org 
---
 Documentation/translations/zh_CN/process/management-style.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/translations/zh_CN/process/management-style.rst b/Documentation/translations/zh_CN/process/management-style.rst
index c6a5bb285797..8053ae474328 100644
--- a/Documentation/translations/zh_CN/process/management-style.rst
+++ b/Documentation/translations/zh_CN/process/management-style.rst
@@ -36,14 +36,14 @@ Linux内核管理风格
 每个人都认为管理者做决定，而且决策很重要。决定越大越痛苦，管理者就必须越高级。
 这很明显，但事实并非如此。
 
-游戏的名字是 **避免** 做出决定。尤其是，如果有人告诉你“选择（a）或（b），
+最重要的是 **避免** 做出决定。尤其是，如果有人告诉你“选择（a）或（b），
 我们真的需要你来做决定”，你就是陷入麻烦的管理者。你管理的人比你更了解细节，
 所以如果他们来找你做技术决策，你完蛋了。你显然没有能力为他们做这个决定。
 
 （推论：如果你管理的人不比你更了解细节，你也会被搞砸，尽管原因完全不同。
 也就是说，你的工作是错的，他们应该管理你的才智）
 
-所以游戏的名字是 **避免** 做出决定，至少是那些大而痛苦的决定。做一些小的
+所以最重要的是 **避免** 做出决定，至少是那些大而痛苦的决定。做一些小的
 和非结果性的决定是很好的，并且使您看起来好像知道自己在做什么，所以内核管理者
 需要做的是将那些大的和痛苦的决定变成那些没有人真正关心的小事情。
 
-- 
2.27.0

