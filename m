Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8061837BE19
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 15:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhELNWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 09:22:20 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:52989 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231221AbhELNWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 09:22:16 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 14CDL29B021209;
        Wed, 12 May 2021 15:21:02 +0200
Date:   Wed, 12 May 2021 15:21:02 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tools/nolibc: Implement msleep()
Message-ID: <20210512132102.GD20883@1wt.eu>
References: <20210512123215.42321-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512123215.42321-1-broonie@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 01:32:15PM +0100, Mark Brown wrote:
> Allow users to implement shorter delays than a full second by implementing
> msleep().
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Great, now queued, thank you Mark!
Willy
