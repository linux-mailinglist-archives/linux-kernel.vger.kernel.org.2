Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92AB40D565
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbhIPJBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:01:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:36204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235398AbhIPJBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:01:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CF1161263;
        Thu, 16 Sep 2021 09:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631782802;
        bh=/kqJLSvbuqjIZcymwD8v27dJaGZvLklGBpG5D51n1lE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MLyVVgs1D/BCsy1mAarh85I47SLChbwU/p9W9bz5c3h5MWe5xuE1sJDU/U+bYX8jq
         C2BTQucezMkbL3Wc9aBkz/an/06X7wSbqVhmPFqCkowKNEOHgBNJZsQrlx0vLNbGM9
         /rDoaOuTK9RE0/9LNX8Oti+UWaDE65ZYOHDSfVHNXEZjm4xUXau/rVhWTSXYThlFG0
         42ZnUyt6PhUBh2WIbuE1nurYAhGDpjsCs2m9N/S+VOfbQKnc903sahCAxSab7u1pCq
         0dogN3rbOLWwHBpfmEGYPSOfnYdZQgm4SEpX8nabyO5pnaaU0SGLgQK+mgE0vUbHnO
         ko/G0Gk2T9s6A==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQnFQ-001qkF-P7; Thu, 16 Sep 2021 11:00:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v3 11/30] ABI: sysfs-class-typec: fix a typo on a What field
Date:   Thu, 16 Sep 2021 10:59:38 +0200
Message-Id: <bff0e7c137fb4f41ac0b2ed9c5a21c0948203f15.1631782432.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631782432.git.mchehab+huawei@kernel.org>
References: <cover.1631782432.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This what:
	/sys/class/typec/<port>-partner>/identity/

Contains an extra ">" character. Remove it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/testing/sysfs-class-typec | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
index 40122d915ae1..75088ecad202 100644
--- a/Documentation/ABI/testing/sysfs-class-typec
+++ b/Documentation/ABI/testing/sysfs-class-typec
@@ -200,7 +200,7 @@ Description:	USB Power Delivery Specification defines a set of product types
 		amc			Alternate Mode Controller
 		======================  ==========================
 
-What:		/sys/class/typec/<port>-partner>/identity/
+What:		/sys/class/typec/<port>-partner/identity/
 Date:		April 2017
 Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
 Description:
-- 
2.31.1

