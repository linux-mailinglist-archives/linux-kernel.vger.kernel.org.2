Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3273B0364
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 13:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhFVL5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 07:57:47 -0400
Received: from vmi485042.contaboserver.net ([161.97.139.209]:53720 "EHLO
        gentwo.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230062AbhFVL5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 07:57:42 -0400
Received: by gentwo.de (Postfix, from userid 1001)
        id 94D4FB00320; Tue, 22 Jun 2021 13:55:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 93D78B002D6;
        Tue, 22 Jun 2021 13:55:24 +0200 (CEST)
Date:   Tue, 22 Jun 2021 13:55:24 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     gumingtao <gumingtao1225@gmail.com>
cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz, nathan@kernel.org,
        ndesaulniers@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        gumingtao <gumingtao@xiaomi.com>
Subject: Re: [PATCH v3] slab: Use __func__ to trace function name
In-Reply-To: <31fdbad5c45cd1e26be9ff37be321b8586b80fee.1624355507.git.gumingtao@xiaomi.com>
Message-ID: <alpine.DEB.2.22.394.2106221355080.365390@gentwo.de>
References: <cover.1624355507.git.gumingtao@xiaomi.com> <31fdbad5c45cd1e26be9ff37be321b8586b80fee.1624355507.git.gumingtao@xiaomi.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jun 2021, gumingtao wrote:

> It is better to use __func__ to trace function name.

Acked-by: Christoph Lameter <cl@linux.com>

