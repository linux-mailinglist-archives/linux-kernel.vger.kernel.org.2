Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B9C41ACB7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 12:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240139AbhI1KPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 06:15:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:39356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240054AbhI1KPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 06:15:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5CD8360F24;
        Tue, 28 Sep 2021 10:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632824050;
        bh=VW+d8iWy8ZQ8DycR9mq4IfWlHvcXqlyXSG7CeCHJ+8I=;
        h=From:To:Cc:Subject:Date:From;
        b=UmM3/+YpRO20GeIktnhKxa686K90eIZ/Z5T7ei5VHxi5CLAf4w9I/1ZiEw9MxN796
         DGrFjEk8yNXBmI0N6dbIpBMm25R0hF7KK/XR+V+mcD9CMMTnjP1OhQtIM5kNqbXswA
         8tUUiJlKLtXZXvhz6PVSXHbrDemdrpPWNa7mPc1nfcdTy9gTkD5QDS1oIDrFiP8Srl
         hLIvnSkvf1BxCa47pfaFMHXZOjJMNL935hB1Wht4nxTAlEwgHpM58btmS/ufksG44B
         lE1HuhfaHDhQkmNoB8arMN+D2zjhYbPSUnOJ3/chuayuQIZfSWKZN1A8ffJU74f+Cs
         i+4CtUWSYr31Q==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mVA7k-000Thv-Bl; Tue, 28 Sep 2021 12:14:08 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 0/3] get_abi: improve message output and fix a regression
Date:   Tue, 28 Sep 2021 12:14:01 +0200
Message-Id: <cover.1632823172.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

As promised on

	https://lore.kernel.org/lkml/20210928120304.62319fba@coco.lan/T/#u

I'm adding progress info when  get_abi.pl is checking for undefined ABI symbols
on patches 1 and 2.

That will help not only to identify what is causing delays on the script, but also
to notify the user that processing it could take some time on some systems.

If you run it on your big server with:

  scripts/get_abi.pl undefined 2>logs

The "logs" file will contain timestamps relative to the time the script started to
do the regex matches for sysfs files. It should be printing one line every
time the progress completes 1% or one second after the last progress output.

-

Patch 3 is just a small fix for an issue introduced by an earlier change at
the script (unrelated to the other two patches).

Mauro Carvalho Chehab (3):
  scripts:: use STDERR for search-string and show-hints
  scripts: get_abi.pl: show progress
  ABI: evm: place a second what at the next line

 Documentation/ABI/testing/evm |   3 +-
 scripts/get_abi.pl            | 165 ++++++++++++++++++++++------------
 2 files changed, 111 insertions(+), 57 deletions(-)

-- 
2.31.1


