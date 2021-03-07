Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEAC32FE8C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 04:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhCGDQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 22:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbhCGDQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 22:16:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A61C06174A;
        Sat,  6 Mar 2021 19:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7mGqxHIn6xsV7OoOZbdwsnXby9qoiBzjYToxzVErS9g=; b=WfDP1Ai9Uyk0OCAE5Y5qIrm0TU
        wM+Qe7xI8JqxcedlOhv2o+wxI1cl5p6s3TYRn7RijLp2AJdYwQ1/cQ4cxnX8oGjJ7Lv6Kf46XFREU
        PMkUSXiJQRq9Jl1yr/9l1XJjnByokHu4ngonW7f5PFHYB1ZTSTgw9DVx2vBqXiUTIWbItqRH2VpPd
        Fj0bnk/OsqRmf49/JpHdpJDOpanliIndBgySdBHTn7A9qMcpUdnAe8HHeqTr4wESfBOirKKcW/M60
        JI9iu0ULOEOsEXNriNzeWm4cRNqp70KdDNEROhSTzX7c1DoJFTeLz/9qooMonGgulB8XY+EG+x7sc
        2yPNfyDg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lIjtr-00DpX0-LM; Sun, 07 Mar 2021 03:16:20 +0000
Date:   Sun, 7 Mar 2021 03:16:11 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Wren Turkal <wt@penguintechs.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Expose the bus kernel docs to the build docs.
Message-ID: <20210307031611.GU2723601@casper.infradead.org>
References: <20210307014445.GT2723601@casper.infradead.org>
 <20210307031219.53800-1-wt@penguintechs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210307031219.53800-1-wt@penguintechs.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 06, 2021 at 07:12:19PM -0800, Wren Turkal wrote:
> +Fucntions and Structures

Typo, but hold off on a v3 until someone weighs in with an opinion on
the rest of the patch.
