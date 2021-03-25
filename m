Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D45D4348E32
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 11:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhCYKjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 06:39:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230174AbhCYKid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 06:38:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8FC9561A34;
        Thu, 25 Mar 2021 10:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616668712;
        bh=X0vm2TLnRzBGMIydCGUugGZKPvObtv5gLOJmeJk0Qlw=;
        h=From:To:Cc:Subject:Date:From;
        b=FYt1/yOjJOvCsxXXqmK7/tmPgEdUp0R/Ch8/HITm8wFIUaUJsTUZYGmIpuaRYgM16
         NwCQQungNwfHor3q1N/5Dg0nZ49V0FDX+nuKyEEB7cNfrA9DvdSvE5wuEIgp6vKjzO
         R56BMiOox/hfEd/EA3K4U2uZYDavUDbglizWIC0UQ97hPk/0ji+yvRVDzpKRbENvKR
         y+Z+MHAGxK0W7q6KDUWkayZ5yLbugi6+Uskf7SO6mEMXkxjD93vzSUYy6CVgdydHKO
         F0DOJvuB6MW1SlKnXT5TJjvn7ILH+mns+Gd9dYtJOKH3bbOYNH+mzh4AjAdfDq8hyP
         jIKVwfuyhiljw==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lPNNl-001AvQ-4U; Thu, 25 Mar 2021 11:38:29 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Minchan Kim <minchan@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v2 0/7] Fix some issues at get_abi.pl script
Date:   Thu, 25 Mar 2021 11:38:21 +0100
Message-Id: <cover.1616668017.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series replace this patch:
	https://lore.kernel.org/linux-doc/20210324191722.08d352e4@coco.lan/T/#t

It turns that there were multiple bugs at the get_abi.pl code that
create cross-references.

Patches 1 to 6 fix those issues, and should apply cleanly on the top of
the docs tree (although I tested against next-20210323).

Patch 7 is optional, and independent from the other patches. It is meant
to be applied against akpm's tree.  It makes the description (IMHO) 
clearer, while producing cross references for the two mentioned symbols.

The fix patches are:

patch 1: fix some regexes that match the symbols that need to be
  escaped when parsing "What:". The same regex is also used when
  generating cross-references;

patch 2: makes the check for Documentation/ABI references more
  robust, as right now, it stops at the first occurrence;

patch 3: fix the parser for /sys/foo -> xref conversion. Basically,
  the logic that seeks for start and end boundaries were broken.
  The new logic is a way more robust.

patch 4: generate cross-references for /config/foo and other less
  common ABI occurrences;

patch 5 and 6: don't generate cross-references inside literal blocks.
  Right now, there are a couple of places that would otherwise
  generate references, producing a bad output.

Mauro Carvalho Chehab (7):
  scripts: get_abi.pl: better handle escape chars on what:
  get_abi.pl: seek for all occurrences for Documentation/ABI
  get_abi.pl: fix xref boundaries
  scripts: get_abi.pl: extend xref match to other types
  scripts: get_abi.pl: parse description line per line
  scripts: get_abi: ignore code blocks for cross-references
  ABI: sysfs-kernel-mm-cma: fix two cross-references

 Documentation/ABI/testing/sysfs-kernel-mm-cma |  8 +-
 scripts/get_abi.pl                            | 76 +++++++++++++------
 2 files changed, 57 insertions(+), 27 deletions(-)

-- 
2.30.2


