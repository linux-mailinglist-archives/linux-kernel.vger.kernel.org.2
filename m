Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E285F317143
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 21:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbhBJUYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 15:24:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:45492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233530AbhBJUVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 15:21:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3504064F00;
        Wed, 10 Feb 2021 20:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612988382;
        bh=TvmjjBQMashqYeR34N26U0gn1dIqetjqzDH8k6T1CEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CbhpmMz7Jt7VTYtX6pogHQfXCZURWdX4XSBQb/7jryW82Er+JQQMEcZjVHuHt+qMo
         YJ5xH6JVY6VfcrpRV3+DzBivr4Hr1LJkq3mbhsiYkQMuRVHsXq7WOy3No0+bblYsXz
         QdpYyu4hssn2veqh2Gf23upcZq+MEvfm/efo7XrTU7ARBjNeUuJ06n9y0jPe6ISj51
         rF38GvtsJ68cKM3h54Cl9+kqJ8Clb6YiZPsbBLSRn06IUUcsBB+BfJHt5UkB2OrGCD
         LbXDdWXB5uYW9fV5dW1aNEJfQO9a8SRSNsS0Ip14jM64glIl4I4ySDPmq8gaPEtH6A
         Ffs68JU2jNniQ==
Date:   Wed, 10 Feb 2021 12:19:40 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Mike Snitzer <snitzer@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v4 4/5] dm: support key eviction from keyslot managers of
 underlying devices
Message-ID: <YCQ/3EJuufLXMiG4@gmail.com>
References: <20210201051019.1174983-1-satyat@google.com>
 <20210201051019.1174983-5-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201051019.1174983-5-satyat@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 05:10:18AM +0000, Satya Tangirala wrote:
> Now that device mapper supports inline encryption, add the ability to
> evict keys from all underlying devices. When an upper layer requests
> a key eviction, we simply iterate through all underlying devices
> and evict that key from each device.
> 
> Co-developed-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Satya Tangirala <satyat@google.com>

This latest version looks good to me.  If it's needed despite my
Co-developed-by, feel free to add:

	Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
