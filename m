Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE17F412689
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 20:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356231AbhITTAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 15:00:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:40934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1387332AbhITS5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 14:57:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C924260EE4;
        Mon, 20 Sep 2021 18:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632164142;
        bh=J25Y9NBEgoBSetqllU82kgC8YAKqqBhRybNFKW4G9X8=;
        h=From:To:Subject:Date:From;
        b=BVeatEgCWjiIrvRpq1/rli5VINvPzHv/4QoSFcAzoMHULLCEWVNWjFaMAdWn8NLs3
         v2tK5CkOS6CaKoOZRdITIN18p1b4PilaKtAD05bHjXnilpd8EhmXidKZ4eJvTJ+pOx
         ihIQJAt1SRMHLq5u+F8G4ynohAXr3YKawn/DYZwYSH6V5r5wE6zsQkjHVP8ZdBhy+M
         JGCUqK3anrv7LOJPNKjqd92bKX0QxGajnRQxIMl2abq1yhgDv7pkg8g6aubJiOGKlS
         Kceuq6fuEK0N9NLL6HHJzF8TcRFB5pxdIl3PkbPhOZVb6Bht3f9ZM8L/E5VliMOExd
         lYQByqnELmFbQ==
Received: by envy17 (sSMTP sendmail emulation); Mon, 20 Sep 2021 11:55:41 -0700
From:   markgross@kernel.org
To:     linux-kernel@vger.kernel.org, hdegoede@redhat.com
Subject: [PATCH] update email addresses. 
Date:   Mon, 20 Sep 2021 11:55:34 -0700
Message-Id: <20210920185535.83416-1-markgross@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry for the resend, I had a very old .gitconfig with an obsolete email
address I needed to git commit --amend to correct.

--mark


