Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88EED37BDCC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 15:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbhELNPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 09:15:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:37540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230320AbhELNPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 09:15:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F36261363;
        Wed, 12 May 2021 13:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620825261;
        bh=MJT/LqqGBgI+Qn4TX3THbJYSnAwXa3ctfwqTmXh1reg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UOmD3ZxcOUqVM6Qh81PohBXMD2GwlN7cRxBO6/ZUIhPc3Fl0ks1OvlQNQdkZXo+RL
         CKkrUlSvnvrJtwQ3J2eMOaYGMjOTceNVCsUeY6pixpm7AxEdj7KUQrvLR92A1mLM7W
         2lM/TyJwPfs6/vKDAu86qdbWypFZW3l+KIYFDQxyifeibp1hJNI4q9V6fbUN0SwO/6
         CFvxaLuXoIvI+pvIrt5wIPPGIqMUK7AceSfDPEe1+vy2O2+RDNUpnUTAMKx1sCRumT
         MofyKMbjGLcWimP2y6fpJMGr3bSMnBaajsiEVniwOfz6zhaMfaj322qfPaszqCVW6U
         2gkHPjt7HBbRw==
Date:   Wed, 12 May 2021 15:14:16 +0200
From:   Alexey Gladkov <legion@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-mm@kvack.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v11 0/9] Count rlimits in each user namespace
Message-ID: <20210512131416.ari5cjzhs754tknd@example.org>
References: <cover.1619094428.git.legion@kernel.org>
 <20210509181205.f0ce806919858efa0e0e0d20@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210509181205.f0ce806919858efa0e0e0d20@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 09, 2021 at 06:12:05PM -0700, Andrew Morton wrote:
> On Thu, 22 Apr 2021 14:27:07 +0200 legion@kernel.org wrote:
> 
> > These patches are for binding the rlimit counters to a user in user namespace.
> 
> It's at v11 and no there has been no acking or reviewing activity?  Or
> have you not been tracking these?

Eric W. Biederman told me he's ready to pick it [1]. But as far as I can
see he hasn't put it in for-next yet.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git/log/?h=ucounts-rlimits-for-v5.13

-- 
Rgrds, legion

