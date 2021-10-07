Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F85E424B6F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 03:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240129AbhJGBC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 21:02:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231279AbhJGBC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 21:02:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65ECA61152;
        Thu,  7 Oct 2021 01:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1633568434;
        bh=XSea3xDREsS668JtnNhe6+YvbVphkxRN+hbEgepZfIY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qN23EiUnwaUxTtCzyddQ+UcOwjZfm+SfZJ7RIR2Q90Kpyavt4V1HnOtPpWsmyMzeE
         7lVLRx+2Scxs9bhPZtUCfN2dvqfsJNgMAxLPrBjbydvre6Y0odB3YBNIp2PUDpbyoy
         /B0hTgMYGfNeW1ctqFFsXgaiuDgtOINH/Wm997bM=
Date:   Wed, 6 Oct 2021 18:00:33 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add "exec & binfmt" section with myself
 and Eric
Message-Id: <20211006180033.e31809540ed053192b423419@linux-foundation.org>
In-Reply-To: <20211006180200.1178142-1-keescook@chromium.org>
References: <20211006180200.1178142-1-keescook@chromium.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 Oct 2021 11:02:00 -0700 Kees Cook <keescook@chromium.org> wrote:

> I'd like more continuity of review for the exec and binfmt (and ELF)
> stuff. Eric and I have been the most active lately, so list us as
> reviewers.

Could add myself sometime as well, I guess.  For some reason I am
suspiciously absent from MAINTAINERS.

	switch (subsystem) {
		...
	default:
		akpm;
	}


