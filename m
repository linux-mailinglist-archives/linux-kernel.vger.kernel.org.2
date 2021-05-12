Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D6837BC29
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 13:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhELMBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 08:01:02 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:52984 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230361AbhELMBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 08:01:02 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 14CBxnhh021106;
        Wed, 12 May 2021 13:59:49 +0200
Date:   Wed, 12 May 2021 13:59:49 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tools/nolibc: Implement msleep()
Message-ID: <20210512115949.GA20883@1wt.eu>
References: <20210512114728.19015-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512114728.19015-1-broonie@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 12:47:28PM +0100, Mark Brown wrote:
> Allow users to implement shorter delays than a full second by implementing
> msleep().
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> 
> v2:
>  - Support delays of more than a second.
>  - Return the number of seconds remaining if the delay does not
>    complete.

But why returning the number of seconds instead of milliseconds ?
The common use case is this:

     delay = delay_before_next_event();
     while ((ret = msleep(delay)) > 0)
            delay -= ret;

Willy
