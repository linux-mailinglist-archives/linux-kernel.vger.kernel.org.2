Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4DE45FD8D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 10:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353174AbhK0JUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 04:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352878AbhK0JSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 04:18:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CD8C061748;
        Sat, 27 Nov 2021 01:14:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9630CB81112;
        Sat, 27 Nov 2021 09:14:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C8FC53FC7;
        Sat, 27 Nov 2021 09:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638004493;
        bh=Qkb+m3FNVzBw/ZD0d7/9d974eseNjWRBmu/5Bxu26Oo=;
        h=From:To:Cc:Subject:Date:From;
        b=g9fiQMVyGlba1HM2g+dEUooDju5nZ6CHYiCoxXqnSC7UjW+f3nRBiqZQEAaLNhdZs
         TUEh7YsZJTjXFedvsK/pEj2tVgWSQueazDVOS0/TvQWyDuRjncy5ifLHoE6TdYVFf6
         8ggfJ/qnpnkvwNXLfYYHn2U1iHnOw1Z0xxHYPvwpKLUmmgFruR4lecS6Pet+CPQyYl
         8enw2lsbNtczEvVh022uuc8uuRN69qu/pGl8buH1arRNq2dsdxgUeHEw7DKJnDwHGy
         c6Wksrl6upUeFFZQb0XHTJVuyPoRYcKtdZSj1EzcIvGut9YMzCAco8wdo5Sglg0Xw2
         2Mabuj0RM5CJQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mqtnG-0002cY-O9; Sat, 27 Nov 2021 10:14:50 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH v2 0/1] docs: fix themes with newer Sphinx and RTD themes
Date:   Sat, 27 Nov 2021 10:14:48 +0100
Message-Id: <cover.1638004294.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

That's the second version of the patch fixing themes with newer versions of
Sphinx and RTD themes.

On my past version, the theme was not actually applied on newer Kernels,
causing a regresion. This version addresses it. It also takes Laurent's suggestion
into account.

As this is actually a fix, I would pick it, independently on the discussions if
we should keep using RTD theme or not.

Regards,
Mauro

Mauro Carvalho Chehab (1):
  docs: conf.py: fix support for Readthedocs v 1.0.0

 Documentation/conf.py | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

-- 
2.33.1


