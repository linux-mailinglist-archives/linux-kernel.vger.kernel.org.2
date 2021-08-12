Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F793EAC0E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 22:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbhHLUpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 16:45:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229703AbhHLUpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 16:45:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F101610CD;
        Thu, 12 Aug 2021 20:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628801079;
        bh=wSu4vK6QPy5lu74chy3kvXxrasNmp0dDg2cJnhU7LNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uNCl5+VMO/bMOXkHVOVUFVNraw/J4d/iSiHZQid9L1sy2VuAuXu3xZ4OnzR+nD9Bb
         sqJvie3xZ6v76PconoASUUN3FxGhnRRTAWhiyKfRukE6199fBISpliZv8moLF09RJv
         8bWPdPhvY4T2EwSScmbHU6cN9Fg12ZfccHlQidIsBxlQ4Tm4Sbwrv0aUeTLl/2YgNk
         bMaH+UUVPY3hEs05gW+T/br+G8aX/FqfyAa5vuLN7sw26CMIZfj6SENYzsHaH6HtYf
         m0mA4YNQ2It3dUneegXsPJsMbqWg9ybOyieTIOHl5O1CfhimExh/WvpLrD8i/gp6hS
         oCYxzoQc5dr+Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Jiri Kosina <trivial@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH trivial/resend] asm-generic: ffs: Drop bogus reference to ffz location
Date:   Thu, 12 Aug 2021 22:44:35 +0200
Message-Id: <162880107042.1372759.8811671186274878669.b4-ty@arndb.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <8363970653cc07e23d6f934642c0e98b6c95dc4d.1626255807.git.geert+renesas@glider.be>
References: <8363970653cc07e23d6f934642c0e98b6c95dc4d.1626255807.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

On Wed, 14 Jul 2021 11:44:22 +0200, Geert Uytterhoeven wrote:
> The generic definition of ffz() is not defined in the same header files
> as the generic definitions of ffs().

Applied to asm-generic-uaccess-3, thanks!

[1/1] asm-generic: ffs: Drop bogus reference to ffz location
      commit: fc062ad8e406a08b624b3ab3427434800ff886f8

       Arnd
