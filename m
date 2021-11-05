Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B48D446AF0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 23:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbhKEWg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 18:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbhKEWg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 18:36:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCFFC061570
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 15:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=hOO7lxIdBGiMGSI9eUV+OgwA4OmL8+b8B41jLoeStsA=; b=eWF9+Hb4zSso9qRigLlE/jCi4Z
        TNbolrY25qFn8X4vgDnqdSYYpg14Sx24s7SacR7Zqckl8LL6q2RTd1okcHoZDFLTd/SaQ9xeBYTr7
        NyLcJ9B0FASuQtS2t6AVizVwO718b0JMR84xAAhpoUy8QivDSHMlqBj/ByL106XBkvB9/cQLTVBMp
        XrTAj/vYc5EHfJtt2dxrWc8sDFqvDzAPCRcUVtPxgP2KPLtUdHhiDkzNghmjsWPDqaAYPXHtMG9V/
        1a1Do0pzk1CeWoRroJ024Xa7kagOE9UrBtdXbCvwDm55NEUnNtCQkCDHvGhjxClG70oSABD89lCU5
        7lroctig==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mj7mM-00CPVu-RT; Fri, 05 Nov 2021 22:33:46 +0000
Date:   Fri, 5 Nov 2021 15:33:46 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jessica Yu <jeyu@kernel.org>, mcgrof@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Modules updates for v5.16-rc1
Message-ID: <YYWxSlB1CNhhjUTQ@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

As requested by Jessica, I'm stepping in to help with modules
maintenance. This is my my first pull request, so if there are any
issues with it please let me know so I can fix things for the next
time around to make it even smoother for you.

Nothing exciting here, except a warning enhancement and a fix for
insanely large modules.

Thank you,

  Luis

The following changes since commit 7fd982f394c42f25a73fe9dfbf1e6b11fa26b40a:

  module: change to print useful messages from elf_validity_check() (2021-11-05 15:13:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-5.16-rc1

for you to fetch changes up to 7fd982f394c42f25a73fe9dfbf1e6b11fa26b40a:

  module: change to print useful messages from elf_validity_check() (2021-11-05 15:13:10 -0700)

----------------------------------------------------------------
modules patches for 5.16-rc1

As requested by Jessica I'm stepping in to help with modules
maintenance. This is my first pull request to you.

I've collected only two patches for modules for the 5.16-rc1 merge
window. These patches are from Shuah Khan as she debugged some corner
case error with modules. The error messages are improved for
elf_validity_check(). While doing this work a corner case fix was
spotted on validate_section_offset() due to a possible overflow bug
on 64-bit. The impact of this fix is low given this just limits
module section headers placed within the 32-bit boundary, and we
obviously don't have insane module sizes. Even if a specially crafted
module is constructed later checks would invalidate the module right
away.

I've let this sit through 0-day testing since October 15th with no
issues found.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

----------------------------------------------------------------
