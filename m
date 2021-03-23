Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0FE8346AD3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 22:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbhCWVJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 17:09:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:55672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233453AbhCWVJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 17:09:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0A3961879;
        Tue, 23 Mar 2021 21:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616533765;
        bh=PryQQGQOOdbNXVqeGFFDDFGtLQcl72kdVVul/251vKs=;
        h=Subject:From:To:Date:From;
        b=WKpcVtQZGVOEAtcbVuY3vZwJDf0edGlj7IuZwylmDs+sor0NREDlUSk0MU1NS+6+z
         n7Zl7ncsUfrZmj5U6YiM3u91Pz2FI4IcGQ3ycYdwoUlwir3zlQJy38R+dXilAnd5+s
         ZcKuI0IGEHc2nbrXKIfNFStTpiT8I2J/Ed68hsLuO1b/b20SjEUaDJwX9Y24wXGu5P
         BTDEjlXKBahxMzS7ag8mDjNCfajrFkCXGkWLS7S7LSgw6OWYn0ZOhI2bEmEBo6rk8U
         0+Au7Y0GEB7IPZSZZJ2gASUTWgWutvuzwjStKIoiWER1EQ9XNNbWtWbRqxVQFO8nB/
         rm/39HFnT7Oaw==
Message-ID: <64fa2b3e44451617afc13006b03f6001be677fcc.camel@kernel.org>
Subject: [ANNOUNCE] 4.19.182-rt74
From:   Tom Zanussi <zanussi@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Pavel Machek <pavel@denx.de>, Tom Zanussi <zanussi@kernel.org>
Date:   Tue, 23 Mar 2021 16:09:23 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.19.182-rt74 stable release.

This release is just an update to the new stable 4.19.182
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 973d50c65e7a04ce11a946a0725e22432353a82c

Or to build 4.19.182-rt74 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.182.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.182-rt74.patch.xz

Enjoy!

   Tom

