Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F0040D574
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235239AbhIPJC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:02:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:36204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235470AbhIPJBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:01:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E89A261356;
        Thu, 16 Sep 2021 09:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631782803;
        bh=ncTiBNiZvhwc0SUAMa/QDBZVzsHakSCDZjhxAyiWi0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lYblWoLBYr5hBt4KqXeHmZH4mscdzZZmxtifSSyBUbJq1NrE+aP+MRXOavbMmxDUG
         7m6DL/7BzitEfZJHRj8l01kBzHu9bHbZ/iPGJoE4KE/45QVBTwR2qfmwmfeI60gHyE
         +CbLVLN/3BZ4Z/LJthNO1SwWvQgny5ruZdVmxMbnU7eSF1QPN+Rt0OZdNcUL69YiJO
         Y75ld/LeABEJ1s3iiUlSJ15+EitfV9KZKfm+wL8Zz/1y8cgB5kvYCqjyTrYtdwY7X7
         WEebUNkEMeu5vMw7PgHxDAhRHygsizIWC1KR42Mu/A2fJOtSgTzs2RYmNX2MxT6Z0H
         45Qz1JDKMNHMw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQnFR-001qkm-5O; Thu, 16 Sep 2021 11:00:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, Peter Rosin <peda@axentia.se>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 19/30] ABI: sysfs-class-mux: use wildcards on What definitions
Date:   Thu, 16 Sep 2021 10:59:46 +0200
Message-Id: <7e8ff8601d5b44b76c5c7f77b6dcf3b1d45bc5be.1631782432.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631782432.git.mchehab+huawei@kernel.org>
References: <cover.1631782432.git.mchehab+huawei@kernel.org>
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

Acked-by: Peter Rosin <peda@axentia.se>
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

