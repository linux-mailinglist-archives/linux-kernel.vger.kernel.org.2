Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E29D312376
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 11:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhBGKb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 05:31:59 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:49685 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhBGKb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 05:31:57 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 117AVEru031382;
        Sun, 7 Feb 2021 11:31:14 +0100
Date:   Sun, 7 Feb 2021 11:31:14 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Marcin Raszka <djraszit@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] I was wondering why I can't set the resolution to
 2560x1080, while in windows 7 I can without a problem. I looked at the
 radeon driver code and found it doesn't support this resolution. So I made
 some changes. I added the hdmi_mhz parameter. In cmdline I set
 radeon.hdmi_mhz=190 Only tested on the Radeon HD 5830
Message-ID: <20210207103114.GA31373@1wt.eu>
References: <20210207094604.7250-1-djraszit@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210207094604.7250-1-djraszit@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, Feb 07, 2021 at 10:46:04AM +0100, Marcin Raszka wrote:
> ---
>  drivers/gpu/drm/radeon/radeon_benchmark.c  |  5 ++--
>  drivers/gpu/drm/radeon/radeon_connectors.c | 30 ++++++++++++++--------
>  drivers/gpu/drm/radeon/radeon_drv.c        |  5 ++++
>  drivers/gpu/drm/radeon/radeon_encoders.c   |  6 +++--
>  4 files changed, 32 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/radeon/radeon_benchmark.c b/drivers/gpu/drm/radeon/radeon_benchmark.c
(...)

Please have a look at Documentation/process/submitting-patches.rst to
see how to reformat your patch so that it contains a descriptive commit
message.

Thanks,
Willy
