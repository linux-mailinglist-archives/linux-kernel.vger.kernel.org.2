Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2628333BDCA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 15:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbhCOOik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 10:38:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233659AbhCOOCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 10:02:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14E0E64EF8;
        Mon, 15 Mar 2021 14:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615816926;
        bh=xcBrq3kDGzZjHnI73Sxcu29nEqrkieYemkYWm+6nhbI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1EfL+ll/5ahKNngzfsNVQRr744AnlqslgcGLwhiVtocz4tKzoPihCAa3wIElXJWlO
         IspjM95dHht7dVuwb0rKeg0OvIeuZMgWFlC5qpr85HJshyycMHkHKxEfecX9Ifkvfq
         KDjx/g116jJrSy+sPcH8RDmL9wFWgNp0yNWB58r4=
From:   gregkh@linuxfoundation.org
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.10 191/290] software node: Fix node registration
Date:   Mon, 15 Mar 2021 14:54:44 +0100
Message-Id: <20210315135548.372685734@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210315135541.921894249@linuxfoundation.org>
References: <20210315135541.921894249@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

commit 8891123f9cbb9c1ee531e5a87fa116f0af685c48 upstream.

Software node can not be registered before its parent.

Fixes: 80488a6b1d3c ("software node: Add support for static node descriptors")
Cc: 5.10+ <stable@vger.kernel.org> # 5.10+
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/swnode.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -786,6 +786,9 @@ int software_node_register(const struct
 	if (software_node_to_swnode(node))
 		return -EEXIST;
 
+	if (node->parent && !parent)
+		return -EINVAL;
+
 	return PTR_ERR_OR_ZERO(swnode_register(node, parent, 0));
 }
 EXPORT_SYMBOL_GPL(software_node_register);


