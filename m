Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEAA339E60
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 15:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbhCMN6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 08:58:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:45442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229615AbhCMN6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 08:58:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4FB0964ECC;
        Sat, 13 Mar 2021 13:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615643885;
        bh=Wv6CERx5fPbidi64thYA1g1O6PBYe1Szo2LGjqOCAuk=;
        h=Date:From:To:Cc:Subject:From;
        b=zFZJgaJmnUntqTg5qfpFOX5iixgPF3f6lxRHED7hN4u1wUDfssT97rGBYwiyMkdCn
         0OI0Cz+VhWFCIoDhNyHw/WNpNA9Lus6Qo1cIiq7UOXDxUqpR1z78v66b0gk+5RHLyn
         PUZtXhyGMJ/xi89OjZ8SCDIBt8ev8tbdyy3up2ng=
Date:   Sat, 13 Mar 2021 14:58:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: [PATCH] MAINTAINERS: move some real subsystems off of the staging
 mailing list
Message-ID: <YEzE6u6U1jkBatmr@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VME and Android drivers still have their MAINTAINERS entries
pointing to the "driverdevel" mailing list, due to them having their
codebase move out of the drivers/staging/ directory, but no one
remembered to change the mailing list entries.

Move them both to linux-kernel for lack of a more specific place at the
moment.  These are both low-volume areas of the kernel, so this
shouldn't be an issue.

Cc: Martyn Welch <martyn@welchs.me.uk>
Cc: Manohar Vanga <manohar.vanga@gmail.com>
Cc: Arve Hjønnevåg <arve@android.com>
Cc: Todd Kjos <tkjos@android.com>
Cc: Martijn Coenen <maco@android.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Christian Brauner <christian@brauner.io>
Cc: Hridya Valsaraju <hridya@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Reported-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index 72e5b9db5050..b02eec28ae2c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1181,7 +1181,7 @@ M:	Joel Fernandes <joel@joelfernandes.org>
 M:	Christian Brauner <christian@brauner.io>
 M:	Hridya Valsaraju <hridya@google.com>
 M:	Suren Baghdasaryan <surenb@google.com>
-L:	devel@driverdev.osuosl.org
+L:	linux-kernel@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 F:	drivers/android/
@@ -19135,7 +19135,7 @@ VME SUBSYSTEM
 M:	Martyn Welch <martyn@welchs.me.uk>
 M:	Manohar Vanga <manohar.vanga@gmail.com>
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
-L:	devel@driverdev.osuosl.org
+L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 F:	Documentation/driver-api/vme.rst
