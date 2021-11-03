Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52FC044490A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 20:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhKCTho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 15:37:44 -0400
Received: from wrqvxttq.outbound-mail.sendgrid.net ([149.72.167.116]:18118
        "EHLO wrqvxttq.outbound-mail.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231251AbhKCThl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 15:37:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wasin.io;
        h=from:subject:mime-version:to:cc:content-transfer-encoding:
        content-type;
        s=s1; bh=qNBGXlLMnPhrJq5G4++xZYyQ0CDuclAGDf2//H9A8Jw=;
        b=ATVwlzXPw6ucJT7y90v3tOD8+WcmUwa6p3KUrJcBgBwJCfUasDWzO6o+yKsla0vrNh5T
        KdSqEAm8tZYLaCDSlMbuvlnNGR/gTXgTai+tum1kJVcvkMJa7QVzdk3Wzxj7EJ8dNHCwbF
        /APUeRwyz35IRsUN6rZWXbcxq7sE6OQbya4o4kCdVhKFSZ9PUykIXH3W4RBUXsgxiv3QQV
        nWFS+l0i/k+ClIUZOtk4kHqRnddSdujm0iMyIAA1n6wvgSpcDLcYrcaK/dPh92UfiuzRR5
        xhsv0EQZUgh6BSDNkt+CWI8PAUiGgSI5hMnK/o/S4eHcASTx2MoqGVeIFkJPrlOQ==
Received: by filterdrecv-7bc86b958d-g5ggb with SMTP id filterdrecv-7bc86b958d-g5ggb-1-6182E467-72
        2021-11-03 19:35:03.921384625 +0000 UTC m=+5433307.461623071
Received: from mail.wasin.io (unknown)
        by geopod-ismtpd-1-0 (SG) with ESMTP
        id LHoz9VGZQV-O_PwKEj1PFg
        for <linux-kernel@vger.kernel.org>;
        Wed, 03 Nov 2021 19:35:03.128 +0000 (UTC)
Received: from mail.wasin.io (localhost.localdomain [127.0.0.1])
        by mail.wasin.io (Postfix) with ESMTP id 89B13A79D7
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 02:39:16 +0800 (SGT)
X-Virus-Scanned: Debian amavisd-new at mail.wasin.io
Received: from mail.wasin.io ([127.0.0.1])
        by mail.wasin.io (mail.wasin.io [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vUn-1U0nVkYD for <linux-kernel@vger.kernel.org>;
        Thu,  4 Nov 2021 02:38:54 +0800 (SGT)
Received: from haxpor-desktop.fritz.box (unknown [185.134.6.138])
        by mail.wasin.io (Postfix) with ESMTPSA id 5BA4BA79D5;
        Thu,  4 Nov 2021 02:38:47 +0800 (SGT)
From:   Wasin Thonkaew <wasin@wasin.io>
Subject: [PATCH RESEND] docs: filesystems: Fix grammatical error "with" to
 "which"
Date:   Wed, 03 Nov 2021 19:35:03 +0000 (UTC)
Message-Id: <20211103193354.185647-1-wasin@wasin.io>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?zTXXJmbXDq374aSgSvBccBfxYYlnkEq2csSLV7s2zvJ+VzBfif=2FVK=2F1r3dRlUa?=
 =?us-ascii?Q?HKdShZ1bg6oUZY4XHrArWueaHjBNLT01KMohBrC?=
 =?us-ascii?Q?Sa0nbaQdlxvdnO8WvPq=2F6UPCVQGz0Sexa6CVWWy?=
 =?us-ascii?Q?Mm=2FvurjjrKufXs16sM0DyQopN60=2Fa7+ahBnM+sQ?=
 =?us-ascii?Q?DQHShyJxPCztW23Ph9N53R7NwjU8QLfwaP1xZRb?=
 =?us-ascii?Q?oI5ZjJW+=2Fm83MGc2Jy7oH+S+cKVMOAwoIzQLue?=
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

