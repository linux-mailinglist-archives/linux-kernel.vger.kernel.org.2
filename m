Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37DA3439E4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 07:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbhCVGob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 02:44:31 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:50644 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230319AbhCVGnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 02:43:55 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 12M6hOLA021274;
        Mon, 22 Mar 2021 07:43:24 +0100
Date:   Mon, 22 Mar 2021 07:43:24 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, colin.king@canonical.com
Subject: Re: [PATCH] tools: include: nolibc: Fix a typo occured to occurred
 in the file nolibc.h
Message-ID: <20210322064324.GA21253@1wt.eu>
References: <20210227224435.21315-1-unixbhaskar@gmail.com>
 <3a9e310f-2a5b-9fc2-cd5a-222e2ed353e4@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a9e310f-2a5b-9fc2-cd5a-222e2ed353e4@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 27, 2021 at 02:58:18PM -0800, Randy Dunlap wrote:
> On 2/27/21 2:44 PM, Bhaskar Chowdhury wrote:
> > 
> > s/occured/occurred/
> > 
> > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>

Oops, seems like I missed this one, now queued, thanks to you both!
Willy
