Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3A2453BFD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 22:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbhKPV7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 16:59:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:37904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229593AbhKPV70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 16:59:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08C3A63222;
        Tue, 16 Nov 2021 21:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1637099789;
        bh=GkDW3avkXtHTZKXysKos7l1cjngE9uaX66Z1h6IGnWg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q5daqATqnCVF2dZO34sWLETM3FtW0KrSIWPd5W6rf17ceReudlRQrI0ooKExS+pVa
         CjzmeTAJr+/2imNExGI0q9OslV/+gMaffwgxtYBxbpO6nBGy+0tv0rZWRAiiEaClx9
         WEXv4Pn34JZ6/lwwkmR+N/pN53FsOaehEMLLavVI=
Date:   Tue, 16 Nov 2021 13:56:27 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     =?UTF-8?B?xYF1a2Fzeg==?= Stelmach <l.stelmach@samsung.com>
Cc:     Joe Perches <joe@perches.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] get_maintainer: look for configuration files in
 ./scripts
Message-Id: <20211116135627.321aa8ef46ee389cf66692df@linux-foundation.org>
In-Reply-To: <20211116213403.820336-1-l.stelmach@samsung.com>
References: <CGME20211116213417eucas1p2a9679f03f7945f7c2bdfcba7a4e7c405@eucas1p2.samsung.com>
        <20211116213403.820336-1-l.stelmach@samsung.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2021 22:34:01 +0100 Łukasz Stelmach <l.stelmach@samsung.com> wrote:

> Change ".scripts" to "./scripts" as described in commit bcde44ed7d2a
> ("scripts/get_maintainer.pl: use .get_maintainer.conf from . then $HOME
> then scripts").

Won't this break people who are using ".scripts"?

If so, we should either leave it as-is and update the documentation
(which doesn't appear to exist) or to newly add ./scripts and leave
.scripts unaltered.


