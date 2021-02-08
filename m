Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83679313E19
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235964AbhBHSxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:53:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:59486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233394AbhBHREr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 12:04:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A312364DAE;
        Mon,  8 Feb 2021 17:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612803847;
        bh=uJ4o7DB4Nqz2fPFzVRVCf+tAxzI7N2QM23dygB5ruRk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uHAEtFN6suPTWTuuTfY02+KDBgc9hsHmH2/xJlY6E+scYkGbXs/8C0oRuSpTrc63q
         tznLhULNoJ+8iH1Ay/abKFMGVNd7dHNs8RT59Si9fovA0ndUDWIwt3IXeUUrQK8KJM
         ndOlQZ7KwHUGqsrRuOEoeuQPFNO6m7Q2NOsycSr0K3G4a1+FeucztTg8LFTlB8fKxQ
         mf6v7Shltrw6TEwkdvJOI2j3v08z5F0GxQjnc0nFgfpEQmzR5ot/yTIKD8whi1Gpoo
         L8xN/zRNqLKNgnjCkqwrlWuYJYVb4tQvePZ9BEdhoVzqa4Ef6ieDOgz9tJV0dyxOyJ
         caGgPfztqbszA==
Date:   Mon, 8 Feb 2021 09:04:05 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     menglong8.dong@gmail.com
Cc:     axboe@kernel.dk, andy.shevchenko@gmail.com, davem@davemloft.net,
        viro@zeniv.linux.org.uk, dong.menglong@zte.com.cn,
        herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next] net: socket: use BIT() for MSG_*
Message-ID: <20210208090405.2b9f68e6@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20210207031816.1864-1-dong.menglong@zte.com.cn>
References: <20210207031816.1864-1-dong.menglong@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  6 Feb 2021 19:18:16 -0800 menglong8.dong@gmail.com wrote:
> From: Menglong Dong <dong.menglong@zte.com.cn>
> 
> The bit mask for MSG_* seems a little confused here. Replace it
> with BIT() to make it clear to understand.
> 
> Changes since v1:
> - use BIT() instead of BIT_MASK()
> 
> Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>

You need to CC netdev.
