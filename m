Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E73D453C8F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 00:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbhKPXNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 18:13:22 -0500
Received: from smtprelay0193.hostedemail.com ([216.40.44.193]:46812 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229704AbhKPXNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 18:13:21 -0500
Received: from omf20.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 9E1B218224D99;
        Tue, 16 Nov 2021 23:10:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id BC10B80193D7;
        Tue, 16 Nov 2021 23:10:22 +0000 (UTC)
Message-ID: <6358495179b8abceafb651e58e933b8cf3a8ff1f.camel@perches.com>
Subject: Re: [PATCH 1/2] get_maintainer: look for configuration files in
 ./scripts
From:   Joe Perches <joe@perches.com>
To:     =?UTF-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 16 Nov 2021 15:10:21 -0800
In-Reply-To: <20211116213403.820336-1-l.stelmach@samsung.com>
References: <CGME20211116213417eucas1p2a9679f03f7945f7c2bdfcba7a4e7c405@eucas1p2.samsung.com>
         <20211116213403.820336-1-l.stelmach@samsung.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BC10B80193D7
X-Spam-Status: No, score=-4.77
X-Stat-Signature: h59tij59kq5ozmqn8udb5fah4taa9xwc
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18N5rIPHJiP99TeCIR9/2P1BVquz9oBAp8=
X-HE-Tag: 1637104222-186179
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-11-16 at 22:34 +0100, Łukasz Stelmach wrote:
> Change ".scripts" to "./scripts" as described in commit bcde44ed7d2a
> ("scripts/get_maintainer.pl: use .get_maintainer.conf from . then $HOME
> then scripts").

The intent there was to use the <kernel_tree>/scripts directory
Adding . to that would change that.


