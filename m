Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE7A41D684
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 11:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349494AbhI3Jlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 05:41:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349464AbhI3Jls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 05:41:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B60CB615E2;
        Thu, 30 Sep 2021 09:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632994805;
        bh=CMZyP1rNsKEbJUnU9kPXngE6AmQWtCmd3sbj/WSyJGs=;
        h=From:To:Cc:Subject:Date:From;
        b=koZwPLKPMKjwsPRGREt+/s0prMCoBWfRAT0/wpoT1Rs/3XRhU/jnix9yLqZ/6NPSm
         M+1X9cG0rdSIEPzBXb5T5W/qeQSlYZ1CCunTVsFDxBCob+C68f91tScv+YFJLCizX3
         tkqdC1gd8WObNLgDMj5sReD8lxwAuOR1/70syfYKs057Bti67w+mfELmn9yrLnLxtj
         Qom1MSIKCBPgCWE3WgqnEOXYyu4NiQJN84Fxh/EsMNjo7a18PXHS0SDNlXY3hI6rlz
         PK4g7AkmwXoFK32Ja/q7plm62TCFXcJhMhZlFpxMCBpVe2iAJTDDLFJpL+se1HiyZE
         vgn9zTb43vWcw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mVsXr-002AEp-JH; Thu, 30 Sep 2021 11:40:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 0/2] get_abi.pl: some fixes
Date:   Thu, 30 Sep 2021 11:39:58 +0200
Message-Id: <cover.1632994565.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This small series contain:

patch 1: 
  - fixes a rule that searches for some additional regexes.
    This will make the script slower but will avoid some false-positives
    (10 seconds instead of 6 seconds here)

patch 2:
  - contain some cleanups to the regexes. That will likely make
    some regular expressions to run faster.

I have an idea that might speedup the script again, but I need
to do some tests.

Mauro Carvalho Chehab (2):
  scripts: get_abi.pl: fix fallback rule for undefined symbols
  scripts: get_abi.pl: better generate regex from what fields

 scripts/get_abi.pl | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

-- 
2.31.1


