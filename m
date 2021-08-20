Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8AD3F33F3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 20:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237441AbhHTSlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 14:41:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:58090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236398AbhHTSlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 14:41:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA0F061056;
        Fri, 20 Aug 2021 18:40:28 +0000 (UTC)
Date:   Fri, 20 Aug 2021 19:40:25 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: in_irq() cleanup
Message-ID: <20210820184025.GA12581@arm.com>
References: <20210813145245.86070-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210813145245.86070-1-changbin.du@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2021 at 10:52:45PM +0800, Changbin Du wrote:
> Replace the obsolete and ambiguos macro in_irq() with new
> macro in_hardirq().
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

For kmemleak:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
