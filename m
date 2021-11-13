Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A8E44F45B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 18:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235975AbhKMRjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 12:39:03 -0500
Received: from smtp161.vfemail.net ([146.59.185.161]:46367 "EHLO
        smtp161.vfemail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235785AbhKMRjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 12:39:02 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Sat, 13 Nov 2021 12:39:01 EST
Received: (qmail 5731 invoked from network); 13 Nov 2021 17:29:27 +0000
Received: from localhost (HELO nl101-3.vfemail.net) ()
  by smtpout.vfemail.net with ESMTPS (ECDHE-RSA-AES256-GCM-SHA384 encrypted); 13 Nov 2021 17:29:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=vfemail.net; h=date:from
        :to:subject:message-id:mime-version:content-type
        :content-transfer-encoding; s=2018; bh=sowAyUc+Q+1oUqX7nzfsftkDq
        110kdObXpSak7lGksw=; b=q0N1bonM3YmidxvrQ8DAYBb0kilVA4ab5X6Mxz31d
        4NJdxvu2C882VJ3HT2AX7kihcSpRvPHGkhFD6LPPDpe75FlsL/8qEVrpyfKcgPnG
        /5iAkZCcGMV+oN3ypxNxM9SZmnrwUBGpqKB2suEEfvIwOaVc4p8H11gGEz1ErxSl
        bI=
Received: (qmail 37092 invoked from network); 13 Nov 2021 17:28:57 -0000
Received: by simscan 1.4.0 ppid: 37081, pid: 37090, t: 0.2965s
         scanners:none
Received: from unknown (HELO bmwxMDEudmZlbWFpbC5uZXQ=) (aGdudGt3aXNAdmZlbWFpbC5uZXQ=@MTkyLjE2OC4xLjE5Mg==)
  by nl101.vfemail.net with ESMTPA; 13 Nov 2021 17:28:57 -0000
Date:   Sat, 13 Nov 2021 12:29:08 -0500
From:   David Niklas <Hgntkwis@vfemail.net>
To:     lkml <linux-kernel@vger.kernel.org>
Subject: ntfs3 64bit cluster size: does it auto-convert the fs?
Message-ID: <20211113122908.2034d3e3@Zen-II-x12.niklas.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
Regarding the option NTFS3_64BIT_CLUSTER, will the Linux kernel
auto-convert FS-es using 32bit clusters, or does this need to be
explicitly asked for when creating the FS with mkfs?

If enabled, will the Linux kernel not be able to access 32bit NTFS FS-es?

Thanks!
