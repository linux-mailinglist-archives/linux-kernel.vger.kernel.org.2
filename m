Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B98316EC4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 19:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbhBJSei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 13:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233990AbhBJSXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 13:23:38 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201F5C06174A;
        Wed, 10 Feb 2021 10:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=gPBD8cTxN1KK/x/IZ1OsnMclVj6MDrV+W4PD4XUJ32o=; b=Xj03N7O/Kc6vuVSLTEccU0XeHS
        wFhDD/VKvxNxurRqJQWJkd5jSM5uMLUr4R+S/HYr5AqtNfphvP/mjf6qFgwaAx6y+dFmoFjGhi+Bw
        XIhyHpJebQNKv7fpyuWzfoSLoswz6UYnlrxnMIXu/aq5F9pA25thFxf6k7H8mmf90Z6Y7GVR6TMx6
        HMovF9T0nlg6VSS0x/3yic7AG6h8FjCvPAHqb7zD6ERaHH9D9kDdpfVHet2qzuT48cmIWzY+CiAvW
        WJ3KSJ3SrEmLc5+U6WXlmkTd/Wgv1AJ/T2SM3nr+biGVoaZqTqbfNMxEayLcBSPk0YTxKIm6KlepA
        W52s2Ifg==;
Received: from [2601:1c0:6280:3f0::cf3b] (helo=merlin.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l9u8b-00055K-3n; Wed, 10 Feb 2021 18:22:53 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrey Vagin <avagin@openvz.org>,
        Serge Hallyn <serge@hallyn.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] Documentation: ioctl: add entry for nsfs.h
Date:   Wed, 10 Feb 2021 10:22:48 -0800
Message-Id: <20210210182248.18101-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All userspace ioctls major/magic number should be documented in
Documentation/userspace-api/ioctl/ioctl-number.rst, so add
the entry for <linux/nsfs.h>.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrey Vagin <avagin@openvz.org>
Cc: Serge Hallyn <serge@hallyn.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: linux-doc@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
---
Feel free to modify the patch as needed.

Probably don't need to backport:
# Fixes: 6786741dbf99 ("nsfs: add ioctl to get an owning user namespace for ns file descriptor")

 Documentation/userspace-api/ioctl/ioctl-number.rst |    1 +
 1 file changed, 1 insertion(+)

--- lnx-511-rc7.orig/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ lnx-511-rc7/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -344,6 +344,7 @@ Code  Seq#    Include File
 0xB5  00-0F  uapi/linux/rpmsg.h                                      <mailto:linux-remoteproc@vger.kernel.org>
 0xB6  all    linux/fpga-dfl.h
 0xB7  all    uapi/linux/remoteproc_cdev.h                            <mailto:linux-remoteproc@vger.kernel.org>
+0xB7  all    uapi/linux/nsfs.h                                       <mailto:Andrei Vagin <avagin@openvz.org>>
 0xC0  00-0F  linux/usb/iowarrior.h
 0xCA  00-0F  uapi/misc/cxl.h
 0xCA  10-2F  uapi/misc/ocxl.h
