Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924EE4291C5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 16:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241262AbhJKOas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 10:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240662AbhJKOaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 10:30:39 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780ACC125FA3;
        Mon, 11 Oct 2021 07:06:21 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1mZvwZ-0001FU-2L; Mon, 11 Oct 2021 16:06:19 +0200
Date:   Mon, 11 Oct 2021 16:06:19 +0200
From:   Florian Westphal <fw@strlen.de>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH security-next] selinux: remove ipv6 hook wrappers
Message-ID: <YWRE2xoK0rUcVQWb@strlen.de>
References: <20211011083717.396885-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011083717.396885-1-fw@strlen.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Westphal <fw@strlen.de> wrote:
> -#endif	/* CONFIG_NETFILTER */

Thats nonsense.  Please disregard this patch, I'll send a v2 later.
