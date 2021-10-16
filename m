Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23424304E2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 22:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244588AbhJPUSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 16:18:34 -0400
Received: from wrqvxttq.outbound-mail.sendgrid.net ([149.72.167.116]:45078
        "EHLO wrqvxttq.outbound-mail.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232786AbhJPUSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 16:18:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wasin.io;
        h=from:subject:mime-version:to:cc:content-transfer-encoding:
        content-type;
        s=s1; bh=qNBGXlLMnPhrJq5G4++xZYyQ0CDuclAGDf2//H9A8Jw=;
        b=vOZiUPFv7s4UU2Qqs6qcRIpvwIdKNsdpEOPZ31ACdliidt7aC+7cDa5sV63kHcf/6Bp1
        ePrcVJieJsrBjuo7PVyFVCwUpTsrPy6r8y1pQHGfKsWchBW30Pcu703hIa7nGaCrLbprCn
        VeTLlpOrWdRq1mkVCWZmL+or4h6+lY84ZTD+cyBJhqfs1BEm/w5mL8mePvVGovIqhMLtwg
        zCM4nubETAMubzioeHWqP3q8J0xDrmqTZkHVVdd+QQrgfCOv7m8lSKgqp1p7ybvgU2aGBX
        3gichD9Ff1Ol8C/T1kkkAOkvjDx3XQY7IHfZ7k4NUaSCvhlgvOW+dAFkprgEyT5w==
Received: by filterdrecv-7bc86b958d-j46hl with SMTP id filterdrecv-7bc86b958d-j46hl-1-616B32BC-29
        2021-10-16 20:14:53.090010418 +0000 UTC m=+3880496.559941341
Received: from mail.wasin.io (unknown)
        by geopod-ismtpd-2-0 (SG) with ESMTP
        id 67mL071zQ-ioAAmFTANDFg
        for <linux-kernel@vger.kernel.org>;
        Sat, 16 Oct 2021 20:14:52.372 +0000 (UTC)
Received: from mail.wasin.io (localhost.localdomain [127.0.0.1])
        by mail.wasin.io (Postfix) with ESMTP id D7612A798C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 03:21:38 +0800 (SGT)
X-Virus-Scanned: Debian amavisd-new at mail.wasin.io
Received: from mail.wasin.io ([127.0.0.1])
        by mail.wasin.io (mail.wasin.io [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HxiqtIs8WfAh for <linux-kernel@vger.kernel.org>;
        Sun, 17 Oct 2021 03:21:13 +0800 (SGT)
Received: from haxpor-desktop.fritz.box (unknown [185.134.6.138])
        by mail.wasin.io (Postfix) with ESMTPSA id 3270FA7982;
        Sun, 17 Oct 2021 03:21:07 +0800 (SGT)
From:   Wasin Thonkaew <wasin@wasin.io>
Subject: [PATCH] docs: filesystems: Fix grammatical error "with" to "which"
Date:   Sat, 16 Oct 2021 20:14:53 +0000 (UTC)
Message-Id: <20211016201157.34240-1-wasin@wasin.io>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?zTXXJmbXDq374aSgSvBccBfxYYlnkEq2csSLV7s2zvJ+VzBfif=2FVK=2F1r3dRlUa?=
 =?us-ascii?Q?HKdShZ1bg6oUZY4XHrArWueRKIwlXkK3scPV=2FPw?=
 =?us-ascii?Q?9ewJjXT1rQyi5KAKJU+KMZfKH995LK4OPu=2FJBJr?=
 =?us-ascii?Q?9UUNYtOHTzAZ=2FXg8SwGexSFgbKY=2FEB2Uj0lXCtJ?=
 =?us-ascii?Q?8MROQwJcxTVv14ZZX8mOtae=2FFwk3YObpfqU6KOi?=
 =?us-ascii?Q?GPcSGOWjHy7tKwq=2FlI99JcZYkItqiiWFmH49xm?=
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wasin Thonkaew <wasin@wasin.io>
X-Entity-ID: 9qDajD32UCSRojGE52wDxw==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Wasin Thonkaew <wasin@wasin.io>
---
 Documentation/filesystems/autofs.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/autofs.rst b/Documentation/filesystems/autofs.rst
index 681c6a492bc0..4f490278d22f 100644
--- a/Documentation/filesystems/autofs.rst
+++ b/Documentation/filesystems/autofs.rst
@@ -35,7 +35,7 @@ This document describes only the kernel module and the interactions
 required with any user-space program.  Subsequent text refers to this
 as the "automount daemon" or simply "the daemon".
 
-"autofs" is a Linux kernel module with provides the "autofs"
+"autofs" is a Linux kernel module which provides the "autofs"
 filesystem type.  Several "autofs" filesystems can be mounted and they
 can each be managed separately, or all managed by the same daemon.
 
-- 
2.25.1

