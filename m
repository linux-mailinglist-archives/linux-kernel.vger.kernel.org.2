Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AADCB413680
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 17:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbhIUPvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 11:51:19 -0400
Received: from mail.alarsen.net ([144.76.18.233]:54304 "EHLO mail.alarsen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229804AbhIUPvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 11:51:18 -0400
Received: from oscar.alarsen.net (unknown [IPv6:fd8b:531:bccf:96:5122:9a9:28f5:243d])
        by joe.alarsen.net (Postfix) with ESMTPS id A9A0D18018A;
        Tue, 21 Sep 2021 17:49:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alarsen.net; s=joe;
        t=1632239385; bh=YZtN/XkzP/vJ27El94EAPr16VieFyvjNat0bx633y2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CpPGp0fNSm9p/T8iQaEclTHOQvtz0lf1POF+sbcKo4yYxVINWK1XyYBpdYpusfY0c
         D+yvWyqvxPdO88nyOVHWFiZbmVCNQcyhKtHkEJjwwS+QazJL+7nG1iu4+lcB2WFqr2
         gZS5Yvm9maP5LligKtTRwY+M0KrUTz0vT55rxu2k=
Received: from oscar.localnet (localhost [IPv6:::1])
        by oscar.alarsen.net (Postfix) with ESMTP id 9E0E327C06B5;
        Tue, 21 Sep 2021 17:49:45 +0200 (CEST)
From:   Anders Larsen <al@alarsen.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [RFC v2] qnx: avoid -Wstringop-overread warning, again
Date:   Tue, 21 Sep 2021 17:49:45 +0200
Message-ID: <1700211.4herOUoSWf@alarsen.net>
In-Reply-To: <CAHk-=wgaaUgz58Avt_W=7mAsp1DSoLh79mkcGASa-OUbPmjvVQ@mail.gmail.com>
References: <20210920121208.54732-1-arnd@kernel.org> <2955101.xlVK0Xs8nM@alarsen.net> <CAHk-=wgaaUgz58Avt_W=7mAsp1DSoLh79mkcGASa-OUbPmjvVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 2021-09-21 17:40 Linus Torvalds wrote:
> I'd rather use that third "clearly neither" structure member, just to
> clarify what is going on.

I'm perfectly fine with that.

> Anyway, I committed my patch that Arnd had tested, with a slightly
> expanded comment. I'm sure yours would have compiled cleanly too.

When it turns up in the tree, I'll cook up a fix for the strlen() issue in
fs/qnx4/namei.c following your scheme.

Cheers
Anders



