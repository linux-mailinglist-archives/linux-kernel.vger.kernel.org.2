Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D658D312478
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 14:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhBGNDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 08:03:01 -0500
Received: from mail2.protonmail.ch ([185.70.40.22]:18181 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhBGNC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 08:02:59 -0500
Date:   Sun, 07 Feb 2021 13:02:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail3; t=1612702936;
        bh=DBVKJjxxXtX1ZvoEUH+R+KQiMwBS89Owh4tS6f2FPXs=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=LqpNKw0eRp7dr6YIgzogwKcpHRCoqLES81Qk7v7aEph7u1PUZ/FEpRHNl8EBelINl
         iQcedVDjprleNswm2693iIWro8MSC884RGo0zSuXHLHyL8bLaYvj3xmdzm7ENSTfrh
         Wylo+T1H5Tui2insnntI9K14+fiqEdy59sjnJYMYFmFFtYcwp3E28qI9/fKnKj41RM
         IERgMoK4RXbemlahLOWDZcGblm/2/qHHABXId823EDx1Uk8mKE4w3lSha4pO7rEU5t
         KWiauut8tXZSlasIgbLVmTU3/ICHaQQ5W6CD0N64fmwpbjg4O364PvzdmPhxoMWVNi
         JYJ01HDY0mWWA==
To:     Marcin Raszka <djraszit@gmail.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH] I was wondering why I can't set the resolution to 2560x1080, while in windows 7 I can without a problem. I looked at the radeon driver code and found it doesn't support this resolution. So I made some changes. I added the hdmi_mhz parameter. In cmdline I set radeon.hdmi_mhz=190 Only tested on the Radeon HD 5830
Message-ID: <eaIUkjPeScDh6sT15RwxrsEfKG73yvqIrfVsRDK9Ey3v2rNZ_e_riEaBomCImXXeHV8XgCBlziwwZIqu0E7tgR7xIqWPVBe4fcdxuSNj1vk=@emersion.fr>
In-Reply-To: <20210207093952.7087-1-djraszit@gmail.com>
References: <20210207093952.7087-1-djraszit@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please keep the commit message short. You probbly want to send this patch
to amd-gfx@lists.freedesktop.org instead of dri-devel.
