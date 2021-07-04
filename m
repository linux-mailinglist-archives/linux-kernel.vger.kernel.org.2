Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF143BAE19
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 19:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhGDRga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 13:36:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229724AbhGDRg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 13:36:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2780F613BD;
        Sun,  4 Jul 2021 17:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625420034;
        bh=SjQMBpfwAn5ddf9p8xn88FzNlcHAnOFIwqzhpAs3Uwc=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=AzB89uyDlh0XaqzutGv/veJAyAjzEjZ18Y1rZdyFxb03nbtVNqR6Fks/m9cGyv8+x
         zAqDHT1KC2taUyVLidqD82a8X05JlzxzCxzOM+4IKoAoC4uskgvk1rVIzMjHI3uhPE
         LnrAhNDaolgovXvsBXNdWymtseSx+8e+VJwf6FOwhb5+g0nJmPDYkCovrd1cwOz/nN
         dyaaeVsUNxARAOVsGSYa+Z1v5fYtDCFCg+G6YSsWUHKK84MP4hUrvxoqyhdvX9ql0/
         1Y/K3mQbExJdZ6Fuoqq3dqU3xQS50mLppYEt7kpl3MP9T75y21O0/g3/lLTaE9Euxt
         A4BdS4xIS1Mlg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D8B735C0147; Sun,  4 Jul 2021 10:33:53 -0700 (PDT)
Date:   Sun, 4 Jul 2021 10:33:53 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: [GIT PULL] Linux-kernel memory model (LKMM) changes for v5.14
Message-ID: <20210704173353.GA2970051@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

Please pull the latest LKMM tree from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git lkmm.2021.05.10c
  # HEAD: d25fba0e34742f19b5ca307c60c4d260ca5a754a: tools/memory-model: Fix smp_mb__after_spinlock() spelling (2021-05-10 16:27:20 -0700)

							Thanx, Paul

----------------------------------------------------------------
Björn Töpel (1):
      tools/memory-model: Fix smp_mb__after_spinlock() spelling

 tools/memory-model/Documentation/explanation.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
