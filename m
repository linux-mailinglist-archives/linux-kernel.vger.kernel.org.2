Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B093195C0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 23:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhBKWWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 17:22:19 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49048 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhBKWWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 17:22:03 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 31F501F4604A
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     dhowells@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 0/2] tiny fixes to watch_queue
Date:   Thu, 11 Feb 2021 17:21:10 -0500
Message-Id: <20210211222112.1518161-1-krisman@collabora.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

You'll find here a couple of misc improvements to watch_queue
documentation and code.

Gabriel Krisman Bertazi (2):
  watch_queue: Fold info_id initialization into init_watch
  docs: watch_queue: Fix unit of the notification size field

 Documentation/watch_queue.rst | 7 ++++---
 include/linux/watch_queue.h   | 2 +-
 kernel/watch_queue.c          | 5 ++++-
 security/keys/keyctl.c        | 3 +--
 4 files changed, 10 insertions(+), 7 deletions(-)

-- 
2.30.0

